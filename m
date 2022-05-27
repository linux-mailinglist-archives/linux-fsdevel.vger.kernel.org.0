Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3A95363F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352148AbiE0OWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350235AbiE0OWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:22:06 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF234BAE;
        Fri, 27 May 2022 07:22:04 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 297FA2629;
        Fri, 27 May 2022 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653661295;
        bh=gY524lf/gzPmcrcGqzOWu5zx71hGf3abpPOyo+Ffr80=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ED7kfG/vEm9bI9Gft1ivzFLUVj7DPujpoJSWZZ3ri7HXf/QnknuRrlbU5HZZFeLw2
         7pjwBE5E3/+KwmjYBuVk/JhlgqYK5Gxkp6n4d0H/rE2JMjikDDyr8cT4incsbuhty9
         Mk53R8mjisNgLESqwNw7IVtS+aPEPTZLbiYlbu9I=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 27 May 2022 17:22:02 +0300
Message-ID: <d196d00e-1d08-36e5-a721-7b04614ec35a@paragon-software.com>
Date:   Fri, 27 May 2022 17:22:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 2/3] fs/ntfs3: Fix double free on remount
Content-Language: en-US
From:   Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <75a1215a-eda2-d0dc-b962-0334356eef7c@paragon-software.com>
In-Reply-To: <75a1215a-eda2-d0dc-b962-0334356eef7c@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pointer to options was freed twice on remount
Fixes xfstest generic/361
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d41d76979e12..697a84ed395e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -30,6 +30,7 @@
  #include <linux/fs_context.h>
  #include <linux/fs_parser.h>
  #include <linux/log2.h>
+#include <linux/minmax.h>
  #include <linux/module.h>
  #include <linux/nls.h>
  #include <linux/seq_file.h>
@@ -390,7 +391,7 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
  		return -EINVAL;
  	}
  
-	memcpy(sbi->options, new_opts, sizeof(*new_opts));
+	swap(sbi->options, fc->fs_private);
  
  	return 0;
  }
@@ -897,6 +898,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
  	ref.high = 0;
  
  	sbi->sb = sb;
+	sbi->options = fc->fs_private;
+	fc->fs_private = NULL;
  	sb->s_flags |= SB_NODIRATIME;
  	sb->s_magic = 0x7366746e; // "ntfs"
  	sb->s_op = &ntfs_sops;
@@ -1260,8 +1263,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
  		goto put_inode_out;
  	}
  
-	fc->fs_private = NULL;
-
  	return 0;
  
  put_inode_out:
@@ -1414,7 +1415,6 @@ static int ntfs_init_fs_context(struct fs_context *fc)
  	mutex_init(&sbi->compress.mtx_lzx);
  #endif
  
-	sbi->options = opts;
  	fc->s_fs_info = sbi;
  ok:
  	fc->fs_private = opts;
-- 
2.36.1

