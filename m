Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947E668825
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 01:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbjAMALp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 19:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjAMALk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DD2196;
        Thu, 12 Jan 2023 16:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37015621E7;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECEC4331E;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=fHoR4awBBwDobL/5OpE5v/VOKzkbb2pwjwCxM8iuNdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvxZF9yNUhj1bZlIh2FFp/QWWmY8978MvkoYvggqN2rxsQ4WQwkuKO25w6bVb+6KY
         6HVnkJfSRyecbTMq18WoPOgui5GHjdAfyXrcbkyxFfH2o9s9mrjAs6zEtVD7b2YUWV
         5nh+crS9RfDP2xBD527PDNRcj6WvL/CqZDvnNJyW/hpmLZWB/e1Mv7ox0FIYUbg0XQ
         goRmKs1MhJCVy6LJEh+Na69LzgSGjlrraW3lpQhNEtknUMi4+Z4PbkJXbJfDKRvt6v
         zgOj3DyibRetiyui7PYLB5tTNmitPHDLu1Vh4cb1FIluxMNqzdPMuLIKYHKsDGqFB0
         uEQ44Gx5LSv8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A66815C17DC; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 09/20] fs: Remove CONFIG_SRCU
Date:   Thu, 12 Jan 2023 16:11:21 -0800
Message-Id: <20230113001132.3375334-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
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
Reviewed-by: John Ogness <john.ogness@linutronix.de>
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

