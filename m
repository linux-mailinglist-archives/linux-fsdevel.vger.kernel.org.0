Return-Path: <linux-fsdevel+bounces-12891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDC8683EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405881C2487B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE517135418;
	Mon, 26 Feb 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOco68Oc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DD132C09;
	Mon, 26 Feb 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987410; cv=none; b=IC8Turo5vvUAxKH3twGNbypcgLC89YPnx2eeQo05P3ImV0G8ZQsLdx6RXBGH9QSPtPKISzv0zGD0WqVTTC//VdzTrEu0Y7uQLlyH3YhTNRoZkNkQm+QuYT3M3fLCc6ahNnCJsioWvebUm8ABfWvz7auMvelLft9k6ANHRSiJ6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987410; c=relaxed/simple;
	bh=lZO496usxRZc4uLXOrLSsGfI9A7Y3eJcpNSY/9wvdTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIKb+paP5Z/RQLdElswcW3HHmfUn8knPe+YbjsvgGEbLVTQTxnkqvBtqdJokNbqEPktgENyEbiQyX5UKb8p2V83kQUXpZJiIf4kBcMLGaBTq9Fr2C32TLRvd6LQv/74Pw5N3sgGb+Utgago52NGNotseOgN3tzlABzd9dkz1Ctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOco68Oc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22007fe465bso926033fac.1;
        Mon, 26 Feb 2024 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708987407; x=1709592207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUPmDk09/sTy9Hx2AnE6xr34od72PSugc7feC6111Fo=;
        b=ZOco68Ocod7WdLh1iUd5Q5MtS5M0djusP4y+mrSP7VEubqe9EJdeuLucBiPgRceeTj
         WQKIwARzmaguugZDwZLtt+Vj5181JGb9XzZcpmj7wr3+1XndV6KUI/UeKEU+n91xAd+j
         Z43W43wLE7cM62lSiBF/93syQU+zko6vitVR0F4ItoJ9+EORHKxC5JMKUaJbHFNXLv1b
         a4MGhLT+SoUgtxLtSPlFZT/uMnUZuQx834Tkn+mxUKNks5CB0GREnqG4H7jl2adzXnXY
         +/lZg8Mgu7niI696eGNb1+MI6McfQSLgjEmy8QwA8/0A32J48AlZyCA+qShFp9jdClxB
         lfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987407; x=1709592207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUPmDk09/sTy9Hx2AnE6xr34od72PSugc7feC6111Fo=;
        b=LsFjt9rn7mxzsva4GZYJV9gtrQ6HQlbg9JuvcBNWDdui5BruAi3K0bbmjE+KHT55dz
         y/ztMZff3t1t6gKifKgz6RByRW5iYvs8+rjwSBmm07mLgMtSsOxseRra1EczcMyxKiYl
         citA/uZF6AoWhhUGUFSKRAEDQTDpO8//M2GoqFXLxo0tVrrTv335Wi6wvVDw3tRgVKRo
         krD1DdTtSLN6GF0HyJVYlML/jAk2IA4twMatx7c++waNmCWG16519rNeZLq/6OhGJuoN
         8BgwF7sq2E70pdNzbChxBwZA/ibV7dMVqLldv4atVL8DyigDgbYvMr6ga0RPl1d/qvR5
         Krmg==
X-Forwarded-Encrypted: i=1; AJvYcCUXRplfXdZPuMSyLqA6fiWAODZwreFFGEK4rABkIubKlUub4NJaEe54JbBziGSoxzuIXMzjRi0qJtW6Zpeg1qfmPj4WfDTcZB4CgxRm/h/mmA3JhUdBnoegq9mLOjKd/sP1H0SLVYPEmX2QHXtVlBqdkbDv711JvaFZvgM45GVsGeM4BPjfcyhHdPHjRRutp16XSd2bDy6K090cvBFS7MKcCA==
X-Gm-Message-State: AOJu0YxLxI+Heme8OFFd9aikCjx5jf5hh7K1Cp6kEs8KhlK4Honf4D4B
	kGbHOQ7PGhWbyLdr+xAiaO+uV7fQI7SS+F4eDtXn1i/qUAu7+Wnv9PbXp19ixdM=
X-Google-Smtp-Source: AGHT+IEoZRM885tJ3SKMed/vEAVoJO38AS5Hl87/35VAcOvt6F3arFNSsmi3/j7xjKGIzHYaoLT4dg==
X-Received: by 2002:a05:6870:b253:b0:21f:642:5240 with SMTP id b19-20020a056870b25300b0021f06425240mr9200382oam.31.1708987407360;
        Mon, 26 Feb 2024 14:43:27 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id er1-20020a0568303c0100b006e34506c5e5sm1280715otb.57.2024.02.26.14.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:43:27 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 16:43:25 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Message-ID: <5aw6k6rcnpj7ukps7jcjlj2creqa4aalnesukgdi4nmjqccfg7@7l7rvtzwpjha>
References: <cover.1708709155.git.john@groves.net>
 <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
 <20240226132019.00007b8c@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226132019.00007b8c@Huawei.com>

