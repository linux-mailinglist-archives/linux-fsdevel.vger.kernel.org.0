Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33322659793
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 12:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiL3LZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 06:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiL3LZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:25:51 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467BCC6A;
        Fri, 30 Dec 2022 03:25:51 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B4A8220EE;
        Fri, 30 Dec 2022 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399336;
        bh=snwY2+VKm0LsKlpAvdxmC463EUj3w2PVok9aOOZl/rI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=rRz9SCjfJ8B7V/kgmkjToZKbuXssEC25O8lWLZ7lBJJaL4VBHMap3MRnA10pXH3UK
         FJhG5btOP2lonbcl2n+UtyprUXZcCL7aLFJrezIUIqyieXDKpz0p8jL8ffTZ7yYj3S
         kyzwnKco+Bqq3u3sx0ASikQ8HsGeHW0Sgl6xfGCI=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 14:25:48 +0300
Message-ID: <4628ae8a-39e9-ecf8-3efe-193a1ad14d23@paragon-software.com>
Date:   Fri, 30 Dec 2022 15:25:48 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH 3/5] fs/ntfs3: Check for extremely large size of $AttrDef
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <b06828df-f9b9-1c5d-d6db-05839bad7016@paragon-software.com>
In-Reply-To: <b06828df-f9b9-1c5d-d6db-05839bad7016@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added additional checking for size of $AttrDef.
Added comment.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ef4ea3f21905..0967035146ce 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1185,10 +1185,18 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
          goto out;
      }

-    if (inode->i_size < sizeof(struct ATTR_DEF_ENTRY)) {
+    /*
+     * Typical $AttrDef contains up to 20 entries.
+     * Check for extremely large size.
+     */
+    if (inode->i_size < sizeof(struct ATTR_DEF_ENTRY) ||
+        inode->i_size > 100 * sizeof(struct ATTR_DEF_ENTRY)) {
+        ntfs_err(sb, "Looks like $AttrDef is corrupted (size=%llu).",
+             inode->i_size);
          err = -EINVAL;
          goto put_inode_out;
      }
+
      bytes = inode->i_size;
      sbi->def_table = t = kmalloc(bytes, GFP_NOFS | __GFP_NOWARN);
      if (!t) {
-- 
2.34.1

