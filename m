Return-Path: <linux-fsdevel+bounces-73360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3770FD162AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C7E3029B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24626F2A6;
	Tue, 13 Jan 2026 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCZliYtd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49ECE55A;
	Tue, 13 Jan 2026 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267752; cv=none; b=sSpYxvue/rZRABxYwB/pjAz35ufz6IDn50bvPWcbpD/X/C1m8BD22oOBwBcFrMsxB7JwDG3df69Y6QJdvvN0eE1XG4SYy+qKVATqq+k/nU7GSyrsCFxmbrrfZWxK51QgVCV7rB1j/hLyEDePdrKIp4dDi05AAQ9cQNaZUr9e5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267752; c=relaxed/simple;
	bh=DpgrUEd9OSo4sZ0rvcGangN0ViInRL3ZVT23ypzGXbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARm+f3K45cp34SYskPG+2rJWt5OVAv8Mh3kbVhaowOy63Rxu0tCprGeZQnWHYglaRVAUSSVKuI90Rcjk6EF9l66XnFekEuzjllBfgD3zobHRTALl55SaUCYLflFnuaeoDaPaxj7MFesLyepV2XkvtnIJJrdWJmJlYWQwzQPcsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCZliYtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F0BC116D0;
	Tue, 13 Jan 2026 01:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768267752;
	bh=DpgrUEd9OSo4sZ0rvcGangN0ViInRL3ZVT23ypzGXbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCZliYtdkY0R2zYkZMa7Qzj3qsw+biOnl5XA7RZSTYPkXsklrna6za+gy9Cif/A+k
	 cSggH8UBjXs8KwC41fJSwznHVx7/GrLtwF2QASmt3e2galk4i0KneBPWyJtwB0M3Gm
	 /ftCk6qnHuhS228LlZC6zpW6CnAsm79UxUCIDDl3IVFXDhRd22vDBJ9Qk0x5r3x8R3
	 zYCtoWl68nLYK56fcZx4pfY7nwpVv/TTN8QbGmcn3OcRDvV7U1xdZrLXiH2g2npVJc
	 Di1bS+aBwOZobtzpX13Nrygic/8yxorx0bp7pG92ZV1AZI6m5hLXyrz5CUN8UeM/04
	 A+uifafO2qVuA==
Date: Mon, 12 Jan 2026 17:29:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Darrick J. Wong" <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 1/22] fsverity: report validation errors back to the
 filesystem
Message-ID: <20260113012911.GU15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <dx6z2f5lrnevosqoqr4a2aa5bmxldmishn6ln22hvdkuxxmjqa@rddd4kri6bce>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dx6z2f5lrnevosqoqr4a2aa5bmxldmishn6ln22hvdkuxxmjqa@rddd4kri6bce>

> To: "Darrick J. Wong" <aalbersh@redhat.com>

Say    ^^^^^^^ what?

On Mon, Jan 12, 2026 at 03:49:50PM +0100, Darrick J. Wong wrote:
> Provide a new function call so that validation errors can be reported
> back to the filesystem.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/verity/verify.c              |  4 ++++
>  include/linux/fsverity.h        | 14 ++++++++++++++
>  include/trace/events/fsverity.h | 19 +++++++++++++++++++
>  3 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 47a66f088f..ef411cf5d8 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -271,6 +271,10 @@
>  		data_pos, level - 1, params->hash_alg->name, hsize, want_hash,
>  		params->hash_alg->name, hsize,
>  		level == 0 ? dblock->real_hash : real_hash);
> +	trace_fsverity_file_corrupt(inode, data_pos, params->block_size);
> +	if (inode->i_sb->s_vop->file_corrupt)
> +		inode->i_sb->s_vop->file_corrupt(inode, data_pos,
> +						 params->block_size);

If fserror_report[1] gets merged before this series, I think we should
add a new FSERR_ type and call fserror_report instead.

https://lore.kernel.org/linux-fsdevel/176826402610.3490369.4378391061533403171.stgit@frogsfrogsfrogs/T/#u

--D

>  error:
>  	for (; level > 0; level--) {
>  		kunmap_local(hblocks[level - 1].addr);
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 5bc7280425..b75e232890 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -128,6 +128,20 @@
>  	 */
>  	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
>  				       u64 pos, unsigned int size);
> +
> +	/**
> +	 * Notify the filesystem that file data is corrupt.
> +	 *
> +	 * @inode: the inode being validated
> +	 * @pos: the file position of the invalid data
> +	 * @len: the length of the invalid data
> +	 *
> +	 * This function is called when fs-verity detects that a portion of a
> +	 * file's data is inconsistent with the Merkle tree, or a Merkle tree
> +	 * block needed to validate the data is inconsistent with the level
> +	 * above it.
> +	 */
> +	void (*file_corrupt)(struct inode *inode, loff_t pos, size_t len);
>  };
>  
>  #ifdef CONFIG_FS_VERITY
> diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
> index dab220884b..375fdddac6 100644
> --- a/include/trace/events/fsverity.h
> +++ b/include/trace/events/fsverity.h
> @@ -137,6 +137,25 @@
>  		__entry->hidx)
>  );
>  
> +TRACE_EVENT(fsverity_file_corrupt,
> +	TP_PROTO(const struct inode *inode, loff_t pos, size_t len),
> +	TP_ARGS(inode, pos, len),
> +	TP_STRUCT__entry(
> +		__field(ino_t, ino)
> +		__field(loff_t, pos)
> +		__field(size_t, len)
> +	),
> +	TP_fast_assign(
> +		__entry->ino = inode->i_ino;
> +		__entry->pos = pos;
> +		__entry->len = len;
> +	),
> +	TP_printk("ino %lu pos %llu len %zu",
> +		(unsigned long) __entry->ino,
> +		__entry->pos,
> +		__entry->len)
> +);
> +
>  #endif /* _TRACE_FSVERITY_H */
>  
>  /* This part must be outside protection */
> 
> -- 
> - Andrey
> 
> 

