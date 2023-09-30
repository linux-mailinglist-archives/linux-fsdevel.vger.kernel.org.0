Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D307B3E5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjI3FEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjI3FD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3622FCC5;
        Fri, 29 Sep 2023 22:02:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c60f1a2652so10356825ad.0;
        Fri, 29 Sep 2023 22:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050158; x=1696654958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyxiBtLOD6vKA93NS3NnjiNRx4OZIF1tJqScqvYHIAA=;
        b=VBSP56FsvsX2sAOKAc6rmt7Qy/p4D5Wl28D/GnHG+/RBJvMHK2GLTOMWAe2sbSCb5y
         BDXmHlod7VCIlROoprvmj7/YsDPXlAcfp0CoipqLJKHLgK66xsLhbbD8/eJc3Y9R9w95
         WQ9a5y6Q42b6DWiwbPslqHiTEcvnHCHjOcVIotM26cs5RhQDncVJjPKNfn7iaBU6p5TH
         9N9VaAheViF9RGEwVj1LmTqLgl7KHJtsDTAEVhmNqD9vqjtAyxebjvm3otWWx3yBcOwz
         ek8VBiD4xTr881N5M3ojNj+Jgq2MuD7+7HOVWZ6vgcbYcYtMuzVjFe7iI3xVza3fNDhd
         L8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050158; x=1696654958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyxiBtLOD6vKA93NS3NnjiNRx4OZIF1tJqScqvYHIAA=;
        b=s2laeMImirhJk319JbNgiWVBY4nXkXblqRhLYosrWqNFSaH5Mn7WBhNGC9Ql+7Xp+J
         rNBqcq7O2OwQyO5r2DCArsd3ERh+MBBT1ZWhsJOZFdO5UPJkaJGngd0eJheyKE5sI+yq
         AKdRfqEZpgnarmOXGtFHeCXB9SoG79TQJ3fO535QY0DbDEPIR8PrgCI9T+XOHOcuQbNe
         2w/HUpEkCWDWUTl4fIqPL6jH20eUAKkXCyngSjn9Ufdsh2CUuMi3+kvLgh/ix0zTovk1
         ddqDIKaQFNpGcNLY+qZkwAAyIYCW4AdixGPkfBUz/Ch8kAoEElqw3Qe2GU0Q08nwV+Kc
         5MPQ==
X-Gm-Message-State: AOJu0Yyi7tVWZAwGx6ZrTnqzu5/qya7I1huvtCds9VYqOdSDThiW6zYq
        9jvpsfNzkJY4zkcKeqyun+g=
X-Google-Smtp-Source: AGHT+IHeeeLjNU8syfWCBKCNd97N2hKxjyhO5OwBkFhe27PcOwAEtpXWD5JUYEpvqR1hQq8unpsqKQ==
X-Received: by 2002:a17:902:e741:b0:1c4:1cd3:8068 with SMTP id p1-20020a170902e74100b001c41cd38068mr9737235plf.5.1696050158560;
        Fri, 29 Sep 2023 22:02:38 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:38 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org
Subject: [PATCH 29/29] net: move sockfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:33 -0300
Message-Id: <20230930050033.41174-30-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
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

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
sockfs_xattr_handlers at runtime.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 include/linux/pseudo_fs.h | 2 +-
 net/socket.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
index eceda1d1407a..730f77381d55 100644
--- a/include/linux/pseudo_fs.h
+++ b/include/linux/pseudo_fs.h
@@ -5,7 +5,7 @@
 
 struct pseudo_fs_context {
 	const struct super_operations *ops;
-	const struct xattr_handler **xattr;
+	const struct xattr_handler * const *xattr;
 	const struct dentry_operations *dops;
 	unsigned long magic;
 };
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..0a99fc22641e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -400,7 +400,7 @@ static const struct xattr_handler sockfs_security_xattr_handler = {
 	.set = sockfs_security_xattr_set,
 };
 
-static const struct xattr_handler *sockfs_xattr_handlers[] = {
+static const struct xattr_handler * const sockfs_xattr_handlers[] = {
 	&sockfs_xattr_handler,
 	&sockfs_security_xattr_handler,
 	NULL
-- 
2.34.1

