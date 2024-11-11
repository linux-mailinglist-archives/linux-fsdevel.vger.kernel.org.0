Return-Path: <linux-fsdevel+bounces-34249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A439C41A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36225280ACA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBE136E21;
	Mon, 11 Nov 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPOKKY3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364825777;
	Mon, 11 Nov 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338181; cv=none; b=nGM5kcF0B3lfpiG9ze59slbz1epMvp1KbSWyppsl3BaUuBiAq6eVNtka7iFO5GH3zU0+cBhs7OO6vD2aSfu9sstQqlYXwU9zZ9f77KGAcRr5kChUV1ebqKabOHBdKEtj7TAE9jiEDmybK6AapEkngQnlmn6z0lrwOmO1F9HJ8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338181; c=relaxed/simple;
	bh=bj9GlN2d5ygMPuEtL8q35rW5wXQMq2mtKNgXd/g0Kgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbhkyNgs6cDhUTeX+wGX7WzI5eEFYXG8AS4uCG3NnVSE4Lwf2KXdUSbKCi01ARsoTJtSO2XXevASdMYVxa+F5KMUxPM02258ahxcU6Z7mGxlDbR5sGjQ5XSYy/Ymg4xr0/6/cYA4rlA3++JN9r6Jazw/uZth6ASqFCpC6+zXHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kPOKKY3z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dscR4STpFrd4KaOzTQlfucw6TNXm89oO1VRGYbZ+0ZU=; b=kPOKKY3zt1XxT8eXK7pZKXVwVf
	EdVOn9MpbkEgBHffgciZDN9dOUbnR/2jaw1OGFeuwlt1I982iU3E0AG0B6mVy2ZbRTCxAsyAJalRy
	X1/shT6w84uE7AJ6E06361ZKQ1deyYCqBIOgX1TNdUMqGXvZQHGtf/YR9e7poXzY84LO/nzhjahEE
	cs5mf6kxHQ+QgZwdXGRM2DMIeMRP4LFJQ4UQiKpmnvHAoJcUG+iUJ8uC9Agub8SX/d7MrGvj2c92o
	GI04ThTrvcf2UAD9sg0MYGINjHWYnv+XFJZOCKVCDuDpVI7jHnXbdKznEro6wnHhSRufZj2wYvjF5
	Aqu41TDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAW9K-00000000Qve-0ZQD;
	Mon, 11 Nov 2024 15:16:18 +0000
Date: Mon, 11 Nov 2024 07:16:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzIfwmGkbHwaSMIn@infradead.org>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
> Ok thanks, let me take a look at that and create a test case that
> exercises that explicitly.

Please add RWF_UNCACHED to fsstress.c in xfstests also.  That is our
exerciser for concurrent issuing of different I/O types to hit these
kinds of corner cases.


