Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8A6118DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJ1RHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJ1RGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:06:43 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4653057C;
        Fri, 28 Oct 2022 10:04:56 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 93084218D;
        Fri, 28 Oct 2022 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976535;
        bh=jh6TmRNujxdGyXcLGIP5CgKNVwl50ZTAY12V/CuhgaM=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=rMsB6p3Mx7e9njRaCFp11e2gPAfFd0+9aH+JvJF3+hlE5fxowj+xFwj+MY6ZPOEDD
         ouau4on/yVxu2+kGt7CUg3SRwELHHZB7pz9NL+PT9+oj1RZTGFfiAEoK4xMk4pbW96
         zotrhs8XsnHxgL7pft490w8f227Er6UL42mrSuUs=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:04:54 +0300
Message-ID: <b68c5399-4ee2-9514-e3dc-685f8e9befc9@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:04:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 07/14] fs/ntfs3: Restore correct state after ENOSPC in
 attr_data_get_block
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added new function ntfs_check_for_free_space.
Added undo mechanism in attr_data_get_block.
Fixes xfstest generic/083

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 141 +++++++++++++++++++++++++++++----------------
  fs/ntfs3/fsntfs.c  |  33 +++++++++++
  fs/ntfs3/ntfs_fs.h |   1 +
  3 files changed, 125 insertions(+), 50 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 91ea73e6f4fe..5e6bafb10f42 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -891,8 +891,10 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  	struct ATTR_LIST_ENTRY *le, *le_b;
  	struct mft_inode *mi, *mi_b;
  	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
+	CLST alloc, evcn;
  	unsigned fr;
-	u64 total_size;
+	u64 total_size, total_size0;
+	int step = 0;
  
  	if (new)
  		*new = false;
@@ -932,7 +934,12 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  
  	asize = le64_to_cpu(attr_b->nres.alloc_size) >> cluster_bits;
  	if (vcn >= asize) {
-		err = -EINVAL;
+		if (new) {
+			err = -EINVAL;
+		} else {
+			*len = 1;
+			*lcn = SPARSE_LCN;
+		}
  		goto out;
  	}
  
@@ -1036,10 +1043,12 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  	if (err)
  		goto out;
  	*new = true;
+	step = 1;
  
  	end = vcn + alen;
-	total_size = le64_to_cpu(attr_b->nres.total_size) +
-		     ((u64)alen << cluster_bits);
+	/* Save 'total_size0' to restore if error. */
+	total_size0 = le64_to_cpu(attr_b->nres.total_size);
+	total_size = total_size0 + ((u64)alen << cluster_bits);
  
  	if (vcn != vcn0) {
  		if (!run_lookup_entry(run, vcn0, lcn, len, NULL)) {
@@ -1081,7 +1090,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  		if (!ni->attr_list.size) {
  			err = ni_create_attr_list(ni);
  			if (err)
-				goto out;
+				goto undo1;
  			/* Layout of records is changed. */
  			le_b = NULL;
  			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
@@ -1098,67 +1107,83 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  		}
  	}
  
+	/*
+	 * The code below may require additional cluster (to extend attribute list)
+	 * and / or one MFT record
+	 * It is too complex to undo operations if -ENOSPC occurs deep inside
+	 * in 'ni_insert_nonresident'.
+	 * Return in advance -ENOSPC here if there are no free cluster and no free MFT.
+	 */
+	if (!ntfs_check_for_free_space(sbi, 1, 1)) {
+		/* Undo step 1. */
+		err = -ENOSPC;
+		goto undo1;
+	}
+
+	step = 2;
  	svcn = evcn1;
  
  	/* Estimate next attribute. */
  	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &svcn, &mi);
  
