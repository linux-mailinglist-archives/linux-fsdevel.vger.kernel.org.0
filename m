Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3677B7AE9A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjIZJzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjIZJzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:55:41 -0400
X-Greylist: delayed 69 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 02:55:33 PDT
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D00F3;
        Tue, 26 Sep 2023 02:55:32 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AD98621BC;
        Tue, 26 Sep 2023 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695721780;
        bh=zfpCmKTIrrX/Tm3omQLSw+qcCQMVXlnwzcY50MQ9HGI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=r2zvMgty3J9zp812qs5vRyTGyhzL4ji93J7KqP6mRh+wYZyf81AwZM3JekNdNREfc
         IbCdHVL/ZUFIjro0fgcAi47CjY+xbxSoMH9BlQlueLTJlDy3YBD16zx3D3LCgOobbz
         Tk8hyV0LgKJTIvDAXJkonFNTdH4mxk3CdDJLjZrg=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 08C121D45;
        Tue, 26 Sep 2023 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695722131;
        bh=zfpCmKTIrrX/Tm3omQLSw+qcCQMVXlnwzcY50MQ9HGI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=sGwkdNutAIoorXYu/T6+JY8sssgHV7lXRSTMrVQjslvRO+0aOJMbH4UQ9yBUZMGFk
         wHz1Z0bt62kPwnvZEKtzPbbRV33DUTwOT6hvkkRrW2nL6joHqFkhlCAAmTLa4N7Iy+
         REc7lvXd35mxwZBaXLtqaAr86MbWhI1S4UW6HUgg=
Received: from [172.16.192.129] (192.168.211.137) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 12:55:29 +0300
Message-ID: <18681891-e588-4745-8cfc-2fe5fc0eee54@paragon-software.com>
Date:   Tue, 26 Sep 2023 12:55:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/8] fs/ntfs3: Allow repeated call to ntfs3_put_sbi
Content-Language: en-US
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
In-Reply-To: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.137]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/bitmap.c |  1 +
  fs/ntfs3/super.c  | 21 ++++++++++++++++-----
  2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index d66055e30aff..63f14a0232f6 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -125,6 +125,7 @@ void wnd_close(struct wnd_bitmap *wnd)
      struct rb_node *node, *next;

      kfree(wnd->free_bits);
+    wnd->free_bits = NULL;
      run_close(&wnd->run);

      node = rb_first(&wnd->start_tree);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index f78c67452b2a..71c80c578feb 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -576,20 +576,30 @@ static noinline void ntfs3_put_sbi(struct 
ntfs_sb_info *sbi)
      wnd_close(&sbi->mft.bitmap);
      wnd_close(&sbi->used.bitmap);

-    if (sbi->mft.ni)
+    if (sbi->mft.ni) {
          iput(&sbi->mft.ni->vfs_inode);
+        sbi->mft.ni = NULL;
+    }

-    if (sbi->security.ni)
+    if (sbi->security.ni) {
          iput(&sbi->security.ni->vfs_inode);
+        sbi->security.ni = NULL;
+    }

-    if (sbi->reparse.ni)
+    if (sbi->reparse.ni) {
          iput(&sbi->reparse.ni->vfs_inode);
+        sbi->reparse.ni = NULL;
+    }

-    if (sbi->objid.ni)
+    if (sbi->objid.ni) {
          iput(&sbi->objid.ni->vfs_inode);
+        sbi->objid.ni = NULL;
+    }

-    if (sbi->volume.ni)
+    if (sbi->volume.ni) {
          iput(&sbi->volume.ni->vfs_inode);
+        sbi->volume.ni = NULL;
+    }

      ntfs_update_mftmirr(sbi, 0);

@@ -1577,6 +1587,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      iput(inode);
  out:
      kfree(boot2);
+    ntfs3_put_sbi(sbi);
      return err;
  }

-- 
2.34.1

