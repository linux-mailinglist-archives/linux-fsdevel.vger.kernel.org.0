Return-Path: <linux-fsdevel+bounces-57615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD835B23E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EDA586661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323E2512C8;
	Wed, 13 Aug 2025 02:48:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256E24DD0B;
	Wed, 13 Aug 2025 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053292; cv=none; b=ZjuZtEOaAw/fTeFbbSHF02XNOilN9KuPUqAudIR6kcGrPoBH94XQz02uGOATvur/OZpBZFg3Qu7x0eUpVUp53CiUJ4C2rs5c/BOqgHmg3+CLXHAMxogW9Mba5NKeRz5izcG+XbjJYykUu+VlkpJVTEyn+8z6Puhllg9dFULFLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053292; c=relaxed/simple;
	bh=tZ9QqB/EuyK2i06le0UC9Txj9cWiMawGnDax1Flyk8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P119h/NNrAdixkzji79UhU4fhBAJy4VIBYMT/WvARONF86wostx8QwKPyjj7bJ+BppkEBe8LIhfCJtIMSHkInX894O0er1Q5CmJiAB9oW2Z2PU7TU5qEWDFaUuCDA1IQP3DKcpYJrtmp2RbmVO+dCmmn4mlPlFWbaMB8Mezvr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1t8l0WNPzKHMkv;
	Wed, 13 Aug 2025 10:48:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 50CC01A1303;
	Wed, 13 Aug 2025 10:48:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAHgdva_JtofdW_DQ--.32695S4;
	Wed, 13 Aug 2025 10:48:02 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH util-linux v2] fallocate: add FALLOC_FL_WRITE_ZEROES support
Date: Wed, 13 Aug 2025 10:40:15 +0800
Message-Id: <20250813024015.2502234-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHgdva_JtofdW_DQ--.32695S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW7XFy3Cw43JFy5XFWkZwb_yoWxXryDpF
	W5tF18K3yFgw4xGw1xAw4kWw15Zws5WrW5CrZ2grykAr13Ga17Ka1vgryFgasrXrWvka15
	Xryavry3ur48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the fallocate
utility by introducing a new option -w|--write-zeroes.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v1->v2:
 - Minor description modification to align with the kernel.

 sys-utils/fallocate.1.adoc | 11 +++++++++--
 sys-utils/fallocate.c      | 20 ++++++++++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
index 44ee0ef4c..0ec9ff9a9 100644
--- a/sys-utils/fallocate.1.adoc
+++ b/sys-utils/fallocate.1.adoc
@@ -12,7 +12,7 @@ fallocate - preallocate or deallocate space to a file
 
 == SYNOPSIS
 
-*fallocate* [*-c*|*-p*|*-z*] [*-o* _offset_] *-l* _length_ [*-n*] _filename_
+*fallocate* [*-c*|*-p*|*-z*|*-w*] [*-o* _offset_] *-l* _length_ [*-n*] _filename_
 
 *fallocate* *-d* [*-o* _offset_] [*-l* _length_] _filename_
 
@@ -28,7 +28,7 @@ The exit status returned by *fallocate* is 0 on success and 1 on failure.
 
 The _length_ and _offset_ arguments may be followed by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB, and YiB (the "iB" is optional, e.g., "K" has the same meaning as "KiB") or the suffixes KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB, and YB.
 
-The options *--collapse-range*, *--dig-holes*, *--punch-hole*, *--zero-range* and *--posix* are mutually exclusive.
+The options *--collapse-range*, *--dig-holes*, *--punch-hole*, *--zero-range*, *--write-zeroes* and *--posix* are mutually exclusive.
 
 *-c*, *--collapse-range*::
 Removes a byte range from a file, without leaving a hole. The byte range to be collapsed starts at _offset_ and continues for _length_ bytes. At the completion of the operation, the contents of the file starting at the location __offset__+_length_ will be appended at the location _offset_, and the file will be _length_ bytes smaller. The option *--keep-size* may not be specified for the collapse-range operation.
@@ -76,6 +76,13 @@ Option *--keep-size* can be specified to prevent file length modification.
 +
 Available since Linux 3.14 for ext4 (only for extent-based files) and XFS.
 
