Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1541324403D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHMVEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHMVEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6EBC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so5509338qtp.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xUKwSa9dEsOBbkoif2MHNtlKwaDfeFIwQ3yS7cCI+po=;
        b=SC9NQH21+yzXW/Ck0Uss2QSSYbwRPRieMYMOCOgOwC07+6AxSvuXtm44n/0z9bMusU
         AW2XEMxcM1VXqAEoE62rMIOhmYY97bUskB9MYXwvh45djOL5HMZpHoUFwu+QGAdwvLnz
         Ze79gjy3eN1UDPFjbndABOdXirSX3d06asTBK8AHQ4oN0nitXCwSwElIdErpoCf5q5sI
         RSb5Dp7qPRg5fvlIa5zG+Wvm9hZ0JmJupxmu6NEu8vGYIM4FBlfEZ8CDALvZw12DQ+FB
         djVkXb0bniei+dI0DMNATg3hvpO0zi0mpfFvIJD0z7ksbx8kNgrYE0bg0opdamsweCaC
         Pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUKwSa9dEsOBbkoif2MHNtlKwaDfeFIwQ3yS7cCI+po=;
        b=UpZUCswhNOcGvNJHReZu+X+2TaINhPAR4k6M8o9P9g2bPMXAuSp4gL/C0IDcgDGAoF
         1n4QxC3wVSNhT14hkkLKNGHMb8/H8Y+6seSezFV/G+FvTSE/wZOhsVpjCVyw9OBR+HVl
         AX92oMXMVxK0/gCbKCBk+1f66r2vkF6Si78SrslU8ceXV8CgVfKKjLj1PPBSkPQX4b+x
         2aS8pQJSTEJwIWeSCxNEtRRmb20NoKgfbAG0o4fkAwXSoEPSrjbivXb516E0aQRtFqwT
         k37LvRX9X2sDXTF1qDyHBI68QDrse4Ub+ofNnuKTQ9+tqAU+dwjgySOIBYUYQajTm962
         +8Tw==
X-Gm-Message-State: AOAM533WtPJsT86ugpV5SMaN5niFi6P1bxwkLpBZgOopEs/sSWqAe9t2
        oNtgyIgNKEGvCKwx90Hnuqtssw==
X-Google-Smtp-Source: ABdhPJzj5SOw34eSF78uCRhtj2OcPdzC6qoKdoWb+tHmcIpOCNxyUbJrFpEUpqE+bg3c2uy+xPQEGA==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr7393215qtp.53.1597352661965;
        Thu, 13 Aug 2020 14:04:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w12sm6240852qkj.116.2020.08.13.14.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 3/6] proc: allocate count + 1 for our read buffer
Date:   Thu, 13 Aug 2020 17:04:08 -0400
Message-Id: <20200813210411.905010-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al suggested that if we allocate enough space to add in the '\0'
character at the end of our strings, we could just use scnprintf() in
our ->proc_handler functions without having to be fancy about keeping
track of space.  There are a lot of these handlers, so the follow ups
will be separate, but start with allocating the extra byte to handle the
null termination of strings.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/proc/proc_sysctl.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8e19bad83b45..446e7a949025 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -548,6 +548,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	void *kbuf;
 	ssize_t error;
+	size_t orig_count = count;
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -577,9 +578,23 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 			goto out;
 		}
 	} else {
-		kbuf = kvzalloc(count, GFP_KERNEL);
+		/*
+		 * To make our lives easier in ->proc_handler, we allocate an
+		 * extra byte to allow us to use scnprintf() for handling the
+		 * buffer output.  This works properly because scnprintf() will
+		 * only return the number of bytes that it was able to write
+		 * out, _NOT_ including the NULL byte.  This means the handler's
+		 * will only ever return a maximum of count as what they've
+		 * copied.
+		 *
+		 * HOWEVER, we do not assume that ->proc_handlers are without
+		 * bugs, so further down we'll do an extra check to make sure
+		 * that count isn't larger than the orig_count.
+		 */
+		kbuf = kvzalloc(count + 1, GFP_KERNEL);
 		if (!kbuf)
 			goto out;
+		count += 1;
 	}
 
 	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, &kbuf, &count,
@@ -593,6 +608,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out_free_buf;
 
 	if (!write) {
+		/*
+		 * This shouldn't happen, but those are the last words before
+		 * somebody adds a security vulnerability, so just make sure
+		 * that count isn't larger than orig_count.
+		 */
+		if (count > orig_count)
+			count = orig_count;
 		error = -EFAULT;
 		if (copy_to_user(ubuf, kbuf, count))
 			goto out_free_buf;
-- 
2.24.1

