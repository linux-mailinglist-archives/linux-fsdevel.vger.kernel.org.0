Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279A43BC2BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGESib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 14:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhGESia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:38:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5CC061574
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jul 2021 11:35:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso548420wmj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jul 2021 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=i11aeIbYZIAXnmIV6Qy6K11j95TILIFNwLQ1SkwuXdE=;
        b=oehPW+i41sCkTm3lhw6YKRzMAD5vJfWof6uNlQAvObsiCn0V6x2h66HbmN9eonTpYJ
         tdSwE8ViQEzS2WQRImJ3bmEO+5AeuF2V4SSHhKOYvNLAyI6oPqERWY00GB99xCuKCV94
         a7UYdu8yB/bLSBf6cjUGU2i7H7l2AxBsB/VPeEfJ3UWfgz22fc8FgZVG4qTdAMoqqFVP
         uXoCDMkKTJ49THDmiLkt0DHvlClmtCPOBSgh/EHQR6OX/pos6yXeagnU7D5voeN9e0hn
         c2kSKUWrboOUd3HU5/TDAklHgH6LRRqVAK28wCHdkL/Friblxgt0zP45F5yTcqhUe11/
         hm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=i11aeIbYZIAXnmIV6Qy6K11j95TILIFNwLQ1SkwuXdE=;
        b=otxqgfAsxNn+7f/XoN0o2/OcL03yrCAU8eqja3K/esmwZYBscjDEMNDDyOCTkVq6OM
         LAi8TYkwK80FV4m5UpyEk7wWBtndwKl935Jbp13DIaG5L6jpc3zDo1AOBjhdsWrlRS6g
         z/Obw234e/bpW6qJu/e1tCXY7rf8te7i5aqk8a7jEI/U9JJ4IaNAnypC5mIDY30VffCi
         +zUGNe+HxEsKufUyw3uHKKYVpLZu6Za+wYHco+zLz1XJvnFILNt2bxPu1Tnh5+EAo2Qu
         W2hEy6dqyLFU9G7+6HSfEDyfA6DOhzQbLXnd2zGDNx66KP6Puq7xmDvlafqU2ht6Z898
         ZArg==
X-Gm-Message-State: AOAM533qB5Ngc68UpbiplbFxlXVF/OJTgNhlubxYsVCqLldStKErI3Vf
        rHRBhhJTpTJFekZPLcn5mms=
X-Google-Smtp-Source: ABdhPJws6OGNV7wUNJLAjVEbgsr0uK708PgUyRKI0cz5IAH5U7efGUeoWBhtAGGHAl8ONGy5xhE/jA==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr422350wmi.87.1625510151283;
        Mon, 05 Jul 2021 11:35:51 -0700 (PDT)
Received: from itaypc ([77.124.41.135])
        by smtp.gmail.com with ESMTPSA id p9sm13723699wrx.59.2021.07.05.11.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:35:50 -0700 (PDT)
Date:   Mon, 5 Jul 2021 21:35:34 +0300
From:   Itay Ie <ieitayie@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/binfmt_elf: disallow e_phnum that equals zero
Message-ID: <YONQ9myUvmVJtu76@itaypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The elf_ex.e_phnum field can be set to zero.

If elf_ex.e_phnum is set to zero, then a redundant kmalloc with the size
zero is called and a following kfree. Check if elf_ex.e_phnum equals zero,
and prevent the redundant kmalloc and kfree.

Signed-off-by: Itay Ie <ieitayie@gmail.com>
---
 fs/binfmt_elf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 187b3f2b9202..f25e8f241ae9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1348,7 +1348,8 @@ static int load_elf_library(struct file *file)

 	/* First of all, some simple consistency checks */
 	if (elf_ex.e_type != ET_EXEC || elf_ex.e_phnum > 2 ||
-	    !elf_check_arch(&elf_ex) || !file->f_op->mmap)
+	    elf_ex.e_phnum == 0 || !elf_check_arch(&elf_ex) ||
+	    !file->f_op->mmap)
 		goto out;
 	if (elf_check_fdpic(&elf_ex))
 		goto out;
@@ -1356,7 +1357,7 @@ static int load_elf_library(struct file *file)
 	/* Now read in all of the header information */

 	j = sizeof(struct elf_phdr) * elf_ex.e_phnum;
-	/* j < ELF_MIN_ALIGN because elf_ex.e_phnum <= 2 */
+	/* j < ELF_MIN_ALIGN because elf_ex.e_phnum is 1 or 2 */

 	error = -ENOMEM;
 	elf_phdata = kmalloc(j, GFP_KERNEL);
--
2.32.0
