Return-Path: <linux-fsdevel+bounces-67053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BBC33A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3363D4ECDD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4E23536B;
	Wed,  5 Nov 2025 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz84YYbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376D11C01
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305767; cv=none; b=doT+5cZ3Inny2Dho6cH1bhKS01nrgjYuLGZSbbenbSLfx+6DLFFyBY5OTWogjy/w+KXWR5pV8fDiJFLLigc9IKhl9PA5NpXLxI/4/Ax+/DHJCavJcteDS/HQkP4763cHKOhAXc0N83tXu7QVswgTmaNZBIBpEjdwWl8jc+/zdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305767; c=relaxed/simple;
	bh=3ssMUsnrjzdxOidYEI5G6afpqEsj4f5Wa0mHTZomNQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdwhuqZXZTjruoymHBN2ohIUgk+vEXyT78Tb7Hu15K30a9TVMx1fAEPTHTldiVTNJrYnuMHmnz22UnwTULa+871D2CUKf3yETmokBrot8rjHw0qs87b7eu0uEm9DNa3palgJnSwoyBUEHj/HNMLzAvUYOhnxuns7RG5FNKxYnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz84YYbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B144DC4CEF7;
	Wed,  5 Nov 2025 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305766;
	bh=3ssMUsnrjzdxOidYEI5G6afpqEsj4f5Wa0mHTZomNQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rz84YYbYcpOLn0vWkeKeEmTdzopiaBBlnvqT+e0AhjgMMAv3X2zaCQnItpnf+ua3F
	 fj1FfSgbF+dCUUIQxGFFxSCIDOMNULjl/WsaaQqNW2JTTxUmCXbaEE3DxOU3ikD5Pc
	 8oqa61zyFR+h0kqnEJ2yJz01l5RWj/rPJZDA9zDQ/LHdaQSeAxoAQQi3P0aUfV/pZJ
	 bGy5hDgxY54C81Z3IhKV5BW94dQZGvqLvDgWnKYe3rnwYVUF1TfcvW+KOztUmU9MxO
	 WbRw91z7mfn82VZFbHaRWopq/sANiWrbxeamc3eVJzx3W5ZiqB1zUWcbQGjPKrl+wc
	 +X23T9/674K0A==
Date: Tue, 4 Nov 2025 17:22:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/8] docs: document iomap writeback's
 iomap_finish_folio_write() requirement
Message-ID: <20251105012246.GC196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-3-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:13PM -0800, Joanne Koong wrote:
> Document that iomap_finish_folio_write() must be called after writeback
> on the range completes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Makes sense,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/iomap/operations.rst | 3 +++
>  include/linux/iomap.h                          | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index c88205132039..4d30723be7fa 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -361,6 +361,9 @@ The fields are as follows:
>      delalloc reservations to avoid having delalloc reservations for
>      clean pagecache.
>      This function must be supplied by the filesystem.
> +    If this succeeds, iomap_finish_folio_write() must be called once writeback
> +    completes for the range, regardless of whether the writeback succeeded or
> +    failed.
>  
>    - ``writeback_submit``: Submit the previous built writeback context.
>      Block based file systems should use the iomap_ioend_writeback_submit
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b1ac08c7474..a5032e456079 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -435,6 +435,10 @@ struct iomap_writeback_ops {
>  	 * An existing mapping from a previous call to this method can be reused
>  	 * by the file system if it is still valid.
>  	 *
> +	 * If this succeeds, iomap_finish_folio_write() must be called once
> +	 * writeback completes for the range, regardless of whether the
> +	 * writeback succeeded or failed.
> +	 *
>  	 * Returns the number of bytes processed or a negative errno.
>  	 */
>  	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
> -- 
> 2.47.3
> 
> 

