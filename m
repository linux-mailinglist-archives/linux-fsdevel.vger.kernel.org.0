Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51A4DB4B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357102AbiCPPUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346132AbiCPPUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:20:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D76580EE;
        Wed, 16 Mar 2022 08:18:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7816621110;
        Wed, 16 Mar 2022 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647443934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tpw6+n0JNVrF3PdumEnMKRdd5KjodhFw+pwv0xEhnk=;
        b=K6OAJMNOOw1hzGMNOAqhN/+P7S4YpPsHZ80vmeVyB8cVFBfws7kpB8D5yTBXO1j6lUV5xc
        uQmQpZshUPOgAQ67Dk37rO/+id+SSnRMKUIzS9YbBviSEX6iTDUf+x2UAquksT+dyKszoX
        Ejq/VPyDtANonbrjaIbm2m8XjKDZSSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647443934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tpw6+n0JNVrF3PdumEnMKRdd5KjodhFw+pwv0xEhnk=;
        b=QR1JTap8plpyXfniQ6pidvW1sKfoHV8UfMyVbXG0o33RnlDcQPKYZ9i14qXH35kvo7xh7Y
        h3vhz/mCya/MfoCQ==
Received: from vasant-suse.fritz.box (unknown [10.163.24.178])
        by relay2.suse.de (Postfix) with ESMTP id 37695A3B92;
        Wed, 16 Mar 2022 15:18:54 +0000 (UTC)
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     David Disseldorp <ddiss@suse.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Cc:     Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 1/1] exfat: allow access to paths with trailing dots
Date:   Wed, 16 Mar 2022 16:18:46 +0100
Message-Id: <20220316151846.12685-2-vkarasulli@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316151846.12685-1-vkarasulli@suse.de>
References: <20220316151846.12685-1-vkarasulli@suse.de>
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

 exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which state:

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
On Windows 10, trailing and leading space ' ' characters are stripped
from the filenames
.
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

This commit adds "keep_last_dots" mount option that controls whether or
not trailing periods '.' are stripped
from path components during file lookup or file creation.
This mount option can be used to access
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

  + echo > kexfat_created_dots_again...
  sh: kexfat_created_dots_again...: Invalid argument

Link: https://bugzilla.suse.com/show_bug.cgi?id=1188964
Link: https://lore.kernel.org/linux-fsdevel/003b01d755e4$31fb0d80$95f12880$
@samsung.com/
Link: https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
Co-developed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/exfat/exfat_fs.h |  3 ++-
 fs/exfat/namei.c    | 50 ++++++++++++++++++++++++++++++++-------------
 fs/exfat/super.c    |  7 +++++++
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 619e5b4bed10..c6800b880920 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -203,7 +203,8 @@ struct exfat_mount_options {
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
-		 discard:1; /* Issue discard requests on deletions */
+		 discard:1, /* Issue discard requests on deletions */
+		 keep_last_dots:1; /* Keep trailing periods in paths */
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
 };

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
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8c9fb7dcec16..4c3f80ed17b1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -174,6 +174,8 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",errors=remount-ro");
 	if (opts->discard)
 		seq_puts(m, ",discard");
+	if (opts->keep_last_dots)
+		seq_puts(m, ",keep_last_dots");
 	if (opts->time_offset)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	return 0;
@@ -217,6 +219,7 @@ enum {
 	Opt_charset,
 	Opt_errors,
 	Opt_discard,
+	Opt_keep_last_dots,
 	Opt_time_offset,

 	/* Deprecated options */
@@ -243,6 +246,7 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_string("iocharset",		Opt_charset),
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
+	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
 		  NULL),
@@ -297,6 +301,9 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_discard:
 		opts->discard = 1;
 		break;
+	case Opt_keep_last_dots:
+		opts->keep_last_dots = 1;
+		break;
 	case Opt_time_offset:
 		/*
 		 * Make the limit 24 just in case someone invents something
--
2.32.0

