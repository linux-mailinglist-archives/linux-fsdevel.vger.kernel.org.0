Return-Path: <linux-fsdevel+bounces-72862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D49D03B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E94A932380BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4651DFDA1;
	Thu,  8 Jan 2026 14:45:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300B346FA4;
	Thu,  8 Jan 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883512; cv=none; b=tfIGJRA1/nnq5nczrxqfQ9OVJfue//kfgbLJunq1E6LNM9nqtIlLKg9oZcvM3rVer8AA3eLp/gsOynjA5udxHyZkmpyIFxWfRTfdxw4hfrpsFqm4Dt5fml9lBTPxcL721+GuWuhGMioEZR2QFqaUeE8q//vlqMeF0bW0YeULYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883512; c=relaxed/simple;
	bh=F/eTu4pG1cXQKtRdSavDbkGAtm+jieNbVY55YIiuzzg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebgkajd+Vu6x2tWhJTpheWBew9/9XKqK4fGjVtyoOELjBirNCPDa6UHfj0QF3jIB23JV55inC4pA15b6xqVZ2ikRmtnKMyojvfmUhqxtGFnJ8T2sF+R96Kg9iyoQNONWJ6NIT2EAERmhISUkr08hPGQt/pOsCnP8yXmWSXL6dQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn73c3BqlzJ468v;
	Thu,  8 Jan 2026 22:45:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 68A0440570;
	Thu,  8 Jan 2026 22:45:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 14:45:03 +0000
Date: Thu, 8 Jan 2026 14:45:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 16/21] famfs_fuse: GET_DAXDEV message and
 daxdev_table
Message-ID: <20260108144502.000024e0@huawei.com>
In-Reply-To: <20260107153332.64727-17-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-17-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:25 -0600
John Groves <John@Groves.net> wrote:

> * The new GET_DAXDEV message/response is added
> * The famfs.c:famfs_teardown() function is added as a primary teardown
>   function for famfs.
> * The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_table yet.
> * fs/namei.c: export may_open_dev()
> 
> Signed-off-by: John Groves <john@groves.net>
Hi John,

A few things inline

Thanks,

Jonathan

> ---
>  fs/fuse/famfs.c           | 236 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/famfs_kfmap.h     |  26 +++++
>  fs/fuse/fuse_i.h          |  13 ++-
>  fs/fuse/inode.c           |   4 +-
>  fs/namei.c                |   1 +
>  include/uapi/linux/fuse.h |  20 ++++
>  6 files changed, 298 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index 2aabd1d589fd..b5cd1b5c1d6c 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -20,6 +20,239 @@
>  #include "famfs_kfmap.h"
>  #include "fuse_i.h"
>  
> +/*
> + * famfs_teardown()
> + *
> + * Deallocate famfs metadata for a fuse_conn
> + */
> +void
> +famfs_teardown(struct fuse_conn *fc)
> +{
> +	struct famfs_dax_devlist *devlist = fc->dax_devlist;
> +	int i;
> +
> +	kfree(fc->shadow);
> +
> +	fc->dax_devlist = NULL;
> +
> +	if (!devlist)
> +		return;
> +
> +	if (!devlist->devlist)

I'm going to assume that if this is true, devlist->nslots == 0?
If so I'd skip this check and just let the rest of the code happen.

> +		goto out;
> +
> +	/* Close & release all the daxdevs in our table */
> +	for (i = 0; i < devlist->nslots; i++) {
> +		struct famfs_daxdev *dd = &devlist->devlist[i];
> +
> +		if (!dd->valid)
> +			continue;
> +
> +		/* Release reference from dax_dev_get() */
> +		if (dd->devp)
> +			put_dax(dd->devp);
> +
> +		kfree(dd->name);
> +	}
> +	kfree(devlist->devlist);
> +
> +out:
> +	kfree(devlist);
> +}

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
Always set before use so no need to init.

> +
> +	FUSE_ARGS(args);
> +
> +	/* Store the daxdev in our table */
> +	if (index >= fc->dax_devlist->nslots) {
> +		pr_err("%s: index(%lld) > nslots(%d)\n",
> +		       __func__, index, fc->dax_devlist->nslots);
> +		err = -EINVAL;
> +		goto out;

I'd return here as nothing to do.

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

I'm not sure what local comment style is, but be consistent of
whether there is a blank line or not.

> +		 * Error will be that the payload is smaller than FMAP_BUFSIZE,
> +		 * which is the max we can handle. Empty payload handled below.
> +		 */
> +		goto out;
return here is probably simpler.

> +	}
> +
> +	down_write(&fc->famfs_devlist_sem);
> +
> +	daxdev = &fc->dax_devlist->devlist[index];
> +
> +	/* Abort if daxdev is now valid (race - another thread got it first) */
> +	if (daxdev->valid) {
> +		up_write(&fc->famfs_devlist_sem);
> +		/* We already have a valid entry at this index */
> +		pr_debug("%s: daxdev already known\n", __func__);
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

Move the label before the up_write, so you don't need to do it in each
error case or use a guard()

> +		pr_warn("%s: device %s not found or not dax\n",
> +			__func__, daxdev_out.name);
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
Can fail.

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
> + * indices referenced in @meta but not in the table will be retrieved via
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

Might as well put those on one line or move i down to the loop init.

> +
> +	/* First time through we will need to allocate the dax_devlist */
> +	if (unlikely(!fc->dax_devlist)) {

I'd avoid unlikely markings unless you have good evidence they are needed.
Let the branch predictors figure it out.

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
> +		/* We don't need famfs_devlist_sem here because we use cmpxchg */
> +		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
> +			kfree(local_devlist->devlist);
> +			kfree(local_devlist); /* another thread beat us to it */
> +		}
> +	}
> +
> +	down_read(&fc->famfs_devlist_sem);
> +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> +		if (!(meta->dev_bitmap & (1ULL << i)))

Could you do for_each_set_bit() on that bitmap?
Might end up clearer.

> +			continue;
> +
> +		/* This file meta struct references devindex i
> +		 * if devindex i isn't in the table; get it...
> +		 */
> +		if (!(fc->dax_devlist->devlist[i].valid)) {

Maybe flip logic and do a continue as you do with the condition above.

> +			up_read(&fc->famfs_devlist_sem);
> +
> +			err = famfs_fuse_get_daxdev(fm, i);
> +			if (err)
> +				pr_err("%s: failed to get daxdev=%d\n",
> +				       __func__, i);
> +
> +			down_read(&fc->famfs_devlist_sem);
> +		}
> +	}
> +	up_read(&fc->famfs_devlist_sem);
> +
> +	return 0;
> +}

