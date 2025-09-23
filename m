Return-Path: <linux-fsdevel+bounces-62473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D8B94272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 05:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1440D2A5D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EA2580E2;
	Tue, 23 Sep 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EIaeeEoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DAAD24;
	Tue, 23 Sep 2025 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599363; cv=none; b=n0DHQE2MKjqpQIPhSGZPmxgGOmvcF3pjvYiyWs0DsG2KDIX6QeXppaAGky/FZNgk7b+nBPOTT4TRTPvXTXRuujWcAnxOWbCdyi/dg/7v/ZvxxK9dHtLG9iKYODU5dKqutA06862FsmHOBZGrJpLoA685ATginHztby8IHITfoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599363; c=relaxed/simple;
	bh=sbacde5IymS4zt+PGppvs/FCiZ+f8/Siy/4gHLV/nA4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QsgSUQVQ6aKXBCbgD/9oAtOK56iZ+Ygrm+JABfu4w0qBilOgni7eOGStMYTaHnc6yDyd098AP40sxUPmu/DmYWnByIUCLDhUE92lezFotYIYgUieH3lHSunFvAqSqD/rGNMAbK+JDXv7/OV1QSsm65mBgl7xmaDxYTqC+7iOJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EIaeeEoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A650C113CF;
	Tue, 23 Sep 2025 03:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758599362;
	bh=sbacde5IymS4zt+PGppvs/FCiZ+f8/Siy/4gHLV/nA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIaeeEoBduPf96ORvfIJNMSLaqJgIRWO/INJuf3A34PfOahvpky4EyMCRd75MFVC1
	 TaoN2Vdk/qp1jn6U/ybWSUZkyf6GH6cdxHVaZayivCjl1Cd6yB9eN0oQMLRQ2xAaTy
	 HZ/Jyxanb9JEKifvsIJqPsuLLOU/bjACVUICbgS4=
Date: Mon, 22 Sep 2025 20:49:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Nanhai Zou <nanhai.zou@intel.com>,
 Gang Deng <gang.deng@intel.com>, Tianyou Li <tianyou.li@intel.com>,
 Vinicius Gomes <vinicius.gomes@intel.com>, Tim Chen
 <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Roman Gushchin
 <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
Message-Id: <20250922204921.898740570c9a595c75814753@linux-foundation.org>
In-Reply-To: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 11:59:46 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:

> RocksDB sequential read benchmark under high concurrency shows severe
> lock contention. Multiple threads may issue readahead on the same file
> simultaneously, which leads to heavy contention on the xas spinlock in
> filemap_add_folio(). Perf profiling indicates 30%~60% of CPU time spent
> there.
> 
> To mitigate this issue, a readahead request will be skipped if its
> range is fully covered by an ongoing readahead. This avoids redundant
> work and significantly reduces lock contention. In one-second sampling,
> contention on xas spinlock dropped from 138,314 times to 2,144 times,
> resulting in a large performance improvement in the benchmark.
> 
> 				w/o patch       w/ patch
> RocksDB-readseq (ops/sec)
> (32-threads)			1.2M		2.4M

On which kernel version?  In recent times we've made a few readahead
changes to address issues with high concurrency and a quick retest on
mm.git's current mm-stable branch would be interesting please.


