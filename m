Return-Path: <linux-fsdevel+bounces-13013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6886A289
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4891F2900D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532E5578D;
	Tue, 27 Feb 2024 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DpKC7Wy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7C1DFEB;
	Tue, 27 Feb 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073067; cv=none; b=BZX78yuuWPb3lgcbumCdRGZM1n//cDhNaKGvW/1uMGYy+s6J93AGtECwhOV1znzciq3LV4KPlEm7PhmF2OHbvbJ5dzNB/BHrRdJQKn5eqsqKmJtGbd0RwWBAtccYGlz5ijqAB2ThAwe+EDmbV2l5Z8cDz4wuQJXU8MnPreKqhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073067; c=relaxed/simple;
	bh=7VheXxNDxS8MFKLz3E8RjAWOSAjmZcXMl7dt1NYjLro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rneYnQtKkxFQTDoByARbeU/sm/NDoZC0/uxoka5zZew0YL87kg6pDHs6JTALIO3+5qF2EChmIDqdg6ThN8WOiUTolnojRxfIrML1Fl8prYbWJDt2FJVqEfhY38rFDgOcnSxLzpxSJkyjl2yBaCoi/aLzPuQbXNtXlFKNuSNSKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DpKC7Wy7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kwg2IJB+Y/BmUDu9vsrqObv3GKLJgEX/yI6sN3Hoj6Y=; b=DpKC7Wy71ZsYHg1/AW+9BNKzYc
	Mj2yjaXjKl5RUYwHMupqYjtdOrOQOpFpAghXMWdZcROviVILOt829QiW0wp6dJuYDEcynOFusMjE+
	pkXmlRd1vss8/WLrlOR5PfqcNmOWMVK1tA1P90m1vjlC2SiACbxd7f4rl/HWCDz7lWZpm0zjtYmcp
	STGILdgqPaqON21Bj3XZdMaNA5mD4ZaMX44taVYzlbQ9pj2xn+MiqUEMlkZm5ZnqBSXEJ3LCk5JQP
	TWYuZSwWkzad8vzYN8m1TvKuuDIsWEpHQYKrjUNiX3JWbIZ/Z7oR/uWwBdYIodKH8Dgqzl8gxOnNB
	xrfwlFdQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf5ya-0000000750d-0EAs;
	Tue, 27 Feb 2024 22:31:04 +0000
Message-ID: <aa41ac4e-c29d-4025-b1c3-8cdc9830b5f7@infradead.org>
Date: Tue, 27 Feb 2024 14:31:03 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtiofs: drop __exit from virtio_fs_sysfs_exit()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20240227155756.420944-1-stefanha@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240227155756.420944-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/24 07:57, Stefan Hajnoczi wrote:
> virtio_fs_sysfs_exit() is called by:
> - static int __init virtio_fs_init(void)
> - static void __exit virtio_fs_exit(void)
> 
> Remove __exit from virtio_fs_sysfs_exit() since virtio_fs_init() is not
> an __exit function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402270649.GYjNX0yw-lkp@intel.com/
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 62a44603740c..948b49c2460d 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1588,7 +1588,7 @@ static int __init virtio_fs_sysfs_init(void)
>  	return 0;
>  }
>  
> -static void __exit virtio_fs_sysfs_exit(void)
> +static void virtio_fs_sysfs_exit(void)
>  {
>  	kset_unregister(virtio_fs_kset);
>  	virtio_fs_kset = NULL;

-- 
#Randy

