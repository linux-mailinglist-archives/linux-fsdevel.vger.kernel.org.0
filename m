Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D23573B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiGMQqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiGMQqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:46:19 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C792F675;
        Wed, 13 Jul 2022 09:46:09 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0A2AF1DDC;
        Wed, 13 Jul 2022 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730700;
        bh=6w5c48gmW/YY/IIJ/xoAHW0KtFqt52eG/b55ntFWz/E=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=jY4AJCQGHqz7Ph2aKZHz9oq9Nd6df+bIenx28o+IDf9zGiH1k7o+Fr2EGJZe9Roal
         4P/VoRAqoUWnVaYGXLziiIvsEeCQaX8wuoQCi5LCHHd0jyhI279NfdFNKSN8HOx/Nj
         4mYZtZIKizr+S8T6/2AAYDtX1rqbxlcMGTcqeGP8=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:46:07 +0300
Message-ID: <33c5b044-23a4-60a6-1649-9e5db228c2f7@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:46:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 3/6] fs/ntfs3: Refactoring attr_punch_hole to restore after
 errors
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
In-Reply-To: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
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

Added comments to code
Added new function run_clone to make a copy of run
Added done and undo labels for restoring after errors

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 117 ++++++++++++++++++++++++++++++---------------
  fs/ntfs3/ntfs_fs.h |   1 +
  fs/ntfs3/run.c     |  25 ++++++++++
  3 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 7bcae3094712..24d545041787 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -140,7 +140,10 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
  		}
  
  		if (lcn != SPARSE_LCN) {
-			mark_as_free_ex(sbi, lcn, clen, trim);
+			if (sbi) {
+				/* mark bitmap range [lcn + clen) as free and trim clusters. */
+				mark_as_free_ex(sbi, lcn, clen, trim);
+			}
  			dn += clen;
  		}
  
@@ -2002,10 +2005,11 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	struct ATTRIB *attr = NULL, *attr_b;
  	struct ATTR_LIST_ENTRY *le, *le_b;
  	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, vcn, len, end, alen, dealloc, next_svcn;
+	CLST svcn, evcn1, vcn, len, end, alen, hole, next_svcn;
  	u64 total_size, alloc_size;
  	u32 mask;
  	__le16 a_flags;
+	struct runs_tree run2;
  
  	if (!bytes)
  		return 0;
@@ -2057,6 +2061,9 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	}
  
  	down_write(&ni->file.run_lock);
+	run_init(&run2);
+	run_truncate(run, 0);
+
  	/*
  	 * Enumerate all attribute segments and punch hole where necessary.
  	 */
@@ -2064,7 +2071,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	vcn = vbo >> sbi->cluster_bits;
  	len = bytes >> sbi->cluster_bits;
  	end = vcn + len;
-	dealloc = 0;
+	hole = 0;
  
  	svcn = le64_to_cpu(attr_b->nres.svcn);
  	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
@@ -2076,14 +2083,14 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  		mi = mi_b;
  	} else if (!le_b) {
  		err = -EINVAL;
-		goto out;
+		goto bad_inode;
  	} else {
  		le = le_b;
  		attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
  				    &mi);
  		if (!attr) {
  			err = -EINVAL;
-			goto out;
+			goto bad_inode;
  		}
  
  		svcn = le64_to_cpu(attr->nres.svcn);
