Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18A38DE12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhEWXjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 19:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhEWXjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 19:39:43 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FFC061574;
        Sun, 23 May 2021 16:38:14 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h7so12691333qvs.12;
        Sun, 23 May 2021 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9a11YZ/p1awTBwVbz3YzCFeSTuy6nImBmPUHPega8M=;
        b=r85CJuPqVWFgpZkmHMAGgS7JKzkBq8vOXdMu/+bBT24P0TolJl9K+nLUQJcZoOOA2O
         8mS0pUZUXpRk+t2Qsqn3YmZb1LLLa7tMb2+yCTBq38u3jso6RUNXDiC8hcBGSWrftmiT
         /PZHUS3ty1xk/oT6kXoQuXBYRROag75W1hStmFYpSkFP0H7wtIz5ZO75KOEZlJKtxcJh
         vX26X1/8HMRZp90BDEanjCPrTVABFZ8od2SMEOrdiehlG3qQr+GLavDPMp2x9euFnfEO
         0agdtUg4R/maJgZ7OG12d6ESM4FAQhLcaS+08o4YEFOcwl/xRJvi1jEXkTmyF2oN0jI2
         C2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9a11YZ/p1awTBwVbz3YzCFeSTuy6nImBmPUHPega8M=;
        b=NIIyAx8ttN/4gS1VjKEUijlEahWhUmLAWmn60XycCK+OoKnKTnNmu/buVMFUvhT97e
         1/7IwbhpGRNeUy2TK9a7CB+VI+8beUcO9JNtJ+Vmq+wQtr3EBx6DNQhstrzVgSMxRNBw
         aduPF6he/P2lnc9dqbo8PQNfqAFcWIQVWuMQ1TWuKOQQ13oLtCidr1a2gcwahaoqco0m
         p84yMxq02//tJH4PpB7Fq22+VG9teutAuNIuo8c/7c1jEw1rP4JIi9sTLbAbgicCAupI
         Sqx2sFvT5IeIpu7cXrTJIIZYUaZmRHl8MQImJ1Eb3FQ3OaIpWOTs0QHDV0r7bV5p1XSL
         P+0A==
X-Gm-Message-State: AOAM532bFOOM8ntnA3RYuy4om31xQoUeCyfr8qLlAlKgtKFYbMUjBZZE
        4UThqtm9Rrr2ymrahTkKQHncJYP6S9Om
X-Google-Smtp-Source: ABdhPJzjaO7Dbgpin7JsPB5l9mj0FhNLxpaJwy3SsIzwn92704IyOHsy5FVqiA4wuLKdJBWbk6IVyQ==
X-Received: by 2002:a05:6214:a6b:: with SMTP id ef11mr16159185qvb.19.1621813092639;
        Sun, 23 May 2021 16:38:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 7sm10234014qtu.38.2021.05.23.16.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:38:12 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/1] generic/{455,457,482}: make dmlogwrites tests work on bcachefs
Date:   Sun, 23 May 2021 19:38:07 -0400
Message-Id: <20210523233807.3800568-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bcachefs has log structured btree nodes, in addition to a regular
journal, which means that unless we replay to markers in the log in the
same order that they happened and are careful to avoid writing in
between replaying to different events - we need to wipe and start fresh
each time.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 tests/generic/455 | 14 ++++++++++++++
 tests/generic/457 | 14 ++++++++++++++
 tests/generic/482 | 27 ++++++++++++++++++++-------
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/tests/generic/455 b/tests/generic/455
index 5b4b242e74..6dc46c3c72 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -35,6 +35,17 @@ _require_dm_target thin-pool
 
 rm -f $seqres.full
 
