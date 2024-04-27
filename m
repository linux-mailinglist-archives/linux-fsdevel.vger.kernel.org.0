Return-Path: <linux-fsdevel+bounces-17959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DCB8B4420
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2189DB21FE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 04:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39AE3F8DE;
	Sat, 27 Apr 2024 04:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hww8PqDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9B405C6;
	Sat, 27 Apr 2024 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714193071; cv=none; b=DdMQ0nc8zHQCgUY5tcdRvcoE8Nx8A1yJpj1TmW2gyjyzzhUsT0sil7hGGIKoXhbkisjVVdEs8i5EwCM4+qF52FrDCxsDWZEYKx16p06b6yE40K2iliBSi2YCciMGc4mmhU25WHLiSdCoCsEKItitp/9un7ZrVhanf5nZjPKn/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714193071; c=relaxed/simple;
	bh=fM+0icHcxjOd5HvMscZat49+YZmTjmzcEp3eWHk0fRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXZjCR5uNCWjH+zHs9O7GDPVUrEXAJBfZAwTH93GJy4CIfmd9y7bGSUSU5KTzMRtG+1vPERVsVfv3Bs5KyL7bbe9hOt0rPoe+OZ+mMRpMxuFPNmGYoGsk/ncqhf6RaVt997sNroILMyVA/tVuoGjY3kfllR2thmf30tvPYqjNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hww8PqDV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fM+0icHcxjOd5HvMscZat49+YZmTjmzcEp3eWHk0fRI=; b=hww8PqDV9qork61Y3ewjFZefEK
	JDU/w6AXdJoz9OdniCjow5WdigZ1u+0yPpIlyzJgm7tltK+Vo/Y1xOHH1Zcy1B5fMOWgxcG6pSQyX
	oVIo2O50RHXBHbSbhbH8T4y1dlcetrwUVBs5Aq6GvvXo1z3UIxWyZcYMZVWkyY9bZAFyHvA7T0RLW
	fFEwJigoBmu4eboGkMdoZG4SCBBapImEldqJKezItfY3iaiKoFUGzAPchfuHuQdbc31oGA+miOKIc
	TP1iQvzTIfiCwE275XEM42jyhTH58v21CX974DWSryl6j6hZAKtuKcaSWKcS2Dgic9cC398QoY1Ze
	kpU5u/JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0ZvF-0000000Eodu-0pSZ;
	Sat, 27 Apr 2024 04:44:25 +0000
Date: Fri, 26 Apr 2024 21:44:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 6/7] iomap: Optimize iomap_read_folio
Message-ID: <ZiyCqZkcRycRiStm@infradead.org>
References: <ZitPUH20e-jOb0n-@infradead.org>
 <87wmokik3m.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmokik3m.fsf@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 26, 2024 at 02:20:05PM +0530, Ritesh Harjani wrote:
> iomap_read_folio_iter() handles multiple sub blocks within a given
> folio but it's implementation logic is similar to how
> iomap_readahead_iter() handles multiple folios within a single mapped
> extent. Both of them iterate over a given range of folio/mapped extent
> and call iomap_readpage_iter() for reading.

Sounds good.

