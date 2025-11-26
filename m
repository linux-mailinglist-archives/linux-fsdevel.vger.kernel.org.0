Return-Path: <linux-fsdevel+bounces-69872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB4C894B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA7AD4E448F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832002E54CC;
	Wed, 26 Nov 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWTGKj7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51702874F6;
	Wed, 26 Nov 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152875; cv=none; b=t6MNvFctouFzdwaqtk4KEKbjSRQJjPjR9lfhx7YyKeOSfodb80oHy0lhNDTXwwwywXgLPYZtBnxgrKVItIQhHF4hqtVAloJxjIYWe0BRYZY1druW5YD5G62jX8bna1oMCQRIpNfaHara1mQK84jgmUChsOVqX5K4a/YQWIf+jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152875; c=relaxed/simple;
	bh=fAodh1jPjSufqfyuyd/1uFzjyHxPRONE3arzIkaRgL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lslOZjkCdlTMsVxJPG+pTBt5H1HqMjIpY/lKyV3wdcLIBZBv4KMzqqMYV/kSgr7o3XpHIQIz9zw405An/E3lb/ZYiTWocGzyrloVkcHQnJsIoeGhLBpruwipdw/tHEArs1FljlULGBR4BRnOML1C+qtGqSPjJEFxePEFOEoI03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWTGKj7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDE1C113D0;
	Wed, 26 Nov 2025 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764152875;
	bh=fAodh1jPjSufqfyuyd/1uFzjyHxPRONE3arzIkaRgL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWTGKj7SgUrHZeGyVtM/SdBDZZAtUyC+AgAIjlH0si58QdmDzvi5NCaTnCugGdb7U
	 18oBHAWr6mJxxPT+3Pv5yGvIpoYwibBMFnw/biE4ojNh2rsXWgNTbf6N3EkXC/a+b6
	 w4udhqrWXuKPniUdVD58u99xeF+22TY0ybzfktNzwzjCzN15qCDiSD5VIszoIolkpu
	 NFj+p3sbk7JFY8BBW0d4SMDSoBY7XADDRb6XuDp0i1dFjbV/DLf2ZlvrStnJRigBDR
	 NLfyd5EjWZULgnD30czsaZ2CwbIJ9j3Ssc1K3IPuAr+icEehPu1NhoCakZur5JBjIS
	 1ye1MHOSeJ1KQ==
Date: Wed, 26 Nov 2025 11:27:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Wenkai Lin <linwenkai6@hisilicon.com>, 
	Chenghai Huang <huangchenghai2@huawei.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chardev: fix consistent error handling in cdev_device_add
Message-ID: <20251126-untragbar-hanfanbau-164f0425c5e5@brauner>
References: <20251119101540.106441-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119101540.106441-1-zhangfei.gao@linaro.org>

On Wed, Nov 19, 2025 at 10:15:40AM +0000, Zhangfei Gao wrote:
> Currently cdev_device_add has inconsistent error handling:
> 
> - If device_add fails, it calls cdev_del(cdev)
> - If cdev_add fails, it only returns error without cleanup
> 
> This creates a problem because cdev_set_parent(cdev, &dev->kobj)
> establishes a parent-child relationship.
> When callers use cdev_del(cdev) to clean up after cdev_add failure,
> it also decrements the dev's refcount due to the parent relationship,
> causing refcount mismatch.
> 
> To unify error handling:
> - Set cdev->kobj.parent = NULL first to break the parent relationship
> - Then call cdev_del(cdev) for cleanup
> 
> This ensures that in both error paths,
> the dev's refcount remains consistent and callers don't need
> special handling for different failure scenarios.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  fs/char_dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c9..fef6ee1aba66 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>  		cdev_set_parent(cdev, &dev->kobj);
>  
>  		rc = cdev_add(cdev, dev->devt, 1);
> -		if (rc)
> +		if (rc) {
> +			cdev->kobj.parent = NULL;
> +			cdev_del(cdev);
>  			return rc;
> +		}

There are callers that call cdev_del() on failure of cdev_add():

        retval = cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
        if (retval != 0) {
                pr_err("dvb-core: unable register character device\n");
                goto error;
        }

<snip>

error:
        cdev_del(&dvb_device_cdev);
        unregister_chrdev_region(dev, MAX_DVB_MINORS);
        return retval;

and there are callers that don't. If you change the scheme here then all
of these callers need to be adjusted as well - including the one that
does a kobject_put() directly...

