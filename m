Return-Path: <linux-fsdevel+bounces-36919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2449EAFC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715811885CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9A1DC98C;
	Tue, 10 Dec 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CQ6khhXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91723DEB3;
	Tue, 10 Dec 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829765; cv=none; b=hktXacf5FoPrZUdWa7Ezvq/8qh3UXaHlC3C1luKMREdrXkLHm9pSuHInNYIKBLHyK47TzUXDH9NNbNo8NmelmhU0X9gdRzKtG6lmbV2ANMdY5oDrAlaYtIHHc3hcxULnWwyVwVc5VGzGo1GElxbolzpSGbYiwPF5p/3IZCOs5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829765; c=relaxed/simple;
	bh=3e8IArdZerzmiqrl5a5fgUupmvK8sP8WRrrkD6Ir9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYXHEnuQQ8f+CqQN0HUpKcKlcZzDi/VNdsuH+J0S3dtzzPJTjMFw2pTMa8UgcT+L3Ap24FHcio/3yL+8azkr2yb05mj/LHosdIamhvNtnjh5gI8KItpf1ZRALBGqdbGrGyW6AhUNs6dZ6lHNn7+oTmk08d24wd0s1p8MZkbIg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CQ6khhXd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WwO2WwMmgUHVrbMnAEHD/hczXHCTvxPmE53VtScaPRI=; b=CQ6khhXdcNxbSInmE0iCXUYCVp
	I3AKvSwOHbA356SDw+74PdaBpNxfCNg4EnYBwktitp31HA5s9fnyh+WIONLihERbtPi3ut1Dy+llM
	Uvf3MoyQyL2iXDOJ0d3YYhLkmYVTs2lyoW1+ytevXnHly2pS9mr7r3ct74HRcJS8bCBcLos9QrBxm
	u6tZO1RpuKQQL8NceSOnBngMYudGfBvJVPCFXhcFj2SRoPs5/Cp14UzE6TbgOcil8mEckYISEu5dH
	wYxfxMowNVxz1S+dUOJykYiEV+61er0QeBQ40Yh8HsKb28B0DACwhr9URIJ+tC3nvg9ffnNVbfO8m
	H44GYjXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKyKB-0000000BIlk-2Dj3;
	Tue, 10 Dec 2024 11:22:43 +0000
Date: Tue, 10 Dec 2024 03:22:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 07/12] fs: add RWF_UNCACHED iocb and FOP_UNCACHED
 file_operations flag
Message-ID: <Z1gkg68w-G9151cC@infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-9-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-9-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 03, 2024 at 08:31:43AM -0700, Jens Axboe wrote:
> +	if (flags & RWF_UNCACHED) {
> +		/* file system must support it */
> +		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
> +			return -EOPNOTSUPP;
> +		/* DAX mappings not supported */
> +		if (IS_DAX(ki->ki_filp->f_mapping->host))
> +			return -EOPNOTSUPP;

I'd argue that DAX is always uncached and could just ignore the flag.
Same for direct I/O.

