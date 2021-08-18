Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23DE3F025D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhHRLMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 07:12:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhHRLMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:12:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4E232006B
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629285109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbGDoq2IilZiL4ZDcGZyeTBcBh/zSOLUvNEnuIrEpv0=;
        b=KAlW7gkKhmtsZWgfN+xGTZiMIDCgBrsiFgjquz94QTX7p4hI56LUzTcthU9nebtuEkrFuU
        5BaNoquXJGkqFf5ltxi4SApNdmaUEPQGtl7+SHHEbrPfCd2N/4vwk4WKJf8RjlOuRDsy5v
        kICQI61RfC7Iv4TvAZIcGI6oZXSEzUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629285109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbGDoq2IilZiL4ZDcGZyeTBcBh/zSOLUvNEnuIrEpv0=;
        b=bzMPOuMsJ9BL5/A2bp6GUHcYvpY4vr0MzoBTTmEod4V6RMThVJ519LMYSaZ+bLhiihs7qP
        DAbKE7aQl7tYTCBg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5C61A3BA3;
        Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] exfat: keep trailing dots in paths if keeptail is set
Date:   Wed, 18 Aug 2021 13:11:23 +0200
Message-Id: <20210818111123.19818-3-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818111123.19818-1-ddiss@suse.de>
References: <20210818111123.19818-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat currently unconditionally strips trailing periods '.' when
performing path lookup. This is done intentionally, loosely following
Windows behaviour and specifications which state:

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

With this change, the "keeptail" mount option can be used to access
paths with trailing periods. E.g. continuing from the previous example:

  + mount -t exfat -o keeptail /dev/zram0 /mnt/test
  + cd /mnt/test
  + ls -l
  total 0
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  fuse_created_spaces  '
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  kexfat_created_spaces  '
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32  fuse_created_dots...
  -rwxr-xr-x 1 root 0 0 Aug 18 10:32  kexfat_created_dots

Link: https://bugzilla.suse.com/show_bug.cgi?id=1188964
Link: https://lore.kernel.org/linux-fsdevel/003b01d755e4$31fb0d80$95f12880$@samsung.com/
Link: https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#773-filename-field
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/exfat/namei.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 24b41103d1cc..e49455ce6da2 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -65,11 +65,14 @@ static int exfat_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return ret;
 }
 
-/* returns the length of a struct qstr, ignoring trailing dots */
-static unsigned int exfat_striptail_len(unsigned int len, const char *name)
+/* returns the length of a struct qstr, possibly ignoring trailing dots */
+static unsigned int exfat_striptail_len(struct super_block *sb,
+					unsigned int len, const char *name)
 {
-	while (len && name[len - 1] == '.')
-		len--;
+	if (!EXFAT_SB(sb)->options.keeptail) {
+		while (len && name[len - 1] == '.')
+			len--;
+	}
 	return len;
 }
 
@@ -83,7 +86,7 @@ static int exfat_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	struct super_block *sb = dentry->d_sb;
 	struct nls_table *t = EXFAT_SB(sb)->nls_io;
 	const unsigned char *name = qstr->name;
-	unsigned int len = exfat_striptail_len(qstr->len, qstr->name);
+	unsigned int len = exfat_striptail_len(sb, qstr->len, qstr->name);
 	unsigned long hash = init_name_hash(dentry);
 	int i, charlen;
 	wchar_t c;
@@ -104,8 +107,8 @@ static int exfat_d_cmp(const struct dentry *dentry, unsigned int len,
 {
 	struct super_block *sb = dentry->d_sb;
 	struct nls_table *t = EXFAT_SB(sb)->nls_io;
-	unsigned int alen = exfat_striptail_len(name->len, name->name);
-	unsigned int blen = exfat_striptail_len(len, str);
+	unsigned int alen = exfat_striptail_len(sb, name->len, name->name);
+	unsigned int blen = exfat_striptail_len(sb, len, str);
 	wchar_t c1, c2;
 	int charlen, i;
 
@@ -136,7 +139,7 @@ static int exfat_utf8_d_hash(const struct dentry *dentry, struct qstr *qstr)
 {
 	struct super_block *sb = dentry->d_sb;
 	const unsigned char *name = qstr->name;
-	unsigned int len = exfat_striptail_len(qstr->len, qstr->name);
+	unsigned int len = exfat_striptail_len(sb, qstr->len, qstr->name);
 	unsigned long hash = init_name_hash(dentry);
 	int i, charlen;
 	unicode_t u;
@@ -161,8 +164,8 @@ static int exfat_utf8_d_cmp(const struct dentry *dentry, unsigned int len,
 		const char *str, const struct qstr *name)
 {
 	struct super_block *sb = dentry->d_sb;
-	unsigned int alen = exfat_striptail_len(name->len, name->name);
-	unsigned int blen = exfat_striptail_len(len, str);
+	unsigned int alen = exfat_striptail_len(sb, name->len, name->name);
+	unsigned int blen = exfat_striptail_len(sb, len, str);
 	unicode_t u_a, u_b;
 	int charlen, i;
 
@@ -419,7 +422,7 @@ static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
 	/* strip all trailing periods */
-	namelen = exfat_striptail_len(strlen(path), path);
+	namelen = exfat_striptail_len(sb, strlen(path), path);
 	if (!namelen)
 		return -ENOENT;
 
-- 
2.31.1

