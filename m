Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA25E5F1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiIVJ4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiIVJ4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:56:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051FCD74FB;
        Thu, 22 Sep 2022 02:55:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c11so14588836wrp.11;
        Thu, 22 Sep 2022 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3KZuhIbDsTmS90rWhTQ5Pzbw5OkmbaOMfSrIrIm8xy4=;
        b=ReyEEc6cyNQu9PfbZH6KMcAsTWJaHLFwoUH7J4nSuug2svcotV24dTuvsbkRXHCGnG
         Cr2k4IB1E3lLATq8zLVo3N2TE6V/bWRmggIIyJGUzV+9//5wkBmdlvnHD34JwyxsIX0U
         h4OCXgVefr6e3LwAYDKfnqYPnsFNjwoRuWeCfZH8yuVGVq989l5PrX9dNAPoE70sSw1t
         C/DuJtpWBDwZ1ZmhD+cPJ7Tkpwc9pDvTd3CHd0lWxtxUg+9kIBQOOd3j1BaeYa+VcdDr
         irQzkv3xWJEqF/aa+UU6A3hyVZGx2s1YJ1K6K8CfK+EOqDu7ukiWiPweTMoOUfaNH9V6
         mCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3KZuhIbDsTmS90rWhTQ5Pzbw5OkmbaOMfSrIrIm8xy4=;
        b=wKmgZwpoRYysyopUEAad4omexoSB7XKCAOMcK1kMks/ShkOd/o2v181afp79SBFU96
         +2OszTY+Pxzt2V8r/tTDUVnyFDn5q4yfQFk9rf8kaMupruFwFl1/dlYSy4+5NAi2YXVi
         feUVA9BPLTrG+AYRw6PTEhxSTPKid3kVxcaoQAsIMe/xHwJYOjnx43N3doCrI6PgKGR3
         6MowpX+/fVUFwrZNaYjDGgTGkVG9xOVOer84dWGK2c1p0QCDEVcF2Fbm5zbQuQae2wqd
         prUAVCtOZTgMjwISdctNpcA5Izaw0T3W64tBJ4ZYHYARwCHhTieI4qFizuCf1BT3c6Qw
         tNug==
X-Gm-Message-State: ACrzQf1/iG+ri6RrHojl72sEQyNgWadzLDMsTLyDxYewzYxBIfvLt21+
        5AKMAz8DyF8BcCa1FubczJeFl4HsyiI=
X-Google-Smtp-Source: AMsMyM6t9YZr1ElRNqIU022/2zzUvuGs7SgaV8WTbISA8nIGuvQffKhrMB8GRUpi3kB5eZlw6avjfA==
X-Received: by 2002:a05:6000:1447:b0:22a:ea42:29f7 with SMTP id v7-20020a056000144700b0022aea4229f7mr1539727wrx.38.1663840519700;
        Thu, 22 Sep 2022 02:55:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id r125-20020a1c2b83000000b003a541d893desm5583233wmr.38.2022.09.22.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:55:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfs: take shared inode lock on single page buffered writes
Date:   Thu, 22 Sep 2022 12:55:14 +0300
Message-Id: <20220922095514.79607-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike many other Linux filesystems, xfs takes a shared inode lock on
buffered reads and exclusive inode lock on buffered writes to guarantee
that buffered writes are atomic w.r.t. buffered reads.

ext4 for example, takes an exclusive inode lock on buffered writes, but
does not take an inode lock on buffered reads.

This difference in behavior is attributed to legacy xfs code that pre
dates Linux.

The contention on inode lock in a concurrent mixed randrw workload
causes severe performance degradation in xfs compared to ext4.

When write range is within the bounds of a single page, the page
lock guarantees that the write is atomic w.r.t buffered reads.
In that case, take shared inode lock on write to avoid the unneeded
contention in case of a randrw workload using 4K IO buffer size.

This optimization could be extended to slightly larger IO buffer size
that falls within the bounds of a single folio, by limiting iomap to map
a single folio and if that fails, fall back to exclusive inode lock.

