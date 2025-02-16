Return-Path: <linux-fsdevel+bounces-41800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229DA37760
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B99188C44A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FE1A2645;
	Sun, 16 Feb 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onRtvIBa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F009454;
	Sun, 16 Feb 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739736093; cv=none; b=sczrTrK7+JX6FBokWYDbIKkF1Vch3gPaPm8R5AqiAh64Sfdvvgp9ZPwwvXE65YLBV5HOKCBCeaCstq1FDV8AsrXh0sbxOLZPX3e50XJOkRIwF2ZQwJxMosXh6Vko60cPYmors/hFGs7KDcw0qysKm3ueCsz9SVW9BJW9dJm6Aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739736093; c=relaxed/simple;
	bh=qBy2DhLIZ21h8sdk9tM9KzC/1HZUyZ4ScPhxIsQ/QPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0AoqsFqe3kUjFy4XpNlMzXwP8CfGHM/gm1uFsxEARUUW3P3D6PIe3sORQBr4AXk6H2JR5rpPaY7jeSEcyfelP3uQuE0ndCd1BALUL+vsv8IbNuAB+Zy8o/xyOWoPQK5mL+KRSej8SgvX9tD/sYB4Ks/CZy+SfA+pzeJ4wlP7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onRtvIBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB00C4CEDD;
	Sun, 16 Feb 2025 20:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739736093;
	bh=qBy2DhLIZ21h8sdk9tM9KzC/1HZUyZ4ScPhxIsQ/QPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onRtvIBanmi1rThKz/t/Atsf/IAVOZBsmHETDiSvXA0EQqN0soMLet39WuIf3oeK6
	 9h7cJ2e4yaDeEi2Z15XzQE/isbB6df6vjlGyFsUkx3mTOVEkh33Jex++2vqCMvM/p7
	 qvi+p8EnNynUNypYDROHuGbqlG00MomZkYyb7C3lYw6rtjUM4dHuEuhQtRpnaKoZGP
	 Ee/ySPFotKS73o5dmT+F8r/KJ+b/f49D5JQD5jI6FvnWkw+mLGK0XnyO66sXmkToeq
	 lbZ7p4ItHjg6BUWsn6fd0joP3qdWoRPjoOLb9b9OQqBBgJnhfPZOiV1muB+nyVpwiT
	 k3y6PkFBo4IJw==
Received: by pali.im (Postfix)
	id 52F277FD; Sun, 16 Feb 2025 21:01:20 +0100 (CET)
Date: Sun, 16 Feb 2025 21:01:20 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] fs: Extend FS_IOC_FS[GS]ETXATTR API for Windows
 attributes
Message-ID: <20250216200120.svl6w3vko7tdgedo@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-3-pali@kernel.org>
 <CAOQ4uxi0saGQYF5qgCKWu_mLNg8FZBHqZu3TvnqpY8v8Hmq-nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi0saGQYF5qgCKWu_mLNg8FZBHqZu3TvnqpY8v8Hmq-nQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Sunday 16 February 2025 20:55:09 Amir Goldstein wrote:
> On Sun, Feb 16, 2025 at 5:42 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > struct fsxattr has 8 reserved padding bytes. Use these bytes for defining
> > new fields fsx_xflags2, fsx_xflags2_mask and fsx_xflags_mask in backward
> > compatible manner. If the new FS_XFLAG_HASEXTFIELDS flag in fsx_xflags is
> > not set then these new fields are treated as not present, like before this
> > change.
> >
> > New field fsx_xflags_mask for SET operation specifies which flags in
> > fsx_xflags are going to be changed. This would allow userspace application
> > to change just subset of all flags. For GET operation this field specifies
> > which FS_XFLAG_* flags are supported by the file.
> >
> > New field fsx_xflags2 specify new flags FS_XFLAG2_* which defines some of
> > Windows FILE_ATTRIBUTE_* attributes, which are mostly not going to be
> > interpreted or used by the kernel, and are mostly going to be used by
> > userspace. Field fsx_xflags2_mask then specify mask for them.
> >
> > This change defines just API without filesystem support for them. These
> > attributes can be implemented later for Windows filesystems like FAT, NTFS,
> > exFAT, UDF, SMB, NFS4 which all native storage for those attributes (or at
> > least some subset of them).
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  include/uapi/linux/fs.h | 36 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 367bc5289c47..93e947d6e604 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -145,15 +145,26 @@ struct fsxattr {
> >         __u32           fsx_nextents;   /* nextents field value (get)   */
> >         __u32           fsx_projid;     /* project identifier (get/set) */
> >         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > -       unsigned char   fsx_pad[8];
> > +       __u16           fsx_xflags2;    /* xflags2 field value (get/set)*/
> > +       __u16           fsx_xflags2_mask;/*mask for xflags2 (get/set)*/
> > +       __u32           fsx_xflags_mask;/* mask for xflags (get/set)*/
> > +       /*
> > +        * For FS_IOC_FSSETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_mask
> > +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags from fsx_xflags
> > +        * and fsx_xflags2 fields are going to be changed.
> > +        *
> > +        * For FS_IOC_FSGETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_mask
> > +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags are supported.
> > +        */
> >  };
> >
> >  /*
> > - * Flags for the fsx_xflags field
> > + * Flags for the fsx_xflags and fsx_xflags_mask fields
> >   */
> >  #define FS_XFLAG_REALTIME      0x00000001      /* data in realtime volume */
> >  #define FS_XFLAG_PREALLOC      0x00000002      /* preallocated file extents */
> > -#define FS_XFLAG_IMMUTABLE     0x00000008      /* file cannot be modified */
> > +#define FS_XFLAG_IMMUTABLEUSER 0x00000004      /* file cannot be modified, changing this bit does not require CAP_LINUX_IMMUTABLE, equivalent of Windows FILE_ATTRIBUTE_READONLY */
> 
> So why not call it FS_XFLAG2_READONLY? IDGI