On 24/02/26 01:20PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:55 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This commit introduces the famfs fs_context_operations and
> > famfs_get_inode() which is used by the context operations.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> Trivial comments inline.
> 
> > ---
> >  fs/famfs/famfs_inode.c | 178 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 178 insertions(+)
> > 
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > index 82c861998093..f98f82962d7b 100644
> > --- a/fs/famfs/famfs_inode.c
> > +++ b/fs/famfs/famfs_inode.c
> > @@ -41,6 +41,50 @@ static const struct super_operations famfs_ops;
> >  static const struct inode_operations famfs_file_inode_operations;
> >  static const struct inode_operations famfs_dir_inode_operations;
> >  
> > +static struct inode *famfs_get_inode(
> > +	struct super_block *sb,
> > +	const struct inode *dir,
> > +	umode_t             mode,
> > +	dev_t               dev)
> > +{
> > +	struct inode *inode = new_inode(sb);
> > +
> > +	if (inode) {
> reverse logic would be simpler and reduce indent.
> 
> 	if (!inode)
> 		return NULL;
> 

Good one - I can be derpy this way. Although I'd bet I just copied that
from ramfs...

> 
> > +		struct timespec64       tv;
> > +
> > +		inode->i_ino = get_next_ino();
> > +		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> > +		inode->i_mapping->a_ops = &ram_aops;
> > +		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> > +		mapping_set_unevictable(inode->i_mapping);
> > +		tv = inode_set_ctime_current(inode);
> > +		inode_set_mtime_to_ts(inode, tv);
> > +		inode_set_atime_to_ts(inode, tv);
> > +
> > +		switch (mode & S_IFMT) {
> > +		default:
> > +			init_special_inode(inode, mode, dev);
> > +			break;
> > +		case S_IFREG:
> > +			inode->i_op = &famfs_file_inode_operations;
> > +			inode->i_fop = &famfs_file_operations;
> > +			break;
> > +		case S_IFDIR:
> > +			inode->i_op = &famfs_dir_inode_operations;
> > +			inode->i_fop = &simple_dir_operations;
> > +
> > +			/* Directory inodes start off with i_nlink == 2 (for "." entry) */
> > +			inc_nlink(inode);
> > +			break;
> > +		case S_IFLNK:
> > +			inode->i_op = &page_symlink_inode_operations;
> > +			inode_nohighmem(inode);
> > +			break;
> > +		}
> > +	}
> > +	return inode;
> > +}
> > +
> >  /**********************************************************************************
> >   * famfs super_operations
> >   *
> > @@ -150,6 +194,140 @@ famfs_open_device(
> >  	return 0;
> >  }
> >  
> > +/*****************************************************************************************
> > + * fs_context_operations
> > + */
> > +static int
> > +famfs_fill_super(
> > +	struct super_block *sb,
> > +	struct fs_context  *fc)
> > +{
> > +	struct famfs_fs_info *fsi = sb->s_fs_info;
> > +	struct inode *inode;
> > +	int rc = 0;
> Always initialized so no need to do it here.

Fixed in more than one place.

> 
> > +
> > +	sb->s_maxbytes		= MAX_LFS_FILESIZE;
> > +	sb->s_blocksize		= PAGE_SIZE;
> > +	sb->s_blocksize_bits	= PAGE_SHIFT;
> > +	sb->s_magic		= FAMFS_MAGIC;
> > +	sb->s_op		= &famfs_ops;
> > +	sb->s_time_gran		= 1;
> > +
> > +	rc = famfs_open_device(sb, fc);
> > +	if (rc)
> > +		goto out;
> 		return rc; //unless you need to do more in out in later patch..

Done

> 
> > +
> > +	inode = famfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
> > +	sb->s_root = d_make_root(inode);
> > +	if (!sb->s_root)
> > +		rc = -ENOMEM;
> 		return -ENOMEM;

Done

> 
> 	return 0;

Done

> 
> > +
> > +out:
> > +	return rc;
> > +}
> > +
> > +enum famfs_param {
> > +	Opt_mode,
> > +	Opt_dax,
> Why capital O?

Direct copy from ramfs

> 
> > +};
> > +
> 
> ...
> 
> > +
> > +static DEFINE_MUTEX(famfs_context_mutex);
> > +static LIST_HEAD(famfs_context_list);
> > +
> > +static int famfs_get_tree(struct fs_context *fc)
> > +{
> > +	struct famfs_fs_info *fsi_entry;
> > +	struct famfs_fs_info *fsi = fc->s_fs_info;
> > +
> > +	fsi->rootdev = kstrdup(fc->source, GFP_KERNEL);
> > +	if (!fsi->rootdev)
> > +		return -ENOMEM;
> > +
> > +	/* Fail if famfs is already mounted from the same device */
> > +	mutex_lock(&famfs_context_mutex);
> 
> New toys might be good to use from start to avoid need for explicit
> unlocks in error paths.
> 
> 	scoped_guard(mutex, &famfs_context_mutex) {
> 		list_for_each_entry(fsi_entry, &famfs_context_list, fsi_list) {
> 			if (strcmp(fsi_entry->rootdev, cs_source) == 0) {
> 			//could invert with a continue to reduce indent
> 			// or factor this out as a little helper.
> 			// famfs_check_not_mounted()
> 				pr_err();
> 				return -EALREADY;
> 			}
> 		}	
> 		list_add(&fsi->fs_list, &famfs_context_list);
> 	}
> 
> 	return get_tree_nodev(...

Hey, I like this one. Thanks!

John


