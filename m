Return-Path: <linux-fsdevel+bounces-29117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF997598F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7231C2240F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD481B3F3D;
	Wed, 11 Sep 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MyjsxIDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C41AC8A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076299; cv=none; b=SibUn9Ujx0rh9BlSbH2RUDKZ3lPABht7FdIU/OvjS0h6CYlRNdP5tOmUpngrci9Tj3M4qhsZ7uVaPDkydZmChcJ789Y1IoeBwi+l+uc+q1MG6NrSP6KMi/KI/pCuXXXh9wOaAfcJMyIhYoxqc6BchOmeS+csiQAQ5XtIlMwUYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076299; c=relaxed/simple;
	bh=TJqKn8kMAZW4AetVJpiUyoOA1Foff6/4ADt7vWK+Q44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXkHvQ+j4kqaL+70HKebHIGSgADZR+k6AnBUdbbPvKMSVSiqVGuw+eXa/uXF6jkc65DXQ748zkwBKrNMP4ZzCwxLv5JLPbelP3JNLn6S8AZh1omLc0ZIUN/JBO33Wt3tIMnpilhCohoVyzExpnoBkj27UPjP8kHTLoncu6NUNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MyjsxIDJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726076295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n9dbFABmXb3RIIbrmIFVCtUVXXsfZQnmMR4MaaV4ITI=;
	b=MyjsxIDJ7+Zt1oh0vV0MZYjTMFdCSfRd/us3OUZIPMb2ibDh+/ekKKbvVvirWTsGtXJqgz
	MVlH0RzgdiimUCXZdmgjAKvLm0OEnGRv6648Ta4ALllFbXUrTivYiJ+hiU1T2Cq46+op9f
	3WF+Dpz2/u0Tyq6qoJHgfpcIfcgxVFI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Omar Sandoval <osandov@osandov.com>,
	Chris Mason <clm@fb.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] mm: optimize shadow entries removal
Date: Wed, 11 Sep 2024 10:37:59 -0700
Message-ID: <20240911173801.4025422-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some of our production workloads which processes a large amount of data
spends considerable amount of CPUs on truncation and invalidation of
large sized files (100s of GiBs of size). Tracing the operations showed
that most of the time is in shadow entries removal. This patch series
optimizes the truncation and invalidation operations.

(This is 6.13+ material)

Shakeel Butt (2):
  mm: optimize truncation of shadow entries
  mm: optimize invalidation of shadow entries

 mm/truncate.c | 96 ++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 55 deletions(-)

-- 
2.43.5


