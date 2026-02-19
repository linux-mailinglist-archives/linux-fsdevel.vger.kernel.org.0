Return-Path: <linux-fsdevel+bounces-77726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD2yLsFEl2kiwQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:13:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7FD161006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D9E30523D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BE34DB74;
	Thu, 19 Feb 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1plIJiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496334A3DA;
	Thu, 19 Feb 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521146; cv=none; b=gyvTrRWQm9VdKKn4wF/QxvCkuo7LQ8SxTRXwR0dxtwFHP2UmQ/4Qbq2VqAnYQ6V+q2w/TwaIbtJCCkAueZ72+8Tbekhs41ZX8s9w/rtAVSIzPgX6Zeto8JLpX8s1mNDCSgKdqDjRe3qCfLRoHdUxLtx7V5mRHz2qhdHqJ+AIbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521146; c=relaxed/simple;
	bh=j+bBJdGxslnhOQvbE4Qpk62+ae5bZlMHiWrTGW376pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDGZQh68Xcv1dSZvPCXW2Ty7MbQZXjBBq+yQTsvdT+KZ8ShyYPkKMGDSUZf86GVGvOJ6aZArP258yYTfyQXzL/cito8yV7NhMESoS+0ktOdkhgwesgxhOWtMDoXm799Ocm6V8nUrdhqT4/lw0m0aMLSHwyHEMDIJv3pWWTIAvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1plIJiA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771521144; x=1803057144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j+bBJdGxslnhOQvbE4Qpk62+ae5bZlMHiWrTGW376pI=;
  b=j1plIJiADdtH1272KY66r538RXjtH6iaSzmXq7nuk4VcUp/wXRd7XHfh
   +ke+NtwbzWmsaxmVI7Gf0je/5StoPUvmErkEuK7iLF6yGm4a62lZoAln7
   osZpoBu3/65SAA5+BGlXDiAAEo+LhojNfeShuxyLvz5GXVdDzUB8CaEW5
   CFi9K1SSuweQEpY8vhBf+9AMcUNPcFdOMJAu2EcvFxCoUpNrhwAE6BfKq
   Xopm+uVIdbjIrtBIlKQi1boqMlBqw9XEO4/qSXnmP+lV7mTaZGqR09TWj
   vgXrArPjph4DRhoQ5R0d/JkPEfHUBQBm7BHrl1OAJuFPzuOEM6vuqdPNd
   Q==;
X-CSE-ConnectionGUID: EE793CKHQmaSzdJaX2Nqqg==
X-CSE-MsgGUID: 3Im6oYJ7TY6lAuUqAKKQTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71819322"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="71819322"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 09:12:21 -0800
X-CSE-ConnectionGUID: SCfhtgPlR0qt4pIIlJ9hSQ==
X-CSE-MsgGUID: ysB3y6DvSK+wOoAeUfeg+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219099046"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 09:12:19 -0800
Message-ID: <489212dc-7f99-4748-b631-218bf78737a7@intel.com>
Date: Thu, 19 Feb 2026 10:12:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 12/19] famfs_fuse: Plumb the GET_FMAP message/response
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
 <20260118223257.92539-1-john@jagalactic.com>
 <0100019bd33d8b0a-05af2fc2-66c2-45e7-9091-42ca2efa6780-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33d8b0a-05af2fc2-66c2-45e7-9091-42ca2efa6780-000000@email.amazonses.com>
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
	TAGGED_FROM(0.00)[bounces-77726-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,groves.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,micron.com:email]
X-Rspamd-Queue-Id: 1A7FD161006
X-Rspamd-Action: no action



