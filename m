Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5505D6FB032
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjEHMhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjEHMhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:37:04 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C83702A;
        Mon,  8 May 2023 05:37:02 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9754021C3;
        Mon,  8 May 2023 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549133;
        bh=Sg0UiYsarTe92ydsTCL9y6XxwHeH2AmXLAFXljDEI6s=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=tPo/NAlD9PThmgQqltZ6Hqx/EHFIp4JWKcj24vVACX2ClRtdQbjzGRHtj/ryuV0HL
         LvA3Q1en1sRJ20sJJyniCi8J3Hg6rAJYLqagxiMMmU1y0KR7pJOLJpMf4paZEvzMfI
         rYk/6uFsdXQFzfAF4V5qo0WLfJ2oxezIFRaKxC8I=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:36:59 +0300
Message-ID: <f4e07222-4f9e-e50d-a898-0583c5a168d0@paragon-software.com>
Date:   Mon, 8 May 2023 16:36:59 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 03/10] fs/ntfs3: Mark ntfs dirty when on-disk struct is
 corrupted
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

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c  | 2 +-
  fs/ntfs3/index.c   | 6 ++++++
  fs/ntfs3/ntfs_fs.h | 2 ++
  fs/ntfs3/record.c  | 6 ++++++
  4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 28cc421102e5..21567e58265c 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -178,7 +178,7 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER 
*rhdr, size_t bytes,
      /* Check errors. */
      if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
          fn * SECTOR_SIZE > bytes) {
-        return -EINVAL; /* Native chkntfs returns ok! */
+        return -E_NTFS_CORRUPT;
      }

      /* Get fixup pointer. */
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 0a48d2d67219..b40da258e684 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1113,6 +1113,12 @@ int indx_read(struct ntfs_index *indx, struct 
ntfs_inode *ni, CLST vbn,
      *node = in;

  out:
+    if (err == -E_NTFS_CORRUPT) {
+        ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
+        ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+        err = -EINVAL;
+    }
+
      if (ib != in->index)
          kfree(ib);

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index eb01f7e76479..2e4be773728d 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -53,6 +53,8 @@ enum utf16_endian;
  #define E_NTFS_NONRESIDENT        556
  /* NTFS specific error code about punch hole. */
  #define E_NTFS_NOTALIGNED        557
+/* NTFS specific error code when on-disk struct is corrupted. */
+#define E_NTFS_CORRUPT            558


  /* sbi->flags */
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7060f784c2d7..7974ca35a15c 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -180,6 +180,12 @@ int mi_read(struct mft_inode *mi, bool is_mft)
      return 0;

  out:
+    if (err == -E_NTFS_CORRUPT) {
+        ntfs_err(sbi->sb, "mft corrupted");
+        ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+        err = -EINVAL;
+    }
+
      return err;
  }

-- 
2.34.1

