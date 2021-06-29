Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0830E3B73A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhF2OB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhF2OB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:01:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3DC061767
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w26so16106983qto.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z9+9p3DkUHErCibT+iydqnILLuZw6VNnyzs7xEbrTYU=;
        b=bGKWxbPYJooGpEobmKjOr2YirWVM4n0aMrkaE4Lb6UR+moWowxKut7DBR8/i4rnDNx
         HCn0221xyUjqQjoX7hpCkG2PJqURYDrlk3BV5KHKaSFmBqGJC+hsPjrDSMVCOw3Vt9WY
         T4YnQYJaFw26WmABTL6UdUqNoZG6xYJ3xcrPzd9Vxf5W9sJ1PKZvEznLAIWHB9Dz7cp3
         tZrUBzDTy2DRXu82pez7ik3A1BgCDvfBFm3wJ8o+US7sSWR2YZRTLTUeTuh9YJcx9nWo
         k+BmQQw4XxkZdHxl+QeuGmyazgFds6R+WhlWHq/0twrKdgbabdqYpPCuycClaQd9p0Le
         b4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9+9p3DkUHErCibT+iydqnILLuZw6VNnyzs7xEbrTYU=;
        b=cBys9CIs70ig31hGfwIc2merFF8dCKAEZsI1pFghnWlJk6KXWmPSIeRkrmZDZwbbKo
         137FT7q3Ca6rzTpr+34gAbK8ENkobRPZBchdLrVTTED+/VtyR4Os86oaqNAxHdsaw0oz
         8nZEQA8GU1KyMJrQ6C4xc5QpH/EG0Ymv0VYpyf/egpCFpGMP5YoaKgMCVRKYjl3gl8Gj
         Yk9ux5xjmkmvFECUKr0XMyULLLWl7olwc+LmxAEgBxar6gVZT4Q/ykPzrPBpEx9kF08V
         oqAFSK3TOKuJmhH0TIorI7bs+sMttaTd0BvYzV1ivamQ0HVKgDHJbMkcU7LR2DX8lQx2
         E0lw==
X-Gm-Message-State: AOAM532Ia5EW9SeFqHijsRolmr7MXD54S6b3OSimGpFjwFD6S00ieEB5
        EeVBsK+vX/jEnLQF2rp5yMrKhQ==
X-Google-Smtp-Source: ABdhPJyASv4gh5GHQYK0u1rZ7RfJV7UwQ3QSHEOdHtTxbtbrlU+WlVBoJ7EoSjVE4y9Z9xfC8nFvbA==
X-Received: by 2002:a05:622a:11cd:: with SMTP id n13mr26919751qtk.233.1624975167940;
        Tue, 29 Jun 2021 06:59:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v20sm5861554qto.89.2021.06.29.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/8] btrfs: enable a tracepoint when we fail tickets
Date:   Tue, 29 Jun 2021 09:59:17 -0400
Message-Id: <196e7895350732ab509b4003427c95fce89b0d9c.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When debugging early enospc problems it was useful to have a tracepoint
where we failed all tickets so I could check the state of the enospc
counters at failure time to validate my fixes.  This adds the tracpoint
so you can easily get that information.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        | 2 ++
 include/trace/events/btrfs.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 392997376a1c..af161eb808a2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -825,6 +825,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 
+	trace_btrfs_fail_all_tickets(fs_info, space_info);
+
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
 		__btrfs_dump_space_info(fs_info, space_info);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c7237317a8b9..3d81ba8c37b9 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2098,6 +2098,12 @@ DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
 	TP_ARGS(fs_info, sinfo)
 );
 
+DEFINE_EVENT(btrfs_dump_space_info, btrfs_fail_all_tickets,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo),
+	TP_ARGS(fs_info, sinfo)
+);
+
 TRACE_EVENT(btrfs_reserve_ticket,
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
 		 u64 start_ns, int flush, int error),
-- 
2.26.3

