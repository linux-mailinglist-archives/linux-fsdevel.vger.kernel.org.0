Return-Path: <linux-fsdevel+bounces-54650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1BB01E2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28EA3AC707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E92D839E;
	Fri, 11 Jul 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf0OK7zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFE29B23E;
	Fri, 11 Jul 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241621; cv=none; b=exwsip2haQAZPHUC94wjM1ZVccYMA45tbMcA7UFMIPIXWh4ms5W6RDqFGl5cuZe6cM3sVJH/I7T2Q3nz4P6G5QtEDet2Gzcsy/JwE+jBOoQpeAhLiYKsC64DzmaYYueuF0rLPf55B+9wdyEqE0H6VbVThXmJnHLj3BNzELFSkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241621; c=relaxed/simple;
	bh=rU03N2HhMy2BaScWgGYe/Q97rekeyCC3P9NomOCiiJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrkfTxsIIWyFjGKNcqIVqgq8h6YZpHnJlK29dUl21mQHawQrvkvgOIM28ZD1S2TiemuOANnfW1sT1Q08sp+leNYTIngiNxCPK3vXXWUWyCjUfvwtXFIecGZpzUPPXBr8279hP9YRNuaQbrnMUUo14UdVGgyJJJXWFxYWNLVxSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf0OK7zo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7387f21daadso1660208a34.0;
        Fri, 11 Jul 2025 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752241618; x=1752846418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GPuleXeBHMAWgXuPdR3B4XK+IiQDyEEXPlfp+HEtyk=;
        b=mf0OK7zo+DUa2gPjT3xfUUUvaTxejwdxCLJzDoeLhi4XKsmiMKC4t3n9GBuX7+08io
         Jpv3QMltT4vKY3wsUkDW6AKE5LLEP+9W6hXXPaioRSoOCMERoEd6CMzQ50plPbxrnQVu
         wRlXLSlX+CGwi3TiRQfLy/JINRya9Psvy5TBI8VmwEPNKheXcu7lW1BGi/6qugFP3xTF
         uK0yhkKWnvkXIiOcs2rNk7RhLCln4RcMQJHpRlGL4gMLX7ya61VN+pZRkx+p7W3J1GcR
         vAiOoNfZLUB7u4YzGNakXCBKIOf1XoJCLR7duqo3pCG5d9E6TYLfsDrooX6PuhzVDGcF
         ugCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241618; x=1752846418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GPuleXeBHMAWgXuPdR3B4XK+IiQDyEEXPlfp+HEtyk=;
        b=P6awErtvFsqgGbwDQfaVG9o8pIEdTayFh3kgxbwIzV5Jo1l9RE45NNlrVjHpyrHHBt
         7PxZUbJdBkRjsiUYDLXfwv0NoKK1ZHv5Gj+KHPwEod9rZC96EyQwh2xHUri3M0gVkIYQ
         QRlO0Gaj+8kfWavm+8I2xAsaKbAVZsbqikR7b+N+OIhZeu7g4qxun1iYorrV/W3s9HFq
         r7tJhSUoFVycYDu6X/PYoHjTdr6KKrpOXOVhvM/Yu2ZOpPjrP0YQODmXm76qdXsIaW1D
         dDmXyhGGJpJm/6qN7L7R9F9qKsxre1Lob+oGCINJvffKTwGOHwFqVSr596kacbmTHEf3
         3wfA==
X-Forwarded-Encrypted: i=1; AJvYcCV1tGpkPNHWtmayi5boAcqzFld4yySRPwispnOwruTm6akCixLRGO8yoqOQR6WPGS2E+deEBxOM1PRhzhEbOg==@vger.kernel.org, AJvYcCVYr47vS8Oa6+ctBDKPFHF+ZqfDIU8fiOMONNcC5bCk7HTd7XruCiU3wwQSU+8jSBOWa0B6qNz/+3dJGpPH@vger.kernel.org, AJvYcCVp01YgQmSqzLFKdc9nEawX8QgQ0r2jC8CRYlWz4TviR4wUUkKLsMpva7SIoghiSEpu8nojCXsGj7Pq@vger.kernel.org, AJvYcCXAX0HufPGMuvo3JNaExYREELpaZBlUnxA2YxH6+FfpOJeddNMUhMp28ZTAXbtypKSbSk4rxvqXxAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjH577CQOAqMs5bRik3bYB4P5e33jbNWJnbsxoD+HC4w6Bd4hk
	U2XqYkCl3DnIgRD4RUy+DvaaGAImHJFJqJsaRrri7giCNUKh6Nrlkdbs
