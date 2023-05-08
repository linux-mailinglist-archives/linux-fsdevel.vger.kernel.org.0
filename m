Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CE6FB04C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjEHMkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjEHMkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:40:08 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E023DC88;
        Mon,  8 May 2023 05:39:45 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4C39321C3;
        Mon,  8 May 2023 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549297;
        bh=6s1aiYUMi1N3V7VNMRBYWUxpu3ZEhCtn4SbHn7Qf7Fg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=aVk0mrX9MQkqEi99MHlO7uLlgKuUQcXvpr0EXyBauUXaj35rdaVC/KvhvRNxNOBS1
         VH0UBergSpSBdZBRl9a1KG61Qyf1wBmdNmNiiVIMBxW7z0CObhot03hGsQ1CsLxZRJ
         KaWr3N8j91EGcmFDIXvI26wQpNQ5EgtTwhIdwwYE=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:39:43 +0300
Message-ID: <5915fbe7-5448-6093-4318-a37987953c7a@paragon-software.com>
Date:   Mon, 8 May 2023 16:39:42 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 09/10] fs/ntfs3: Fix endian problem
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
  fs/ntfs3/frecord.c | 11 +++++------
  fs/ntfs3/ntfs_fs.h |  2 +-
  2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index be59bd399fd1..16bd9faa2d28 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -236,6 +236,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, 
struct ATTRIB *attr,
      return attr;

  out:
+    ntfs_inode_err(&ni->vfs_inode, "failed to parse mft record");
      ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
      return NULL;
  }
@@ -1643,14 +1644,13 @@ int ni_delete_all(struct ntfs_inode *ni)
   * Return: File name attribute by its value.
   */
  struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
-                     const struct cpu_str *uni,
+                     const struct le_str *uni,
                       const struct MFT_REF *home_dir,
                       struct mft_inode **mi,
                       struct ATTR_LIST_ENTRY **le)
  {
      struct ATTRIB *attr = NULL;
      struct ATTR_FILE_NAME *fname;
-    struct le_str *fns;

      if (le)
          *le = NULL;
@@ -1674,10 +1674,9 @@ struct ATTR_FILE_NAME *ni_fname_name(struct 
ntfs_inode *ni,
      if (uni->len != fname->name_len)
          goto next;

-    fns = (struct le_str *)&fname->name_len;
-    if (ntfs_cmp_names_cpu(uni, fns, NULL, false))
+    if (ntfs_cmp_names(uni->name, uni->len, fname->name, uni->len, NULL,
+               false))
          goto next;
-
      return fname;
  }

@@ -2915,7 +2914,7 @@ int ni_remove_name(struct ntfs_inode *dir_ni, 
struct ntfs_inode *ni,
      /* Find name in record. */
      mi_get_ref(&dir_ni->mi, &de_name->home);

-    fname = ni_fname_name(ni, (struct cpu_str *)&de_name->name_len,
+    fname = ni_fname_name(ni, (struct le_str *)&de_name->name_len,
                    &de_name->home, &mi, &le);
      if (!fname)
          return -ENOENT;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 98b61e4b3215..00fa782fcada 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -543,7 +543,7 @@ void ni_remove_attr_le(struct ntfs_inode *ni, struct 
ATTRIB *attr,
                 struct mft_inode *mi, struct ATTR_LIST_ENTRY *le);
  int ni_delete_all(struct ntfs_inode *ni);
  struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
-                     const struct cpu_str *uni,
+                     const struct le_str *uni,
                       const struct MFT_REF *home,
                       struct mft_inode **mi,
                       struct ATTR_LIST_ENTRY **entry);
-- 
2.34.1

