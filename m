Return-Path: <linux-fsdevel+bounces-42437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A6A42693
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B44D1883DAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE924EF63;
	Mon, 24 Feb 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVYXG4mw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE26248874;
	Mon, 24 Feb 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411293; cv=none; b=age+1hojHWYJo/bVhHwGYoaDm6YSAmTQx4uM/gUo2skAaEzRHr58h+7XHmCW1DiMwLSZ9Lg1N3TboYWbujtFCFenSxwpphcaD83ELlYLW/riImEzh1C6fVfXjed8b4Pdiq86+OhaU4GQA0lBl1nO3cqT+rND0zJ7I2gpWJlo3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411293; c=relaxed/simple;
	bh=8bsvLBbvk6LViA+IJkZX1yMrabNFNJPQ6Q/OQ0JDrGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P921++3X9qVsD0bGusAQTuG4rqYE74tFhDrzSxfNUN0OZo1Oz5mdoj/7DN0nsSkZYJAcZPa9cfeLyKRxO+I8RdV34PTaP0XVvrUtEMXvBx2rs5t17hSXzzY2GiZz9PeNWRgyuIHY0LwiHZ4UjIa09vGRPBuRFejxb2jjxnjzSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AVYXG4mw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WGuziz2I2YQKaC2H+rN54sRWpReNMCFZEOke+5h8AZs=; b=AVYXG4mwTIhY03pov/L2TKlmJh
	frxeD+YbIOra26LanN5KQ5Nm4swfotSpCjTCbKc+DX3PsS84YwX4qQ7QpMmmCB0FeDh1EkVcVMH1q
	RDkx7Ej9ZWFvaBu6LOcKnVOxd1Aq5bqkd6T4+tmky8L+StfiZiuygjPoH8IN6qFxm+UWGlkn+FF6t
	ZzFXXmQhsljQ2dIairViT7l2eLcx8ipggQOS07YVk1SkiTRwUWH6SZqe11aWsbreauFDpvK9axK1x
	QqFbxHFycCx/Vz/3CBuydzEF2smWUBoaNlZXQY3jFyXQYSJiFqtOQLClbSqXvqW8JJJ5koH2gC902
	BjGHc3pw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmaTq-00000007dvD-1KeO;
	Mon, 24 Feb 2025 15:34:50 +0000
Date: Mon, 24 Feb 2025 15:34:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>, hch@lst.de
Subject: Re: [PATCH v3] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z7yRmknoYqb2ia-Y@casper.infradead.org>
References: <20250224143700.23035-1-raphaelsc@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143700.23035-1-raphaelsc@scylladb.com>

On Mon, Feb 24, 2025 at 11:37:00AM -0300, Raphael S. Carvalho wrote:

Don't send out replacement patches this quickly.  NAK.

