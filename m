Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11D751266
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjGLVMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjGLVMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:21 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1B2694
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry7U36vaXDdBTb0o6BnFM/rdvkZja/IMfv3muX44WIU=;
        b=H/PcQLzUY9PMMaDMDJwLi0XXcTGO8YvVfT6XKsh1JXOymc2y7ZVnR56snJOlO9Xb/Yz3l4
        bRwbeCnPM3wz2EPPnP2d5RVd4IhMeXJvhurNnxpGX0g2cOGsDM/v89gyyMQcqGokab5lzL
        7glFmafusrUIz1iPlOtVxrZ1QJ7bs+E=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 14/20] closures: closure_wait_event()
Date:   Wed, 12 Jul 2023 17:11:09 -0400
Message-Id: <20230712211115.2174650-15-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

Like wait_event() - except, because it uses closures and closure
waitlists it doesn't have the restriction on modifying task state inside
the condition check, like wait_event() does.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Acked-by: Coly Li <colyli@suse.de>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/closure.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index 0ec9e7bc8d..36b4a83f9b 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -374,4 +374,26 @@ static inline void closure_call(struct closure *cl, closure_fn fn,
 	continue_at_nobarrier(cl, fn, wq);
 }
 
+#define __closure_wait_event(waitlist, _cond)				\
+do {									\
+	struct closure cl;						\
+									\
+	closure_init_stack(&cl);					\
+									\
+	while (1) {							\
+		closure_wait(waitlist, &cl);				\
+		if (_cond)						\
+			break;						\
+		closure_sync(&cl);					\
+	}								\
+	closure_wake_up(waitlist);					\
+	closure_sync(&cl);						\
+} while (0)
+
+#define closure_wait_event(waitlist, _cond)				\
+do {									\
+	if (!(_cond))							\
+		__closure_wait_event(waitlist, _cond);			\
+} while (0)
+
 #endif /* _LINUX_CLOSURE_H */
-- 
2.40.1