X-Gm-Gg: ASbGncuIB7VOazDCPtkvvCRSsxFnxi9sYUrST+34UA5ohkUrWjHnWeueSh9x/kbtGme
	0OWypMlEGgDxHiLchG/xM5EN67p81JfFgLmu/jukjzPpL9/IFVvgDheVeLSOJ7NQgJw+2YTlT5W
	f3kWHUWZeWmf06QWIl/h+RkF/e6HOKxEzUsm0ls6eh5YBqAItI/M3rw0J94S5Ev7Sx1UkLPik08
	2y4N5tUJ/OuoRbB1iVzo8wzVv+cwXQtxPK3AUbqyWZ8Yiwggj9ilcRbCT6rEsb4/A7vYNAqf3TW
	InIpwxdXNHdub1Z5z7jwLaP6r/hTG4YE1pC/PXBi5HlvhFaiE2InQ49U05hVL4igD1UeL5rpxA2
	dVSsZQAlzRjc8cqPhs/a1zIIspySuIlLX71ye
X-Google-Smtp-Source: AGHT+IEe2XPLigbUHcncB2xlw3olBXm4plTDrY+NsL1YHY2kqGP5ueQ/yK2JyL3sv4JtTRMyN4WCtA==
X-Received: by 2002:a05:6830:b85:b0:73b:1efa:5f5c with SMTP id 46e09a7af769-73cfa28914dmr2857648a34.8.1752241617517;
        Fri, 11 Jul 2025 06:46:57 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:25b0:db8a:a7d3:ffe1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a6ea1sm559465a34.49.2025.07.11.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:46:56 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 11 Jul 2025 08:46:54 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <2vkgyxe3mnyamj33axiwthmqo32akdakfgv3vfauziakjnzqtj@vr3erk5wdshq>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <20250709042713.GF2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709042713.GF2672029@frogsfrogsfrogs>

On 25/07/08 09:27PM, Darrick J. Wong wrote:
> On Thu, Jul 03, 2025 at 01:50:26PM -0500, John Groves wrote:
> > Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> > retrieve and cache up the file-to-dax map in the kernel. If this
> > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> > 
> > GET_FMAP has a variable-size response payload, and the allocated size
> > is sent in the in_args[0].size field. If the fmap would overflow the
> > message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> > specifies the size of the fmap message. Then the kernel can realloc a
> > large enough buffer and try again.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/file.c            | 84 +++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h          | 36 ++++++++++++++++-
> >  fs/fuse/inode.c           | 19 +++++++--
> >  fs/fuse/iomode.c          |  2 +-
> >  include/uapi/linux/fuse.h | 18 +++++++++
> >  5 files changed, 154 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 93b82660f0c8..8616fb0a6d61 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -230,6 +230,77 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
> >  	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +
> > +#define FMAP_BUFSIZE 4096
> 
> PAGE_SIZE ?

Like it. Queued to -next

> 
> > +
> > +static int
> > +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
> > +{
> > +	struct fuse_get_fmap_in inarg = { 0 };
> > +	size_t fmap_bufsize = FMAP_BUFSIZE;
> > +	ssize_t fmap_size;
> > +	int retries = 1;
> > +	void *fmap_buf;
> > +	int rc;
> > +
> > +	FUSE_ARGS(args);
> > +
> > +	fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
> > +	if (!fmap_buf)
> > +		return -EIO;
> > +
> > + retry_once:
> > +	inarg.size = fmap_bufsize;
> > +
> > +	args.opcode = FUSE_GET_FMAP;
> > +	args.nodeid = nodeid;
> > +
> > +	args.in_numargs = 1;
> > +	args.in_args[0].size = sizeof(inarg);
> > +	args.in_args[0].value = &inarg;
> > +
> > +	/* Variable-sized output buffer
> > +	 * this causes fuse_simple_request() to return the size of the
> > +	 * output payload
> > +	 */
> > +	args.out_argvar = true;
> > +	args.out_numargs = 1;
> > +	args.out_args[0].size = fmap_bufsize;
> > +	args.out_args[0].value = fmap_buf;
> > +
> > +	/* Send GET_FMAP command */
> > +	rc = fuse_simple_request(fm, &args);
> > +	if (rc < 0) {
> > +		pr_err("%s: err=%d from fuse_simple_request()\n",
> > +		       __func__, rc);
> > +		return rc;
> > +	}
> > +	fmap_size = rc;
> > +
> > +	if (retries && fmap_size == sizeof(uint32_t)) {
> > +		/* fmap size exceeded fmap_bufsize;
> > +		 * actual fmap size returned in fmap_buf;
> > +		 * realloc and retry once
> > +		 */
> > +		fmap_bufsize = *((uint32_t *)fmap_buf);
> > +
> > +		--retries;
> > +		kfree(fmap_buf);
> > +		fmap_buf = kcalloc(1, fmap_bufsize, GFP_KERNEL);
> > +		if (!fmap_buf)
> > +			return -EIO;
> > +
> > +		goto retry_once;
> > +	}
> > +
> > +	/* Will call famfs_file_init_dax() when that gets added */
> 
> Hard to say what this does without looking further down in the patchset.
> :)

New comment:
	/* We retrieved the "fmap" (the file's map to memory), but
	 * we haven't used it yet. A call to famfs_file_init_dax() will be added
	 * here in a subsequent patch, when we add the ability to attach
	 * fmaps to files.
	 */

