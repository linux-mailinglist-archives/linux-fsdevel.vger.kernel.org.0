Return-Path: <linux-fsdevel+bounces-63895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C69BD14F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BDC3A5EC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CBA27A129;
	Mon, 13 Oct 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSuQhcnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6414A8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324695; cv=none; b=mpFY4JeZ25xVxunH8geya/+CHAqnfQT8QK6gktLdab1PXHOGNfcluj08Ki9qFTeqx+ThjmhQJ3b33UteSz8cBI0yl5wNIgK4wycsrt7BcI8lAI105SPYaHcEDg05VpDiGJ4lwDrsQ9fp1kipvobfGi4dtO1en0+qjpseLsJ0K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324695; c=relaxed/simple;
	bh=JPiq0wSjnLn2TCgmM4cnIVkor0KsS4h/6OC44n7YqJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRs4P8nzpNLBmS0yrrCqu580TrgFq7lDDL7If1Pjxa4Zsn8QlRyArHaPNhdGbH2wGjZl6r49ayjdgocD13VyBEs40fMe2gw6QMFU4TP495YsnrL9FrhF5cQ2wBVHrT5VVbhh6LYid1NWLfMbdLHThgvpb2oTqs5qdn75vZk7/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SSuQhcnn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wlLP1gbcRKQDjmhrPCdkYjv6d8zpj4J2z9Rc1OnNFSk=; b=SSuQhcnnvUBD7IpROjk8zFrGys
	fqBNjiB52k5n+61es+8uDW55cfO6RiKCyEPtw1liHW6DkXpLSnT+sjxt/gfFgC8qpWy+3Hb/e3hAc
	HdhMsiluTGDqLz1HSpqmQtZGx9AJvEi6EPqDaLngPVFEqwNs6ToVGsrRKTCznJ7NCYZkhK3ry/0dh
	2JggKj09sSZazeUeQtytSjql5BvIyo4ny3tmPS/abHiErwz/nHujkKJCddOlabGFwgnsIM7RHqsh4
	2aP9SyuY620n0vgmHXnnXRUovh3Q4D96xpuGSDHikWMmfNvN4m0oEMpA/zv4SGp/rjxfTd31OcRTk
	BBb8pQmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88rl-0000000C9DF-0gSb;
	Mon, 13 Oct 2025 03:04:53 +0000
Date: Sun, 12 Oct 2025 20:04:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 3/9] iomap: optimize pending async writeback accounting
Message-ID: <aOxsVZlz8kEFmFIP@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-4-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 09, 2025 at 03:56:05PM -0700, Joanne Koong wrote:
>  
>  static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
> -		bool *wb_pending)
> +		unsigned *wb_bytes_pending)

Maybe shorten the variable name to bytes_pending or wb_bytes?
The current name feels a bit too verbose (not really a major issue,
just thinking out aloud)

> -		/*
> -		 * Holes are not be written back by ->writeback_range, so track
> +		/* Holes are not written back by ->writeback_range, so track

Please stick to the normal kernel comment style that was used here
previously.

Otherwise this looks good to me.


