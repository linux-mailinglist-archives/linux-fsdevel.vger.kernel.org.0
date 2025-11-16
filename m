Return-Path: <linux-fsdevel+bounces-68597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73100C60EAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8EF3AEF69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481971EF0B0;
	Sun, 16 Nov 2025 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jy3Npjg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93612CDBE
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257646; cv=none; b=K7Db4ddXoa8FgCz1GbXkqhrnUoWV7z83LoDKWeR9QzXXoZutRpWYc3ceRKXKwfZSTcYPQ+50w98EFTXXcoZ3wuTMpS/dK4+oCRxVt1Di6UivT3rldGTr2U5b7Umb27piqdYyBxO9YzFwdqhXHLmUEQQUHRn8BEZNGOZuiKUk+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257646; c=relaxed/simple;
	bh=3YmkYMHBzoOF5Pepux3Fi5TSrOEmam7XgDA9wu5lcfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qeFbz3eRUvLut0RQiEIgjnrBF9D4S449ZLQ+Ts3WV0S81GBZjpquH6F0ucncw+kL5dk03yDn+eGsl08+vJJn398DwcC+EpinNx4dgrimoS/burr0Kr4Bj0BuUDSKStnad0MD3fxr7RJoLIZ2l1tmbZEIiJmMzepW52V74TCVNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jy3Npjg4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343e262230eso3956703a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763257644; x=1763862444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+XqlIsMDWzYqc7JguFqNqhha1T5Qhe5Y6rEy+19C3o0=;
        b=jy3Npjg43xqcUKkLWNSlWhqesNaMOGjNVz5002np/oVXRQSYi2U0fLJInJ6daFV/2D
         CuU6FTwQdzzZdCB1i0IlGVa5z1IdyFUvf1FYshlLFCpIXhA/UYKktUg8m7zPaBIejuH1
         X3ffPewdSsoDHuFKDrVldYs/JowoEoeS7CNPpOTBf9z2UNqF8AeJpv5Iv01wkoc+yh2D
         u/hqacFuuoc+Pprz88aN9rKVlUNulwYAsmKxCVs2Um11DpPNTPDk6W1qV31NBX9/0LWQ
         IvVsrwnxWu/1jksmjOlzBBAldF2fH8JvibTyk7IPUrRLp6JN5tSOi0GdFDLWyVoYGzqA
         G+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763257644; x=1763862444;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XqlIsMDWzYqc7JguFqNqhha1T5Qhe5Y6rEy+19C3o0=;
        b=o55SV4jnWxdmkNHL3CAVsnmaBogJrZkCqGJskn1Ovu9Sn1pKGrDYzi6EMIJk1Itnx8
         xo/N+CSNA/3umfa6oKCJncym58/qVxOMT+noLRyDMqUxIPxgHN3dik8/gFbPJ98fPhnt
         b/1pxkkAvrXrABMpx7MqASQINRWP0Uny3xoJsyUDufHcjbe3YauukbnOufOqKo49K4LI
         saDmA9InM8kuD6nLs1dsEM85OMnb3+bdiNXsRMAYzfnkJs6AJRMWcTN03ZSJGartL/5F
         6MqxcGMEe3ldHZ6HVi0fGEdnEgr8XFF2189iJEbc/C4BjmdqMrdtK90HK4hdpudBK8PR
         nokA==
X-Forwarded-Encrypted: i=1; AJvYcCUR7JeR9EeICMY5eZFSs1NQ7oA0XVjwcNVcOw2Z2iLaADpk4MmVc4sfQM8bx3l9xco5BtCoyYKMmkZnLOJy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4f2AnGjXvpu00Jh5HZahZn0z403hBjMVQd4rUWLnTSrfh2vZC
	1uF+MiJMDMV1xB5X6Ta+6cSPkRB57Cn7+ODVn3y2mTSSRf+Rl2S1ehQ2dQRJl/7ePFTQvdDd66g
	DMmYydIQrn3LKng==
