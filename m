Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8994ED9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiCaM4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiCaM4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:56:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D989177095;
        Thu, 31 Mar 2022 05:54:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so2927669pjo.1;
        Thu, 31 Mar 2022 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHo/SdnNdRZSmP8pzyHHOdEbBJV/03V1Re1aAbJD2Gc=;
        b=SgklHYzOSi3fjID+QSeRHLtlahscqSRaADv5CBvzVTNSeyx8NW74mxGbBs8EN/3aBh
         6HTBgn9q2gNp1X58O7/CupgNNwdjE7gRYRK1HE6lwgJiT8/HAkDqut3hF1RhSgvcn6/s
         gIIkbLz6eIaUzLno6+9bthQIWBOVAQprG4xg7Inyqj4MYHcA3s43js3/QiMkkMoBUzlf
         B7VMzjHurKBNqq+EONESmcgKiwRieJKz/mRhNvbsIR/sMGHENTtUXoa9lFTIsQTlAuCY
         8m8VkzPwF8I+Hl8ZrFVlhiaYTCt6rEz3DIXMHceSCCKOECeu2lfgkYJtN6XxIf0fj1ZC
         ojrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHo/SdnNdRZSmP8pzyHHOdEbBJV/03V1Re1aAbJD2Gc=;
        b=2x8Osp0rHXnVJNu3BrrNk1BD6FVnjd2fn6PjPY8pmFjvjPnHl/RWeXIvORaKHTLqfy
         rYrMmFIU3IT2+YYGL7LEuS5hx7FQvrwkHfLbiG6z8+BCHUqxzHIoloytFhqLA1gpG0Yq
         jpGvI+QfNXi4eTwBMLrVGfUMtKzL3Q7Mx3QQxxfD8/0vfbckfy0aUFL2+3WjhD/xzGsO
         Mj6zIWXwkT4Sr2oNWYRFKZyjfBEIF7g4h3ErK0Wm00IDNuJiJs4gIeSbBNto5aQ0cdl2
         27ooRrCjZtZ4Yr72vIH5y7TtXjreAwKlQrBXz29meeHxF/pD6VZpjU4iEP5V5hILyLJ/
         VDPA==
X-Gm-Message-State: AOAM530qZO32mPu/NElRUWQ9sEyGOESZhGoeO5k4CourY94x//ZIwPRR
        RBCNPgIESCkGeCKkfW8AcYCw9EmgQPY=
X-Google-Smtp-Source: ABdhPJy8fzYBBWX6X83T9W9WfaKZGq1VpsF5iaS+grrRT+GuiNeOUqC6Ud9fxIYWWbOfmHouDWwqWg==
X-Received: by 2002:a17:902:e9d4:b0:153:bd06:859c with SMTP id 20-20020a170902e9d400b00153bd06859cmr4929160plk.8.1648731297010;
        Thu, 31 Mar 2022 05:54:57 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a150200b001c9f1a7aafesm6135370pja.29.2022.03.31.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:54:56 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 4/4] generic/679: Add a test to check unwritten extents tracking
Date:   Thu, 31 Mar 2022 18:24:23 +0530
Message-Id: <c9a40292799a83e52924b7b748701b3b0aa31c46.1648730443.git.ritesh.list@gmail.com>
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

With these sequence of operation (in certain cases like with ext4 fast_commit)
could miss to track unwritten extents during replay phase
(after sudden FS shutdown).

This fstest adds a test case to test this.

5e4d0eba1ccaf19f
ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/679     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/679.out |  6 ++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/679
 create mode 100644 tests/generic/679.out

diff --git a/tests/generic/679 b/tests/generic/679
new file mode 100755
index 00000000..4f35a9cd
--- /dev/null
+++ b/tests/generic/679
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 679
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
+_require_scratch_shutdown
+
+t1=$SCRATCH_MNT/t1
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
diff --git a/tests/generic/679.out b/tests/generic/679.out
new file mode 100644
index 00000000..4d3c3377
--- /dev/null
+++ b/tests/generic/679.out
@@ -0,0 +1,6 @@
+QA output created by 679
+wrote XXXX/XXXX bytes at offset XXXX
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..39]: none
+1: [40..59]: unwritten
+2: [60..99]: nonelast
-- 
2.31.1

