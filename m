Return-Path: <linux-fsdevel+bounces-32694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0149ADCE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 08:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F027B22D6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7818A6D9;
	Thu, 24 Oct 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TspUYcjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFDB189F5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753047; cv=none; b=SfAIODW4Tu5PsyrObnbjs3SE+divrdOcdkKD3LRU4ecOW94gQPl9TDMhC9R9bwJni/c6ajhRP5Jgw9P/P4VjUwsMpcbUaXqt8DO64y1sWlqR1cWGotxxPh2ycSpjD8SNocqS//NWUkdwktu3zNpDHB4kbs7EKBMBwCmURxDcjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753047; c=relaxed/simple;
	bh=MZCtspQs47hvSHY7yN7jR56BOmefBpAyiy6rpcqVfT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdsNPdCPEIjBzDS2AsnYhXRq7GE2HLDsLIywqr/i2Ab2/3jOQoLLoqSovJM5JDAN/1wtjHLKb2OJGtG1dK/esUn1C9KFySz8IqdQuZJDufkO18sjzsqUs2w4OX+U8GO5UQ2ZFaG6P8C5wnrjg04voM2UKERyeLTlpXLzp6HdjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TspUYcjf; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729753043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KnFX2m6jkpkqkNftsFITtlFPeLSY1W41MMcnLCh4dYw=;
	b=TspUYcjfzaIFDz5Rs6jj026nPmaG2edsEPEKCkjp3ZDuivc4FFk3OglfYNcH8yBRU0K19r
	DOHBUG5p6nULP4uryvh9jv0x1srywC5TiN6UefeOlNmwrGRPR5FO/nis6SqJFP3JWX5isX
	gCY4AN7HpRIAYkLnRsKPNKurkLs8l9g=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 0/3] memcg-v1: fully deprecate charge moving
Date: Wed, 23 Oct 2024 23:57:09 -0700
Message-ID: <20241024065712.1274481-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg v1's charge moving feature has been deprecated for almost 2
years and the kernel warns if someone try to use it. This warning has
been backported to all stable kernel and there have not been any report
of the warning or the request to support this feature anymore. Let's
proceed to fully deprecate this feature.

Shakeel Butt (3):
  memcg-v1: fully deprecate move_charge_at_immigrate
  memcg-v1: remove charge move code
  memcg-v1: remove memcg move locking code

 .../admin-guide/cgroup-v1/memory.rst          |  82 +-
 fs/buffer.c                                   |   5 -
 include/linux/memcontrol.h                    |  59 --
 mm/filemap.c                                  |   1 -
 mm/memcontrol-v1.c                            | 960 +-----------------
 mm/memcontrol-v1.h                            |   6 -
 mm/memcontrol.c                               |  14 -
 mm/page-writeback.c                           |  21 +-
 mm/rmap.c                                     |   1 -
 mm/vmscan.c                                   |  11 -
 10 files changed, 8 insertions(+), 1152 deletions(-)

-- 
2.43.5


