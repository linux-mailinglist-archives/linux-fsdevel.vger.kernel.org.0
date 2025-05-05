Return-Path: <linux-fsdevel+bounces-48031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818EEAA8EC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00793A733A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0F85270;
	Mon,  5 May 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wEhwXiqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66535957;
	Mon,  5 May 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435671; cv=none; b=lblWnu9p8G31KcyOEfaSsNyJJgLsIkDrTHvvVIUs1QM8yUNEZTwSRVPjcXlpqwfZhm8zZo55ebukz48FgjF9mDgUgmkVogb+0czx5+fAhrZbv9ZlIm2tfUVRZyvw/SEJf6aILtu0S1rrSXWCwh2q5NLWuIgfSbJGaqCaUDur0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435671; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irSzWU91iY8cmQ4+wDtqZMrxZ3Kpq+pFRYGDkW9bpucGyx8oL1X9yHYmbAbkYMmroqQdApLRzKqTEkdjUUBGLHy+/GldSns6/roKkIj+HvJXxOpCWRhg2u/VcCy0FskZjoGeALDXQH0Eboxdf07LCeCAM9kKLRULTv+Q7OmfxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wEhwXiqf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wEhwXiqf2mhVb6HXj8MUXuWBcc
	ehmDs+sTD96lDIkcedrgofizpKAm4pGXYViKErzU1q0QtTwF89SoZMQgD45/uADYltt8aE8gAKT6d
	/UQhc8IaOy+tHRQzCXMJtbjWhiQJIDVzMgEAWU+A8Oz8IZJ3EjkQBo45SOBJ2EoWUGhdu/d+0Wup1
	tPJXz7il4k7w21UTePGKcy4jDbEYpIG/fnp0Ek1s8dNUWWWOPn+LUqHU29PgXJshVGUQ/R6VHNuIU
	pQHUdQ3GwTnNnWeT7IjXZhrgATXy6IfkkoNj1jKdPvxjN4W5c5loCKzt9LzcGve4f1S7byjHOTz9p
	YKQGnCHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrhF-00000006r0B-13Sw;
	Mon, 05 May 2025 09:01:09 +0000
Date: Mon, 5 May 2025 02:01:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap: drop unnecessary pos param from
 iomap_write_[begin|end]
Message-ID: <aBh-VdMKwnpG9EZB@infradead.org>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


