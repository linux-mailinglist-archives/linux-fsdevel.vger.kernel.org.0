Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743B435A4EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhDIRtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhDIRtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:49:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05225C061761;
        Fri,  9 Apr 2021 10:49:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id 12so6443925wrz.7;
        Fri, 09 Apr 2021 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmhossM91o0deosjNdHtzDbsO2au6Ve08hKTaoPGrX4=;
        b=YQooyeLGEMkNlVisNZPXjsUhktiowyuG01NbtLEr0Y1P2U7QFSdbvRTjnCxmn/BGXi
         CDkjrY1y+YC7HcXIUDk/s5nipkQCrpibhFNALZmsBe8ezMRdsK6dM0Hz13VnraO4aicj
         +5a9h0H9d0z8czd2neBN5figqRntNNx9H+MYSXCVzTru4gIViWcgej/7mp0HcF2wv16Y
         uuvCnhm5GKj3pchqQY3OpFXd/yo7j0jaYh38t+ytY94V/4v1zWsTDLAO9LoLT6j8p0Cb
         luJVOFdj1fSDyFs2uyCY1Uy7MBz+7bVIm38J0EI/zcT4rojktoLdcgGz6hf69awdDJSu
         PPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmhossM91o0deosjNdHtzDbsO2au6Ve08hKTaoPGrX4=;
        b=AoBJHRhz6o9H+HmNxq8Rm7piMIkf1ux2aLZzbmfgwuoTZz+cjHI62EsypSMkoTVniK
         GpXKd2hRhMXwqEl3QEpg3EEP08AgJ47uVeV4V5kvHJ4247ExFYSKtKPqwqgBg/+UUINE
         wY8k5Xv2Hw3WjY0grIaUFiJiDShnzLan86LRkMRqRq8JT+7mMQ0t3qkAPfzI8wZ/MrPU
         2JfBLG8O8KB18tWQWTfO2qlEMH/lcBj1NDWxcz2WOVeYpdJ78sXwPpAACxd4VU86t7HZ
         cdpc7yUJCUhPF/ReXGvUHO7VJdxWffKJamK4STgCQtub6Ln7Bcte25u78cTH205oIhfL
         VY8w==
X-Gm-Message-State: AOAM533B83SjjVZgjMkozcxN882ynFlDODncykH4r5+FbcyFG1AZ0yrK
        IVZGp6T/KJSVQid8H1U2duI=
X-Google-Smtp-Source: ABdhPJy1pceaoMln6zJkD9oPosLisfEHfjiJCbsP8hBT77aYWz3jjegImt/RZE7pKzLYpEruzJBAtg==
X-Received: by 2002:adf:cf0f:: with SMTP id o15mr18467100wrj.91.1617990574787;
        Fri, 09 Apr 2021 10:49:34 -0700 (PDT)
Received: from centos83.localdomain (80-42-79-215.dynamic.dsl.as9105.com. [80.42.79.215])
        by smtp.gmail.com with ESMTPSA id y4sm5010278wmc.2.2021.04.09.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:49:34 -0700 (PDT)
From:   Andriy Tkachuk <andriy.tkachuk@gmail.com>
X-Google-Original-From: Andriy Tkachuk <andriy.tkachuk@seagate.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Andriy Tkachuk <andriy.tkachuk@seagate.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xattr: simplify logic at xattr_resolve_name()
Date:   Fri,  9 Apr 2021 18:48:36 +0100
Message-Id: <20210409174836.23694-1-andriy.tkachuk@seagate.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The negative case check logic with XOR operation between the
two variables with negated values is really hard to comprehend.
Change it to positive case check with == instead of XOR.

Signed-off-by: Andriy Tkachuk <andriy.tkachuk@seagate.com>
---
 fs/xattr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index b3444e06cd..531562535d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -66,13 +66,13 @@ xattr_resolve_name(struct inode *inode, const char **name)
 
 		n = strcmp_prefix(*name, xattr_prefix(handler));
 		if (n) {
-			if (!handler->prefix ^ !*n) {
-				if (*n)
-					continue;
-				return ERR_PTR(-EINVAL);
+			if (!handler->prefix == !*n) {
+				*name = n;
+				return handler;
 			}
-			*name = n;
-			return handler;
+			if (*n)
+				continue;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.27.0

