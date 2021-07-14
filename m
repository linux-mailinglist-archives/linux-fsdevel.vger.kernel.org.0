Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27913C8B2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhGNSu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbhGNSuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:23 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B3C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s6so2607116qkc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V4ubrhMWd+B6p1vRLOMjUxHyopfqP/FHLyRQu3oDcLY=;
        b=S6NwblJp3dnjLjHGn9zX4V85sRagMdhnxZ/iUQuC3387+NRiU3wedA0I+ZUSuTewiX
         eueUbH8kjRQemFTc4+Bs8ymOMe4YMz67x5ABFqn+S4k7OvOI1H7JZXULPkfQKR7MkFcf
         vrVMUojR0Yg6Sf1Z+mF+S37svGAz9hsBim1pI3XFz50tCKN0MvndJQND19e9qKbtsUF5
         dbEVxnYdwCeC3XmW3eL22RAtW1v3jfQCT1I5BxbTh6h0ssLZ2Tjzpbq7UYu0eDIH1Spp
         Xr+WzEnGdexpsLmub3f/wnQcs1KUZEi02F8Xgrn9TvOIMNuRkakfdT8QMYIroKLhPXWo
         mozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4ubrhMWd+B6p1vRLOMjUxHyopfqP/FHLyRQu3oDcLY=;
        b=XNlAMBUFZX4MmnCGdXfcf3/uyU4I1G52wUl43pbOAYvcBTAcV8zcwSviDEm3hLuhWT
         cg7jQ/i5+HCrfnA1thzHtxKsCvp6NAs2swJib5rCoTUOyPJ9vaVCBSpOCizKF4UjDzvw
         WNHX0LXR4w/L5nxSLjFApTBDpsO/tSkijhFOId4Eig1N6y7Rcpp/AC6ehrb3bwyv/bUY
         aHtHhyJRZs8yJjDgolQrGBagt4VguTfTXqbhDUI8F/RF4m0jUy/opvm91wHB8tUwYV+V
         n7rAv9spsQ7OnmVapf2U1sQfIGgz2ExF3ongtmGTb5jZIbgSnOYFN16Mgto9/auSc/E5
         Yn5Q==
X-Gm-Message-State: AOAM533dp3eyS4hSqDRtTeK9UVVN1OIeHmSrlROOXfZ3F6GLOvQQYC4X
        /l3zmGapoZFkDQzyveY3MrOiIw==
X-Google-Smtp-Source: ABdhPJyggr0ygazjtNNGcDthUTyPyH/J4WwnAF7T+R9gBzVWtpp9sixoYYItBi2D2HeZgEhSh5kjZg==
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr11649898qkj.495.1626288450258;
        Wed, 14 Jul 2021 11:47:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 197sm1421633qkn.64.2021.07.14.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/9] btrfs: include delalloc related info in dump space info tracepoint
Date:   Wed, 14 Jul 2021 14:47:18 -0400
Message-Id: <8bdbea6af922d952247196f999610bc45bc38071.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to debug delalloc flushing issues I added delalloc_bytes and
ordered_bytes to this tracepoint to see if they were non-zero when we
were ENOSPC'ing.  This was valuable for me and showed me cases where we
weren't waiting on ordered extents properly. In order to add this to the
tracepoint we need to take away the const modifier for fs_info, as
percpu_sum_counter_positive() will change the counter when it adds up
the percpu buckets.  This is needed to make sure we're getting accurate
information at these tracepoints, as the wrong information could send us
down the wrong path when debugging problems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/trace/events/btrfs.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c7237317a8b9..a87953e74573 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2037,7 +2037,7 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 );
 
 DECLARE_EVENT_CLASS(btrfs_dump_space_info,
-	TP_PROTO(const struct btrfs_fs_info *fs_info,
+	TP_PROTO(struct btrfs_fs_info *fs_info,
 		 const struct btrfs_space_info *sinfo),
 
 	TP_ARGS(fs_info, sinfo),
@@ -2057,6 +2057,8 @@ DECLARE_EVENT_CLASS(btrfs_dump_space_info,
 		__field(	u64,	delayed_refs_reserved	)
 		__field(	u64,	delayed_reserved	)
 		__field(	u64,	free_chunk_space	)
+		__field(	u64,	delalloc_bytes		)
+		__field(	u64,	ordered_bytes		)
 	),
 
 	TP_fast_assign_btrfs(fs_info,
@@ -2074,6 +2076,8 @@ DECLARE_EVENT_CLASS(btrfs_dump_space_info,
 		__entry->delayed_refs_reserved	=	fs_info->delayed_refs_rsv.reserved;
 		__entry->delayed_reserved	=	fs_info->delayed_block_rsv.reserved;
 		__entry->free_chunk_space	=	atomic64_read(&fs_info->free_chunk_space);
+		__entry->delalloc_bytes		=	percpu_counter_sum_positive(&fs_info->delalloc_bytes);
+		__entry->ordered_bytes		=	percpu_counter_sum_positive(&fs_info->ordered_bytes);
 	),
 
 	TP_printk_btrfs("flags=%s total_bytes=%llu bytes_used=%llu "
@@ -2081,7 +2085,8 @@ DECLARE_EVENT_CLASS(btrfs_dump_space_info,
 			"bytes_may_use=%llu bytes_readonly=%llu "
 			"reclaim_size=%llu clamp=%d global_reserved=%llu "
 			"trans_reserved=%llu delayed_refs_reserved=%llu "
-			"delayed_reserved=%llu chunk_free_space=%llu",
+			"delayed_reserved=%llu chunk_free_space=%llu "
+			"delalloc_bytes=%llu ordered_bytes=%llu",
 			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
 			__entry->total_bytes, __entry->bytes_used,
 			__entry->bytes_pinned, __entry->bytes_reserved,
@@ -2089,11 +2094,12 @@ DECLARE_EVENT_CLASS(btrfs_dump_space_info,
 			__entry->reclaim_size, __entry->clamp,
 			__entry->global_reserved, __entry->trans_reserved,
 			__entry->delayed_refs_reserved,
-			__entry->delayed_reserved, __entry->free_chunk_space)
+			__entry->delayed_reserved, __entry->free_chunk_space,
+			__entry->delalloc_bytes, __entry->ordered_bytes)
 );
 
 DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
-	TP_PROTO(const struct btrfs_fs_info *fs_info,
+	TP_PROTO(struct btrfs_fs_info *fs_info,
 		 const struct btrfs_space_info *sinfo),
 	TP_ARGS(fs_info, sinfo)
 );
-- 
2.26.3

