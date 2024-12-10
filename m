Return-Path: <linux-fsdevel+bounces-36915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144B9EAFA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FD9188CD4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35C22FDF0;
	Tue, 10 Dec 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7tIgdUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA93223338;
	Tue, 10 Dec 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829193; cv=none; b=rvV7127V4AUgamytiTEsN3ZHjFdvVJwkExZETODlZixfcgMBiRjCHSJQoa/gNPIFwiTBnE/q4OYon6Hg23C1T/TTzLQSdygM/NWB9ZNF+tokL/eeUPbI7uF9iYzRNwuzNRrIdg4S91w5uvJJIfFjkFvb3ype05W5us1rvBB0vdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829193; c=relaxed/simple;
	bh=ZD7KPZlK5V6sIIKYhEp6vNkRzJziwR4qvPxVMSzWClM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdrrVH4pZnoIE/dAi5EGNojRhtHNAOslnWIcIjrujlSYpyfHqwNXQ7UAsMy1jvSXd/MbeNnbdpjLVuK/3kptlA8e1to90uuxjA3Kqmbxy6cKb+PLYP4nBJpsJvm8s9Ej6QJMkCcvK+8zHbnQFEDXgOFUeBXe2HqL7LDlUZUaPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h7tIgdUP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KKxeo5Dq7PDirXiUbx/lnvud/6krnOHXEt33uvRUtdY=; b=h7tIgdUP8MwA7O/zZThtdrtm96
	BolgGocQDA8egdF9mwnwKR1CCWvI49LOz4mLwh9kg5TwySZHXceK52esfmbM0YFaFRRzKzA8m4FdO
	VQwuFUwdavHhpyZUGgKZLYHkW/w2O7zjAMAF6lsY4Kme5sPbMcLAYfNqD0rFXB4rvexWoorYNgBt6
	FwvCShatDxXvlzN6CnXwCVRVqPmQO1WT11LOrQjTVThpmrrvPl4D6TnJyl8OE8fGEdTe+ZbLF5xN9
	HtAHkE3OS1H9A43/+fyIKNPzxaD9f5pO2JI2lBmKTTLbC1rwQUZLsn3IFHwqfU0KCn0p1QB43VxzP
	UTUkuTEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKyAx-0000000BGuD-3s5G;
	Tue, 10 Dec 2024 11:13:11 +0000
Date: Tue, 10 Dec 2024 03:13:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 01/12] mm/filemap: change filemap_create_folio() to take
 a struct kiocb
Message-ID: <Z1giRw7nEebrPfpN@infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 03, 2024 at 08:31:37AM -0700, Jens Axboe wrote:
> +static int filemap_create_folio(struct kiocb *iocb,
> +		struct address_space *mapping, struct folio_batch *fbatch)

We might as well drop passing the mapping and deriving it from the iocb
as well.

Otherwise this looks fine to me.


