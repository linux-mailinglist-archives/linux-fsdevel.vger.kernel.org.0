Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EA3626A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhDPRWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbhDPRWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:22:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0562C06175F;
        Fri, 16 Apr 2021 10:21:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p67so13832275pfp.10;
        Fri, 16 Apr 2021 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AnZhuDCV2gPGk7yptczxHyXrPMAD4WH5esVjmlwoBAc=;
        b=KD0qVc3PsNa/uHNlaBewavU1/Qo+ndvRTB9RE40lseo9pXkEAn6gbxE3oHBYFqfWRO
         NkDOjO9+HbGr4LTdDk27fkeflXnUCRXORejILb813gPRJEbmLjXcId/IrZg7PFjqGLk7
         gjoy+Ul2MGAr2WLpLHeIM8IdtLt+ksREHscMs/Aq2pXJPLfjNykohByr6SrHbWlqUP/V
         FPFwK8dRGaq+sMoBtspwe8tXqThhkni84g6Z1HVCe49iNhcZk9Tm3PB6MMSp/4BqbCuq
         aDlQdDhZunFD7h0JYc4m57v6YV0FkebXY8v7K9dd27bRe3f4lKzMy0Jzrh23BQVsef6T
         0gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AnZhuDCV2gPGk7yptczxHyXrPMAD4WH5esVjmlwoBAc=;
        b=o5wo5RjR40N4z864aOc4K9xYgmKmQPgbmfHBvH1z7qM3+AxuKBHjs3HQu3jThHETe7
         +drd/e5FtInK0mYfzUDLB0gHRybu1Htp3eCP7nDVVybscz4zNFHQz+m3a0nbDXuixu5b
         4eUPZF/OeDFjgjKU1mDR+JVRTWdim5uRJsU3jgGSDAj3fkf536/M1Y4nVYUQvYNyoB4w
         PTgkr8uApMhssNa6SyD58VwqaqvBm35cOZNBvNh/MNPqsEzz4EFIaJX5Kp2kWJj7hX6U
         R3Rk6V3joLgSw/bl5PRn5lBzSe0/GMwq+aJALb1gLgHHSI5K8Ja0XTSEO2dOeZw8OXtZ
         A+Ow==
X-Gm-Message-State: AOAM532uXuIbzNejrvpAhkqMbAYFVr0vaYoQ7sDFGwBXBbT8XDmJRR/1
        dRLEtqv0uzOTGWnJiK31Qhult8m5W8z7Dg==
X-Google-Smtp-Source: ABdhPJzBsbGs/cGVODuM6ifyNPsKrEsR4jwJgVNVTsFHE3XIeF5KSH6apxX2XjIGol/OyL0UjZG+MA==
X-Received: by 2002:a62:1409:0:b029:25a:4158:1c9 with SMTP id 9-20020a6214090000b029025a415801c9mr3127222pfu.61.1618593712062;
        Fri, 16 Apr 2021 10:21:52 -0700 (PDT)
Received: from localhost.localdomain (220-130-175-235.HINET-IP.hinet.net. [220.130.175.235])
        by smtp.gmail.com with ESMTPSA id ck5sm2962965pjb.1.2021.04.16.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:21:51 -0700 (PDT)
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
X-Google-Original-From: Chung-Chiang Cheng <cccheng@synology.com>
To:     christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jamorris@linux.microsoft.com,
        axboe@kernel.dk
Cc:     cccheng@synology.com
Subject: [PATCH] hfsplus: report create_date to kstat.btime
Date:   Sat, 17 Apr 2021 01:21:47 +0800
Message-Id: <20210416172147.8736-1-cccheng@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The create_date field of inode in hfsplus is corresponding to kstat.btime
and could be reported in statx.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/hfsplus/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 078c5c8a5156..aab3388a0fd7 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -278,6 +278,11 @@ int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 
+	if (request_mask & STATX_BTIME) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime = hfsp_mt2ut(hip->create_date);
+	}
+
 	if (inode->i_flags & S_APPEND)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (inode->i_flags & S_IMMUTABLE)
-- 
2.25.1

