Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D879B41C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjIKUz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjIKLt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:49:57 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDACCEB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 04:49:53 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5733d11894dso954116eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694432992; x=1695037792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+g1AHGpy19FPO8Y8wh58i0Go6+oJttGgPur9KjzkMwA=;
        b=dSlyp+LSnl1b1KWq6E0mIZIZAKC3ifdgzqh/PGc0terE5dIn1TGNDn9vEq03jddrUt
         ZCf4kqAIJ6fqbGFreWoGZejnqgMU1du8ztyWqJQlNMFVhg5hr6/UJFsMQYgsiS7iXNm+
         FZLeLf8YyPJMuidSPOJEgWmz0X8p+27mT7OSNFuCi2z2NNfVjXI5odATtWEcbQ3HCZ4F
         MjN2bXYGPW/NgNGaw0KkFMEcYEBRrQEWu+boioM+SpYmzCGDajpXrnav40VZdxeFjh7U
         GYvd8pmU7wFoUryZM4UCWYVYdKqHwUsORFo1RyxW7J+TN1yXLi8whjJcp/z9NL5gXxTE
         4zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432992; x=1695037792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g1AHGpy19FPO8Y8wh58i0Go6+oJttGgPur9KjzkMwA=;
        b=Uu20jWzTm1D8GUocvlupcW/ljfmP2tIGLFB+mEU8isjgbjrpr9toEZKe+NHNZo+E4e
         BLEuiED6cYwkVNwE/LdBqPyrEBFSKMAOC/Zz5rQIQWLV0zWpmG1CF3u7vtMB/epHoS4u
         BB+mde2g+TjATgSy3haDMKZZTcR1hndZs/QAs+xPQJa3MHp8TgSQYJJKNO8iHDAxK2XR
         xxrL1EFR068l8EZZQOVFDTJ12HxQKSiE0hpWPrduP21azFO0ZrbrSMPrlU95WoZF1FMd
         Gn4V7/IH6QAHk+PM+Nt/GNIhWXW+BwBHWRtBwvWbuMC1cfkY7xtSrBkuKg3cT7/trkMl
         dh4A==
X-Gm-Message-State: AOJu0Yxnu+SzzfKK5JPUZtCvOPKqj9NjqwqU11RavzHiWLFGbJ/ZIYJD
        IASlFqf0B3uXbRMtqDXn5iB1jJo1xu0=
X-Google-Smtp-Source: AGHT+IEhZKA/fg+r0CqShHHUlTx2GQOJZdZDHp06c1GRSk6PQFHnW0udjBA5zvNyfg9UAQ1CIYbEew==
X-Received: by 2002:a4a:a70b:0:b0:573:764b:3b8d with SMTP id g11-20020a4aa70b000000b00573764b3b8dmr8311115oom.0.1694432992460;
        Mon, 11 Sep 2023 04:49:52 -0700 (PDT)
Received: from node202.. ([209.16.91.231])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a1d81000000b00569c240e398sm3147147oog.30.2023.09.11.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:49:51 -0700 (PDT)
From:   Reuben Hawkins <reubenhwk@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     amir73il@gmail.com, mszeredi@redhat.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH v2] vfs: fix readahead(2) on block devices
Date:   Mon, 11 Sep 2023 06:47:13 -0500
Message-Id: <20230911114713.25625-1-reubenhwk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Readahead was factored to call generic_fadvise.  That refactor added an
S_ISREG restriction which broke readahead on block devices.

This change removes the S_ISREG restriction to fix block device readahead.
The change also means that readahead will return -ESPIPE on FIFO files
instead of -EINVAL.

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 mm/readahead.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..ef3b23a41973 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -734,8 +734,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 * on this file, then we must return -EINVAL.
 	 */
 	ret = -EINVAL;
-	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	if (!f.file->f_mapping || !f.file->f_mapping->a_ops)
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.34.1