On 1/18/26 3:33 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> retrieve and cache up the file-to-dax map in the kernel. If this
> succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  MAINTAINERS               |  8 +++++
>  fs/fuse/Makefile          |  1 +
>  fs/fuse/famfs.c           | 74 +++++++++++++++++++++++++++++++++++++++
>  fs/fuse/file.c            | 14 +++++++-
>  fs/fuse/fuse_i.h          | 70 +++++++++++++++++++++++++++++++++---
>  fs/fuse/inode.c           |  8 ++++-
>  fs/fuse/iomode.c          |  2 +-
>  include/uapi/linux/fuse.h |  7 ++++
>  8 files changed, 176 insertions(+), 8 deletions(-)
>  create mode 100644 fs/fuse/famfs.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10aa5120d93f..e3d0aa5eb361 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10379,6 +10379,14 @@ F:	fs/fuse/
>  F:	include/uapi/linux/fuse.h
>  F:	tools/testing/selftests/filesystems/fuse/
>  
> +FUSE [FAMFS Fabric-Attached Memory File System]
> +M:	John Groves <jgroves@micron.com>
> +M:	John Groves <John@Groves.net>
> +L:	linux-cxl@vger.kernel.org
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Supported
> +F:	fs/fuse/famfs.c
> +
>  FUTEX SUBSYSTEM
>  M:	Thomas Gleixner <tglx@kernel.org>
>  M:	Ingo Molnar <mingo@redhat.com>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 22ad9538dfc4..3f8dcc8cbbd0 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -17,5 +17,6 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
>  fuse-$(CONFIG_SYSCTL) += sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> +fuse-$(CONFIG_FUSE_FAMFS_DAX) += famfs.o
>  
>  virtiofs-y := virtio_fs.o
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> new file mode 100644
> index 000000000000..615819cc922d
> --- /dev/null
> +++ b/fs/fuse/famfs.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2026 Micron Technology, Inc.
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file system
> + * view of dax files that map to shared memory.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/dax.h>
> +#include <linux/iomap.h>
> +#include <linux/path.h>
> +#include <linux/namei.h>
> +#include <linux/string.h>
> +
> +#include "fuse_i.h"
> +
> +
> +#define FMAP_BUFSIZE PAGE_SIZE
> +
> +int
> +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)

keep the return int on the same line?

