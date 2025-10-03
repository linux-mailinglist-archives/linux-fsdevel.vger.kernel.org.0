Return-Path: <linux-fsdevel+bounces-63344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A5EBB620B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 09:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 834A834407B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1A226CF7;
	Fri,  3 Oct 2025 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t1byKF4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FE21CA14;
	Fri,  3 Oct 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475078; cv=none; b=Rx24Y0MK5mwsCjY0Wl8uL4vBzQ1AGdi+8X3GBCKzLJKOgCyNlB1zr0AvEW2YWrB4owc503VSSDF9I9AFaPU1nyGvJU+iL+PZKK5KuB9JXa5hnBXlCY0H3KEPbFKul3tQgMkby91qGOoSFZ4+vYiiZYP19PIsIlDhftaDr6nNsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475078; c=relaxed/simple;
	bh=9l2iXb9x45Wnp/GuE+IXwkPyd6c6zBevkMmOOa+JV+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJSBN9pdXPnV4zSuJbaun1bsLBdATDyxsrKmXjUhMIEjHlDduPtJHi9xNqoFCC8h2nfertETAO+AVtXPAbxDfQZv8PM5zXrhq795beU3vFIZv0aDNTtJKVCbO7/9CbRIGsPVFjR4EJ4ofjhweZ0JmYofDsOv29NBzY58YQA2VJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t1byKF4T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zlSFhuPDogDRZZHOPwko08uKnHV99ObplqYJmcJoZtY=; b=t1byKF4TZyu09Gfn9KaMaOVcfs
	6NsiBwPgJ8gZBDWInRDMYnCjzR/Jlkx+KbNhOiVVV/M8Lk1359Qtb4w3v3t+apJ6Fc6Znk6Xa4LvT
	NsiVgEsqjP/5IEzrI382buSEd6iITIdJYbKlYM6AGkDpXY2aShTOgv9ZTzrrZYhiYsggVEpS1wM91
	9ESg2behJOPROvrvpdY4q0vFBU2qNDZ4uRPSOPDvVWje8QbCKt//rPitmx5QENkV8hloX3LjM+0vt
	3qE6EZoQDha0VZiAzISqSaDwXYRw0WmciycV3w2MzQtukUiPYVNjDXEBXyjg1dN623/RStnEHJKjc
	c7qSci8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZqH-0000000BmqQ-0Wee;
	Fri, 03 Oct 2025 07:04:37 +0000
Date: Fri, 3 Oct 2025 00:04:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 2/6] loop: add helper lo_rw_aio_prep()
Message-ID: <aN91hdC63pmRq0fk@infradead.org>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928132927.3672537-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 28, 2025 at 09:29:21PM +0800, Ming Lei wrote:
> Add helper lo_rw_aio_prep() to make lo_rw_aio() more readable.

Does it?  The patch looks ok, but the reasoing here is a bit weak.