> 
> > +	kfree(fmap_buf);
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static int fuse_open(struct inode *inode, struct file *file)
> >  {
> >  	struct fuse_mount *fm = get_fuse_mount(inode);
> > @@ -263,6 +334,19 @@ static int fuse_open(struct inode *inode, struct file *file)
> >  
> >  	err = fuse_do_open(fm, get_node_id(inode), file, false);
> >  	if (!err) {
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +		if (fm->fc->famfs_iomap) {
> > +			if (S_ISREG(inode->i_mode)) {
> 
> /me wonders if you want to turn this into a dumb helper to reduce the
> indenting levels?
> 
> #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> static inline bool fuse_is_famfs_file(struct inode *inode)
> {
> 	return fm->fc->famfs_iomap && S_ISREG(inode->i_mode);
> }
> #else
> # define fuse_is_famfs_file(...)	(false)
> #endif
> 
> 	if (!err) {
> 		if (fuse_is_famfs_file(inode)) {
> 			rc = fuse_get_fmap(fm, inode);
> 			...
> 		}
> 	}
> 

I've already refactored helpers and simplified this logic in the -next 
branch, including losing the conditrional code here in file.c:

	if (!err) {
		if ((fm->fc->famfs_iomap) && (S_ISREG(inode->i_mode))) {
			int rc;
			/* Get the famfs fmap */
			rc = fuse_get_fmap(fm, inode);
			...
		}
		...
	}

So I think it's quite a bit cleaner... will send out an updated patch
pretty soon (probably next week, without the poisoned page fixes yet).

> > +				int rc;
> > +				/* Get the famfs fmap */
> > +				rc = fuse_get_fmap(fm, inode,
> > +						   get_node_id(inode));
> 
> Just get_node_id inside fuse_get_fmap to reduce the parameter count.

Done, thanks

> 
> > +				if (rc)
> > +					pr_err("%s: fuse_get_fmap err=%d\n",
> > +					       __func__, rc);
> > +			}
> > +		}
> > +#endif
> >  		ff = file->private_data;
> >  		err = fuse_finish_open(inode, file);
> >  		if (err)
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index f4ee61046578..e01d6e5c6e93 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -193,6 +193,10 @@ struct fuse_inode {
> >  	/** Reference to backing file in passthrough mode */
> >  	struct fuse_backing *fb;
> >  #endif
> > +
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +	void *famfs_meta;
> > +#endif
> 
> What gets stored in here?

Explanatory comment added:
	/* Pointer to the file's famfs metadata. Primary content is the
	 * in-memory version of the fmap - the map from file's offset range
	 * to DAX memory
	 */

> 
> >  };
> >  
> >  /** FUSE inode state bits */
> > @@ -945,6 +949,8 @@ struct fuse_conn {
> >  #endif
> >  
> >  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +	struct rw_semaphore famfs_devlist_sem;
> > +	struct famfs_dax_devlist *dax_devlist;
> >  	char *shadow;
> >  #endif
> >  };
> > @@ -1435,11 +1441,14 @@ void fuse_free_conn(struct fuse_conn *fc);
> >  
> >  /* dax.c */
> >  
> > +static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
> > +
> >  /* This macro is used by virtio_fs, but now it also needs to filter for
> >   * "not famfs"
> >   */
> >  #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
> > -					&& IS_DAX(&fuse_inode->inode))
> > +					&& IS_DAX(&fuse_inode->inode)	\
> > +					&& !fuse_file_famfs(fuse_inode))
> >  
> >  ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
> >  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
> > @@ -1550,4 +1559,29 @@ extern void fuse_sysctl_unregister(void);
> >  #define fuse_sysctl_unregister()	do { } while (0)
> >  #endif /* CONFIG_SYSCTL */
> >  
> > +/* famfs.c */
> > +static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> > +						       void *meta)
> > +{
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +	return xchg(&fi->famfs_meta, meta);
> > +#else
> > +	return NULL;
> > +#endif
> > +}
> > +
> > +static inline void famfs_meta_free(struct fuse_inode *fi)
> > +{
> > +	/* Stub wil be connected in a subsequent commit */
> > +}
> > +
> > +static inline int fuse_file_famfs(struct fuse_inode *fi)
> > +{
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +	return (READ_ONCE(fi->famfs_meta) != NULL);
> > +#else
> > +	return 0;
> > +#endif
> > +}
> 
> ...or maybe this is the predicate you want to see if you really need to
> fmapping related stuff?
> 
> > +
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index a7e1cf8257b0..b071d16f7d04 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
> >  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >  		fuse_inode_backing_set(fi, NULL);
> >  
> > +	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > +		famfs_meta_set(fi, NULL);
> > +
> >  	return &fi->inode;
> >  
> >  out_free_forget:
> > @@ -138,6 +141,13 @@ static void fuse_free_inode(struct inode *inode)
> >  	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >  		fuse_backing_put(fuse_inode_backing(fi));
> >  
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +	if (S_ISREG(inode->i_mode) && fi->famfs_meta) {
> > +		famfs_meta_free(fi);
> > +		famfs_meta_set(fi, NULL);
> 
> _free should null out the pointer, no?

Good point - will do

<snip>

Thanks Darrick!
John


