Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FA53863C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiE3QkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiE3QkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 12:40:05 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679696470E;
        Mon, 30 May 2022 09:40:04 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 288271F86;
        Mon, 30 May 2022 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653928772;
        bh=gY524lf/gzPmcrcGqzOWu5zx71hGf3abpPOyo+Ffr80=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ntNuaaKQ7pBH44imN202AJvn/CRhGayiUZuG5JZKdsgFLrbXs3FNyYsAyBNMjUadl
         mEVHggE1H5OHT3SD2WwmPuBJEtjICfQiSqDpGsW27XGWGYSwkM6SQskOtY6TetA3DG
         RhHG+Pz44G9/nwJ+w5k9RJI/KJ3hZls0ij+TDFxI=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 69D6F21B3;
        Mon, 30 May 2022 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653928802;
        bh=gY524lf/gzPmcrcGqzOWu5zx71hGf3abpPOyo+Ffr80=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=PhOMUaZNBR+9naglTsx3/PSB5UyAx1dQngqhqke4mWG8NvujQzOe7kVbWPfXJdcOh
         vcVPqsqcW1dhuHy3B/JAackGCgFbTicG1AWHI0JqTD6+ZMveWQ7nyCnomU6BfJsD48
         wHkdeq+mgaUYTiYwdXNYl96RjnIVTLGMed5Vdkh4=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 May 2022 19:40:01 +0300
Message-ID: <9dee6fd3-ab6f-b51a-b494-b579e537710b@paragon-software.com>
Date:   Mon, 30 May 2022 19:40:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH v2 2/3] fs/ntfs3: Fix double free on remount
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
In-Reply-To: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
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


