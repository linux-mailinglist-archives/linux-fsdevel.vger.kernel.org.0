Return-Path: <linux-fsdevel+bounces-34081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9E39C24C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9406028281E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D71A9B3A;
	Fri,  8 Nov 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LhtkU6/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D78193418;
	Fri,  8 Nov 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089914; cv=none; b=KBqRwYUVOQulePwztqK/hKVcpiSl6/MstZ8dJFmd8fCdxEk+FSrEWAu8gqrRRWJYvmhyMcqC78CcUenYG/esi+PG7MhiUW41j96VoixezQyLS4Hn297qE9LBXk07cTIubWQQplODG9ng44ge1OM+h5NfzWYS0y6FOA+Gp6jDdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089914; c=relaxed/simple;
	bh=LP4RAM0qR/ytuVuwTD7htBAHrnyPxX123oRj1JPz/OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvcpDALY1snb0K2+cCfCqXFzevN4OJbQXKbwOhrs5CvWGyFT+baqu4yJ7scQo/J7ewQGwShDgMEZljv4ppCeKjax1TMYm5wA7F9WMOo8Na0KQ0DVp5mElzlAzaUb9XvsRu5L6me/6TCIo8Fkp+AYgBYrHji3jCyX8rXHWUO7mMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LhtkU6/e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LP4RAM0qR/ytuVuwTD7htBAHrnyPxX123oRj1JPz/OQ=; b=LhtkU6/ekHvmRvAnCjsFNmAeLw
	tpI/kQn+9L/nuY21XAz2GguZcDU0OOeqFqYKS+jUJG3xnEK9nuK+7zvl3qvadqG5xwuMRMtdlxPrL
	1iJ5WFPtupZs77x2nRrZN3yfujegpl1MVEzUmuLT00+ZiJU6Y4TckgnJjrexEqp3Ag6MVc0c+6a92
	myGNfqEkVJfM5ilwS7LrVgFvreH5nU6R0k2IVSmfTnZW2wxPdoJa7XRa7Hp/DyB/81HyJn4AKbPBm
	BWt3dAWooJfCckcXYKRLy7op8xLmvcGsGE0b6BvQfqNUEFmFWEuqAJw19/9SQYwhVwwYzobj904pn
	BUytuv1A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9TYz-00000009AMP-2qiG;
	Fri, 08 Nov 2024 18:18:29 +0000
Date: Fri, 8 Nov 2024 18:18:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/filemap: change filemap_create_folio() to take
 a struct kiocb
Message-ID: <Zy5V9QmrUzWV7jv6@casper.infradead.org>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108174505.1214230-2-axboe@kernel.dk>

On Fri, Nov 08, 2024 at 10:43:24AM -0700, Jens Axboe wrote:
> Rather than pass in both the file and position directly from the kiocb,
> just take a struct kiocb instead. In preparation for actually needing
> the kiocb in the function.

If you're undoing this part of f253e1854ce8, it's probably worth moving
the IOCB flag checks back to where they were too.


