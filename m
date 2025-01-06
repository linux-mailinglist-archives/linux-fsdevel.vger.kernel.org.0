Return-Path: <linux-fsdevel+bounces-38464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13BA02F31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFB3A3404
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50021DF279;
	Mon,  6 Jan 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc/tb42i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4C1DF255;
	Mon,  6 Jan 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185208; cv=none; b=UrjzArtd7Vg3R2+rWVZY5qhmAVPP1WUVESknQbvV7H2KN+P0baysnTjN75G9C3qZbR2qU1e1B7DDs6uYmO/TRzUoylFVc+FSn8540hOAIM3VOAWP67hFWYXKqsV0wj/TucEFp5DndbQXoLSWMmDzS0dkF9ul3tq+0zByitpfDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185208; c=relaxed/simple;
	bh=7W9pHS4PWpd3SS1uQabJP+wUkjf2TzWY9fHvfJnEDBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwCCgswDQemtfCZJMo94yNOMLT6IBSNvuTnV8ceIs63dwINQH+eknBAkCsg4aZFsRWrSGLhy67veJ3WgOh8Kl8N8IYjVVHCrkGiaNNrH8/FrvZPaB9XbQ3IdeTxkt5M6rXvpgZccv9acpKl8Hyiyn3REbsvM7NpqMr3GHVI2JFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc/tb42i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C2C4CEDF;
	Mon,  6 Jan 2025 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736185207;
	bh=7W9pHS4PWpd3SS1uQabJP+wUkjf2TzWY9fHvfJnEDBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fc/tb42iPn0lxr2eEBP3jvwUDRYAFIuzsdptqvVQXGhb1+AQg5hoK/FZKbLuXSg6x
	 4xTbVpdRz+reXHWcrcHaipcXpJakO8v5b1JEs2R4nXCH0Nc0iKBwPc1opwUj+hxYXW
	 shkfeyPwDriIwgAXrCLLtajilkTxZMsWGQfPuTRWea0V8Uf3BWtbnJeVhCEKPH17lM
	 PHkRmohJYstf1VQO8OtR9xJtYY2dLfaXDTVhOhSk0J6LD7/ZceKhenRUhKBlSIlSby
	 KsTOA3gN3OyFRLOWJZyYSeA2Fl0CZhP+boljKiR24cc0maB61rupC7iAMRoaJgfdU4
	 rBq0ir5dO8a4w==
Date: Mon, 6 Jan 2025 09:40:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <20250106174007.GD6174@frogsfrogsfrogs>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151938.GA27324@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151938.GA27324@lst.de>

On Mon, Jan 06, 2025 at 04:19:38PM +0100, Christoph Hellwig wrote:
> Document the new STATX_DIO_READ_ALIGN flag and the new
> stx_dio_read_offset_align field guarded by it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  man/man2/statx.2 | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index c5b5a28ec2f1..378bf363d93f 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -76,6 +76,9 @@ struct statx {
>      __u32 stx_atomic_write_unit_min;
>      __u32 stx_atomic_write_unit_max;
>      __u32 stx_atomic_write_segments_max;
> +
> +    /* File offset alignment for direct I/O reads */
> +    __u32   stx_dio_read_offset_align;
>  };
>  .EE
>  .in
> @@ -261,7 +264,7 @@ STATX_BTIME	Want stx_btime
>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  	It is deprecated and should not be used.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> -STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> +STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align.
>  	(since Linux 6.1; support varies by filesystem)
>  STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>  STATX_SUBVOL	Want stx_subvol
> @@ -270,6 +273,8 @@ STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
>  	stx_atomic_write_unit_max,
>  	and stx_atomic_write_segments_max.
>  	(since Linux 6.11; support varies by filesystem)
> +STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
> +	(since Linux 6.14; support varies by filesystem)
>  .TE
>  .in
>  .P
> @@ -467,6 +472,26 @@ This will only be nonzero if
>  .I stx_dio_mem_align
>  is nonzero, and vice versa.
>  .TP
> +.I stx_dio_read_offset_align
> +The alignment (in bytes) required for file offsets and I/O segment lengths for
> +direct I/O reads
> +.RB ( O_DIRECT )
> +on this file.  If zero the limit in

manpage nit: new sentences should start on a new line.

> +.I
> +stx_dio_offset_align
> +applies for reads as well.  If non-zero this value must be

Here too.

> +smaller than
> +.I
> +stx_dio_offset_align
> +which must be provided by the file system.

I can't imagine a filesystem where dio_read_offset > dio_offset makes
sense, but why do we need to put that in the manpage?

vs. "If non-zero, the filesystem must also provide stx_dio_offset_align."

> +This value does not affect the memory alignent in

                                         alignment

> +.I stx_dio_mem_align .
> +.IP
> +.B STATX_DIO_READ_ALIGN
> +.I ( stx_dio_offset_align )
> +support by filesystem;
> +it is supported by xfs since Linux 6.14.

Aside from those bits, this looks good to me.

--D

> +.TP
>  .I stx_subvol
>  Subvolume number of the current file.
>  .IP
> -- 
> 2.45.2
> 
> 

