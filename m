Return-Path: <linux-fsdevel+bounces-71685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA78CCD4BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5AD83076E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758530C600;
	Thu, 18 Dec 2025 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMh/0YQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E6309DDD;
	Thu, 18 Dec 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083553; cv=none; b=J5HQqr030q7JEGmdPx7KAyTWL8i86PSEEYYBpxN9kHyXFSFj7dB2SVGSdOlf6QDuKHOEADznXJ5nC8ymUS/Q08x1L6XgQ65nLgpGRBHAxX/cjjmxlXf4Oz0ijdzaDKX6tmHnezIMLk1XIeV7E5rymPZJBy/2QSb3/NT8yN+A1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083553; c=relaxed/simple;
	bh=zFjLw9KZ+5ZqYTiLA/RGdxGqLp3uTd1STpOGPgAjqgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hip08/Z31BioKoChMbqZOrtDMoPamOM3gwtczQxwjeOgP6Jxx1u/B6TATo+rIalY6sZS86vRgbRSTqPGbNANN5NfZod/8ReK8YF8Nx+9wy3afCx2S75LNmsoM8Iomr6Aw5T+EkbVGRKKF2VhWLj+kRp7l9pzP5CDcKr7aP2TlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMh/0YQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43213C113D0;
	Thu, 18 Dec 2025 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766083553;
	bh=zFjLw9KZ+5ZqYTiLA/RGdxGqLp3uTd1STpOGPgAjqgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMh/0YQXEKdCwrKHFEHvOu+K+BNHYbtTOBdsueDtZHcFPThSSNBst26Gs2TScTxlF
	 tj99TJVzjqC+kxia8TJRVl3a2n5joCMmP35fXCYV2kERS/oIr+NUMLDUVfjNq6Ax0O
	 nFa5MMVL8FT0SNQ267l3jBzXDHUelpOBjJc9+HOTGu+1gApS4OBCF1dVNnMcWLABDb
	 p9gfd82ZQivmfz3PrlLll+LZcNpY9Mno7FZET+XdYoTrrrbX9/5ysHJLBIS2Bgt8aV
	 Hy/AmqJNfMuQf1T2oKPEGEX2qkEFoyON6X3wUblQHB0lGJUI7JY705vv1m8SbpZNnq
	 g3a7mzSi1Jg0g==
Date: Thu, 18 Dec 2025 10:45:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH 1/6] uapi: promote EFSCORRUPTED and EUCLEAN to errno.h
Message-ID: <20251218184552.GY7725@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332146.686273.6355079912638580915.stgit@frogsfrogsfrogs>
 <aUOOW9z3K5ff-531@infradead.org>
 <vffjgmklao4a7cb7r7nky7umh2pdyvzdpv4hzi5j3j5lgxxwsp@6phylpwucm2k>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vffjgmklao4a7cb7r7nky7umh2pdyvzdpv4hzi5j3j5lgxxwsp@6phylpwucm2k>

On Thu, Dec 18, 2025 at 12:04:11PM +0100, Alejandro Colomar wrote:
> Hi Christoph,
> 
> On Wed, Dec 17, 2025 at 09:17:15PM -0800, Christoph Hellwig wrote:
> > On Wed, Dec 17, 2025 at 06:02:56PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Stop definining these privately and instead move them to the uapi
> > > errno.h so that they become canonical instead of copy pasta.
> > 
> > Sounds fine:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Do we need to document these overlay errnos in the man man pages,
> > though?
> 
> I'd say yes.  errno(3) is where these are documented.  Thanks for CCing.

I'll send a manpage update, thanks!

--D

