Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60C3FAA95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhH2J5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhH2J5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE8C061756;
        Sun, 29 Aug 2021 02:56:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k5so24611461lfu.4;
        Sun, 29 Aug 2021 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3egmclPp6Wx1/0tawWJ+PILwmaso1iDcpgDHnZfUHs=;
        b=BDGEEtVed7NONusJZRJVpHxLj7oDNbgLuwQd6K6oa8GlLEkaC3/TZdxnd25z8eXsEQ
         bqXnF0mb9zNnMkL1TcmikekU70b0nLu2etltRVyh6j/O5d2qFB9epT2APsunY6fRlrSy
         FweebPe/eHMe8Or398yW4JX9RoSnzoZoRxq3L1B+5U5MbjtZDEYKdSG1v7Dqw/SX39rF
         L9ZSU05Jl6xWInM/nEmMNdysh7a8g8mMqxGIfVBi4uKpPOpPzoSts+WGgTgZRWi37FsF
         AKCukGuhBVmSFN8cVjn6jIihHRNVpr3SiYhJfbVTyVsHNkkxXvAxnA5L/BTboNxlR8wk
         ZX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3egmclPp6Wx1/0tawWJ+PILwmaso1iDcpgDHnZfUHs=;
        b=rvddSqFgxf8iNdJidBIHwBb8OGXV3byeBbsgkWTEVnoCZUoTxYL6mTvMGuU7HMrc2H
         LeKMjRO3jTHyEOZAj7HtVcMCdpA2HG2OXAXkPoQkmV8D7zrK5Yr3C4J+Ywyaowlsc1Un
         wzch+2VOuIMyfyOtkGEelppjyKzBQN9X8HYf9Z9wnEvExlrL8cT3TFS0Zf/3S9/Gg1UZ
         QN0DRs+jkCcp6QKFSvS6mWE8wgRAM3hUs1EyUE+6wfcjSLCw0CAqUTchC0orO0/0M2D/
         3/DFXeTW6jWAb6z8AAdzJlgBklTSSqrk5RJTJ2cdc6MqGfKEujlzvzowkFNrTpy0hiNG
         LVnQ==
X-Gm-Message-State: AOAM530VAx7u9x+xUyF2V5YMjqiUspq0yQEGKojlLp9G/5nC+6ku4jIE
        PaVJC9YICK3TGWjniJpLT1A=
X-Google-Smtp-Source: ABdhPJz2qfjqW8rdnNGzA4UGKKEppM5B4O4oRkU43Z12Y+bss2f8O8bAZo0YQ0ZnJIHjMOr0xWQx1g==
X-Received: by 2002:a05:6512:ac7:: with SMTP id n7mr5086161lfu.469.1630231010634;
        Sun, 29 Aug 2021 02:56:50 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:50 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 5/9] fs/ntfs3: Init spi more in init_fs_context than fill_super
Date:   Sun, 29 Aug 2021 12:56:10 +0300
Message-Id: <20210829095614.50021-6-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

init_fs_context() is meant to initialize s_fs_info (spi). Move spi
initializing code there which we can initialize before fill_super().

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 99102a146cf5..b2a3f947542b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -870,7 +870,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	const struct VOLUME_INFO *info;
 	u32 idx, done, bytes;
 	struct ATTR_DEF_ENTRY *t;
-	u16 *upcase = NULL;
+	u16 *upcase;
 	u16 *shared;
 	bool is_ro;
 	struct MFT_REF ref;
@@ -885,9 +885,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
 
-	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
-			     DEFAULT_RATELIMIT_BURST);
-
 	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
 	if (IS_ERR(sbi->options->nls)) {
 		sbi->options->nls = NULL;
@@ -917,12 +914,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
 #endif
 
-	mutex_init(&sbi->compress.mtx_lznt);
-#ifdef CONFIG_NTFS3_LZX_XPRESS
-	mutex_init(&sbi->compress.mtx_xpress);
-	mutex_init(&sbi->compress.mtx_lzx);
-#endif
-
 	/*
 	 * Load $Volume. This should be done before LogFile
 	 * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'
@@ -1207,11 +1198,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out;
 	}
 
-	sbi->upcase = upcase = kvmalloc(0x10000 * sizeof(short), GFP_KERNEL);
-	if (!upcase) {
-		err = -ENOMEM;
-		goto out;
-	}
+	upcase = sbi->upcase;
 
 	for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
 		const __le16 *src;
@@ -1421,10 +1408,21 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 		goto ok;
 
 	sbi = kzalloc(sizeof(struct ntfs_sb_info), GFP_NOFS);
-	if (!sbi) {
-		kfree(opts);
-		return -ENOMEM;
-	}
+	if (!sbi)
+		goto free_opts;
+
+	sbi->upcase = kvmalloc(0x10000 * sizeof(short), GFP_KERNEL);
+	if (!sbi->upcase)
+		goto free_sbi;
+
+	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
+			     DEFAULT_RATELIMIT_BURST);
+
+	mutex_init(&sbi->compress.mtx_lznt);
+#ifdef CONFIG_NTFS3_LZX_XPRESS
+	mutex_init(&sbi->compress.mtx_xpress);
+	mutex_init(&sbi->compress.mtx_lzx);
+#endif
 
 	sbi->options = opts;
 	fc->s_fs_info = sbi;
@@ -1433,6 +1431,11 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 	fc->ops = &ntfs_context_ops;
 
 	return 0;
+free_opts:
+	kfree(opts);
+free_sbi:
+	kfree(sbi);
+	return -ENOMEM;
 }
 
 // clang-format off
-- 
2.25.1

