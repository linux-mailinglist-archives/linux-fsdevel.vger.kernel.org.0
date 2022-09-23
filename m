Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348F5E7A31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiIWMIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIWMGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:06:17 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C512ED83;
        Fri, 23 Sep 2022 05:02:47 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 07C142173;
        Fri, 23 Sep 2022 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663934437;
        bh=9h8HcWYd0SfTeCNvuHdZHPs2YkclRVOz6udoku1OqUw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Zp6n0k8BShm4EkbcmcubaEET5+L0XOCBrodRiJYLdW7wrhKEumOVlFmQsbPGlOBvR
         74SsQtHC8PGKmvWFM2TX3xGRnjLg8X10K0tYHm7husJdGGGDKuagsYCaDQf+jasBJM
         29UmJHOJO21EqnWoBa7RiiQzfvkPkzjRw+fNt5ik=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E93D9DD;
        Fri, 23 Sep 2022 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663934565;
        bh=9h8HcWYd0SfTeCNvuHdZHPs2YkclRVOz6udoku1OqUw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=JUTeHtpPtkiL9EXVnKMSZi9fN9b83kREZKTwkj4RYCYo6OKDg5xG7EWlVyCElgv/m
         ZZ0WSBB+/Adam/zig+l9SPm/ILaB4J6MOVnIdoGMMMVIVNZf4NY6WYd2gZx2nlGXns
         o8CrVJLHrENfNWCnw6MyBqz24RNTVT/nrCzugxT0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 23 Sep 2022 15:02:45 +0300
Message-ID: <18cc1af1-8ad2-7a05-d5a1-c68ab5569def@paragon-software.com>
Date:   Fri, 23 Sep 2022 15:02:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 1/2] fs/ntfs3: Add option "nocase"
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <91c21f32-cc6f-2c2e-ebf7-d1d738090aef@paragon-software.com>
In-Reply-To: <91c21f32-cc6f-2c2e-ebf7-d1d738090aef@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds mount option and additional functions.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/index.c   |   2 +-
  fs/ntfs3/namei.c   | 139 +++++++++++++++++++++++++++++++++++++++++++++
  fs/ntfs3/ntfs_fs.h |   4 ++
  fs/ntfs3/super.c   |   6 ++
  fs/ntfs3/upcase.c  |  12 ++++
  5 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 440328147e7e..613036f9c6e6 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -47,7 +47,7 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
  	if (l2 < fsize2)
  		return -1;
  
-	both_case = f2->type != FILE_NAME_DOS /*&& !sbi->options.nocase*/;
+	both_case = f2->type != FILE_NAME_DOS && !sbi->options->nocase;
  	if (!l1) {
  		const struct le_str *s2 = (struct le_str *)&f2->name_len;
  
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc22cc321a74..315763eb05ff 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -7,6 +7,7 @@
  
  #include <linux/fs.h>
  #include <linux/nls.h>
+#include <linux/ctype.h>
  
  #include "debug.h"
  #include "ntfs.h"
@@ -355,6 +356,138 @@ struct dentry *ntfs3_get_parent(struct dentry *child)
  	return ERR_PTR(-ENOENT);
  }
  
