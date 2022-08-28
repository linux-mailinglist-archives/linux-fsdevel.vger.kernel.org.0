Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345505A3BEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiH1FFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiH1FFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0BA20187;
        Sat, 27 Aug 2022 22:05:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 145so4949171pfw.4;
        Sat, 27 Aug 2022 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=88iMR9hKTzO75VCZYoWA2Dyf+17rRly6JO4axtKQRAk=;
        b=lTmTgVWefuYiMBVuFrLa1g5eQioOHeZaNbUAQjZ+AZMYlDFPH5RyLjKfEp5k1fXaNn
         lc0e3P7vC9FHj9Kk1I1orjytNoE9liLI174dfWbTLwkNFIf+orKY+u0B+B4BiDdG0cjz
         WEuFWb+PJwoarY7x38VVguCSAPN0PsQDcIhOg975pyMhqzsT/BEVxM+t2gkdMARetsG5
         gea60SBcLfx95dySBKGYXXgxPSSgs+9PKE6mocMjUyPHq7i1yZHz1yUDN4x2C5kvuao9
         KNQ1eU3K1pF9FDp26g/3v2fdix63GBLHCQFcU6+06VnkFAl0YhffcAA0SBwYkzhSb21T
         HnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=88iMR9hKTzO75VCZYoWA2Dyf+17rRly6JO4axtKQRAk=;
        b=U4CrL1BlIIU48mi4SRF7pQhJbJbll1UDhnMWmMVTq+c1BL6gAuKweS0KAM0khoYJWv
         J/7+vpRE9Ax9rA1cyVHz9xH7JFdpvNp/zD9Xd0x/uHeCV8QGb6wNP+7RdNNk2YnZ9XRY
         rv01FoVokyRAhvnGT4c2xLbvmgCEU+PIvo3+TAlDuo+MsJxwPIysQY6/v+JgeFqBeC6E
         imSy+DqwD5Fhw4F55Edqgh7Rgo99GSDHA7gaGqGt9hwHNFasOxZMkeD7bPXjBf/BkzGK
         xmmekbNZ7klLUemxezp7T6vo6l/Gq/BPu+jl9SxTk3mHpdSqxpSYsPqYi+zgjXBgYRCy
         5WDQ==
X-Gm-Message-State: ACgBeo0xCl9K2+qY0nG45GhhOAGoKvpQPH/JIfjqpxS6n14zEMSUU7zv
        IDyFVt42d2pUy2ioVoKRUtittP65TnA=
X-Google-Smtp-Source: AA6agR47JMYOXWCuFVL1r98hC3vz/cs21hssdmz3ZDfBQMYVsAqr0m2hQ3kRZIVzuqfVUjtpUq/msg==
X-Received: by 2002:a63:e352:0:b0:42b:dc03:cc38 with SMTP id o18-20020a63e352000000b0042bdc03cc38mr1658154pgj.545.1661663104101;
        Sat, 27 Aug 2022 22:05:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bj15-20020a056a02018f00b0041d70c03da5sm3888480pgb.60.2022.08.27.22.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:05:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/9] kernfs: Factor out kernfs_activate_one()
Date:   Sat, 27 Aug 2022 19:04:38 -1000
Message-Id: <20220828050440.734579-8-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828050440.734579-1-tj@kernel.org>
References: <20220828050440.734579-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out kernfs_activate_one() from kernfs_activate() and reorder
operations so that KERNFS_ACTIVATED now simply indicates whether activation
was attempted on the node ignoring whether activation took place. As the
flag doesn't have a reader, the refactoring and reordering shouldn't cause
any behavior difference.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f8cbd05e9b68..c9323956c63c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1305,6 +1305,21 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 	return pos->parent;
 }
 
+static void kernfs_activate_one(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+
+	kn->flags |= KERNFS_ACTIVATED;
+
+	if (kernfs_active(kn) || (kn->flags & KERNFS_REMOVING))
+		return;
+
+	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
+	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+
+	atomic_sub(KN_DEACTIVATED_BIAS, &kn->active);
+}
+
 /**
  * kernfs_activate - activate a node which started deactivated
  * @kn: kernfs_node whose subtree is to be activated
@@ -1326,16 +1341,8 @@ void kernfs_activate(struct kernfs_node *kn)
 	down_write(&root->kernfs_rwsem);
 
 	pos = NULL;
-	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		if (kernfs_active(pos) || (pos->flags & KERNFS_REMOVING))
-			continue;
-
-		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
-		WARN_ON_ONCE(atomic_read(&pos->active) != KN_DEACTIVATED_BIAS);
-
-		atomic_sub(KN_DEACTIVATED_BIAS, &pos->active);
-		pos->flags |= KERNFS_ACTIVATED;
-	}
+	while ((pos = kernfs_next_descendant_post(pos, kn)))
+		kernfs_activate_one(pos);
 
 	up_write(&root->kernfs_rwsem);
 }
-- 
2.37.2

