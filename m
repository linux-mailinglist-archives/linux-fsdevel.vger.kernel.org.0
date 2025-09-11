Return-Path: <linux-fsdevel+bounces-60936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93014B53077
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB987AADCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507931A046;
	Thu, 11 Sep 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4FWAQ1k8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB101D5146;
	Thu, 11 Sep 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590304; cv=none; b=VaUtgBiBTZSDdkXLd3rADyYO2wWfi5MtlDjB3I23YSf96tCU7JDkIjL8d9I4fehfHDxvhcR3sdi43oxvjdEPnRFgeL9ZvAdbk9ErgMvkjoGpuTlQMaIcuI74Jkg9GHKWtS3TRMYMce8bg5OjGejDvdiLevXGoD+OjAzB3CMJ2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590304; c=relaxed/simple;
	bh=VGY4c47OStnjNxEC2Vtq1r6zfHhoJtjbPl5vb2ePaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q19sO/wSzuiCUmNUF9ZSgZUkosE3PAeLt+YRnACl3SAoMhzkLFtL4Vj3mIWrLvi/iKCxJQo2oqSsW5CkYFm5w9Gq2uZW8toW/5ogiaQlzZjSjEnamflJ+5QFP11nSQu6ISpr7RP9ObJRs/0PLF+xoVx3AkqODJTzTpc7hGMw8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4FWAQ1k8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kNyYbrIdpRFt22L+V/yJhMpR58AQ5SBq5iv/ar/dp3k=; b=4FWAQ1k8RVPeslnf+JK4mhfuM/
	TmDrREkCHkY/bOFpEGcoP/idpeXRTojC1/hgJ26vIj9eAt4hB3CAAVU9VAaXn35OdPuxeusk8azsx
	Tutr7mtpI1RZkCMkzeREHcjHVRfS1cmtUaTZSaWiz6J5mtZnkC7wbEXVLuNS5EXJinllEnwrDdPSW
	F0k6aSCoew/XbVxaz98YBc6OkI714hiOWXFNNd7q1DfzVq42VjIFxl5CmCOxP6PzsfQkoQ3lOU5kT
	hz1ufUAyyJ4ab9Th5qdEwnAs6pnLRoy1lkl1tfvoyouUNAJa9/zD14uiR806RAQ1N3rsli7GDyRpz
	gY9UVu1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfWd-00000002gtU-3Rkn;
	Thu, 11 Sep 2025 11:31:39 +0000
Date: Thu, 11 Sep 2025 04:31:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
Message-ID: <aMKzG3NUGsQijvEg@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-13-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void __iomap_finish_folio_read(struct folio *folio, size_t off,
> +		size_t len, int error, bool update_bitmap)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	bool uptodate = !error;
> @@ -340,7 +340,7 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&ifs->state_lock, flags);
> -		if (!error)
> +		if (!error && update_bitmap)
>  			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);

This code sharing keeps confusing me a bit.  I think it's technically
perfectly fine, but not helpful for readability.  We'd solve that by
open coding the !update_bitmap case in iomap_read_folio_iter.  Which
would also allow to use spin_lock_irq instead of spin_lock_irqsave there
as a nice little micro-optimization.  If we'd then also get rid of the
error return from ->read_folio_range and always do asynchronous error
returns it would be even simpler.

Or maybe I just need to live with the magic bitmap update, but the
fact that "len" sometimes is an actual length, and sometimes just a
counter for read_bytes_pending keeps confusing me


