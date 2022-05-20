Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3252E72F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346904AbiETIVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346984AbiETIVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 04:21:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6497C192BF;
        Fri, 20 May 2022 01:21:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h14so10456688wrc.6;
        Fri, 20 May 2022 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeqVgPhrJ3rmGWv1yv76yF8UJMTl9EbNypZJm0t70ro=;
        b=duDNCpwq/jDOGw7ZU2fo6D88Uy5IK644FWxgtW0soJfzQ8JejPO2zERKRW7jmFsiDT
         0Q5ZEQGmxslulxOrT+Gi+H5BEGMOCg12HZf3jdHcDZL372VHci29lA5uZySX8pO1ZuBe
         9uO2SUv2eLdePUzaJn6lapNeRaFjNHQrCIM0Ef/3YafGsw74PNBWqKFRcW78KnJb0xaO
         qvBncqlvE/p03NNegY3ts/TYjiEEIy7Y0kyNSQw1Mnr2/vXsGaE/ct6bRIhpU2UgLYAg
         1/t6TNUlI0Y4AUf1HOk8jUCo1aqIdBSniT70tZ4PXnAd5x3UsfItaBQjKvZbA2vkdKm5
         If+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeqVgPhrJ3rmGWv1yv76yF8UJMTl9EbNypZJm0t70ro=;
        b=8Gzr7GLlym8a3+j+EAUYcbq+cJBzNrhE2ycmxrg1KGVMgaMmIhv8QedSM/wO20GatT
         VGELbpFYN559cedUChMrLD8f6U5ybOO+T4mOXAe10Z83QiSs9FpkBphLHyW8OUOtKlV7
         /1Y8YuwSXIkARVVox+oVCPYOWuD1ZM4gwSneDsSfTYSVddW6J867q2s64xkPu+8Yy6iE
         vioUQWXjW2EFTh8qhhU4+oPv1VowL/m9J7qRHLVn0zdZC5Yplkl5MA3NTxO6JCpiJiQi
         nnZz01IqNGw6/CYgEOa0irEVdL6CsMcX8eqZHmpkXJylbIVJUpd5xMp11NpQMwaqHcNy
         072g==
X-Gm-Message-State: AOAM530dgrGdXVZvLXuRTV6RfCuNUWWobA9s9FHjItszgjMsrZFN0Y61
        xjHDGGo7aA2zUecMAQUtSVCyCs8WTHw=
X-Google-Smtp-Source: ABdhPJwKONGpk7cAoGcHigjvYAVnU/4faMPsryYreqrLiJN++Qxg3TScAPJtJPEUxChtsS1eQbe1eA==
X-Received: by 2002:a05:6000:16c9:b0:20f:2668:3edc with SMTP id h9-20020a05600016c900b0020f26683edcmr1191152wrf.712.1653034878761;
        Fri, 20 May 2022 01:21:18 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([77.137.79.96])
        by smtp.gmail.com with ESMTPSA id n9-20020adf8b09000000b0020d0931b48asm1822351wra.37.2022.05.20.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:21:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        He Zhe <zhe.he@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v13] vfs: fix copy_file_range regression in cross-fs copies
Date:   Fri, 20 May 2022 11:21:11 +0300
Message-Id: <20220520082111.2066400-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.de>

A regression has been reported by Nicolas Boichat, found while using the
copy_file_range syscall to copy a tracefs file.  Before commit
5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
kernel would return -EXDEV to userspace when trying to copy a file across
different filesystems.  After this commit, the syscall doesn't fail anymore
and instead returns zero (zero bytes copied), as this file's content is
generated on-the-fly and thus reports a size of zero.

Another regression has been reported by He Zhe and Paul Gortmaker -
WARN_ON_ONCE(ret == -EOPNOTSUPP) can be triggered from userspace when
copying from a sysfs file whose read operation may return -EOPNOTSUPP:

  xfs_io -f -c "copy_range /sys/class/net/lo/phys_switch_id" /tmp/foo

Since we do not have test coverage for copy_file_range() between any
two types of filesystems, the best way to avoid with this sort of issues
in the future is for the kernel to be more picky about filesystems that
are allowed to do copy_file_range().

This patch restores some cross-filesystem copy restrictions that existed
prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
devices").

