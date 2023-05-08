Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177B96FB02F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjEHMgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjEHMgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:36:44 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986D391BE;
        Mon,  8 May 2023 05:36:39 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8DF8E21C3;
        Mon,  8 May 2023 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549110;
        bh=h5cbTykc9cuI68jfwGBg6SVUQfDSQ4DeVKUgsn+zaao=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=IrRYPMph4pWjLaHDypU5B9Y9R8yzwcToPVA1MQT0qienyTf8C7Jc/lyXDBRspjxm3
         xBjgaKNCbXDoM4ITCj4bNnfrFkSulkmJlrN1KvGcO16aiOWNnJ/YQhrWutKP5hdwFd
         f+Js0zqSZmcLd9I6q7WK31VNpe0aZbd0Rtd1hXRM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3F15B2191;
        Mon,  8 May 2023 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549397;
        bh=h5cbTykc9cuI68jfwGBg6SVUQfDSQ4DeVKUgsn+zaao=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=hm7oaKhjn6FnPfk/UtGsGFWrGvBA3FZap6DH8mF8yNUveTW8HtyndqQPBPLq0ejLy
         WPcBcwjAY7MnJdaxo42FUMZr12HEfrb37EbjxJ54u171P56ki/U8JhYVPTp1BxIE9j
         NoRKwmUiiObDkS0+UUxS6B5laYvBTH6CFeDXKSLc=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:36:36 +0300
Message-ID: <cf807cd5-8566-6a56-f446-1f97ffd9eacc@paragon-software.com>
Date:   Mon, 8 May 2023 16:36:36 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 02/10] fs/ntfs3: Fix ntfs_atomic_open
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
In-Reply-To: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fixes xfstest 633/696.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/namei.c | 15 +++------------
  1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 9736b1e4a0f6..343bce6da58a 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -422,19 +422,10 @@ static int ntfs_atomic_open(struct inode *dir, 
struct dentry *dentry,
       * fnd contains tree's path to insert to.
       * If fnd is not NULL then dir is locked.
       */
-
-    /*
-     * Unfortunately I don't know how to get here correct 'struct 
nameidata *nd'
-     * or 'struct mnt_idmap *idmap'.
-     * See atomic_open in fs/namei.c.
-     * This is why xfstest/633 failed.
-     * Looks like ntfs_atomic_open must accept 'struct mnt_idmap 
*idmap' as argument.
-     */
-
-    inode = ntfs_create_inode(&nop_mnt_idmap, dir, dentry, uni, mode, 0,
-                  NULL, 0, fnd);
+    inode = ntfs_create_inode(mnt_idmap(file->f_path.mnt), dir, dentry, 
uni,
+                  mode, 0, NULL, 0, fnd);
      err = IS_ERR(inode) ? PTR_ERR(inode) :
-                    finish_open(file, dentry, ntfs_file_open);
+                  finish_open(file, dentry, ntfs_file_open);
      dput(d);

  out2:
-- 
2.34.1

