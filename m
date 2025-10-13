Return-Path: <linux-fsdevel+bounces-63896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D103BD14F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5624F1884779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5DB27A129;
	Mon, 13 Oct 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m5VzXn+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C114A8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324765; cv=none; b=OBIJRU/0fXghN5P0iMB1GIK29Xl6oOuOs1q6O9nm3iPp763PNos8tPjPPxyBnkb/2R10S1mas8qlmyZEd9f1hilM/erUZYom0mxB2AYRB5vIHfClZYLiq2D1My1IgSdT3xNolQ9FssEVqw6/SmTr7cpfHIOWNUNZK9SgVy/VIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324765; c=relaxed/simple;
	bh=tqY5++WN/a9uQkKxJEYp6eZNihCDNokrQGXTWj49wlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKISgQhIKtmjqfjdm9gP0na6JPEwwkOSJZffHHz3p8MNGjiuk5l4NZewohze2X/qHMH8ndHQFM77xX9NwxLs2HxCMPY5CNpsfzJ8F92UCVEL5ykBvMxIgWdlYiuf69OzBvW0y4KpiMSQAgNulRS7SnSlnY2sO9fuBr2aTtk4V9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m5VzXn+X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tqY5++WN/a9uQkKxJEYp6eZNihCDNokrQGXTWj49wlc=; b=m5VzXn+XyQXEipOhs22+2xXsAp
	cfrLV6r4qp4g1njmdz/p/6Sxmvzrr9xEtUdzpr8eD0ZBFVTGyehLfGhQmG56UPV5kKfbv1N+6SseD
	0pcjWSdIYOi5dY4zKmAEa52xwizQtYRPgNMMkht/uyYxPEqHpjTheGib9yAdPLh6DDXmmY3kaLLKl
	aWGgPMXxMbJquglF9ewsTUKLu/EYpjIpv7Uvyx9kBdqkxJP9Tjmrjq/+9ztK1Rpq4S84JlQf7+kyQ
	h5z43vjK7xLUZ8onto0Hhb6fYYsmOKK4ZcSikoG1pSoju9szIQTbJHjCKiwFw27kqKNBAFBIq5eD3
	gvR/OotA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88st-0000000C9HU-3P39;
	Mon, 13 Oct 2025 03:06:03 +0000
Date: Sun, 12 Oct 2025 20:06:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 4/9] iomap: simplify ->read_folio_range() error
 handling for reads
Message-ID: <aOxsm1UDpO1phBnH@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-5-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although we'll really need to test all this very careful for the
configurations finding writeback bugs)


