Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8109B4D4B05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiCJOeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiCJOav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:30:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D9186461;
        Thu, 10 Mar 2022 06:26:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DF7EB1F381;
        Thu, 10 Mar 2022 14:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646922345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++Jw21RLpGNeaQls3k41a2AkvyCBXO9w+RoMdYIogPE=;
        b=GZWn3eNCVSyZbAekI7KNyRFf5uXxm+oijBOaGyTNaM2/sruC9YIqDyJvG/mMC9CesdY/vA
        XbJYBsSOErFba2VwMkmDpV2Xl8hqTNBK3dhL4krPn9hrAs09XZ92FFM4MzRFIUSt9DSq/o
        KHg+h9LhKZEETfsdi6q1KfBQA6cRtrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646922345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++Jw21RLpGNeaQls3k41a2AkvyCBXO9w+RoMdYIogPE=;
        b=K57dwkBeez158WEN6yxWY9ftQ4J6I+SUcjXNVyz+JiFk0AUrdgy34vbCrL+3xG4fgOoZCg
        /DRITECazwxbNmBw==
Received: from vasant-suse.fritz.box (unknown [10.163.24.178])
        by relay2.suse.de (Postfix) with ESMTP id 9C542A3BB4;
        Thu, 10 Mar 2022 14:25:45 +0000 (UTC)
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ddiss@suse.de
Cc:     Vasant Karasulli <vkarasulli@suse.de>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/2] exfat currently unconditionally strips trailing periods '.' when performing path lookup, but allows them in the filenames during file creation. This is done intentionally, loosely following Windows behaviour and specifications which state:
Date:   Thu, 10 Mar 2022 15:24:55 +0100
Message-Id: <20220310142455.23127-3-vkarasulli@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310142455.23127-1-vkarasulli@suse.de>
References: <20220310142455.23127-1-vkarasulli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  #exFAT
  The concatenated file name has the same set of illegal characters as
  other FAT-based file systems (see Table 31).

  #FAT
  ...
  Leading and trailing spaces in a long name are ignored.
  Leading and embedded periods are allowed in a name and are stored in
  the long name. Trailing periods are ignored.

Note: Leading and trailing space ' ' characters are currently retained
by Linux kernel exfat, in conflict with the above specification.

Some implementations, such as fuse-exfat, don't perform path trailer
removal. When mounting images which contain trailing-dot paths, these
paths are unreachable, e.g.:

  + mount.exfat-fuse /dev/zram0 /mnt/test/
  FUSE exfat 1.3.0
  + cd /mnt/test/
  + touch fuse_created_dots... '  fuse_created_spaces  '
  + ls -l
  total 0
  -rwxrwxrwx 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
  -rwxrwxrwx 1 root 0 0 Aug 18 09:45  fuse_created_dots...
  + cd /
  + umount /mnt/test/
  + mount -t exfat /dev/zram0 /mnt/test
  + cd /mnt/test
  + ls -l
  ls: cannot access 'fuse_created_dots...': No such file or directory
  total 0
  -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
  -????????? ? ?    ? ?            ?  fuse_created_dots...
  + touch kexfat_created_dots... '  kexfat_created_spaces  '
  + ls -l
  ls: cannot access 'fuse_created_dots...': No such file or directory
  total 0
  -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
  -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  kexfat_created_spaces  '
  -????????? ? ?    ? ?            ?  fuse_created_dots...
  -rwxr-xr-x 1 root 0 0 Aug 18 09:45  kexfat_created_dots
  + cd /
  + umount /mnt/test/

With this change, the "keep_last_dots" mount option can be used to access
paths with trailing periods and disallow creating files with names with
trailing periods. E.g. continuing from the previous example:

  + mount -t exfat -o keep_last_dots /dev/zram0 /mnt/test
  + cd /mnt/test
  + ls -l
  total 0
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  fuse_created_spaces  '
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  kexfat_created_spaces  '
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32  fuse_created_dots...
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32  kexfat_created_dots

