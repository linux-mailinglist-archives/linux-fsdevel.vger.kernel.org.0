Return-Path: <linux-fsdevel+bounces-29793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C867897DF98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 02:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8AA1C209CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EC18DF6A;
	Sun, 22 Sep 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FjRljN6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD618D65F
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726965376; cv=none; b=BnrkwRl9WlY4dUMIjmdkaDnvTG04u842iyDGVpUqH1tehn9Ttke8yRsWinCSgTKPRNLDSsc3hobq6mYmM2SyPaspHHoW/Xmlbp95ac2HKVrg7v6863nXkKjRgetiKWEyOdh6gxGOA6dSL70SHdc/EEFJq+vFRnl7msucy5cCfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726965376; c=relaxed/simple;
	bh=39GowlBBQSedF+68dRpL98HghWpQWyWwVJLY/9a5Sig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBcxXRqzRrKGAE5y4gCpWNc6JibjgX8QFsKnZj0h7zNHgQs0DurW50jUOZzIc/+rFpsyhX71mRA0AfCm7VsMKMAyFI7yA3liGH+5eBGkSZ+Klu2jk4+/PrDSB8RiLFSlgdN6ZftdeFAsoZWg6mCg6vrRdqfLlvvqTwbRA51JMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FjRljN6Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XMtvylaUwwhb/kxBPvNcJGl3QJuXFbLPE2VHYOWXK/M=; b=FjRljN6Z6a1USemY8N922JVxdM
	wzAyFjoq7xsZoI7wexO7z3GCyDTdQxkwU4nK7/FBIKik7q+Ug+lhBOJqUwe8WqjpVLMhhMaaPZyRc
	ju8CqjZppZha6L2SokGc7VmhviIrox8Yue1waTic+dnfKID2fSYJER1YazPxweVko1s8CPnFRGxYu
	bZfG+0beBblSFaQ+eyXDt1lzYwVz8OrCws/lIynf082lII2/1sm8WIkb2WH6JyaLKs1M1Nvod+TO0
	XDb0mZu1/fYuBIzt6e9sLP83Ym2tpWaU6JHQ7alBku7EqTMGfWczVRrfztxElBUt+GvX4eVdfDeYD
	oZhidbbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssAZw-0000000D8zN-1xro;
	Sun, 22 Sep 2024 00:35:56 +0000
Date: Sun, 22 Sep 2024 01:35:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
Message-ID: <Zu9mbBHzI-MyRoHa@casper.infradead.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>

On Fri, Sep 20, 2024 at 10:36:54PM +0800, Kefeng Wang wrote:
> The tmpfs supports large folio, but there is some configurable options
> to enable/disable large folio allocation, and for huge=within_size,
> large folio only allowabled if it fully within i_size, so there is
> performance issue when perform write without large folio, the issue is
> similar to commit 4e527d5841e2 ("iomap: fault in smaller chunks for
> non-large folio mappings").

No.  What's wrong with my earlier suggestion?

