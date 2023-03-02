Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30276A8A67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCBU3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBU3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22062DE64;
        Thu,  2 Mar 2023 12:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WXKrajJbqkbUb299wVP+wMZwzux4ve5i7i48jqTzVOM=; b=3AqsqJI8lCaM8wKT1MeU5adKVx
        yZUVeEU7kgWNaQDeh/xzFucDN4Eo2WI0oQhEQtYjLrZzlxLm/K6EgYpusTJvObavKIQq5OQ7/aGV6
        P2qhNLsnCTtYcoT2Gq6mV8hgc9pqnjQJyJPPBTxPS6+CxINAW06uYQhM/r+B2a+rTf1gZC3ORUVpl
        SFWiS9VweZ2Oedn5boZUmx5k9N3jEUYi+qIyoewiOXydRoabiTbtzYKZ6ihTguLW4MLFxkxmc2Cnx
        42fqvnsTQpDvHVmGcTxt7SbWhhrBrKOXofmIibo3iaW6acX0VORs7MqgDieHMi6lTGwAMqQNMKExv
        jE531YOQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxH-71; Thu, 02 Mar 2023 20:28:30 +0000
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
Subject: [PATCH 05/11] loadpin: simplify sysctls use with register_sysctl()
Date:   Thu,  2 Mar 2023 12:28:20 -0800
Message-Id: <20230302202826.776286-6-mcgrof@kernel.org>
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

register_sysctl_paths() is not required, we can just use
register_sysctl() with the required path specified.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 security/loadpin/loadpin.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index d73a281adf86..c971464b4ad5 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -52,12 +52,6 @@ static bool deny_reading_verity_digests;
 #endif
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_path loadpin_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ .procname = "loadpin", },
-	{ }
-};
-
 static struct ctl_table loadpin_sysctl_table[] = {
 	{
 		.procname       = "enforce",
@@ -262,7 +256,7 @@ static int __init loadpin_init(void)
 		enforce ? "" : "not ");
 	parse_exclude();
 #ifdef CONFIG_SYSCTL
-	if (!register_sysctl_paths(loadpin_sysctl_path, loadpin_sysctl_table))
+	if (!register_sysctl("kernel/loadpin", loadpin_sysctl_table))
 		pr_notice("sysctl registration failed!\n");
 #endif
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
-- 
2.39.1

