Return-Path: <linux-fsdevel+bounces-53800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11D0AF7628
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F02A1BC884C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344742E7635;
	Thu,  3 Jul 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wj76+C79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DF2E6D35;
	Thu,  3 Jul 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550629; cv=none; b=cT5XVA+QIWDlekmHQcPKNMmoU2TicQduiykZvNWcVvI1KoDYzNc9WPEraOh8zCY/SjtUyL9XkhtK/VdUZyGDvmkiXNycCCj55Y0Z8XeSipm7gxyiTsONOGy/ZVIQt/lRoz+Y2Y+V8s5J2w3VhL7lPqUqpnm7VuOQzugeOepwbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550629; c=relaxed/simple;
	bh=yBkyQVzTj11JeCCE8CwjO7US3wdU6W1CTw8UVQdITNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpECAZ4WWzhUKJ5oASMbbKTFP5Rkwrz6gH7DsBGu6UimAdy5frw54fiGqR7b9MHprKLMyVUoK8L661aDxomMjxKMZwaaREMb+HtXzHsZQDyBsqOL6JCYkK+tLstuGKiTnS9rJNjGJJy3A8Rn1GrguZ6Xw9LlD2qRql+4Q7oGVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wj76+C79; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ab9+M0Wwt286fsDWoPAsSY/Y3oyNMaCJy+7VX1xGd4I=; b=Wj76+C79gmLbu6iFcE2+Q67mjF
	DYQrCWxdTZrv5py4rxaC8uj0aMsyX0yjkjZ8osnFH2V84sHVTtZYpKfO3AHtaRgagiZmhKsbheMr+
	zex7OCatCGmEbvVo5M15wEmJsAUiQxCN3C69NBQCI/GQVMrskNUrKz20VK63IXRGXoxxPWcyHUKSe
	4Q7DZ5ol6HalqZEqusfBhkqF/jkZj2bGKxxUQNbhHOTsfxjisLOO1bHUPniDFVFcPa+nZstvRjw/k
	+47iIupZNjV8BieF8HObH91KvQes/s6+dEJzxtwJPDGBLw30cQQlCE76dJsqfnXP5p7BmR5TvqNyh
	kcxYVjqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKKW-0000000BY8t-0aYF;
	Thu, 03 Jul 2025 13:50:24 +0000
Date: Thu, 3 Jul 2025 06:50:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: djwong@kernel.org, alexjlzheng@tencent.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with
 locks
Message-ID: <aGaKoDhuw72wZ9dM@infradead.org>
References: <20250701184737.GA9991@frogsfrogsfrogs>
 <20250702120912.36380-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702120912.36380-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 02, 2025 at 08:09:12PM +0800, Jinliang Zheng wrote:
> ltp and xfstests showed no noticeable errors caused by this patch.

With what block and page size?  I guess it was block size < PAGE_SIZE
as otherwise you wouldn't want to optimize this past, but just asking
in case.