Link: https://bugzilla.suse.com/show_bug.cgi?id=1188964
Link: https://lore.kernel.org/linux-fsdevel/003b01d755e4$31fb0d80$95f12880$
@samsung.com/
Link: https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
Co-developed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/exfat/namei.c | 50 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index af4eb39cc0c3..a4f8010fbd38 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -65,11 +65,14 @@ static int exfat_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return ret;
 }
 
-/* returns the length of a struct qstr, ignoring trailing dots */
-static unsigned int exfat_striptail_len(unsigned int len, const char *name)
+/* returns the length of a struct qstr, ignoring trailing dots if necessary */
+static unsigned int exfat_striptail_len(unsigned int len, const char *name,
+					bool keep_last_dots)
 {
-	while (len && name[len - 1] == '.')
-		len--;
+	if (!keep_last_dots) {
+		while (len && name[len - 1] == '.')
+			len--;
+	}
 	return len;
 }
 
@@ -83,7 +86,8 @@ static int exfat_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	struct super_block *sb = dentry->d_sb;
 	struct nls_table *t = EXFAT_SB(sb)->nls_io;
 	const unsigned char *name = qstr->name;
-	unsigned int len = exfat_striptail_len(qstr->len, qstr->name);
+	unsigned int len = exfat_striptail_len(qstr->len, qstr->name,
+			   EXFAT_SB(sb)->options.keep_last_dots);
 	unsigned long hash = init_name_hash(dentry);
 	int i, charlen;
 	wchar_t c;
@@ -104,8 +108,10 @@ static int exfat_d_cmp(const struct dentry *dentry, unsigned int len,
 {
 	struct super_block *sb = dentry->d_sb;
 	struct nls_table *t = EXFAT_SB(sb)->nls_io;
-	unsigned int alen = exfat_striptail_len(name->len, name->name);
-	unsigned int blen = exfat_striptail_len(len, str);
+	unsigned int alen = exfat_striptail_len(name->len, name->name,
+				EXFAT_SB(sb)->options.keep_last_dots);
+	unsigned int blen = exfat_striptail_len(len, str,
+				EXFAT_SB(sb)->options.keep_last_dots);
 	wchar_t c1, c2;
 	int charlen, i;
 
@@ -136,7 +142,8 @@ static int exfat_utf8_d_hash(const struct dentry *dentry, struct qstr *qstr)
 {
 	struct super_block *sb = dentry->d_sb;
 	const unsigned char *name = qstr->name;
-	unsigned int len = exfat_striptail_len(qstr->len, qstr->name);
+	unsigned int len = exfat_striptail_len(qstr->len, qstr->name,
+			       EXFAT_SB(sb)->options.keep_last_dots);
 	unsigned long hash = init_name_hash(dentry);
 	int i, charlen;
 	unicode_t u;
@@ -161,8 +168,11 @@ static int exfat_utf8_d_cmp(const struct dentry *dentry, unsigned int len,
 		const char *str, const struct qstr *name)
 {
 	struct super_block *sb = dentry->d_sb;
-	unsigned int alen = exfat_striptail_len(name->len, name->name);
-	unsigned int blen = exfat_striptail_len(len, str);
+	unsigned int alen = exfat_striptail_len(name->len, name->name,
+				EXFAT_SB(sb)->options.keep_last_dots);
+	unsigned int blen = exfat_striptail_len(len, str,
+				EXFAT_SB(sb)->options.keep_last_dots);
+
 	unicode_t u_a, u_b;
 	int charlen, i;
 
@@ -416,13 +426,25 @@ static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
+	int pathlen = strlen(path);
 
-	/* strip all trailing periods */
-	namelen = exfat_striptail_len(strlen(path), path);
+	/*
+	 * get the length of the pathname excluding
+	 * trailing periods, if any.
+	 */
+	namelen = exfat_striptail_len(pathlen, path, false);
+	if (EXFAT_SB(sb)->options.keep_last_dots) {
+		/*
+		 * Do not allow the creation of files with names
+		 * ending with period(s).
+		 */
+		if (!lookup && (namelen < pathlen))
+			return -EINVAL;
+		namelen = pathlen;
+	}
 	if (!namelen)
 		return -ENOENT;
-
-	if (strlen(path) > (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
+	if (pathlen > (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
 		return -ENAMETOOLONG;
 
 	/*
-- 
2.32.0