+*-w*, *--write-zeroes*::
+Zeroes space in the byte range starting at _offset_ and continuing for _length_ bytes. Within the specified range, blocks are preallocated for the regions that span the holes in the file. After a successful call, subsequent reads from this range will return zeroes, subsequent writes to that range do not require further changes to the file mapping metadata.
++
+Zeroing is done within the filesystem by preferably submitting write zeores commands, the alternative way is submitting actual zeroed data, the specified range will be converted into written extents. The write zeroes command is typically faster than write actual data if the device supports unmap write zeroes, the specified range will not be physically zeroed out on the device.
++
+Options *--keep-size* can not be specified for the write-zeroes operation.
+
 include::man-common/help-version.adoc[]
 
 == AUTHORS
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 13bf52915..8d37fdad7 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -40,7 +40,7 @@
 #if defined(HAVE_LINUX_FALLOC_H) && \
     (!defined(FALLOC_FL_KEEP_SIZE) || !defined(FALLOC_FL_PUNCH_HOLE) || \
      !defined(FALLOC_FL_COLLAPSE_RANGE) || !defined(FALLOC_FL_ZERO_RANGE) || \
-     !defined(FALLOC_FL_INSERT_RANGE))
+     !defined(FALLOC_FL_INSERT_RANGE) || !defined(FALLOC_FL_WRITE_ZEROES))
 # include <linux/falloc.h>	/* non-libc fallback for FALLOC_FL_* flags */
 #endif
 
@@ -65,6 +65,10 @@
 # define FALLOC_FL_INSERT_RANGE		0x20
 #endif
 
+#ifndef FALLOC_FL_WRITE_ZEROES
+# define FALLOC_FL_WRITE_ZEROES		0x80
+#endif
+
 #include "nls.h"
 #include "strutils.h"
 #include "c.h"
@@ -94,6 +98,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
 	fputs(_(" -p, --punch-hole     replace a range with a hole (implies -n)\n"), out);
 	fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
+	fputs(_(" -w, --write-zeroes   write zeroes and ensure allocation of a range\n"), out);
 #ifdef HAVE_POSIX_FALLOCATE
 	fputs(_(" -x, --posix          use posix_fallocate(3) instead of fallocate(2)\n"), out);
 #endif
@@ -304,6 +309,7 @@ int main(int argc, char **argv)
 	    { "dig-holes",      no_argument,       NULL, 'd' },
 	    { "insert-range",   no_argument,       NULL, 'i' },
 	    { "zero-range",     no_argument,       NULL, 'z' },
+	    { "write-zeroes",   no_argument,       NULL, 'w' },
 	    { "offset",         required_argument, NULL, 'o' },
 	    { "length",         required_argument, NULL, 'l' },
 	    { "posix",          no_argument,       NULL, 'x' },
@@ -312,8 +318,8 @@ int main(int argc, char **argv)
 	};
 
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
-		{ 'c', 'd', 'i', 'p', 'x', 'z'},
-		{ 'c', 'i', 'n', 'x' },
+		{ 'c', 'd', 'i', 'p', 'w', 'x', 'z'},
+		{ 'c', 'i', 'n', 'w', 'x' },
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -323,7 +329,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while ((c = getopt_long(argc, argv, "hvVncpdizxl:o:", longopts, NULL))
+	while ((c = getopt_long(argc, argv, "hvVncpdizwxl:o:", longopts, NULL))
 			!= -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -353,6 +359,9 @@ int main(int argc, char **argv)
 		case 'z':
 			mode |= FALLOC_FL_ZERO_RANGE;
 			break;
+		case 'w':
+			mode |= FALLOC_FL_WRITE_ZEROES;
+			break;
 		case 'x':
 #ifdef HAVE_POSIX_FALLOCATE
 			posix = 1;
@@ -429,6 +438,9 @@ int main(int argc, char **argv)
 			else if (mode & FALLOC_FL_ZERO_RANGE)
 				fprintf(stdout, _("%s: %s (%ju bytes) zeroed.\n"),
 								filename, str, length);
+			else if (mode & FALLOC_FL_WRITE_ZEROES)
+				fprintf(stdout, _("%s: %s (%ju bytes) write zeroed.\n"),
+								filename, str, length);
 			else
 				fprintf(stdout, _("%s: %s (%ju bytes) allocated.\n"),
 								filename, str, length);
-- 
2.39.2


