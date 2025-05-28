Return-Path: <linux-fsdevel+bounces-49958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A7AC6446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F981BC7597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8B247297;
	Wed, 28 May 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELmb3MUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75290213253
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420137; cv=none; b=CU3VX8i0f8fcJ4lT9flk5ZS4oxQTkoHhyM8A+fV9WCHqRDT0b7aiQcE7r5tPQqRgx/rjjFCdZHFNNNf3PQDorOCXYWI8H/it0qcqB4je6+XhmA3as/GONFuDMqrrtvE1x++TlTtLixwHejMQTGp+Aqnq7z6rBx40MVkikndH16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420137; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjmoiVDRSHWzAc3k5ZB9yNJyKPOPrdUMA4W9TCoCjoG9sRpRX1qm+3vNynaNkomsvw8mXar6set4FX4LchF2kZcWFoYlmFHA5EelUJh5khtgxNEQ2jK4kk7HkR6HJZDA5dAKiVmuR2vmGvASnr+ZQEWwaU8p/T/BG2iJ1xtIbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ELmb3MUV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ELmb3MUVv5JxshplTpic0E9aSK
	hD1dZIZbTXdK0GqpVqetWlqRIpheHvRH3BViWwtsYuSw9u8fGGzhzGKoTCPfcsZXHSVSAQYN4Bttn
	+ekWy3Y1Er/v8YOo8qiIH/FGc/NHsto6xkiOhHn58Xgnwbg0BH/PdH8C10gCFhTRsW9zAobsH125/
	r15Sg5IKfNHVhCeRIKVfliRyvTHSI/w7kQVqoUXpDtOFIpdwDQAgIUnRX4PWorzMQDl2Mlcj3DbdH
	jRzteTJpWJiAkTjLG0c7WYEY33/FUguBtb5HS+wwAue8wl5gyroLvxGfhg50uvGuUlZRF0SrIqDav
	bMRS1fhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBwl-0000000CXOh-3hB5;
	Wed, 28 May 2025 08:15:35 +0000
Date: Wed, 28 May 2025 01:15:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	djwong@kernel.org, brauner@kernel.org,
	torvalds@linux-foundation.org, trondmy@hammerspace.com
Subject: Re: [PATCH 5/5] mm/filemap: unify dropbehind flag testing and
 clearing
Message-ID: <aDbGJ8IGU0ezzpeA@infradead.org>
References: <20250527133255.452431-1-axboe@kernel.dk>
 <20250527133255.452431-6-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527133255.452431-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


