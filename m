Return-Path: <linux-fsdevel+bounces-10056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C884759B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37651C232AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19A14D42A;
	Fri,  2 Feb 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdIbO7Ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192D14A4E7;
	Fri,  2 Feb 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893383; cv=none; b=V8SdDNVu8mCLpm4eYc4FyjUS6TlNyzzSx5s9oxDCE6ZmwCrJu7XAE2ErskSc014ULfSDtCP5vtkjpb4yycu4LokK+YqvW9PUGF6ROZ7CSnFUE7atTojEC1XbENx4SQgHocH7qVu2toJ16bpll7P+PJRFD6M3m641h2h1udEU1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893383; c=relaxed/simple;
	bh=WGXGeGTdrW7NoVRK7cYfyrjHnGc5NCJjZnCnYePfUZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATl4mIuHJzYkeuTnof2LM3qsRVv9o4+qCHygIkHYJHDS0h3AxJqezry5FCXwPhdqFSDVl52SgX6W72lzyFN8q7McTB/q0Ne1zLZgHQ8Bg7wzZWfTguT+jK9685tCr8amM/mgSB2GfbD0ZM/m/HVS1bxtEA1M4vwyQd3wbtfJaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdIbO7Ou; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6dfc321c677so1724918b3a.3;
        Fri, 02 Feb 2024 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893381; x=1707498181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhrTG5AYewh5phNKX1uPxhcy8QhnMld2uJe/mWMdTe0=;
        b=WdIbO7Ouw3Z3py0EEW5CcPqIlylJU5eowr5F68NhhsduW+K7P/0JlYNtzBhTRLyNmB
         0/UDkimsfnoSj2r/vSfIattYQL5NwWnsWNUmdLMqST0uvnXPPJD+yOsyJzuDkX9DZq2T
         Gf2d6TjzKYTcKtvVn+6KJWpJT1cFn62m3k9aF7lkOUnDftZszjNV/y+0WAVdi7ZUWAo/
         ngKzGNmmQW/yI7SWEkHwlspyAx1i+PhZaOGdeapzN1gZpqs+Uv0Hjg4O9AxzEe39Lb0U
         XW6XPyNF6g/I57BOhrAgzwh3y6T7wcsJ7BmKCeYgnPQ+qY9TRo8kc0IbqeZLv1EbdNb0
         ZRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893381; x=1707498181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhrTG5AYewh5phNKX1uPxhcy8QhnMld2uJe/mWMdTe0=;
        b=gMV/llJJKF+mm6g2aMYc89BpZ/onRKuL5VLgNjOknGshjj0T6jyMimOdUqw7J5tBII
         d+0R2wFlDOR5JXB3dAx3xMYBcfmq8zefCeLoqhRyKc7Q37g3ofXdb5TJPcxwdM1zLXUt
         q+ckRFS/yvyD5rLtvOIxUW2OIg8iF13rr1BasJnFbfBdAfwbzYfJSkb0WMCi4nxUiPOa
         iwyRzRAPOW0ADxgfZiyqZCiIrV9EGGnMV3LEiLmMP42BwDaxCbao54K/lKVu/rs4JjvA
         80bg8NCmY83ZpCmNaPbfZxmFPXj3suBDH2K6OBzuaWV+H1wAR68Bk2qDSNOFWvsoH+O1
         zQfg==
X-Gm-Message-State: AOJu0YzuLpnAjFOBMv7wmS15We5UMAKkI0Y+ldHKI+xKI5xGmFsKFJR7
	RqJGJD1JJXk9/78wHODYneTOnCpisYPsB69PhIO1bZNdjHcqyYQ=