@@ -2091,69 +2098,91 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	}
  
  	while (svcn < end) {
-		CLST vcn1, zero, dealloc2;
+		CLST vcn1, zero, hole2 = hole;
  
  		err = attr_load_runs(attr, ni, run, &svcn);
  		if (err)
-			goto out;
+			goto done;
  		vcn1 = max(vcn, svcn);
  		zero = min(end, evcn1) - vcn1;
  
-		dealloc2 = dealloc;
-		err = run_deallocate_ex(sbi, run, vcn1, zero, &dealloc, true);
+		/*
+		 * Check range [vcn1 + zero).
+		 * Calculate how many clusters there are.
+		 * Don't do any destructive actions.
+		 */
+		err = run_deallocate_ex(NULL, run, vcn1, zero, &hole2, false);
  		if (err)
-			goto out;
+			goto done;
  
-		if (dealloc2 == dealloc) {
-			/* Looks like the required range is already sparsed. */
-		} else {
-			if (!run_add_entry(run, vcn1, SPARSE_LCN, zero,
-					   false)) {
-				err = -ENOMEM;
-				goto out;
-			}
+		/* Check if required range is already hole. */
+		if (hole2 == hole)
+			goto next_attr;
  
-			err = mi_pack_runs(mi, attr, run, evcn1 - svcn);
+		/* Make a clone of run to undo. */
+		err = run_clone(run, &run2);
+		if (err)
+			goto done;
+
+		/* Make a hole range (sparse) [vcn1 + zero). */
+		if (!run_add_entry(run, vcn1, SPARSE_LCN, zero, false)) {
+			err = -ENOMEM;
+			goto done;
+		}
+
+		/* Update run in attribute segment. */
+		err = mi_pack_runs(mi, attr, run, evcn1 - svcn);
+		if (err)
+			goto done;
+		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+		if (next_svcn < evcn1) {
+			/* Insert new attribute segment. */
+			err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
+						    next_svcn,
+						    evcn1 - next_svcn, a_flags,
+						    &attr, &mi, &le);
  			if (err)
-				goto out;
-			next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
-			if (next_svcn < evcn1) {
-				err = ni_insert_nonresident(ni, ATTR_DATA, NULL,
-							    0, run, next_svcn,
-							    evcn1 - next_svcn,
-							    a_flags, &attr, &mi,
-							    &le);
-				if (err)
-					goto out;
-				/* Layout of records maybe changed. */
-				attr_b = NULL;
-			}
+				goto undo_punch;
+
+			/* Layout of records maybe changed. */
+			attr_b = NULL;
  		}
+
+		/* Real deallocate. Should not fail. */
+		run_deallocate_ex(sbi, &run2, vcn1, zero, &hole, true);
+
+next_attr:
  		/* Free all allocated memory. */
  		run_truncate(run, 0);
  
  		if (evcn1 >= alen)
  			break;
  
+		/* Get next attribute segment. */
  		attr = ni_enum_attr_ex(ni, attr, &le, &mi);
  		if (!attr) {
  			err = -EINVAL;
-			goto out;
+			goto bad_inode;
  		}
  
  		svcn = le64_to_cpu(attr->nres.svcn);
  		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
  	}
  
-	total_size -= (u64)dealloc << sbi->cluster_bits;
+done:
+	if (!hole)
+		goto out;
+
  	if (!attr_b) {
  		attr_b = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
  				      &mi_b);
  		if (!attr_b) {
  			err = -EINVAL;
-			goto out;
+			goto bad_inode;
  		}
  	}
+
+	total_size -= (u64)hole << sbi->cluster_bits;
  	attr_b->nres.total_size = cpu_to_le64(total_size);
  	mi_b->dirty = true;
  
@@ -2163,11 +2192,23 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	mark_inode_dirty(&ni->vfs_inode);
  
  out:
+	run_close(&run2);
  	up_write(&ni->file.run_lock);
-	if (err)
-		_ntfs_bad_inode(&ni->vfs_inode);
-
  	return err;
+
+bad_inode:
+	_ntfs_bad_inode(&ni->vfs_inode);
+	goto out;
+
+undo_punch:
+	/*
+	 * Restore packed runs.
+	 * 'mi_pack_runs' should not fail, cause we restore original.
+	 */
+	if (mi_pack_runs(mi, attr, &run2, evcn1 - svcn))
+		goto bad_inode;
+
+	goto done;
  }
  
  /*
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index c3e17090effc..23f93c263091 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -798,6 +798,7 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
  #define run_unpack_ex run_unpack
  #endif
  int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn);
+int run_clone(const struct runs_tree *run, struct runs_tree *new_run);
  
  /* Globals from super.c */
  void *ntfs_set_shared(void *ptr, u32 bytes);
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index e4bd46b02531..ed09b7a6f6e5 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1157,3 +1157,28 @@ int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
  	*highest_vcn = vcn64 - 1;
  	return 0;
  }
+
+/*
+ * run_clone
+ *
+ * Make a copy of run
+ */
+int run_clone(const struct runs_tree *run, struct runs_tree *new_run)
+{
+	size_t bytes = run->count * sizeof(struct ntfs_run);
+
+	if (bytes > new_run->allocated) {
+		struct ntfs_run *new_ptr = kvmalloc(bytes, GFP_KERNEL);
+
+		if (!new_ptr)
+			return -ENOMEM;
+
+		kvfree(new_run->runs);
+		new_run->runs = new_ptr;
+		new_run->allocated = bytes;
+	}
+
+	memcpy(new_run->runs, run->runs, bytes);
+	new_run->count = run->count;
+	return 0;
+}
-- 
2.37.0


