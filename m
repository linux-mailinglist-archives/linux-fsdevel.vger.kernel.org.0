Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF24865A322
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiLaH5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 02:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiLaH5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:57:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAED9D;
        Fri, 30 Dec 2022 23:57:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so14682549wms.0;
        Fri, 30 Dec 2022 23:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3DzRI51PYBUXFaa7iBRSWpK+zXF1njrTHM9hKQ8ASA=;
        b=TWi2DOINUP9biKc29xu8+VPFZChm3y+eYFuYj2cz3sp6slza4h2+ljvtEd6hBKK8R1
         D09H9UubeyVSG/vgLwFehi+d0nfWBITHromhUKcsIA1elW/SbZ94DuBoyjbBB7+Em4Op
         o6D4+sXDq7OtoHClC4nyOPYlF2ExJDOaUgbcMrplVb4xT3T1ihjT/zDwhZW/4J4m/hb5
         bJkQwv10S+07WacGgDxLhD523W6SUpTsBGv5AZ+IcZZa/qjVIuzMAENYOzRrSSiES0Cw
         sW7cugericU8oZMktIM3WPEV/oV2QDRtzGVFjPfn1E+6cdjMfc7bYMcCVQhbhjRFfdjA
         h9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3DzRI51PYBUXFaa7iBRSWpK+zXF1njrTHM9hKQ8ASA=;
        b=DLdgmu9iUxaW7v5Ph5Dklz/b0AHRJfWQLP4NZYL/v2ynYMF6Al/Pxb/kqP2U0c6eG9
         h596FY7Ojk7+ySGPV36Z7066LY3XPCk6K6QH027MgeknBm821gCU8m3bKixS8lNcFzuw
         vQYa6bPXzng+0uoYSp8ZoGmYduTe9qRTCZa1u2tepyjZ/wIHRbLu7ZBzNeJUGeazY6hU
         i/JTF8GMAFasTZWnbHQTK3sJpaJsJytuOxy2kIwR9Sqql06cfuKX6XFQ3avk7IRrbmkw
         +NCs1hFkMUqRiV/iNHb5a8cCVi2u56VhcYkHfEyIwB7hd0Q27c5K93QoW+wrL2NYI/Oi
         3cIA==
X-Gm-Message-State: AFqh2kq7Tu4BVqYwHG+fr51ZiiF+fVMrEqH1VpOy/Vq1qNjhjNGJwS7i
        LQ12pv3maNEu6QpkWFlE312thEKBOvU=
X-Google-Smtp-Source: AMrXdXsDJKyyNtMIrc6A9JejwwuK62KOBjlQJaNVSMsRpfEvhuodXc2sTdc0APG2Gdb4lgNjCXYRvA==
X-Received: by 2002:a05:600c:3d05:b0:3d3:5c21:dd94 with SMTP id bh5-20020a05600c3d0500b003d35c21dd94mr25123341wmb.9.1672473447131;
        Fri, 30 Dec 2022 23:57:27 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm39389232wms.11.2022.12.30.23.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:57:26 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 3/4] fs/sysv: Use dir_put_page() in sysv_rename()
Date:   Sat, 31 Dec 2022 08:57:16 +0100
Message-Id: <20221231075717.10258-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231075717.10258-1-fmdefrancesco@gmail.com>
References: <20221231075717.10258-1-fmdefrancesco@gmail.com>
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
 fs/sysv/dir.c   | 2 +-
 fs/sysv/namei.c | 9 +++------
 fs/sysv/sysv.h  | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 0a8b5828c390..a37747e9e9a3 100644
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

