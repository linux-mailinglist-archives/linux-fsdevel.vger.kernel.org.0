Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E16662C44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjAIRI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjAIRHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:07:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80863D9C6;
        Mon,  9 Jan 2023 09:06:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs20so8890887wrb.3;
        Mon, 09 Jan 2023 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUTGNtTWUZq9Xoje3nsOop87o5Mba7F27fOFrJfe2eQ=;
        b=HgfVbMkcCLZZu6XmhqgrMXw7DD0yrq+R391qfVS+t+ETVWXmmZ9iLYRmGdMsbq99Ah
         p3viZaylRYsq8TKpGrgb23TS6CW8xAjn/h81Fouvbv5WtFs8g60SnpB2ZHXyPSJVLn89
         wGRFrru0Oes6WH3vK3e5SjbQ/B5tbvFt479w0TjtcP1NPMngBoH+uAQO57rt66Mh5qVr
         FN8oMZNj//gUfyoBhvQQ+pMnNDMf90gGGQ0io6FCakFsCsZ3u6fDStV5BdQyWEKy8kCH
         9xEJX9sUWyTceOd672p3F8aEL97iVSmqL7DVluCwpQkxAe2kS9yX76FhCx7vmr2sgIxx
         NoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUTGNtTWUZq9Xoje3nsOop87o5Mba7F27fOFrJfe2eQ=;
        b=kikS1tit/Flo0ZLLb9+hyNuSHLzI62dRwzAUwcxlBf7SDcAU2OVRPi3XnX5RF8r84+
         Ptw/yxj+SByzpS75X2ZUxNtJVuZIr5E5Fgu6WefT7zxJvwNNPmGEoFwMAf04c/rB6nEw
         tVB7cAo9IFQ5FoyDnUjaCaZMRf8lP99XPtc/Iwkb85fl2/Xe6x0JFo/itx82KBRdQ+B2
         RP1tYCuM2F+qTyMYTel8dVHr0Q2E0J++CA6Ukl2YduXF5NhDkBrv8tku7lp2YFwqS+9a
         83IqtQE3Db+up/UvCS/16ytOT4YGD+U+7LVedkMrKAvT/Lqzcpo7u8P58u35TNLaANIY
         s3AA==
X-Gm-Message-State: AFqh2koyVtqhn1rMSxEM4fwkHziYMg6PDV0iVvfQwwqTouUyw6hHKJ4g
        rJ5tkwDxtbtHHYTmtemJxnw=
X-Google-Smtp-Source: AMrXdXsUUu0vIw1r83K+4bQJ8Gxca23zAEBovS/WFacuZRUWtWBEIgPdXpM1DTACrYshvgQ/ilpOBA==
X-Received: by 2002:adf:ed02:0:b0:2bc:841d:b831 with SMTP id a2-20020adfed02000000b002bc841db831mr490804wro.55.1673284009240;
        Mon, 09 Jan 2023 09:06:49 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm8954527wrx.96.2023.01.09.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:06:48 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 3/4] fs/sysv: Use dir_put_page() in sysv_rename()
Date:   Mon,  9 Jan 2023 18:06:38 +0100
Message-Id: <20230109170639.19757-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109170639.19757-1-fmdefrancesco@gmail.com>
References: <20230109170639.19757-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the dir_put_page() helper in sysv_rename() instead of open-coding two
kunmap() + put_page().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

No changes from v1.

 fs/sysv/dir.c   | 2 +-
 fs/sysv/namei.c | 9 +++------
 fs/sysv/sysv.h  | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index f953e6b9251e..ee38dc5a3010 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -28,7 +28,7 @@ const struct file_operations sysv_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
-static inline void dir_put_page(struct page *page)
+inline void dir_put_page(struct page *page)
 {
 	kunmap(page);
 	put_page(page);
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index b2e6abc06a2d..981c1d76f342 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -250,13 +250,10 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	return 0;
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		dir_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	dir_put_page(old_page);
 out:
 	return err;
 }
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index 99ddf033da4f..b250ac1dd348 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -148,6 +148,7 @@ extern void sysv_destroy_icache(void);
 
 
 /* dir.c */
+extern void dir_put_page(struct page *page);
 extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
 extern int sysv_add_link(struct dentry *, struct inode *);
 extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
-- 
2.39.0

