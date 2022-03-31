Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AC4ED9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiCaM4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiCaM4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:56:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D8175843;
        Thu, 31 Mar 2022 05:54:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a16so6402658plh.13;
        Thu, 31 Mar 2022 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdKrCzZxzKVcqcgPDrjDJsLO4bDaeI9ud7tYwYppoeA=;
        b=Q8/7bH4O2x6wGXrZIPRBtt8ePILsVBepVYI5Z42acUAIUhNUdPdlIu66AaN/8Hx9Ei
         wRAdeJGql4UyUhPaSL4iBT/4eJBHaIzUJHj/Siva9yfhy3QSyWlHSILHYaC/0WKPG4aM
         dLn57LpCk0wJoIbCiVoB9KJRxDJHUYAWsZQPdfxlsuoQ2hhOPFHQ/btl5DKPeDpGWemk
         JeIwbr1dqk8uogRQYwL7aHGCQeVa8wIr3X5e3oE+Z7PEov+1pOu8cdDZcYXx+7lfDYe2
         P4fXu2EFcRyoq+Kz4md+7isQt3H5w08OLtAL+rNJu5ZAEym4800Xg0RMoktP3Dk4u2lu
         i52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdKrCzZxzKVcqcgPDrjDJsLO4bDaeI9ud7tYwYppoeA=;
        b=i8gmtbnj/Jd8vIgooa65fdgnnVLfIoAvRZjGa3kyCnzUTeObqJowVXltyyGLQOg4D9
         0vVZiJIm6rcwchUtD/QNOzs0xtszRV+DDYu08SYw8OWXnhpO5C8HESsUkR+PBO4KlT6D
         XVYxKS8JsQtv1fndDczyafb2dmNq1ntf/a1J5XLY4GqYDok0SC8flMjIvYq4BVjZG/+Y
         LOEyAWb8cNiW6YD5UglaVNSq1+WWa2bIqGiOzkZ+nyOYZUrrc31GuVfS1CQPzg6dmFr7
         Ab3N4Rp7BOh4nGn6bpxM3UHGJR/gpB3YZq2W+q4mt7upOj+TKChwNKRMPuospKdzFP3t
         myVw==
X-Gm-Message-State: AOAM530z0kuUWaH+X05MTNMLc5+vpoAsNiRAdP4hiHF8UDVqhy+fVbe/
        BqoNzBjUxJcuS9XIE+NsfGftmo/BApw=
X-Google-Smtp-Source: ABdhPJy76UA88DJqcu7WyJMdmsX8fTxQgQTKcEC2DH9S1NBGbj3yquVKo8ujFSc76jvARwSQ+KFhuw==
X-Received: by 2002:a17:902:e812:b0:154:19ec:538b with SMTP id u18-20020a170902e81200b0015419ec538bmr5169580plg.102.1648731291457;
        Thu, 31 Mar 2022 05:54:51 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id pj9-20020a17090b4f4900b001c744034e7csm10717436pjb.2.2022.03.31.05.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:54:51 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 3/4] generic/678: Add a new shutdown recovery test
Date:   Thu, 31 Mar 2022 18:24:22 +0530
Message-Id: <2df6ee0680b5d2a6fad945e4936749f22abe72dd.1648730443.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1648730443.git.ritesh.list@gmail.com>
References: <cover.1648730443.git.ritesh.list@gmail.com>
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

From: Ritesh Harjani <riteshh@linux.ibm.com>

In certain cases (it is noted with ext4 fast_commit feature) that, replay phase
may not delete the right range of blocks (after sudden FS shutdown)
due to some operations which depends on inode->i_size (which during replay of
an inode with fast_commit could be 0 for sometime).
This fstest is added to test for such scenarios for all generic fs.

This test case is based on the test case shared via Xin Yin.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/678     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/678.out |  7 +++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/generic/678
 create mode 100644 tests/generic/678.out

diff --git a/tests/generic/678 b/tests/generic/678
new file mode 100755
index 00000000..46a7be6c
--- /dev/null
+++ b/tests/generic/678
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 678
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
+_require_scratch_shutdown
+
+t1=$SCRATCH_MNT/foo
+t2=$SCRATCH_MNT/bar
+
+_scratch_mkfs > $seqres.full 2>&1
+
+_scratch_mount >> $seqres.full 2>&1
+
+bs=$(_get_file_block_size $SCRATCH_MNT)
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
diff --git a/tests/generic/678.out b/tests/generic/678.out
new file mode 100644
index 00000000..e0992edd
--- /dev/null
+++ b/tests/generic/678.out
@@ -0,0 +1,7 @@
+QA output created by 678
+wrote XXXX/XXXX bytes at offset XXXX
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..29]: none
+1: [30..49]: hole
+2: [50..59]: unwritten
+3: [60..99]: nonelast
-- 
2.31.1

