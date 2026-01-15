Return-Path: <linux-fsdevel+bounces-73899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A95D2325F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6052C302413C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCF333755;
	Thu, 15 Jan 2026 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q12ytVWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4F333441;
	Thu, 15 Jan 2026 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465788; cv=none; b=MujFx1E0rDryzhljzYmp4SO+3S8i3KqcPehcUD4I2hceyORt45eRWLdpX8oQQYTLTHbmty1YZX/pYxaq+/DW1QscgPGbPYDvuWMM5CNtX/1HDjNsGpGF00EQm6A2cXAZzVu1V9ELY1Xf8VrX2IeWB4ncFqTflpgsNrAn6Kf+jlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465788; c=relaxed/simple;
	bh=R14DaZGFpUHZtfwpnZ4r6zV65WrZFacicwafJAAUhi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbBNphbWeM9ZX+rviXn5W4KYlHhs6GCDmnylsdoHYkgTvDOuLggG9U2HTRA2OfkfAveqfkjkJmF8dXjC8S4x1qpsEVioQpy2VJde05ce3toAXAcKFhMNV1C8AgO7Q+lk5Jw8XI4adBn+C7RduhLOdG6bVBcQ9/ir+vl0e5Qa5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q12ytVWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A2C116D0;
	Thu, 15 Jan 2026 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465787;
	bh=R14DaZGFpUHZtfwpnZ4r6zV65WrZFacicwafJAAUhi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q12ytVWRB/0h7GDBzmyz96GYbtpCYfuDB6mEovp08L88s5lkn+FSy9Ht+kimtsdnN
	 mi4/mmYSNPdJspu5E/BB0NNx79CBCacFyIEG32pUQD855YoYv46vW5EgzWLWJf0ytI
	 KNY0KrjzCnkLgU5cpZHiGEGJmZiNjGwLLE8i7g84cV1btC11xxx335cRe2pbfv1Yhy
	 zmc6dMQgcYXcQdEmgUM8rDh/I53s7XQPHjjsynnoAp/7hUcTmPxKX6xcE5KfQb8vgj
	 kCmTFroVDvF5ZfhlerkVmeLgGqOwQ6n3cPnrGi6lH87Yqy9xwOZGlG0+cUosUv1j+o
	 qsBojF262UC2Q==
Date: Thu, 15 Jan 2026 09:29:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jan Kara <jack@suse.cz>, 
	vira@imap.suse.de, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, almaz.alexandrovich@paragon-software.com, 
	Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	Theodore Tso <tytso@mit.edu>, adilger.kernel@dilger.ca, Carlos Maiolino <cem@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 01/16] fs: Add case sensitivity info to file_kattr
Message-ID: <20260115-mitgift-crashtest-35039325f65c@brauner>
References: <20260114142900.3945054-1-cel@kernel.org>
 <20260114142900.3945054-2-cel@kernel.org>
 <3kq2tbdcoxxw3y2gseg7vtnhnze5ee536fu4rnsn22yjrpsmb4@fpfueqqiji5q>
 <7b6aa90f-79dc-443a-8e5f-3c9b88892271@app.fastmail.com>
 <20260114200130.GJ15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114200130.GJ15551@frogsfrogsfrogs>

On Wed, Jan 14, 2026 at 12:01:30PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 02:01:14PM -0500, Chuck Lever wrote:
> > 
> > 
> > On Wed, Jan 14, 2026, at 1:11 PM, Jan Kara wrote:
> > > On Wed 14-01-26 09:28:44, Chuck Lever wrote:
> > >> From: Chuck Lever <chuck.lever@oracle.com>
> > >> 
> > >> Enable upper layers such as NFSD to retrieve case sensitivity
> > >> information from file systems by adding case_insensitive and
> > >> case_nonpreserving boolean fields to struct file_kattr.
> > >> 
> > >> These fields default to false (POSIX semantics: case-sensitive and
> > >> case-preserving), allowing filesystems to set them only when
> > >> behavior differs from the default.
> > >> 
> > >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ...
> > >> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > >> index 66ca526cf786..07286d34b48b 100644
> > >> --- a/include/uapi/linux/fs.h
> > >> +++ b/include/uapi/linux/fs.h
> > >> @@ -229,10 +229,20 @@ struct file_attr {
> > >>  	__u32 fa_nextents;	/* nextents field value (get)   */
> > >>  	__u32 fa_projid;	/* project identifier (get/set) */
> > >>  	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
> > >> +	/* VER1 additions: */
> > >> +	__u32 fa_case_behavior;	/* case sensitivity (get) */
> > >> +	__u32 fa_reserved;
> > >>  };
> > >>  
> > >>  #define FILE_ATTR_SIZE_VER0 24
> > >> -#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
> > >> +#define FILE_ATTR_SIZE_VER1 32
> > >> +#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
> > >> +
> > >> +/*
> > >> + * Case sensitivity flags for fa_case_behavior
> > >> + */
> > >> +#define FS_CASE_INSENSITIVE	0x00000001	/* case-insensitive lookups */
> > >> +#define FS_CASE_NONPRESERVING	0x00000002	/* case not preserved */
> > >
> > > This is a matter of taste so not sure what others think about it but
> > > file_attr already have fa_xflags field and there is already one flag which
> > > doesn't directly correspond to on-disk representation (FS_XFLAG_HASATTR) so
> > > we could also put the two new flags in there... I have hard time imagining
> > > fa_case_behavior would grow past the two flags you've introduced so u32
> > > seems a bit wasteful.
> > 
> > No problem. I'll wait for additional guidance on this.
> 
> Sounds like a better use of space in struct file_attr than adding
> another pair of u32.

Fine by me as well.

