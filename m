Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E0573B87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiGMQq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiGMQqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:46:42 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3342FFD2;
        Wed, 13 Jul 2022 09:46:41 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 70B7A1DDC;
        Wed, 13 Jul 2022 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730731;
        bh=+Kxi6wCqMCYp3uid88lNveT4fDMaGw09h6CkdfU5K6A=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=hiLucy7XTGMVKScpiHa+Gpk9vIwT1Gmbze39+X0o1vROp+khJq3lwy6gzkl7O6T+9
         4C5QRS2LjjLDUqRHJIDHW0RTaHt0hK2s3UPCf9mLDLhWjovbeoOZyYKvwGglHbiz0I
         GfddntXvhPbtC+HG8F/3W1GUPsR5wIlAIihKkqMM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 041E4213E;
        Wed, 13 Jul 2022 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730799;
        bh=+Kxi6wCqMCYp3uid88lNveT4fDMaGw09h6CkdfU5K6A=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=f9li3KrufgwTrm5ZEbWRHRqk0YQsOXz+B1weK916No18JJT9rdWccioHON9mDaWF4
         zKpvA1nUmnCjmrBMXnazuBr2nI4CJP1uUfk0oLNZLiAnlYVJ3dpNqmPvd4MMR3YWeK
         ws+kwGaTCAfKManicuHe2V39S1TXirMgq4bm/794=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:46:38 +0300
Message-ID: <ab84cf8a-63bc-fc54-9f0c-43b3ef2705ab@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:46:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 4/6] fs/ntfs3: Refactoring attr_insert_range to restore after
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

Added done and undo labels for restoring after errors

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 115 ++++++++++++++++++++++++++++++++++------------
  1 file changed, 86 insertions(+), 29 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 24d545041787..71f870d497ae 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2275,28 +2275,29 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  
  	if (!attr_b->non_res) {
  		err = attr_set_size(ni, ATTR_DATA, NULL, 0, run,
-				    data_size + bytes, NULL, false, &attr);
+				    data_size + bytes, NULL, false, NULL);
+
+		le_b = NULL;
+		attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err = -EINVAL;
+			goto bad_inode;
+		}
+
  		if (err)
  			goto out;
-		if (!attr->non_res) {
+
+		if (!attr_b->non_res) {
  			/* Still resident. */
-			char *data = Add2Ptr(attr, attr->res.data_off);
+			char *data = Add2Ptr(attr_b, attr_b->res.data_off);
  
  			memmove(data + bytes, data, bytes);
  			memset(data, 0, bytes);
-			err = 0;
-			goto out;
+			goto done;
  		}
+
  		/* Resident files becomes nonresident. */
-		le_b = NULL;
-		attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
-				      &mi_b);
-		if (!attr_b)
-			return -ENOENT;
-		if (!attr_b->non_res) {
-			err = -EINVAL;
-			goto out;
-		}
  		data_size = le64_to_cpu(attr_b->nres.data_size);
  		alloc_size = le64_to_cpu(attr_b->nres.alloc_size);
  	}
@@ -2314,14 +2315,14 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
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
@@ -2344,7 +2345,6 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  		goto out;
  
  	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
-	run_truncate_head(run, next_svcn);
  
  	while ((attr = ni_enum_attr_ex(ni, attr, &le, &mi)) &&
  	       attr->type == ATTR_DATA && !attr->name_len) {
@@ -2357,9 +2357,27 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  		mi->dirty = true;
  	}
  
+	if (next_svcn < evcn1 + len) {
+		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
+					    next_svcn, evcn1 + len - next_svcn,
+					    a_flags, NULL, NULL, NULL);
+
+		le_b = NULL;
+		attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err = -EINVAL;
+			goto bad_inode;
+		}
+
+		if (err) {
+			/* ni_insert_nonresident failed. Try to undo. */
+			goto undo_insert_range;
+		}
+	}
+
  	/*
-	 * Update primary attribute segment in advance.
-	 * pointer attr_b may become invalid (layout of mft is changed)
+	 * Update primary attribute segment.
  	 */
  	if (vbo <= ni->i_valid)
  		ni->i_valid += bytes;
@@ -2374,14 +2392,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  		attr_b->nres.valid_size = cpu_to_le64(ni->i_valid);
  	mi_b->dirty = true;
  
-	if (next_svcn < evcn1 + len) {
-		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
-					    next_svcn, evcn1 + len - next_svcn,
-					    a_flags, NULL, NULL, NULL);
-		if (err)
-			goto out;
-	}
-
+done:
  	ni->vfs_inode.i_size += bytes;
  	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
  	mark_inode_dirty(&ni->vfs_inode);
@@ -2390,8 +2401,54 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  	run_truncate(run, 0); /* clear cached values. */
  
  	up_write(&ni->file.run_lock);
-	if (err)
-		_ntfs_bad_inode(&ni->vfs_inode);
  
  	return err;
+
+bad_inode:
+	_ntfs_bad_inode(&ni->vfs_inode);
+	goto out;
+
+undo_insert_range:
+	svcn = le64_to_cpu(attr_b->nres.svcn);
+	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
+
+	if (svcn <= vcn && vcn < evcn1) {
+		attr = attr_b;
+		le = le_b;
+		mi = mi_b;
+	} else if (!le_b) {
+		goto bad_inode;
+	} else {
+		le = le_b;
+		attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
+				    &mi);
+		if (!attr) {
+			goto bad_inode;
+		}
+
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+	}
+
+	if (attr_load_runs(attr, ni, run, NULL))
+		goto bad_inode;
+
+	if (!run_collapse_range(run, vcn, len))
+		goto bad_inode;
+
+	if (mi_pack_runs(mi, attr, run, evcn1 + len - svcn))
+		goto bad_inode;
+
+	while ((attr = ni_enum_attr_ex(ni, attr, &le, &mi)) &&
+	       attr->type == ATTR_DATA && !attr->name_len) {
+		le64_sub_cpu(&attr->nres.svcn, len);
+		le64_sub_cpu(&attr->nres.evcn, len);
+		if (le) {
+			le->vcn = attr->nres.svcn;
+			ni->attr_list.dirty = true;
+		}
+		mi->dirty = true;
+	}
+
+	goto out;
  }
-- 
2.37.0


