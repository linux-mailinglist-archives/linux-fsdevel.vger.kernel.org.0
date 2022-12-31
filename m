Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1465A31E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 08:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLaH51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 02:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLaH50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:57:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020CD9D;
        Fri, 30 Dec 2022 23:57:25 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso14843220wmb.3;
        Fri, 30 Dec 2022 23:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4IpF0CMnhbBf7H7iLN0nfh/18GS/Ps3ATwtaps4Vp8=;
        b=AOl7o3fmt3GWKSukWb8eLrplMvNc8lqZmXLnm8MPUxTsxPucV3/hhW063eGVE1JXg/
         tFrop3VJAz0M3OYKgqncR0UuoMlCV/SJ7vy/NHDNuQsFkfuzyMsecph3+tzNMNPeQ+Uk
         bjpujoOPzTGGa3PaaODY9yWrdaUw/p1tluWLd4suv34ZqrEEDf+o2AAJ94McrOoA9SGN
         tIifYv3uoqRq4Mw8c4+MxJkSX8CrwMAdZJ3ssvjo/5K9lieSW8cbD2WgLUUPm5yYSYq3
         S4ysG2PlRxt9fT73c5m2Dt8fFKzJEB0IkVzJvMw7UcCkmF8lEOKlgifqe2f3Dc0OZWav
         SI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4IpF0CMnhbBf7H7iLN0nfh/18GS/Ps3ATwtaps4Vp8=;
        b=DLhlfuP4hcpsxauMgEwphMkYRL7ax9AeGBviKFWfUNnX2UqKHW7oF9QoYs7FdrS1PV
         WxkFilmACUcuV+NV7c5nnNs2iVCDVhwZlhYJvLN8JhtyAdW2kJleaeNrMtTE2QsVROwv
         cII6YBa4JXOAOLwrig/a+hGwOH56HIZTqyARnAMgPrM4UMS6thQzL4FGZxzKM4iu40gF
         9x2SZVe8fPPQe8DE86U7UiBXdAZHsN7mk7TzBB34bPOZk1itArmANP8bYGaM4Gtz1Zok
         G7mmkZMps/EjjlOBjukBMtZ1tuTy1vXuGdECxacAT9e1dtoBjbtxOWYArZrpn4akbThH
         8ufQ==
X-Gm-Message-State: AFqh2ko8YtVZ99p26ZRXxf+2G4BLlVuGm9PfIxmsEB9VcMBYei9nsxyz
        2QrjS/raTsBxKF+/CjKpouencRbMzBc=
X-Google-Smtp-Source: AMrXdXtLKJOTY3ROoXoRtERdQqXUEdnIAQMc3WUqq79mAgfZYayLl+tF5dfMyDFfgYNb6jVM1jEfwg==
X-Received: by 2002:a05:600c:a13:b0:3d0:2485:c046 with SMTP id z19-20020a05600c0a1300b003d02485c046mr24077127wmp.27.1672473443870;
        Fri, 30 Dec 2022 23:57:23 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm39389232wms.11.2022.12.30.23.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:57:23 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/4] fs/sysv: Use the offset_in_page() helper
Date:   Sat, 31 Dec 2022 08:57:14 +0100
Message-Id: <20221231075717.10258-2-fmdefrancesco@gmail.com>
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

Use the offset_in_page() helper because it is more suitable than doing
explicit subtractions between pointers to directory entries and kernel
virtual addresses of mapped pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9..685379bc9d64 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -206,8 +206,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + offset_in_page(de);
 	lock_page(page);
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	if (err)
@@ -230,8 +229,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = (char*)page_address(page);
-	loff_t pos = page_offset(page) + (char *)de - kaddr;
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
@@ -328,8 +326,7 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	struct inode *inode)
 {
 	struct inode *dir = page->mapping->host;
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
-- 
2.39.0

