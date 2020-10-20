Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675802940D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbgJTQvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 12:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbgJTQvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603212696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KfTEnC1hRU5Wp4OQBkD32Mop6h/iB9TUi8U4zzrLAag=;
        b=QeXEHiTQ+gPQaqP87pyV9x4KZciLxDilTeaM5QiXNvZpHNt4brtYVwPUp4/eTgH7ULBO9u
        3IMsZ0qkp72KJFvgCUuFbU0i5j1JEmhBRVNl52DwNlzZAokWVTavsHKHQEu3/KAGpfvtzC
        yNJTXOcuvmKN0hzTLoZ+d9BRVVtmZJk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-8wG9TLLgP9GUxTGSjKhAcg-1; Tue, 20 Oct 2020 12:51:34 -0400
X-MC-Unique: 8wG9TLLgP9GUxTGSjKhAcg-1
Received: by mail-il1-f198.google.com with SMTP id v29so2772387ilk.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 09:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfTEnC1hRU5Wp4OQBkD32Mop6h/iB9TUi8U4zzrLAag=;
        b=uD4aZarMj8hu15nPvGNpRSQ0/FFhnLGJVBEgOImVRzrbVwG1ZCzn2VklXWrnXNB+m3
         hVESsC9ZzoUAiT+9OXRYQAIZpfM1iFwxEJXRF968bfduWO/1cWoKDAD3DnlM8IAVrfhm
         Scnf5WlpB46InOMHDVgYB3h9SWs0W0hAyuZEomTaO75z+MwpQeT9CG7oxfa079TDUJMs
         5jlbfR332vGE6jMkGr4rrAwU+5Qvb5lx/oalkqYKsu4bptLmC0Bu/8om+BgYDS5dIZt3
         qPSt+aKEybi/V01BGV535KA+GHrTP0pfv6vcNg7QG+qoNzbVtYnSrZ7zi+52p9Gdl7BZ
         SlpA==
X-Gm-Message-State: AOAM531LlglwqKsTGzW4xVRh+zodUTBXKhPeMnu2Vf5nanVQWp1SJbV+
        C+VQh6SiJR7VXbgnOEpwkTuZ5MPoK1FAD9hWEVSeJjJxhc4FOyHpbZZHFxSgkTStLUylxAcJ5KJ
        cG5RtLw7h4P/q7S43/OJtDgWzWQ==
X-Received: by 2002:a6b:8f92:: with SMTP id r140mr2813408iod.81.1603212693678;
        Tue, 20 Oct 2020 09:51:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhYhP8bHy9rw26FwgSrJo5i/J3IGR39kvEzGCFYR24S3FRdOAuoxtOikLtoCLiNfi/oNuuXA==
X-Received: by 2002:a6b:8f92:: with SMTP id r140mr2813377iod.81.1603212693324;
        Tue, 20 Oct 2020 09:51:33 -0700 (PDT)
Received: from respighi.redhat.com (c-24-9-17-161.hsd1.co.comcast.net. [24.9.17.161])
        by smtp.gmail.com with ESMTPSA id l77sm2987800ill.50.2020.10.20.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 09:51:32 -0700 (PDT)
From:   Charles Haithcock <chaithco@redhat.com>
To:     adobriyan@gmail.com
Cc:     trivial@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Charles Haithcock <chaithco@redhat.com>
Subject: [PATCH net-next] mm, oom: keep oom_adj under or at upper limit when printing [v2]
Date:   Tue, 20 Oct 2020 10:51:30 -0600
Message-Id: <20201020165130.33927-1-chaithco@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For oom_score_adj values in the range [942,999], the current
calculations will print 16 for oom_adj. This patch simply limits the
output so output is inline with docs.

v2: moved the change to after put task to make sure the task is
    released asap
Signed-off-by: Charles Haithcock <chaithco@redhat.com>
---
 fs/proc/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0faa0..eafabeaf21d1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1049,6 +1049,8 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
 		oom_adj = (task->signal->oom_score_adj * -OOM_DISABLE) /
 			  OOM_SCORE_ADJ_MAX;
 	put_task_struct(task);
+	if (oom_adj > OOM_ADJUST_MAX)
+		oom_adj = OOM_ADJUST_MAX;
 	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
 	return simple_read_from_buffer(buf, count, ppos, buffer, len);
 }
-- 
2.25.1

