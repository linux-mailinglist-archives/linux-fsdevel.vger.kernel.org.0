Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEDA55F375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiF2CgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF2CgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:36:01 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F03E62A41F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 19:36:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D965D10E8472;
        Wed, 29 Jun 2022 12:35:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o6NYb-00CJ8B-SH; Wed, 29 Jun 2022 12:35:57 +1000
Date:   Wed, 29 Jun 2022 12:35:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     James Yonan <james@openvpn.net>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Message-ID: <20220629023557.GN1098723@dread.disaster.area>
References: <20220627221107.176495-1-james@openvpn.net>
 <Yrs7lh6hG44ERoiM@ZenIV>
 <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>
 <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>
 <20220629014323.GM1098723@dread.disaster.area>
 <165646842481.15378.14054777682756518611@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165646842481.15378.14054777682756518611@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62bbba90
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=drOt6m5kAAAA:8 a=7-415B0cAAAA:8
        a=V9hz_q2Jx7qf1sRSNoMA:9 a=CjuIK1q_8ugA:10 a=RMMjzBEyIzXRtoq5n5K6:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 12:07:04PM +1000, NeilBrown wrote:
> On Wed, 29 Jun 2022, Dave Chinner wrote:
> > On Tue, Jun 28, 2022 at 05:19:12PM -0600, James Yonan wrote:
> > > On 6/28/22 12:34, Amir Goldstein wrote:
> > > > On Tue, Jun 28, 2022 at 8:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > > On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:
> > > > > 
> > > > > >            && d_is_positive(new_dentry)
> > > > > >            && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
> > > > > >                                  &d_backing_inode(new_dentry)->i_mtime) <= 0)
> > > > > >                goto exit5;
> > > > > > 
> > > > > > It's pretty cool in a way that a new atomic file operation can even be
> > > > > > implemented in just 5 lines of code, and it's thanks to the existing
> > > > > > locking infrastructure around file rename/move that these operations
> > > > > > become almost trivial.  Unfortunately, every fs must approve a new
> > > > > > renameat2() flag, so it bloats the patch a bit.
> > > > > How is it atomic and what's to stabilize ->i_mtime in that test?
> > > > > Confused...
> > > > Good point.
> > > > RENAME_EXCHANGE_WITH_NEWER would have been better
> > > > in that regard.
> > > > 
> > > > And you'd have to check in vfs_rename() after lock_two_nondirectories()
> > > 
> > > So I mean atomic in the sense that you are comparing the old and new mtimes
> > > inside the lock_rename/unlock_rename critical section in do_renameat2(), so
> > 
> > mtime is not stable during rename, even with the inode locked. e.g. a
> > write page fault occurring concurrently with rename will change
> > mtime, and so which inode is "newer" can change during the rename
> > syscall...
> 
> I don't think that is really important for the proposed use case.

Sure, but that's not the point. How do you explain it the API
semantics to an app developer that might want to use this
functionality? RENAME_EXCHANGE_WITH_NEWER would be atomic in the
sense you either get the old or new file at the destination, but
it's not atomic in the sense that it is serialised against all other
potential modification operations against either the source or
destination. Hence the "if newer" comparison is not part of the
"atomic rename" operation that is supposedly being performed...

I'm also sceptical of the use of mtime - we can't rely on mtime to
determine the newer file accurately on all filesystems. e.g. Some
fileystems only have second granularity in their timestamps, so
there's a big window where "newer" cannot actually be determined by
timestamp comparisons.

/me is having flashbacks to the bad old days of NFS using inode
timestamps for change ordering and cache consistency....

> In any case where you might be using this new rename flag, the target
> file wouldn't be open for write, so the mtime wouldn't change.
> The atomicity is really wanted to make sure the file at the destination
> name is still the one that was expected (I think).

How would you document this, and how would the application be
expected to handle such a "someone else has this open for write"
error? There's nothing the app can do about the cause of the
failure, so how is it expected to handle such an error?

I'm not opposed to adding functionality like this, I'm just pointing
out problems that I see arising from the insufficiently
constrained/specified behaviour of the proposed functionality.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