Just because to show that these two flags are similar, just one is for
root (or CAP_LINUX_IMMUTABLE) and another is for normal user.

For example FreeBSD has also both flags (one for root and one for user)
and uses names SF_IMMUTABLE and UF_IMMUTABLE.

For me having FS_XFLAG_IMMUTABLE and FS_XFLAG2_READONLY sounds less
clear, and does not explain how these two flags differs.

> Does anyone think that FS_XFLAG_IMMUTABLEUSER is more clear or something?
> 
> Thanks,
> Amir.
> 
> > +#define FS_XFLAG_IMMUTABLE     0x00000008      /* file cannot be modified, changing this bit requires CAP_LINUX_IMMUTABLE */
> >  #define FS_XFLAG_APPEND                0x00000010      /* all writes append */
> >  #define FS_XFLAG_SYNC          0x00000020      /* all writes synchronous */
> >  #define FS_XFLAG_NOATIME       0x00000040      /* do not update access time */
> > @@ -167,10 +178,25 @@ struct fsxattr {
> >  #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream allocator */
> >  #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
> >  #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size allocator hint */
> > -#define FS_XFLAG_COMPRESSED    0x00020000      /* compressed file */
> > -#define FS_XFLAG_ENCRYPTED     0x00040000      /* encrypted file */
> > +#define FS_XFLAG_COMPRESSED    0x00020000      /* compressed file, equivalent of Windows FILE_ATTRIBUTE_COMPRESSED */
> > +#define FS_XFLAG_ENCRYPTED     0x00040000      /* encrypted file, equivalent of Windows FILE_ATTRIBUTE_ENCRYPTED */
> > +#define FS_XFLAG_CHECKSUMS     0x00080000      /* checksum for data and metadata, equivalent of Windows FILE_ATTRIBUTE_INTEGRITY_STREAM */
> > +#define FS_XFLAG_HASEXTFIELDS  0x40000000      /* fields fsx_xflags_mask, fsx_xflags2 and fsx_xflags2_mask are present */
> >  #define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   */
> >
> > +/*
> > + * Flags for the fsx_xflags2 and fsx_xflags2_mask fields
> > + */
> > +#define FS_XFLAG2_HIDDEN       0x0001  /* inode is hidden, equivalent of Widows FILE_ATTRIBUTE_HIDDEN */
> > +#define FS_XFLAG2_SYSTEM       0x0002  /* inode is part of operating system, equivalent of Windows FILE_ATTRIBUTE_SYSTEM */
> > +#define FS_XFLAG2_ARCHIVE      0x0004  /* inode was not archived yet, equivalent of Windows FILE_ATTRIBUTE_ARCHIVE */
> > +#define FS_XFLAG2_TEMPORARY    0x0008  /* inode content does not have to preserved across reboots, equivalent of Windows FILE_ATTRIBUTE_TEMPORARY */
> > +#define FS_XFLAG2_NOTINDEXED   0x0010  /* inode will not be indexed by content indexing service, equivalent of Windows FILE_ATTRIBUTE_NOT_CONTENT_INDEXED */
> > +#define FS_XFLAG2_NOSCRUBDATA  0x0020  /* file inode will not be checked by scrubber (proactive background data integrity scanner), for directory inode it means that newly created child would have this flag set, equivalent of Windows FILE_ATTRIBUTE_NO_SCRUB_DATA */
> > +#define FS_XFLAG2_OFFLINE      0x0040  /* inode is marked as HSM offline, equivalent of Windows FILE_ATTRIBUTE_OFFLINE */
> > +#define FS_XFLAG2_PINNED       0x0080  /* inode data content must be always stored in local HSM storage, equivalent of Windows FILE_ATTRIBUTE_PINNED */
> > +#define FS_XFLAG2_UNPINNED     0x0100  /* inode data content can be removed from local HSM storage, equivalent of Windows FILE_ATTRIBUTE_UNPINNED */
> > +
> >  /* the read-only stuff doesn't really belong here, but any other place is
> >     probably as bad and I don't want to create yet another include file. */
> >
> > --
> > 2.20.1
> >

