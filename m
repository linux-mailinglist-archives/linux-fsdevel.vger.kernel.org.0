Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD865E1C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 01:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjAEAlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjAEAix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2BDE4;
        Wed,  4 Jan 2023 16:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CD7618BF;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A89C43332;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=XMX0rNISyJ3jdJLoqDXy9UsPPAVZ6pFivTvukmA1Yy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blU9blNCFeH4+MvoJnMJK2XWTi40fgcvMY1ZZGJCka/5+Rh+1E+L/Ian43TBJEuGq
         DMi5UvOsUHaWIkfgb7k/mOe6b7avNFVzalMFKsDtGOjIsBosFw8GNIuaH7TdSpyik+
         dfvW/iY99Z+zLSodcCngB77xOBlB7w+rGdGzZVkNf6dXCPw/9OKZDWj5+VzOmhtEV7
         NQMa+wXpsOA5rDjRs1WgYQePd+gDLEI1u9ZSqNZAD85H1NwMZ3vNbMirGYbgIkuYbK
         Zc1R6IGO7j6bMXnch4c97JlJrs/jE8ss9C8TKB3tchu771TDVs0IwqSuLkvx/wuH69
         VU+S+ehWHamTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E41B15C1CBA; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH rcu 25/27] fs: Remove CONFIG_SRCU
Date:   Wed,  4 Jan 2023 16:38:11 -0800
Message-Id: <20230105003813.1770367-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in conditional compilation based on CONFIG_SRCU.
Therefore, remove the #ifdef and throw away the #else clause.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/locks.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 8f01bee177159..1909a9de242c8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1889,7 +1889,6 @@ int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
 }
 EXPORT_SYMBOL(generic_setlease);
 
-#if IS_ENABLED(CONFIG_SRCU)
 /*
  * Kernel subsystems can register to be notified on any attempt to set
  * a new lease with the lease_notifier_chain. This is used by (e.g.) nfsd
@@ -1923,30 +1922,6 @@ void lease_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(lease_unregister_notifier);
 
-#else /* !IS_ENABLED(CONFIG_SRCU) */
-static inline void
-lease_notifier_chain_init(void)
-{
-}
-
-static inline void
-setlease_notifier(long arg, struct file_lock *lease)
-{
-}
-
-int lease_register_notifier(struct notifier_block *nb)
-{
-	return 0;
-}
-EXPORT_SYMBOL_GPL(lease_register_notifier);
-
-void lease_unregister_notifier(struct notifier_block *nb)
-{
-}
-EXPORT_SYMBOL_GPL(lease_unregister_notifier);
-
-#endif /* IS_ENABLED(CONFIG_SRCU) */
-
 /**
  * vfs_setlease        -       sets a lease on an open file
  * @filp:	file pointer
-- 
2.31.1.189.g2e36527f23

