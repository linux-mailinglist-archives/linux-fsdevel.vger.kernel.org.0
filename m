Return-Path: <linux-fsdevel+bounces-40474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC58A23A73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC353A534F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB715CD55;
	Fri, 31 Jan 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ytdgs9Xn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FE170A0B;
	Fri, 31 Jan 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310978; cv=none; b=FH2Ykoq3jpudLO1JimTn5l0ckubpv2Udno+KMnV7v3kMkuEMoZVrJt4TvbW6MynrDdOWa+mahMJCKp+EeqpPG1KYLdisi/BaJJ9KOJRz3Dk/Ije0DVb7H+qWh8qL98tv5mqOQ6I8q/cieVcMuM+wrHucF5RbjbqObchofvQxRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310978; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqPKcdtyD0VzrVTMKgdRV5//KSMz+2XZ3H7nWwRME0ixwNzuBxgLLuh8Kp/H+DwHowYpmxWOyMKPC31fuymNFaQezr2HAveqiyhJCn9JWvNqBHNNUgIY3uC09Sa9iFX+DoIOZqS8qhd55b5Qar9aKIK9smi1m32beHDraPldgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ytdgs9Xn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ytdgs9Xn1rLQIP4iVPeYemZ5AE
	4P/HYU+zFpwmmppWqkzLyIXfhHlh1kIku3IFUcDSJqiGg7YarW3c4BEgtU04UfCkcd5G1NnCaYyKR
	UGwmATfkyFLKKzRrzFUZtePf8mT8cjBQNnUm0aVg7qbeNRS8kK+brLu+QkttOLZSNeM9itg333c2g
	OLYuLqtcN9vZ5UYMlyRTud61Ch2quRdl/8LDeWmbCSCJLpWJ0/FTGmHGyvmzzqhvmSKyvNvZLpjIM
	TG6roqS5c71IYik+3KW8iSRlRVzEfEka/eSENFfp+FybOZBga/JP3v7siERU2a+Z0SkPQ5yMtAnqP
	qVzOYZFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5o-0000000AAko-0uoX;
	Fri, 31 Jan 2025 08:09:36 +0000
Date: Fri, 31 Jan 2025 00:09:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5yFQFaKSda0DqQL@infradead.org>
References: <20250130170949.916098-1-bfoster@redhat.com>
 <20250130170949.916098-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130170949.916098-7-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


