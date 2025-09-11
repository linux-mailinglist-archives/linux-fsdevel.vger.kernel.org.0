Return-Path: <linux-fsdevel+bounces-60929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E20B52FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B1B1CC0FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA631AF27;
	Thu, 11 Sep 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hN6P2KGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC32311C38;
	Thu, 11 Sep 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589408; cv=none; b=Ax913aGcMtTLvhvVI8PTx37Xhsy5QG/cU1E6Z+7ubvh7eOTHtgllAqjxRvWNokQRvT9HrYU+RX/ZWk6YR3ynkNJJVlK/uIzA1T2pp6mAV18HNllsZDOpLEZdX1o0t8Ln9nebC+xWSjr63fQsC6Kp2g+spq55BZ51m9zZ8zgTCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589408; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVrqtlqvouquXwLkyNuKVHQpp62LlRLWmIDgNMFaOuVOArfiqPaM8v9besFe8UKC3lkkObIel7rbsO2kN0votouVOtomdq0jvlpC6z3G9ucyRhKlNpMtVTFpbiK+qtGz6ClRzKI7LG7e4HDUoMrvrRJpbTQbBueW7UX2BNudPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hN6P2KGh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hN6P2KGhapAb/wOYlm+xDHRBOC
	A7jz8EGMwe+eYHJFtyg7+dhbuJ6+FKKqaxo9vC60WJWgMjF8CAtc3mvDtJltTwq4LJTA667XVZ6zM
	sF8Q1h7jVluzJX9whXTYlI3c2tb0BLISIlFYtwT/9uJc+DqEUR9isnMZ0qYiV7m8dj4XYMEm+zZ/E
	Rieu3dsaYgFd6XTGlhE3MEn/4e1iZJMyl6mn0p06L6jxHM4szdox20IwUuGUfLfc6amvaCXD6FQph
	T3VfHU7ewjviECsRNwNiP9zdqFn6OObv6vqrzL2Ryc7SfgddQAzrvkFKIjNvLPE2pXWb0+Y0MiM6o
	NB9VKvhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfIB-00000002c7c-0Ds7;
	Thu, 11 Sep 2025 11:16:43 +0000
Date: Thu, 11 Sep 2025 04:16:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 09/16] iomap: add public start/finish folio read
 helpers
Message-ID: <aMKvm722EHNxVfix@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-10-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