> 
> Have a lovely day!
> Alex
> 
> > 
> > > 
> > > Cc: linux-api@vger.kernel.org
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  arch/alpha/include/uapi/asm/errno.h        |    2 ++
> > >  arch/mips/include/uapi/asm/errno.h         |    2 ++
> > >  arch/parisc/include/uapi/asm/errno.h       |    2 ++
> > >  arch/sparc/include/uapi/asm/errno.h        |    2 ++
> > >  fs/erofs/internal.h                        |    2 --
> > >  fs/ext2/ext2.h                             |    1 -
> > >  fs/ext4/ext4.h                             |    3 ---
> > >  fs/f2fs/f2fs.h                             |    3 ---
> > >  fs/minix/minix.h                           |    2 --
> > >  fs/udf/udf_sb.h                            |    2 --
> > >  fs/xfs/xfs_linux.h                         |    2 --
> > >  include/linux/jbd2.h                       |    3 ---
> > >  include/uapi/asm-generic/errno.h           |    2 ++
> > >  tools/arch/alpha/include/uapi/asm/errno.h  |    2 ++
> > >  tools/arch/mips/include/uapi/asm/errno.h   |    2 ++
> > >  tools/arch/parisc/include/uapi/asm/errno.h |    2 ++
> > >  tools/arch/sparc/include/uapi/asm/errno.h  |    2 ++
> > >  tools/include/uapi/asm-generic/errno.h     |    2 ++
> > >  18 files changed, 20 insertions(+), 18 deletions(-)
> > > 
> > > 
> > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
> > > index 3d265f6babaf0a..6791f6508632ee 100644
> > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > @@ -55,6 +55,7 @@
> > >  #define	ENOSR		82	/* Out of streams resources */
> > >  #define	ETIME		83	/* Timer expired */
> > >  #define	EBADMSG		84	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EPROTO		85	/* Protocol error */
> > >  #define	ENODATA		86	/* No data available */
> > >  #define	ENOSTR		87	/* Device not a stream */
> > > @@ -96,6 +97,7 @@
> > >  #define	EREMCHG		115	/* Remote address changed */
> > >  
> > >  #define	EUCLEAN		117	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		118	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		119	/* No XENIX semaphores available */
> > >  #define	EISNAM		120	/* Is a named type file */
> > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
> > > index 2fb714e2d6d8fc..c01ed91b1ef44b 100644
> > > --- a/arch/mips/include/uapi/asm/errno.h
> > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > @@ -50,6 +50,7 @@
> > >  #define EDOTDOT		73	/* RFS specific error */
> > >  #define EMULTIHOP	74	/* Multihop attempted */
> > >  #define EBADMSG		77	/* Not a data message */
> > > +#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define ENAMETOOLONG	78	/* File name too long */
> > >  #define EOVERFLOW	79	/* Value too large for defined data type */
> > >  #define ENOTUNIQ	80	/* Name not unique on network */
> > > @@ -88,6 +89,7 @@
> > >  #define EISCONN		133	/* Transport endpoint is already connected */
> > >  #define ENOTCONN	134	/* Transport endpoint is not connected */
> > >  #define EUCLEAN		135	/* Structure needs cleaning */
> > > +#define EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define ENOTNAM		137	/* Not a XENIX named type file */
> > >  #define ENAVAIL		138	/* No XENIX semaphores available */
> > >  #define EISNAM		139	/* Is a named type file */
> > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
> > > index 8d94739d75c67c..8cbc07c1903e4c 100644
> > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > @@ -36,6 +36,7 @@
> > >  
> > >  #define	EDOTDOT		66	/* RFS specific error */
> > >  #define	EBADMSG		67	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EUSERS		68	/* Too many users */
> > >  #define	EDQUOT		69	/* Quota exceeded */
> > >  #define	ESTALE		70	/* Stale file handle */
> > > @@ -62,6 +63,7 @@
> > >  #define	ERESTART	175	/* Interrupted system call should be restarted */
> > >  #define	ESTRPIPE	176	/* Streams pipe error */
> > >  #define	EUCLEAN		177	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		178	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		179	/* No XENIX semaphores available */
> > >  #define	EISNAM		180	/* Is a named type file */
> > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
> > > index 81a732b902ee38..4a41e7835fd5b8 100644
> > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > @@ -48,6 +48,7 @@
> > >  #define	ENOSR		74	/* Out of streams resources */
> > >  #define	ENOMSG		75	/* No message of desired type */
> > >  #define	EBADMSG		76	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EIDRM		77	/* Identifier removed */
> > >  #define	EDEADLK		78	/* Resource deadlock would occur */
> > >  #define	ENOLCK		79	/* No record locks available */
> > > @@ -91,6 +92,7 @@
> > >  #define	ENOTUNIQ	115	/* Name not unique on network */
> > >  #define	ERESTART	116	/* Interrupted syscall should be restarted */
> > >  #define	EUCLEAN		117	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		118	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		119	/* No XENIX semaphores available */
> > >  #define	EISNAM		120	/* Is a named type file */
> > > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > index f7f622836198da..d06e99baf5d5ae 100644
> > > --- a/fs/erofs/internal.h
> > > +++ b/fs/erofs/internal.h
> > > @@ -541,6 +541,4 @@ long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> > >  long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> > >  			unsigned long arg);
> > >  
> > > -#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> > > -
> > >  #endif	/* __EROFS_INTERNAL_H */
> > > diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> > > index cf97b76e9fd3e9..5e0c6c5fcb6cd6 100644
> > > --- a/fs/ext2/ext2.h
> > > +++ b/fs/ext2/ext2.h
> > > @@ -357,7 +357,6 @@ struct ext2_inode {
> > >   */
> > >  #define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
> > >  #define	EXT2_ERROR_FS			0x0002	/* Errors detected */
> > > -#define	EFSCORRUPTED			EUCLEAN	/* Filesystem is corrupted */
> > >  
> > >  /*
> > >   * Mount flags
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 56112f201cace7..62c091b52bacdf 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -3938,7 +3938,4 @@ extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> > >  				  get_block_t *get_block);
> > >  #endif	/* __KERNEL__ */
> > >  
> > > -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> > > -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> > > -
> > >  #endif	/* _EXT4_H */
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 20edbb99b814a7..9f3aa3c7f12613 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -5004,7 +5004,4 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
> > >  	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
> > >  }
> > >  
> > > -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> > > -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> > > -
> > >  #endif /* _LINUX_F2FS_H */
> > > diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> > > index 2bfaf377f2086c..7e1f652f16d311 100644
> > > --- a/fs/minix/minix.h
> > > +++ b/fs/minix/minix.h
> > > @@ -175,6 +175,4 @@ static inline int minix_test_bit(int nr, const void *vaddr)
> > >  	__minix_error_inode((inode), __func__, __LINE__,	\
> > >  			    (fmt), ##__VA_ARGS__)
> > >  
> > > -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> > > -
> > >  #endif /* FS_MINIX_H */
> > > diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> > > index 08ec8756b9487b..8399accc788dea 100644
> > > --- a/fs/udf/udf_sb.h
> > > +++ b/fs/udf/udf_sb.h
> > > @@ -55,8 +55,6 @@
> > >  #define MF_DUPLICATE_MD		0x01
> > >  #define MF_MIRROR_FE_LOADED	0x02
> > >  
> > > -#define EFSCORRUPTED EUCLEAN
> > > -
> > >  struct udf_meta_data {
> > >  	__u32	s_meta_file_loc;
> > >  	__u32	s_mirror_file_loc;
> > > diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> > > index 4dd747bdbccab2..55064228c4d574 100644
> > > --- a/fs/xfs/xfs_linux.h
> > > +++ b/fs/xfs/xfs_linux.h
> > > @@ -121,8 +121,6 @@ typedef __u32			xfs_nlink_t;
> > >  
> > >  #define ENOATTR		ENODATA		/* Attribute not found */
> > >  #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
> > > -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> > > -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> > >  
> > >  #define __return_address __builtin_return_address(0)
> > >  
> > > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > > index f5eaf76198f377..a53a00d36228ce 100644
> > > --- a/include/linux/jbd2.h
> > > +++ b/include/linux/jbd2.h
> > > @@ -1815,7 +1815,4 @@ static inline int jbd2_handle_buffer_credits(handle_t *handle)
> > >  
> > >  #endif	/* __KERNEL__ */
> > >  
> > > -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> > > -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> > > -
> > >  #endif	/* _LINUX_JBD2_H */
> > > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> > > index cf9c51ac49f97e..92e7ae493ee315 100644
> > > --- a/include/uapi/asm-generic/errno.h
> > > +++ b/include/uapi/asm-generic/errno.h
> > > @@ -55,6 +55,7 @@
> > >  #define	EMULTIHOP	72	/* Multihop attempted */
> > >  #define	EDOTDOT		73	/* RFS specific error */
> > >  #define	EBADMSG		74	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EOVERFLOW	75	/* Value too large for defined data type */
> > >  #define	ENOTUNIQ	76	/* Name not unique on network */
> > >  #define	EBADFD		77	/* File descriptor in bad state */
> > > @@ -98,6 +99,7 @@
> > >  #define	EINPROGRESS	115	/* Operation now in progress */
> > >  #define	ESTALE		116	/* Stale file handle */
> > >  #define	EUCLEAN		117	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		118	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		119	/* No XENIX semaphores available */
> > >  #define	EISNAM		120	/* Is a named type file */
> > > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
> > > index 3d265f6babaf0a..6791f6508632ee 100644
> > > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > > @@ -55,6 +55,7 @@
> > >  #define	ENOSR		82	/* Out of streams resources */
> > >  #define	ETIME		83	/* Timer expired */
> > >  #define	EBADMSG		84	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EPROTO		85	/* Protocol error */
> > >  #define	ENODATA		86	/* No data available */
> > >  #define	ENOSTR		87	/* Device not a stream */
> > > @@ -96,6 +97,7 @@
> > >  #define	EREMCHG		115	/* Remote address changed */
> > >  
> > >  #define	EUCLEAN		117	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		118	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		119	/* No XENIX semaphores available */
> > >  #define	EISNAM		120	/* Is a named type file */
> > > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
> > > index 2fb714e2d6d8fc..c01ed91b1ef44b 100644
> > > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > > @@ -50,6 +50,7 @@
> > >  #define EDOTDOT		73	/* RFS specific error */
> > >  #define EMULTIHOP	74	/* Multihop attempted */
> > >  #define EBADMSG		77	/* Not a data message */
> > > +#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define ENAMETOOLONG	78	/* File name too long */
> > >  #define EOVERFLOW	79	/* Value too large for defined data type */
> > >  #define ENOTUNIQ	80	/* Name not unique on network */
> > > @@ -88,6 +89,7 @@
> > >  #define EISCONN		133	/* Transport endpoint is already connected */
> > >  #define ENOTCONN	134	/* Transport endpoint is not connected */
> > >  #define EUCLEAN		135	/* Structure needs cleaning */
> > > +#define EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define ENOTNAM		137	/* Not a XENIX named type file */
> > >  #define ENAVAIL		138	/* No XENIX semaphores available */
> > >  #define EISNAM		139	/* Is a named type file */
> > > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
> > > index 8d94739d75c67c..8cbc07c1903e4c 100644
> > > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > > @@ -36,6 +36,7 @@
> > >  
> > >  #define	EDOTDOT		66	/* RFS specific error */
> > >  #define	EBADMSG		67	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EUSERS		68	/* Too many users */
> > >  #define	EDQUOT		69	/* Quota exceeded */
> > >  #define	ESTALE		70	/* Stale file handle */
> > > @@ -62,6 +63,7 @@
> > >  #define	ERESTART	175	/* Interrupted system call should be restarted */
> > >  #define	ESTRPIPE	176	/* Streams pipe error */
> > >  #define	EUCLEAN		177	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		178	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		179	/* No XENIX semaphores available */
> > >  #define	EISNAM		180	/* Is a named type file */
> > > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
> > > index 81a732b902ee38..4a41e7835fd5b8 100644
> > > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > > @@ -48,6 +48,7 @@
> > >  #define	ENOSR		74	/* Out of streams resources */
> > >  #define	ENOMSG		75	/* No message of desired type */
> > >  #define	EBADMSG		76	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EIDRM		77	/* Identifier removed */
> > >  #define	EDEADLK		78	/* Resource deadlock would occur */
> > >  #define	ENOLCK		79	/* No record locks available */
> > > @@ -91,6 +92,7 @@
> > >  #define	ENOTUNIQ	115	/* Name not unique on network */
> > >  #define	ERESTART	116	/* Interrupted syscall should be restarted */
> > >  #define	EUCLEAN		117	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		118	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		119	/* No XENIX semaphores available */
> > >  #define	EISNAM		120	/* Is a named type file */
> > > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
> > > index cf9c51ac49f97e..92e7ae493ee315 100644
> > > --- a/tools/include/uapi/asm-generic/errno.h
> > > +++ b/tools/include/uapi/asm-generic/errno.h
> > > @@ -55,6 +55,7 @@
> > >  #define	EMULTIHOP	72	/* Multihop attempted */
> > >  #define	EDOTDOT		73	/* RFS specific error */
> > >  #define	EBADMSG		74	/* Not a data message */
> > > +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
> > >  #define	EOVERFLOW	75	/* Value too large for defined data type */
> > >  #define	ENOTUNIQ	76	/* Name not unique on network */
> > >  #define	EBADFD		77	/* File descriptor in bad state */
> > > @@ -98,6 +99,7 @@
> > >  #define	EINPROGRESS	115	/* Operation now in progress */
> > >  #define	ESTALE		116	/* Stale file handle */
> > >  #define	EUCLEAN		117	/* Structure needs cleaning */
> > > +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
> > >  #define	ENOTNAM		118	/* Not a XENIX named type file */
> > >  #define	ENAVAIL		119	/* No XENIX semaphores available */
> > >  #define	EISNAM		120	/* Is a named type file */
> > > 
> > > 
> > ---end quoted text---
> > 
> 
> -- 
> <https://www.alejandro-colomar.es>



