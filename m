Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01D53B73AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhF2OCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbhF2OCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:02:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF5C061767
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 19so20802099qky.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xk61Zn1WGvZe9oDMxIvYakdXIuBAH34lTAxcJ/5AdLQ=;
        b=zN+HvvGCbZuQeiqfZwR5zvwx0m2wCKVBtylRJtgYyTzsq/t5jdG07i45CYmpoRwiwc
         tH/BotJ5WG8j2zKGM/FUDGc+HTr6r/jJpve47H4701qHdRMBr76b6+OxYJ3pGaEPIpgL
         TjmbwIf3FwQWlWmp4zJuEP02iz9zzlTCuyKXSjVBjti2VIlaESoJbexlo9eBUajlwu18
         tfJKW+6MZy+SrFcu7ZZFWlbfXrWIO6k3g0hQ1t0Vg3tHH207Scjxlw8/leroAtdjVL2i
         yns24TPBSDfiF8NlZcQ4G5/JeW52meU7S0u7z1dwA9MJ1JvkxwoAueaZGfx5J7wevdr6
         X0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xk61Zn1WGvZe9oDMxIvYakdXIuBAH34lTAxcJ/5AdLQ=;
        b=VKi0GEUU+rneb0VBtpuhIc9IHSDMDxbmy0CDXu7zzTExB6u3lgJhhj5NdvGk786g/r
         d/dW8izVH1inB1sdcQxfgr1JbqWY9Knpr3exjg9dRJkWKGb7aOVL5rQ84OAccGxUEDva
         25fbXXNWKCV2c2TpELCEL/pIeISUjQY6j4HKB3chDljGm5Bq55zXuzdL3KI/AGpEQI92
         7NwWg+A4qDdBcTiZaTeoORdLmeO7QqSC5rZUEX/RxBW5Zdk3hT+tQtn7Sw0EbKQwHues
         bzVq0V/eN3HpXgs1QdbWvPcDHjtDLXgF1uZZfw9zjKYQDLVlt4477cojydohQ+1kWhUk
         1mXg==
X-Gm-Message-State: AOAM530aNWSAZl7LUzWPYnBZR+bdEfanYJkkXytECZcEdjpmVHJSrsj4
        p67LhfDrSrR6iSEbSgHTk6DGaQ==
X-Google-Smtp-Source: ABdhPJzZjRFEthCixKwWy1jjV52zQ7wkSwJcfUKTrSniM0DJ5znFTUdh9aKKMDnq723lmOZAm1UuYw==
X-Received: by 2002:a37:438e:: with SMTP id q136mr31108026qka.382.1624975177325;
        Tue, 29 Jun 2021 06:59:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v15sm10361335qkp.96.2021.06.29.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/8] 9p: migrate from sync_inode to filemap_fdatawrite_wbc
Date:   Tue, 29 Jun 2021 09:59:23 -0400
Message-Id: <16ad65c145645b0ade200b45ecbf1b14f3e8c1c0.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We're going to remove sync_inode, so migrate to filemap_fdatawrite_wbc
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/9p/vfs_file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 59c32c9b799f..6b64e8391f30 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -625,12 +625,7 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
 
 	inode = file_inode(vma->vm_file);
-
-	if (!mapping_can_writeback(inode->i_mapping))
-		wbc.nr_to_write = 0;
-
-	might_sleep();
-	sync_inode(inode, &wbc);
+	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
 }
 
 
-- 
2.26.3

