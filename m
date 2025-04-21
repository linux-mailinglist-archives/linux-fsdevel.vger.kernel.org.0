Return-Path: <linux-fsdevel+bounces-46787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0149A94D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D4F170C0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473CA20F067;
	Mon, 21 Apr 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sb7AsCPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB81FC3;
	Mon, 21 Apr 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222396; cv=none; b=Iz8tLKzNM15gydZHA4EeAo+B/8eGDys5qtaxYzKOBzsV94O3H/JOy/COnhN+1WMlVcqHTYsu4t0bRvvRuJ0Ds0oX39aEOT2EO6pUec+Pbg1bljQ04judoL/xa0hWSgqSb3Z0k5Lf2l06eZDJIYv05qSK4OQdpvIY5FXCliC/6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222396; c=relaxed/simple;
	bh=SLFBE+3b0QC5fGDIl8chUYJEsK3wHont7fV5G4AvqyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klVnlUBpICbtORQMimtyCQESZgq8OfjaEghVcor7ucLdCZpDhawxGuyrZC5hxeRQ+nQFePv9S2icPgbYoI4HHn5eMzDe0HrNIFSURdxMnOEpguekdBYMgGhWKIyNX0c0LbwGgutaLvV0vJCZWA2xhWEfFUCMd1gxaUkIFpCOZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sb7AsCPx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ng0re57t7EUKR698C4JQbuTYS85SI00yjjDHhJo9LrU=; b=sb7AsCPxSK1xLME3b6exCQMNsq
	HU/Crm9/13xiNngmTHGd3Y6hLGgSeCRuQFxvEeAAadOSF4i+l7dYztZhd1xdEkkqsLT+oDP4i7qQB
	oOwH+BhLcuBPeFBf5n+6sjd7oa2NEt7ykK7SE3OAf5JrvxuJTF/DYeogd2KCIXTZYSisqFllirodH
	QCY/fFm0EODfShclcKBo9SxyaqbgTkoykf6ArHkYXgIbL2P9uCFmC/n6HiifXwO3ue2sP4jdNpddF
	SGHmkJHcRlLrGV3fjUCTpfV54dOD72YxF+UeJrUqJSvrMQh3Q5RXKIQpfBhHHaBe+49cdJwTHkDTU
	8z6EDreQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6m4I-00000003qF2-1gjT;
	Mon, 21 Apr 2025 07:59:54 +0000
Date: Mon, 21 Apr 2025 00:59:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: stop using set_blocksize
Message-ID: <aAX6-lH7tJiRuRGG@infradead.org>
References: <20250418155458.GR25675@frogsfrogsfrogs>
 <20250418155804.GS25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418155804.GS25675@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please split this into separate patches for the block helper and the
use of it in xfs.  Each part looks fine, though.


