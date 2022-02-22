Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054534C046D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 23:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiBVWQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 17:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:16:44 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 008A7C3351;
        Tue, 22 Feb 2022 14:16:17 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0586C10E1034;
        Wed, 23 Feb 2022 09:16:15 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMdSA-00FEJg-J2; Wed, 23 Feb 2022 09:16:14 +1100
Date:   Wed, 23 Feb 2022 09:16:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220222221614.GC3061737@dread.disaster.area>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=621560b0
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=_MjYSGqaCGpKE7YW:21 a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=EH5YdbLGPw6z9d0QqZoA:9 a=CjuIK1q_8ugA:10 a=aebnku51ZD03SSuSuSm5:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:04:08AM +0100, Jan Kara wrote:
> Hello!
> 
> On Sun 20-02-22 12:13:04, Matthew Wilcox wrote:
> > Keeping reiserfs in the tree has certain costs.  For example, I would
> > very much like to remove the 'flags' argument to ->write_begin.  We have
> > the infrastructure in place to handle AOP_FLAG_NOFS differently, but
> > AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.
> > 
> > Looking over the patches to reiserfs over the past couple of years, there
> > are fixes for a few syzbot reports and treewide changes.  There don't
> > seem to be any fixes for user-spotted bugs since 2019.  Does reiserfs
> > still have a large install base that is just very happy with an old
> > stable filesystem?  Or have all its users migrated to new and exciting
> > filesystems with active feature development?
> > 
> > We've removed support for senescent filesystems before (ext, xiafs), so
> > it's not unprecedented.  But while I have a clear idea of the benefits to
> > other developers of removing reiserfs, I don't have enough information to
> > weigh the costs to users.  Maybe they're happy with having 5.15 support
> > for their reiserfs filesystems and can migrate to another filesystem
> > before they upgrade their kernel after 5.15.
> > 
> > Another possibility beyond outright removal would be to trim the kernel
> > code down to read-only support for reiserfs.  Most of the quirks of
> > reiserfs have to do with write support, so this could be a useful way
> > forward.  Again, I don't have a clear picture of how people actually
> > use reiserfs, so I don't know whether it is useful or not.
> > 
> > NB: Please don't discuss the personalities involved.  This is purely a
> > "we have old code using old APIs" discussion.
> 
> So from my distro experience installed userbase of reiserfs is pretty small
> and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
> for enterprise offerings it is unsupported (for like 3-4 years) and the module
> is not in the default kernel rpm anymore.
> 
> So clearly the filesystem is on the deprecation path, the question is
> whether it is far enough to remove it from the kernel completely. Maybe
> time to start deprecation by printing warnings when reiserfs gets mounted
> and then if nobody yells for year or two, we'll go ahead and remove it?

Yup, I'd say we should deprecate it and add it to the removal
schedule. The less poorly tested legacy filesystem code we have to
maintain the better.

Along those lines, I think we really need to be more aggressive
about deprecating and removing filesystems that cannot (or will not)
be made y2038k compliant in the new future. We're getting to close
to the point where long term distro and/or product development life
cycles will overlap with y2038k, so we should be thinking of
deprecating and removing such filesystems before they end up in
products that will still be in use in 15 years time.

And just so everyone in the discussion is aware: XFS already has a
deprecation and removal schedule for the non-y2038k-compliant v4
filesystem format. It's officially deprecated right now, we'll stop
building kernels with v4 support enabled by default in 2025, and
we're removing the code that supports the v4 format entirely in
2030.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
