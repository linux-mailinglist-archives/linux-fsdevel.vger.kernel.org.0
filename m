Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D023C8B32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbhGNSu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbhGNSuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:24 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E8C061762
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z12so2619754qtj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EpdgEcRiBqQsZrOSnIk/qayn286ESnYWwrM6gnsT55M=;
        b=vdlXEiXebSuhkKjwBpAIpgZ3LlMhHVhskWGVr159+4cRz0cwgUPfSWGu3ECkOSOKfF
         bCDl3gbl9GP1t8J8GPIdWpRF/Zj0DWZEQrvnMrZe1X21bHjd9wCBZVvt3uH34Imos7No
         49w0BZYuxupZOO/auWGB5z8YbREYpqtWAE/55WQFbPjTMxT/sSEcZPSp8fXrf/JPxBnq
         uR8Ubag1J4XqHY79BKiz6YDoe4k7+pyhV+xAwQ1fjiBR4yB1q5PuZ8Sp7X5TgRIeWBjP
         0xfWnHUv7xsLd6bud3cYYEBxOCv6f71cAzfKn7ZIOKdl+NzLjxBLziuIg1uYWBsfcPcy
         qaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpdgEcRiBqQsZrOSnIk/qayn286ESnYWwrM6gnsT55M=;
        b=j20tMRirWlqhP2O3PdGElfyyGMq+duBaxpio93CUw4Z49snAL185UpO+q9m289m7Mg
         Y19IbgyE5eQEJtkhiZmOwIIhjXG9C+Cch9P5wyS08HyZlPD64ZD0cDhr+qzZitXtrAqn
         07A/olCALJfsLmQtIWSZ/JKnEUBOgL2nZwXyu9JuW0U+1af+rBRAmnhvN15Aa6sbr+C6
         VllaNVBadAFqibLKQMC3YMU/3q8amNHtJWTe3vEjbBP0hjzJbta64emhouJvk71mwkTv
         Cp0kFlzDHOtvkvUuB5SG6ErBf9wpoF1s4PaNGIwlIsHI7fSMLU64aJ5iiLuJXGUa95g2
         leHA==
X-Gm-Message-State: AOAM530Cb8lvtaCZLUFEH9Sv2ntoa2s/uB/vunv8A4gQAq1PfZCGSQD3
        a0I8526K4XWY43DaJlNsZVkP+w==
X-Google-Smtp-Source: ABdhPJzMXWWzEW1xNgRG2YJ6Ri2c+pRxiSkNfTQbuAUVeuozGxwrmS5brLLpNVP4YFy5tTOkSmvteA==
X-Received: by 2002:ac8:1347:: with SMTP id f7mr1455871qtj.70.1626288451514;
        Wed, 14 Jul 2021 11:47:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s3sm1406472qke.85.2021.07.14.11.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/9] btrfs: enable a tracepoint when we fail tickets
Date:   Wed, 14 Jul 2021 14:47:19 -0400
Message-Id: <e8840708de6be39bf0f34c5c3da2b52271546e37.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
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
index a87953e74573..d754c6ec1797 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2104,6 +2104,12 @@ DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
 	TP_ARGS(fs_info, sinfo)
 );
 
+DEFINE_EVENT(btrfs_dump_space_info, btrfs_fail_all_tickets,
+	TP_PROTO(struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo),
+	TP_ARGS(fs_info, sinfo)
+);
+
 TRACE_EVENT(btrfs_reserve_ticket,
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
 		 u64 start_ns, int flush, int error),
-- 
2.26.3

