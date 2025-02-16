Return-Path: <linux-fsdevel+bounces-41807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C997A3779A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 22:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F671167E31
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AF1A23A9;
	Sun, 16 Feb 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da9DLO86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8581E;
	Sun, 16 Feb 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739675; cv=none; b=Ji+ALW6y63fKPXeWRAg07x4cht26pF7PMk9B/rnn8jxujGctsfPbAKxOk5EFUOf+Zg85kCwJUOkgBadkfGmlp6dbu/3mMQ0ePli8cZh8UWO0ToHG+AW9zdhK+vTzIYUxs7BKeCcCp0Uf36tbmwF8GaSjrptt+dR0ZZt/K+3F0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739675; c=relaxed/simple;
	bh=CUGVELtCbw5vQRe5fBVL8hp/VpFQD8LzQmI0y/mIkAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEmTC9qOLSMFFFN+u0mBoZ8r3Tto5JWJmCp548opI13PjHadf60wqeCklU66dPph7phnCptK5cl9guIwHJgKJLUdxXAWbeWG6Z88mvUJ8QC8unRzOwwaZ2OXiwNvpoGwRpFTJENgnLLUTvSb4xIVdk78sh8Op9caH3qfdQzXaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da9DLO86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA55EC4CEDD;
	Sun, 16 Feb 2025 21:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739739675;
	bh=CUGVELtCbw5vQRe5fBVL8hp/VpFQD8LzQmI0y/mIkAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=da9DLO86ZJRB6roU1IO2ZMu1xxMjglLjab87Z0q8vOabBgWZHuRZ44ngjN577OU3G
	 zUlYnLJrVHmLf84CbiQTXOr7MD+FCUlZjZkMtwMoDDy4eVEBDddMz6N32IUsiAKV6t
	 /p4QuwntssVyaG3xhUANCIV/sTMkw7bMZ3skmObYXMRJbMtWNk/GuJRTf9nA0Gb/jf
	 xeGwrKQ+3uHpJGtRP424muJJUz2xrhbg427z0pm9xb823YWQsSDK2xKVR9fxVr/J1p
	 vVMqESBUibEC3z2i6aiUW5+6bZBUMWPxQl6bUPvPzXtlDG0UboJR1kr6gU3VX5z+S4
	 MvChrHDbazPeA==
Received: by pali.im (Postfix)
	id 060E37FD; Sun, 16 Feb 2025 22:01:01 +0100 (CET)
Date: Sun, 16 Feb 2025 22:01:01 +0100
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
Message-ID: <20250216210101.l4d6mm42pyopgrjj@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-3-pali@kernel.org>
 <CAOQ4uxi0saGQYF5qgCKWu_mLNg8FZBHqZu3TvnqpY8v8Hmq-nQ@mail.gmail.com>
 <20250216200120.svl6w3vko7tdgedo@pali>
 <CAOQ4uxi4V0ONe-Sapp8=vncs_F4zOb67_1EpFuydPs7iundZJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi4V0ONe-Sapp8=vncs_F4zOb67_1EpFuydPs7iundZJA@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Sunday 16 February 2025 21:34:42 Amir Goldstein wrote:
