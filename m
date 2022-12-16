Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA3B64EDEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiLPP1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiLPP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209D654EE
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F5055D11A;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE8xnNEo354lxHLxVgr91ZXktWxx/iWQdoLYJC7j/hM=;
        b=MXZeHdRbPXxGEj2qnn4q8stE2JuNUjqhS2wSuQX2Phvi8uCH5fmunFQ6QYfgDL+FdfJOov
        pyAwUET74KIcXNTvdeuT3KjPWgskaSfUibA8z99H9b/eqRvC3H3f/AE9Pn9g65UVmmhhIX
        wckqhLJKq26FVWJCNcIvm3Wi5sZ7Z10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE8xnNEo354lxHLxVgr91ZXktWxx/iWQdoLYJC7j/hM=;
        b=TUfgOw429STm1UVqH2+BcEhWfr/9rq4ZDJX+RGm1KemA2mw+oTY1iEARbsYSNTERFcfXe2
        Pj/LQgB9I+6wPRAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 499601390D;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RKElEUaOnGPbCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 90C74A0768; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+69c9fdccc6dd08961d34@syzkaller.appspotmail.com
Subject: [PATCH 06/20] udf: Implement searching for directory entry using new iteration code
Date:   Fri, 16 Dec 2022 16:24:10 +0100
Message-Id: <20221216152656.6236-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2379; i=jack@suse.cz; h=from:subject; bh=oEyTZGpo56D7PXSJtPmxHY19CXw00hKZYRHHLFnE4AY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2bw174ANWKCpGMaMjw/NJoqy0n6ClE5Ny7PhQF OddabwaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNmwAKCRCcnaoHP2RA2cGXCA Df0vTfoOn/BKyfNOuDd82r50LVYBAuN+UjXbPbZLgMrOpCZcY+QkJGmeZpahlWnErtBz2aW3Q9ZkN/ 2h35scP+Zdrd1jP+Fdn4A8qMR4aFSu5RB/xl/Cre+8DZ1ZTYVUwrNR/MlkjaeFIKabBVuFIx/3dsbT qVrhgo/YEatieL9m+oAi9wKBqKlzSPob2nj0RrLMKpjVtz2RQclDG4SfCiLANOJ428sMS5R7R4JsFb eIeuNmrVZOhrwiVf0bTlxzr05Yc1u/YLIP3bo3Th0fJPWGQx6Jpue9+gdFse4LQ4AST2Di0Yk7AbUD Pn2NmQe1ZhpVoO0YtzvXKW9Zo4UZiQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement searching for directory entry - udf_fiiter_find_entry() -
using new directory iteration code.

Reported-by: syzbot+69c9fdccc6dd08961d34@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 78bc4bbb7c54..145883d15c0f 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -140,6 +140,73 @@ int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
 	return 0;
 }
 
+/**
+ * udf_fiiter_find_entry - find entry in given directory.
+ *
+ * @dir:	directory inode to search in
+ * @child:	qstr of the name
+ * @iter:	iter to use for searching
+ *
+ * This function searches in the directory @dir for a file name @child. When
+ * found, @iter points to the position in the directory with given entry.
+ *
+ * Returns 0 on success, < 0 on error (including -ENOENT).
+ */
+static int udf_fiiter_find_entry(struct inode *dir, const struct qstr *child,
+				 struct udf_fileident_iter *iter)
+{
+	int flen;
+	unsigned char *fname = NULL;
+	struct super_block *sb = dir->i_sb;
+	int isdotdot = child->len == 2 &&
+		child->name[0] == '.' && child->name[1] == '.';
+	int ret;
+
+	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
+	if (!fname)
+		return -ENOMEM;
+
+	for (ret = udf_fiiter_init(iter, dir, 0);
+	     !ret && iter->pos < dir->i_size;
+	     ret = udf_fiiter_advance(iter)) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
+			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
+				continue;
+		}
+
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) {
+			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
+				continue;
+		}
+
+		if ((iter->fi.fileCharacteristics & FID_FILE_CHAR_PARENT) &&
+		    isdotdot)
+			goto out_ok;
+
+		if (!iter->fi.lengthFileIdent)
+			continue;
+
+		flen = udf_get_filename(sb, iter->name,
+				iter->fi.lengthFileIdent, fname, UDF_NAME_LEN);
+		if (flen < 0) {
+			ret = flen;
+			goto out_err;
+		}
+
+		if (udf_match(flen, fname, child->len, child->name))
+			goto out_ok;
+	}
+	if (!ret)
+		ret = -ENOENT;
+
+out_err:
+	udf_fiiter_release(iter);
+out_ok:
+	kfree(fname);
+
+	return ret;
+}
+
 /**
  * udf_find_entry - find entry in given directory.
  *
-- 
2.35.3

