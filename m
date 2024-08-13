Return-Path: <linux-fsdevel+bounces-25813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DB950C1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B241C2287A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140101A38DB;
	Tue, 13 Aug 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLkYdW1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77643155;
	Tue, 13 Aug 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573270; cv=none; b=NRFHveptH2ZlcoPZeR5LgxD5bU4ymj9LywALy3s3eBOyRjFgCPDni/HXZ04cpPdk9CYVQNnCCCw95Vli2NXTjOAtZ6HBnxXzaJsX/H+bFe5aonvHBn4wL45KSIzpMrxywjkIdKHbVKGPB33Yh/gDXELQ06F4uM+qLCxxNfi8who=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573270; c=relaxed/simple;
	bh=0FfawM6Ws50nNU2tSSGn+8MK81B8Z4Sye5v4DK7RKcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fN9+aapNRMAji/FCOdhbo08ETlBJ93q83rS6DhWzEsp4WOdxRs0MTKNjQkJ2POJeltVCnLACL+vjkEkAipLbUAE3gsVICJHyxN3nGpVns9UcsSbehEFsZKWK5lAWOq/+OTmsRRmwhJozbFlrS03+RY9OBHSaBQZr7zhc8O/hYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLkYdW1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747FFC32782;
	Tue, 13 Aug 2024 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723573269;
	bh=0FfawM6Ws50nNU2tSSGn+8MK81B8Z4Sye5v4DK7RKcY=;
	h=From:Date:Subject:To:Cc:From;
	b=PLkYdW1ftsylOD2WCwuqeM0ZmZ7lqyFx0e1GiIr06N6X5wQGRnxPMaVGDAtdEIZo0
	 B8d3iMKulZpmFASILn8T6jF/gSORpcKXVjVotM3UVa40//txOuDaJttaDC0LHiclTL
	 mhhekanjdjmg50MBLMaaKDSzGdPOPKdGll/bVParfZ4VdubfkU0leP5x9ahJJrAqYx
	 gmrbCVaSzki/diXur00R6acW+vgiA++B3rDhl3AfLnA4D80oxnN7gagE2KDepbr4zF
	 /Ab4fdH462I9Cn0hDRK7WKiFzwg4+EU+8RyVmKgQSOdOX/aphl2RKwDg2kbEkciriH
	 fWQ3xO2DyzTiA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 13 Aug 2024 14:21:08 -0400
Subject: [PATCH fstests] generic/755: test that inode's ctime is updated on
 unlink
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-master-v1-1-862678cc4000@kernel.org>
X-B4-Tracking: v=1; b=H4sIABOku2YC/x3MSwqAIBRG4a3IP06wDIm2Eg00b3UHPfBGBNLek
 4YHPk6GUGIS9Coj0c3Cx16irhSm1e8LaY6l0ZimNV1t9ebloqTJhtZFctaEiILPRDM//2jAXIh
 cgvF9P6ybpQthAAAA
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3516; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0FfawM6Ws50nNU2tSSGn+8MK81B8Z4Sye5v4DK7RKcY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmu6QV8I8asDagDaui4Ac1XnOlCOMn45Gd8GFwI
 FLYU2PVZ9eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZrukFQAKCRAADmhBGVaC
 FXoXEACjnJWfoNA53AD6CNjxTY9PqrP6HZdsNS8kScOCErYeG0lExEVbKrEWwlSZ0k7xSPrY6ac
 MJzprcpaTxWujZftWVz5pgB6ILUDlZerD6qy/AlMa7sr2i48veWuQsQS3TXSpT5py2O0U0055Qm
 5EZPUZgBk75yXtVs2sWKyDeiJqB0vF5LSXxmQjwzzb1AC+dWOGPcI27US7Bhv6y+nIRH+04jQro
 ITydLH+lBAbOcqW/RQcpXu+iDpgDvl3i+FqnjCNHNYCRj//mW3cWQM8I0wq9ZEDw/wbSUw93lDj
 Dwl+Z/xHhtjZBAcIh3jfkT+yuHX/3do2pWFt1YQBycW1+DVBGBdl5vN2OV2quYPe7OZZq/r4PD6
 98RzGFWmpjASZZYY3YmVoClKyNp66RAAuJHi+SC+J36gQcW7PhpiaFDak8nbIXJ79VYZCHZgXmB
 gaJA2Hk3O9ysv8MWrVX6KpuA7vg7J4ShWrT80GYHNVi1V0qP09PYYFSNWgYlDenWJz1u9ptirWS
 Uw/3+ORxO2dFOQ/o5AZOgA0UCpp8NgEasDMSbZDWEi5EQBL9eo0lpAgOD19ZkGLIn8escYEYq9u
 3PkyZnrYRa/cL1tM77YVOlO37WXTR0p2zVZLEdsFIEQtIKZlmh2Wn71TO6qTpaitJBvqu5cDyTO
 Fw5kuuPInrbtzRQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
HCH suggested I roll a fstest for this problem that I found in btrfs the
other day. In principle, we probably could expand this to other dir
operations and to check the parent timestamps, but having to do all that
in C is a pain.  I didn't see a good way to use xfs_io for this,
however.
---
 src/Makefile          |  2 +-
 src/unlink-ctime.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/755     | 26 ++++++++++++++++++++++++++
 tests/generic/755.out |  2 ++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 9979613711c9..c71fa41e4668 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
+	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault unlink-ctime
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/unlink-ctime.c b/src/unlink-ctime.c
new file mode 100644
index 000000000000..7661e340eaba
--- /dev/null
+++ b/src/unlink-ctime.c
@@ -0,0 +1,50 @@
+#define _GNU_SOURCE 1
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+int main(int argc, char **argv)
+{
+	int fd, ret;
+	struct statx before, after;
+
+	if (argc < 2) {
+		fprintf(stderr, "Must specify filename!\n");
+		return 1;
+	}
+
+	fd = open(argv[1], O_RDWR|O_CREAT, 0600);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &before);
+	if (ret) {
+		perror("statx");
+		return 1;
+	}
+
+	sleep(1);
+
+	ret = unlink(argv[1]);
+	if (ret) {
+		perror("unlink");
+		return 1;
+	}
+
+	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &after);
+	if (ret) {
+		perror("statx");
+		return 1;
+	}
+
+	if (before.stx_ctime.tv_nsec == after.stx_ctime.tv_nsec &&
+	    before.stx_ctime.tv_sec == after.stx_ctime.tv_sec) {
+		printf("No change to ctime after unlink!\n");
+		return 1;
+	}
+	return 0;
+}
diff --git a/tests/generic/755 b/tests/generic/755
new file mode 100755
index 000000000000..500c51f99630
--- /dev/null
+++ b/tests/generic/755
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
+#
+# FS QA Test No. 755
+#
+# Create a file, stat it and then unlink it. Does the ctime of the
+# target inode change?
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+. ./common/dmerror
+
+_require_test
+_require_test_program unlink-ctime
+
+testfile="$TEST_DIR/unlink-ctime.$$"
+
+$here/src/unlink-ctime $testfile
+
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/755.out b/tests/generic/755.out
new file mode 100644
index 000000000000..7c9ea51cd298
--- /dev/null
+++ b/tests/generic/755.out
@@ -0,0 +1,2 @@
+QA output created by 755
+Silence is golden

---
base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
change-id: 20240813-master-e3b46de630bd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


