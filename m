Return-Path: <linux-fsdevel+bounces-60924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37739B52FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BB6B609D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496631D74A;
	Thu, 11 Sep 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqpZnoQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45031CA5D;
	Thu, 11 Sep 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589113; cv=none; b=uRCxVcyfbM5WJNNAJoUQfpAvsADL7s9VI9QZj4KNPy1fIiWjaYFeZa6GGOxyrxQnNjA20G4amRA9Ab6gPf6qnzXCHThGEyArKRP8946whCOSA+axuGOzsyYEJ5Nu+SMdJBllJYMIhFeDMC1AFPwTcDxNuw0yeph6tEqz3Q3TbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589113; c=relaxed/simple;
	bh=mI6RAyj9ugJxe5aWcmzbBttUxm+wBkmcNdREwV65AGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu/fHtBPGLvCDC0wntXNcl3nbrLSL0qla3XTnAwaQiqnihDAKex3auN9VX6D+0Ab3kQXp+fSgbknHkFI8QwoM5WR69xCMnRuIvuSGrptqQPc5gcYsqlODykrAeVG4NzycrJdbiEKr6vjKBGvHunXK/3fgh7rDTF1Q12oZWO7Vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QqpZnoQV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5FaLlM6S3dojGsG6ryFdLOVg+LSc2bSHN4q0A6qfpCI=; b=QqpZnoQVN1UNWzaVsVSY7ArZ1E
	5I5qEAodY9IOqC1MKJd7HAIPsVGlhnrkiwxR4x6dxHJ9lx/ncCQ9rmevJQUU3Xiv7dG+s3/F3iJEJ
	8tXCRJgcV5cMCccqdz3sw7aD+1dleqVo5NNqdQz0oZMkxBfg9VDpDQ8pkmArTUb5h1KPNKedJaaNm
	9Y8FY+erQKQeJrqibbJeKoBnhumJDCaojoUM/Y2FIwS8+XFBa8+PbuFx/6gmxFiLGwI/xZbxVawn/
	8wCJPzXUgr/H6DI8tfgDCViZADtRHRdIuppu9LpLvNeG2QWsB9ZRZ9RwF6iyw518tGdmtRLt1jAQr
	Ix2Xb0Kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfDT-00000002aSR-2ukA;
	Thu, 11 Sep 2025 11:11:51 +0000
Date: Thu, 11 Sep 2025 04:11:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 04/16] iomap: store read/readahead bio generically
Message-ID: <aMKudxVnwafaoqmm@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-5-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	void			*private;

private is always a bit annoying to grep for.  Maybe fsprivate or
read_ctx instead?


