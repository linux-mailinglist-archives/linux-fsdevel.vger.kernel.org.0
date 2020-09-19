Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2973D270959
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 02:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgISAKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISAKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:10:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5EC0613CE;
        Fri, 18 Sep 2020 17:10:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so6454741ljk.0;
        Fri, 18 Sep 2020 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dESGYbnfg7wQ4Z2+mdwlRJpxrBgQFzID5ccxYF3X5U0=;
        b=RBva7VcRX7O/kEvKZNDT0CqRALPY8292/hmUqYscH0QmEeo1gQEcDL0zF+AbqAXGGR
         Y2d++cg0mVY2SOyOZfJ8t2LZQZRz1YlDe79xqcCf0Gh+6rhqqsIj8eHM8XJAP8fN+CRT
         xq4FEaG1qVkgvcKXKRkoVEvqLTocw4Q1zxkEnP98UNWJODPkpShSbLVsFRjKzOJTVNdA
         oabZcP29m8FtqJBuA1xHeVil5/9Z+XAGFIb7TcQtjhnUFiv78f6SWtkVDqw4bNzuqlK0
         uineKtoRhaVEYmocI08pmESxMC5ikiTwfjreg5HynFJSykF4IL8b3P2eIufUS6HnvFwI
         BPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dESGYbnfg7wQ4Z2+mdwlRJpxrBgQFzID5ccxYF3X5U0=;
        b=C7D9PD834wJ677APgiTYGlA41L7H+FpZH5jO9XGFEdRGQI7stv/sjuz2kV7XONjfSh
         GtD9TjucKRSt+Ip3tx4BYv1A07O2TbMOCSxy/tj29BDMtALMNvyoOpNhW3pJrTEBt0Sx
         ImXmNYjhKU307N5cGZgmdNrDOCYKcx5JfOchhLOsKvs0AR5Dh508qVdF6w9Nn9OWQdiL
         yysCD+3CsndYHV2pqIu4vmgzjxv+bf5qQPk0PK/FuGyqNW2RgJ26J/E9W2PtZmpuQZ1v
         JOph6Q5hU2olwx5l+p7em4HwJIJiJt/Kz0puKBZO9KhN90jpSaWKAgKVllo6ZCS2lGMw
         JgmQ==
X-Gm-Message-State: AOAM532IQzLr1yUZOa2gpKi1j6F79QaHwXUdW3Qqg9OYYdoUpIjGnCv6
        YAqswfniKT7lvj1JkuYhQj2Qzy/ck3o=
X-Google-Smtp-Source: ABdhPJwU/xG13KtB/wenP6ov2aCDN9xIdgYiffJ0dh7QiB9V4mFL1Mg9WtyrLUlUetxhNBHXgjqz3g==
X-Received: by 2002:a2e:6d01:: with SMTP id i1mr13116898ljc.181.1600474249240;
        Fri, 18 Sep 2020 17:10:49 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id j127sm915054lfd.6.2020.09.18.17.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:10:48 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, viro@zeniv.linux.org.uk
Subject: [PATCH] fs/open.c: micro-optimization by avoiding branch on common path
Date:   Sat, 19 Sep 2020 02:10:21 +0200
Message-Id: <20200919001021.21690-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

If file is a directory it is surely not regular. Therefore, if 'S_ISREG'
check returns false one can be sure that vfs_truncate must returns with
error. Introduced patch refactors code to avoid one branch in 'likely'
control flow path. Moreover, it marks the proper check with 'unlikely'
macro to improve both branch prediction and readability. Changes were
tested with gcc 8.3.0 on x86 architecture and it is confirmed that
slightly better assembly is generated.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 fs/open.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..69658ea27530 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -74,10 +74,12 @@ long vfs_truncate(const struct path *path, loff_t length)
 	inode = path->dentry->d_inode;
 
 	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
-	if (S_ISDIR(inode->i_mode))
-		return -EISDIR;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
+	if (unlikely(!S_ISREG(inode->i_mode))) {
+		if (S_ISDIR(inode->i_mode))
+			return -EISDIR;
+		else
+			return -EINVAL;
+	}
 
 	error = mnt_want_write(path->mnt);
 	if (error)
-- 
2.20.1

