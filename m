Return-Path: <linux-fsdevel+bounces-29464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B5497A20A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338EB1F21374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA173155391;
	Mon, 16 Sep 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sgmvMot3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827613B79F;
	Mon, 16 Sep 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488999; cv=none; b=IzzHfhK7jSHyXFA7NpDwWy3gsye9OiqgKraIHC0MDnF7XBsYUdxQrckw1ThC4cNpQiqu2+e5Dqc9Wv1gpq8cOJjKfpNX2Ott1pi6LJN6CNIg9dg3Iu0eA7ypJDmsMfjUhfBmO1NhBNbgHOwOr5wrqa3jtkNXlv7oMahhq9regxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488999; c=relaxed/simple;
	bh=O8sjaISbl65n+BzqV+pJwtzwzFEpUSGLHm3v6urMSRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGjCqEkxThttKsl1ijQK5kUq26jMIWVoc+G5UIwJ+QoY9dKG2Ve1UU6uTp0cvtfobs3LB7vHvpEq871LUueuxO+vKW+2YYFI3a/48q1FqhePGTB3szY+kvZyJHp7v0Mn5nlPDYnpF7ZS0GOCXOcavEDrlkcWo/m4e2xuRWHQxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sgmvMot3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5+42I91UHYKbpgVx0xLKFPyOFyQqdWJW5R7685LO37w=; b=sgmvMot3ZHHizrleAhYxMOo3G6
	JlAD+NDucC/p5agSkNDRl2mQXxvpv5fBLBVQ8EGVJLX6DLez6TuyhUbUDGn8A00GvBk2wDG3D3wdC
	mvzQHO9okA7q74Uc49t+p5E7fuyA/0pSlgPngtoNq8mkPrUy4vsdDWLBbFsnMDdCcV6Rw+eUt4Lvi
	fraBqrrLdHsiXgJAp8va1X9SVk3FlKZYDzuh5AL5791nHt/obNV4Yit6AuVi2OcTv0D1tS/PINixh
	mtm/bRp4ZRrCLEMJaM5wakM3oxu0wIUjzRVZX2zqMyLTSv9OcSHDFDz9575ooyf8hS9tEwJf8/EwM
	qY5H9Y8w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqAeW-00000001vRN-3pyw;
	Mon, 16 Sep 2024 12:16:25 +0000
Date: Mon, 16 Sep 2024 13:16:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Theune <ct@flyingcircus.io>
Cc: Dave Chinner <david@fromorbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, clm@meta.com,
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZughmB3uLbFAWnOa@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <686D222E-3CA3-49BE-A9E5-E5E2F5AFD5DA@flyingcircus.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <686D222E-3CA3-49BE-A9E5-E5E2F5AFD5DA@flyingcircus.io>

On Mon, Sep 16, 2024 at 09:14:45AM +0200, Christian Theune wrote:
> Also, I’m still puzzled about the one variation that seems to involve page faults and not XFS. That’s something I haven’t seen a response to yet whether this IS in fact interesting or not. 

It's not; once the page cache is corrupted, it doesn't matter whether
we go through the filesystem to get the page or not.

