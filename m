Return-Path: <linux-fsdevel+bounces-36095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F59DBA10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB35B229DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2B1B6D09;
	Thu, 28 Nov 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9Xjfq2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0F19D06A;
	Thu, 28 Nov 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806444; cv=none; b=o8aby05m0BGWgSbJfNt/k1j7fvbG0eZZTdb+yim92phh7P7ZGT6yCC7mstcMIYO9AfjbXNOWTgyORv3NmhuBha7al+5DLi7QcI/hKyaii37wo0CcIpBrqGelAC5zjWPbrLcUFwyybnRk4ti9IFUi3UVbq4pfukMtrYmHqY9ux6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806444; c=relaxed/simple;
	bh=YjAa2GOZ/h9F5y+Xv0qeuvT3dIXuKOC/mjC84JX0cgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd02ZMHWUiwjGi3eyL1oSGfJWXwz/g/mqI1oCJ4XTWAwe0ae8GAoOpjUlr6PQkGXiuJHQ0RGmmTZHhbImHX+pk+7HNGX8rLz07UkaVO/hhO+Kjvo6SCE3uCSMwOx4wR8WZvnba2WLiNkPLNAIVhk8o3VRZDROahVdX3563ri0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9Xjfq2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300ABC4CED3;
	Thu, 28 Nov 2024 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732806443;
	bh=YjAa2GOZ/h9F5y+Xv0qeuvT3dIXuKOC/mjC84JX0cgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9Xjfq2UQOX0+PYoGAuBnXHhKVUFErglu3fiYy5BIgu9kMoMMDywZlpDg9S0rXYWC
	 m6wi3ZmIyDfZXSA/xbDgfaPnTLY+SBvFcUJroqjbvqjGmo4BH1cXml53HFrcCp4Z0N
	 N0I9GXAhJPlv7gis1/HHAmrRtiBhd3cpLRBzzUrY=
Date: Thu, 28 Nov 2024 16:07:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Scott Branden <scott.branden@broadcom.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: Unsafe find_vpid() calls
Message-ID: <2024112853-conjure-posh-bf7a@gregkh>
References: <ueprb5sfjisjucekft3ls7it3pacq44ryfyqtumb3be3itmzy4@mnp4e2lcbzus>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ueprb5sfjisjucekft3ls7it3pacq44ryfyqtumb3be3itmzy4@mnp4e2lcbzus>

On Thu, Nov 28, 2024 at 03:58:06PM +0100, Christian Brauner wrote:
> Hey,
> 
> You have various calls to find_vpid() in your drivers that aren't
> protected by either tasklist_lock or rcu_read_lock(). Afair, this is
> unsafe as the struct pid might be freed beneath you. You should please
> fix those places to be protected by rcu_read_lock(). Something like the
> below or similar should work.
> 
> Thanks!
> Christian
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index d4a96137728d..84cab909db71 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -522,7 +522,9 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
>                                 dev_dbg(&vk->pdev->dev,
>                                         "Send kill signal to pid %d\n",
>                                         ctx->pid);
> +                               rcu_read_lock();
>                                 kill_pid(find_vpid(ctx->pid), SIGKILL, 1);
> +                               rcu_read_unlock();
>                         }
>                 }
>         }
> diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
> index 59bab76ff0a9..6bd93347938e 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_tty.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
> @@ -326,8 +326,11 @@ void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk)
> 
>         for (i = 0; i < BCM_VK_NUM_TTY; ++i) {
>                 vktty = &vk->tty[i];
> -               if (vktty->pid)
> +               if (vktty->pid) {
> +                       rcu_read_lock();
>                         kill_pid(find_vpid(vktty->pid), SIGKILL, 1);
> +                       rcu_read_unlock();
> +               }
>         }
>  }
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
> index bb7db96ed821..de13f4eab60f 100644
> --- a/drivers/staging/rtl8712/rtl8712_cmd.c
> +++ b/drivers/staging/rtl8712/rtl8712_cmd.c
> @@ -61,7 +61,9 @@ static void check_hw_pbc(struct _adapter *padapter)
>                  */
>                 if (padapter->pid == 0)
>                         return;
> +               rcu_read_lock();
>                 kill_pid(find_vpid(padapter->pid), SIGUSR1, 1);
> +               rcu_read_unlock();
>         }
>  }

Odds are all of these usages can just be removed entirely, I'll add it
to the "todo" list of mine...

thanks!

greg k-h