X-Google-Smtp-Source: AGHT+IEsv7NHXWIs6Yu2rkIffMNoH1XQYTEANQjz5QTzo7SXbZIR8OEsdNaEZH+xmUiMVSFZfyDJEvVIa8rVaA==
X-Received: from pjub12.prod.google.com ([2002:a17:90a:cc0c:b0:340:d03e:4ed9])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3bcd:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-343f9eb4416mr10268299a91.12.1763257644392;
 Sat, 15 Nov 2025 17:47:24 -0800 (PST)
Date: Sun, 16 Nov 2025 01:47:19 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116014721.1561456-1-jiaqiyan@google.com>
Subject: [PATCH v1 0/2] Only free healthy pages in high-order HWPoison folio
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, ziy@nvidia.com
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, william.roche@oracle.com, 
	harry.yoo@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, jane.chu@oracle.com, akpm@linux-foundation.org, 
	osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

At the end of dissolve_free_hugetlb_folio that a free HugeTLB
folio becomes non-HugeTLB, it is released to buddy allocator
as a high-order folio, e.g. a folio that contains 262144 pages
if the folio was a 1G HugeTLB hugepage.

This is problematic if the HugeTLB hugepage contained HWPoison
subpages. In that case, since buddy allocator does not check
HWPoison for non-zero-order folio, the raw HWPoison page can
be given out with its buddy page and be re-used by either
kernel or userspace.

Memory failure recovery (MFR) in kernel does attempt to take
raw HWPoison page off buddy allocator after
dissolve_free_hugetlb_folio. However, there is always a time
window between dissolve_free_hugetlb_folio frees a HWPoison
high-order folio to buddy allocator and MFR takes HWPoison
raw page off buddy allocator.

One obvious way to avoid this problem is to add page sanity
checks in page allocate or free path. However, it is against
the past efforts to reduce sanity check overhead [1,2,3].

Introduce hugetlb_free_hwpoison_folio to solve this problem.
The idea is, in case a HugeTLB folio for sure contains HWPoison
page, first split the non-HugeTLB high-order folio uniformly
into 0-order folios, then let healthy pages join the buddy
allocator while reject the HWPoison ones.

I tested with some test-only code [4] and hugetlb-mfr [5], by
checking the stats of pcplist and freelist immediately after
hugetlb_free_hwpoison_folio. After dealing with HugeTLB folio
that contains 3 HWPoison raw pages, the pages used to be in
folio becomes one of the four states:

* Some pages can still be in zone->per_cpu_pageset (pcplist)
  because pcp-count is not high enough.

* Many others are, after merging, in some order's
  zone->free_area[order].free_list (freelist).

* There may be some pages in neither pcplist nor freelist.
  My best guest is they are allocated already.

* 3 HWPoison pages are checked in neither pcplist nor freelist.

For example:

* When hugepagesize=2M, 509 0-order pages are all placed in
pcplist, and no page from the hugepage is in freelist.

* When hugepagesize=1G, in one of the tests, I observed that
  262069 pages are merged to buddy blocks of order 0 to 10,
  72 are in pcplist, and 3 HWPoison ones are isolated.

[1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/
[2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/
[3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
[4] https://drive.google.com/file/d/1CzJn1Cc4wCCm183Y77h244fyZIkTLzCt/view?usp=sharing
[5] https://lore.kernel.org/linux-mm/20251116013223.1557158-3-jiaqiyan@google.com

Jiaqi Yan (2):
  mm/huge_memory: introduce uniform_split_unmapped_folio_to_zero_order
  mm/memory-failure: avoid free HWPoison high-order folio

 include/linux/huge_mm.h |  6 ++++++
 include/linux/hugetlb.h |  4 ++++
 mm/huge_memory.c        |  8 ++++++++
 mm/hugetlb.c            |  8 ++++++--
 mm/memory-failure.c     | 43 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


