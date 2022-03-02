Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A54C9F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiCBI1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 03:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiCBI1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:27:46 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49CF9B82D7;
        Wed,  2 Mar 2022 00:27:03 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D9C7810E7AA7;
        Wed,  2 Mar 2022 19:26:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nPKK2-000Yvk-TL; Wed, 02 Mar 2022 19:26:58 +1100
Date:   Wed, 2 Mar 2022 19:26:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Generic per-sb io stats
Message-ID: <20220302082658.GF3927073@dread.disaster.area>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=621f2a55
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=hrpbfNtiAHGPJjzkeMIA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:43:50AM +0200, Amir Goldstein wrote:
> On Wed, Mar 2, 2022 at 8:59 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Mar 01, 2022 at 08:42:15PM +0200, Amir Goldstein wrote:
> > > Miklos,
> > >
> > > Following your feedback on v2 [1], I moved the iostats to per-sb.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > [1] https://lore.kernel.org/linux-unionfs/20220228113910.1727819-1-amir73il@gmail.com/
> > >
> > > Changes since v2:
> > > - Change from per-mount to per-sb io stats (szeredi)
> > > - Avoid percpu loop when reading mountstats (dchinner)
> > >
> > > Changes since v1:
> > > - Opt-in for per-mount io stats for overlayfs and fuse
> >
> > Why make it optional only for specific filesystem types? Shouldn't
> > every superblock capture these stats and export them in exactly the
> > same place?
> >
> 
> I am not sure what you are asking.
> 
> Any filesystem can opt-in to get those generic io stats.

Yes, but why even make it opt-in? Why not just set these up
unconditionally in alloc_super() for all filesystems? Either this is
useful information for userspace montioring and diagnostics, or it's
not useful at all. If it is useful, then all superblocks should
export this stuff rather than just some special subset of
filesystems where individual maintainers have noticed it and thought
"that might be useful".

Just enable it for every superblock....

> This is exactly the same as any filesystem can already opt-in for
> fs specific io stats using the s_op->show_stats() vfs op.
> 
> All I did was to provide a generic implementation.
> The generic io stats are collected and displayed for all filesystems the
> same way.
> 
> I only included patches for overlayfs and fuse to opt-in for generic io stats,
> because I think those stats should be reported unconditionally (to
> mount options)
> for fuse/overlayfs and I hope that Miklos agrees with me.

Yup, and I'm asking you why it should be optional - no filesystem
ever sees this information - it's totally generic VFS level code
except for the structure allocation. What's the point of *not*
enabling it for every superblock unconditionally?

> If there is wide consensus that all filesystems should have those stats
> unconditionally (to mount options), then I can post another patch to make
> the behavior not opt-in, but I have a feeling that this discussion

That's exactly what I want you to do. We're already having this
discussion, so let's get it over and done with right now.

> How would you prefer the io stats behavior for xfs (or any fs) to be?
> Unconditional to mount options?
> Opt-in with mount option? (suggest name please)
> Opt-in/out with mount options and default with Kconfig/sysfs tunable?
> Anything else?

Unconditional, for all filesystems, so they all display the same
stats in exactly same place without any filesystem having to
implement a single line of code anywhere. A single kconfig option
like you already hav is just fine to turn it off for those that
don't want to use it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
