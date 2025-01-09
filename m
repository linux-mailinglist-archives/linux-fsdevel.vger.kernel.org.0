Return-Path: <linux-fsdevel+bounces-38714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF30DA06EF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47127A1EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357D207A06;
	Thu,  9 Jan 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xix77r+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455637160;
	Thu,  9 Jan 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407326; cv=none; b=LwLnUaU6h8A+p4PTuHybIF9tvNwRnK/bcaC5kJuudKCkXbToOrUZXaI2qLGOr+cIZimlyuKa9aMFJGNRO7uEVI0pbiMWCxZiNwBDS7TxyHeSqGmvTTqYTc1pxfrXCHmPaiu4j+4Y86yGzCfqpG7XVbDat/WksWmaEddtdeFfeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407326; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI4+gct55LIVZsYm+QkSrmGBkcij8eDE/FMa8+1YXusREYbBJdk8uu6olRSI9vw5/b2YZrm/rYj7jprj+O28u2DBeOQixKd8iV1gntApfiVOv1anrBSc9nuYUtt2aSckevuWx/1a01w1RPt1VWS4BXuOQoGIUvLjQn5gq4uZ8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xix77r+i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Xix77r+i73SMwJJEKfcWlmvBXR
	9imKQSC8kqDdBcWAIb3H2H5kJQSHIQiQ5MYLyss2OwCRUsv3q9UPjxHgrgTWHSXnXFute+4b5fOnN
	OqzzWQgpHhWSR4wUQzy3/s34tvc+EjESA03fXhN+2UC59qBr/IsGhciMHFAOwklapq10RIbJgaC5y
	FSDyssj5gd+nzdkjG8Rm8a3k6vFWp6/Bj/tMHZgYmLGHy2c7/Eti07KUb49QYzlqIibGNWDcCnXm4
	F7cCpQaYLLg4ihQUg7wcd3QgUGXEC6jBabfKmqSBNOxPwQgWlr9hTDdzccolUvXd3FdCjF52CSxGl
	1HdIERLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVmrh-0000000B2LT-2WPK;
	Thu, 09 Jan 2025 07:22:01 +0000
Date: Wed, 8 Jan 2025 23:22:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 3/4] xfs: always trim mapping to requested range
 for zero range
Message-ID: <Z395GZLWuKqShvBl@infradead.org>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213150528.1003662-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


