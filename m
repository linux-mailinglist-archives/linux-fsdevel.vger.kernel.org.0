Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B094AB0CC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbiBFRD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 12:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiBFRD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:03:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF69C06173B;
        Sun,  6 Feb 2022 09:03:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2484D611BE;
        Sun,  6 Feb 2022 17:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACE4C340E9;
        Sun,  6 Feb 2022 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644167007;
        bh=CxNZhf0Rj0X+y+VCbMTPfy1hriBWerZmKT41tTRAYzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDoAKbPGicUgOwtqu8mIQK6uUNLfBO9/kmCWiamx3/iJ1TyJmOZRiTgR9u9ausvhA
         AI5midU3xIJ9Iuvrv+STI+6/9rYA2X2w6QKMHaU2E5LgGK+5cv+f6Kr4yQfVx1GS4v
         E889lgGqdYzvQBDKQ/rOfdjTJmnzBPCjaHjfCcd4=
Date:   Sun, 6 Feb 2022 18:03:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yu <xuyu@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dhowells@redhat.com
Subject: Re: [PATCH] chardev: call tty_init() in real chrdev_init()
Message-ID: <Yf//U1s3DbTuSqo2@kroah.com>
References: <4e753e51d0516413fbf557cf861d654ca73486cc.1644164597.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e753e51d0516413fbf557cf861d654ca73486cc.1644164597.git.xuyu@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 07, 2022 at 12:27:31AM +0800, Xu Yu wrote:
> It is confusing that tty_init() in called in the initialization of
> memdev, i.e., static chr_dev_init().
> 
> Through blame, it is introduced by commit 31d1d48e199e ("Fix init
> ordering of /dev/console vs callers of modprobe"), which fixes the
> initialization order of /dev/console driver. However, there seems
> to be a typo in the patch, i.e., chrdev_init, instead of chr_dev_init.
> 
> This fixes the typo, IIUC.
> 
> Note that the return value of tty_init() is always 0, and thus no error
> handling is provided in chrdev_init().
> 
> Fixes: 31d1d48e199e ("Fix init ordering of /dev/console vs callers of modprobe")
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> ---
>  drivers/char/mem.c | 2 +-
>  fs/char_dev.c      | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index cc296f0823bd..8c90881f8115 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -775,7 +775,7 @@ static int __init chr_dev_init(void)
>  			      NULL, devlist[minor].name);
>  	}
>  
> -	return tty_init();
> +	return 0;
>  }
>  
>  fs_initcall(chr_dev_init);
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index ba0ded7842a7..fc042a0a098f 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -667,6 +667,7 @@ static struct kobject *base_probe(dev_t dev, int *part, void *data)
>  void __init chrdev_init(void)
>  {
>  	cdev_map = kobj_map_init(base_probe, &chrdevs_lock);
> +	tty_init();
>  }
>  

You just changed the ordering sequence here, are you SURE this is
correct?

How was this tested?  Did you verify that the problem that the original
commit here was fixing is now not happening again?

And what real problem is this solving?  How did you hit the issue that
this solves?

And finally, yes, it is not good to throw away the return value of
tty_init().  If it really can not return anything but 0, then let us
make it a void function first.

thanks,

greg k-h
