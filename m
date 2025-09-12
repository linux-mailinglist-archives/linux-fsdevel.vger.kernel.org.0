Return-Path: <linux-fsdevel+bounces-61001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D98B5439C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28383464085
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D862BD5B2;
	Fri, 12 Sep 2025 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKgZ0B1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BA282E1;
	Fri, 12 Sep 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661271; cv=none; b=X/Ny0vIP6O3eAF696jyxVKd/sbSJXoUhsxq/6KjXMvTvzWNOi5BMsyEgrnQEvvXc8c9xwTOGQw676eguhi9arADW3loTN27qqG6Aow04dlClXbCSu3vQ7IEFy3jIt5b0jCSVCChtn+L7sKPCx6Srp4VfMr9LrbAtS7g4wRXX8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661271; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTOV3oKL0DVY/QLLE7NzZIEDdf5baW0SeAdTwT4axl0tAtauuPiQ9fsH4UW0PVFUBek+2xlgZ6cFY3k3QyqwOeevKKwhoiKcKXiENgIK/YjrurFtaUUKxyhRqEyJtE9EEK/IxefqFvvcYIHJfPbvDc8Bm/IGIgeJ4d2PDdFVekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AKgZ0B1Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AKgZ0B1Yf3/YlGAhXyFgmVjN//
	4SkUCjUvlcadtd3xFs/5vZ33spehnvMIsRkFBwFAD0WtA8ichQ0P7G0ztI9yyxt/FgugYJRAF4I1f
	ftdVh8sS9ghdqNXGzGOHFPBisf2nkDx/3+bjE/f5MMQGPcKqMn3b4miiYjlS28kUZYC/MwJOuuqpO
	oTGURXlsRLWUF6hKG8ZMmOvUGbwQ2HYqkzjuuSTp5a+q3jo9O3Spm6tvtooIEEIK1/E60Mzsn0A1i
	DkA8kEXJ/iwMyDsSJCE1b5rxSabU5ObHoIyfumfcMfEa6Q5gwnD9DC+jygclMjN+m27ML4PfUtU2N
	zchs1cHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwxzJ-00000007aba-0QNB;
	Fri, 12 Sep 2025 07:14:29 +0000
Date: Fri, 12 Sep 2025 00:14:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] iomap: revert the iomap_iter pos on ->iomap_end()
 error
Message-ID: <aMPIVc7KG4bKBhW5@infradead.org>
References: <20250908130102.101790-1-bfoster@redhat.com>
 <20250908130102.101790-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908130102.101790-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


