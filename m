Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00A779BF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 02:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjHLAl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbjHLAl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:41:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8CC3581;
        Fri, 11 Aug 2023 17:41:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFB4D1F385;
        Sat, 12 Aug 2023 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691800915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gc3ImIlvvNAlNv89w2x2DqtkUeFquTvzH0e1HxxlakQ=;
        b=WPNMe74pRP9y1F4AfbMzA7v1wLaAk+rqQH4j7Fc2IBMN/lncSw4YpqM716vOqVqmsL7zjC
        AELb8iIU2hVGEdbcS6eTnI4op/H7W2sNkgx3DZnAXSs3b+rQnvpI0LT10+cr/UoQdkIIUP
        928H4kORANFovpX4ZSoZPfMpbAgCLKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691800915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gc3ImIlvvNAlNv89w2x2DqtkUeFquTvzH0e1HxxlakQ=;
        b=7bO/NmKNxiJ/5BFD5zAPqsdas9fCtjTJzsBfJlhynDqUada/lYz9mNV5xKH3cMHPZTSPUK
        9jxi+CQumQORzSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B712213592;
        Sat, 12 Aug 2023 00:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TcJ7JlPV1mQLEAAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 12 Aug 2023 00:41:55 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 01/10] fs: Expose helper to check if a directory needs casefolding
Date:   Fri, 11 Aug 2023 20:41:37 -0400
Message-ID: <20230812004146.30980-2-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812004146.30980-1-krisman@suse.de>
References: <20230812004146.30980-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation to use it in ecryptfs, move needs_casefolding into a
public header and give it a namespaced name.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c         | 14 ++------------
 include/linux/fs.h | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..8d0b64cfd5da 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1381,16 +1381,6 @@ bool is_empty_dir_inode(struct inode *inode)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Determine if the name of a dentry should be casefolded.
- *
- * Return: if names will need casefolding
- */
-static bool needs_casefold(const struct inode *dir)
-{
-	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
-}
-
 /**
  * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
  * @dentry:	dentry whose name we are checking against
@@ -1411,7 +1401,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	char strbuf[DNAME_INLINE_LEN];
 	int ret;
 
-	if (!dir || !needs_casefold(dir))
+	if (!dir || !dir_is_casefolded(dir))
 		goto fallback;
 	/*
 	 * If the dentry name is stored in-line, then it may be concurrently
@@ -1453,7 +1443,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	const struct unicode_map *um = sb->s_encoding;
 	int ret = 0;
 
-	if (!dir || !needs_casefold(dir))
+	if (!dir || !dir_is_casefolded(dir))
 		return 0;
 
 	ret = utf8_casefold_hash(um, dentry, str);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6867512907d6..e3b631c6d24a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3213,6 +3213,27 @@ static inline bool dir_relax_shared(struct inode *inode)
 	return !IS_DEADDIR(inode);
 }
 
+/**
+ * dir_is_casefolded - Safely determine if filenames inside of a
+ * directory should be casefolded.
+ * @dir: The directory inode to be checked
+ *
+ * Filesystems should usually rely on this instead of checking the
+ * S_CASEFOLD flag directly when handling inodes, to avoid surprises
+ * with corrupted volumes.  Checking i_sb->s_encoding ensures the
+ * filesystem knows how to deal with case-insensitiveness.
+ *
+ * Return: if names will need casefolding
+ */
+static inline bool dir_is_casefolded(const struct inode *dir)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
+#else
+	return false;
+#endif
+}
+
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
-- 
2.41.0

