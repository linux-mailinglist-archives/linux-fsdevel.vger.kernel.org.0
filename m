Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8181E3E3B62
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhHHQZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhHHQZe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B3C86101D;
        Sun,  8 Aug 2021 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439915;
        bh=CCbOjF4h8gnTbFB8EC68C16uQ5tIWZrtjoVHn9HD2fg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E+KscZX+ZPE+Jo3MK0DyGd64O/Ih5qoALWraOXZo+AA9RoS76bKzgVt70R1ObShCh
         lQepZYufzuiHS8LEouK2Tdn0Yvg3Fz1aSdKt9UT+Zsa0bhPknvpNtTJVxxOHpIqD5C
         DMIGFarRGtRwjA0OoJp+B0RO3z4FbKXMbMa5aAcgFzleGvykrtxgnSGC4yO6Uh6HD0
         FHeqyUPQYic/NOCimrO1lOkaqWZ/1ux0yitdhjPBZiLaI1u8M30I5Pw+8xWavjPFr3
         RQCwqcKfYabgkdiv2Wztl+5JsVuajSEsy7ToZbmtwStaKYjvsU1DxFIqSRn69jfRV9
         /WN0DKRegZiPA==
Received: by pali.im (Postfix)
        id 1D5D915B6; Sun,  8 Aug 2021 18:25:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 05/20] ntfs: Undeprecate iocharset= mount option
Date:   Sun,  8 Aug 2021 18:24:38 +0200
Message-Id: <20210808162453.1653-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other fs drivers are using iocharset= mount option for specifying charset.
So mark iocharset= mount option as preferred and deprecate nls= mount
option.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/ntfs/inode.c  |  2 +-
 fs/ntfs/super.c  | 13 ++++---------
 fs/ntfs/unistr.c |  3 ++-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4474adb393ca..3676f185b4a0 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2303,7 +2303,7 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_printf(sf, ",fmask=0%o", vol->fmask);
 		seq_printf(sf, ",dmask=0%o", vol->dmask);
 	}
-	seq_printf(sf, ",nls=%s", vol->nls_map->charset);
+	seq_printf(sf, ",iocharset=%s", vol->nls_map->charset);
 	if (NVolCaseSensitive(vol))
 		seq_printf(sf, ",case_sensitive");
 	if (NVolShowSystemFiles(vol))
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0d7e948cb29c..02de1aa05b7c 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -192,11 +192,6 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 			ntfs_warning(vol->sb, "Ignoring obsolete option %s.",
 					p);
 		else if (!strcmp(p, "nls") || !strcmp(p, "iocharset")) {
-			if (!strcmp(p, "iocharset"))
-				ntfs_warning(vol->sb, "Option iocharset is "
-						"deprecated. Please use "
-						"option nls=<charsetname> in "
-						"the future.");
 			if (!v || !*v)
 				goto needs_arg;
 use_utf8:
@@ -218,10 +213,10 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 		} else if (!strcmp(p, "utf8")) {
 			bool val = false;
 			ntfs_warning(vol->sb, "Option utf8 is no longer "
-				   "supported, using option nls=utf8. Please "
-				   "use option nls=utf8 in the future and "
-				   "make sure utf8 is compiled either as a "
-				   "module or into the kernel.");
+				   "supported, using option iocharset=utf8. "
+				   "Please use option iocharset=utf8 in the "
+				   "future and make sure utf8 is compiled "
+				   "either as a module or into the kernel.");
 			if (!v || !*v)
 				val = true;
 			else if (!simple_getbool(v, &val))
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index a6b6c64f14a9..75a7f73bccdd 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -372,7 +372,8 @@ retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 conversion_err:
 	ntfs_error(vol->sb, "Unicode name contains characters that cannot be "
 			"converted to character set %s.  You might want to "
-			"try to use the mount option nls=utf8.", nls->charset);
+			"try to use the mount option iocharset=utf8.",
+			nls->charset);
 	if (ns != *outs)
 		kfree(ns);
 	if (wc != -ENAMETOOLONG)
-- 
2.20.1

