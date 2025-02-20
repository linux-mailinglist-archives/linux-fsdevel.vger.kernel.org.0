Return-Path: <linux-fsdevel+bounces-42192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B054A3E85B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F263A9F05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D4267384;
	Thu, 20 Feb 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NH2vTtUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FB1D5CDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093876; cv=none; b=hmC9D/nqHsHWfgCmLu4qRGJHP2ZF7+zDcO2ThXFNvYTeJeuW2WArHWHz6wOzp3Kfzb+fTkfYNmRO8/VWaFpMLUWHJCvqBmW2DpwEvUD8mFzwNqu0QDefmjr5XTUsL0cej6XsSoObtl2dOwQWo0IC+zpvszXmovwZcP+FULkMtRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093876; c=relaxed/simple;
	bh=TLpQMbcNTVQKjroWSkPOq883MBKd0o9XWAEJCU1kzcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnogP2IewCC6vPoExJoEJrHltJTnfXYu57mDU4GGY1MOSlJ21VGf4ZteFVu3tw3ejHpvMvZqE61g0DqDy/20/Qn+1RJ269fpLl/Pd51PO8QpQf/PgrT89zY8g7LSFPT8BgoAKuq7+HdeB8YwR5rati9bLbdq4d+vIacSG1cfDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NH2vTtUB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N5p+10xtV2EZCf0Am0cAPbuFQJ6oETqk1Rm+C1CZow0=; b=NH2vTtUB8IbkKCmWGy15m8Vby9
	JTOU2bgfcOwTEe9+GSpzTRw6Jw8F5yEExRe42pJ+Bf9YopkTp1fGyn+Y0Ewa+HiNMEfaYW995wSWO
	ejeOjbMoL7CbIyPbAlS6VQ1ujwEVtysysC+2R8KWLDXe+7PMNUA322wXM8X08bAg1YgraV+yNM6jp
	RHkvJ/kjhxqCBTEQPkOHi/Py80RLAU1nUye9UQBRXUfzHWRyjaAhOowUolWeygChIk+BRbRkcgnoC
	fuNaJBmKFI01LfXVEwhheHO2PnbpwHOOykY4mgvOYbh/L74wUleRfqJbdyRlUcmELPZl6gJXQjHah
	rSLbMsJg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlFu6-0000000BIW1-304g;
	Thu, 20 Feb 2025 23:24:26 +0000
Date: Thu, 20 Feb 2025 23:24:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: check for folio order < mapping min order
Message-ID: <Z7e5qkGm7Wt0C3Vp@casper.infradead.org>
References: <20250220204033.284730-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220204033.284730-1-kent.overstreet@linux.dev>

On Thu, Feb 20, 2025 at 03:40:33PM -0500, Kent Overstreet wrote:
> accidentally inserting a folio < mapping min order causes the readahead
> code to go into an infinite loop, which is unpleasant.

We already have:

        VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
                        folio);

If you're not enabling CONFIG_DEBUG_VM in your testing, I think that's
an oversight on your part.

