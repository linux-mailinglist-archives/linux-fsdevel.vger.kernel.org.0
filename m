Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03D210F746
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLCF32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:29:28 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34779 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfLCF31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:29:27 -0500
Received: by mail-pg1-f201.google.com with SMTP id w9so1126547pgl.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/PZuvjxFpiHxBxqmZZS2DIf/mUXIgszqKKP6+YA75fE=;
        b=bw01QGxc7pcn2yVbZZ0nqE3Fu2jYn4PGVSSJmBvOGf4dmVs6bo+m30ngfK65tAsOci
         xUpbZVzDLxL5Gx1P9zYhE+m3v5NrIXI7Rpwec4vEsGZoPHmPcIPzQEfVQhYa12Q7hrBB
         ZzJCTfWgZ4AdOPAPq3Xiuy7UA0t+keaUNCFHCOKcC9h8s5HnpU8eCeUFxA8LiCGRwGI4
         c0MiTsILl1t2fpJZunCbbpOR9s/dRWf/7VOxqr4dOppMgvH3YfLpkSBRc/Z2dE7t8Zir
         46eMo+ASXZsM2hHpGJNFp7sNK03eyApp2IEAMEbhroxY1hAjVMWpiSbJDP1Np9sCtTUh
         q/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/PZuvjxFpiHxBxqmZZS2DIf/mUXIgszqKKP6+YA75fE=;
        b=EnKijVkaz4mmkDIkwLzXCNimue737O3D3p+jEncLl4wGT74odvKuqc4A4OguqTQRgO
         yA0J5NwNwnZUcfTuoaIPmDARp0R5zffsQ+YSZ8mgDDX8hcFunAAxK90o5WJz5jKVJvU6
         0Wh4CMr93bRPgJGKrynvsTnlLtCNkKHZbRLDaBOWO7OrApy67J3K2ws4401ANDSIJ/MK
         vjuHW8Qid45fpsIhoUYryZfeIJDPYrQqknNOM0bUp8OEPWZ9/aFVDhTE9teQauueFZhO
         mn+AgRnxrk7ZEMdKu1xW3GE+LW2r2wNbfG7a4GfbYXCPgHB8zAhOoAtQtHRHvjRHGvW9
         +GOA==
X-Gm-Message-State: APjAAAWypYr5I7WYIrdkE5YmA1okdgIaizA4O66ozJKOw4Ud3AI0lNlo
        cXIqtzdIGv6mev93nJaP2m2rvtf15uc=
X-Google-Smtp-Source: APXvYqz1gFG/vtMpjY11UukOuaOFnKrrhGKaaW/tl7gK2jtu7Vgr7WnCmYQnIp+P3p+o0bam49oMiK/5nHg=
X-Received: by 2002:a65:56c9:: with SMTP id w9mr3374564pgs.296.1575350967131;
 Mon, 02 Dec 2019 21:29:27 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:29:23 -0800
Message-Id: <20191203052923.65477-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] tune2fs: Support casefolded encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows enabling casefold and encryption at the same
time. Fsck still needs to be adjusted to deal wtih this.

Change-Id: Ic9ed63180ef28c36e083cee85ade432e4bfcc654
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 misc/mke2fs.c  |  9 ---------
 misc/tune2fs.c | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index da29ab39..879e3914 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2460,15 +2460,6 @@ profile_error:
 		}
 	}
 
-	if (ext2fs_has_feature_casefold(&fs_param) &&
-	    ext2fs_has_feature_encrypt(&fs_param)) {
-		com_err(program_name, 0, "%s",
-			_("The encrypt and casefold features are not "
-			  "compatible.\nThey can not be both enabled "
-			  "simultaneously.\n"));
-		      exit (1);
-	}
-
 	/* Don't allow user to set both metadata_csum and uninit_bg bits. */
 	if (ext2fs_has_feature_metadata_csum(&fs_param) &&
 	    ext2fs_has_feature_gdt_csum(&fs_param))
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index c31c9a7c..b19ee5ca 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -101,6 +101,8 @@ static int rewrite_checksums;
 static int feature_64bit;
 static int fsck_requested;
 static char *undo_file;
+static int encoding = 0;
+static char encoding_flags = 0;
 
 int journal_size, journal_flags;
 char *journal_device;
@@ -160,7 +162,8 @@ static __u32 ok_features[3] = {
 		EXT4_FEATURE_INCOMPAT_64BIT |
 		EXT4_FEATURE_INCOMPAT_ENCRYPT |
 		EXT4_FEATURE_INCOMPAT_CSUM_SEED |
-		EXT4_FEATURE_INCOMPAT_LARGEDIR,
+		EXT4_FEATURE_INCOMPAT_LARGEDIR |
+		EXT4_FEATURE_INCOMPAT_CASEFOLD,
 	/* R/O compat */
 	EXT2_FEATURE_RO_COMPAT_LARGE_FILE |
 		EXT4_FEATURE_RO_COMPAT_HUGE_FILE|
@@ -1403,12 +1406,6 @@ mmp_error:
 	}
 
 	if (FEATURE_ON(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_ENCRYPT)) {
-		if (ext2fs_has_feature_casefold(sb)) {
-			fputs(_("Cannot enable encrypt feature on filesystems "
-				"with the encoding feature enabled.\n"),
-			      stderr);
-			return 1;
-		}
 		fs->super->s_encrypt_algos[0] =
 			EXT4_ENCRYPTION_MODE_AES_256_XTS;
 		fs->super->s_encrypt_algos[1] =
@@ -2146,6 +2143,24 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				continue;
 			}
 			ext_mount_opts = strdup(arg);
+		} else if (!strcmp(token, "encoding")) {
+			if (!arg) {
+				r_usage++;
+				continue;
+			}
+
+			encoding = e2p_str2encoding(arg);
+			if (encoding < 0) {
+				fprintf(stderr, _("Invalid encoding: %s"), arg);
+				r_usage++;
+				continue;
+			}
+		} else if (!strcmp(token, "encoding_flags")) {
+			if (!arg) {
+				r_usage++;
+				continue;
+			}
+			encoding_flags = *arg;
 		} else
 			r_usage++;
 	}
@@ -3325,6 +3340,14 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		       ext_mount_opts);
 		free(ext_mount_opts);
 	}
+	if (encoding > 0) {
+		sb->s_encoding = encoding;
+		ext2fs_mark_super_dirty(fs);
+	}
+	if (encoding_flags) {
+		sb->s_encoding_flags = encoding_flags;
+		ext2fs_mark_super_dirty(fs);
+	}
 
 	free(device_name);
 	remove_error_table(&et_ext2_error_table);
-- 
2.24.0.393.g34dc348eaf-goog

