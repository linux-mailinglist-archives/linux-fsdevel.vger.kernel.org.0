Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06A4A4DF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbiAaSXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352535AbiAaSWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:22:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62449C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:49 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so13789697otr.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=5vGwoTC1e4kUUVS5mywGbNPZbTA57tIfGZpAbVJZdPc=;
        b=uPAa/sk2IOzeJCHeNYiZWThya96U6MZM4TNQ3W7xElP3WnOciW2NWRUaZxJqVc/BWD
         SL9+Z0BaL2cO27liA1EJhEw4sAE9ciMh8O+O4iz/CJqfzFRMEHGzU+1OOZ5WFXzR/YE+
         g1Q8GfZ4Hpqk2ocPtEBaUT3M8xpubQ9wvpghAK6NWnS0MkjnNLfCK55fLZFBoSyXYCnP
         tdF07TqTEznFa0zfc2THo6oHqjc6ZackuizbICp61oOu6IHX6qQ5K3OycwutEP6Fv99c
         X34D8BlZb6UKTusYwwckqKWB+lmWP1YmTeOEbtEUUsy+0rEg1FJl/gbV3AzZWoYGZkhC
         VCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=5vGwoTC1e4kUUVS5mywGbNPZbTA57tIfGZpAbVJZdPc=;
        b=uugORxtI9qC8FkjUdjeY8H8AKUd9QSCztXVzfh9Hthhx5q7peeLOZ+rh3n9T6TtcIj
         kPT3sGCfGsO9S1DmHt1IDyn3GtqVb4Z9MpwgMygQ8kpyK3YOqiC/Ug62GYwZM7s5UKZD
         N/TGatSBI1fCgd1K4seLej8IPO+qLx5eC1XpU8xOP8iwnffNFTiDMcMu6V0G+5B4dyqT
         rSbhTk+PUjdh4S4hDKLxOZ81fcP77RuLxMtJorX1l8y68pGhGxwLki7xzp337fRbvd05
         cP09BA6Mdi6qfphP8X30PAm3nmTimpe0tFaRXGVhXkAXNYfliR+iBd97mv6cX9Os6h+Q
         uC5g==
X-Gm-Message-State: AOAM53014U/o1TPHwFOdmCq9lDKZH+CIngr6xon9Zu5p0OMsZ9AudSsB
        xcnBQvnJbZQeqewkkAtlokGktw==
X-Google-Smtp-Source: ABdhPJyFkngoaC74FUTn3EaXxXFZljpAATvXAlAMBERI5eghY/B2TUgZRyyVHgs4KNqPSAnjGDqyIw==
X-Received: by 2002:a9d:1f0:: with SMTP id e103mr9137176ote.234.1643653368677;
        Mon, 31 Jan 2022 10:22:48 -0800 (PST)
Received: from fedora ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id m14sm1003163ooj.22.2022.01.31.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:22:48 -0800 (PST)
Date:   Mon, 31 Jan 2022 15:22:42 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, ndesaulniers@google.com, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v3] seq_file: fix NULL pointer arithmetic warning
Message-ID: <Yfgo8p6Vk+h4+YHY@fedora>
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
V2 -> V3:
- Remove the EXPORT of the single_start symbol
---
 fs/kernfs/file.c         | 7 +------
 fs/seq_file.c            | 4 ++--
 include/linux/seq_file.h | 1 +
 3 files changed, 4 insertions(+), 8 deletions(-)

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
index f8e1f4ee87ff..7ab8a58c29b6 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -554,9 +554,9 @@ int seq_dentry(struct seq_file *m, struct dentry *dentry, const char *esc)
 }
 EXPORT_SYMBOL(seq_dentry);
 
-static void *single_start(struct seq_file *p, loff_t *pos)
+void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	return *pos ? NULL : SEQ_START_TOKEN;
 }
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
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

