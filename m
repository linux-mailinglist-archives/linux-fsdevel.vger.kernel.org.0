Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D586A8A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCBU3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCBU3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D821ABDC;
        Thu,  2 Mar 2023 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H2cUIW21WZq17g9O2oNgRsa778WFbjBOimotIrmyA/E=; b=nNmP8ACa3bYQFO+va5O1HA9FsY
        7uEoxbwqkYk/qt113tW2SYA9YMG3a2AHu8L7Iv3iQ0EMlgc7BBKKyksmjuEvEnZO0sSPh+srw21Ed
        92vGNiItW9t2AeJ5aH7Je//Kla0sYsQd6yw57DZXv4g5YLEqNM5fx8BqApdQ2WOzt1ETsFacehG28
        1v5ozP5b85IjoFEOhl2RVeEKNDt9QH7O2q/lI+HC3DfepUovBBCkaCjB4ahImpZOYcj2qeiGF+SSR
        bKm0l0YVBiFRo1VjmJYCVnVBvM6yvLikEV5zJHWv1DMHYb3GMsppkfKWHIApcwT0D+DZwuAqLb0xi
        hYGi9dkg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxJ-9n; Thu, 02 Mar 2023 20:28:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 06/11] yama: simplfy sysctls with register_sysctl()
Date:   Thu,  2 Mar 2023 12:28:21 -0800
Message-Id: <20230302202826.776286-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302202826.776286-1-mcgrof@kernel.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

register_sysctl_paths() is only need if you have directories with
entries, simplify this by using register_sysctl().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 security/yama/yama_lsm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..90dd012b0db5 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -447,12 +447,6 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
 
 static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
-static struct ctl_path yama_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ .procname = "yama", },
-	{ }
-};
-
 static struct ctl_table yama_sysctl_table[] = {
 	{
 		.procname       = "ptrace_scope",
@@ -467,7 +461,7 @@ static struct ctl_table yama_sysctl_table[] = {
 };
 static void __init yama_init_sysctl(void)
 {
-	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table))
+	if (!register_sysctl("kernel/yama", yama_sysctl_table))
 		panic("Yama: sysctl registration failed.\n");
 }
 #else
-- 
2.39.1

