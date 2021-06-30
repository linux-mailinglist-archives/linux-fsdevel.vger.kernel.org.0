Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537D3B86E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhF3QPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 12:15:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhF3QPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:15:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2B41FEC3;
        Wed, 30 Jun 2021 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625069603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yD2GvFI9lAZx9DdInSThCY/ul+clyC+0KRKni1cHlWA=;
        b=Me27T7a6xoz/jj9WqnSumHhFuJpl1ROn25cHtSDoNtywbWxsqA2DypAZeeViV8nyrFoysI
        abbHCKeoCj8wPOGamqC2JaCs66oMLbakVXubZHbRvP5kSGSog91/SDJBkkOeixfwPaYhry
        GntVryip8dHpaz02kVb7IgG2Fi4SwgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625069603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yD2GvFI9lAZx9DdInSThCY/ul+clyC+0KRKni1cHlWA=;
        b=OYrm06ORQcxM4t2nk4de0YvlMoiWAugiZnLsm1HcdEvmPkCF0W6YPkycxwYvtlXSShbUou
        grvscT7BsxjXyHDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7FE68118DD;
        Wed, 30 Jun 2021 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625069603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yD2GvFI9lAZx9DdInSThCY/ul+clyC+0KRKni1cHlWA=;
        b=Me27T7a6xoz/jj9WqnSumHhFuJpl1ROn25cHtSDoNtywbWxsqA2DypAZeeViV8nyrFoysI
        abbHCKeoCj8wPOGamqC2JaCs66oMLbakVXubZHbRvP5kSGSog91/SDJBkkOeixfwPaYhry
        GntVryip8dHpaz02kVb7IgG2Fi4SwgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625069603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yD2GvFI9lAZx9DdInSThCY/ul+clyC+0KRKni1cHlWA=;
        b=OYrm06ORQcxM4t2nk4de0YvlMoiWAugiZnLsm1HcdEvmPkCF0W6YPkycxwYvtlXSShbUou
        grvscT7BsxjXyHDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id S/2EHCKY3GCUXAAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Wed, 30 Jun 2021 16:13:22 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 9ff4b454;
        Wed, 30 Jun 2021 16:13:21 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Petr Vorel <pvorel@suse.cz>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v11] vfs: fix copy_file_range regression in cross-fs copies
Date:   Wed, 30 Jun 2021 17:13:20 +0100
Message-Id: <20210630161320.29006-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A regression has been reported by Nicolas Boichat, found while using the
copy_file_range syscall to copy a tracefs file.  Before commit
5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
kernel would return -EXDEV to userspace when trying to copy a file across
different filesystems.  After this commit, the syscall doesn't fail anymore
and instead returns zero (zero bytes copied), as this file's content is
generated on-the-fly and thus reports a size of zero.

This patch restores some cross-filesystem copy restrictions that existed
prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
devices").  Filesystems are still allowed to fall-back to the VFS
generic_copy_file_range() implementation, but that has now to be done
explicitly.

nfsd is also modified to fall-back into generic_copy_file_range() in case
vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.

Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
Reported-by: Nicolas Boichat <drinkcat@chromium.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Changes since v10
- simply remove the "if (len == 0)" short-circuit instead of checking if
  the filesystem implements the syscall.  This is because a filesystem may
  implement it but a particular instance (hint: overlayfs!) may not.
Changes since v9
- the early return from the syscall when len is zero now checks if the
  filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
  otherwise.  Issue reported by test robot.
  (obviously, dropped Amir's Reviewed-by and Olga's Tested-by tags)
Changes since v8
- Simply added Amir's Reviewed-by and Olga's Tested-by
Changes since v7
- set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so that the
  error returned is always related to the 'copy' operation
Changes since v6
- restored i_sb checks for the clone operation
Changes since v5
- check if ->copy_file_range is NULL before calling it
Changes since v4
- nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
  or -EXDEV.
