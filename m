Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516B6A8A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCBU3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCBU3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1032ED54;
        Thu,  2 Mar 2023 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Bays9fkBFms7vhPJoOG9l9IJ7nM/VsUcupIDAJVjf80=; b=Bz1QvwzCl7hRI0wtSOphGbHAjd
        moIi7Iqb1DdJU55W/01ooclWjla3NRkjZN8KVAJTjDnBHx56pp6jV+k/vQDQHDlEEGrYiKd97L8hf
        ciLumPQjTGpY60IvmgF2Vhq4jHu1hyB1Sd5I5mYi26CzS2nijc5XMgeu7qQ/aDRk8PAiyFPygV9uX
        6zDAhjyOF+7Gd7zpEiaaYWe+ZssvpcYMJmYAdwPvLSFQdFZ7I+qjgHnnpJ25RXsLmk0te+Fc+WTrC
        nB/zhVB0QfdOUAmrW8bGzZmKaXOthdUTNfbaGIEJS/3ZbCBqtLS1H2j1MJd2kdm1R54lAjRnPe8YS
        fmBJaTKA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxN-Eb; Thu, 02 Mar 2023 20:28:30 +0000
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
Subject: [PATCH 08/11] kernel: pid_namespace: simplify sysctls with register_sysctl()
Date:   Thu,  2 Mar 2023 12:28:23 -0800
Message-Id: <20230302202826.776286-9-mcgrof@kernel.org>
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

register_sysctl_paths() is only required if your child (directories)
have entries and pid_namespace does not. So use register_sysctl_init()
instead where we don't care about the return value and use
register_sysctl() where we do.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/pid_namespace.c | 3 +--
 kernel/pid_sysctl.h    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 46e0d5a3f91f..b43eee07b00c 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -314,7 +314,6 @@ static struct ctl_table pid_ns_ctl_table[] = {
 	},
 	{ }
 };
-static struct ctl_path kern_path[] = { { .procname = "kernel", }, { } };
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
@@ -473,7 +472,7 @@ static __init int pid_namespaces_init(void)
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	register_sysctl_paths(kern_path, pid_ns_ctl_table);
+	register_sysctl_init("kernel", pid_ns_ctl_table);
 #endif
 
 	register_pid_ns_sysctl_table_vm();
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index e22d072e1e24..d67a4d45bb42 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -46,10 +46,9 @@ static struct ctl_table pid_ns_ctl_table_vm[] = {
 	},
 	{ }
 };
-static struct ctl_path vm_path[] = { { .procname = "vm", }, { } };
 static inline void register_pid_ns_sysctl_table_vm(void)
 {
-	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
+	register_sysctl("vm", pid_ns_ctl_table_vm);
 }
 #else
 static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
-- 
2.39.1

