Return-Path: <linux-fsdevel+bounces-51414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C312AAD68DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9B41BC3D4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F720C031;
	Thu, 12 Jun 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GldLZfLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D81442E8;
	Thu, 12 Jun 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712924; cv=none; b=nPms99ub0bHIgZ4vlaYkVsLOuV6JYqnIIZ+RRks/G6+74AOz6RfwPEkK3wCPtDop+ySfwTUMSsHiCBlkb0GFfTris4WqPLcn89iUb4tSAjx5WL2UUh0fvShUR1imdHnx8Is/TxnQum8DK83T73PULO+eavx4ltEQXrgP7KJwtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712924; c=relaxed/simple;
	bh=hQ25cRnQNAWRevQzrPt9gKJ5qCxiM9w5Fi5T+GEChPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbY4+sCfjac2SIKA2rSA9DH/u2xBr7xoTcYtR5QG4yVmOZu+iFamHxyx8kONUUeATe3gUNdHt/vinP45cFS8WQ+e2yL6Vz0HRIxsLfczRE9wKElWsBtgpDgwW58H9Ur37jGRwskhurIDnGe170vHLGhWj+EKKFMD3IqAI6hDt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GldLZfLm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X5+TLzB0z+EuhDiEbuXwK1fgR7Wc+FyHi5TrihIUUPk=; b=GldLZfLmzR9A2YbyI7ZM266icX
	FQ17dYWT+OlRWSnvp2GOjWpvdsJiHDCio+k99LEJqLIpn4a0T/YaWi1LI4CKSf7qjv/vGUo0tiJkZ
	NiujjuVu7eXPAP0y/oBsKmHYAPL2uExf4tptmGJcKYVanwLEvqV+iT/p8rjtMxHot8QFY24PlNY/G
	VaJIJkFuujWB6n3iyp6aeNQ3SudfMjF92/kFmvnkMeeFMehCtIRURm9+d2cyMXXgrgdDrirOEO7XY
	OzOwIpRZCzUMDgde+48a29yMqVix/Fc2jUOkD4VN1wCEvK/halfZa6TMDSiHBdKfH8cND3fp1JhFL
	r5BoM9Gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcGB-0000000CQw4-10Gp;
	Thu, 12 Jun 2025 07:22:03 +0000
Date: Thu, 12 Jun 2025 00:22:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEqAG0Y2xycKhETh@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <aEkpcmZG4rtAZk-3@infradead.org>
 <aEl1RhqybSCAzv3H@kernel.org>
 <b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 09:30:54AM -0400, Jeff Layton wrote:
> 
> I'm concerned here too. Invalidation races can mean silent data
> corruption. We'll need to ensure that this is safe.
> 
> Incidentally, is there a good testcase for this? Something that does
> buffered and direct I/O from different tasks and looks for
> inconsistencies?

We have a few xfstets racing different kinds of I/O and triggers the
failing invalidation warnings.  I'm not sure anything combines this
with checks for data integrity.


