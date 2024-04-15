Return-Path: <linux-fsdevel+bounces-16905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3B8A49CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D71B22BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92836120;
	Mon, 15 Apr 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m4YjkR3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883594C6D;
	Mon, 15 Apr 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168499; cv=none; b=K3FRaU2gteCKQBu6j85GFj02uB7yFY276LJqIgNjFPmcU2D/AgwRxUWv3TGNbEA5/+iHd9lXE3XHRdtsR8c3fjHNmaqY73O/EK6dlkuvzsC95v0DwZb8xzcFWu6KUiBL9D8Hl6F7184+PymF4IaWy8hyMVnSVKX+9PsIQfwzXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168499; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmy6hP9aPpO+ZzuznMyH1SwP41vR1JbzE6EnESa4RYcuid4gWIck5gyRvj3A5NbxLk8ZxUa5aKixiPe2rg3oLj5nCUJaFwpkBaJiuBGagAvdavE9hErBeXFAePmi6O7YHAodLmHDvuAPToNKchHZ27llAYWIhBqhv5ODhlG6IC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m4YjkR3b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=m4YjkR3bfy4c8whbfrXp5STY4T
	SL3D9WBKzR2trBaLtI2K52HqVL5k7VFf6PdRwOt6IZdKP9F8ApJQ32zvG3ehdbr30MrV+qCCRtpjz
	OKbQlE99wFF1LtafalTxPsJkiAKhe00uUNMlU/83hyTGuaV8KND3SPG02HYiAN19osBZnSK6A3avk
	wxKBtiK0zhvojIdS2XcTpWdFwIkZgW9Hy22I3ErOroERBDXTCxuGYuhQOeyAgtBPoz5qJs8n2zHgM
	xUyFvfOYcg9O1TIvdjVsHd5c7c2US30Fp7JNBR97BrUjzmOPHzUqx9WaX1r/YeHPowu/bKkUjJ37g
	E9tf4FYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHNw-00000007TQb-416g;
	Mon, 15 Apr 2024 08:08:16 +0000
Date: Mon, 15 Apr 2024 01:08:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <ZhzgcIZCejASfdqC@infradead.org>
References: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


