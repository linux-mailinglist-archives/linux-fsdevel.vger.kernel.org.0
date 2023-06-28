Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C1741723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjF1RZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjF1RZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172FF1FDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bf34588085bso1341276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973137; x=1690565137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83rYaWFW6QNQhfB0rTt9RkG69OVxHHwKFqolT0xWQu0=;
        b=UokIsNFS7/P5ifE0g0gbJ51af5XfHkQTHzAgzLLCATuc/7MAyN3e2BIPy1izcYPkLY
         z5f44UMQRnCVB/vZkWWNMEwOIDkzuui+0Zwrl35SVD1vVSw69/uOHfZ8N6f04+Hc4UE8
         OMS5qOGaEvHe2e7Pkp97+c129PKIZIfcz2hG05HLZYnQzbeA5Kf51CkDDRCs5Gj3bCn3
         IyzanXcnxJEZy6IFmpLEMW/Hpa919YAfn1aORWnHhQljmXr6br6YiaYfYPvCtBgZON7s
         ICsPLNMrtcvCAid/Y2Aigd28hxg2v4s1SjgCANnNW3FUlDE6VL5Cwje43GGlxg+Y6Z5I
         IRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973137; x=1690565137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83rYaWFW6QNQhfB0rTt9RkG69OVxHHwKFqolT0xWQu0=;
        b=UebdeKZwu788nwrtr2R3Xu4IiC88ti7VxzO8y03s3GXIGXE+6NlVjitKz6XnOx7Kkm
         86cmeXba5+/Lz4ba8gRP0tyTf+eXMkS6PgEbfgtZH8ER3qOpxpOIf4X0bJJo8v7KzOd9
         mDifVCI+WvB9k3Eqf1vU7CI/mT4EKVVr4pFq1OLpdb8wS7ElGQr4UaYfPC+wHthNEscC
         IQ+/MopNrW5fO/x+yjHSPYrNbDcuifdYR5b51jRbr/GVdNNH5doAgIcGiTuQQa+/oWDc
         YNrjStrxdB26JxUiPycE+tHRkLhlzEND6ihFXNRj+e0K1jAy7S4+iCgB9GRPvwWI8gJZ
         NQFA==
X-Gm-Message-State: AC+VfDzWd4wCnxYI52rWtQv1zSf9bWEx9cPzqYPSzHz6Zu01IFj7qzUj
        rUbvyZ7dRx5Zu84WzTt9bs8++1DXzxc=
X-Google-Smtp-Source: ACHHUZ7JjKtitm+lPkm21TpKtpBUVfUzi/WI1UUa7vSu8SsD9xW8kKDV4Pf2ivIVJgyup2CqnecVVXuo0yI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a25:ad94:0:b0:ba6:e7ee:bb99 with SMTP id
 z20-20020a25ad94000000b00ba6e7eebb99mr14318213ybi.12.1687973137283; Wed, 28
 Jun 2023 10:25:37 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:25 -0700
In-Reply-To: <20230628172529.744839-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-3-surenb@google.com>
Subject: [PATCH v5 2/6] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
to be used as flag_array inside trace_print_flags_seq(). The element
for VM_FAULT_COMPLETED is missing, add it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..79765e3dd8f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1070,7 +1070,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_COMPLETED,           "COMPLETED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.41.0.162.gfafddb0af9-goog

