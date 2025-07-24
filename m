Return-Path: <linux-fsdevel+bounces-55957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606DB10F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251C1189F870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408732EA754;
	Thu, 24 Jul 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfAqoS70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535B61FFE
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374302; cv=none; b=TUfO/p63027s2/nWr8bUzomH/71hJS7y6N0z15k+F4q0y3OlT0bdpM+VG9zzC49kMCUDD+xIbYO4ryOvkeXd04nZJVaCo5H2K4oAcW7Qub6wIOmRS3adYqicBfFvDCV3wHZYNB/aP5vp433FXfSuaH7JqKsIz95GUOA/9XTj1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374302; c=relaxed/simple;
	bh=f9UQ+WRtf9hT6iZTxwJIE4JYhKVRVPBVgo1LA2IDr2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwzm/GpHSXf1c4kIlnECCrY0g9n+OvXLrOna1YI6b7Fyk4SH445BbW/SJFoq8e+O10doqhboM6NXe9GAoa0Bls5xZrKok47upoNLa0ZqetlVtjJ87bmABPUxL+WtCh0N0DFnwRrklOJot+jFA7BTGJn/163Psr3tdMaag9Z/6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfAqoS70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC13C4CEED;
	Thu, 24 Jul 2025 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753374302;
	bh=f9UQ+WRtf9hT6iZTxwJIE4JYhKVRVPBVgo1LA2IDr2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfAqoS70qj1qGxz1eUesne8kIISKoYajpB7Ve5Z2W+IVg4ZyNDMogXKSsytKn+dpk
	 YVThFEpQlib0av1kZZVhdE+1q5MdU1N+fmqW3AAxMDWUBRfK4u0uZGt0Hlt/msnE2A
	 R8Nvj79cpECzTfQDn3OUGcc99SdGZxnc03cyj8X5lamRkDB2AezskhyMOwJsXKawr0
	 Vh+Tf7cG5JLS/OgTTkLNn9uQmWRM+LTWz5rr8yV0zcWyRrOR5YRoi7az1HYIil6lF6
	 4Wxqs573sBSog1R8g2pgTR6mktKWVNEw8PfS4KYnISzgQjMRa9+cV2dEQ14Zh6hKoo
	 Dr94XE3TkQUwA==
Date: Thu, 24 Jul 2025 09:25:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	naresh.kamboju@linaro.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] fuse: remove page alignment check for writeback len
Message-ID: <20250724162501.GL2672029@frogsfrogsfrogs>
References: <20250723230850.2395561-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723230850.2395561-1-joannelkoong@gmail.com>

On Wed, Jul 23, 2025 at 04:08:50PM -0700, Joanne Koong wrote:
> Remove incorrect page alignment check for the writeback len arg in
> fuse_iomap_writeback_range(). len will always be block-aligned as passed
> in by iomap. On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT
> so this is not a problem but for fuseblk filesystems, the block size is
> set to a default of 512 bytes or a block size passed in at mount time.
> 
> Please note that non-page-aligned lens are fine for the logic in
> fuse_iomap_writeback_range(). The check was originally added as a
> safeguard to detect conspicuously wrong ranges.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Seems fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> [1] report:
> https://lore.kernel.org/linux-fsdevel/CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com/
> ---
>  fs/fuse/file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f16426fd2bf5..883dc94a0ce0 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2155,8 +2155,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  	loff_t offset = offset_in_folio(folio, pos);
>  
>  	WARN_ON_ONCE(!data);
> -	/* len will always be page aligned */
> -	WARN_ON_ONCE(len & (PAGE_SIZE - 1));
>  
>  	if (!data->ff) {
>  		data->ff = fuse_write_file_get(fi);
> -- 
> 2.47.3
> 
> 

