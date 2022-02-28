Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35F4C7ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiB1X6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiB1X6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:58:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93A40E4E;
        Mon, 28 Feb 2022 15:58:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ay5so9251891plb.1;
        Mon, 28 Feb 2022 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qVTXgEk7jDbNe3RIcGVI67pez+4LMoxn8Ha8tkNEVM=;
        b=I/uneKQYRfBvvU1QYfMRxA9cdeOKNDx/GA80yQj/Vii5WOYT8JOLzKQ39OtDsLJu0e
         w68+trSpW+r3e+66nPqchuDl41VrZKCXAQGBhtvqKIYb9WYtGnPkgetwDILXcx3Ufnm6
         qMBAVb3txy8flmueV6alKq9spfgtUhlVfk7krxGlnlerA9XBBtqiWGZLBz96Yoa74hLj
         Od7jXKzhB8UI9wQQeuJYi4wYkOq19NjFPBQEOFDqXYdIwIKiaAZkzknKapA4y0+lcBGv
         J2k+NZJFmd7jy+8HFikciV61Djwz36lqySOqaLUGqMA7vNp0f/ai6ZRZpZv18TqYZ8j0
         EYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qVTXgEk7jDbNe3RIcGVI67pez+4LMoxn8Ha8tkNEVM=;
        b=6h0dU8/uMz0b5aalZ5alqVNnBpRZhWH2HKe6SxMNvPcRmIpVyj40Q+qBmu+qi/3ISi
         SbXnJ9iYIXcy9vspVFUBMs5mnB/7/EZZUTtLN+mVQlISM1gwq7R0wK6Z2qHLw3rZeWx7
         aCDM5NERmMqhUkTuyG+0P7YnhC9qk/lc6I4jOsYRLyu+rz1R9qgBzVJ9/wOv0RmXgAVb
         RWrnQoNU6WutKPr09o30F4LH1kPAoBaT/lZxUSrHBJz8KOIRnMpK8evfsTa53lvJbBX8
         iaHVEvOUiSSDLJoNiEF4179LUsx2EIDPO/djPfpAdNsjUkpHf1V5AkHvYSMQoNr5Hsnl
         Ytjw==
X-Gm-Message-State: AOAM530zO55JZw/7N9tiRcieUaizykWpAfB3mzZgYnES3sgCdVGeGjEb
        oP2Va/7qk7+1Xa2sURXyk0w=
X-Google-Smtp-Source: ABdhPJwS2d/mQvKUD9RT9YRNebvue4fyV0w7v+iF01ewR6eZtUfak47eHHmfgpbarwiWX2HhFS9nLA==
X-Received: by 2002:a17:902:b204:b0:14d:a8c8:af37 with SMTP id t4-20020a170902b20400b0014da8c8af37mr23074869plr.108.1646092684471;
        Mon, 28 Feb 2022 15:58:04 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:04 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
Date:   Mon, 28 Feb 2022 15:57:34 -0800
Message-Id: <20220228235741.102941-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220228235741.102941-1-shy828301@gmail.com>
References: <20220228235741.102941-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MMF_VM_HUGEPAGE is set as long as the mm is available for khugepaged by
khugepaged_enter(), not only when VM_HUGEPAGE is set on vma.  Correct
the comment to avoid confusion.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/sched/coredump.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d9e3a656875..4d0a5be28b70 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -57,7 +57,8 @@ static inline int get_dumpable(struct mm_struct *mm)
 #endif
 					/* leave room for more dump flags */
 #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
-#define MMF_VM_HUGEPAGE		17	/* set when VM_HUGEPAGE is set on vma */
+#define MMF_VM_HUGEPAGE		17	/* set when mm is available for
+					   khugepaged */
 /*
  * This one-shot flag is dropped due to necessity of changing exe once again
  * on NFS restore
-- 
2.26.3