Changes since v3
- dropped the COPY_FILE_SPLICE flag
- kept the f_op's checks early in generic_copy_file_checks, implementing
  Amir's suggestions
- modified nfsd to use generic_copy_file_range()
Changes since v2
- do all the required checks earlier, in generic_copy_file_checks(),
  adding new checks for ->remap_file_range
- new COPY_FILE_SPLICE flag
- don't remove filesystem's fallback to generic_copy_file_range()
- updated commit changelog (and subject)
Changes since v1 (after Amir review)
- restored do_copy_file_range() helper
- return -EOPNOTSUPP if fs doesn't implement CFR
- updated commit description

 fs/nfsd/vfs.c   |  8 +++++++-
 fs/read_write.c | 52 +++++++++++++++++++++++--------------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 15adf1f6ab21..f54a88b3b4a2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -569,6 +569,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
 ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
 			     u64 dst_pos, u64 count)
 {
+	ssize_t ret;
 
 	/*
 	 * Limit copy to 4MB to prevent indefinitely blocking an nfsd
@@ -579,7 +580,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
 	 * limit like this and pipeline multiple COPY requests.
 	 */
 	count = min_t(u64, count, 1 << 22);
-	return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
+	ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
+
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
+		ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
+					      count, 0);
+	return ret;
 }
 
 __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..049a2dda29f7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1395,28 +1395,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 }
 EXPORT_SYMBOL(generic_copy_file_range);
 
-static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
-				  struct file *file_out, loff_t pos_out,
-				  size_t len, unsigned int flags)
-{
-	/*
-	 * Although we now allow filesystems to handle cross sb copy, passing
-	 * a file of the wrong filesystem type to filesystem driver can result
-	 * in an attempt to dereference the wrong type of ->private_data, so
-	 * avoid doing that until we really have a good reason.  NFS defines
-	 * several different file_system_type structures, but they all end up
-	 * using the same ->copy_file_range() function pointer.
-	 */
-	if (file_out->f_op->copy_file_range &&
-	    file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
-		return file_out->f_op->copy_file_range(file_in, pos_in,
-						       file_out, pos_out,
-						       len, flags);
-
-	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				       flags);
-}
-
 /*
  * Performs necessary checks before doing a file copy
  *
@@ -1434,6 +1412,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	loff_t size_in;
 	int ret;
 
+	/*
+	 * Although we now allow filesystems to handle cross sb copy, passing
+	 * a file of the wrong filesystem type to filesystem driver can result
+	 * in an attempt to dereference the wrong type of ->private_data, so
+	 * avoid doing that until we really have a good reason.  NFS defines
+	 * several different file_system_type structures, but they all end up
+	 * using the same ->copy_file_range() function pointer.
+	 */
+	if (file_out->f_op->copy_file_range) {
+		if (file_in->f_op->copy_file_range !=
+		    file_out->f_op->copy_file_range)
+			return -EXDEV;
+	} else if (file_in->f_op->remap_file_range) {
+		if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+			return -EXDEV;
+	} else {
+                return -EOPNOTSUPP;
+	}
+
 	ret = generic_file_rw_checks(file_in, file_out);
 	if (ret)
 		return ret;
@@ -1497,11 +1494,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (unlikely(ret))
 		return ret;
 
-	if (len == 0)
-		return 0;
-
 	file_start_write(file_out);
 
+	ret = -EOPNOTSUPP;
 	/*
 	 * Try cloning first, this is supported by more file systems, and
 	 * more efficient if both clone and copy are supported (e.g. NFS).
@@ -1520,9 +1515,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		}
 	}
 
-	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				flags);
-	WARN_ON_ONCE(ret == -EOPNOTSUPP);
+	if (file_out->f_op->copy_file_range)
+		ret = file_out->f_op->copy_file_range(file_in, pos_in,
+						      file_out, pos_out,
+						      len, flags);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
