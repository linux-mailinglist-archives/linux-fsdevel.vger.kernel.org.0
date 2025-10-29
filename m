Return-Path: <linux-fsdevel+bounces-66203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8243C195B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF61C86ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DF324B33;
	Wed, 29 Oct 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GA03knUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F83128CA;
	Wed, 29 Oct 2025 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729834; cv=none; b=PvLwhdI18CLRRlX6dpEeE0IB7D1wx6Zj2jgxaz0N1BHDNr7n11uATYn4Q6hvlKG4Oq9AQ87aUX7MBo40hXs4Ql3aa9O4qN4fn2g1KP36BuXSo7s44W1PGvH3U74IEM7oa4krXodagNS9ySmdrvCYq4wZqXP2s3f48S+dTzsPIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729834; c=relaxed/simple;
	bh=jTxdkb4v5//ZDCSckJFq++uwvUJsKMWAwmKvwtlqekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC+v8RA+NzAyDLUkWkqEVL2e/Y7qr9+FfHf5RNeCjhUmXiCZ2tOknzW5H/wntSxkZGZSHau4KQFE29JDFK3/z5KQc0Z4qjQiHlTdvXkKeb8ITUyc+0aj/69J6SRofuGUaBoynZ5qmnEDH44DGdXoF0qKfxOfk0cPIpaVVDGl1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GA03knUk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Ih05HK+8ZsKOo5cQ+utqVaq+hUnBg4xFJaxP/XkN4A=; b=GA03knUksWMuLiHmkDJ5EtiFSg
	wtcTt2zLP5rdVxMJlL5t+2bQPR9r1FAu+7TxdPT1FZoVd+9zZqS8DvVU3U58tlcANQo3Ijlxm29r6
	BIL1s0m3nl0Oj5zeyYWGYkRZrAQgYCgg7EwQeFKub1LK86Uy5OSqSsuBN38/AYPS3gZpPXq24K0x0
	9hFELXTlQiy0mJ1/LIvBFNKdrwvGhc6WAtCupQZEw8eVo10iVBdtQ2tvC/JcnCTHrsd578Gj8mAoI
	DiiBs5ov9+QgkPuCXSJMAiWBqFr+vrzwt270IQq6w3w9rvz7L7t9vBla6YL+/OiGk39CXMbQYj+eu
	RZXfs7tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2P5-00000000TeR-1TcB;
	Wed, 29 Oct 2025 09:23:39 +0000
Date: Wed, 29 Oct 2025 02:23:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com,
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com,
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	minchan@kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
Message-ID: <aQHdG_4yk0-o0iEY@infradead.org>
References: <20251026203611.1608903-1-surenb@google.com>
 <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> I'm guessing you missed my reply to your comment in the previous
> submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=eukTuS2X8f=nBGiiuE0Nwhg@mail.gmail.com/
> Please check it out and follow up here or on the original thread.

I didn't feel to comment on it.  Please don't just build abstractions
on top of abstractions for no reason.  If you later have to introduce
them add them when they are actually needed.


