Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1842B01D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 10:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLJPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 04:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKLJPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:15:19 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3AAC0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 01:15:18 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e21so3638222pgr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgmYy2oo4yKBBbCgZapoTN1Dk2safVBvCvsBcacBH84=;
        b=nOHltpbuC1nXtvVXy/kE63t7xaR73y8DD+/umP4rn+YqoshfbjOPLRh2mfDXiQp8n1
         tpINs1tuWXdoao8PKk88VSkWeTSFPIyTPHEnJj4KV0NYZEpuHZICiKsv9on4GwvQ99CN
         bQF3/SO1rL+1MXjjonLXSNr/fU6pdfrWIYjcgImLjWkvyMIXM930cvgUaqAGlIGzUjQI
         yxhdwebbODkd69u1PZ7/OySD1P/c6/QBRqaYzblvIt1FJwTPYdpI6ARQDAYNRdhJVF2Q
         XByhuB5lvih7TWLCVDOSNwEb1VMYSYnj4EiWFukBCan/SaHYEUnCJLPSI6iLmy1uh6+y
         pGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgmYy2oo4yKBBbCgZapoTN1Dk2safVBvCvsBcacBH84=;
        b=cUP5H1VihltpFNWA/1Ynd23Rmp04JnG3ShTQmZV6PrteTV36eeUA9xg9yQiCQtxs4k
         MHZpFqlABMTD4JnubjA6Agyr7Wnx+2Vv3eaTra4aIIEL6h7DQeR4kre3ljGrmk00B3oj
         9pUK3e4EBrBjLmcg8mljISWKgEdDuiZ3ScmTN/VjxjvrhNP2zGwUUqfl65VBYTuhyBXZ
         mQaPiIgNSTt5NywTa8iOlyn4Qpfn5aR5VT8lmvbnz8MiJTK7v0oSBEbuomVrCKCRwpqP
         8OByYOzK1CW+zyqE7P8EKoso8Ldmfy8RVWjz0DPfWMyzVKp58g0znoC/uxduD9mY3G5L
         lvpQ==
X-Gm-Message-State: AOAM5332UbVj1bEUzIUNjrauA3nSZRCcj68izL/Gqf+6o55VtY8y6dLk
        hPHMhBUro9oWzUsY4AG2LSM=
X-Google-Smtp-Source: ABdhPJzhtkhhaTTCEKurgpkKcIW4YvAekQe9Uoe4fC4twzYsrMKS/mBSUexuxFvtjpTrLNhJtLhitQ==
X-Received: by 2002:a17:90a:ea16:: with SMTP id w22mr8469271pjy.64.1605172518561;
        Thu, 12 Nov 2020 01:15:18 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id y3sm4852816pgq.40.2020.11.12.01.15.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 01:15:18 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     yuchao0@huawei.com, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, hyeongseok.kim@lge.com,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2] f2fs: fix double free of unicode map
Date:   Thu, 12 Nov 2020 18:14:54 +0900
Message-Id: <20201112091454.15311-1-hyeongseok@gmail.com>
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

Fixes: eca4873ee1b6 ("f2fs: Use generic casefolding support")
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

