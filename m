Return-Path: <linux-fsdevel+bounces-57734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B721CB24D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1FF166753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022122DFA5;
	Wed, 13 Aug 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MvbJ0v1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3422A1D4;
	Wed, 13 Aug 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098562; cv=none; b=UzGC2ZbBQphKDjylZtiBsXjRj3zKDsBreCdGvDpO0NGYJLceZG4EMKy+ymNEuNDpNMQc2980b796E7vf7QLHc3iAP8FFO3wCje1b3gt7rCTEzWYmS5TId1bqluoruQpENQnmI0Un2gPvyQ4wFJHeDOtz+cEkgWtOuGRXbrhcRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098562; c=relaxed/simple;
	bh=jZGa+5p8OKMxDeASZIZ7juQprGKdJaAUxc70fbNmq0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMtG7SR6aUebmerLPKqTJoKsm/gUiwVAQPLkYv27fokUOXRc0VnThsY8Gdh4Zpx24SwUMJYXMVpvnOeyRhdqrCfTZarxEy0+0CkRb5VUsLa2TpAF3mVcU8Cd+KHwftdw8fTcCFrDgWnJtsenYIu6GlG775+DYsAJrjxTjDaWHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MvbJ0v1m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nhPtYN4tBHcWvztkc3kAGUGMgKwq0x8atHjNCcCB+AU=; b=MvbJ0v1mtVZc5PT7sWWSuBsGL7
	SzLxpDpNszmZwJS+xuNDdz8iN9dhJYUkjEtY2V3QnIOnNaZPA7MU6ooTpTIxtsyg1dAZPKVukr7Kx
	W6ywSRF2O1yMdy+vnckHnsBnL+K1TrYZdsgKEv4S6juE5LYNhN8pKfSJKUVc1icJN8727SqBgvc9q
	+JvufEKldxI7BN/RfuwNpg04ElcGL4gzwYtI5EeKr04XuQxhFoRrmXaTDoVCWTgFfzq5Sprtd9LS0
	pvOupbV2RuOvM4BCMMr8J4rOj8rBowZYvS/04gc4CXDI7DL38wCpjo6l2feSZdUI6JuwFcge0BhHa
	vLMRCmlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDJF-0000000EAgH-0ana;
	Wed, 13 Aug 2025 15:22:37 +0000
Date: Wed, 13 Aug 2025 08:22:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nanzhe Zhao <nzzhao@126.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>, Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [f2fs-dev] [RFC PATCH 0/9] f2fs: Enable buffered read/write
 large folios support with extended iomap
Message-ID: <aJytvfsMcR2hzWKI@infradead.org>
References: <20250813092131.44762-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813092131.44762-1-nzzhao@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 13, 2025 at 05:21:22PM +0800, Nanzhe Zhao wrote:
> * **Why extends iomap**
>   * F2FS stores its flags in the folio's private field,
>     which conflicts with iomap_folio_state.
>   * To resolve this, we designed f2fs_iomap_folio_state,
>     compatible with iomap_folio_state's layout while extending
>     its flexible state array for F2FS private flags.
>   * We store a magic number in read_bytes_pending to distinguish
>     whether a folio uses the original or F2FS's iomap_folio_state.
>     It's chosen because it remains 0 after readahead completes.

That's pretty ugly.  What additionals flags do you need?  We should
try to figure out if there is a sensible way to support the needs
with a single codebase and data structure if that the requirements
are sensible.


