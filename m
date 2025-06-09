Return-Path: <linux-fsdevel+bounces-50964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BFAD180D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E2E3A3D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262227FB1C;
	Mon,  9 Jun 2025 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L244MnqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548A248F65;
	Mon,  9 Jun 2025 04:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749444046; cv=none; b=QTywr52LE6GJJ0mAuuM6nIk3mtsUjyLJ/x8M2Zf/+nHqmL6yZxQw+bGcXvA8hjSBY/NuaNXgwWKx8F4H7KJID2O4gnPTQie6Imsw2oBtfiE1pSqWerdZO3iUALTJDZpJjXGZDRUlti9cHGI4u4NdzkuLtVOza1aPsBBdPtCSKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749444046; c=relaxed/simple;
	bh=XNm6w/NcQT6xQFrLY0xHOuOd8Ekg1brzlA1HuRcBfXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6CWF4TGiazqk/KvgOm6ZQWiFshLBqF7ipFZKR3WWzVnxxh18CbQxWKZD3V5SXIKtsdnO/36/iosJCJ2ZGvdStzJ7ZWHJDdjdxJhq4iGXpzDDRmvLahQDkw9n16IwbkmXtlO6eV3nqzUABhawX+JkQDhjBE/JPvFsuqbA4ErNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L244MnqP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XNm6w/NcQT6xQFrLY0xHOuOd8Ekg1brzlA1HuRcBfXk=; b=L244MnqPgv/NklFPWGlVBhaw/K
	tkO0grteVRYAC3609a4LP3ddNuss+1QUH/OOMFed+JkiF1heDGEcjLfnhZOWkZBbI+P0qLx2pUcY2
	uQBZZR0+g87OiMy0XDtaNBtKlrtYxd0oBLd9x40pDQnnLl6zpGu84WdxBsBW5tC0oYa/Hs7qDah0j
	FdhKGDFvtiP2SDJSKz0gCY1Iihxga+d3yBy/suiZ16g/pUrf8YOt0fN9VcIRgrwiIK+FWAkQrbIxC
	8WRtPjs85Gm47Ojn/l6ezPisDhObEv6anxDmI0QBDzJf2MYwQ9wn2ard5tte3dFJiBq8uz2QN4PWp
	z3bE+R+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOUJP-00000003QKd-3ZjM;
	Mon, 09 Jun 2025 04:40:43 +0000
Date: Sun, 8 Jun 2025 21:40:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
Message-ID: <aEZly7K9Uok5KBtq@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can you also point to a branch or at least tell the baseline?
The patches won't apply against Linus' 6.16-rc tree.

As for the concept: I've always wanted the highlevel fuse code to
support more than just block I/O, so using it for fuse seems fine.

A lot of the details don't make me entirely happy, I hope I can
come up with good ideas for improvement.


