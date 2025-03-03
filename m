Return-Path: <linux-fsdevel+bounces-42938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A296A4C538
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F061889427
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29522135BB;
	Mon,  3 Mar 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2n6JX3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CC22098;
	Mon,  3 Mar 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015921; cv=none; b=pUQesX1mxf/+3wdxtXnq74dTtq+TpD692IQNB9MrN/QVCRzTJ+ffCInT3L430jP/Xc3vrHbVzxuYxQRHl9xbcZLF4vY+Gf5CGCt4gAHU/A63bIMw4vZKjOolfK0L/D5tru5q25GJPqNmpJotB5b76Ate9kuRPkdwoQpIJyc20Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015921; c=relaxed/simple;
	bh=dcw7/Wg389gBfk+L6HK4NCC9yUYaH9SNp9/QspVAY9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwDQZTF2UHeF9fOjFO0tFALBeYAzJKhRF+g+sVKHeTKoMOXRPr1biesi9YkI9JkLLaLspjUup2ZR+rn8PG29+0yXP3wbKhmcrC0XiKbD253Vnztl5qk5nk4E6qQpHOBuJ7By1/CEOk2Dpez0XUFSHUTwoug48HxsL3jM3fE8NTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W2n6JX3/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0HCj62e3BVbAJjKmBPN5KgNHVvDUyyOEB6y36R9K+/U=; b=W2n6JX3/0+Qmr30XQdZNZyV80l
	EfNTJz8rbR+IK/gmOkpdX1ngk3B7h8pj9jgUFrtRJjsX/htjA4npQ5HaTuTxD2yu0imay08aOdKlm
	s6NG+BAGnHWNBuuQ+qD9Es9SuyQDf8z0WVqChoOmPOT+krXj4pIdBaJGoSkDE6mjsfJD+UI6LCrDv
	r0XTKjySecckRI+NzYidVBF1mY91N9N2+YvQhD3VxCiqqx1StxG6t91qL1HYxaGkXosP5Jm8tdiJZ
	KkNfgbjHMtTEy3FASBVkXdKopamNnJy+rf2awCF0NvUatTImE9NMCqV8uE4AbeTC7lz/UuM8Dcfo+
	rdkBx5iQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp7lt-00000001KMD-0hyP;
	Mon, 03 Mar 2025 15:31:57 +0000
Date: Mon, 3 Mar 2025 07:31:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Heinz Mauelshagen <heinzm@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8XLbaXUywNburXu@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <CAM23VxprhJgOPfhxQf6QNWzHd6+-ZwbjSo-oMHCD2WDQiKntMg@mail.gmail.com>
 <Z8XHLdh_YT1Z7ZSC@infradead.org>
 <Z8XJSL-rSLUtx-NL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XJSL-rSLUtx-NL@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 03:22:48PM +0000, Matthew Wilcox wrote:
> Funnily, I was looking at the md bitmap code too.  It's the last part of
> the kernel using buffer heads with not-a-pagecache page, so it's the
> only caller of alloc_page_buffers() remaining.
> 
> I think it should just use the page cache to read/write the file data,
> but I haven't looked into it in detail.

The md bitmap code is awful as it abuses it's own buffer heads in a
way that is non-coherent with the underlying fs.  It should just be
using the vfs read/write helpers for in-kernel direct I/O with a
scoped nofs context.


