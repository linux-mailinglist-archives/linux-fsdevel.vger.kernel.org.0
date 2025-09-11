Return-Path: <linux-fsdevel+bounces-60928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C7B52FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC71882D3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC731A550;
	Thu, 11 Sep 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n1+wY47J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385E3126C5;
	Thu, 11 Sep 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589379; cv=none; b=t9unFxJA/oHZZZcKg6HrkXELIEHo5xKyUJAi/aRAOji5m5NF/Wf+AU6/yDx8HPjg+h1ro3GjNZFdUC+nmv/YFpKrfYmhKd7E7nhQt+PK5Xxb765snIFl8MaHJ2BFtIegbwpSBZtZN//YxR+lL9IkczQs55Nj2GXeDkB53pUGDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589379; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5qfmUyu2TGFphC+fDk8JxlFNBEJArrUmeigVDYkxXjmys6Ouk34Ug8797ERM0/r5Mel8F7PdystR49iEdGgvjgQ5/VEd34pYFnEXRI8Du7lyUoFk9rAxXix8Cy0w5/hYmUnWIF7jctNbubKrOoE3ded3O/nxZW0IX7IuBpKF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n1+wY47J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=n1+wY47J1JLQLRW0+Pk7fULWd3
	LEnhlKrowGnf4xk1PrDcuUhE7cq4gQHSRdWF8Sgh7eM7lym/mP6FsjK7C2L9OCUu7fqvUXtaZo+nk
	3xsV11lpE0/br0Bcd2ZIE3UldAVD1w5LxLZJZrl156p8V1XY3TdqkkiWuz7m8NR5nJXNr4fvz3FDY
	O2gfyhL6Q8lZgr54Y/f1eJ6LOMtBclRVUR/uvQS719W7yYl1aZSORLSWrRQPN3rS+EKk2ADcFB5V8
	3axHQEEpv4M7X4OGOqYCjTw7FfOJykYZZya9wZ/4zPBTZS2gg0K2BngLYT9kl3LWbGNFlIJ+pEDUL
	WlRUEADw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfHl-00000002bwV-3b9y;
	Thu, 11 Sep 2025 11:16:17 +0000
Date: Thu, 11 Sep 2025 04:16:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 08/16] iomap: rename iomap_readpage_ctx struct to
 iomap_read_folio_ctx
Message-ID: <aMKvgRapFpbwR3Ep@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-9-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


