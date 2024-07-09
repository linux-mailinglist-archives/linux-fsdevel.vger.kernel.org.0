Return-Path: <linux-fsdevel+bounces-23449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B592C5CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 23:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530E82817CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C318785C;
	Tue,  9 Jul 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrFdG7XC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541315574D;
	Tue,  9 Jul 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562359; cv=none; b=MbKidno0CmrvHnISKnvt7Ia4GVNiIOM0t9/BstzKcGUAENwQ2rxEL93X+3xJOo+B9jWivlaudQe4uZMYuQ/ohvbChVjxyLGlS5HgqnJNIA3i3mU48wSTI5pdmJKYcGgM4v1mdePR31A4S4G/llvtIEawNCPq9n+ysL1wKbK+U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562359; c=relaxed/simple;
	bh=gJR9+R3Sp+X9MDHtGXK+187J/tLYoRv4pK+2NdBCMnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSNPqeLMBtlFlEHQRNqYGqPFGldnsxvyHU6ynBj/rswHOACx7tNh4/0vfCGwbHME2GKa0ulED/WRO+UIgFuGLmUotMWkWkp7VHywJtoap9EctnJ7KtWteFaXJGF/6pXZuKbzPzV9GcxP4deJkEjKwWE1rLUovntp+ZwpnU9IPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrFdG7XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020D9C3277B;
	Tue,  9 Jul 2024 21:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720562359;
	bh=gJR9+R3Sp+X9MDHtGXK+187J/tLYoRv4pK+2NdBCMnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrFdG7XCGLOOpEaTEEkx5EgR5W6BwnZ8GIaRyOty4hmQqtqicvqzY1kwqdLslE02s
	 i22EOi3o5yGSTgnk6uawtJt4T+ZOnafHgmEvL42BvBb9vZEJn5n2LKOZuhP6kkpAzJ
	 Z9r0t9LGKtG+ywgdW41+VNfHrS+IUsaNbVX0enlYVQY8iu0PRrvqLACUecEx1di9GP
	 R0wX5t5kLiBU5eTS7PDmWusszfqt0PQgnktJ41ka/Kel6cdMHYGwbFEiGUplvAuYLR
	 ttQHNcUnRbBlXGdHjgjyXDP5xBakY3Dg2usV3i2YXcMPMcCU4Xpy4l1Ujs255Ft5BT
	 UgmI0KHTxvhVA==
Date: Tue, 9 Jul 2024 14:59:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	akpm@linux-foundation.org, chandan.babu@oracle.com
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240709215918.GD612460@frogsfrogsfrogs>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <20240709162907.gsd5nf33teoss5ir@quentin>
 <20240709165047.GS1998502@frogsfrogsfrogs>
 <20240709210829.dgm6dsirkry3fgu6@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709210829.dgm6dsirkry3fgu6@quentin>

On Tue, Jul 09, 2024 at 09:08:29PM +0000, Pankaj Raghav (Samsung) wrote:
> > > 
> > > - We make THP an explicit dependency for XFS:
> > > 
> > > diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> > > index d41edd30388b7..be2c1c0e9fe8b 100644
> > > --- a/fs/xfs/Kconfig
> > > +++ b/fs/xfs/Kconfig
> > > @@ -5,6 +5,7 @@ config XFS_FS
> > >         select EXPORTFS
> > >         select LIBCRC32C
> > >         select FS_IOMAP
> > > +       select TRANSPARENT_HUGEPAGE
> > >         help
> > >           XFS is a high performance journaling filesystem which originated
> > >           on the SGI IRIX platform.  It is completely multi-threaded, can
> > > 
> > > OR
> > > 
> > > We create a helper in page cache that FSs can use to check if a specific
> > > order can be supported at mount time:
> > 
> > I like this solution better; if XFS is going to drop support for o[ld]d
> > architectures I think we need /some/ sort of notice period.  Or at least
> > a better story than "we want to support 64k fsblocks on x64 so we're
> > withdrawing support even for 4k fsblocks and smallish filesystems on
> > m68k".
> > 
> > You probably don't want bs>ps support to block on some arcane discussion
> > about 32-bit, right? ;)
> > 
> 
> :)
> 
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index 14e1415f7dcf..9be775ef11a5 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -374,6 +374,14 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
> > >  #define MAX_XAS_ORDER          (XA_CHUNK_SHIFT * 2 - 1)
> > >  #define MAX_PAGECACHE_ORDER    min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
> > >  
> > > +
> > > +static inline unsigned int mapping_max_folio_order_supported()
> > > +{
> > > +    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > > +      return 0;
> > 
> > Shouldn't this line be indented by two tabs, not six spaces?
> > 
> > > +    return MAX_PAGECACHE_ORDER;
> > > +}
> > 
> > Alternately, should this return the max folio size in bytes?
> > 
> > static inline size_t mapping_max_folio_size(void)
> > {
> > 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > 		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> > 	return PAGE_SIZE;
> > }
> 
> We already have mapping_max_folio_size(mapping) which returns the
> maximum folio order set for that mapping. So this could be called as
> mapping_max_folio_size_supported().
> 
> So we could just have mapping_max_folio_size_supported() instead of
> having mapping_max_folio_order_supported as you suggest.

<nod>

> > 
> > Then the validation looks like:
> > 
> > 	const size_t	max_folio_size = mapping_max_folio_size();
> > 
> > 	if (mp->m_sb.sb_blocksize > max_folio_size) {
> > 		xfs_warn(mp,
> >  "block size (%u bytes) not supported; maximum folio size is %u.",
> > 				mp->m_sb.sb_blocksize, max_folio_size);
> > 		error = -ENOSYS;
> > 		goto out_free_sb;
> > 	}
> > 
> > (Don't mind me bikeshedding here.)
> > 
> > > +
> > > 
> > > 
> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index b8a93a8f35cac..e2be8743c2c20 100644
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -1647,6 +1647,15 @@ xfs_fs_fill_super(
> > >                         goto out_free_sb;
> > >                 }
> > >  
> > > +               if (mp->m_sb.sb_blocklog - PAGE_SHIFT >
> > > +                   mapping_max_folio_order_supported()) {
> > > +                       xfs_warn(mp,
> > > +"Block Size (%d bytes) is not supported. Check MAX_PAGECACHE_ORDER",
> > > +                       mp->m_sb.sb_blocksize);
> > 
> > You might as well print MAX_PAGECACHE_ORDER here to make analysis
> > easier on less-familiar architectures:
> 
> Yes!

Thanks.

--D

> > 
> > 			xfs_warn(mp,
> >  "block size (%d bytes) is not supported; max folio size is %u.",
> > 					mp->m_sb.sb_blocksize,
> > 					1U << mapping_max_folio_order_supported());
> > 
> > (I wrote this comment first.)
> 
> > 
> > --D
> > 
> > > +                       error = -ENOSYS;
> > > +                       goto out_free_sb;
> > > +               }
> > > +
> > >                 xfs_warn(mp,
> > >  "EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
> > >                         mp->m_sb.sb_blocksize);
> > > 
> > > 
> > > --
> > > Pankaj
> 

