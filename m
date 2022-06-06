Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8394D53EC8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiFFNqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 09:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiFFNqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:46:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7C24706F;
        Mon,  6 Jun 2022 06:46:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d14so10939240wra.10;
        Mon, 06 Jun 2022 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYFeSPHXfcNqBAugUWJ8cxyvZbQPdZtQ4kdbRs+T5T4=;
        b=bVuJzNhsb7K1SKO5jFAgB6qwoAcfbwFygZq4kMNZ7V0MZNHjKytL3x+ezsHlNjufPW
         vCrrSm2M4MCvXhsMDJ/8X/BfXKABKQEYbj0TD9z2ZITgZgOlAKcYA/wWoeCg80pKrpo4
         gib/KjWin5UJxFTTqhqPhjTsCA9pFjjyFk5uHFjMsjDf9uP5DQ9gYLxqd99ZDyIHDm1K
         ZTL171VsDR5er4r472Qf96s4VBC8fCBbDJIstUI0k6QrWjfuWdxYyUypxBrOxhIQqjHn
         FTaapIcysOVUIbfX6z3IANpsBJHEYISRQaFgruyBu6UccEOK+tQP9HZQUnpuA1i31+5A
         r3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYFeSPHXfcNqBAugUWJ8cxyvZbQPdZtQ4kdbRs+T5T4=;
        b=di5/huVRluF9XOe/fNd6skLgNGDuBgpFB1b5ioJwkGOx7qhvSEN4/1dkFmfkqGacrN
         4/KPCNcyxuvVB7XoAwtN6A554UxQvONwHvHgP5NYeRu+w8CaiTjCvUIX/HDFp20sBjP2
         rf8Q3euAnD51tpjiy6SNFgnNXmWDtX7Jdbg/3hIOzZDAFRUzDy1g9JyTjoEVkWQRoZ0F
         c30g6nV7AUD/tDu9Xyaf1G9BfqV6nTgr5+Z8b227NPHhcPvC6tykllnvL7CSXGa88fTv
         jGtS+krt7NAb8GPXwOFYQ8skgHvCxYdimY4mpCDDLTaxQlZ0hGEK3d8NmijxWtdqZtV1
         7bzA==
X-Gm-Message-State: AOAM530PWsMBHg/HcFu6rhoZ/xvf1f/nQ+jrd1wB/JgLxM/WWIgoM0ma
        m98O7SL9y2wIrmlxOyABiVM=
X-Google-Smtp-Source: ABdhPJw6wENLrWuk1u9L6GiSGtrIjIrkKEsEGLshpAVfDp+pW2v+dHY8zk/pCbnWZDZZ9xGZtN1RcA==
X-Received: by 2002:adf:e792:0:b0:214:b7a8:62c9 with SMTP id n18-20020adfe792000000b00214b7a862c9mr15710552wrm.523.1654523173434;
        Mon, 06 Jun 2022 06:46:13 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b0039aef592ca0sm17294332wmk.35.2022.06.06.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:46:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Steve French <smfrench@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        He Zhe <zhe.he@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Luis Henriques <lhenriques@suse.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v14] vfs: fix copy_file_range() regression in cross-fs copies
Date:   Mon,  6 Jun 2022 16:46:08 +0300
Message-Id: <20220606134608.684131-1-amir73il@gmail.com>
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

Another regression has been reported by He Zhe - the assertion of
WARN_ON_ONCE(ret == -EOPNOTSUPP) can be triggered from userspace when
copying from a sysfs file whose read operation may return -EOPNOTSUPP.

Since we do not have test coverage for copy_file_range() between any
two types of filesystems, the best way to avoid these sort of issues
in the future is for the kernel to be more picky about filesystems that
are allowed to do copy_file_range().

This patch restores some cross-filesystem copy restrictions that existed
prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
devices"), namely, cross-sb copy is not allowed for filesystems that do
not implement ->copy_file_range().

Filesystems that do implement ->copy_file_range() have full control of
the result - if this method returns an error, the error is returned to
the user.  Before this change this was only true for fs that did not
implement the ->remap_file_range() operation (i.e. nfsv3).

Filesystems that implement only ->remap_file_range() (i.e. xfs) may still
fall-back to the generic_copy_file_range() implementation when the copy
is within the same sb, but filesystem cannot handle the reuqested copied
range.  This helps the kernel can maintain a more consistent story about
which filesystems support copy_file_range().

nfsd and ksmbd servers are modified to fall-back to the
generic_copy_file_range() implementation in case vfs_copy_file_range()
fails with -EOPNOTSUPP or -EXDEV, which preserves behavior of
server-side-copy.

fall-back to generic_copy_file_range() is not implemented for the smb
operation FSCTL_DUPLICATE_EXTENTS_TO_FILE, which is arguably a correct
change of behavior.

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
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Steve, Namje,

I was going to ping Al about this patch when I remembered that we have
another kernel file server that supports server side copy and needs to
be adjusted. I also realized that v13 wrongly (?) falls back to
generic_copy_file_range() in nfs/smb client code.

It would be great if you could review my ksmbd change and run the fstests
as below in your test setup.

I tested knfsd with kvm-xfstests:
$ kvm-xfstests -c nfs -g copy_range
...
nfs/loopback: 11 tests, 2 skipped, 28 seconds
  generic/430  Pass     3s
  generic/431  Pass     4s
  generic/432  Pass     3s
  generic/433  Pass     4s
  generic/434  Pass     3s
  generic/553  Skipped  1s
  generic/564  Pass     3s
  generic/565  Pass     4s
  generic/629  Skipped  1s
Totals: 9 tests, 2 skipped, 0 failures, 0 errors, 26s

