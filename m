Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EA53863F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiE3Qk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiE3Qk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 12:40:58 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90270371;
        Mon, 30 May 2022 09:40:57 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 759F31F86;
        Mon, 30 May 2022 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653928825;
        bh=sICHCfo4uTR9mxXHyCTyqelqqIWYEf1R3oO5FRPMAf0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=uGpJDEEz+5fYhvd+y3hQkruz0yb7f05Qhm3qvxK7CN586eb//uucHu1KgjKgpmXFb
         21dBh1irQdVa0Ru3y7iQDa5+ykmabI+7exB5PspCIlL3XtSHL4xYdjWymgoqIfPdJJ
         B8lQ0Xit7TNefNZC/GRvXNllRL/NDYkGg5U9TYOw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 May 2022 19:40:55 +0300
Message-ID: <10fe5b38-eb6c-8cb2-5355-1952a6cfb447@paragon-software.com>
Date:   Mon, 30 May 2022 19:40:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH v2 3/3] fs/ntfs3: Refactor ni_try_remove_attr_list function
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
In-Reply-To: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
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

Now we save a copy of primary record for restoration.
Also now we remove all attributes from subrecords.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c | 49 ++++++++++++++++++++++++++++++++++------------
  fs/ntfs3/record.c  |  5 ++---
  2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 18842998c8fa..3576268ee0a1 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -7,6 +7,7 @@
  
  #include <linux/fiemap.h>
  #include <linux/fs.h>
+#include <linux/minmax.h>
  #include <linux/vmalloc.h>
  
  #include "debug.h"
@@ -649,6 +650,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  	struct mft_inode *mi;
  	u32 asize, free;
  	struct MFT_REF ref;
+	struct MFT_REC *mrec;
  	__le16 id;
  
  	if (!ni->attr_list.dirty)
@@ -692,11 +694,17 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  		free -= asize;
  	}
  
+	/* Make a copy of primary record to restore if error. */
+	mrec = kmemdup(ni->mi.mrec, sbi->record_size, GFP_NOFS);
+	if (!mrec)
+		return 0; /* Not critical. */
+
  	/* It seems that attribute list can be removed from primary record. */
  	mi_remove_attr(NULL, &ni->mi, attr_list);
  
  	/*
-	 * Repeat the cycle above and move all attributes to primary record.
+	 * Repeat the cycle above and copy all attributes to primary record.
+	 * Do not remove original attributes from subrecords!
  	 * It should be success!
  	 */
  	le = NULL;
@@ -707,14 +715,14 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  		mi = ni_find_mi(ni, ino_get(&le->ref));
  		if (!mi) {
  			/* Should never happened, 'cause already checked. */
-			goto bad;
+			goto out;
  		}
  
  		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
  				    le->name_len, &le->id);
  		if (!attr) {
  			/* Should never happened, 'cause already checked. */
-			goto bad;
+			goto out;
  		}
  		asize = le32_to_cpu(attr->size);
  
@@ -724,18 +732,33 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  					  le16_to_cpu(attr->name_off));
  		if (!attr_ins) {
  			/*
-			 * Internal error.
-			 * Either no space in primary record (already checked).
-			 * Either tried to insert another
-			 * non indexed attribute (logic error).
+			 * No space in primary record (already checked).
  			 */
-			goto bad;
+			goto out;
  		}
  
  		/* Copy all except id. */
  		id = attr_ins->id;
  		memcpy(attr_ins, attr, asize);
  		attr_ins->id = id;
+	}
+
+	/*
+	 * Repeat the cycle above and remove all attributes from subrecords.
+	 */
+	le = NULL;
+	while ((le = al_enumerate(ni, le))) {
+		if (!memcmp(&le->ref, &ref, sizeof(ref)))
+			continue;
+
+		mi = ni_find_mi(ni, ino_get(&le->ref));
+		if (!mi)
+			continue;
+
+		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+				    le->name_len, &le->id);
+		if (!attr)
+			continue;
  
  		/* Remove from original record. */
  		mi_remove_attr(NULL, mi, attr);
@@ -748,11 +771,13 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  	ni->attr_list.le = NULL;
  	ni->attr_list.dirty = false;
  
+	kfree(mrec);
+	return 0;
+out:
+	/* Restore primary record. */
+	swap(mrec, ni->mi.mrec);
+	kfree(mrec);
  	return 0;
-bad:
-	ntfs_inode_err(&ni->vfs_inode, "Internal error");
-	make_bad_inode(&ni->vfs_inode);
-	return -EINVAL;
  }
  
  /*
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 861e35791506..8fe0a876400a 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -445,12 +445,11 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
  	attr = NULL;
  	while ((attr = mi_enum_attr(mi, attr))) {
  		diff = compare_attr(attr, type, name, name_len, upcase);
-		if (diff > 0)
-			break;
+
  		if (diff < 0)
  			continue;
  
-		if (!is_attr_indexed(attr))
+		if (!diff && !is_attr_indexed(attr))
  			return NULL;
  		break;
  	}
-- 
2.36.1


