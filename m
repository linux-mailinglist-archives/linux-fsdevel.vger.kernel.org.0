Return-Path: <linux-fsdevel+bounces-65618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD8C08B1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 06:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A43D4E479B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 04:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD82BE622;
	Sat, 25 Oct 2025 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hDX9dsBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185F2AD3D;
	Sat, 25 Oct 2025 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761367539; cv=none; b=Mlx2D466/Sob6EfOOPIXDdOnaxe+hTQGh5WT2dq4EHf+pqp9prz0fTwoDOaLCWzB3StMs/8ZFaJ4rizEPodouL9Jsh3CCNfwt49bfX60e47r+4mTkYljMYK1w1ULEI913wyy/3eFIHt/ZJp6tmK0IXknWgKSmKk8U5hw407WJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761367539; c=relaxed/simple;
	bh=MpWNGfxEaaSWJwURGuFrqvFiZNrJ2gPR2Wx/QXwoJJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF2nw5oJNgNO0Rka5BkFE0zFvea2fs8N9WNWsbyf0SoerphsyzbRZVbS24WHliBJXsxd+IGh8z0RtbQ4+7wWAJGLpP3MUt+ZEUp/26lcZeFkU3dvvy5I+ZzS9xaItpVzNnqtN+3g3UtSqltOIJ6yIYPHrWtcoxS8zmiDphXh5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hDX9dsBt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mQjSkC3ua7dzjDBzte7rrQ5nRmVgH3qrTQ90wWZPPLY=; b=hDX9dsBtzcXQhmANie+AEm0YjV
	vQPj5MEpcoB8AwXFuNdkmltwxQ5HpiwG1cTqtkVeoePAILnF3KENpgMIAzd3/DVFo/IiirZI9Mn+0
	fi0ShxIRMGcTV7vg4v0Xf15vjyffKlDO13+qyKY1LLfJp2bFl7UNyPofCg8ySrxnbDuOSo7nHmGoF
	5KtjMg0mCDSzvbPwLKHm7wtbOWD1igBnB4XsrR7UGfgPsro0Y4H0KYqBKZe8U2fJ5YJlXw+OfEVJg
	+Y8fR+CrgkgR3dYM/4QfOjvpRU2OEwjiQKHdRtPdlth+lEdJKvXaaHiJJm3zh8SVkJ9FBxJuOaCKE
	K7m1Gnjg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCW9i-00000002hpY-0vxi;
	Sat, 25 Oct 2025 04:45:30 +0000
Date: Sat, 25 Oct 2025 05:45:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Message-ID: <aPxV6QnXu-OufSDH@casper.infradead.org>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-23-libaokun@huaweicloud.com>

On Sat, Oct 25, 2025 at 11:22:18AM +0800, libaokun@huaweicloud.com wrote:
> +	while (1) {
> +		folio = __filemap_get_folio(mapping, index, fgp_flags,
> +					    gfp & ~__GFP_NOFAIL);
> +		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
> +			return folio;
> +
> +		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
> +			return folio;
> +
> +		memalloc_retry_wait(gfp);
> +	}

No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
The right way forward is for ext4 to use iomap, not for buffer heads
to support large block sizes.

