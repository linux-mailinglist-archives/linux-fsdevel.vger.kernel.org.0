Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528014D9D8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349217AbiCOOac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349207AbiCOOa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:30:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7385521B;
        Tue, 15 Mar 2022 07:29:15 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FCiXDP010791;
        Tue, 15 Mar 2022 14:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i3m03whNHG64kV4iuqqFKqr94cW+BuyZ8aCmxAB1cRo=;
 b=C26Pj7Ckh3MJ6LvlEAqNU0HLuR9CJiH36BT6b5WNykg5exesMCIhDtZXNHybzzYx6gBg
 RsT8X6F+MpfVn3TcUu7JT0wEJhWjkkYv6G+94w7R3Py+D9fsiMCp5sb1eNAuT+g8hIGS
 o9eI9Nqc90PUn/QRHBEGnHhZJZ87fjNONAXRjq4G3zRlbLgu9FH2ZfDrhC24SgPAft3Y
 EqEOIyS5FrPj27F5OZ9qtzZhlpvtdV3RBZQaJjJ24evzNw1BS03q7wTDrG1jLy3U6s1F
 4spctmF08XWVxC2MH7hdB6Zd1xrazUPKM2O7C91KqXt+8NENBtL8E2NqWK63sU0lOhuS /g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3etu2stfeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FERIES030868;
        Tue, 15 Mar 2022 14:29:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3erjshpuhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FETA1033358280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:29:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B20A4060;
        Tue, 15 Mar 2022 14:29:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A1FA4065;
        Tue, 15 Mar 2022 14:29:10 +0000 (GMT)
Received: from localhost (unknown [9.43.32.151])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 14:29:09 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 3/4] generic/676: Add a new shutdown recovery test
Date:   Tue, 15 Mar 2022 19:58:58 +0530
Message-Id: <3d8c4f7374e97ccee285474efd04b093afe3ee16.1647342932.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647342932.git.riteshh@linux.ibm.com>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RxJLXyOCTF-VMtt_Q2kCWMVYBB_WtU9Q
X-Proofpoint-ORIG-GUID: RxJLXyOCTF-VMtt_Q2kCWMVYBB_WtU9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=847 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In certain cases (it is noted with ext4 fast_commit feature) that, replay phase
may not delete the right range of blocks (after sudden FS shutdown)
due to some operations which depends on inode->i_size (which during replay of
an inode with fast_commit could be 0 for sometime).
This fstest is added to test for such scenarios for all generic fs.

This test case is based on the test case shared via Xin Yin.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/676     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/676.out |  7 +++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/generic/676
 create mode 100644 tests/generic/676.out

diff --git a/tests/generic/676 b/tests/generic/676
new file mode 100755
index 00000000..315edcdf
--- /dev/null
+++ b/tests/generic/676
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 676
+#
+# This test with ext4 fast_commit feature w/o below patch missed to delete the right
+# range during replay phase, since it depends upon inode->i_size (which might not be
+# stable during replay phase, at least for ext4).
+# 0b5b5a62b945a141: ext4: use ext4_ext_remove_space() for fast commit replay delete range
+# (Based on test case shared by Xin Yin <yinxin.x@bytedance.com>)
+#
+
+. ./common/preamble
+_begin_fstest auto shutdown quick log recoveryloop
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+   _scratch_unmount > /dev/null 2>&1
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
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "fzero"
+_require_xfs_io_command "fiemap"
+
+t1=$SCRATCH_MNT/foo
+t2=$SCRATCH_MNT/bar
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
+# fzero certain range in between with -k
+$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1
+
+# create and fsync a new file t2
+$XFS_IO_PROG -f -c "fsync" $t2
+
+# fpunch within the i_size of a file
+$XFS_IO_PROG -c "fpunch $((30*$bs)) $((20*$bs))" $t1
+
+# fsync t1 to trigger journal operation
+$XFS_IO_PROG -c "fsync" $t1
+
+# shutdown FS now for replay journal to kick in next mount
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
diff --git a/tests/generic/676.out b/tests/generic/676.out
new file mode 100644
index 00000000..78375940
--- /dev/null
+++ b/tests/generic/676.out
@@ -0,0 +1,7 @@
+QA output created by 676
+wrote XXXX/XXXX bytes at offset XXXX
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..29]: none
+1: [30..49]: hole
+2: [50..59]: unwritten
+3: [60..99]: nonelast
--
2.31.1

