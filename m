Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260FE4970DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 11:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiAWKIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 05:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiAWKIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 05:08:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC803C06173B;
        Sun, 23 Jan 2022 02:08:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q63so8721968pja.1;
        Sun, 23 Jan 2022 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=njkyrdC1wcthwNNsN5Xhys28AeoO+Ti6ASQok8RODU0=;
        b=AXiFgOgPZGK6n7UVABKe265/hzX0VvPqpiKG1lmVJwIGjnev5OxEzsptOeeC5Bl+89
         +GRarcZPhIGkUkaYJovTgKuf3F55ALD1FuZJTCNubuoRuPcYljhrMUyCl4eHEbUU8f8V
         F2PPO5YZlAEwYk7bPRAX4VjJ9kTtq++Ew+T5eLRImZUVtxPboqY35DXoYSA7JZgmOtZ6
         cbXAZVn6qOVjcu+g+0DkirypEqGeCvBzT7FQN5J7D0qLrf7n/2EFbOq9oswk07fKfFsn
         1FLToGZ6T5P+xmY6ldftFTD3srbetkijB9vHA8WD8BsPnYHGVWf4mr47FyJgSXbR5uGB
         loIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=njkyrdC1wcthwNNsN5Xhys28AeoO+Ti6ASQok8RODU0=;
        b=OntQXX7nByHMYXiGSYseKGdYU8Sm9wBuRJvIS5h0bahbHaxD7OH72C8X2zlYEJ5fpz
         gWKOIdfMEdj9hFVYRr/ePu9Nom2wCiSpjnY2DT3aS18BF4/Zexmt+Vd5BbVL3s67blCk
         4M24pcxaucpV657UhnBKEX5PWtsnPoazewKUSLP9j4qx7GLKNG+revPF2A1PveKy1905
         hAb2/wlCmWr4rVV5aRcA0d1S9E9QTBLbt+94vjvMZMSgag28X0bh0JJobTrO4hJLVR3u
         QxoM0abwwYCGETbymXhc971ZJLifpi92g2ACJtUYraHjPpFPaE3b2etShUkKurd14Pv8
         yd1A==
X-Gm-Message-State: AOAM53344cZRO4lw+Y8Y4KKd6PsWHvIAyJisybKTAgvx5vcm1QOHgesc
        NXtD5EaIYvkYWHem2AMecMU=
X-Google-Smtp-Source: ABdhPJyaSqGygn/I5ajDjCayssZ3m8BO9RZa4XGpmoh79ncwqXg6Wa09TOb/xUALc5w6Y7Vxm9c8jA==
X-Received: by 2002:a17:902:f54b:b0:14b:2aa6:d2b with SMTP id h11-20020a170902f54b00b0014b2aa60d2bmr6972916plf.152.1642932519504;
        Sun, 23 Jan 2022 02:08:39 -0800 (PST)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id s9sm3617138pgm.76.2022.01.23.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 02:08:39 -0800 (PST)
Date:   Sun, 23 Jan 2022 10:08:37 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     christian.brauner@ubuntu.com, keescook@chromium.org,
        adobriyan@gmail.com, jamorris@linux.microsoft.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        haolee.swjtu@gmail.com
Subject: [PATCH] proc: use kmalloc instead of __get_free_page() to alloc path
 buffer
Message-ID: <20220123100837.GA1491@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's not a standard approach that use __get_free_page() to alloc path
buffer directly. We'd better use kmalloc and PATH_MAX.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 fs/proc/base.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..74cfef87fe45 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1764,25 +1764,26 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 
 static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
 {
-	char *tmp = (char *)__get_free_page(GFP_KERNEL);
+	char *buf = NULL;
 	char *pathname;
 	int len;
 
-	if (!tmp)
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	pathname = d_path(path, tmp, PAGE_SIZE);
+	pathname = d_path(path, buf, PATH_MAX);
 	len = PTR_ERR(pathname);
 	if (IS_ERR(pathname))
 		goto out;
-	len = tmp + PAGE_SIZE - 1 - pathname;
+	len = buf + PATH_MAX - 1 - pathname;
 
 	if (len > buflen)
 		len = buflen;
 	if (copy_to_user(buffer, pathname, len))
 		len = -EFAULT;
  out:
-	free_page((unsigned long)tmp);
+	kfree(buf);
 	return len;
 }
 
-- 
2.34.1

