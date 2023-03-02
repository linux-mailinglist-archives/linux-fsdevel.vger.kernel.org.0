Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018016A8876
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBSWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCBSWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:22:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1541027F;
        Thu,  2 Mar 2023 10:22:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3666499pjg.4;
        Thu, 02 Mar 2023 10:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677781337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HX2Vj0FqJHvCREMyAVXC+Ew/k8upKYV2kIV0kMLwhNg=;
        b=PIOmkhQ3Zmdcw5LDd3JSBkvBEhGf/h08i54ZYcAP9bt78ucYbTMFOMMuyPaZRTviSA
         ZvjjabcdDF958KxtPotYhI/RqV2r0JQ+KOZnvIE39rLW43WAFh+33vZVGM/5KY2/Xedw
         45KrQacLCOIQoraNKb8rKFQiJBArTqVyHMk4aBiBG2MToi3Sl+1C+Wbt617uUnKqZfbG
         vRYP43QanARqxQ+YS924J1cqXWOs4nZ/f8GE+haOBpqk1cWS8tqcV/QEj4OQIarobQjh
         a+sN0HCYvzLiKKici3loOX98aMEyCDiuabwW3Y2k+uziF0xAHzhJUQ+hKLSy+qOowBPK
         Bvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677781337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX2Vj0FqJHvCREMyAVXC+Ew/k8upKYV2kIV0kMLwhNg=;
        b=wybl8bPtdv56mnytyGjjVIgOuFdxHpOFBIhe05SsTSKD9XthXsrojv2WFjiA9VZ/u4
         M9yLWE9699PLgfuMM60McjFUMWOrQOGPmOZ0ml8elAjVZ7JTmZ7jOT+OTnb1nVUrcpA7
         eN2KwqjNFS9zcjHTF3J2PgYYmEenGJTjp5dSOrjBcJyo5y+wAPetps1CNET+e3r/Incc
         QfN8i+h6enqJlBjK/L7MKMs3JUTTJnJ8dTxDGG+yjz34jI8NtggYboEobZnl9P74lzJ3
         /8bzyALCddHGWtORQYbcPQizexzqToAYY05n9N4MV3Gkyld5zXzxxy9Ib0HRyTmAIV1N
         csfQ==
X-Gm-Message-State: AO0yUKXEfyu44xhSFkVA3PnVIIMOPDYmL6PrD22Zx0fLGcCmDlcl/Hs+
        A6PKAgOeye3f7eOoUwVrXJk=
X-Google-Smtp-Source: AK7set/lehteaf2LyWVK/VBv6pfhm/1Eg4IJkxaxcbUnXo5NreywqIY0ZgqWAukxmQqkSCPcbkjdqg==
X-Received: by 2002:a17:90a:fd15:b0:233:a836:15f4 with SMTP id cv21-20020a17090afd1500b00233a83615f4mr11509061pjb.1.1677781337010;
        Thu, 02 Mar 2023 10:22:17 -0800 (PST)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090adc8600b00234b785af1dsm89908pjv.26.2023.03.02.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:22:16 -0800 (PST)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC 1/3] file: Introduce iterate_fd_locked
Date:   Thu,  2 Mar 2023 18:22:05 +0000
Message-Id: <20230302182207.456311-1-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Callers holding the files->file_lock lock can call iterate_fd_locked instead of
iterate_fd

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 fs/file.c               | 21 +++++++++++++++------
 include/linux/fdtable.h |  3 +++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index c942c89ca4cd..4b2346b8a5ee 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1295,15 +1295,12 @@ int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 	return err;
 }
 
-int iterate_fd(struct files_struct *files, unsigned n,
-		int (*f)(const void *, struct file *, unsigned),
-		const void *p)
+int iterate_fd_locked(struct files_struct *files, unsigned n,
+                int (*f)(const void *, struct file *, unsigned),
+                const void *p)
 {
 	struct fdtable *fdt;
 	int res = 0;
-	if (!files)
-		return 0;
-	spin_lock(&files->file_lock);
 	for (fdt = files_fdtable(files); n < fdt->max_fds; n++) {
 		struct file *file;
 		file = rcu_dereference_check_fdtable(files, fdt->fd[n]);
@@ -1313,6 +1310,18 @@ int iterate_fd(struct files_struct *files, unsigned n,
 		if (res)
 			break;
 	}
+	return res;
+}
+
+int iterate_fd(struct files_struct *files, unsigned n,
+		int (*f)(const void *, struct file *, unsigned),
+		const void *p)
+{
+	int res = 0;
+	if (!files)
+		return 0;
+	spin_lock(&files->file_lock);
+	res = iterate_fd_locked(files, n, f, p);
 	spin_unlock(&files->file_lock);
 	return res;
 }
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..14882520d1fe 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -122,6 +122,9 @@ void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
+int iterate_fd_locked(struct files_struct *, unsigned,
+			int (*)(const void *, struct file *, unsigned),
+			const void *);
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.34.1

