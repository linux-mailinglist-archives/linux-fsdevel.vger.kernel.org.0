Return-Path: <linux-fsdevel+bounces-49759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF1AC2269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D6D1C027AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B023906A;
	Fri, 23 May 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frkRgo8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704432288C3;
	Fri, 23 May 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002352; cv=none; b=oHI4fQaFSm3C4E2e/bib7dbrp/Mp0HudCLBkYlWrB852W7KzKvmdyBmo2+CpkCbuyjyQ+1ZNKQUXqkqrG+MfdiuVY5WPYPLkBdtMOEwWlw6/Ty2ov81W/4F5F02pAkNSnhnLRrV7gzblwWerbL9RmNtUw+yJ7urZc4l5dPnKGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002352; c=relaxed/simple;
	bh=U3QyEuYpXOaWaZWhA06kcXEGXAnt7jNsFPYg2v0zqYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZwMApk2Ip8q4Rg4JZAF5sFt/tVQcQIdD6OpDoM4MaRCprUR/UESQWdHZ+VlofoaTg+0DZFSeAyB8Nco+FGLUi0NLkXaY13UdZFgeNGRcAsDmW+WfYoq1ZLiEVbVUxChkAeteFK3OTkX4fSJ9TmDNBGRw4P0x9ifH0tXuPtIkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=frkRgo8F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NGmWLKp5PIfl8R7L3jvzHZZajb1ZReYtp2VEVc8pBjo=; b=frkRgo8F+9f7PMd3S+VHqVwpx5
	YUS3WHXk1PDMgebh4vSpJXUwqU8CLOHyi+DT8c/M9wG+ZwHFG1AveyimWuYDlrjcFg+TvkGxTFgUs
	zMh5EJCCxBsyvNu/TNuK8gvZE92vxID6KDUr4EfgpaOdAeQiTdqyA6ul9O7VI/A5TJLVQxSOJlBKF
	Y6dNXuXNDCDNU8ovjCvRHQAZbfQOVe3gj5xyF7aSQ3JPTGdws497mGfa2tMZZYtxQ4P1p2or4ioCS
	TgpRQUXPoQBLfA/xouhkGPqZpCrFDb94g543n9zr+X36hfvWmKG/wc1LgRtNMmZzYAm0EdP8SpYRH
	4UX6mgNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRGG-00000003mjm-2YQ7;
	Fri, 23 May 2025 12:12:28 +0000
Date: Fri, 23 May 2025 05:12:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ye Chey <yechey@ai-sast.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix potential NULL pointer dereference in
 iomap_alloc_ioend
Message-ID: <aDBmLIFtndFpOfsu@infradead.org>
References: <20250523091417.2825-1-yechey@ai-sast.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523091417.2825-1-yechey@ai-sast.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 05:14:17PM +0800, Ye Chey wrote:
> Under memory pressure, bio_alloc_bioset() may fail and return NULL.

It won't.  Please stop sending all these bogus patches.