-	if (attr) {
-		CLST alloc = bytes_to_cluster(
-			sbi, le64_to_cpu(attr_b->nres.alloc_size));
-		CLST evcn = le64_to_cpu(attr->nres.evcn);
-
-		if (end < next_svcn)
-			end = next_svcn;
-		while (end > evcn) {
-			/* Remove segment [svcn : evcn). */
-			mi_remove_attr(NULL, mi, attr);
-
-			if (!al_remove_le(ni, le)) {
-				err = -EINVAL;
-				goto out;
-			}
+	if (!attr) {
+		/* Insert new attribute segment. */
+		goto ins_ext;
+	}
  
-			if (evcn + 1 >= alloc) {
-				/* Last attribute segment. */
-				evcn1 = evcn + 1;
-				goto ins_ext;
-			}
+	/* Try to update existed attribute segment. */
+	alloc = bytes_to_cluster(sbi, le64_to_cpu(attr_b->nres.alloc_size));
+	evcn = le64_to_cpu(attr->nres.evcn);
  
-			if (ni_load_mi(ni, le, &mi)) {
-				attr = NULL;
-				goto out;
-			}
+	if (end < next_svcn)
+		end = next_svcn;
+	while (end > evcn) {
+		/* Remove segment [svcn : evcn). */
+		mi_remove_attr(NULL, mi, attr);
  
-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
-					    &le->id);
-			if (!attr) {
-				err = -EINVAL;
-				goto out;
-			}
-			svcn = le64_to_cpu(attr->nres.svcn);
-			evcn = le64_to_cpu(attr->nres.evcn);
+		if (!al_remove_le(ni, le)) {
+			err = -EINVAL;
+			goto out;
  		}
  
-		if (end < svcn)
-			end = svcn;
+		if (evcn + 1 >= alloc) {
+			/* Last attribute segment. */
+			evcn1 = evcn + 1;
+			goto ins_ext;
+		}
  
-		err = attr_load_runs(attr, ni, run, &end);
-		if (err)
+		if (ni_load_mi(ni, le, &mi)) {
+			attr = NULL;
  			goto out;
+		}
  
-		evcn1 = evcn + 1;
-		attr->nres.svcn = cpu_to_le64(next_svcn);
-		err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
-		if (err)
+		attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, &le->id);
+		if (!attr) {
+			err = -EINVAL;
  			goto out;
+		}
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn = le64_to_cpu(attr->nres.evcn);
+	}
  
-		le->vcn = cpu_to_le64(next_svcn);
-		ni->attr_list.dirty = true;
-		mi->dirty = true;
+	if (end < svcn)
+		end = svcn;
+
+	err = attr_load_runs(attr, ni, run, &end);
+	if (err)
+		goto out;
+
+	evcn1 = evcn + 1;
+	attr->nres.svcn = cpu_to_le64(next_svcn);
+	err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
+	if (err)
+		goto out;
+
+	le->vcn = cpu_to_le64(next_svcn);
+	ni->attr_list.dirty = true;
+	mi->dirty = true;
+	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
  
-		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
-	}
  ins_ext:
  	if (evcn1 > next_svcn) {
  		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
@@ -1170,10 +1195,26 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  ok:
  	run_truncate_around(run, vcn);
  out:
+	if (err && step > 1) {
+		/* Too complex to restore. */
+		_ntfs_bad_inode(&ni->vfs_inode);
+	}
  	up_write(&ni->file.run_lock);
  	ni_unlock(ni);
  
  	return err;
+
+undo1:
+	/* Undo step1. */
+	attr_b->nres.total_size = cpu_to_le64(total_size0);
+	inode_set_bytes(&ni->vfs_inode, total_size0);
+
+	if (run_deallocate_ex(sbi, run, vcn, alen, NULL, false) ||
+	    !run_add_entry(run, vcn, SPARSE_LCN, alen, false) ||
+	    mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn)) {
+		_ntfs_bad_inode(&ni->vfs_inode);
+	}
+	goto out;
  }
  
  int attr_data_read_resident(struct ntfs_inode *ni, struct page *page)
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 3fe2de74eeaf..b56ffb4951cc 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -419,6 +419,39 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
  	return err;
  }
  
+/*
+ * ntfs_check_for_free_space
+ *
+ * Check if it is possible to allocate 'clen' clusters and 'mlen' Mft records
+ */
+bool ntfs_check_for_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen)
+{
+	size_t free, zlen, avail;
+	struct wnd_bitmap *wnd;
+
+	wnd = &sbi->used.bitmap;
+	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+	free = wnd_zeroes(wnd);
+	zlen = wnd_zone_len(wnd);
+	up_read(&wnd->rw_lock);
+
+	if (free < zlen + clen)
+		return false;
+
+	avail = free - (zlen + clen);
+
+	wnd = &sbi->mft.bitmap;
+	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
+	free = wnd_zeroes(wnd);
+	zlen = wnd_zone_len(wnd);
+	up_read(&wnd->rw_lock);
+
+	if (free >= zlen + mlen)
+		return true;
+
+	return avail >= bytes_to_cluster(sbi, mlen << sbi->record_bits);
+}
+
  /*
   * ntfs_extend_mft - Allocate additional MFT records.
   *
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 5fad93a2c3fd..d73d1c837ba7 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -587,6 +587,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi);
  int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
  			     CLST *new_lcn, CLST *new_len,
  			     enum ALLOCATE_OPT opt);
+bool ntfs_check_for_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen);
  int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
  		       struct ntfs_inode *ni, struct mft_inode **mi);
  void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft);
-- 
2.37.0


