Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED06B55F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjCJXpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjCJXpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:45:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB4126991;
        Fri, 10 Mar 2023 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6RSbXeOyJXMcC096K906LGWK1pufxQXw88aIMgb//hY=; b=oPkUxijQji7nsAPM9NoPoMym+I
        AR65R3ylE5x03QCPirCr2PlHYS0RXVk6IA586IZCoN+CVwZyxHSPlfGIRAOj/TNyFpl67NiQB0txS
        dNinDi5REGeIrrg5VGBGMjJzr6z9eF1AmBa7IFYBe5tcWeTT1u2eu7mHZsx9QBht1S6dYvGp60Lij
        y5NMIxZAhBUSZlsUAT58b4NtLvGew+LNFw6z8eEPaI+yo1xxDFjfA08xuqBhHueLjj9y4A1VV/AqF
        RktygUAbAEOmsDduIfaJl+JYHG2UDxfI25po7gm08BHdl3sZJ03wZ0inOuzaNEmxwVhVv0zZ8FAix
        EUc9SXIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamQS-00Gj35-95; Fri, 10 Mar 2023 23:45:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6/6] s390: simplify dynamic sysctl registration for appldata_register_ops
Date:   Fri, 10 Mar 2023 15:45:25 -0800
Message-Id: <20230310234525.3986352-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310234525.3986352-1-mcgrof@kernel.org>
References: <20230310234525.3986352-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The routine appldata_register_ops() allocates a sysctl table
with 4 entries. The firsts one,   ops->ctl_table[0] is the parent directory
with an empty entry following it, ops->ctl_table[1]. The next entry is
for the the ops->name and that is ops->ctl_table[2]. It needs an empty
entry following that, and that is ops->ctl_table[3]. And so hence the
kcalloc(4, sizeof(struct ctl_table), GFP_KERNEL).

We can simplify this considerably since sysctl_register("foo", table)
can create the parent directory for us if it does not exist. So we
can just remove the first two entries and move back the ops->name to
the first entry, and just use kcalloc(2, ...).

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/s390/appldata/appldata_base.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index c593f2228083..a60c1e093039 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -351,7 +351,8 @@ int appldata_register_ops(struct appldata_ops *ops)
 	if (ops->size > APPLDATA_MAX_REC_SIZE)
 		return -EINVAL;
 
-	ops->ctl_table = kcalloc(4, sizeof(struct ctl_table), GFP_KERNEL);
+	/* The last entry must be an empty one */
+	ops->ctl_table = kcalloc(2, sizeof(struct ctl_table), GFP_KERNEL);
 	if (!ops->ctl_table)
 		return -ENOMEM;
 
@@ -359,17 +360,12 @@ int appldata_register_ops(struct appldata_ops *ops)
 	list_add(&ops->list, &appldata_ops_list);
 	mutex_unlock(&appldata_ops_mutex);
 
-	ops->ctl_table[0].procname = appldata_proc_name;
-	ops->ctl_table[0].maxlen   = 0;
-	ops->ctl_table[0].mode     = S_IRUGO | S_IXUGO;
-	ops->ctl_table[0].child    = &ops->ctl_table[2];
+	ops->ctl_table[0].procname = ops->name;
+	ops->ctl_table[0].mode     = S_IRUGO | S_IWUSR;
+	ops->ctl_table[0].proc_handler = appldata_generic_handler;
+	ops->ctl_table[0].data = ops;
 
-	ops->ctl_table[2].procname = ops->name;
-	ops->ctl_table[2].mode     = S_IRUGO | S_IWUSR;
-	ops->ctl_table[2].proc_handler = appldata_generic_handler;
-	ops->ctl_table[2].data = ops;
-
-	ops->sysctl_header = register_sysctl_table(ops->ctl_table);
+	ops->sysctl_header = register_sysctl(appldata_proc_name, ops->ctl_table);
 	if (!ops->sysctl_header)
 		goto out;
 	return 0;
-- 
2.39.1

