Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AE84D9D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349225AbiCOOad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349184AbiCOOaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:30:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241B55520D;
        Tue, 15 Mar 2022 07:29:18 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FCrZVO008429;
        Tue, 15 Mar 2022 14:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UEfh8l2z5Ugymmbrmr+ooUwyFTcVal3at3eCjb1Clmo=;
 b=AF3D1dxluVITFuqocbYz7ds7ImarXArh/6sv0Frf7x1iZj1ZS3etK/B2ZRL7ACJUmK4N
 W946azQrzyV7hlO1+m648RL0Cd56ZRcCSByS4zAxCcQVriuSAF8e/hBMyiqyvDlP3obc
 QyHA9GaK5ZL5NzqCDz0p2KbMMBQeq2TSCF/fzVR7+S+ep11gWIXQ3h4vXpE5pZuEMkEi
 K3ZOrhyBG3oNE1k1p/PfyxFISUauHrZnM/mXQUw9HGSE+gTo7KH9j68JuX25zWDpL1Y1
 oznt7kQuVmmsVJ7LJVWcvI6hdRu9lMPIMhy/0Le2JB8FIjxEY3ve5kKxitTav2XM4qQL WA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etru2nfj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:17 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FETFTY026887;
        Tue, 15 Mar 2022 14:29:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58ntnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FETDLK54526416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:29:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EE7E4C044;
        Tue, 15 Mar 2022 14:29:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C49E4C046;
        Tue, 15 Mar 2022 14:29:12 +0000 (GMT)
Received: from localhost (unknown [9.43.32.151])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 14:29:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 4/4] generic/677: Add a test to check unwritten extents tracking
Date:   Tue, 15 Mar 2022 19:58:59 +0530
Message-Id: <37d65f1026f2fc1f2d13ab54980de93f4fa34c46.1647342932.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647342932.git.riteshh@linux.ibm.com>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 17IHvhtUMgfqKoVY7OCCr5bs2PAwpVDr
X-Proofpoint-GUID: 17IHvhtUMgfqKoVY7OCCr5bs2PAwpVDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With these sequence of operation (in certain cases like with ext4 fast_commit)
could miss to track unwritten extents during replay phase
(after sudden FS shutdown).

This fstest adds a test case to test this.

5e4d0eba1ccaf19f
ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/677     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/677.out |  6 ++++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/generic/677
 create mode 100644 tests/generic/677.out

diff --git a/tests/generic/677 b/tests/generic/677
new file mode 100755
index 00000000..e316763a
--- /dev/null
+++ b/tests/generic/677
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 677
+#
+# Test below sequence of operation which (w/o below kernel patch) in case of
+# ext4 with fast_commit may misss to track unwritten extents.
+# commit 5e4d0eba1ccaf19f
+# ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
+#
+. ./common/preamble
+_begin_fstest auto quick log shutdown recoveryloop
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/punch
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_scratch
+_require_xfs_io_command "fzero"
+_require_xfs_io_command "fiemap"
+
+t1=$SCRATCH_MNT/t1
+
+_scratch_mkfs > $seqres.full 2>&1
+
+_scratch_mount >> $seqres.full 2>&1
+
+bs=$(_get_block_size $SCRATCH_MNT)
+
+# create and write data to t1
+$XFS_IO_PROG -f -c "pwrite 0 $((100*$bs))" $t1 | _filter_xfs_io_numbers
+
+# fsync t1
+$XFS_IO_PROG -c "fsync" $t1
+
+# fzero certain range in between
+$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1
+
+# fsync t1
+$XFS_IO_PROG -c "fsync" $t1
+
+# shutdown FS now for replay of journal to kick during next mount
+_scratch_shutdown -v >> $seqres.full 2>&1
+
+_scratch_cycle_mount
+
+# check fiemap reported is valid or not
+$XFS_IO_PROG -c "fiemap -v" $t1 | _filter_fiemap_flags $bs
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/677.out b/tests/generic/677.out
new file mode 100644
index 00000000..b91ab77a
--- /dev/null
+++ b/tests/generic/677.out
@@ -0,0 +1,6 @@
+QA output created by 677
+wrote XXXX/XXXX bytes at offset XXXX
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..39]: none
+1: [40..59]: unwritten
+2: [60..99]: nonelast
--
2.31.1

