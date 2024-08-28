Return-Path: <linux-fsdevel+bounces-27705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA99963676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC39B21348
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5E1AC459;
	Wed, 28 Aug 2024 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC81/Reh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE24D16CD32;
	Wed, 28 Aug 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889150; cv=none; b=srypaxDUYiGHSN6lonzyu1WYGhTGzmrXi0VPwk9/zsCJMFjdDPsmlLC3lJ3iqUqYOM9EjZE74KUfG7HEtIRQy3SjlH6lLHOOJXr03XX66SaolDitJ395kyIgZpj2mSSsNWgBboU7lBpLIE8XmsJJaN7B1yRzF2X7ZOjKXIU/SUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889150; c=relaxed/simple;
	bh=9Cn5zgF08teqjN1yl3pfC4JjsBYn6aKJCtMX7STasc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXv4jBQnq585NR2Mo7Z2JQTWXHkquFxnv/ocwzK4lYkWvap3d79RRvsMUbL2PPeu8q/TpD0J2md4HYb6db2y/c01s2e35xjZEIBk3cnt5Sqop47c6RmVLVu5dCSZxIatHvXOF2I/uug1QDQ101s2vfU4NIP2yuP4SwWTbqgsYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC81/Reh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BDDC4CEC0;
	Wed, 28 Aug 2024 23:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724889149;
	bh=9Cn5zgF08teqjN1yl3pfC4JjsBYn6aKJCtMX7STasc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jC81/RehKEr3dq7VhVsMtOSxmECo3gWllzFBzUynQUgJx5lyC9cfBQ+Xxr8xO+Psg
	 w4aBStMkVtN12EHw9j5CWzfm4GISwqppo08HNCq3itpIxsrpmfMIk9wCxbxpwPCQmP
	 vFjfnCl53SHJ98dmJyEOh2fLgfomewYPKpTxYT2Gb0qsaGeXgNaQV84k7WVX4TWPu3
	 iSyqToh7EekwJ9PnPj+n5fsSnNmkD0JFYTgJege0R/XTQzZ8BJqBPovEfLl5Scz0pS
	 9wKBQbFiJ9NjWhI/AS+IWmFl1XP4qRD6951/rIvPh8HR4jQQLjZqU//PwwC6SvFMns
	 S1toNIULVztzw==
Date: Wed, 28 Aug 2024 23:52:27 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: add STATX_DIO_READ_ALIGN
Message-ID: <20240828235227.GB558903@google.com>
References: <20240828051149.1897291-1-hch@lst.de>
 <20240828051149.1897291-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828051149.1897291-3-hch@lst.de>

On Wed, Aug 28, 2024 at 08:11:02AM +0300, Christoph Hellwig wrote:
> Add a separate dio read align field, as many out of place write
> file systems can easily do reads aligned to the device sector size,
> but require bigger alignment for writes.
> 
> This is usually papered over by falling back to buffered I/O for smaller
> writes and doing read-modify-write cycles, but performance for this
> sucks, so applications benefit from knowing the actual write alignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/stat.c                 | 1 +
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 89ce1be563108c..044e7ad9f3abc2 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -700,6 +700,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_mnt_id = stat->mnt_id;
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
> +	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
>  	tmp.stx_subvol = stat->subvol;
>  	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
>  	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 3d900c86981c5b..9d8382e23a9c69 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -52,6 +52,7 @@ struct kstat {
>  	u64		mnt_id;
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
> +	u32		dio_read_offset_align;
>  	u64		change_cookie;
>  	u64		subvol;
>  	u32		atomic_write_unit_min;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 8b35d7d511a287..f78ee3670dd5d7 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -179,7 +179,8 @@ struct statx {
>  	/* Max atomic write segment count */
>  	__u32   stx_atomic_write_segments_max;
>  
> -	__u32   __spare1[1];
> +	/* File offset alignment for direct I/O reads */
> +	__u32	stx_dio_read_offset_align;
>  
>  	/* 0xb8 */
>  	__u64	__spare3[9];	/* Spare space for future expansion */
> @@ -213,6 +214,7 @@ struct statx {
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
>  #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
> +#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */

Thanks.  We maybe should have included read/write separation in STATX_DIOALIGN,
but at the time the only case that was brought up was "DIO reads are supported
but DIO writes are not" which people had argued was not useful.

Is this patch meant to support that case, or just the case where DIO in both
directions is supported but with different alignments?  Is that different file
offset alignments, different memory alignments, or both?  This patch doesn't add
a stx_dio_read_mem_align field, so it's still assumed that both directions share
the existing stx_dio_mem_align property, including whether DIO is supported at
all (0 vs. nonzero).  So as proposed, the only case it helps with is where DIO
in both directions is supported with the same memory alignment but different
file offset alignments.  Maybe that is intended, but it's not clear to me.

Are there specific userspace applications that would like to take advantage of a
smaller value of stx_dio_read_offset_align compared to the existing
stx_dio_offset_align?  Even in the case of a discrepancy between reads and
writes, applications are supposed to be able to just use stx_dio_offset_align
since it has to be the greater of the two alignments.

And as always, new UAPIs need to be accompanied by documentation.  In this case
that's an update to the statx man page.

- Eric

