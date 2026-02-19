Return-Path: <linux-fsdevel+bounces-77734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H7sALVbl2lFxQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:51:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B8161CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EB0A301F4A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB042773CC;
	Thu, 19 Feb 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifiNoQsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56342765D4;
	Thu, 19 Feb 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527081; cv=none; b=LY9cxslZyCgex0Nrht5hvaVGaQ4tcy/5h+Y8lugyrOOFNi6EHQQ3d+KVLmR/DOXQESvafPdP9i8oUlSlBMBtcAkPJj+uDQlU96p/or7PHvsLqttYSegU76ZDkEAx7xAwiRW06Js1KR/qxjSVyUmHnY+ZODiu+ztmB3r63i5XMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527081; c=relaxed/simple;
	bh=/yBwW1RWJjdFwPgQx4LABRk0YhllKo9EHod/gZYm2II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+biZCIJH2La153auVM8PVlzAcGR5KCu1A9vp2eFGH7pHjeds5wZDQu6wscMXZZw2akcLKumn8UXlhEkbyFq6b5a9Qz3SxJbQAdkwNmoF/qgzRQabcyO88GrmIZ2U3cKk7W23Kx0O9h0cZl3rLHgF3fIpxtN0OR7pYRFU475TXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifiNoQsB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771527079; x=1803063079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/yBwW1RWJjdFwPgQx4LABRk0YhllKo9EHod/gZYm2II=;
  b=ifiNoQsBxQzr+cSrVz/gv++6yvMeo4xQ8UDRKvixEPXAmpbtg/OE6GWj
   E6u4GrnMQkyQ1CJ9GnDSa7maYp5HdO73W2qjCPtxCH/Qa5pyWUXYYubYx
   4H8LJsA2o+nu8YO/6d3hTd0kFpZ7SZ+rJX62qvRGfQ37rlh0MsDMP3qSC
   NqCYXyG5bWL3qnVMLUYCdxLe+p/tykvD7er+6ou8hwFSQfFdy/ZD3pm/9
   9FzcP148sjX26zgWqM767oxq+mROesKYOjArT4uBNzAT/o9zkpeNcpcj8
   eYYTSlyq1SrkvOC9bxp6ja7lINUkUsmgNhCMgenUw3O/vfgiDS3YQhmeQ
   Q==;
X-CSE-ConnectionGUID: gBYayd2jRbai5D3lwh0LfQ==
X-CSE-MsgGUID: JEYLwyUCSBqGM9MFlxw3ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76459381"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76459381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:51:18 -0800
X-CSE-ConnectionGUID: XR8dTTn/RxaGZgmnqycLAA==
X-CSE-MsgGUID: tv7Af4QqQKeecw0iuglgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="214465823"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:51:16 -0800
Message-ID: <80f4b014-207c-4a6d-89f3-9e49831dd691@intel.com>
Date: Thu, 19 Feb 2026 11:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 14/19] famfs_fuse: GET_DAXDEV message and daxdev_table
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223316.92580-1-john@jagalactic.com>
 <0100019bd33dd1f9-3e016d01-fe3b-4be0-a8d0-f566cd5e2c07-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33dd1f9-3e016d01-fe3b-4be0-a8d0-f566cd5e2c07-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77734-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,daxdev_out.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B7B8161CBC
X-Rspamd-Action: no action



On 1/18/26 3:33 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> - The new GET_DAXDEV message/response is added
> - The famfs.c:famfs_teardown() function is added as a primary teardown
>   function for famfs.
> - The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_table yet.
> - fs/namei.c: export may_open_dev()
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/famfs.c           | 230 +++++++++++++++++++++++++++++++++++++-
>  fs/fuse/famfs_kfmap.h     |  26 +++++
>  fs/fuse/fuse_i.h          |  19 ++++
>  fs/fuse/inode.c           |   7 +-
>  fs/namei.c                |   1 +
>  include/uapi/linux/fuse.h |  20 ++++
>  6 files changed, 301 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index a9728e11f1dd..7aa2eb2e99bf 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -21,6 +21,231 @@
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
> +	fc->dax_devlist = NULL;
> +
> +	if (!devlist)
> +		return;
> +
> +	if (!devlist->devlist)
> +		goto out;

I think if you declare devlist with __free(), you can just return instead of having a goto.