> +{
> +	void *fmap_buf __free(kfree) = NULL;

Should do the variable declaration when you do the kzalloc(). That way you can avoid any potential use before check issues.

> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	size_t fmap_bufsize = FMAP_BUFSIZE;
> +	u64 nodeid = get_node_id(inode);
> +	ssize_t fmap_size;
> +	int rc;
> +
> +	FUSE_ARGS(args);
> +
> +	/* Don't retrieve if we already have the famfs metadata */
> +	if (fi->famfs_meta)
> +		return 0;
> +
> +	fmap_buf = kzalloc(FMAP_BUFSIZE, GFP_KERNEL);
> +	if (!fmap_buf)
> +		return -EIO;

-ENOMEM?

DJ
> +
> +	args.opcode = FUSE_GET_FMAP;
> +	args.nodeid = nodeid;
> +
> +	/* Variable-sized output buffer
> +	 * this causes fuse_simple_request() to return the size of the
> +	 * output payload
> +	 */
> +	args.out_argvar = true;
> +	args.out_numargs = 1;
> +	args.out_args[0].size = fmap_bufsize;
> +	args.out_args[0].value = fmap_buf;
> +
> +	/* Send GET_FMAP command */
> +	rc = fuse_simple_request(fm, &args);
> +	if (rc < 0) {
> +		pr_err("%s: err=%d from fuse_simple_request()\n",
> +		       __func__, rc);
> +		return rc;
> +	}
> +	fmap_size = rc;
> +
> +	/* We retrieved the "fmap" (the file's map to memory), but
> +	 * we haven't used it yet. A call to famfs_file_init_dax() will be added
> +	 * here in a subsequent patch, when we add the ability to attach
> +	 * fmaps to files.
> +	 */
> +
> +	return 0;
> +}
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 093569033ed1..1f64bf68b5ee 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -277,6 +277,16 @@ static int fuse_open(struct inode *inode, struct file *file)
>  	err = fuse_do_open(fm, get_node_id(inode), file, false);
>  	if (!err) {
>  		ff = file->private_data;
> +
> +		if ((fm->fc->famfs_iomap) && (S_ISREG(inode->i_mode))) {
> +			/* Get the famfs fmap - failure is fatal */
> +			err = fuse_get_fmap(fm, inode);
> +			if (err) {
> +				fuse_sync_release(fi, ff, file->f_flags);
> +				goto out_nowrite;
> +			}
> +		}
> +
>  		err = fuse_finish_open(inode, file);
>  		if (err)
>  			fuse_sync_release(fi, ff, file->f_flags);
> @@ -284,12 +294,14 @@ static int fuse_open(struct inode *inode, struct file *file)
>  			fuse_truncate_update_attr(inode, file);
>  	}
>  
> +out_nowrite:
>  	if (is_wb_truncate || dax_truncate)
>  		fuse_release_nowrite(inode);
>  	if (!err) {
>  		if (is_truncate)
>  			truncate_pagecache(inode, 0);
> -		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> +		else if (!(ff->open_flags & FOPEN_KEEP_CACHE) &&
> +			 !fuse_file_famfs(fi))
>  			invalidate_inode_pages2(inode->i_mapping);
>  	}
>  	if (dax_truncate)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 2839efb219a9..b66b5ca0bc11 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -223,6 +223,14 @@ struct fuse_inode {
>  	 * so preserve the blocksize specified by the server.
>  	 */
>  	u8 cached_i_blkbits;
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	/* Pointer to the file's famfs metadata. Primary content is the
> +	 * in-memory version of the fmap - the map from file's offset range
> +	 * to DAX memory
> +	 */
> +	void *famfs_meta;
> +#endif
>  };
>  
>  /** FUSE inode state bits */
> @@ -1511,11 +1519,8 @@ void fuse_free_conn(struct fuse_conn *fc);
>  
>  /* dax.c */
>  
> -static inline bool fuse_file_famfs(struct fuse_inode *fuse_inode) /* Will be superseded */
> -{
> -	(void)fuse_inode;
> -	return false;
> -}
> +static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
> +
>  #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
>  					&& IS_DAX(&fuse_inode->inode)  \
>  					&& !fuse_file_famfs(fuse_inode))
> @@ -1634,4 +1639,59 @@ extern void fuse_sysctl_unregister(void);
>  #define fuse_sysctl_unregister()	do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +/* famfs.c */
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +void __famfs_meta_free(void *map);
> +
> +/* Set fi->famfs_meta = NULL regardless of prior value */
> +static inline void famfs_meta_init(struct fuse_inode *fi)
> +{
> +	fi->famfs_meta = NULL;
> +}
> +
> +/* Set fi->famfs_meta iff the current value is NULL */
> +static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> +						  void *meta)
> +{
> +	return cmpxchg(&fi->famfs_meta, NULL, meta);
> +}
> +
> +static inline void famfs_meta_free(struct fuse_inode *fi)
> +{
> +	famfs_meta_set(fi, NULL);
> +}
> +
> +static inline int fuse_file_famfs(struct fuse_inode *fi)
> +{
> +	return (READ_ONCE(fi->famfs_meta) != NULL);
> +}
> +
> +int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
> +
> +#else /* !CONFIG_FUSE_FAMFS_DAX */
> +
> +static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> +						  void *meta)
> +{
> +	return NULL;
> +}
> +
> +static inline void famfs_meta_free(struct fuse_inode *fi)
> +{
> +}
> +
> +static inline int fuse_file_famfs(struct fuse_inode *fi)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_FUSE_FAMFS_DAX */
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index acabf92a11f8..f2d742d723dc 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -120,6 +120,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
>  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		fuse_inode_backing_set(fi, NULL);
>  
> +	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> +		famfs_meta_set(fi, NULL);
> +
>  	return &fi->inode;
>  
>  out_free_forget:
> @@ -141,6 +144,9 @@ static void fuse_free_inode(struct inode *inode)
>  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  		fuse_backing_put(fuse_inode_backing(fi));
>  
> +	if (S_ISREG(inode->i_mode) && fuse_file_famfs(fi))
> +		famfs_meta_free(fi);
> +
>  	kmem_cache_free(fuse_inode_cachep, fi);
>  }
>  
> @@ -162,7 +168,7 @@ static void fuse_evict_inode(struct inode *inode)
>  	/* Will write inode on close/munmap and in all other dirtiers */
>  	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
>  
> -	if (FUSE_IS_VIRTIO_DAX(fi))
> +	if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_famfs(fi))
>  		dax_break_layout_final(inode);
>  
>  	truncate_inode_pages_final(&inode->i_data);
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 31ee7f3304c6..948148316ef0 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
>  	 * io modes are not relevant with DAX and with server that does not
>  	 * implement open.
>  	 */
> -	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
> +	if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_famfs(fi) || !ff->args)
>  		return 0;
>  
>  	/*
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 25686f088e6a..9eff9083d3b5 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -669,6 +669,9 @@ enum fuse_opcode {
>  	FUSE_STATX		= 52,
>  	FUSE_COPY_FILE_RANGE_64	= 53,
>  
> +	/* Famfs / devdax opcodes */
> +	FUSE_GET_FMAP           = 54,
> +
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
>  
> @@ -1313,4 +1316,8 @@ struct fuse_uring_cmd_req {
>  	uint8_t padding[6];
>  };
>  
> +/* Famfs fmap message components */
> +
> +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
> +
>  #endif /* _LINUX_FUSE_H */