The performance improvment was demonstrated by running the following
fio workload on a e2-standard-8 GCE machine:

[global]
filename=testfile.fio
norandommap
randrepeat=0
size=5G
bs=4K
ioengine=psync
numjobs=8
group_reporting=1
direct=0
fallocate=1
end_fsync=0
runtime=60
[read]
readwrite=randread
[write]
readwrite=randwrite

The numbers in the table below represent the range of results in
different test runs per tested filesystem.
Each test was run on a freshly formatted fs with single test file with
written extents and cold caches.

     FS:   ext4               xfs                  xfs+ (this path)
   READ:   136MB/s-210MB/s     2.7MB/s-6.3MB/s     747MB/s-771MB/s
  WRITE:   227MB/s-248MB/s    86.3MB/s-171MB/s     973MB/s-1050MB/s

Needless to say, xfs performance on the same workload with 8K IO buffer
size is not improved by this patch and are just as bad as 4K IO buffer
without the patch.

Suggested-by: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-xfs/20220920022439.GP3600936@dread.disaster.area/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Dave and Darrick,

Following the discussions on my previous patch [1]
("xfs: reduce ilock contention on buffered randrw workload")

Here is a patch that optimizes the low hanging case of single page.
As you can see in the commit message, the optimization fixes the
performance of 4K IO workload.

I verified no regrerssions with -g quick on default 4K block config and
started running -g auto on all kdevop configs including 1K block configs.

Regarding the followup higher order folio optimizations, please let
me know if you intend to work on the large folio mapping iomap write
code or if you prefer to guide me to do that work.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/20220920022439.GP3600936@dread.disaster.area/

 fs/xfs/xfs_file.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c6c80265c0b2..3c17f2461ec2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -703,12 +703,29 @@ xfs_file_buffered_write(
 {
 	struct inode		*inode = iocb->ki_filp->f_mapping->host;
 	struct xfs_inode	*ip = XFS_I(inode);
-	ssize_t			ret;
+	ssize_t			ret = 0;
+	off_t			end_pos = iocb->ki_pos + iov_iter_count(from);
 	bool			cleared_space = false;
 	unsigned int		iolock;
 
 write_retry:
 	iolock = XFS_IOLOCK_EXCL;
+	/*
+	 * When write range is within the bounds of a single page, the page
+	 * lock guarantees that the write is atomic w.r.t buffered reads.
+	 * In that case, take shared iolock to avoid contention on iolock in
+	 * concurrent mixed read-write workloads.
+	 *
+	 * Write retry after space cleanup is not interesting to optimize,
+	 * so don't bother optimizing this case.
+	 *
+	 * TODO: Expand this optimization to write range that may fall within
+	 * the bounds of a single folio, ask iomap to try to write into a single
+	 * folio and if that fails, write_retry with exclusive iolock.
+	 */
+	if (!ret && iocb->ki_pos >> PAGE_SHIFT == (end_pos - 1) >> PAGE_SHIFT)
+		iolock = XFS_IOLOCK_SHARED;
+
 	ret = xfs_ilock_iocb(iocb, iolock);
 	if (ret)
 		return ret;
@@ -740,6 +757,7 @@ xfs_file_buffered_write(
 		xfs_iunlock(ip, iolock);
 		xfs_blockgc_free_quota(ip, XFS_ICWALK_FLAG_SYNC);
 		cleared_space = true;
+		ret = -EAGAIN;
 		goto write_retry;
 	} else if (ret == -ENOSPC && !cleared_space) {
 		struct xfs_icwalk	icw = {0};
@@ -750,6 +768,7 @@ xfs_file_buffered_write(
 		xfs_iunlock(ip, iolock);
 		icw.icw_flags = XFS_ICWALK_FLAG_SYNC;
 		xfs_blockgc_free_space(ip->i_mount, &icw);
+		ret = -EAGAIN;
 		goto write_retry;
 	}
 
-- 
2.25.1

