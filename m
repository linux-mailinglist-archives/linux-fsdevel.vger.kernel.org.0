Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9026C8DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgIPS6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgIPS6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:58:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52550C061756;
        Wed, 16 Sep 2020 11:58:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k14so4416810pgi.9;
        Wed, 16 Sep 2020 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F81s0rIPBWblQiyluR6hglrcI7ROo5yasjtOBI37hNg=;
        b=mZqc0jljd/8sr5+kvQjTKKe3AFdrpzOFDDMIBUO+PUn+a6XpZRpo79Atnqv1VOnlnS
         EkUT0J9s8xsHnTW3+G349vqk+a5LomUWdlU29ynNacJgfFp6WLBvGak8gCcJLVL44f94
         XcYH5swx5dtwtKREZsFbpTZUkRYNNM+cKEL9FbC27JrWIY/01KTO9Tgy70Zqnl+q+mbZ
         4CF1VS4cec4ZOjpKhznpfPY6yJ845rV/YU1u5BdJcJPcpjHMOAU593VTijNltDFIum9e
         Ydb+hOGPfWL5jHACAuW+Ibb+DOnWiktygjBUIRS3NctPP5oeOSP+6KL+6qBreT329V+B
         8G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F81s0rIPBWblQiyluR6hglrcI7ROo5yasjtOBI37hNg=;
        b=Bx06hLc9w5deOiOhjl7Borb/yc+fWtNRfKkpzGTrdOSWT9EiGy+dZY8JyxnX9cL+nc
         0GDIRKeY7NXItwEflFsHIBHTYPVnlxl4+C8OwMcqMal+zJBa85wXVwpfsHzQcA7cAAdA
         bKEBMFkpaxH0MAYMXA3QD8k+BxSFAXCf8KDb87h4iYP7vzJbYiIgYn2rIOfrAAQgGm3Q
         eCfsfX5/pZbIsE0ZFonvx9TtOzcqx+16fr6jdLz3Erh3HrLnRfoxeKGfbTv/GRT57pSr
         yOn02qglKWtlHYoCgvxdlwTh0CGeoA4/OGfSugE7tZETzLAdMCYmhC3nH3olUtfloo6f
         tkyw==
X-Gm-Message-State: AOAM531SImx2eWhhAM60M+XU6SsRQTy9D2Itah/pnFR7vQ7XLORozsCk
        EQxyxfQl/U4sWvq2+cjo+LFMRGW0E6c=
X-Google-Smtp-Source: ABdhPJxx/RelfTwk8Irck3IijqBQjwOkCy74p2cEpMoZ+BalP/NvlYKBAp/L5wpoHgKuaqczNiNKXA==
X-Received: by 2002:a63:5ec5:: with SMTP id s188mr19707324pgb.218.1600282720914;
        Wed, 16 Sep 2020 11:58:40 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id fz23sm3453747pjb.36.2020.09.16.11.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:58:39 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     shy828301@gmail.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm: vmscan: remove shrinker's nr_deferred from tracepoint
Date:   Wed, 16 Sep 2020 11:58:22 -0700
Message-Id: <20200916185823.5347-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916185823.5347-1-shy828301@gmail.com>
References: <20200916185823.5347-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrinker's nr_deferred will be removed in the following patch, this is a preparation
patch to make it bisectable.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/trace/events/vmscan.h | 26 +++++++-------------------
 mm/vmscan.c                   |  4 ++--
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 2070df64958e..27f268bbeba4 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -184,18 +184,15 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_re
 
 TRACE_EVENT(mm_shrink_slab_start,
 	TP_PROTO(struct shrinker *shr, struct shrink_control *sc,
-		long nr_objects_to_shrink, unsigned long cache_items,
-		unsigned long long delta, unsigned long total_scan,
-		int priority),
+		unsigned long cache_items, unsigned long long delta,
+		unsigned long total_scan, int priority),
 
-	TP_ARGS(shr, sc, nr_objects_to_shrink, cache_items, delta, total_scan,
-		priority),
+	TP_ARGS(shr, sc, cache_items, delta, total_scan, priority),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
 		__field(void *, shrink)
 		__field(int, nid)
-		__field(long, nr_objects_to_shrink)
 		__field(gfp_t, gfp_flags)
 		__field(unsigned long, cache_items)
 		__field(unsigned long long, delta)
@@ -207,7 +204,6 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->shr = shr;
 		__entry->shrink = shr->scan_objects;
 		__entry->nid = sc->nid;
-		__entry->nr_objects_to_shrink = nr_objects_to_shrink;
 		__entry->gfp_flags = sc->gfp_mask;
 		__entry->cache_items = cache_items;
 		__entry->delta = delta;
@@ -215,11 +211,10 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->priority = priority;
 	),
 
-	TP_printk("%pS %p: nid: %d objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
-		__entry->nr_objects_to_shrink,
 		show_gfp_flags(__entry->gfp_flags),
 		__entry->cache_items,
 		__entry->delta,
@@ -229,17 +224,14 @@ TRACE_EVENT(mm_shrink_slab_start,
 
 TRACE_EVENT(mm_shrink_slab_end,
 	TP_PROTO(struct shrinker *shr, int nid, int shrinker_retval,
-		long unused_scan_cnt, long new_scan_cnt, long total_scan),
+		long total_scan),
 
-	TP_ARGS(shr, nid, shrinker_retval, unused_scan_cnt, new_scan_cnt,
-		total_scan),
+	TP_ARGS(shr, nid, shrinker_retval, total_scan),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
 		__field(int, nid)
 		__field(void *, shrink)
-		__field(long, unused_scan)
-		__field(long, new_scan)
 		__field(int, retval)
 		__field(long, total_scan)
 	),
@@ -248,18 +240,14 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->shr = shr;
 		__entry->nid = nid;
 		__entry->shrink = shr->scan_objects;
-		__entry->unused_scan = unused_scan_cnt;
-		__entry->new_scan = new_scan_cnt;
 		__entry->retval = shrinker_retval;
 		__entry->total_scan = total_scan;
 	),
 
-	TP_printk("%pS %p: nid: %d unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d total_scan %ld last shrinker return val %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
-		__entry->unused_scan,
-		__entry->new_scan,
 		__entry->total_scan,
 		__entry->retval)
 );
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9727dd8e2581..48ebea97f12f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -485,7 +485,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	if (total_scan > freeable * 2)
 		total_scan = freeable * 2;
 
-	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
+	trace_mm_shrink_slab_start(shrinker, shrinkctl, 
 				   freeable, delta, total_scan, priority);
 
 	/*
@@ -537,7 +537,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	else
 		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, nid, freed, total_scan);
 	return freed;
 }
 
-- 
2.26.2