These tests were run when local server fs is ext4 (no clone support)
and when local server fs is xfs (clone support, but not cross-sb clone),
which is relevant for cross-fs copy test generic/565.

It would be great if someone could add smb config support to kvm-xfstests
following the existing nfs/loopback config as reference.

I rather make this change to copy_file_range() syscall and nfsd/ksmbd
with a single patch, so I will be waiting for your review/test.

Olga,

It would be great if you can verify my test results and also test this
patch with nfsd server-side-copy across different combination of exported
fs. It would also be great if you can ack that the behavior change of
"no fall back to generic_copy_file_range() in nfs42 client" is desired.

Luis,

I did not added your Tested-by and RVB from v13, because the patch had
changed. Note that you are still the author of the patch, as I felt there
is still more code in the patch from v12 than code that I have changed.
If you would like me to change that let me know.

Thanks,
Amir.

Changes since v13 [1]:
- Rebased and tested over 5.19-rc1
- Never fallback from ->copy_file_range() to generic_copy_file_range()
- Added fallback to generic_copy_file_range() in ksmbd
- Typo fixes in commit message and comments

[1] https://lore.kernel.org/linux-fsdevel/20220520082111.2066400-1-amir73il@gmail.com/

 fs/ksmbd/smb2pdu.c | 16 ++++++++--
 fs/ksmbd/vfs.c     |  4 +++
 fs/nfsd/vfs.c      |  8 ++++-
 fs/read_write.c    | 77 ++++++++++++++++++++++++++--------------------
 4 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index e6f4ccc12f49..17f42f5b02fe 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7806,14 +7806,24 @@ int smb2_ioctl(struct ksmbd_work *work)
 		src_off = le64_to_cpu(dup_ext->SourceFileOffset);
 		dst_off = le64_to_cpu(dup_ext->TargetFileOffset);
 		length = le64_to_cpu(dup_ext->ByteCount);
-		cloned = vfs_clone_file_range(fp_in->filp, src_off, fp_out->filp,
-					      dst_off, length, 0);
+		/*
+		 * XXX: It is not clear if FSCTL_DUPLICATE_EXTENTS_TO_FILE
+		 * should fall back to vfs_copy_file_range().  This could be
+		 * beneficial when re-exporting nfs/smb mount, but note that
+		 * this can result in partial copy that returns an error status.
+		 * If/when FSCTL_DUPLICATE_EXTENTS_TO_FILE_EX is implemented,
+		 * fall back to vfs_copy_file_range(), should be avoided when
+		 * the flag DUPLICATE_EXTENTS_DATA_EX_SOURCE_ATOMIC is set.
+		 */
+		cloned = vfs_clone_file_range(fp_in->filp, src_off,
+					      fp_out->filp, dst_off, length, 0);
 		if (cloned == -EXDEV || cloned == -EOPNOTSUPP) {
 			ret = -EOPNOTSUPP;
 			goto dup_ext_out;
 		} else if (cloned != length) {
 			cloned = vfs_copy_file_range(fp_in->filp, src_off,
-						     fp_out->filp, dst_off, length, 0);
+						     fp_out->filp, dst_off,
+						     length, 0);
 			if (cloned != length) {
 				if (cloned < 0)
 					ret = cloned;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index dcdd07c6efff..8d57347231ce 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1777,6 +1777,10 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 
 		ret = vfs_copy_file_range(src_fp->filp, src_off,
 					  dst_fp->filp, dst_off, len, 0);
+		if (ret == -EOPNOTSUPP || ret == -EXDEV)
+			ret = generic_copy_file_range(src_fp->filp, src_off,
+						      dst_fp->filp, dst_off,
+						      len, 0);
 		if (ret < 0)
 			return ret;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 840e3af63a6f..b764213bcc55 100644
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
index b1b1cdfee9d3..f7bcca1bf0e2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1397,28 +1397,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
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
@@ -1440,6 +1418,27 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	if (ret)
 		return ret;
 
+	/*
+	 * Although we now allow filesystems to handle cross sb copy, passing
+	 * a file of the wrong filesystem type to filesystem driver can result
+	 * in an attempt to dereference the wrong type of ->private_data, so
+	 * avoid doing that until we really have a good reason.
+	 *
+	 * nfs and cifs define several different file_system_type structures
+	 * and several different sets of file_operations, but they all end up
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
@@ -1505,26 +1504,38 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	file_start_write(file_out);
 
 	/*
-	 * Try cloning first, this is supported by more file systems, and
-	 * more efficient if both clone and copy are supported (e.g. NFS).
+	 * Cloning is supported by more file systems, so we implement copy on
+	 * same sb using clone, but for filesystems where both clone and copy
+	 * are supported (e.g. nfs,cifs), we only call the copy method.
 	 */
+	if (file_out->f_op->copy_file_range) {
+		ret = file_out->f_op->copy_file_range(file_in, pos_in,
+						      file_out, pos_out,
+						      len, flags);
+		goto done;
+	}
+
 	if (file_in->f_op->remap_file_range &&
 	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
-		loff_t cloned;
-
-		cloned = file_in->f_op->remap_file_range(file_in, pos_in,
+		ret = file_in->f_op->remap_file_range(file_in, pos_in,
 				file_out, pos_out,
 				min_t(loff_t, MAX_RW_COUNT, len),
 				REMAP_FILE_CAN_SHORTEN);
-		if (cloned > 0) {
-			ret = cloned;
+		if (ret > 0)
 			goto done;
-		}
 	}
 
-	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				flags);
-	WARN_ON_ONCE(ret == -EOPNOTSUPP);
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