DJ

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
> +
> +static int
> +famfs_verify_daxdev(const char *pathname, dev_t *devno)
> +{
> +	struct inode *inode;
> +	struct path path;
> +	int err;
> +
> +	if (!pathname || !*pathname)
> +		return -EINVAL;
> +
> +	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
> +	if (err)
> +		return err;
> +
> +	inode = d_backing_inode(path.dentry);
> +	if (!S_ISCHR(inode->i_mode)) {
> +		err = -EINVAL;
> +		goto out_path_put;
> +	}
> +
> +	if (!may_open_dev(&path)) { /* had to export this */
> +		err = -EACCES;
> +		goto out_path_put;
> +	}
> +
> +	*devno = inode->i_rdev;
> +
> +out_path_put:
> +	path_put(&path);
> +	return err;
> +}
> +
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
> +	int rc;
> +
> +	FUSE_ARGS(args);
> +
> +	/* Store the daxdev in our table */
> +	if (index >= fc->dax_devlist->nslots) {
> +		pr_err("%s: index(%lld) > nslots(%d)\n",
> +		       __func__, index, fc->dax_devlist->nslots);
> +		return -EINVAL;
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
> +	rc = fuse_simple_request(fm, &args);
> +	if (rc) {
> +		pr_err("%s: rc=%d from fuse_simple_request()\n",
> +		       __func__, rc);
> +		/* Error will be that the payload is smaller than FMAP_BUFSIZE,
> +		 * which is the max we can handle. Empty payload handled below.
> +		 */
> +		return rc;
> +	}
> +
> +	scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {
> +		daxdev = &fc->dax_devlist->devlist[index];
> +
> +		/* Abort if daxdev is now valid (races are possible here) */
> +		if (daxdev->valid) {
> +			pr_debug("%s: daxdev already known\n", __func__);
> +			return 0;
> +		}
> +
> +		/* Verify dev is valid and can be opened and gets the devno */
> +		rc = famfs_verify_daxdev(daxdev_out.name, &daxdev->devno);
> +		if (rc) {
> +			pr_err("%s: rc=%d from famfs_verify_daxdev()\n",
> +			       __func__, rc);
> +			return rc;
> +		}
> +
> +		daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
> +		if (!daxdev->name)
> +			return -ENOMEM;
> +
> +		/* This will fail if it's not a dax device */
> +		daxdev->devp = dax_dev_get(daxdev->devno);
> +		if (!daxdev->devp) {
> +			pr_warn("%s: device %s not found or not dax\n",
> +				__func__, daxdev_out.name);
> +			kfree(daxdev->name);
> +			daxdev->name = NULL;
> +			return -ENODEV;
> +		}
> +
> +		wmb(); /* All other fields must be visible before valid */
> +		daxdev->valid = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * famfs_update_daxdev_table() - Update the daxdev table
> + * @fm:   fuse_mount
> + * @meta: famfs_file_meta, in-memory format, built from a GET_FMAP response
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
> +	int indices_to_fetch[MAX_DAXDEVS];
> +	int n_to_fetch = 0;
> +	int err;
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
> +		/* We don't need famfs_devlist_sem here because we use cmpxchg */
> +		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
> +			kfree(local_devlist->devlist);
> +			kfree(local_devlist); /* another thread beat us to it */
> +		}
> +	}
> +
> +	/* Collect indices that need fetching while holding read lock */
> +	scoped_guard(rwsem_read, &fc->famfs_devlist_sem) {
> +		unsigned long i;
> +
> +		for_each_set_bit(i, (unsigned long *)&meta->dev_bitmap, MAX_DAXDEVS) {
> +			if (!(fc->dax_devlist->devlist[i].valid))
> +				indices_to_fetch[n_to_fetch++] = i;
> +		}
> +	}
> +
> +	/* Fetch needed daxdevs outside the read lock */
> +	for (int j = 0; j < n_to_fetch; j++) {
> +		err = famfs_fuse_get_daxdev(fm, indices_to_fetch[j]);
> +		if (err)
> +			pr_err("%s: failed to get daxdev=%d\n",
> +			       __func__, indices_to_fetch[j]);
> +	}
> +
> +	return 0;
> +}
>  
>  /***************************************************************************/
>  
> @@ -184,7 +409,7 @@ famfs_fuse_meta_alloc(
>  			/* ie_in = one interleaved extent in fmap_buf */
>  			ie_in = fmap_buf + next_offset;
>  
> -			/* Move past one interleaved extent header in fmap_buf */
> +			/* Move past 1 interleaved extent header in fmap_buf */
>  			next_offset += sizeof(*ie_in);
>  			if (next_offset > fmap_buf_size) {
>  				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> @@ -329,6 +554,9 @@ famfs_file_init_dax(
>  	if (rc)
>  		goto errout;
>  
> +	/* Make sure this fmap doesn't reference any unknown daxdevs */
> +	famfs_update_daxdev_table(fm, meta);
> +
>  	/* Publish the famfs metadata on fi->famfs_meta */
>  	inode_lock(inode);
>  
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> index 18ab22bcc5a1..eb9f70b5cb81 100644
> --- a/fs/fuse/famfs_kfmap.h
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -64,4 +64,30 @@ struct famfs_file_meta {
>  	};
>  };
>  
> +/*
> + * famfs_daxdev - tracking struct for a daxdev within a famfs file system
> + *
> + * This is the in-memory daxdev metadata that is populated by parsing
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
> +/*
> + * famfs_dax_devlist - list of famfs_daxdev's
> + */
> +struct famfs_dax_devlist {
> +	int nslots;
> +	int ndevs;
> +	struct famfs_daxdev *devlist;
> +};
> +
>  #endif /* FAMFS_KFMAP_H */
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index dbfec5b9c6e1..83e24cee994b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1006,6 +1006,11 @@ struct fuse_conn {
>  		/* Request timeout (in jiffies). 0 = no timeout */
>  		unsigned int req_timeout;
>  	} timeout;
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	struct rw_semaphore famfs_devlist_sem;
> +	struct famfs_dax_devlist *dax_devlist;
> +#endif
>  };
>  
>  /*
> @@ -1647,6 +1652,8 @@ int famfs_file_init_dax(struct fuse_mount *fm,
>  			size_t fmap_size);
>  void __famfs_meta_free(void *map);
>  
> +void famfs_teardown(struct fuse_conn *fc);
> +
>  /* Set fi->famfs_meta = NULL regardless of prior value */
>  static inline void famfs_meta_init(struct fuse_inode *fi)
>  {
> @@ -1668,6 +1675,11 @@ static inline void famfs_meta_free(struct fuse_inode *fi)
>  	}
>  }
>  
> +static inline void famfs_init_devlist_sem(struct fuse_conn *fc)
> +{
> +	init_rwsem(&fc->famfs_devlist_sem);
> +}
> +
>  static inline int fuse_file_famfs(struct fuse_inode *fi)
>  {
>  	return (READ_ONCE(fi->famfs_meta) != NULL);
> @@ -1677,6 +1689,9 @@ int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
>  
>  #else /* !CONFIG_FUSE_FAMFS_DAX */
>  
> +static inline void famfs_teardown(struct fuse_conn *fc)
> +{
> +}
>  static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
>  						  void *meta)
>  {
> @@ -1687,6 +1702,10 @@ static inline void famfs_meta_free(struct fuse_inode *fi)
>  {
>  }
>  
> +static inline void famfs_init_devlist_sem(struct fuse_conn *fc)
> +{
> +}
> +
>  static inline int fuse_file_famfs(struct fuse_inode *fi)
>  {
>  	return 0;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b9933d0fbb9f..c5c7f2aeda3f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1047,6 +1047,9 @@ void fuse_conn_put(struct fuse_conn *fc)
>  		WARN_ON(atomic_read(&bucket->count) != 1);
>  		kfree(bucket);
>  	}
> +	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> +		famfs_teardown(fc);
> +
>  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		fuse_backing_files_free(fc);
>  	call_rcu(&fc->rcu, delayed_release);
> @@ -1476,8 +1479,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  				u64 in_flags = ((u64)ia->in.flags2 << 32)
>  						| ia->in.flags;
>  
> -				if (in_flags & FUSE_DAX_FMAP)
> +				if (in_flags & FUSE_DAX_FMAP) {
> +					famfs_init_devlist_sem(fc);
>  					fc->famfs_iomap = 1;
> +				}
>  			}
>  		} else {
>  			ra_pages = fc->max_read / PAGE_SIZE;
> diff --git a/fs/namei.c b/fs/namei.c
> index cf16b6822dd3..99ac58975394 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4171,6 +4171,7 @@ bool may_open_dev(const struct path *path)
>  	return !(path->mnt->mnt_flags & MNT_NODEV) &&
>  		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
>  }
> +EXPORT_SYMBOL(may_open_dev);
>  
>  static int may_open(struct mnt_idmap *idmap, const struct path *path,
>  		    int acc_mode, int flag)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index cf678bebbfe0..1b82895108be 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -247,6 +247,9 @@
>   *    - struct fuse_famfs_simple_ext
>   *    - struct fuse_famfs_iext
>   *    - struct fuse_famfs_fmap_header
> + *  - Add the following structs for the GET_DAXDEV message and reply
> + *    - struct fuse_get_daxdev_in
> + *    - struct fuse_get_daxdev_out
>   *  - Add the following enumerated types
>   *    - enum fuse_famfs_file_type
>   *    - enum famfs_ext_type
> @@ -678,6 +681,7 @@ enum fuse_opcode {
>  
>  	/* Famfs / devdax opcodes */
>  	FUSE_GET_FMAP           = 54,
> +	FUSE_GET_DAXDEV         = 55,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> @@ -1369,6 +1373,22 @@ struct fuse_famfs_fmap_header {
>  	uint64_t reserved1;
>  };
>  
> +struct fuse_get_daxdev_in {
> +	uint32_t        daxdev_num;
> +};
> +
> +#define DAXDEV_NAME_MAX 256
> +
> +/* fuse_daxdev_out has enough space for a uuid if we need it */
> +struct fuse_daxdev_out {
> +	uint16_t index;
> +	uint16_t reserved;
> +	uint32_t reserved2;
> +	uint64_t reserved3;
> +	uint64_t reserved4;
> +	char name[DAXDEV_NAME_MAX];
> +};
> +
>  static inline int32_t fmap_msg_min_size(void)
>  {
>  	/* Smallest fmap message is a header plus one simple extent */


