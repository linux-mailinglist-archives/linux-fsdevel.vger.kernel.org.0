Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA21991820
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfHRRAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46171 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHRQ76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so5701037pfc.13;
        Sun, 18 Aug 2019 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A08CQyPF693tmDGwyR4szt4dpA6CyB4J0ZetXSJxCsI=;
        b=D3UzYMN0ubh5OjWIPnDT31k0PC+Ich0Iti3pY8agIwmBEfh4giotU36w7CPi4aJUDi
         A8TNhlzmGX8N3gYYHeBmUl5gYG1Aps4+iKvb4f35zC5C7YcEEC0OByyfZWa1rn/O49Lt
         68+eVWloTEJkFhTCp2xX+kNHj9dt3X6uBFi3jpq9OyZizQHEbx5k2zmja0JwdM+28t0l
         TTWijpf7HfhmcQwyCcJFnxlwAI2YEXMtQPIkITSGzA8Im21zk2spABQgrB8RRZWFQ5AU
         eehoFZArqJHemcbdJURNxrYnz49EKHnREgfoC+d2IpP+KePg604bCIye/3bBbLZYyXF8
         t7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A08CQyPF693tmDGwyR4szt4dpA6CyB4J0ZetXSJxCsI=;
        b=Ynx1pVjBnrU7GxTbal9W/qxIhZKTgV0CpJjFSe2z9ZwTX1Yp4f6hKN7mNfPIUD3aPM
         ow0PnU9t+UQotLQcE/VlZIExAWnjge2M1LYN+i1NOrPl5evmIOr8cg0qF8hXBfNsnX+L
         wZ9d5ML51sqyUEjNcaielekw7I02fXZy7WYDm/IuzPIxQtRK8e4Dj8wmRpbJ2f1Voas6
         MXr9j9Qccze7lr4F0+Ix1M9ydfeMrApKu9ZVdGgui8fRgDdBA+gI0RrEBMH+wJ8H6dz6
         KrrHBTGN/V2uu6j5wzfbihVckquHjxkMZIJ5wSIM7Aq02cS3CtYLnIJXcrLmnA+K3VyN
         bppg==
X-Gm-Message-State: APjAAAUv16emr1UkKFDghmcIC6JQPs8yaYjlftwix38URLJ5RTMkoIko
        oquhYMSPAKoGq/Gxf/ZOMmg=
X-Google-Smtp-Source: APXvYqx/sle7DSPuLV3QaIXCNVWde/w+5lmvjpliq7rm7/ePMmQOHOoZqsVToWT6ZCOTNTb876Y+/Q==
X-Received: by 2002:a63:b10f:: with SMTP id r15mr16218681pgf.230.1566147597851;
        Sun, 18 Aug 2019 09:59:57 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:57 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, hirofumi@mail.parknet.co.jp
Subject: [PATCH v8 12/20] fs: fat: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:09 -0700
Message-Id: <20190818165817.32634-13-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Some FAT variants indicate that the years after 2099 are not supported.
Since commit 7decd1cb0305 ("fat: Fix and cleanup timestamp conversion")
we support the full range of years that can be represented, up to 2107.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hirofumi@mail.parknet.co.jp
---
 fs/fat/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 0bc2abc5d453..f27f84e2103f 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -31,6 +31,11 @@
 
 #define KB_IN_SECTORS 2
 
+/* DOS dates from 1980/1/1 through 2107/12/31 */
+#define FAT_DATE_MIN (0<<9 | 1<<5 | 1)
+#define FAT_DATE_MAX (127<<9 | 12<<5 | 31)
+#define FAT_TIME_MAX (23<<11 | 59<<5 | 29)
+
 /*
  * A deserialized copy of the on-disk structure laid out in struct
  * fat_boot_sector.
@@ -1617,6 +1622,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	int debug;
 	long error;
 	char buf[50];
+	struct timespec64 ts;
 
 	/*
 	 * GFP_KERNEL is ok here, because while we do hold the
@@ -1710,6 +1716,12 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	sbi->free_clus_valid = 0;
 	sbi->prev_free = FAT_START_ENT;
 	sb->s_maxbytes = 0xffffffff;
+	fat_time_fat2unix(sbi, &ts, 0, cpu_to_le16(FAT_DATE_MIN), 0);
+	sb->s_time_min = ts.tv_sec;
+
+	fat_time_fat2unix(sbi, &ts, cpu_to_le16(FAT_TIME_MAX),
+			  cpu_to_le16(FAT_DATE_MAX), 0);
+	sb->s_time_max = ts.tv_sec;
 
 	if (!sbi->fat_length && bpb.fat32_length) {
 		struct fat_boot_fsinfo *fsinfo;
-- 
2.17.1

