Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348EF5690B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 19:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiGFRcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiGFRcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:32:18 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372B2A27B;
        Wed,  6 Jul 2022 10:32:16 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 615471D06;
        Wed,  6 Jul 2022 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657128673;
        bh=tMnAizoXK6QBMMXkKehfHJvqxNBU6tVkklOZnbjrjZQ=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=hoors9GGD369P9C8i6yq4B/py99HgIgEcPGhZowZg1RDhClVJIEs4kUzae3O8fiXX
         rXiPAdCVJqvEPhC+6GR/TfOkNVs//9dpimwbc9yt6ozP+GS6GgAR6IWCr8rsiaKxFW
         buMZWC6hgRB7PN1Oo8td32yRR/2mcAsQxCvqyTDE=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Jul 2022 20:32:14 +0300
Message-ID: <61c894b8-9dc3-2d8f-3a60-80f60c24c7dd@paragon-software.com>
Date:   Wed, 6 Jul 2022 20:32:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 1/2] fs/ntfs3: Added comments to frecord functions
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
In-Reply-To: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
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

Added some comments in frecord.c for more context.
Also changed run_lookup to static because it's an internal function.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/bitmap.c  | 3 +--
  fs/ntfs3/frecord.c | 8 ++++----
  fs/ntfs3/ntfs_fs.h | 1 -
  fs/ntfs3/run.c     | 2 +-
  4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index e3b5680fd516..bb9ebb160227 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1393,9 +1393,8 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
  
  void wnd_zone_set(struct wnd_bitmap *wnd, size_t lcn, size_t len)
  {
-	size_t zlen;
+	size_t zlen = wnd->zone_end - wnd->zone_bit;
  
-	zlen = wnd->zone_end - wnd->zone_bit;
  	if (zlen)
  		wnd_add_free_ext(wnd, wnd->zone_bit, zlen, false);
  
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index acd9f444bd64..bc48923693a9 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1287,7 +1287,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
  	done = asize - run_size - SIZEOF_NONRESIDENT;
  	le32_sub_cpu(&ni->mi.mrec->used, done);
  
-	/* Estimate the size of second part: run_buf=NULL. */
+	/* Estimate packed size (run_buf=NULL). */
  	err = run_pack(run, svcn, evcn + 1 - svcn, NULL, sbi->record_size,
  		       &plen);
  	if (err < 0)
@@ -1317,6 +1317,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
  	attr->name_off = SIZEOF_NONRESIDENT_LE;
  	attr->flags = 0;
  
+	/* This function can't fail - cause already checked above. */
  	run_pack(run, svcn, evcn + 1 - svcn, Add2Ptr(attr, SIZEOF_NONRESIDENT),
  		 run_size, &plen);
  
@@ -1392,8 +1393,6 @@ int ni_expand_list(struct ntfs_inode *ni)
  
  	/* Split MFT data as much as possible. */
  	err = ni_expand_mft_list(ni);
-	if (err)
-		goto out;
  
  out:
  	return !err && !done ? -EOPNOTSUPP : err;
@@ -1419,6 +1418,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	u32 run_size, asize;
  	struct ntfs_sb_info *sbi = ni->mi.sbi;
  
+	/* Estimate packed size (run_buf=NULL). */
  	err = run_pack(run, svcn, len, NULL, sbi->max_bytes_per_attr - run_off,
  		       &plen);
  	if (err < 0)
@@ -1448,12 +1448,12 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	attr->name_off = cpu_to_le16(name_off);
  	attr->flags = flags;
  
+	/* This function can't fail - cause already checked above. */
  	run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size, &plen);
  
  	attr->nres.svcn = cpu_to_le64(svcn);
  	attr->nres.evcn = cpu_to_le64((u64)svcn + len - 1);
  
-	err = 0;
  	if (new_attr)
  		*new_attr = attr;
  
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index b88721e48458..cf1fa69a0eb8 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -773,7 +773,6 @@ bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
  void run_truncate(struct runs_tree *run, CLST vcn);
  void run_truncate_head(struct runs_tree *run, CLST vcn);
  void run_truncate_around(struct runs_tree *run, CLST vcn);
-bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index);
  bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
  		   bool is_mft);
  bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len);
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 7609d45a2d72..95fb9d739706 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -31,7 +31,7 @@ struct ntfs_run {
   * Case of entry missing from list 'index' will be set to
   * point to insertion position for the entry question.
   */
-bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
+static bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
  {
  	size_t min_idx, max_idx, mid_idx;
  	struct ntfs_run *r;
-- 
2.37.0


