Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5037BE9C6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfJ3Nhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 09:37:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43502 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3Nhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:37:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so1497137pgh.10;
        Wed, 30 Oct 2019 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rz7QH0F6wLnmKP0y/0TivVCFIkM5VAJcLbadkXKVaJo=;
        b=P6Jn09VqprfdoLMHIA7fbSnGpHm/jwFe4tzwSN1qX1hvhsL8x+pjEjP3MzZQNK3ZBx
         cnei2JQ5/PK/0sAKgXaxnQfDAB5lsnZrM4Xvzr6nMA1RugoKMW2RZvsQXZz1wv4dmiyZ
         OCKmS9ItqEOsJtZ8/eOKFwzbW6CTBu58e07x6TLTzaodXI08k3XHKMxbLBtDoqrqv045
         THN5J7wxztiU3Pb907JPi96mqDXtwp4NfdcCuMh3uDTyAqbPMUEZJqM0f9V3GU3CK2fL
         AF1rX4E1mfJq4AU0b4kVy1TAMeKYntjB8veFVESi5jHHh1u53+pY9BWWJKix9jeVp1/K
         +cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rz7QH0F6wLnmKP0y/0TivVCFIkM5VAJcLbadkXKVaJo=;
        b=GO7Y4pUggX5LWCXOV71jtyECcIrv+84toJhFDuXz6xTxUeWCiYS8oG4NuZOQLOhVsW
         7cpSMw2OApgdXZ6kKPvhqJZrbsbnwCiWViAkffk28cCpLTMY6uTKTQoAINdkXuS6h6/0
         nnACS4gwU0SN/n7DCiaNyMvDfBgubiPk5QkuiLlXczhOfZPoii6cjR6zPT/HzF0mFtFF
         BzLyENTYFx0GjzooLAeee/fZpcUG+RIpr36H+JK4DE7GEPCUSVQGQC+OeuajR0SL6urO
         JYAztIyYXeOqVxh2yKi9XuwHZAJgwY+Z41vm9TAMHHkQ2AdGRHQjen9UmGitqrrmrS/M
         odnQ==
X-Gm-Message-State: APjAAAX3B0fgAJxeAVMjBxBXa2DQU8OSnvvuZxQuUORBQbAZrzl1TaFs
        Yg034c5ksTCzKsj+bg+8CgIxiiU=
X-Google-Smtp-Source: APXvYqxy6M1jhGWqr6DIAHM7goNhtjLlOC5Lcn7zVYM2e9WOIziYtw6tdFoDLaF3Tpjb+e2vX691Bg==
X-Received: by 2002:a62:2b94:: with SMTP id r142mr33773899pfr.251.1572442656400;
        Wed, 30 Oct 2019 06:37:36 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j10sm2333233pfn.128.2019.10.30.06.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 06:37:35 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfs/log: protect the logging content under xc_ctx_lock
Date:   Wed, 30 Oct 2019 21:37:11 +0800
Message-Id: <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <20191030133327.GA29340@mypc>
References: <20191030133327.GA29340@mypc>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xc_cil_lock is not enough to protect the integrity of a trans logging.
Taking the scenario:
  cpuA                                 cpuB                          cpuC

  xlog_cil_insert_format_items()

  spin_lock(&cil->xc_cil_lock)
  link transA's items to xc_cil,
     including item1
  spin_unlock(&cil->xc_cil_lock)
                                                                      xlog_cil_push() fetches transA's item under xc_cil_lock
                                       issue transB, modify item1
                                                                      xlog_write(), but now, item1 contains content from transB and we have a broken transA

Survive this race issue by putting under the protection of xc_ctx_lock.
Meanwhile the xc_cil_lock can be dropped as xc_ctx_lock does it against
xlog_cil_insert_items()

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/xfs/xfs_log_cil.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 004af09..f8df3b5 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -723,22 +723,6 @@ xlog_cil_push(
 	 */
 	lv = NULL;
 	num_iovecs = 0;
-	spin_lock(&cil->xc_cil_lock);
-	while (!list_empty(&cil->xc_cil)) {
-		struct xfs_log_item	*item;
-
-		item = list_first_entry(&cil->xc_cil,
-					struct xfs_log_item, li_cil);
-		list_del_init(&item->li_cil);
-		if (!ctx->lv_chain)
-			ctx->lv_chain = item->li_lv;
-		else
-			lv->lv_next = item->li_lv;
-		lv = item->li_lv;
-		item->li_lv = NULL;
-		num_iovecs += lv->lv_niovecs;
-	}
-	spin_unlock(&cil->xc_cil_lock);
 
 	/*
 	 * initialise the new context and attach it to the CIL. Then attach
@@ -783,6 +767,25 @@ xlog_cil_push(
 	up_write(&cil->xc_ctx_lock);
 
 	/*
+	 * cil->xc_cil_lock around this loop can be dropped, since xc_ctx_lock
+	 * protects us against xlog_cil_insert_items().
+	 */
+	while (!list_empty(&cil->xc_cil)) {
+		struct xfs_log_item	*item;
+
+		item = list_first_entry(&cil->xc_cil,
+					struct xfs_log_item, li_cil);
+		list_del_init(&item->li_cil);
+		if (!ctx->lv_chain)
+			ctx->lv_chain = item->li_lv;
+		else
+			lv->lv_next = item->li_lv;
+		lv = item->li_lv;
+		item->li_lv = NULL;
+		num_iovecs += lv->lv_niovecs;
+	}
+
+	/*
 	 * Build a checkpoint transaction header and write it to the log to
 	 * begin the transaction. We need to account for the space used by the
 	 * transaction header here as it is not accounted for in xlog_write().
-- 
2.7.5

