Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7A44195F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhKAKHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhKAKGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:06:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16925C046383
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Nov 2021 02:38:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so15595305pji.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3n/eNSdVxlSjMk13ChGiWhuWjUn4hZkjFbVG3KgqlOg=;
        b=IoMzgpsE+wuebyMjCwnpq8dYjSkQbLfyYLAL0zInLpPwR7hqu9rvXlD+XtGE36MuA/
         rlbSvFJcZEpw5UcvD7pjEVlcTNLkQQWdavnOkHtN8wFb1wzjyMV5mBDEXUb9oIBil9Tz
         AorEwS0GE1QzkttRILrP7kDxBFDGBEBPaWZKuwhsGOQhS6I73ZEH7BV8hSvmKF/R3931
         b6OPpgGoraUWcqWncQLLUbaofsYegZWrPrJuwsx6m6g4NTpw5ATbxt4e3iAjITnpPjnc
         YqQMUXU5F2uRlB7yT1VPHIolB5stCBArccGvpflExAR/0a/v0juXS3h3qjIvYjN3PFUP
         3WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3n/eNSdVxlSjMk13ChGiWhuWjUn4hZkjFbVG3KgqlOg=;
        b=FV3YpP7PeqnMLVDCZM0E/OAcl7gzCEV0RzvcNFuscM+nsZTEOXraLwEuzube2/bT+U
         Wbe7eliwygLxFn097sYX6EzU69etYHV7YTXVbm3LO9lUaAqjvH6zXMjTeE9Ds8boiswL
         fgoXQ4dedGTq/K0UhVYgF2OrWWWTvRN3A97gMmIzjTbCvsPUtHeELrl4wyaLNl2YzZ/k
         ynD4/npGylDFPD5U7CZlWSMFybxeM6/rbcHM+cjBeWJvf9znFn7pUUXRO0NNRZkbayB6
         Orl2Ewh2/5WQFDsqhr2rr9cSKU2vrgO52SaePTBETUHKI8l9i/rDc7fr+nCOeHrCSbM7
         DSjA==
X-Gm-Message-State: AOAM530D7U27ViCzCwUFKJsIUVfl9ZwgMHmoDbuI/HuMXtW1GMPBbUYM
        9cd71G/r+Vb3psEoJvaneppJ0w==
X-Google-Smtp-Source: ABdhPJz+ht4jAbOhXhwgo3nCLiEjPwovO6xS9f7f7sNAavRQDHCNIyRWB4BwgM2NBuSwmJEE54X9gw==
X-Received: by 2002:a17:902:70c5:b0:13f:f941:9ad6 with SMTP id l5-20020a17090270c500b0013ff9419ad6mr24112760plt.28.1635759490989;
        Mon, 01 Nov 2021 02:38:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id p16sm15738259pfh.97.2021.11.01.02.38.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 02:38:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] fs: proc: remove PDE_DATA()
Date:   Mon,  1 Nov 2021 17:35:17 +0800
Message-Id: <20211101093518.86845-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211101093518.86845-1-songmuchun@bytedance.com>
References: <20211101093518.86845-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no users of PDE_DATA() and we do not need it anymore,
just remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/proc/generic.c       | 6 ------
 fs/proc/internal.h      | 5 -----
 include/linux/proc_fs.h | 2 --
 3 files changed, 13 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5b78739e60e4..f2132407e133 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -791,12 +791,6 @@ void proc_remove(struct proc_dir_entry *de)
 }
 EXPORT_SYMBOL(proc_remove);
 
-void *PDE_DATA(const struct inode *inode)
-{
-	return __PDE_DATA(inode);
-}
-EXPORT_SYMBOL(PDE_DATA);
-
 /*
  * Pull a user buffer into memory and pass it to the file's write handler if
  * one is supplied.  The ->write() method is permitted to modify the
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 03415f3fb3a8..06a80f78433d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -115,11 +115,6 @@ static inline struct proc_dir_entry *PDE(const struct inode *inode)
 	return PROC_I(inode)->pde;
 }
 
-static inline void *__PDE_DATA(const struct inode *inode)
-{
-	return PDE(inode)->data;
-}
-
 static inline struct pid *proc_pid(const struct inode *inode)
 {
 	return PROC_I(inode)->pid;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 069c7fd95396..ec59ccce4308 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -110,7 +110,6 @@ extern struct proc_dir_entry *proc_create_data(const char *, umode_t,
 struct proc_dir_entry *proc_create(const char *name, umode_t mode, struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
 extern void proc_set_size(struct proc_dir_entry *, loff_t);
 extern void proc_set_user(struct proc_dir_entry *, kuid_t, kgid_t);
-extern void *PDE_DATA(const struct inode *);
 extern void *proc_get_parent_data(const struct inode *);
 extern void proc_remove(struct proc_dir_entry *);
 extern void remove_proc_entry(const char *, struct proc_dir_entry *);
@@ -183,7 +182,6 @@ static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
 
 static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
 static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
-static inline void *PDE_DATA(const struct inode *inode) {BUG(); return NULL;}
 static inline void *proc_get_parent_data(const struct inode *inode) { BUG(); return NULL; }
 
 static inline void proc_remove(struct proc_dir_entry *de) {}
-- 
2.11.0