Filesystems that implement copy_file_range() or remap_file_range() may
still fall-back to the generic_copy_file_range() implementation when the
filesystem cannot handle the copy, so kernel can maintain a consistent
story about which filesystems support copy_file_range().
That will allow userspace tools to make consistent desicions w.r.t using
copy_file_range().

nfsd is also modified to fall-back into generic_copy_file_range() in case
vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.

Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
Link: https://lore.kernel.org/linux-fsdevel/20210630161320.29006-1-lhenriques@suse.de/
Reported-by: Nicolas Boichat <drinkcat@chromium.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
Fixes: 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
Link: https://lore.kernel.org/linux-fsdevel/20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com/
Reported-by: He Zhe <zhe.he@windriver.com>
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Al,

Please take this patch to fix several issues that started to pop up
as userspace tools started using copy_file_range(), which could only
get more popular in the future.

I've decides to pick this up from Luis' v12 last year [1] following
some recent bug report. Although Luis' patch was reviewed by me back
then and tested by Olga on nfs, I tested it now and found that it
regressed fstests on xfs,btrfs, so decided on a slightly differnt logic.

The rationale behind my change is that given src fs and dst fs, the
outcomes of EOPNOTSUPP and EXDEV are consistent, while keeping the
fs that may return success from this syscall to a minimum.

I've tested this with the -g copy_range tests from fstests on
ext4,xfs,btrfs,nfs,overlayfs (over xfs).

For ext4, all tests are skipping as expected.
For xfs,btrfs (support clone) the cross-fs copy test (genric/565)
is skipped.
For nfs,overlayfs the tests pass including the cross-fs copy test.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxh6PegaOtMXQ9WmU=05bhQfYTeweGjFWR7T+XVAbuR09A@mail.gmail.com/

 fs/nfsd/vfs.c   |  8 ++++-
 fs/read_write.c | 79 +++++++++++++++++++++++++++----------------------
 2 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c22ad0532e8e..74f7fef48504 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -577,6 +577,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
 			     u64 dst_pos, u64 count)
 {
+	ssize_t ret;
 
 	/*
 	 * Limit copy to 4MB to prevent indefinitely blocking an nfsd
@@ -587,7 +588,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
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
index e643aec2b0ef..a8f12e91762f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1381,28 +1381,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
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
@@ -1424,6 +1402,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	if (ret)
 		return ret;
 
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
 	/* Don't touch certain kinds of inodes */
 	if (IS_IMMUTABLE(inode_out))
 		return -EPERM;
@@ -1489,26 +1486,36 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	file_start_write(file_out);
 
 	/*
-	 * Try cloning first, this is supported by more file systems, and
-	 * more efficient if both clone and copy are supported (e.g. NFS).
+	 * Cloning is supported by more file systems, so we implement copy on
+	 * same sb using clone, but for filesystems were both clone and copy
+	 * are supported (e.g. NFS), we only call the copy method.
 	 */
-	if (file_in->f_op->remap_file_range &&
-	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
-		loff_t cloned;
-
-		cloned = file_in->f_op->remap_file_range(file_in, pos_in,
+	if (file_out->f_op->copy_file_range) {
+		ret = file_out->f_op->copy_file_range(file_in, pos_in,
+						      file_out, pos_out,
+						      len, flags);
+	} else if (file_in->f_op->remap_file_range &&
+		   file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
+		ret = file_in->f_op->remap_file_range(file_in, pos_in,
 				file_out, pos_out,
 				min_t(loff_t, MAX_RW_COUNT, len),
 				REMAP_FILE_CAN_SHORTEN);
-		if (cloned > 0) {
-			ret = cloned;
-			goto done;
-		}
 	}
 
-	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				flags);
-	WARN_ON_ONCE(ret == -EOPNOTSUPP);
+	if (ret > 0)
+		goto done;
+
+	/*
+	 * We can get here if filesystem supports clone but rejected the clone
+	 * request (e.g. because it was not block aligned).
+	 * In that case, fall back to kernel copy so we are able to maintain a
+	 * consistent story about which filesystems support copy_file_range()
+	 * and which filesystems do not, that will allow userspace tools to
+	 * make consistent desicions w.r.t using copy_file_range().
+	 */
+	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+				      flags);
+
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
-- 
2.25.1

