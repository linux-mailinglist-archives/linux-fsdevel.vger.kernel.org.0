Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4D751262
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjGLVMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjGLVMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:21 -0400
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [IPv6:2001:41d0:203:375::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F826A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eXxZII/AY+4X/BxaYnmkLZzUciXf9EGOnTBvq8dyQQ=;
        b=JmsjQ2ajsBYN3QOblqtRMGTF5kTXZyMU6AdekvlvzukOKlyd/dutSqxvKv5t5RWAgQWpgM
        7Gv9ZJdbcozKP4osvPilzfhGaThul1hTjIWDql/qV8P4XoZuQN6CWcA8f/LNhh9yW5ZmMw
        gB+thTgZixIl8jLYzHr+5vwIp8lR1hs=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 15/20] closures: closure_nr_remaining()
Date:   Wed, 12 Jul 2023 17:11:10 -0400
Message-Id: <20230712211115.2174650-16-kent.overstreet@linux.dev>
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

Factor out a new helper, which returns the number of events outstanding.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/closure.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index 36b4a83f9b..722a586bb2 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -172,6 +172,11 @@ void __closure_wake_up(struct closure_waitlist *list);
 bool closure_wait(struct closure_waitlist *list, struct closure *cl);
 void __closure_sync(struct closure *cl);
 
+static inline unsigned closure_nr_remaining(struct closure *cl)
+{
+	return atomic_read(&cl->remaining) & CLOSURE_REMAINING_MASK;
+}
+
 /**
  * closure_sync - sleep until a closure a closure has nothing left to wait on
  *
@@ -180,7 +185,7 @@ void __closure_sync(struct closure *cl);
  */
 static inline void closure_sync(struct closure *cl)
 {
-	if ((atomic_read(&cl->remaining) & CLOSURE_REMAINING_MASK) != 1)
+	if (closure_nr_remaining(cl) != 1)
 		__closure_sync(cl);
 }
 
-- 
2.40.1

