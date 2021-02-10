Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AFB316A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBJPzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhBJPzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:55:07 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F71C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 07:54:27 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o21so1851309qtr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxE0y8wwvHdcyS4GSv6Atyz30ECFPty+ac1qjn7nH4M=;
        b=N6fP+envttGaR6PkGS485E3oQQ6UGBOaDx5L4dsVZ1fgmOWbF2uakPTV7vOAETwvPg
         URsIBRw5KvL/rsCcNCS1M1nKA/ZTHjtVDV3LaDFwk4kQs/YRriwHO9ubD67jFTREaBT/
         AgVIg6d0r5MCH1ntJBNpGwbWp6e35irk+R3uW6RKos5huV/NlYl3Ds4m2WsLhSCHW4wp
         3eyMVKFTIDF74YA4e36771qOeHtm3lZK/Wbm3E8if4cdv5MqHLmQ962swpebQwqnycOb
         QEihWA9RrrY6T9Gn0JDyNp03eBF4mcOyhRMWaTjw67OJkTqhlsDVtk/B1RnfrTBICi0F
         RogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxE0y8wwvHdcyS4GSv6Atyz30ECFPty+ac1qjn7nH4M=;
        b=ko0V5cflV8iWRnYO/tHZxURv1uxBxfmOhZBrd0WJoixlH6IxOD44kBjOrtn4Q/p1RV
         A+BO2MSlsb7LuK1krniCPPwXW/sEV/NyzkSUomGW0vmALHVpWht7R4c7EcdN18ulMFjT
         LtlA92jSjWd96nC/l9shYfe1XyazlvF4eTrA1qF0Il2J2qchbl/zzekLbtDmq01/SwIU
         4zYy24isIpI8rrxOkYvqrj3qRkgZjjMDw/S/GbadDvbsy/QgYutL5xC5F1PnrDmqOtrO
         n6E/aNH9lnUUQ/cDl9S4C7pECYqIc+BLN7mD+jRsQOx6cpaN/muyM6m+IkS8Iq5uSypy
         UNUA==
X-Gm-Message-State: AOAM532BzM46MPjKRdhqJspNr4w0T4fPCjtl2Gtq8IDp2xvfv0X6ivWr
        9Uvb1OP/yXzYDAZUEAG3Vsbbbw==
X-Google-Smtp-Source: ABdhPJwDtffe2C4aP4GlKtE1CFhg36F0tM3gZlILLftBRVKFsAronaQQswr1uVmbsfOksveX2ZHywg==
X-Received: by 2002:aed:3443:: with SMTP id w61mr990277qtd.89.1612972466533;
        Wed, 10 Feb 2021 07:54:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z20sm1625439qki.93.2021.02.10.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:54:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz, willy@infradead.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] proc: use vmalloc for our kernel buffer
Date:   Wed, 10 Feb 2021 10:54:24 -0500
Message-Id: <6345270a2c1160b89dd5e6715461f388176899d1.1612972413.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since

  sysctl: pass kernel pointers to ->proc_handler

we have been pre-allocating a buffer to copy the data from the proc
handlers into, and then copying that to userspace.  The problem is this
just blind kmalloc()'s the buffer size passed in from the read, which in
the case of our 'cat' binary was 64kib.  Order-4 allocations are not
awesome, and since we can potentially allocate up to our maximum order,
use vmalloc for these buffers.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/proc_sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d2018f70d1fa..070d2df8ab9c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -571,7 +571,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	error = -ENOMEM;
 	if (count >= KMALLOC_MAX_SIZE)
 		goto out;
-	kbuf = kzalloc(count + 1, GFP_KERNEL);
+	kbuf = kvzalloc(count + 1, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
 
@@ -600,7 +600,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 
 	error = count;
 out_free_buf:
-	kfree(kbuf);
+	kvfree(kbuf);
 out:
 	sysctl_head_finish(head);
 
-- 
2.26.2

