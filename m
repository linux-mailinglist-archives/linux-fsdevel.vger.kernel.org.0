Return-Path: <linux-fsdevel+bounces-60927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD6B5300F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CC27B96F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B742319877;
	Thu, 11 Sep 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhF/Ef9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54C3126C5;
	Thu, 11 Sep 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589367; cv=none; b=NJm/P0ub9PEHjIYPzVqX23xyqdS1ZvhlWtHzwwifqup8URcrvwKJWerZpMeJsTUwO73Fil1nVVu9aZT/Dw7JBSF88ORB8pVUurx8RsCo27kArvresEz9Gj2tZjaDe3ywS3jDEOgJYB8SzzTuw5hLMa1ojeeLdJUX7BZU7vhlKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589367; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWDtQfkRPfj2El6ILBjNnOWq0yIPKy+oW/oDppdQlt/e3XQHJZRGKZUyVgmjCQtBOUFg7GPD/2Ao9aASaCc0VymAQ8K9vPiTYjeyWar4yBPt4olTZqCqc6Skg4M0KEUorwQdgO4B7/0Q/ToauWdrGUF2Q2k1s0ooiAzznabGvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AhF/Ef9q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AhF/Ef9qA+2PI5MQt2tFdXY+kZ
	L+ZUqgyFtyQOeKBMh2pKrNB2z1ivvmZ5bF1GFQGa3YDxZhqn1VKSP2yqQveSFuPeKvrz+z01lPjjy
	8jacZb9dfsr6KHj2vfEdYtkct0aT2VPx1mhCAQd4t0gIUomfNPQeTpSZ+D2WK7ROypSu78b63F1gl
	EG2DlVlL/SkK60P5SSYHMokEYGls88LpMtXD+8f5Q6UeQ361ixAMQQQ78vCsXX2iqqReJUkPhsSoS
	9YQnY+FqP2Z1oi2jYUsq7HBnotOWB25rQRFDTfX3vT4m+oGhL14uQc7U75JFNJN1ilme+zXYsKeNL
	mLBCr1aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfHZ-00000002bst-3E6A;
	Thu, 11 Sep 2025 11:16:05 +0000
Date: Thu, 11 Sep 2025 04:16:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 07/16] iomap: rename iomap_readpage_iter() to
 iomap_read_folio_iter()
Message-ID: <aMKvdcBevhlYT9Ky@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-8-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


