Return-Path: <linux-fsdevel+bounces-12520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C88603B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 21:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A3EB253B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BF71747;
	Thu, 22 Feb 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dEHGEePX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB514B838;
	Thu, 22 Feb 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634264; cv=none; b=cghE213EreylWuzTNJxdZvYhkqqmeRMefqmB59EjyCiHW1spNM8XMDES88hseAyDHg40pPG3gHQVuMITycqLBajHL+F0qP4XAi9Cw5wXaY0B0j//KW7qg5PY0thiOlpXuiTs0n8wEjjhysiI3JNfF+ao6QwtXC9fvHXM78/O5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634264; c=relaxed/simple;
	bh=etmoFvC0jzrVfBtm2Oi+WKPEjzsrOdltXvFIbHB+jOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtuicI4C+Lyi9ms5uRWAvjIcSDpX8tUdK6HXuM5KdaaCT2QEP+3wF/WeKpwWZiSv30qDcMXQlVl1RE6AqEA/IxFSmmCKSW68BbBlnJfG0uNSVO+2WYJfg17bZ0smNMNwvY6odvxq79k+LnAoGVPKKW1+KZO5KEPllpZb1RSl+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dEHGEePX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=btPG773oXTDOg4O/9cAMX0cN9VDh0j3lO20yvkkL30w=; b=dEHGEePX9yBXi8zsNzEeIC5QmR
	ckp11koQLTVAEDXvJZqV6U9qFUwpfmcT7lVr5y1jZGeC2IaLihqNc3lB9PNNPC7tkO438rN9PjQPr
	jCHLyC2nUc8Zrb5N1zT1VEcEarXcewmQ1P8danAgHG6vzK3uf1O9D9uBuiPaIaNHtPBuD5b1ReZqj
	rGyJqjFBl4S0ilMQFOdRWFmfLYdbTGfCz3cgh+9Fiok4n92F5NFMA7+V/2ofcWKAZpJnjB6Bc9Rk4
	s9hDgEBWdZyT7k0bMNvfi6lkqYTshyzJbRlIPLcNWD8s9Or/LN8HdWLD3fSLNdmiULCKXHytfgHL5
	/aswRtIA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFp0-00000004ceu-03QG;
	Thu, 22 Feb 2024 20:37:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	rcu@vger.kernel.org
Subject: [PATCH 0/1] Rosebush, a new hash table
Date: Thu, 22 Feb 2024 20:37:23 +0000
Message-ID: <20240222203726.1101861-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rosebush is a resizing, scalable, cache-aware, RCU optimised hash table.
I've written a load of documentation about how it works, mostly in
Documentation/core-api/rosebush.rst but some is dotted through the
rosebush.c file too.

You can see this code as a further exploration of the "Linked lists are
evil" design space.  For the workloads which a hashtable is suited to,
it has lower overhead than either the maple tree or the rhashtable.
It cannot support ranges (so is not a replacement for the maple tree),
but it does have per-bucket locks so is more scalable for write-heavy
workloads.  I suspect one could reimplement the rhashtable API on top
of the rosebush, but I am not interested in doing that work myself.

The per-object overhead is 12 bytes, as opposed to 16 bytes for the
rhashtable and 32 bytes for the maple tree.  The constant overhead is also
small, being just 16 bytes for the struct rosebush.  The exact amount
of memory consumed for a given number of objects is going to depend on
the distribution of hashes; here are some estimated consumptions for
power-of-ten entries distributed evenly over a 32-bit hash space in the
various data structures:

number	xarray	maple	rhash	rosebush
1	3472	272	280	256
10	32272	784	424	256
100	262kB	3600	1864	2080
1000	[1]	34576	17224	16432
10k	[1]	343k	168392	131344
100k	[1]	3.4M	1731272	2101264

As you can see, rosebush and rhashtable are close the whole way.
Rosebush moves in larger chunks because it doubles each time; there's
no actual need to double the bucket size, but that works well with
the slab allocator's existing slabs.  As noted in the documentation,
we could create our own slabs and get closer to the 12 bytes per object
minimum consumption. [2]

Where I expect rosebush to shine is on dependent cache misses.
I've assumed an average chain length of 10 for rhashtable in the above
memory calculations.  That means on average a lookup would take five cache
misses that can't be speculated.  Rosebush does a linear walk of 4-byte
hashes looking for matches, so the CPU can usefully speculate the entire
array of hash values (indeed, we tell it exactly how many we're going to
look at) and then take a single cache miss fetching the correct pointer.
Add that to the cache miss to fetch the bucket and that's just two cache
misses rather than five.

I have not yet converted any code to use the rosebush.  The API is
designed for use by the dcache, and I expect it will evolve as it actually
gets used.  I think there's probably some more refactoring to be done.
I am not aware of any bugs, but the test suite is pitifully small.
The current algorithm grows the buckets more aggressively than the table;
that's probably exactly the wrong thing to do for good performance.

This version is full of debugging printks.  You should probably take
them out if you're going to try to benchmark it.  The regex '^print'
should find them all.  Contributions welcome; I really want to get back
to working on folios, but this felt like an urgent problem to be fixed.

[1] I stopped trying to estimate the memory costs for xarray; I couldn't
be bothered to as it's not a serious competitor for this use case.

[2] We have ideas for improving the maple tree memory consumption for
this kind of workload; a new node type for pivots that fit in 4 bytes and
sparse nodes to avoid putting a NULL entry after each occupied entry.
The maple tree really is optimised for densely packed ranges at the
moment.

Matthew Wilcox (Oracle) (1):
  rosebush: Add new data structure

 Documentation/core-api/index.rst    |   1 +
 Documentation/core-api/rosebush.rst | 135 ++++++
 MAINTAINERS                         |   8 +
 include/linux/rosebush.h            |  41 ++
 lib/Kconfig.debug                   |   3 +
 lib/Makefile                        |   3 +-
 lib/rosebush.c                      | 707 ++++++++++++++++++++++++++++
 lib/test_rosebush.c                 | 135 ++++++
 8 files changed, 1032 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/rosebush.rst
 create mode 100644 include/linux/rosebush.h
 create mode 100644 lib/rosebush.c
 create mode 100644 lib/test_rosebush.c

-- 
2.43.0


