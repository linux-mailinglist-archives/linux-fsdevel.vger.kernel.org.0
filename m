Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84F21A646D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDMJEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728115AbgDMJEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:04:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB210C0A3BDC
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 01:57:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g32so4196008pgb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WjND0ct9WXfnmUwrPTBzmeuopYzO4yH6lk3AAONsNw=;
        b=WEk/2JRpJ4RFJsvyAWO9EICaAyMaTsqpoYex5Fe9WikBDqfQsj3Ujrar0RXoKWweXF
         t9PESt9EfmZuQCBz8auC08Oh0YKGi2DPtN+yK+yRCRaOiDCH19VPpxmPMrTDD98uhRmw
         OrlOVgQhX22mG3fbDBoG835NgT3zWT1tSVCNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WjND0ct9WXfnmUwrPTBzmeuopYzO4yH6lk3AAONsNw=;
        b=h9iQyHsFxSOf2T+qoYRP1t7BIJTbxzXZPIorwSc0wA7giuRtG/yBotU7PDz4Mqx91m
         OTkp71ROCczmlwg4MWDWJZTwfhI8etApEYAI4WEMit4ELXybk2TKQfPH0cGMJpi1xmq7
         58mUj/l9ZNZbgHFxXZZSdMWnfJg6/ISDfl11XUezUxlCr81VD6lKs2bg7pKJQOeIJKG0
         abnfKdSUfpZw3j8hbrTlVBU2C71uXoaVyKD1k4/HM83St2jFy2Nss9PL7JARcuTI45tF
         zzaPIXit0wH6q4lI1FF32JtfGhg25+BPN5Od7CW/aDseloNp+YEKYEy2pVTLxbx/GWMM
         IS3A==
X-Gm-Message-State: AGi0PuZb+blc3nXCk3QblQWhfnuyiRWf4iG0pu8Tv+YS7M48OrDtbdIN
        nderJaSr14Q4TAC/48kBailqeg==
X-Google-Smtp-Source: APiQypIRHXKeVfsDa4U96lR30IMY0mcfMZCpcMgXv7bKpkfMzxj9H3vfBpjfyAT69mkBbx/v+2GVhw==
X-Received: by 2002:a62:2783:: with SMTP id n125mr17816801pfn.133.1586768266373;
        Mon, 13 Apr 2020 01:57:46 -0700 (PDT)
Received: from localhost ([124.19.8.131])
        by smtp.gmail.com with ESMTPSA id a2sm315136pgk.90.2020.04.13.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 01:57:45 -0700 (PDT)
From:   daurnimator <quae@daurnimator.com>
Cc:     quae@daurnimator.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: only pass valid chmod mode_t bits to security_path_chmod
Date:   Mon, 13 Apr 2020 18:56:45 +1000
Message-Id: <20200413085645.135829-1-quae@daurnimator.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

chmod only pays attention to some of the flags in umode_t, don't pass
on irrelevant flags to security_path_chmod.

Signed-off-by: daurnimator <quae@daurnimator.com>
---
 fs/open.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index b69d6eed67e6..a2d8bee88a3c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -551,12 +551,13 @@ static int chmod_common(const struct path *path, umode_t mode)
 	error = mnt_want_write(path->mnt);
 	if (error)
 		return error;
+	mode &= S_IALLUGO;
 retry_deleg:
 	inode_lock(inode);
 	error = security_path_chmod(path, mode);
 	if (error)
 		goto out_unlock;
-	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
+	newattrs.ia_mode = mode | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
 	error = notify_change(path->dentry, &newattrs, &delegated_inode);
 out_unlock:
-- 
2.26.0