X-Google-Smtp-Source: AGHT+IFogIopQqwUpwpEFsFzdYwSc8X+34bpQwF6wcEJlxSEsQ2LoOTeQtLBa1R1mPNFivEZAibTKQ==
X-Received: by 2002:aa7:8698:0:b0:6dd:c3b1:797e with SMTP id d24-20020aa78698000000b006ddc3b1797emr2585012pfo.19.1706893381133;
        Fri, 02 Feb 2024 09:03:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVt1bpVi7/1usRCD00UfVroAEBs2kkA7ivPuJBFs7e4G+50XRtr/OkpAzFSMfFRAHdUrmWFaRgbmluqN9+kP6pYoISXSBVGj3gGym0kGZAPJqyC9zCnaxeKxoVqIg+YsKhcBnckhYr0jqT+88HBKWVVvKol1k9qKs6zfze27eMF8LMwoCCImKMQ1QboF2LNyUiQlGDhILX78kacwGH3CEFwJF4MjCCPH0WZzUCY/EqU11rSp+7VSCcPyhqnACvJLqIenX7ox5uk6g+0BRmKDyW+u0Kc96vapdvPzWcSfp5uXlV8r4+b1LugH1OLSTzxHTdLvSuzkh+bhPyPGuGqqkRp6Jq/WmFwjFmTpaVnvynSrPgg6EXt8aJXZqPdvgU1hCvlfMTDAyWGPgEprUT0uA7CjpAMGLx9aO2UBB/uFO4lpMVdoIkgg+FhMnZNXJxNugpKs6x6pYKxEzulQq0Qc4VtjlWtT3Ml2/G1MpSSw2VARz4d2EBU7mh4um+v+jw+7cNDhrTAWNgBx7r4cq/lD29zYteZKCs+AhvgyOw94L0HxtBf8Mh8WR9T8cZvnNh0uxpT4ozEnaaTYxN/bWhlS0dY1lsdRGSWlqopk5eik5zKkpWz/fv0D5jTdAaQ5ARjZhTX69CwPcQUtgzfBrZ0y9Ic17GPXYKjlKblDPYcsHw=
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id z22-20020aa785d6000000b006ddddc7701fsm1866578pfn.4.2024.02.02.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:03:00 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	gregory.price@memverge.com,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	mhocko@kernel.org,
	ying.huang@intel.com,
	vtavarespetr@micron.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com
Subject: [PATCH v5 4/4] mm/mempolicy: protect task interleave functions with tsk->mems_allowed_seq
Date: Fri,  2 Feb 2024 12:02:38 -0500
Message-Id: <20240202170238.90004-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240202170238.90004-1-gregory.price@memverge.com>
References: <20240202170238.90004-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the event of rebind, pol->nodemask can change at the same time as an
allocation occurs.  We can detect this with tsk->mems_allowed_seq and
prevent a miscount or an allocation failure from occurring.

The same thing happens in the allocators to detect failure, but this
can prevent spurious failures in a much smaller critical section.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d8cc3a577986..ed0d5d2d456a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1878,11 +1878,17 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 
 static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
-	unsigned int node = current->il_prev;
-
-	if (!current->il_weight || !node_isset(node, policy->nodes)) {
+	unsigned int node;
+	unsigned int cpuset_mems_cookie;
+
+retry:
+	/* to prevent miscount use tsk->mems_allowed_seq to detect rebind */
+	cpuset_mems_cookie = read_mems_allowed_begin();
+	node = current->il_prev;
+	if (!node || !node_isset(node, policy->nodes)) {
 		node = next_node_in(node, policy->nodes);
-		/* can only happen if nodemask is being rebound */
+		if (read_mems_allowed_retry(cpuset_mems_cookie))
+			goto retry;
 		if (node == MAX_NUMNODES)
 			return node;
 		current->il_prev = node;
@@ -1896,8 +1902,14 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 static unsigned int interleave_nodes(struct mempolicy *policy)
 {
 	unsigned int nid;
+	unsigned int cpuset_mems_cookie;
+
+	/* to prevent miscount, use tsk->mems_allowed_seq to detect rebind */
+	do {
+		cpuset_mems_cookie = read_mems_allowed_begin();
+		nid = next_node_in(current->il_prev, policy->nodes);
+	} while (read_mems_allowed_retry(cpuset_mems_cookie));
 
-	nid = next_node_in(current->il_prev, policy->nodes);
 	if (nid < MAX_NUMNODES)
 		current->il_prev = nid;
 	return nid;
@@ -2374,6 +2386,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 		struct page **page_array)
 {
 	struct task_struct *me = current;
+	unsigned int cpuset_mems_cookie;
 	unsigned long total_allocated = 0;
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
@@ -2391,7 +2404,13 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	if (!nr_pages)
 		return 0;
 
-	nnodes = read_once_policy_nodemask(pol, &nodes);
+	/* read the nodes onto the stack, retry if done during rebind */
+	do {
+		cpuset_mems_cookie = read_mems_allowed_begin();
+		nnodes = read_once_policy_nodemask(pol, &nodes);
+	} while (read_mems_allowed_retry(cpuset_mems_cookie));
+
+	/* if the nodemask has become invalid, we cannot do anything */
 	if (!nnodes)
 		return 0;
 
-- 
2.39.1