+/*
+ * dentry_operations::d_hash
+ */
+static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
+{
+	struct ntfs_sb_info *sbi;
+	const char *n = name->name;
+	unsigned int len = name->len;
+	unsigned long hash;
+	struct cpu_str *uni;
+	unsigned int c;
+	int err;
+
+	/* First try fast implementation. */
+	hash = init_name_hash(dentry);
+
+	for (;;) {
+		if (!len--) {
+			name->hash = end_name_hash(hash);
+			return 0;
+		}
+
+		c = *n++;
+		if (c >= 0x80)
+			break;
+
+		hash = partial_name_hash(toupper(c), hash);
+	}
+
+	/*
+	 * Try slow way with current upcase table
+	 */
+	uni = __getname();
+	if (!uni)
+		return -ENOMEM;
+
+	sbi = dentry->d_sb->s_fs_info;
+
+	err = ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
+				UTF16_HOST_ENDIAN);
+	if (err < 0)
+		goto out;
+
+	if (!err) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	hash = ntfs_names_hash(uni->name, uni->len, sbi->upcase,
+			       init_name_hash(dentry));
+	name->hash = end_name_hash(hash);
+	err = 0;
+
+out:
+	__putname(uni);
+	return err;
+}
+
+/*
+ * dentry_operations::d_compare
+ */
+static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
+			  const char *str, const struct qstr *name)
+{
+	struct ntfs_sb_info *sbi;
+	int ret;
+	const char *n1 = str;
+	const char *n2 = name->name;
+	unsigned int len2 = name->len;
+	unsigned int lm = min(len1, len2);
+	unsigned char c1, c2;
+	struct cpu_str *uni1, *uni2;
+
+	/* First try fast implementation. */
+	for (;;) {
+		if (!lm--) {
+			ret = len1 == len2 ? 0 : 1;
+			goto out;
+		}
+
+		if ((c1 = *n1++) == (c2 = *n2++))
+			continue;
+
+		if (c1 >= 0x80 || c2 >= 0x80)
+			break;
+
+		if (toupper(c1) != toupper(c2)) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+	/*
+	 * Try slow way with current upcase table
+	 */
+	sbi = dentry->d_sb->s_fs_info;
+	uni1 = __getname();
+	if (!uni1)
+		return -ENOMEM;
+
+	ret = ntfs_nls_to_utf16(sbi, str, len1, uni1, NTFS_NAME_LEN,
+				UTF16_HOST_ENDIAN);
+	if (ret < 0)
+		goto out;
+
+	if (!ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	uni2 = Add2Ptr(uni1, 2048);
+
+	ret = ntfs_nls_to_utf16(sbi, name->name, name->len, uni2, NTFS_NAME_LEN,
+				UTF16_HOST_ENDIAN);
+	if (ret < 0)
+		goto out;
+
+	if (!ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = !ntfs_cmp_names(uni1->name, uni1->len, uni2->name, uni2->len,
+			      sbi->upcase, false)
+		      ? 0
+		      : 1;
+
+out:
+	__putname(uni1);
+	return ret;
+}
+
  // clang-format off
  const struct inode_operations ntfs_dir_inode_operations = {
  	.lookup		= ntfs_lookup,
@@ -382,4 +515,10 @@ const struct inode_operations ntfs_special_inode_operations = {
  	.get_acl	= ntfs_get_acl,
  	.set_acl	= ntfs_set_acl,
  };
+
+const struct dentry_operations ntfs_dentry_ops = {
+	.d_hash		= ntfs_d_hash,
+	.d_compare	= ntfs_d_compare,
+};
+
  // clang-format on
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index cd680ada50ab..6c1c7ef3b2d6 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -101,6 +101,7 @@ struct ntfs_mount_options {
  	unsigned force : 1; /* RW mount dirty volume. */
  	unsigned noacsrules : 1; /* Exclude acs rules. */
  	unsigned prealloc : 1; /* Preallocate space when file is growing. */
+	unsigned nocase : 1; /* case insensitive. */
  };
  
  /* Special value to unpack and deallocate. */
@@ -721,6 +722,7 @@ struct dentry *ntfs3_get_parent(struct dentry *child);
  
  extern const struct inode_operations ntfs_dir_inode_operations;
  extern const struct inode_operations ntfs_special_inode_operations;
+extern const struct dentry_operations ntfs_dentry_ops;
  
  /* Globals from record.c */
  int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
@@ -840,6 +842,8 @@ int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
  		   const u16 *upcase, bool bothcase);
  int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
  		       const u16 *upcase, bool bothcase);
+unsigned long ntfs_names_hash(const u16 *name, size_t len, const u16 *upcase,
+			      unsigned long hash);
  
  /* globals from xattr.c */
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 87d9eabf9847..d72a27abf1c8 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -253,6 +253,7 @@ enum Opt {
  	Opt_iocharset,
  	Opt_prealloc,
  	Opt_noacsrules,
+	Opt_nocase,
  	Opt_err,
  };
  
@@ -272,6 +273,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
  	fsparam_flag_no("showmeta",		Opt_showmeta),
  	fsparam_flag_no("prealloc",		Opt_prealloc),
  	fsparam_flag_no("acsrules",		Opt_noacsrules),
+	fsparam_flag_no("nocase",		Opt_nocase),
  	fsparam_string("iocharset",		Opt_iocharset),
  	{}
  };
@@ -383,6 +385,9 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
  	case Opt_noacsrules:
  		opts->noacsrules = result.negated ? 1 : 0;
  		break;
+	case Opt_nocase:
+		opts->nocase = result.negated ? 1 : 0;
+		break;
  	default:
  		/* Should not be here unless we forget add case. */
  		return -EINVAL;
@@ -936,6 +941,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
  	sb->s_export_op = &ntfs_export_ops;
  	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
  	sb->s_xattr = ntfs_xattr_handlers;
+	sb->s_d_op = sbi->options->nocase ? &ntfs_dentry_ops : NULL;
  
  	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
  	if (IS_ERR(sbi->options->nls)) {
diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
index b5e8256fd710..7681eefacb4b 100644
--- a/fs/ntfs3/upcase.c
+++ b/fs/ntfs3/upcase.c
@@ -102,3 +102,15 @@ int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
  	diff2 = l1 - l2;
  	return diff2 ? diff2 : diff1;
  }
+
+/* Helper function for ntfs_d_hash. */
+unsigned long ntfs_names_hash(const u16 *name, size_t len, const u16 *upcase,
+			      unsigned long hash)
+{
+	while (len--) {
+		unsigned int c = upcase_unicode_char(upcase, *name++);
+		hash = partial_name_hash(c, hash);
+	}
+
+	return hash;
+}
-- 
2.37.0

