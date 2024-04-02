Return-Path: <linux-fsdevel+bounces-15907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C9B8959CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CF41C21EEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E8159216;
	Tue,  2 Apr 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsMtpuIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F9158213;
	Tue,  2 Apr 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075694; cv=none; b=jYRgzuBlaHUq449ivPZhys4RHz63XTuXptFVe+Y6ZBkI/c44HK6kVgHUZ5IP/KmFqd5bcd4NbBO1bRBRKymz3IDk47v6i+P7s0Xwgon7eRPR3744yIA065GqiK7cth0yWZPIncbND8BJMegHWY33AyELqU0rgjqnZ+CGjdLdT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075694; c=relaxed/simple;
	bh=8RQgzWJzCRGU76BM/vjXZlTKCA5dVVCGOQKb1wbLXf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPkJIl33FHA0eVerWJy53QvUtVC1IuNmbZQ2V6lMdrw3jjfJ4i2Xx9p4PyUQPnp6/VGI/Jzi5s1dt0sJjbmmhBgcmkhnlKgnKd03kLXyyHeoTKzXOdKBI7n3BmUj+KRgJMaIvzbU6J+DIXXtLte1PV5JZ12eo7GLlB6bffJBzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsMtpuIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC86CC433C7;
	Tue,  2 Apr 2024 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712075693;
	bh=8RQgzWJzCRGU76BM/vjXZlTKCA5dVVCGOQKb1wbLXf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsMtpuICuEzb+vhFt9IzpFSDiHF40gkIcr317aS/qKiC0P9PqjAyB72zzlX6ppUsi
	 4xLA12sd/ooOqs90u8k8+IyQNlKw0pX1RnoFn31wh5dO/bXlPfmD5dzvaEf0TZU30C
	 ZSXs/ytAIEPxFQYx5ES/NOXeJM6CMt04ExssC6KeZV5EaDa9klhN9tGixhw31cEJj7
	 lDP4emOJSFXaF0pwDMGFZQMxKXc9O1VMH4zGRaZDJXQVH6QxRjtJCv8k9VDYeYKX7M
	 JhFN64So8KcIZn9XR+JIQg/zUdbNlfxvKimAXKcC3DRSylSkbt+KpX2iD9pJjyIiZE
	 Z6APgpmnuL+gQ==
Date: Tue, 2 Apr 2024 09:34:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	hch@infradead.org
Subject: Re: [PATCH 13/29] xfs: add fs-verity support
Message-ID: <20240402163453.GB6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868775.1988170.1235485201931301190.stgit@frogsfrogsfrogs>
 <r72bz6xc5h2iz2jko35mcfdxs7etgznywv25hfovyv24rvvv4q@jrxihodinndr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r72bz6xc5h2iz2jko35mcfdxs7etgznywv25hfovyv24rvvv4q@jrxihodinndr>

On Tue, Apr 02, 2024 at 10:42:44AM +0200, Andrey Albershteyn wrote:
> On 2024-03-29 17:39:27, Darrick J. Wong wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Add integration with fs-verity. The XFS store fs-verity metadata in
> > the extended file attributes. The metadata consist of verity
> > descriptor and Merkle tree blocks.
> > 
> > The descriptor is stored under "vdesc" extended attribute. The
> > Merkle tree blocks are stored under binary indexes which are offsets
> > into the Merkle tree.
> > 
> > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > flag is set meaning that the Merkle tree is being build. The
> > initialization ends with storing of verity descriptor and setting
> > inode on-disk flag (XFS_DIFLAG2_VERITY).
> > 
> > The verification on read is done in read path of iomap.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > [djwong: replace caching implementation with an xarray, other cleanups]
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/Makefile               |    2 
> >  fs/xfs/libxfs/xfs_attr.c      |   41 +++
> >  fs/xfs/libxfs/xfs_attr.h      |    1 
> >  fs/xfs/libxfs/xfs_da_format.h |   14 +
> >  fs/xfs/libxfs/xfs_ondisk.h    |    3 
> >  fs/xfs/libxfs/xfs_verity.c    |   58 ++++
> >  fs/xfs/libxfs/xfs_verity.h    |   13 +
> >  fs/xfs/xfs_fsverity.c         |  559 +++++++++++++++++++++++++++++++++++++++++
> >  fs/xfs/xfs_fsverity.h         |   20 +
> >  fs/xfs/xfs_icache.c           |    4 
> >  fs/xfs/xfs_inode.h            |    5 
> >  fs/xfs/xfs_super.c            |   17 +
> >  fs/xfs/xfs_trace.h            |   32 ++
> >  13 files changed, 769 insertions(+)
> >  create mode 100644 fs/xfs/libxfs/xfs_verity.c
> >  create mode 100644 fs/xfs/libxfs/xfs_verity.h
> >  create mode 100644 fs/xfs/xfs_fsverity.c
> >  create mode 100644 fs/xfs/xfs_fsverity.h
> > 
> > 

<snip>

> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index 5a202706fc4a4..70c5700132b3e 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -96,6 +96,9 @@ typedef struct xfs_inode {
> >  	spinlock_t		i_ioend_lock;
> >  	struct work_struct	i_ioend_work;
> >  	struct list_head	i_ioend_list;
> > +#ifdef CONFIG_FS_VERITY
> > +	struct xarray		i_merkle_blocks;
> > +#endif
> 
> So, is this fine like this or do you plan to change it to per-ag
> mapping? I suppose Christoph against adding it to inodes [1]
> 
> [1]: https://lore.kernel.org/linux-xfs/ZfecSzBoVDW5328l@infradead.org/

Still working on it.  hch and I have been nitpicking the parent pointers
patchset.  I think a per-ag rhashtable would work in principle, but I
don't know how well it will handle a 128-bit key.

--D

> >  } xfs_inode_t;
> >  
> >  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> > @@ -391,6 +394,8 @@ static inline bool xfs_inode_needs_cow_around(struct xfs_inode *ip)
> >   */
> >  #define XFS_IREMAPPING		(1U << 15)
> >  
> > +#define XFS_VERITY_CONSTRUCTION	(1U << 16) /* merkle tree construction */
> > +
> >  /* All inode state flags related to inode reclaim. */
> >  #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
> >  				 XFS_IRECLAIM | \
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 42a1e1f23d3b3..4e398884c46ae 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -30,6 +30,7 @@
> >  #include "xfs_filestream.h"
> >  #include "xfs_quota.h"
> >  #include "xfs_sysfs.h"
> > +#include "xfs_fsverity.h"
> >  #include "xfs_ondisk.h"
> >  #include "xfs_rmap_item.h"
> >  #include "xfs_refcount_item.h"
> > @@ -53,6 +54,7 @@
> >  #include <linux/fs_context.h>
> >  #include <linux/fs_parser.h>
> >  #include <linux/fsverity.h>
> > +#include <linux/iomap.h>
> >  
> >  static const struct super_operations xfs_super_operations;
> >  
> > @@ -672,6 +674,8 @@ xfs_fs_destroy_inode(
> >  	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> >  	XFS_STATS_INC(ip->i_mount, vn_rele);
> >  	XFS_STATS_INC(ip->i_mount, vn_remove);
> > +	if (fsverity_active(inode))
> > +		xfs_fsverity_cache_drop(ip);
> >  	fsverity_cleanup_inode(inode);
> >  	xfs_inode_mark_reclaimable(ip);
> >  }
> > @@ -1534,6 +1538,9 @@ xfs_fs_fill_super(
> >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> >  #endif
> >  	sb->s_op = &xfs_super_operations;
> > +#ifdef CONFIG_FS_VERITY
> > +	sb->s_vop = &xfs_fsverity_ops;
> > +#endif
> >  
> >  	/*
> >  	 * Delay mount work if the debug hook is set. This is debug
> > @@ -1775,10 +1782,20 @@ xfs_fs_fill_super(
> >  		xfs_warn(mp,
> >  	"EXPERIMENTAL parent pointer feature enabled. Use at your own risk!");
> >  
> > +	if (xfs_has_verity(mp))
> > +		xfs_alert(mp,
> > +	"EXPERIMENTAL fsverity feature in use. Use at your own risk!");
> > +
> >  	error = xfs_mountfs(mp);
> >  	if (error)
> >  		goto out_filestream_unmount;
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +	error = iomap_init_fsverity(mp->m_super);
> > +	if (error)
> > +		goto out_unmount;
> > +#endif
> > +
> >  	root = igrab(VFS_I(mp->m_rootip));
> >  	if (!root) {
> >  		error = -ENOENT;
> > diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> > index e2992b0115ad2..86a8702c1e27c 100644
> > --- a/fs/xfs/xfs_trace.h
> > +++ b/fs/xfs/xfs_trace.h
> > @@ -5908,6 +5908,38 @@ TRACE_EVENT(xfs_growfs_check_rtgeom,
> >  );
> >  #endif /* CONFIG_XFS_RT */
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +DECLARE_EVENT_CLASS(xfs_fsverity_cache_class,
> > +	TP_PROTO(struct xfs_inode *ip, unsigned long key, unsigned long caller_ip),
> > +	TP_ARGS(ip, key, caller_ip),
> > +	TP_STRUCT__entry(
> > +		__field(dev_t, dev)
> > +		__field(xfs_ino_t, ino)
> > +		__field(unsigned long, key)
> > +		__field(void *, caller_ip)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->dev = ip->i_mount->m_super->s_dev;
> > +		__entry->ino = ip->i_ino;
> > +		__entry->key = key;
> > +		__entry->caller_ip = (void *)caller_ip;
> > +	),
> > +	TP_printk("dev %d:%d ino 0x%llx key 0x%lx caller %pS",
> > +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		  __entry->ino,
> > +		  __entry->key,
> > +		  __entry->caller_ip)
> > +)
> > +
> > +#define DEFINE_XFS_FSVERITY_CACHE_EVENT(name) \
> > +DEFINE_EVENT(xfs_fsverity_cache_class, name, \
> > +	TP_PROTO(struct xfs_inode *ip, unsigned long key, unsigned long caller_ip), \
> > +	TP_ARGS(ip, key, caller_ip))
> > +DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_load);
> > +DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_store);
> > +DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_drop);
> > +#endif /* CONFIG_XFS_VERITY */
> > +
> >  #endif /* _TRACE_XFS_H */
> >  
> >  #undef TRACE_INCLUDE_PATH
> > 
> 
> -- 
> - Andrey
> 
> 

