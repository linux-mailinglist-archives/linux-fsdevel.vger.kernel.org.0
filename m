Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDE6A8A65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCBU3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCBU30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C81E5D1;
        Thu,  2 Mar 2023 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Twn8MQ1Gcyzszq3QMuH8qlsxJH8SeLsz2Z/0dFs1T4k=; b=OcKK2q+bPChjV8lLm8hD8AxY/r
        0ZovvoOZyeZWiN66xALTlkMSscbzMU03wN2Numi+F46tX1ap0g9sJmBv8Vf2/tFtlHSaGnf8vY1Iq
        OWJZu6BWsKEm0gwUWsNQtpbPMSinmD3Sd4Wf+VCgJqs72vkHGe5kr0edfkTfwCjcFQxx4yTjYSN5L
        4T2Zq+MUsJ1tcSPlT3LJEBjnctee8Tn0g+giVPsQH2/KO3gYJSaf12NznKHR3fgF0pJh4TNcCwyts
        0ggEuqJC5rprNeKbjssHjNnzh4wdI8cykjd8bxvzx6Yx+oxPQ/yvC+38szw8Mk7St5joqEuNvKKXI
        3NnI8Vdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxD-1R; Thu, 02 Mar 2023 20:28:30 +0000
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
Subject: [PATCH 03/11] sysctl: clarify register_sysctl_init() base directory order
Date:   Thu,  2 Mar 2023 12:28:18 -0800
Message-Id: <20230302202826.776286-4-mcgrof@kernel.org>
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

Relatively new docs which I added which hinted the base directories needed
to be created before is wrong, remove that incorrect comment. This has been
hinted before by Eric twice already [0] [1], I had just not verified that
until now. Now that I've verified that updates the docs to relax the context
described.

[0] https://lkml.kernel.org/r/875ys0azt8.fsf@email.froward.int.ebiederm.org
[1] https://lkml.kernel.org/r/87ftbiud6s.fsf@x220.int.ebiederm.org
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6b9b2694d430..15d5e02f1ec0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1440,10 +1440,7 @@ EXPORT_SYMBOL(register_sysctl);
  * register_sysctl() failing on init are extremely low, and so for both reasons
  * this function does not return any error as it is used by initialization code.
  *
- * Context: Can only be called after your respective sysctl base path has been
- * registered. So for instance, most base directories are registered early on
- * init before init levels are processed through proc_sys_init() and
- * sysctl_init_bases().
+ * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
-- 
2.39.1