> On Sun, Feb 16, 2025 at 9:01 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Sunday 16 February 2025 20:55:09 Amir Goldstein wrote:
> > > On Sun, Feb 16, 2025 at 5:42 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > struct fsxattr has 8 reserved padding bytes. Use these bytes for defining
> > > > new fields fsx_xflags2, fsx_xflags2_mask and fsx_xflags_mask in backward
> > > > compatible manner. If the new FS_XFLAG_HASEXTFIELDS flag in fsx_xflags is
> > > > not set then these new fields are treated as not present, like before this
> > > > change.
> > > >
> > > > New field fsx_xflags_mask for SET operation specifies which flags in
> > > > fsx_xflags are going to be changed. This would allow userspace application
> > > > to change just subset of all flags. For GET operation this field specifies
> > > > which FS_XFLAG_* flags are supported by the file.
> > > >
> > > > New field fsx_xflags2 specify new flags FS_XFLAG2_* which defines some of
> > > > Windows FILE_ATTRIBUTE_* attributes, which are mostly not going to be
> > > > interpreted or used by the kernel, and are mostly going to be used by
> > > > userspace. Field fsx_xflags2_mask then specify mask for them.
> > > >
> > > > This change defines just API without filesystem support for them. These
> > > > attributes can be implemented later for Windows filesystems like FAT, NTFS,
> > > > exFAT, UDF, SMB, NFS4 which all native storage for those attributes (or at
> > > > least some subset of them).
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  include/uapi/linux/fs.h | 36 +++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 31 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > index 367bc5289c47..93e947d6e604 100644
> > > > --- a/include/uapi/linux/fs.h
> > > > +++ b/include/uapi/linux/fs.h
> > > > @@ -145,15 +145,26 @@ struct fsxattr {
> > > >         __u32           fsx_nextents;   /* nextents field value (get)   */
> > > >         __u32           fsx_projid;     /* project identifier (get/set) */
> > > >         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > > > -       unsigned char   fsx_pad[8];
> > > > +       __u16           fsx_xflags2;    /* xflags2 field value (get/set)*/
> > > > +       __u16           fsx_xflags2_mask;/*mask for xflags2 (get/set)*/
> > > > +       __u32           fsx_xflags_mask;/* mask for xflags (get/set)*/
> > > > +       /*
> > > > +        * For FS_IOC_FSSETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_mask
> > > > +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags from fsx_xflags
> > > > +        * and fsx_xflags2 fields are going to be changed.
> > > > +        *
> > > > +        * For FS_IOC_FSGETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_mask
> > > > +        * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags are supported.
> > > > +        */
> > > >  };
> > > >
> > > >  /*
> > > > - * Flags for the fsx_xflags field
> > > > + * Flags for the fsx_xflags and fsx_xflags_mask fields
> > > >   */
> > > >  #define FS_XFLAG_REALTIME      0x00000001      /* data in realtime volume */
> > > >  #define FS_XFLAG_PREALLOC      0x00000002      /* preallocated file extents */
> > > > -#define FS_XFLAG_IMMUTABLE     0x00000008      /* file cannot be modified */
> > > > +#define FS_XFLAG_IMMUTABLEUSER 0x00000004      /* file cannot be modified, changing this bit does not require CAP_LINUX_IMMUTABLE, equivalent of Windows FILE_ATTRIBUTE_READONLY */
> > >
> > > So why not call it FS_XFLAG2_READONLY? IDGI
> >
> > Just because to show that these two flags are similar, just one is for
> > root (or CAP_LINUX_IMMUTABLE) and another is for normal user.
> >
> > For example FreeBSD has also both flags (one for root and one for user)
> > and uses names SF_IMMUTABLE and UF_IMMUTABLE.
> >
> > For me having FS_XFLAG_IMMUTABLE and FS_XFLAG2_READONLY sounds less
> > clear, and does not explain how these two flags differs.
> >
> 
> Yes, I understand, but I do not agree.
> 
> What is your goal here?
> 
> Do you want to implement FreeBSD UF_IMMUTABLE?
> maybe UF_APPEND as well?
> Did anyone ask for this functionality?
> Not that I know of.

None of those.

> The requirement is to implement an API to the functionality known
> as READONLY in SMB and NTFS. Right?

Yes. But Linux is already calling this functionality as "immutable", not
as "readonly". That is why I thought that using existing name is better
than inventing a new name for some existing functionality.

> TBH, I did not study the semantics of READONLY, but I had a
> strong feeling that if we looked closely, we will find that other things are
> possible to do with READONLY files that are not possible with IMMUTABLE
> files. So I asked ChatGPT and it told me that all these can be changed:
> 1. File Attributes (Hidden, System, Archive, or Indexed).
> 2. Permissions (ACL - Access Control List)
> 3. Timestamps
> 4. Alternate Data Streams (ADS)
> 
> I do not know if ChatGPT is correct

Do not trust ChatGPT.

Modification of main data stream (= file content) or alternate data
streams is not possible.

Changing of file or extended attributes is possible.
Timestamp is a file attribute. xattrs are extended attributes.

About ACL I was not sure. But now I tried it and changing ACL is
possible even with readonly attribute set.

So 1. 2. and 3. is possible to change. 4. not.

> but it also told me that a READONLY
> file can be deleted (without removing the flag first).

That is wrong. File cannot be deleted if the READONLY attribute is set.
You first need to clear the READONLY flag. This is one of the main point
of READONLY attribute.

For example cifs.ko for unlink syscall issue SMB removal and if it is
failing due to readonly attribute, it clears it and try removal again.

> This is very very far from what IS_IMMUTABLE is.
> IS_IMMUTABLE is immutable to any metadata change.

I was always looking at this readonly attribute as IMMUTABLE as it
prevents modification of file content and prevents unlinking the file.

For me it was always very similar to immutable. But if you think that
changing ACL and file/extended attributes is the reason why it should
not be called immutable, then I'm fine. Maybe it needs better
documentation and explanation what each of those two flags can and
cannot do.

> Thanks,
> Amir.

