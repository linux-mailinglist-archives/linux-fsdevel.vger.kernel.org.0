Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E843F575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 05:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJ2Dbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 23:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhJ2Dbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:31:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1DC061714
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 20:29:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r28so8622898pga.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt3GCe+54FqcZOH31G5bddZOmFvvBWRqXYZp4dfbBP4=;
        b=q88FJapufg3fkDigwnOkLElje1mOJaOMneaa+cUXfVv3z+dQxlVNwoUKzUWKvy2Rf0
         9EUV0vPPJSHw3FH4JXXyceGvnpp9hBu8puHYOMQQ2xoyq8EBIOfPn/rgRBLqjiJZ+DT+
         EgWhHMYyvHjxcGGRc80cYMhEOxw0oqFHlvO8ccn/0b6FLVveo7+JleqXOCGYloMZk/R0
         x1j6ay8vk82+VHZAejPhffP8jogUeCPE8Fs6D6WAWQ29YdQ738WTbzgHkhhU+3PMW0dT
         +qRmg7bbrMxnRayXPFtbQlPT15hoz9X7BfDK8MpvBNMAORXctA/W5k0bAUK5aYVE6pbG
         D55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt3GCe+54FqcZOH31G5bddZOmFvvBWRqXYZp4dfbBP4=;
        b=fvb6tswxxPkzzMpdpU6r+eGyoT5nXrpXzNRf7HwEL+XwbxfOYI/F8RKdTvQrVkB7Nq
         yS0GUdNPd+LAOFVpr612xRW/pRWJjzosczEotBgA4EkgZuLipo/YkfrQP1mNr2ciucAI
         EPeeQSI056wjbGENUyhRnKwgGyJnHChU/nOUZdrv4kyxle2HA6b13skWaig1rh/aZtuR
         tc+3A5reW3dnqyPSlOFPPP7uyoUQoB5digNE0Zqsqz2YUOLxj3wIiHze2AEfF7yTB6V+
         2utdlt1dnb6/tzw0fBbHIt3xOXgf72ZtlOrvy3AACnCdlYpR9DUxSJraoT9l0Z1S8XZi
         0Brw==
X-Gm-Message-State: AOAM5330yuLN0gx4pYJw/HqT6sJcse4p6oapPDkekhYA6yk1ZhPfo97r
        biBPzxec6lL1BDrPLSFsxU4RCQ==
X-Google-Smtp-Source: ABdhPJwf9ij8ao7F4qK1p5p4HPf/oV92hqNF2+2Coe0vzfTrDCnUq0sldGm3f725kiW8/KLIllp1UA==
X-Received: by 2002:a65:448a:: with SMTP id l10mr6160963pgq.313.1635478162580;
        Thu, 28 Oct 2021 20:29:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id w5sm5396319pfu.85.2021.10.28.20.29.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 20:29:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, revest@chromium.org, adobriyan@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] seq_file: fix passing wrong private data
Date:   Fri, 29 Oct 2021 11:26:38 +0800
Message-Id: <20211029032638.84884-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DEFINE_PROC_SHOW_ATTRIBUTE() is supposed to be used to define a series
of functions and variables to register proc file easily. And the users
can use proc_create_data() to pass their own private data and get it
via seq->private in the callback. Unfortunately, the proc file system
use PDE_DATA() to get private data instead of inode->i_private. So fix
it. Fortunately, there only one user of it which does not pass any
private data, so this bug does not break any in-tree codes.

Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/seq_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 103776e18555..72dbb44a4573 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {			\
 #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)				\
 static int __name ## _open(struct inode *inode, struct file *file)	\
 {									\
-	return single_open(file, __name ## _show, inode->i_private);	\
+	return single_open(file, __name ## _show, PDE_DATA(inode));	\
 }									\
 									\
 static const struct proc_ops __name ## _proc_ops = {			\
-- 
2.11.0

