Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108116FB02D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjEHMgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjEHMgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:36:24 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199E37E57;
        Mon,  8 May 2023 05:36:06 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B025E21C2;
        Mon,  8 May 2023 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549077;
        bh=8YnqHs6viNhkNZ9+6wZf88ELrlrGUvvnL2bs2/5eVko=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=HCrARVnRdX+b90e0/I9bBzR4l5wjGoEeWjE4hBXgbuvurr62vl2f/r6LIYWMZ9AM5
         QhFavzGfh8C8JjEFbZcixiMiI+gpMEkj1fvRdg0N7YknMtwK9/HnLZ8f+Ov7Y4/SFG
         MacEJQfAmzJeUxlGld1jYnzRwsoWN56Sa4oduakI=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:36:03 +0300
Message-ID: <ba9a25e5-89b1-cc25-6d2c-af86ca33e25b@paragon-software.com>
Date:   Mon, 8 May 2023 16:36:03 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 01/10] fs/ntfs3: Correct checking while generating attr_list
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

Correct slightly previous commit:
Enhance sanity check while generating attr_list

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c | 25 ++++++++++---------------
  1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 50214b77c6a3..66f3341c65ec 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -813,10 +813,8 @@ int ni_create_attr_list(struct ntfs_inode *ni)
       * Looks like one record_size is always enough.
       */
      le = kmalloc(al_aligned(rs), GFP_NOFS);
-    if (!le) {
-        err = -ENOMEM;
-        goto out;
-    }
+    if (!le)
+        return -ENOMEM;

      mi_get_ref(&ni->mi, &le->ref);
      ni->attr_list.le = le;
@@ -865,14 +863,14 @@ int ni_create_attr_list(struct ntfs_inode *ni)

          if (to_free > free_b) {
              err = -EINVAL;
-            goto out1;
+            goto out;
          }
      }

      /* Allocate child MFT. */
      err = ntfs_look_free_mft(sbi, &rno, is_mft, ni, &mi);
      if (err)
-        goto out1;
+        goto out;

      err = -EINVAL;
      /* Call mi_remove_attr() in reverse order to keep pointers 
'arr_move' valid. */
@@ -884,7 +882,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
          attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
                        b->name_len, asize, name_off);
          if (!attr)
-            goto out1;
+            goto out;

          mi_get_ref(mi, &le_b[nb]->ref);
          le_b[nb]->id = attr->id;
@@ -895,19 +893,19 @@ int ni_create_attr_list(struct ntfs_inode *ni)

          /* Remove from primary record. */
          if (!mi_remove_attr(NULL, &ni->mi, b))
-            goto out1;
+            goto out;

          if (to_free <= asize)
              break;
          to_free -= asize;
          if (!nb)
-            goto out1;
+            goto out;
      }

      attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
                    lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
      if (!attr)
-        goto out1;
+        goto out;

      attr->non_res = 0;
      attr->flags = 0;
@@ -921,16 +919,13 @@ int ni_create_attr_list(struct ntfs_inode *ni)
      ni->attr_list.dirty = false;

      mark_inode_dirty(&ni->vfs_inode);
-    goto out;
+    return 0;

-out1:
+out:
      kfree(ni->attr_list.le);
      ni->attr_list.le = NULL;
      ni->attr_list.size = 0;
      return err;
-
-out:
-    return 0;
  }

  /*
-- 
2.34.1

