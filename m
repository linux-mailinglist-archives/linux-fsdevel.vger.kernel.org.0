Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011895363F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiE0OVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiE0OVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:21:08 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 07:21:07 PDT
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC28106560;
        Fri, 27 May 2022 07:21:06 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id EACD52629;
        Fri, 27 May 2022 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653661237;
        bh=XnC7aSAr5neGOTbasoTgRb0LT1HnKG7Qv+EzDQ/U96s=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=TJo2FR8XuGjp2J4EmDVyjwgKesMT1QCW38axW6Bg555bGml6FqTEzHGDpJU4Otbt7
         f5iJ6T7UCq8+PqDA9gAyLh7tzVqXUw8IqAutKrMrZcTRdhFPvpbcAN5PogAz9zK0q8
         mi/dK3fYOOOI/YNIejBMlQttPpQD/U06Ib6fNC/E=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 93361220E;
        Fri, 27 May 2022 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653661264;
        bh=XnC7aSAr5neGOTbasoTgRb0LT1HnKG7Qv+EzDQ/U96s=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=XoYlcs8nM4kChSxxvHnaa/UCkpzr5vQ187tjOzeDwUdPbQZia6n1/keHbS5VOiz/N
         hkB6+5A9TlT5s7wkL3RN3zanV2X/sNeqzdGu/FtPJJkR9j5QSXepzjJurZvEQsZo/j
         2e3sQHB1fR+V4nqIgxcKV8ub2JSYAHX1JFovNgHo=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 27 May 2022 17:21:04 +0300
Message-ID: <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
Date:   Fri, 27 May 2022 17:21:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 1/3] fs/ntfs3: Refactoring of indx_find function
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

This commit makes function a bit more readable

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/index.c | 20 ++++++--------------
  1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6f81e3a49abf..511f872b6650 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1042,19 +1042,16 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
  {
  	int err;
  	struct NTFS_DE *e;
-	const struct INDEX_HDR *hdr;
  	struct indx_node *node;
  
  	if (!root)
  		root = indx_get_root(&ni->dir, ni, NULL, NULL);
  
  	if (!root) {
-		err = -EINVAL;
-		goto out;
+		/* Should not happed. */
+		return -EINVAL;
  	}
  
-	hdr = &root->ihdr;
-
  	/* Check cache. */
  	e = fnd->level ? fnd->de[fnd->level - 1] : fnd->root_de;
  	if (e && !de_is_last(e) &&
@@ -1068,39 +1065,34 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
  	fnd_clear(fnd);
  
  	/* Lookup entry that is <= to the search value. */
-	e = hdr_find_e(indx, hdr, key, key_len, ctx, diff);
+	e = hdr_find_e(indx, &root->ihdr, key, key_len, ctx, diff);
  	if (!e)
  		return -EINVAL;
  
  	fnd->root_de = e;
-	err = 0;
  
  	for (;;) {
  		node = NULL;
  		if (*diff >= 0 || !de_has_vcn_ex(e)) {
  			*entry = e;
-			goto out;
+			return 0;
  		}
  
  		/* Read next level. */
  		err = indx_read(indx, ni, de_get_vbn(e), &node);
  		if (err)
-			goto out;
+			return err;
  
  		/* Lookup entry that is <= to the search value. */
  		e = hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx,
  			       diff);
  		if (!e) {
-			err = -EINVAL;
  			put_indx_node(node);
-			goto out;
+			return -EINVAL;
  		}
  
  		fnd_push(fnd, node, e);
  	}
-
-out:
-	return err;
  }
  
  int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
-- 
2.36.1

