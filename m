Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF67B3E26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjI3FBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjI3FBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802310E5;
        Fri, 29 Sep 2023 22:01:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1ff5b741cso134162965ad.2;
        Fri, 29 Sep 2023 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050081; x=1696654881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc7EZI0QTgBVujG8JfkUP0DGPINpthmbr1tCtQXff5c=;
        b=ag/RLoUDLaiw5u/Lqe1u/h247avxIsqNkzwSKhP1E6bmFzaiYP9QNEIrgAwzxCsrzE
         NlZP1rwmrvPhd9GAPKCeaJvJMKErBy9IAWfOHpsj60o0U2rtO+aN3JVZIKoJdr+Xch53
         ds9iYTO5q+ab2vwqoHDIbI2XkPWgUosu58q8w7AP8JA5PZqpz7C07O2nQwkcNTufEcEi
         nfRLYIX2BCqsAzOM2IvrHWzsXRfxAgQ9e3q96rZaAdkuKDYbvfuWk3jK6/wnr5nuY4J7
         iNE/ab0mJ30/9jVIL/zkfIse5BjobJ0lM5e0abpAiSLskZYbZUYmu845vPRenxcHkT5f
         OFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050081; x=1696654881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc7EZI0QTgBVujG8JfkUP0DGPINpthmbr1tCtQXff5c=;
        b=ipu6kMqemGxiiuEPv5JI4BjcGACxdGy+iL0q++UzJoGzcrCcTue8NF5nBGdsmqGuwj
         cDWnWIgjLxfmmXPkcB0ETfawKnFnbyWHvcT/C3c39cyhvWFc2tmPDaB/06WoZqJgq4oM
         LYQ0Jg+2UpaxDRqKIXYdS8FvefMJnCsQ9HeHPuNoQFtB+7104d7zwUnq491Rv7aH+g4/
         mu9dqv0fFK6Wwn6phosTFWWyCk9Z6dG2/iIT+nq/lk8IhJZmb23aXrWGw6qasm1Dvezb
         baTZ24W7E4lnIoinLdC5HCUocKiIcB2PrbRlV4BQLsQCkKhH82TfKu11jJ6JTKQ5G2PC
         F8kA==
X-Gm-Message-State: AOJu0YwXe4Pc+I3lX6B/cs9PqanogiUfT0drsApSLnEMIbWSfSNOZebk
        b4k1zzpvI2f7iAT5sDixk2+6SiuE/mRK6w==
X-Google-Smtp-Source: AGHT+IH3BKoWw/bIi/uoK/YSuI/cQIkI1vHksczWhfPejPGJq1Fi36aq+SAS76YP6K6KBymEbiRJow==
X-Received: by 2002:a17:903:1247:b0:1c4:3cd5:4298 with SMTP id u7-20020a170903124700b001c43cd54298mr7127633plh.18.1696050081179;
        Fri, 29 Sep 2023 22:01:21 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:20 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Subject: [PATCH 07/29] ecryptfs: move ecryptfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:11 -0300
Message-Id: <20230930050033.41174-8-wedsonaf@gmail.com>
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
ecryptfs_xattr_handlers at runtime.

Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/inode.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index f2ed0c0266cb..c586c5db18b5 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -702,6 +702,6 @@ int ecryptfs_set_f_namelen(long *namelen, long lower_namelen,
 int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
 		       loff_t offset);
 
-extern const struct xattr_handler *ecryptfs_xattr_handlers[];
+extern const struct xattr_handler * const ecryptfs_xattr_handlers[];
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 83274915ba6d..18fcec208d9d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1209,7 +1209,7 @@ static const struct xattr_handler ecryptfs_xattr_handler = {
 	.set = ecryptfs_xattr_set,
 };
 
-const struct xattr_handler *ecryptfs_xattr_handlers[] = {
+const struct xattr_handler * const ecryptfs_xattr_handlers[] = {
 	&ecryptfs_xattr_handler,
 	NULL
 };
-- 
2.34.1

