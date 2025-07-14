Return-Path: <linux-fsdevel+bounces-54847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD9B03FB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3551616B03A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D62517AF;
	Mon, 14 Jul 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pj+FOuSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D624A047;
	Mon, 14 Jul 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499178; cv=none; b=HqL3VDiE76JtB56X9BqgCB7BvJ/BJB77QMIknBCs9Tp0kUW9+/AZVwJB09/eIeOhgxH7L+GKFm6rLspsiqROYGSkn4AyenYrafv6c+SMq5cb9nuBd7b3AqdyhaMJvYzW0yY0Ie7jlOdJ3uwVS5x1erYxTa/0zuMJrwydDT4kZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499178; c=relaxed/simple;
	bh=lQ2HBasLftr+jmS6g1QCrJql3WuZjYF2MKPVvq1KT/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCx6Akrf6rNknm2a/RqMcnFR1Ikq30Ys2uVDlS6bbJVV4qSb1Gv74yTjTgCkvKQ/TdeCXgvvebSjisNs2G0h6cJUcYVGxQYCJzZGthEJQxpdhGFoLfKosoGcFMDo2IzSRPiEm/0SxiC0AkiD3C6AurJsO6Qdip5DiWP0CqmvUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pj+FOuSz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lQ2HBasLftr+jmS6g1QCrJql3WuZjYF2MKPVvq1KT/E=; b=pj+FOuSz3t6mB2Plx1bLJfJUdX
	l21AqWOajzGfIa/QjIo9g9Bq8ZZ8KWWDi9mavPvM4tZV0gZPLZPyFU5rE/uLSTGN244GoQ5BGeoGx
	73+DQ6N1iHGIpw7QZomZtbeDh41QeyyiMNqJjZO0vOIXxmYzEJXYkQAIAUbXime0IM1ZdpvJ5wJpV
	8OC7ZQC9Bdjp45i+j/nBQW0QLFNDjoXGnW28bD/QpGdZp2vzG41NNJYPM7kRuBNit3APXzq4W9wNM
	6TI44HswpNFWFZv3Igsyf7zZnSPVEg556I6/8hDBVfPr75JPBWB0JeyiKfgD5VWt42TBty/eyx0B4
	NaLr1T+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJ5j-00000002GPi-1in4;
	Mon, 14 Jul 2025 13:19:35 +0000
Date: Mon, 14 Jul 2025 06:19:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2 1/7] filemap: add helper to look up dirty folios in a
 range
Message-ID: <aHUD51kZKNvMAAaC@infradead.org>
References: <20250714132059.288129-1-bfoster@redhat.com>
 <20250714132059.288129-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714132059.288129-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although for this code you probably really want an ACK from willy and
not me to be safe :))


