Return-Path: <linux-fsdevel+bounces-59929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A4B3F471
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118927ADA52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6FB2DF139;
	Tue,  2 Sep 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ktk3Vikv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961854652;
	Tue,  2 Sep 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790515; cv=none; b=dV1uWhLJ4bhoTI8lsvQZcRmMT0VfYvad2VO57qxuBd9llzqKBllvOVz6SCevsU4VbGQ1ivXHBKUHjkrYhgTrBwqcuZmD4jM6IFxY5ix6lGBNWNmxrX3Sgd9NNHpbR3toNUgjrMZJvcg4nWZzKRtgPA2kJSdi00j9cZxwvy1jsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790515; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPuaeQba0jpeVv1bXXeUseVrGUgPYmIM9mW1nOHuEk8DMh5uwHmdJ8vKliknmpS9u+66wG+D4szRk0ibpP+4u9uvjAutmgF4FwKUGEnMNcqNQr20s/OY/armp3cFeYx4e2CBIvhKD8cHtfIz1ZzP5ZCEnrpDP0rGbdqaJBiwUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ktk3Vikv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ktk3VikvUSb3bqBMDwmSpKSyRl
	2jWhzTx6XspZfuDMGCfKaIOpsfS1amKYOTXwQOLqiuf1Dz3SX7BoK6ctE8837oAipiLO45BXbqKsj
	Hs4U1bHPkOUcTxJYDSiuEFA+STCwkluPlgjc8gqXlQ+5Ugk3U/gIUZxNVtruszl2gKuqbGKdckR32
	8mkt1psJizKYAX687PlIZOANkTDTkGzph+5eGxIioc7PK6iUhoOxCSqoiLvPWmxRh3nSU+5sOkRU7
	OmSmxN23th6HEPTas0Qnuog9ukX7ZjyD2HkpIxGMzlUaGZs1H+NDqUA67lq61iqotxagDgbdygn+R
	eXVo2aQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJSn-0000000FIXf-25n7;
	Tue, 02 Sep 2025 05:21:49 +0000
Date: Mon, 1 Sep 2025 22:21:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <aLZ-7TG2OvC5tazU@infradead.org>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


