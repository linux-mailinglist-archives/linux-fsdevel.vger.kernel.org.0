Return-Path: <linux-fsdevel+bounces-38986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98325A0A8E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF271669C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF81B219E;
	Sun, 12 Jan 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BG2WxpxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650E1AA7A6;
	Sun, 12 Jan 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683343; cv=none; b=qSkLg2F+vJ6E6nMEFHSruYabosYYSB3+psWCrfsrq5CKMvnbLRDAULu0XqfX3vksCKur3C35tZcsh/Cw2xYW8lWrPYOIMcEsY/6AAhbbE8eJC1ZHary6mvA3k39+WUQzkloS9qvFNJ6/ZgCxyrUzinI4+aAbFucpJt2rq1T5GKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683343; c=relaxed/simple;
	bh=ez3gEv6R3IZlpumoFaoHdmDssYzFjciKI/ZKJWSzhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYf94i0Cusf5GR8ZJCFfvTHACPKtJ0t+nui5x9xVA0kFHnIl3X0Un1DmKz3zSZjLARTV7T3ELSmM7rAAzt8PiwYUm4U6+ryTMWoidYtoLTaRXMBmuovG12iV8gM3cmhQ2514f/et0xdzW28+dgvPx0gfQWKngt8FRsR+QMSVF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BG2WxpxE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mINOFD/z3wJJsYIblZcazetsQ/fwmJD/fCcLc2fXueY=; b=BG2WxpxEW6964q+g1ejYxmigMt
	wmk+HS+jx0f0Bq4I2skTCrODifdH9+bjiaU9HhtnH5TXnF4A2kRTiCM+/2kSgeqUh1SVfQj17QeiS
	QO//EDvMO216OzEAT+mPLXABn9PgBfbgeSx5XWKyEGxIaqbiMNvT/GximzAubaHaLJ62I4VRCLhLv
	cm8GoQ/Z2KbG8AzCEQuznBl/j2jeWQggYbih9g78YAXwS5YjcqKJICirRXXSML5qoMmDJ+ymxs11m
	3YPhl5rOq6ZHSM55nCua9CzFVP13YK239en6LcyTC8OnsYG60VqZy+gBeXev9Kg96DrfsYHgWeKAX
	v4Dzq4xg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWwfS-0000000GVo1-00Vt;
	Sun, 12 Jan 2025 12:02:10 +0000
Date: Sun, 12 Jan 2025 12:02:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: hch@lst.de, jlayton@kernel.org, kirill.shutemov@linux.intel.com,
	vbabka@suse.cz, william.kucharski@oracle.com, rppt@linux.ibm.com,
	dhowells@redhat.com, akpm@linux-foundation.org, hughd@google.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug: task hung in shmem_swapin_folio
Message-ID: <Z4OvQfse4hekeD-A@casper.infradead.org>
References: <F5B70018-2D83-4EA8-9321-D260C62BF5E3@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F5B70018-2D83-4EA8-9321-D260C62BF5E3@m.fudan.edu.cn>

On Sun, Jan 12, 2025 at 05:46:24PM +0800, Kun Hu wrote:
> Hello,
> 
> When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (42s)
> was triggered.

It's not a crash.  It's a warning.  You've just configured your kernel
to crash when emitting a warning.

What you need to do is poke around in the reproducer you've found and
figure out what it is you're doing that causes this warning.  Are
you constraining your task with memory groups, for example?  Are you
doing a huge amount of I/O which is causing your disk to be
bottlenecked?  Something else?

It's all very well to automate finding bugs, but you're asking other
people to do a lot of the work for you.

