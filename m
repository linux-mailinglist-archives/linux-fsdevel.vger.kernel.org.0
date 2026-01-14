Return-Path: <linux-fsdevel+bounces-73812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33429D21209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234FF304D871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5A352C25;
	Wed, 14 Jan 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBZwUrWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFE25228C;
	Wed, 14 Jan 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420891; cv=none; b=RFLSVhUu0UvB+yLS9GDCCrFTuUdEURPFqBGcc7APjBkD5hE4uKc2IAQOqqG4syhk7FJol68ZqVHqRwAeRhH6jXs+LDKsQ8xVUKYCdLlVhXw0DovuBjAe7uaIixYg9qWGEPFh0mhQjv5dGCCtEPltfiacAZkoXHB5kjkH+Xy8ryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420891; c=relaxed/simple;
	bh=UjkIcWoNSe9/a1EUTFB+7URBpKEndTzvxBxd5f8spV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7IkxCWi/UOMhrhu/KElqhj/5rnUYpl1pxz3j/7oNjAjDrc+8EKZD00NXTjTcYaXzZ6H/gU7JMj0QrasjhqH21S+5hclxQ3a9f0PGO3AaitrJPQl0ikL3nj/8+cBpWy3sCiwabSSNEpvC0539z0hB1VLAvEetynFzZbqQ/Ct3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBZwUrWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F65BC4CEF7;
	Wed, 14 Jan 2026 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420891;
	bh=UjkIcWoNSe9/a1EUTFB+7URBpKEndTzvxBxd5f8spV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBZwUrWpkL7RNu1xJ2TiDEUsEWnQvVHTuq5cXS+8nyD7SG5Fh5ZhgVNWowLeQ7Tc0
	 g+uWq71bqae6Iev8H5mVgUAdPVj+NLr7hR091p+EixtcdjV5G8lXJ/q+b3WomXtG1s
	 bop0BcRwdDYFAunxuihoSnRx/IpWVXMoE5kplK8mCxexB7AWACk2ciiErmZ2uYl3SO
	 LNfFoOGHwpHYIfA6yNzyYLHWioN6voRWLcJbGCv+grQjNJnmLK16A+BVB3sErelXBF
	 HIK6FJc0y+d5AikHOkaA01i2j5Igi01j8vJNeEcBIqQTJGTA1FiFHTT6mECNnRRWMO
	 O1EKRXZzIefcQ==
Date: Wed, 14 Jan 2026 12:01:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, vira@imap.suse.de,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	almaz.alexandrovich@paragon-software.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	Theodore Tso <tytso@mit.edu>, adilger.kernel@dilger.ca,
	Carlos Maiolino <cem@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Hans de Goede <hansg@kernel.org>,
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 01/16] fs: Add case sensitivity info to file_kattr
Message-ID: <20260114200130.GJ15551@frogsfrogsfrogs>
References: <20260114142900.3945054-1-cel@kernel.org>
 <20260114142900.3945054-2-cel@kernel.org>
 <3kq2tbdcoxxw3y2gseg7vtnhnze5ee536fu4rnsn22yjrpsmb4@fpfueqqiji5q>
 <7b6aa90f-79dc-443a-8e5f-3c9b88892271@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6aa90f-79dc-443a-8e5f-3c9b88892271@app.fastmail.com>

On Wed, Jan 14, 2026 at 02:01:14PM -0500, Chuck Lever wrote:
> 
> 
> On Wed, Jan 14, 2026, at 1:11 PM, Jan Kara wrote:
> > On Wed 14-01-26 09:28:44, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> Enable upper layers such as NFSD to retrieve case sensitivity
> >> information from file systems by adding case_insensitive and
> >> case_nonpreserving boolean fields to struct file_kattr.
> >> 
> >> These fields default to false (POSIX semantics: case-sensitive and
> >> case-preserving), allowing filesystems to set them only when
> >> behavior differs from the default.
> >> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ...
> >> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> >> index 66ca526cf786..07286d34b48b 100644
> >> --- a/include/uapi/linux/fs.h
> >> +++ b/include/uapi/linux/fs.h
> >> @@ -229,10 +229,20 @@ struct file_attr {
> >>  	__u32 fa_nextents;	/* nextents field value (get)   */
> >>  	__u32 fa_projid;	/* project identifier (get/set) */
> >>  	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
> >> +	/* VER1 additions: */
> >> +	__u32 fa_case_behavior;	/* case sensitivity (get) */
> >> +	__u32 fa_reserved;
> >>  };
> >>  
> >>  #define FILE_ATTR_SIZE_VER0 24
> >> -#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
> >> +#define FILE_ATTR_SIZE_VER1 32
> >> +#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
> >> +
> >> +/*
> >> + * Case sensitivity flags for fa_case_behavior
> >> + */
> >> +#define FS_CASE_INSENSITIVE	0x00000001	/* case-insensitive lookups */
> >> +#define FS_CASE_NONPRESERVING	0x00000002	/* case not preserved */
> >
> > This is a matter of taste so not sure what others think about it but
> > file_attr already have fa_xflags field and there is already one flag which
> > doesn't directly correspond to on-disk representation (FS_XFLAG_HASATTR) so
> > we could also put the two new flags in there... I have hard time imagining
> > fa_case_behavior would grow past the two flags you've introduced so u32
> > seems a bit wasteful.
> 
> No problem. I'll wait for additional guidance on this.

Sounds like a better use of space in struct file_attr than adding
another pair of u32.

--D

> 
> -- 
> Chuck Lever
> 