+_reset_dmthin()
+{
+    # With bcachefs, we need to wipe and start fresh every time we replay to a
+    # different point in time - if we see metadata from a future point in time,
+    # or an unrelated mount, bcachefs will get confused:
+    if [ "$FSTYP" = "bcachefs" ]; then
+	_dmthin_cleanup
+	_dmthin_init $devsize $devsize $csize $lowspace
+    fi
+}
+
 check_files()
 {
 	local name=$1
@@ -44,6 +55,7 @@ check_files()
 		local filename=$(basename $i)
 		local mark="${filename##*.}"
 		echo "checking $filename" >> $seqres.full
+		_reset_dmthin
 		_log_writes_replay_log $filename $DMTHIN_VOL_DEV
 		_dmthin_mount
 		local expected_md5=$(_md5_checksum $i)
@@ -101,6 +113,7 @@ _dmthin_check_fs
 
 # check pre umount
 echo "checking pre umount" >> $seqres.full
+_reset_dmthin
 _log_writes_replay_log last $DMTHIN_VOL_DEV
 _dmthin_mount
 _dmthin_check_fs
@@ -111,6 +124,7 @@ done
 
 # Check the end
 echo "checking post umount" >> $seqres.full
+_reset_dmthin
 _log_writes_replay_log end $DMTHIN_VOL_DEV
 _dmthin_mount
 for j in `seq 0 $((NUM_FILES-1))`; do
diff --git a/tests/generic/457 b/tests/generic/457
index ddbd90cf0c..f17d4e4430 100755
--- a/tests/generic/457
+++ b/tests/generic/457
@@ -37,6 +37,17 @@ _require_dm_target thin-pool
 
 rm -f $seqres.full
 
+_reset_dmthin()
+{
+    # With bcachefs, we need to wipe and start fresh every time we replay to a
+    # different point in time - if we see metadata from a future point in time,
+    # or an unrelated mount, bcachefs will get confused:
+    if [ "$FSTYP" = "bcachefs" ]; then
+	_dmthin_cleanup
+	_dmthin_init $devsize $devsize $csize $lowspace
+    fi
+}
+
 check_files()
 {
 	local name=$1
@@ -46,6 +57,7 @@ check_files()
 		local filename=$(basename $i)
 		local mark="${filename##*.}"
 		echo "checking $filename" >> $seqres.full
+		_reset_dmthin
 		_log_writes_replay_log $filename $DMTHIN_VOL_DEV
 		_dmthin_mount
 		local expected_md5=$(_md5_checksum $i)
@@ -105,6 +117,7 @@ _dmthin_check_fs
 
 # check pre umount
 echo "checking pre umount" >> $seqres.full
+_reset_dmthin
 _log_writes_replay_log last $DMTHIN_VOL_DEV
 _dmthin_mount
 _dmthin_check_fs
@@ -115,6 +128,7 @@ done
 
 # Check the end
 echo "checking post umount" >> $seqres.full
+_reset_dmthin
 _log_writes_replay_log end $DMTHIN_VOL_DEV
 _dmthin_mount
 for j in `seq 0 $((NUM_FILES-1))`; do
diff --git a/tests/generic/482 b/tests/generic/482
index 86941e8468..3cbe187f2e 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -77,16 +77,29 @@ prev=$(_log_writes_mark_to_entry_number mkfs)
 cur=$(_log_writes_find_next_fua $prev)
 [ -z "$cur" ] && _fail "failed to locate next FUA write"
 
+if [ "$FSTYP" = "bcachefs" ]; then
+    _dmthin_cleanup
+    _dmthin_init $devsize $devsize $csize $lowspace
+fi
+
 while [ ! -z "$cur" ]; do
 	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
 
-	# Here we need extra mount to replay the log, mainly for journal based
-	# fs, as their fsck will report dirty log as error.
-	# We don't care to preserve any data on the replay dev, as we can replay
-	# back to the point we need, and in fact sometimes creating/deleting
-	# snapshots repeatedly can be slower than replaying the log.
-	_dmthin_mount
-	_dmthin_check_fs
+	if [ "$FSTYP" = "bcachefs" ]; then
+	    # bcachefs will get confused if fsck does writes to replay the log,
+	    # but then we replay writes from an earlier point in time on the
+	    # same fs - but  fsck in -n mode won't do any writes:
+	    _check_scratch_fs -n $DMTHIN_VOL_DEV
+	else
+	    # Here we need extra mount to replay the log, mainly for journal based
+	    # fs, as their fsck will report dirty log as error.
+	    # We don't care to preserve any data on the replay dev, as we can replay
+	    # back to the point we need, and in fact sometimes creating/deleting
+	    # snapshots repeatedly can be slower than replaying the log.
+
+	    _dmthin_mount
+	    _dmthin_check_fs
+	fi
 
 	prev=$cur
 	cur=$(_log_writes_find_next_fua $(($cur + 1)))
-- 
2.32.0.rc0

