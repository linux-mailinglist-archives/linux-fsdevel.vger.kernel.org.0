Return-Path: <linux-fsdevel+bounces-65554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A8C07858
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004B51C204F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00BB3431E3;
	Fri, 24 Oct 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MXoETsyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3E30F52D;
	Fri, 24 Oct 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326481; cv=none; b=NOzL8HCfU8bNI29mMgQ6JjNulI3Dt6a2e8DzuWps3IYRMXhALbb8wU0dWdT9Rzox9M0HPyEVbhPNX9XXG+Uyz9wqA1eBjAyZLx0OG4wFdMK11HuuwF1RPzmJZB5zoaFfgn/aBdDCfJuWUEVIRjN9j2Q7A3gAFMvzoHh1E8FzKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326481; c=relaxed/simple;
	bh=YZl+3mWSqSB7EF8WRWN7AJW+TIH9LvMUqfIelgcqYEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SffsBsNGIRKJP1s4A/pt31anukBczJ14Zk9foLqVz9p/3bscgo9Vb2bv4+HX8n1pkFmiNN7BWEyaPQL04ziZK2Qma2nfDoaHcsaaNgsvylcO/iE8MoaIraat5qsMm63cMeKzgsM783FdwoRxDPfyQr1KwbDVqj+JWWjQKvX1P28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MXoETsyv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JYPvwd+/M7IKOYWzMSWfu7+WmaK3zsnJSflXp8kIby0=; b=MXoETsyvYCNdx8oNUPvK4Fsn7l
	rst1wxkVDRrbOkBNCQ726xNw5wcpO8vvv/b78MBDGcMIBEJ1rT1MK/vfuo7ABPKhXUZIJ2TYVRcro
	Pw+GN3kCP1gXP/eWgCDbGowIWfZID/hHhS0HkIjJLooygvjVpyLGix/1kZLQHYJN7Y69WP0hyC/Va
	LxybJnvUiuJCPA6YPQTM2zUjPcI5N7lddAwO7E10B7iApLStMkQFOZSisURlRYwVghSCpW1/QAyQe
	9/FQBK8qnXa6/aVAJdHS13as6b/THvlY9/i2SplKjAJOyfJV4nxpmbWCfhlf5ql4l+MpGmlDSw07E
	BjddqzKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLTW-00000006DjU-2njU;
	Fri, 24 Oct 2025 17:21:14 +0000
Date: Fri, 24 Oct 2025 18:21:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org,
	miklos@szeredi.hu, djwong@kernel.org, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
Message-ID: <aPu1ilw6Tq6tKPrf@casper.infradead.org>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com>
 <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>

On Fri, Oct 24, 2025 at 09:25:13AM -0700, Joanne Koong wrote:
> What I missed was that if all the bytes in the folio are non-uptodate
> and need to read in by the filesystem, then there's a bug where the
> read will be ended on the folio twice (in iomap_read_end() and when
> the filesystem calls iomap_finish_folio_write(), when only the
> filesystem should end the read), which does 2 folio unlocks which ends
> up locking the folio. Looking at the writeback patch that does a
> similar optimization [1], I miss the same thing there.

folio_unlock() contains:
        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
when testing (excluding performance testing of course; it'll do ugly
things to your performance numbers).

