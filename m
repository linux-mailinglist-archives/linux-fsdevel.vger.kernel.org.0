Return-Path: <linux-fsdevel+bounces-53964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE3AF93EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EA517417D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14F3093D3;
	Fri,  4 Jul 2025 13:20:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8F302CB0;
	Fri,  4 Jul 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635245; cv=none; b=IPmK2dYkYPUFVKRKNWGSeIVk6/POjRf7i/IR7JGFLmIly4o2YZOSUDVG+fwKBCpVQs64D31Vfj9U2r20GE5Dg4LiFuB2Vx55kYieHX+95LByl2vi88j7SDyv6IcxkDotdK9hokIdkVSizb41U9u6lQ7HnA5vJeQ9W7aU5REEuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635245; c=relaxed/simple;
	bh=r/zZfk+rBckUaqy0G8l9RA51eIYy10yBBUZBXpfCWZ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlNbpACYsI5c6NRqkOzcQ3D8hWqOaSgt7yEhgxzmdLupEhqgatm7dTuYQxog1I1Ay4kBdd9y801i4FACrVpoCy6fyUS8olwWC23wEeHtlzx4dv27yH5t/EG6T8khEqEDz4Ou9RHUYbs/oqGLv7sWxkiOCeadZBYNPrXNlVpcjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYZ3x2mjWz6M4jr;
	Fri,  4 Jul 2025 21:19:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03F1E1402A5;
	Fri,  4 Jul 2025 21:20:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 15:20:38 +0200
Date: Fri, 4 Jul 2025 14:20:37 +0100
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
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <20250704142037.00002717@huawei.com>
In-Reply-To: <20250703185032.46568-15-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
	<20250703185032.46568-15-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Jul 2025 13:50:28 -0500
John Groves <John@Groves.net> wrote:

> * The new GET_DAXDEV message/response is enabled
> * The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_dable yet.
> 
> Signed-off-by: John Groves <john@groves.net>

More drive by stuff you can ignore for now if you like.

> ---
>  fs/fuse/famfs.c           | 227 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/famfs_kfmap.h     |  26 +++++
>  fs/fuse/fuse_i.h          |   1 +
>  fs/fuse/inode.c           |   4 +-
>  fs/namei.c                |   1 +
>  include/uapi/linux/fuse.h |  18 +++
>  6 files changed, 276 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index 41c4d92f1451..f5e01032b825 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c

