Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA24A4D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350406AbiAaR4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiAaR4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:56:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA55C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 09:56:20 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u13so11960658oie.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=BVD0NSbX3nj02sBgzS26Hzi8d1ZIOHSSU47jm/3MiI0=;
        b=kEM6rNetZF01SR0pi5B+qDDKi3p/QNb3xolAKlDE3PbprwbOww1d0ZRLalVqU9fwHY
         1kKtnwvoE65sHCs7JX+ZVlBmfLYE4sslG9hvPFVcL104Gy/BhEQd+zKVCXZppeg4xMUe
         3wh4tKonjg/Zp7Qm9yrxLgQzZ3i575Hj5ddAai/sxziVCoaVs8cEl1my7e0R0TWl4EdV
         GBlDZX6fxsr3P33VRf0nN1pGgqVQK9uJLFdzVeOlxjzvPfNBKXHPlaEZ9Zz0nAuzp/q5
         ICqxDNCecVtvhOx8QLvMJTu26eovXTbxs/0HflbKs4Tf8qIaYjw30c8LFME3hXPs5mOB
         VmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=BVD0NSbX3nj02sBgzS26Hzi8d1ZIOHSSU47jm/3MiI0=;
        b=BdY9fS49YWcqjHhFJhg8bbAF2bpAMvEwpzwS6gdSLaLA3QXIehqyhVrOwW9TQ+pMjb
         zYlzr8l8R7Qj9KqDa+2qN9Bs1JNOgj2KMqY09oMW8rWl0s2KBOq32AcA4espu/9f7qvl
         XNh4jfSr6pZiT6jEzvyyRbJ3qnn0FnJWx5D+Xrzs+i3w5Bx4ftMEiVaurCoBoWuk4R1a
         K4QEjXNQ5l6pEFQZDoNbe777j1Vd38fxri+dv4iwAlCu0O4QmF8nisI4Bd9I/XOpR4/2
         hUAgz75cBK6sVyjYqOtG8ccQU/AjVvSu0c4VAyYQyszxDP26Xezqjjo/BXiHj99uv/Pg
         eoFQ==
X-Gm-Message-State: AOAM533zWSVp3prJlz/X6+0FKfBC1qwy+z0HCjx/6WOLAb7sEz8Qvt6U
        ItmjIVNoF+rSjpKAzTkJIrl+/w==
X-Google-Smtp-Source: ABdhPJxTt13DSu5K/UgSNfsHqPrBctZ8yNK463AzxV13RIocT8h2aaYGcoAZcFFPegFyhHACuSBw/Q==
X-Received: by 2002:a05:6808:1583:: with SMTP id t3mr18106273oiw.248.1643651779818;
        Mon, 31 Jan 2022 09:56:19 -0800 (PST)
Received: from fedora ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id w191sm13425965oiw.42.2022.01.31.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:56:19 -0800 (PST)
Date:   Mon, 31 Jan 2022 14:56:13 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2] seq_file: fix NULL pointer arithmetic warning
Message-ID: <YfgivbCgwKjJu9ec@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement conditional logic in order to replace NULL pointer arithmetic.

The use of NULL pointer arithmetic was pointed out by clang with the
following warning:

fs/kernfs/file.c:128:15: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                return NULL + !*ppos;
                       ~~~~ ^
fs/seq_file.c:559:14: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
        return NULL + (*pos == 0);

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
V1 -> V2:
- Use SEQ_START_TOKEN instead of open-coding it
- kernfs_seq_start call single_start instead of open-coding it
---
 fs/kernfs/file.c         | 7 +------
 fs/seq_file.c            | 5 +++--
 include/linux/seq_file.h | 1 +
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f..7aefaca876a0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -120,13 +120,8 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 		if (next == ERR_PTR(-ENODEV))
 			kernfs_seq_stop_active(sf, next);
 		return next;
-	} else {
-		/*
-		 * The same behavior and code as single_open().  Returns
-		 * !NULL if pos is at the beginning; otherwise, NULL.
-		 */
-		return NULL + !*ppos;
 	}
+	return single_start(sf, ppos);
 }
 
 static void *kernfs_seq_next(struct seq_file *sf, void *v, loff_t *ppos)
diff --git a/fs/seq_file.c b/fs/seq_file.c
index f8e1f4ee87ff..bb2b15d3f1c5 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -554,10 +554,11 @@ int seq_dentry(struct seq_file *m, struct dentry *dentry, const char *esc)
 }
 EXPORT_SYMBOL(seq_dentry);
 
-static void *single_start(struct seq_file *p, loff_t *pos)
+void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	return *pos ? NULL : SEQ_START_TOKEN;
 }
+EXPORT_SYMBOL(single_start);
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
 {
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 88cc16444b43..60820ab511d2 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -162,6 +162,7 @@ int seq_dentry(struct seq_file *, struct dentry *, const char *);
 int seq_path_root(struct seq_file *m, const struct path *path,
 		  const struct path *root, const char *esc);
 
+void *single_start(struct seq_file *, loff_t *);
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_open_size(struct file *, int (*)(struct seq_file *, void *), void *, size_t);
 int single_release(struct inode *, struct file *);
-- 
2.34.1

