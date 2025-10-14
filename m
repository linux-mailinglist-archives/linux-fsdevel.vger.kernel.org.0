Return-Path: <linux-fsdevel+bounces-64069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA1BD739E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F065404F9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C110305E3E;
	Tue, 14 Oct 2025 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y0fN6Ahf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A972BAF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415270; cv=none; b=JrLVpGWeGBFGdWunBsBF261/x7qtdjEWaChBdT+iRuwQgi+Q91JZ2GQZKZ2MLYRDadoE40kJer9LdAjMc7i0PK8Xi13KbPiWrRwpr5Kb57THSEIJchuNhE/nDt7suQKu7Y2buHSTJjaoo2ZNHywgpBo8tV5RcH53JS8jVSkK568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415270; c=relaxed/simple;
	bh=J/LUY+BOeXbEY+owlyL6s+wJWXhzUrYfg4hwKrqFtZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii4iUTAn/YeVW6j5F4BrR9pMswRr4sTFKef4YxrCFWMcqVzNcIjo2GI6U74kikuCAxzI4nNUUD76O+aLeRGHL0Al7pxXWv6m62rGtekuxh7ncIuyqKDNuKVE7C0FueDztVY7nTe4U+hj2OD58L0oyxgIyo3YEMTx8Lit0vqvKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y0fN6Ahf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J/LUY+BOeXbEY+owlyL6s+wJWXhzUrYfg4hwKrqFtZc=; b=Y0fN6Ahf3da6WtdWPPebxHUCQ3
	uYZukGOQ7lcTqmE/SgBOCGY2fHTPq+P1N143Xvrea150blzMSoFq4pL/qQnLy1cBGmt2JQXMYFXfC
	ztcbqV3Y7slxzU3H5jyDOt09KZJ4M3N4J//neF2mjbjOj6XXtzy2/BLe7nrAgu12817H1zjFHr7EE
	uSpBCsC4vUqSYO9VdxJjzyzZYD+sv/6OWpViBZqQBbxBnj5opRh8sMt1TmeQG4EhzSjegVdpIncqS
	l/yrjKQ5f+4kmYNMgNIfujeYT35wfGof397m4Kq4toLTtP2Mg3jXjKm8uPKi957liZcxlzcB4j90S
	FnJNZ7jA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8WQe-0000000F5ki-0stC;
	Tue, 14 Oct 2025 04:14:28 +0000
Date: Mon, 13 Oct 2025 21:14:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v1 6/9] iomap: optimize reads for non-block-aligned writes
Message-ID: <aO3OJBJL1Y64KJTL@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-7-joannelkoong@gmail.com>
 <aOxtJY57keADPfR1@infradead.org>
 <CAJnrk1aS9ko2ZxKM0zKm6Uy1zP6RFm6JWJ9Ku2zLSK9LmC4pOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aS9ko2ZxKM0zKm6Uy1zP6RFm6JWJ9Ku2zLSK9LmC4pOg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 13, 2025 at 05:04:30PM -0700, Joanne Koong wrote:
> Ahh okay, that makes sense. I'll drop this patch then.

If this is a big enough win for fuse / network file systems we can
find a way to opt into this behavior.


