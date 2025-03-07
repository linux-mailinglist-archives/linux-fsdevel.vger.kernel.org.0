Return-Path: <linux-fsdevel+bounces-43483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA0A57313
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 21:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A623AD83A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75932571DD;
	Fri,  7 Mar 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vDGHzYNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8523E23D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380528; cv=none; b=CzWsX4cyrnlfPqUzIFy23rNQ7ke+hJM/aqb9205595b4J04U8X3FGAwsRwC3E/emwKff+NzuiRKi9cORSyorgsbWdv52jqapnAZdmPaLovxTF0jrUaGmrq5ncEsElG2ZhJInzgS/v9cRYRrINK9JloP0T0D4F79hz0Ntia6UiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380528; c=relaxed/simple;
	bh=RvKwtuDvjbtmyqS1otB0FuD19vZ1wjpw0lzBB1XiSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srTcoW8Gfvj49zbZ7PyFePX9Lx9gs181JghpCJVPGqeR4ZCmWvDlivDO3e2yL0IOiV7aDf8ro5Wrbb4ROFizWhsusC2sW7SsdZ9lUxNkTjVgcBDW8WOAaT9Mnfnkd8+WKCJLS4RllHpekgPxUS0XhlHyHZ3B5qIbA2LXUOyfDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vDGHzYNI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DzIhgr18pG7inFFCWSj6rwK5m9SNmaNVTpsZcfEKO54=; b=vDGHzYNIxhx6SKCaNWWWlzymC9
	wJyDVgZR7JDqttPhUiGii1N62V1GYmNewjYtvECa0SDIQBn4NfmpjIKx2LraBfPxeJT/4u+0pgxwQ
	xyArswHyBbYAosFs82jKkKfJ/r0BQOzxA9xxqBCwexybJJZezwkn1pWlPFZyfGyfJ43PwYuvpA/bo
	ZwniM2oVPFspHBaJWLLEzI6dpEu/XTGdcf/CxvdsWZhiTUzo1n/pUjAMH6CGDIYWBJU9Mg0H3Mi8m
	OWxAc1Fc8ubMX8GXYGzMLmOOWnwMhU+dVQW4YZt0gz11MiBcfX99/jYzNrxLOWMsTwT8Rf0RdwQzP
	FTXli0PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqece-0000000EOs1-1bNF;
	Fri, 07 Mar 2025 20:48:44 +0000
Date: Fri, 7 Mar 2025 20:48:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z8tbrL1OKN8pqhNe@casper.infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <Z8tZnN-CAS20Dpi7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tZnN-CAS20Dpi7@google.com>

On Fri, Mar 07, 2025 at 08:39:56PM +0000, Jaegeuk Kim wrote:
> On 03/07, Matthew Wilcox (Oracle) wrote:
> > I was planning on sending this next cycle, but maybe there's time to
> > squeeze these patches into the upcoming merge window?
> > 
> > f2fs already implements writepages and migrate_folio for all three
> > address_space_operations, so either ->writepage will never be called (by
> > migration) or it will only be harmful (if called from pageout()).
> 
> My tree sitting on [1] doesn't have mm-next, which looks difficult to test this
> series for test alone. Matthew, can you point which patches I need to apply
> in mm along with this for test?
> 
> [1] f286757b644c "Merge tag 'timers-urgent-2025-02-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"

Oh, you don't need any extra patches.  The ->writepage removal has been
going on since mid-2021 (commit 21b4ee7029c9 was the first removal, I
believe).

