Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50579332264
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCIJzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 04:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhCIJzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:55:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58965C06174A;
        Tue,  9 Mar 2021 01:55:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 30so1741672ple.4;
        Tue, 09 Mar 2021 01:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dcifETfuNPReFgb8Ok5BcjVr8wRAhz76Wrsbeu/hSRU=;
        b=r6mjmDhgsYutkVK9gep+Ni9MaZYUjqXdeYFpe2yPu1E20MoZJZv13HH4UDxnQw6/0H
         YqT52J+Zx/hYe75pIrhMo0KWFkXfkifxa0sVtA6zScYMLi//iy4gtfTdrzJ+yU8LrEJL
         RTQtlcuN49KBFBHoZWcMqHuaFrkUoHoAtCgfHSvqk8qhKxvlSFzvpPv5GJywD4UV+HKH
         C4llfek1C3GaKl0GiRi169XAielsxNX8emE39vMJc3yqvvmLFboBqheqqaYcKYWr1vwx
         NAQIRnaBhVrsDHevZWeRNKb92Y1qcBGjeuLG3Jwkwbs4VSqwzKtNnZOYmSoT5m6XvyIn
         nC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dcifETfuNPReFgb8Ok5BcjVr8wRAhz76Wrsbeu/hSRU=;
        b=hS+hAiJYUZZjss1CqOAH50NtnK8XOQ/WRYRJSxyA+Mvrbcn5rUGIUoyvqUZjPBcN2m
         tkl7xjbXBrxAenCl3QsyFRbZ/t+m613WCVH8gvgfw0I4aqglGnDogpHFQ2gDjGLl/VeU
         vebs/xXY5z9x9iKcGCt79A2pCvVLI67tfVvmE36wIIOGHromYzomXr0PvWC4eS2TJlAs
         yTMmj/LOjUtqWRLU1Q6WyjvsGfOHbVCfH5a2quf8HqwChQv8EtAt/vgbYYobj0wdUt8o
         1WCPntlu7B3WeZUGHF53Jq2oKAjO0ixvICbIoaRlnBHf+zJnCeD34zG1nFn83Qzhj9c7
         Calw==
X-Gm-Message-State: AOAM533WBX03N7QW5cSYqhRBHcicz/a24m6EsLxxr1CLjM6gfxSLL0Rl
        MzICumVzVNIwK5o4He4g9xA=
X-Google-Smtp-Source: ABdhPJzlwK85lHApwtV53mphgw+InkFQCC3O5OM9KfJ6VS86ZfEal0JKlTn7BMzT2p11TrmJt/qxkA==
X-Received: by 2002:a17:902:369:b029:e4:b5f1:cfb4 with SMTP id 96-20020a1709020369b02900e4b5f1cfb4mr24746468pld.60.1615283743864;
        Tue, 09 Mar 2021 01:55:43 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.97])
        by smtp.gmail.com with ESMTPSA id v16sm12327585pfu.76.2021.03.09.01.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:55:43 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     adobriyan@gmail.com, christian@brauner.io, ebiederm@xmission.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        gladkov.alexey@gmail.com, walken@google.com,
        bernd.edlinger@hotmail.de, avagin@gmail.com, deller@gmx.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: proc: fix error return code of proc_map_files_readdir()
Date:   Tue,  9 Mar 2021 01:55:27 -0800
Message-Id: <20210309095527.27969-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When get_task_mm() returns NULL to mm, no error return code of
proc_map_files_readdir() is assigned.
To fix this bug, ret is assigned with -ENOENT in this case.

Fixes: f0c3b5093add ("[readdir] convert procfs")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/proc/base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3851bfcdba56..254cc6ac65fb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2332,8 +2332,10 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		goto out_put_task;
 
 	mm = get_task_mm(task);
-	if (!mm)
+	if (!mm) {
+		ret = -ENOENT;
 		goto out_put_task;
+	}
 
 	ret = mmap_read_lock_killable(mm);
 	if (ret) {
-- 
2.17.1

