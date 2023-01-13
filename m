Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0287668827
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 01:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjAMALr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 19:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjAMALl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5045D882;
        Thu, 12 Jan 2023 16:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A35621F0;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B86C4331F;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=TSW+es/7mkqAin48GNIt/poHNpNOZUx5YOK9cMi3/Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjyN1Y0m32N4ojq8b/3ykrHnZGjjwMz+qydoynbf+gotzOgANkkno5y+fxLkZ0P73
         egs+6qQZLwtCRZ/UOGiIGjRlepjuNILJ2fg7CzdHiDFjDQCYfO0YCU31hsvWmV7n/B
         xjCfuWbk9LNlCXMifRar6JkbRqoJG7Z0EvAn7lX0samxGnfLeLTpmF//tyJegzNbvA
         IHnB9J/vBMzahW7dvthSdgRwAnnf+x215CiGk9eIH4FwKmiPCLe4+xHiWIUf4fzqjq
         NJLb9FAO+N+HHChbt/nJFkprMlsav7pakWvRRo6H4TjT4ugcuL2lducvA2jUhY/6zg
         BhdWHoNcaeWOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC7FD5C1C65; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 12/20] fs/notify: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:24 -0800
Message-Id: <20230113001132.3375334-12-paulmck@kernel.org>
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
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 fs/notify/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/notify/Kconfig b/fs/notify/Kconfig
index c020d26ba223e..c6c72c90fd253 100644
--- a/fs/notify/Kconfig
+++ b/fs/notify/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config FSNOTIFY
 	def_bool n
-	select SRCU
 
 source "fs/notify/dnotify/Kconfig"
 source "fs/notify/inotify/Kconfig"
-- 
2.31.1.189.g2e36527f23

