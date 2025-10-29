Return-Path: <linux-fsdevel+bounces-66198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B6C194D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF32E5A038D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20192329C4D;
	Wed, 29 Oct 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DreQdCbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08532860C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727046; cv=none; b=PpXVZZTpQ7gv7le/K1LJrwi6RBIdkbhqewJit2b65hxerICpFS/LZ9hcfABUykE1QrqOj/d6uS33w9oaOE/pReREyMVK42OgypDCQNtkFcxUjMXVZfc27RIm5ADOvqfL3FvxlHpRabept26bB4GGCqSlkz1puNFoXE/XOGwh2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727046; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxrp45KIOOuW/Z2uhV7bAZ9H2HsW2e5U7FSFsuBtGt/wBgL95iOZFT6We4vHLdMRNKsoN0HwJAXYLSmEkNETa2Tk8QaHrQsFoGNqMpiqQsGRc9mtCD7w8p7uvwkK6PWaGlM/IQibQlE77C8ElKAcBn52JGAOg7bUVFFOWh5p1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DreQdCbI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DreQdCbIkHGrNdoe9p1QjBmdmf
	C1wpbLbimchZt1WRrbaMvkmdsANdCiKREIGV6Tv0T6nTXaR0vv34negRtGmjVVw1WGiR/2qevADLr
	PxsJbX+Va6x/jRYNY+jZP5Ttb0R7g2sGIlTHFcbw4P8zsBhELGF7NKFpjCROgEZ8Vp3bAkre+mQzK
	TjFXYNkLa1vDBv666X0WbW64f9eNDbg2O8Ur2kdhUXLYpaf1zgFkCP+33EmobSLej8P8/oxW92Zs+
	YL/UZ0FZxRo/fGJbloevcgAjdZSfaz37UPOl+rq2LG4Gsxz+GxiQ9LSN/NcbJlWPX4OyQJMZh5tb7
	+Y1+nR3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1gJ-00000000KiK-0tE4;
	Wed, 29 Oct 2025 08:37:23 +0000
Date: Wed, 29 Oct 2025 01:37:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, bfoster@redhat.com, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iomap: rename bytes_pending/bytes_accounted to
 bytes_submitted/bytes_not_submitted
Message-ID: <aQHSQwABm0qdLeBv@infradead.org>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
 <20251028181133.1285219-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028181133.1285219-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

