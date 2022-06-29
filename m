Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C255F2E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiF2Bn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 21:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiF2Bn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:43:27 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4843C14086
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 18:43:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EDA4610E8DDD;
        Wed, 29 Jun 2022 11:43:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o6Mjj-00CIAx-Pz; Wed, 29 Jun 2022 11:43:23 +1000
Date:   Wed, 29 Jun 2022 11:43:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     James Yonan <james@openvpn.net>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Message-ID: <20220629014323.GM1098723@dread.disaster.area>
References: <20220627221107.176495-1-james@openvpn.net>
 <Yrs7lh6hG44ERoiM@ZenIV>
 <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>
 <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62bbae3d
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=drOt6m5kAAAA:8 a=7-415B0cAAAA:8
        a=LAvlIBjgyWtn99JKrSsA:9 a=CjuIK1q_8ugA:10 a=RMMjzBEyIzXRtoq5n5K6:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 05:19:12PM -0600, James Yonan wrote:
> On 6/28/22 12:34, Amir Goldstein wrote:
> > On Tue, Jun 28, 2022 at 8:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:
> > > 
> > > >            && d_is_positive(new_dentry)
> > > >            && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
> > > >                                  &d_backing_inode(new_dentry)->i_mtime) <= 0)
> > > >                goto exit5;
> > > > 
> > > > It's pretty cool in a way that a new atomic file operation can even be
> > > > implemented in just 5 lines of code, and it's thanks to the existing
> > > > locking infrastructure around file rename/move that these operations
> > > > become almost trivial.  Unfortunately, every fs must approve a new
> > > > renameat2() flag, so it bloats the patch a bit.
> > > How is it atomic and what's to stabilize ->i_mtime in that test?
> > > Confused...
> > Good point.
> > RENAME_EXCHANGE_WITH_NEWER would have been better
> > in that regard.
> > 
> > And you'd have to check in vfs_rename() after lock_two_nondirectories()
> 
> So I mean atomic in the sense that you are comparing the old and new mtimes
> inside the lock_rename/unlock_rename critical section in do_renameat2(), so

mtime is not stable during rename, even with the inode locked. e.g. a
write page fault occurring concurrently with rename will change
mtime, and so which inode is "newer" can change during the rename
syscall...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
