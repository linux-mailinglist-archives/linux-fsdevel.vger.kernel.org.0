Return-Path: <linux-fsdevel+bounces-40763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FFA273C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFE91632FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A928399;
	Tue,  4 Feb 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="413gnWrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691082080E1;
	Tue,  4 Feb 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677086; cv=none; b=Wg7koEMOVNW/kbepYcNk+s52Lt1+zUmz2HxpfIryYT+iQSKgu55idwE2bOXjpugzMCx48M9R7/uVjWevXNJoQKHz8zJ5K7bOEHxzoVNKuwBQq6uWtymYDm5EoHTFb3vV/xIbeDN7e9dgXqymVMgqS6It7VcKD1PUvH0fR7yjH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677086; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ97uZPYPnrXhJ/21+pQeNzIB7+93OAsJBi0wo8lxkIXWJZ6CM9WdlxP/XW1/tzxc1kykTkD541wVnyTE1FT5rmM2V+U5yjbiB8M+HoPO4Rn21OjDl9QBphEH9gLQJbdDOWg5SgAiKzh56UJnDpxvi0JnvoQoM+EOHtqwJVdpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=413gnWrs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=413gnWrscNTQiUOKfX08F2LNE5
	g/tAzjO4grbx3ZIkGsM00S8QUKKC4lLE3BFI2KTTMBP3c/acS1H78DxsYT+Fck39ffkfRQ+VkUg7A
	UsB2ZaRjZydERIfks3S7pUvhSVg2zw7xWqucOvduXxs94umjOmowy+/NewFCRFHzOX7H/+SOyWOr4
	GYo27KpvCdCTnJOQfMFmjrnbPmHD3V2kvrYHAezrt9f+IxxofjPscaQvhEBE+LDSklxI7Z9MBU5wz
	4FzklEPZ1F+gbYXRSLfjbpMwSAPUGnI055pFTY9jlKl2UBa6hB2sROdO/F+ZB3Z5pNYOY/HzNqFOk
	Db9pPD2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJKm-00000000aRo-3xbe;
	Tue, 04 Feb 2025 13:51:24 +0000
Date: Tue, 4 Feb 2025 05:51:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 05/10] iomap: lift iter termination logic from
 iomap_iter_advance()
Message-ID: <Z6IbXAgxAgZR7lkj@infradead.org>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133044.80551-6-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