> +/**
> + * famfs_fuse_get_daxdev() - Retrieve info for a DAX device from fuse server
> + *
> + * Send a GET_DAXDEV message to the fuse server to retrieve info on a
> + * dax device.
> + *
> + * @fm:     fuse_mount
> + * @index:  the index of the dax device; daxdevs are referred to by index
> + *          in fmaps, and the server resolves the index to a particular daxdev
> + *
> + * Returns: 0=success
> + *          -errno=failure
> + */
> +static int
> +famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
> +{
> +	struct fuse_daxdev_out daxdev_out = { 0 };
> +	struct fuse_conn *fc = fm->fc;
> +	struct famfs_daxdev *daxdev;
> +	int err = 0;
> +
> +	FUSE_ARGS(args);
> +
> +	/* Store the daxdev in our table */
> +	if (index >= fc->dax_devlist->nslots) {
> +		pr_err("%s: index(%lld) > nslots(%d)\n",
> +		       __func__, index, fc->dax_devlist->nslots);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	args.opcode = FUSE_GET_DAXDEV;
> +	args.nodeid = index;
> +
> +	args.in_numargs = 0;
> +
> +	args.out_numargs = 1;
> +	args.out_args[0].size = sizeof(daxdev_out);
> +	args.out_args[0].value = &daxdev_out;
> +
> +	/* Send GET_DAXDEV command */
> +	err = fuse_simple_request(fm, &args);
> +	if (err) {
> +		pr_err("%s: err=%d from fuse_simple_request()\n",
> +		       __func__, err);
> +		/*
> +		 * Error will be that the payload is smaller than FMAP_BUFSIZE,
> +		 * which is the max we can handle. Empty payload handled below.
> +		 */
> +		goto out;
> +	}
> +
> +	down_write(&fc->famfs_devlist_sem);

Worth thinking about guard() in this code in general.
Simplify some of the error paths at least.

> +
> +	daxdev = &fc->dax_devlist->devlist[index];
> +
> +	/* Abort if daxdev is now valid */
> +	if (daxdev->valid) {
> +		up_write(&fc->famfs_devlist_sem);
> +		/* We already have a valid entry at this index */
> +		err = -EALREADY;
> +		goto out;
> +	}
> +
> +	/* Verify that the dev is valid and can be opened and gets the devno */
> +	err = famfs_verify_daxdev(daxdev_out.name, &daxdev->devno);
> +	if (err) {
> +		up_write(&fc->famfs_devlist_sem);
> +		pr_err("%s: err=%d from famfs_verify_daxdev()\n", __func__, err);
> +		goto out;
> +	}
> +
> +	/* This will fail if it's not a dax device */
> +	daxdev->devp = dax_dev_get(daxdev->devno);
> +	if (!daxdev->devp) {
> +		up_write(&fc->famfs_devlist_sem);
> +		pr_warn("%s: device %s not found or not dax\n",
> +			__func__, daxdev_out.name);
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
> +	wmb(); /* all daxdev fields must be visible before marking it valid */
> +	daxdev->valid = 1;
> +
> +	up_write(&fc->famfs_devlist_sem);
> +
> +out:
> +	return err;
> +}
> +
> +/**
> + * famfs_update_daxdev_table() - Update the daxdev table
> + * @fm   - fuse_mount
> + * @meta - famfs_file_meta, in-memory format, built from a GET_FMAP response
> + *
> + * This function is called for each new file fmap, to verify whether all
> + * referenced daxdevs are already known (i.e. in the table). Any daxdev
> + * indices that referenced in @meta but not in the table will be retrieved via
> + * famfs_fuse_get_daxdev() and added to the table
> + *
> + * Return: 0=success
> + *         -errno=failure
> + */
> +static int
> +famfs_update_daxdev_table(
> +	struct fuse_mount *fm,
> +	const struct famfs_file_meta *meta)
> +{
> +	struct famfs_dax_devlist *local_devlist;
> +	struct fuse_conn *fc = fm->fc;
> +	int err;
> +	int i;
> +
> +	/* First time through we will need to allocate the dax_devlist */
> +	if (!fc->dax_devlist) {
> +		local_devlist = kcalloc(1, sizeof(*fc->dax_devlist), GFP_KERNEL);
> +		if (!local_devlist)
> +			return -ENOMEM;
> +
> +		local_devlist->nslots = MAX_DAXDEVS;
> +
> +		local_devlist->devlist = kcalloc(MAX_DAXDEVS,
> +						 sizeof(struct famfs_daxdev),
> +						 GFP_KERNEL);
> +		if (!local_devlist->devlist) {
> +			kfree(local_devlist);
> +			return -ENOMEM;
> +		}
> +
> +		/* We don't need the famfs_devlist_sem here because we use cmpxchg... */
> +		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
> +			kfree(local_devlist->devlist);
> +			kfree(local_devlist); /* another thread beat us to it */
> +		}
> +	}
> +
> +	down_read(&fc->famfs_devlist_sem);
> +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> +		if (meta->dev_bitmap & (1ULL << i)) {
Flip for readability.
		if (!(meta->dev_bitmap & (1ULL << i))
			continue;

Or can we use bitmap_from_arr64() and
for_each_set_bit() to optimize this a little.

> +			/* This file meta struct references devindex i
> +			 * if devindex i isn't in the table; get it...
> +			 */
> +			if (!(fc->dax_devlist->devlist[i].valid)) {
> +				up_read(&fc->famfs_devlist_sem);
> +
> +				err = famfs_fuse_get_daxdev(fm, i);
> +				if (err)
> +					pr_err("%s: failed to get daxdev=%d\n",
> +					       __func__, i);
Don't want to surface that error?
> +
> +				down_read(&fc->famfs_devlist_sem);
> +			}
> +		}
> +	}
> +	up_read(&fc->famfs_devlist_sem);
> +
> +	return 0;
> +}
> +
> +/***************************************************************************/

?

> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> index ce785d76719c..f79707b9f761 100644
> --- a/fs/fuse/famfs_kfmap.h
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -60,4 +60,30 @@ struct famfs_file_meta {
>  	};
>  };
>  
> +/**
> + * famfs_daxdev - tracking struct for a daxdev within a famfs file system
> + *
> + * This is the in-memory daxdev metadata that is populated by
> + * the responses to GET_FMAP messages
> + */
> +struct famfs_daxdev {
> +	/* Include dev uuid? */
> +	bool valid;
> +	bool error;
> +	dev_t devno;
> +	struct dax_device *devp;
> +	char *name;
> +};
> +
> +#define MAX_DAXDEVS 24
> +
> +/**
> + * famfs_dax_devlist - list of famfs_daxdev's

Run kernel-doc script over these. It gets grumpy about partial
documentation.

> + */
> +struct famfs_dax_devlist {
> +	int nslots;
> +	int ndevs;
> +	struct famfs_daxdev *devlist; /* XXX: make this an xarray! */
> +};
> +
>  #endif /* FAMFS_KFMAP_H */

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index ecaaa62910f0..8a81b6c334fe 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -235,6 +235,9 @@
>   *      - struct fuse_famfs_simple_ext
>   *      - struct fuse_famfs_iext
>   *      - struct fuse_famfs_fmap_header
> + *    - Add the following structs for the GET_DAXDEV message and reply
> + *      - struct fuse_get_daxdev_in
> + *      - struct fuse_get_daxdev_out
>   *    - Add the following enumerated types
>   *      - enum fuse_famfs_file_type
>   *      - enum famfs_ext_type
> @@ -1351,6 +1354,20 @@ struct fuse_famfs_fmap_header {
>  	uint64_t reserved1;
>  };
>  
> +struct fuse_get_daxdev_in {
> +	uint32_t        daxdev_num;
> +};
> +
> +#define DAXDEV_NAME_MAX 256
> +struct fuse_daxdev_out {
> +	uint16_t index;
> +	uint16_t reserved;
> +	uint32_t reserved2;
> +	uint64_t reserved3; /* enough space for a uuid if we need it */

Odd place for the comment. If it just refers to reserved3 then nope
not enough space.  If you mean that and reserved4 then fiar enough
but that's not obvious as it stands.

> +	uint64_t reserved4;
> +	char name[DAXDEV_NAME_MAX];
> +};
> +
>  static inline int32_t fmap_msg_min_size(void)
>  {
>  	/* Smallest fmap message is a header plus one simple extent */
> @@ -1358,4 +1375,5 @@ static inline int32_t fmap_msg_min_size(void)
>  		+ sizeof(struct fuse_famfs_simple_ext));
>  }
>  
> +
Stray change.  Worth a quick scrub to clean these out (even in an RFC) as they just add
noise to the bits you want people to look at!

>  #endif /* _LINUX_FUSE_H */


