Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E03656337
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiLZOWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLZOWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79022616;
        Mon, 26 Dec 2022 06:22:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ED78B80D3B;
        Mon, 26 Dec 2022 14:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005B0C433F2;
        Mon, 26 Dec 2022 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064524;
        bh=ZrKrntGH0WofuwsAtdP0jIQ8uCLZbrmm0J3jNna5drc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FW4Apmw9ZjRYOfjahl9pzNoc+QFOhJinA5x6Ij2t0JIhlYF/TlSqgb9XIBbyK9Tdz
         iw/0yyFmCyK6zTIP/BUuPm8egQPs30Yxse+X9XZ+HEjgaVGlaiHeGqQEolsQiQcFXU
         wdmU+RkiyVzZ9Mi52Y5raowONK2gp3utyAAoTRhHkfTIK6EaV+ngVjqK6mmgke/I7W
         k7VtigVCtMeCrXr/hNlYwovyQDcXLhkaReHuVQorcboQsAN68VYK6yme+Sqwwi8/0a
         jy8NTat8PJ5NQz8W05JfMewVtsNT93b1P8QCB9bqNJROsDDLqVVsmCJ0mZ4qCpCVMO
         duGDzzDCik72w==
Received: by pali.im (Postfix)
        id AD3BB9D7; Mon, 26 Dec 2022 15:22:03 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 03/18] ntfs: Undeprecate iocharset= mount option
Date:   Mon, 26 Dec 2022 15:21:35 +0100
Message-Id: <20221226142150.13324-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other fs drivers are using iocharset= mount option for specifying charset.
So mark iocharset= mount option as preferred and deprecate nls= mount
option.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/filesystems/ntfs.rst |  5 ++---
 fs/ntfs/inode.c                    |  2 +-
 fs/ntfs/super.c                    | 13 ++++---------
 fs/ntfs/unistr.c                   |  3 ++-
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/ntfs.rst b/Documentation/filesystems/ntfs.rst
index 5bb093a26485..51784141b56a 100644
--- a/Documentation/filesystems/ntfs.rst
+++ b/Documentation/filesystems/ntfs.rst
@@ -109,10 +109,9 @@ mount command (man 8 mount, also see man 5 fstab), the NTFS driver supports the
 following mount options:
 
 ======================= =======================================================
-iocharset=name		Deprecated option.  Still supported but please use
-			nls=name in the future.  See description for nls=name.
+nls=name		Alias for ``iocharset=`` mount option.
 
-nls=name		Character set to use when returning file names.
+iocharset=name		Character set to use when returning file names.
 			Unlike VFAT, NTFS suppresses names that contain
 			unconvertible characters.  Note that most character
 			sets contain insufficient characters to represent all
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 08c659332e26..2ab071c4560d 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2314,7 +2314,7 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_printf(sf, ",fmask=0%o", vol->fmask);
 		seq_printf(sf, ",dmask=0%o", vol->dmask);
 	}
-	seq_printf(sf, ",nls=%s", vol->nls_map->charset);
+	seq_printf(sf, ",iocharset=%s", vol->nls_map->charset);
 	if (NVolCaseSensitive(vol))
 		seq_printf(sf, ",case_sensitive");
 	if (NVolShowSystemFiles(vol))
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 001f4e053c85..55762abdc22a 100644
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

