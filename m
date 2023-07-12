Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A80751259
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjGLVMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjGLVMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:02 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [IPv6:2001:41d0:203:375::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F992139
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zrRAhLqNEKhRrIoVgPZyeRn+CDbvH7B3D4IIgSyFSc=;
        b=H2CyNxWGCE3tivzrg2wKis0Fi1baP6oPMbzsQ9Vph9f3q/hlsngS4aMYt/197qAIh8IcH1
        5SfVqNPTjdnhOXSN3oB7KxOEWArW+m2E5FnG/AzvN/yw14BF1ZU23+aXp6Tp2TfMzTqyX9
        aeXA4uTnJ/+mhn5UXz88dfILMGDoxTM=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Date:   Wed, 12 Jul 2023 17:11:06 -0400
Message-Id: <20230712211115.2174650-12-kent.overstreet@linux.dev>
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

These are used by bcachefs's six locks.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/osq_lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d5610ad52b..b752ec5cc6 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -203,6 +203,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(osq_lock);
 
 void osq_unlock(struct optimistic_spin_queue *lock)
 {
@@ -230,3 +231,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	if (next)
 		WRITE_ONCE(next->locked, 1);
 }
+EXPORT_SYMBOL_GPL(osq_unlock);
-- 
2.40.1

