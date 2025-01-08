Return-Path: <linux-fsdevel+bounces-38666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D456A0635C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 18:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92703A70C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FDE200BBE;
	Wed,  8 Jan 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWS/oUo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50E1FF7D5;
	Wed,  8 Jan 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357263; cv=none; b=nYP8e5C+n7oXaMHJFXEeKzrDXytsSa0jl3izveTdYGC5Rz1RdoE8b4SwYusOGiAQ0Ei8EYwp74GxhzE6cEP2vcsALkgJGsZuuB7jHM2YKXVPLzQgpC3kLXiPG/Leg8TXO6/CEP65aTJcvk2yniMrMC39GqpUJehALZvo9VfVAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357263; c=relaxed/simple;
	bh=Fd/ChOXqWXSLL6ad01QK9TB9XaT+4qZHk5d/62xJaSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4tYYOqsHJ8mwi04pLtUGE2+T/NEYkkc89gSFeEOyu9tFdggxrVedFnNWFZFzJALEbmKfu3PBeYRCpuJ+PSBK3HoaSK87HibVfY3LSCt9J4yEWOmL9kKJhQioFWCjMuU4eWUikQK0n9rauG5wQFt5izrUuA8kNsC65DTeN38D3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWS/oUo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B0EC4CED3;
	Wed,  8 Jan 2025 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736357262;
	bh=Fd/ChOXqWXSLL6ad01QK9TB9XaT+4qZHk5d/62xJaSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWS/oUo+z1iZbbqIThQJ9SY8CG3ds2ucVWo0LaCtoRXf3hL6b3B3/r4+AxCRvB4nm
	 N16ORCVDFJLZUuOxPdk/8MbFS9qJ5UopEHQGvNVrQd0BPvIN+J7D6FbY8AxD8XHfVR
	 H+xnuwtP0ls3E5fO08XEaz7QoFtMKhMPnyMrLIVvjjpOsFQRKFbATRXiTHqAh0QTx1
	 dDeViBKg/XM0JnYj0OnGBMRygkTlX3+d4bCo5rz667lhmCC+28rLA00IlPLbNpu0o6
	 j1qx7vP2gKJ+PuN9hs67LCWGX0zn5gsDZWgRnx7Vg1gH6c+BwT2bbzuAlJ/fIaz34V
	 FvcV7xcrOq1Ng==
Date: Wed, 8 Jan 2025 09:27:42 -0800
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
Message-ID: <20250108172742.GH1306365@frogsfrogsfrogs>
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085900.GA27227@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108085900.GA27227@lst.de>

On Wed, Jan 08, 2025 at 09:59:00AM +0100, Christoph Hellwig wrote:
> Document the new STATX_DIO_READ_ALIGN flag and the new
> stx_dio_read_offset_align field guarded by it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  man/man2/statx.2 | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index c5b5a28ec2f1..8ef6a1cfb1c0 100644
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
> @@ -467,6 +472,25 @@ This will only be nonzero if
>  .I stx_dio_mem_align
>  is nonzero, and vice versa.
>  .TP
> +.I stx_dio_read_offset_align
> +The alignment (in bytes) required for file offsets and I/O segment lengths for
> +direct I/O reads
> +.RB ( O_DIRECT )
> +on this file.
> +If zero the limit in

nit: add a comma here (really a dependent clause) to make it clearer
that 'zero' isn't being used as a verb here:

"If zero, the limit in..."

> +.I stx_dio_offset_align
> +applies for reads as well.
> +If non-zero this value must be smaller than

Same here.

"If non-zero, this value..."

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +.I stx_dio_offset_align
> +which must be provided by the file system.
> +The memory alignment in
> +.I stx_dio_mem_align
> +is not affected by this value.
> +.IP
> +.B STATX_DIO_READ_ALIGN
> +.RI ( stx_dio_offset_align )
> +is supported by xfs on regular files since Linux 6.14.
> +.TP
>  .I stx_subvol
>  Subvolume number of the current file.
>  .IP
> -- 
> 2.45.2
> 
> 

