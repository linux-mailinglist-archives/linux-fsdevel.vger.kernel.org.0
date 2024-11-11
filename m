Return-Path: <linux-fsdevel+bounces-34333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2659C487A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FE81F22D05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509F1BC9FB;
	Mon, 11 Nov 2024 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxWWcxvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518F1BBBE0;
	Mon, 11 Nov 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361703; cv=none; b=bqt0Pul/8TyW0zIVZX7ICzfNLbgZo3iUyy4cHWKK6M3S/+ToLzBzMMII5eqxMkKc5Wxo/k0wFVwAHFQ06xHvzi+YUYj2Ase2usWiaicUA2R0Nw7/WBT+r1u6At3TEsHiEuhBg8aMqlznYEIytvt3JqY/DKZdRCpQD4nUmiPPA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361703; c=relaxed/simple;
	bh=Tow86Lfl+Vd9tTVdz6gfmKuMtjSvcxpy4bKwJWSVcBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsawsyyJZVoaHsECrvuJdQKEVCJ55nm/HE2iQ30tX9f2vhZ2bCm6yXXl7wy99aO9f+KaUNttVAyBstCZzN7A7h8lbpdrSeBG9M+Je0ynBl1ndJmaKorc/c4dhTp6vHp1hHaz1t63Ai98SllOhIgKYmSqTnFaQ28WC97Kv4jE+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dxWWcxvQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tow86Lfl+Vd9tTVdz6gfmKuMtjSvcxpy4bKwJWSVcBA=; b=dxWWcxvQIpuW/reao+4g2RQ4pI
	OwZX/CTm6btiYbBEznUxCKpCU/DBCcx8B/sgFIgXEiGMrEbSWj22Py+w14kbOVRy3IlStoGq6ey+Q
	poSa8+vMnIAbl9r5s5gC79pmqNIMujzQSD1pY2J2JtFQA9ZXxZOR2XYKQQz0D0FR7MKhUys6yrz4I
	CnRDPf/SI+x4iA1063F2tsPebBQXk1Ei/YUG87KHL/P/prZlyBwbCuxMPUuYG+g34Z4JsUhK25kbN
	M90Jwr2iQNy+KIjWJQHEmV5PNaiyVCsEciEokd8qDiKcWfTcIVO4kriNk+Fo56MgFNCpdOTprtQmZ
	I9Rf8i/A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAcGf-0000000DN5J-3wAV;
	Mon, 11 Nov 2024 21:48:17 +0000
Date: Mon, 11 Nov 2024 21:48:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
Message-ID: <ZzJ7obt4cLfFU-i2@casper.infradead.org>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <ZzI97bky3Rwzw18C@casper.infradead.org>
 <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com>

On Mon, Nov 11, 2024 at 02:24:54PM -0700, Yu Zhao wrote:
> Just to clarify that NOREUSE is NOT a noop since commit 17e8102 ("mm:

maybe you should send a patch to the manpage?

