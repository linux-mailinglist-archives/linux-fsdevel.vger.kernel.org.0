Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939E62B00CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKLICb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 03:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKLICJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:02:09 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CBC0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 00:02:08 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so3514162pgh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 00:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+waUlGtlkBgYWb7wXp9DIAiajCHd+frNRohqWw+nsc=;
        b=micFsx3gaYn9qWYO35vPKHvVOSN9JaU5O4K8vZ2zd8v/uIbHy1aH0L+HoFWPbcss41
         Npv61Fv22oZzvOkg4mg14PZrrhCrSLunNF07UL7jhGSIrL1qgxvGIAJ3xQ/LzAcf+utn
         HT+/pfrf7DS+uC9DzfkLg0NJYOibf0sFVlM7Z/JjfkETcsHKTA9s8WB+/1T4gBdDWExD
         9ve+Czsa64lU+Jix22YQefE1Bnfozlb4r1x0c1aYA+HtkU80Q93gJfIEQeWcFj4bZhI8
         rU0Q5EnXJ961Aqi8M4pGnP1c629ANhd5olXRQrnxQneN0AIcZYXS2xVBtnV0Y9xzWqW6
         fYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+waUlGtlkBgYWb7wXp9DIAiajCHd+frNRohqWw+nsc=;
        b=IDBVVBfouIn4jI2am6z3ynvIhWeu+uK7mBmVmY2od4gf17d1o6kgkglw2+ouHIMmjX
         R6Gn0G2NAxyzevKgyuzZVFEmMB7Rd7/piJlhNBc29ygEmjtVbFyrnBXxVi+t49NJxtyT
         Pc/t4J8wgqVeoKrx62CwkOclUSRo1P9yqN+cpYgTg6SBETi3CEtLuGY+CJ8e03m+635v
         2UKDqMxWMMgCyy7qKZ3G3/scQHZAueeyuJmhtJtfJFllcTTUzB+LloIrBScM7U46MPLt
         wv22gfJdK8FsSkfPBdDDsjyK37r+HYkrgQ8aDNmoAGF8RsQl4J9e3tCBXVW8GePS/ukR
         Wqbg==
X-Gm-Message-State: AOAM530ShItstLj7eLf3XdtgCZZUA2tIC0zR0tkcw8WKOe0vJBRHOQPq
        sYmIud+GQbDoXJQ5DEQMxVg=
X-Google-Smtp-Source: ABdhPJwiNKBQvpl1OTw2k5oq8Hv8NrhoMZj7izp+r2mER1uzorFMs+LuXuXpTIalBkPcKOg1Ha5juw==
X-Received: by 2002:a05:6a00:212b:b029:18b:ad77:1a27 with SMTP id n11-20020a056a00212bb029018bad771a27mr25806979pfj.40.1605168128615;
        Thu, 12 Nov 2020 00:02:08 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id v3sm5170553pfn.215.2020.11.12.00.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 00:02:08 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     yuchao0@huawei.com, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, hyeongseok.kim@lge.com,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH] f2fs: fix double free of unicode map
Date:   Thu, 12 Nov 2020 17:02:01 +0900
Message-Id: <20201112080201.149359-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case of retrying fill_super with skip_recovery,
s_encoding for casefold would not be loaded again even though it's
already been freed because it's not NULL.
Set NULL after free to prevent double freeing when unmount.

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00eff2f51807..fef22e476c52 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3918,6 +3918,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 #ifdef CONFIG_UNICODE
 	utf8_unload(sb->s_encoding);
+	sb->s_encoding = NULL;
 #endif
 free_options:
 #ifdef CONFIG_QUOTA
-- 
2.27.0.83.g0313f36

