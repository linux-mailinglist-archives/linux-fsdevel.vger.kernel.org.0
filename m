Return-Path: <linux-fsdevel+bounces-53954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048EAAF90C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD6E4E48FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4732BF012;
	Fri,  4 Jul 2025 10:39:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2520C00B;
	Fri,  4 Jul 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625589; cv=none; b=FbLw0j1PAqne2wzVyKxT1Mquuo7J2oXhrG6U9BnWkfuelGRZUGYWEW0Fc9F9sBc63sWNj5vBu3+If/a1c2HfBe9qzZWXg1vyQ79iOh8wSgssLa9jRk9KNa3+kdal8n5BieKl+bdK+1ct9JSgpbF4/SYtfbdHmQWrsa/tkqeEQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625589; c=relaxed/simple;
	bh=LBz82hO1YdtOP7p2XifOwPmwI+x1TPOYXV3bv5losxw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu2WVlH5sF2KtCP0G5hzbp8GfcOLG0azLZdjAMO7QpFutyIH6nC+KUlZ8uu5KMuIE9ooA3wxgjk+NStMCa2FD+rihQKCOp5pK83jmzVNpboidoOqrLwlbY6YM06krhfhQlDmFJ7wz3BD0zHxmxTzHsXTMXpEYtOspnqS+pXKsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYVRq4810z6L53m;
	Fri,  4 Jul 2025 18:36:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 39FE3140427;
	Fri,  4 Jul 2025 18:39:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 12:39:37 +0200
Date: Fri, 4 Jul 2025 11:39:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi
	<miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, John Groves
	<jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Matthew
 Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Darrick J
 . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Jeff
 Layton" <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, "Stefan
 Hajnoczi" <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 02/18] dev_dax_iomap: Add fs_dax_get() func to prepare
 dax for fs-dax usage
Message-ID: <20250704113935.000028cf@huawei.com>
In-Reply-To: <20250703185032.46568-3-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
	<20250703185032.46568-3-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Jul 2025 13:50:16 -0500
John Groves <John@Groves.net> wrote:

> This function should be called by fs-dax file systems after opening the
> devdax device. This adds holder_operations, which effects exclusivity
> between callers of fs_dax_get().
> 
> This function serves the same role as fs_dax_get_by_bdev(), which dax
> file systems call after opening the pmem block device.
> 
> This also adds the CONFIG_DEV_DAX_IOMAP Kconfig parameter
> 
> Signed-off-by: John Groves <john@groves.net>
Trivial stuff inline.


> ---
>  drivers/dax/Kconfig |  6 ++++++
>  drivers/dax/super.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/dax.h |  5 +++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index d656e4c0eb84..ad19fa966b8b 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -78,4 +78,10 @@ config DEV_DAX_KMEM
>  
>  	  Say N if unsure.
>  
> +config DEV_DAX_IOMAP
> +       depends on DEV_DAX && DAX
> +       def_bool y
> +       help
> +         Support iomap mapping of devdax devices (for FS-DAX file
> +         systems that reside on character /dev/dax devices)
>  endif
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e16d1d40d773..48bab9b5f341 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -122,6 +122,36 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  EXPORT_SYMBOL_GPL(fs_put_dax);
>  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
>  
> +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> +/**
> + * fs_dax_get()

Trivial but from what I recall kernel-doc isn't going to like this.
Needs a short description.

> + *
> + * fs-dax file systems call this function to prepare to use a devdax device for
> + * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
> + * dev_dax (and there  * is no bdev). The holder makes this exclusive.

there is no *bdev?  So * in wrong place.

> + *
> + * @dax_dev: dev to be prepared for fs-dax usage
> + * @holder: filesystem or mapped device inside the dax_device
> + * @hops: operations for the inner holder
> + *
> + * Returns: 0 on success, <0 on failure
> + */
> +int fs_dax_get(struct dax_device *dax_dev, void *holder,
> +	const struct dax_holder_operations *hops)
> +{
> +	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> +		return -ENODEV;
> +
> +	if (cmpxchg(&dax_dev->holder_data, NULL, holder))
> +		return -EBUSY;
> +
> +	dax_dev->holder_ops = hops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_get);
> +#endif /* DEV_DAX_IOMAP */
> +
>  enum dax_device_flags {
>  	/* !alive + rcu grace period == no new operations / mappings */
>  	DAXDEV_ALIVE,
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index df41a0017b31..86bf5922f1b0 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -51,6 +51,11 @@ struct dax_holder_operations {
>  
>  #if IS_ENABLED(CONFIG_DAX)
>  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
> +
> +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> +int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
> +struct dax_device *inode_dax(struct inode *inode);
> +#endif
>  void *dax_holder(struct dax_device *dax_dev);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);


