Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B667B3E4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjI3FD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjI3FDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D881BC9;
        Fri, 29 Sep 2023 22:02:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5859d13f73dso1084836a12.1;
        Fri, 29 Sep 2023 22:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050131; x=1696654931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBbz7qEexK/f91LFPBrdRHvTcIeI5CzCcQ9osGtM8EE=;
        b=UMq4KiAenfMRZggFur+7oToekfK53rrUmKeNu0Ghnkzk07XzBH/KYXtiKuBEWPNA+6
         SjOMka6aI0mXxa9H/u7ZT5ccO+ijtLM7cXvJftVFXJTChfpsnOjKkdQr2lpI5nTRKa2v
         klfPbri/lScotVvZvz5jmKHKJ8V3/7yy5NBptU2GCKx1oZ1M5oAIxX7x3Hj79+4VreHP
         ENUpjQYP234CNQNBrH43OsoHK6EUmL24Ldho4wsqWmvvtbxKRSRVSYWMSQy04xeBbXgZ
         MAJ+3/Frgtrt6d1QMXJ2CScoH7Ozfpp4guc/5EFEltYMhDcYPfXiefYzHkhJcLJeJQKT
         FBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050131; x=1696654931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBbz7qEexK/f91LFPBrdRHvTcIeI5CzCcQ9osGtM8EE=;
        b=PFxBH0kWcd/Dy+ROjmJveKCdXfNL2RYPzWC5PssZviFEGyikLK+6vZ/V3KtAvz0g+9
         kv0xhZ4+Ar5+bfV2a2SOkfSxa/CQTANDvqc7MmuzcX1zAtEDV+r25DkqC92ct2biMB2u
         W7VbkhPy7GrIUZ8QhjT9B8bMBjYLWKT8c+SQ1fp7WiPg+uNr2WN092B0Lg6TrMJMNguM
         udVKx6g6B0mxcNS1ypJ1oES5qYLgYtN4otZgXC5OvW5PB2q8gid7m3yipPALOOCPCjEu
         q03cuER92ABsyeDYEp5ir/c61OM8Xn3esqTq5sUDuMay68MYsDxdFbcUmri0n8b940IX
         vIoA==
X-Gm-Message-State: AOJu0YzcUxmm02EJjFdws7vgQw2CDX6oZ9W1eC54c6VCWYg6BnJzl17w
        JbcPRV+3ehjkOPCofUOtDXWoUlkViJT7KA==
X-Google-Smtp-Source: AGHT+IF67kMPoPHLlDtSc9BQY+CBMONjrBbp5Igqw6BP0LBiD0MIb8dONb9/GI0Ztc0yUvu5eqfp/w==
X-Received: by 2002:a17:903:456:b0:1c3:1c74:5d0a with SMTP id iw22-20020a170903045600b001c31c745d0amr5368774plb.34.1696050131398;
        Fri, 29 Sep 2023 22:02:11 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:11 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 22/29] reiserfs: move reiserfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:26 -0300
Message-Id: <20230930050033.41174-23-wedsonaf@gmail.com>
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
reiserfs_xattr_handlers at runtime.

Cc: reiserfs-devel@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/reiserfs/reiserfs.h | 2 +-
 fs/reiserfs/xattr.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 55e85256aae8..c18d0bc01725 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -1165,7 +1165,7 @@ static inline int bmap_would_wrap(unsigned bmap_nr)
 	return bmap_nr > ((1LL << 16) - 1);
 }
 
-extern const struct xattr_handler *reiserfs_xattr_handlers[];
+extern const struct xattr_handler * const reiserfs_xattr_handlers[];
 
 /*
  * this says about version of key of all items (but stat data) the
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 651027967159..5a22a2bdaec7 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -910,7 +910,7 @@ static int create_privroot(struct dentry *dentry) { return 0; }
 #endif
 
 /* Actual operations that are exported to VFS-land */
-const struct xattr_handler *reiserfs_xattr_handlers[] = {
+const struct xattr_handler * const reiserfs_xattr_handlers[] = {
 #ifdef CONFIG_REISERFS_FS_XATTR
 	&reiserfs_xattr_user_handler,
 	&reiserfs_xattr_trusted_handler,
-- 
2.34.1

