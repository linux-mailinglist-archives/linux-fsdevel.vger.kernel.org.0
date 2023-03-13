Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B656B7416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMKcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCMKcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:32:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B22EC178;
        Mon, 13 Mar 2023 03:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07B8BB80F99;
        Mon, 13 Mar 2023 10:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B084C433EF;
        Mon, 13 Mar 2023 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678703531;
        bh=chNdwuAemYgMq4XKL76d7BGQaxzzJr1o0V7KFh3PATM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJXAUXuypSk/Ys5+qKwq5QjXXqo1LDIpNyK39xsKuc9lM+OuX3rMYzQVK05PHwDW0
         DAckh5m59xLCl2L2HOrZP+RE/xLznlYJusK9MdhUGJj6+G81676F1J+zlphk8/Io9D
         oXvKAvx1SxyOM1CpKhZBqJbXXa5uDYdZ06iA1P8Y=
Date:   Mon, 13 Mar 2023 11:32:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Cc:     security@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Patch for a overwriting/corruption of the file system
Message-ID: <ZA77qAuaTVCEwqHc@kroah.com>
References: <CADZg-m0Z+dOGfG=ddJxqPvgFwG0+OLAyP157SNzj6R6J2p7L-g@mail.gmail.com>
 <ZA734rBwf4ib2u9n@kroah.com>
 <CADZg-m04XELrO-v-uYZ4PyYHXVPX35dgWbCHBpZvwepS4XV9Ew@mail.gmail.com>
 <CADZg-m2k_L8-byX0WKYw5Cj1JPPhxk3HCBexpqPtZvcLRNY8Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADZg-m2k_L8-byX0WKYw5Cj1JPPhxk3HCBexpqPtZvcLRNY8Ug@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:54:55PM +0530, Kirtikumar Anandrao Ramchandani wrote:
> Seems like again it got rejected. I am sending it in the body if it works:
> 
> >From 839cae91705e044b49397590f2d85a5dd289f0c5 Mon Sep 17 00:00:00 2001
> From: KirtiRamchandani <kirtar15502@gmail.com>
> Date: Mon, 13 Mar 2023 15:05:08 +0530
> Subject: [PATCH] Fix bug in affs_rename() function. The `affs_rename()`
>  function in the AFFS filesystem has a bug that can cause the `retval`
>  variable to be overwritten before it is used. Specifically, the function
>  assigns `retval` a value in two separate code blocks, but then only checks
>  its value in one of those blocks. This commit fixes the bug by ensuring
> that
>  `retval` is properly checked in both code blocks.
> 
> Signed-off-by: KirtiRamchandani <kirtar15502@gmail.com>
> ---
>  namei.c | 4++++--
>  1 file changed, 4 insertions(+), 2 deletion(-)
> 
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index d1084e5..a54c700 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -488,7 +488,8 @@ affs_xrename(struct inode *old_dir, struct dentry
> *old_dentry,
>         affs_lock_dir(new_dir);
>         retval = affs_insert_hash(new_dir, bh_old);
>         affs_unlock_dir(new_dir);
> -
> +       if (retval)
> +               goto done;

The patch is corrupted and can not be applied.

Here's the response from my patch bot.  Please read over the
documentation and try to submit it properly like any other normal
change.

------------


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
