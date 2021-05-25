Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724D390C18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhEYWVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhEYWVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F38C06175F;
        Tue, 25 May 2021 15:20:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i5so24874663qkf.12;
        Tue, 25 May 2021 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9a11YZ/p1awTBwVbz3YzCFeSTuy6nImBmPUHPega8M=;
        b=eJl1YYRpzwwp2DAltfGJhSC/tvXHhbVfpR1d3kkzzZ/sEZNbiHurPl5ZmFoMBZpzMZ
         n5E+7X1IKdnZgSH/kVj4AFmKULPeTD50HfBwEDn3MLx9L4Dydu7iFVNDxnHdAlemiDn0
         12T3HgjLdRUgaOaJxmrvY81gmDBrjwEtcCpDECoIFF+EMiUDfrA6nXGgwp3D1TjGVB+m
         u3L0nzjA3Hvypm0hUrMS+QE0ABhX7shVAfwZNZVDx9Nquc5gNohOPpn35zzPii9RcZH2
         4WfKAudhxC6ynQ4wlTQ8ypiwAIACpj2lSOV9vR7FF2HXdUhhpLGD1UoYhhBeKhj7B/TO
         f3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9a11YZ/p1awTBwVbz3YzCFeSTuy6nImBmPUHPega8M=;
        b=hggxjdvWzA7uVAXEpxBRvSIhCFIDkPHrkVXULzOmS8p2Ad8CqNRbMMKBc8vDdDVtxe
         5Vx7BnEmgkYFgi6StI04vx+yr7ZYbhwTKGWBmUyyrfPSRU+jZlAme37R2Y7Ral8xoV5U
         9L1RkvjGsoUaQ7Ret11c6JJSFL1A5h5JyfFNp4XN+xxkQc0xDXpUTlOdIWjzQaTtUtH7
         7C4+w8kkEWLkqWkF148MvjOyYLDFHnysHVPFwhm+XsHSi4pTu0OXEkeBkNOeE5T7zelr
         TjzPTUzWi5S21+d92l3cdzOpJd0WFu26X9xvOi2zBqw0w8rSIXDemyfudiYKTcvDAvom
         +9SQ==
X-Gm-Message-State: AOAM530oOgRUaa/NQ4LHdySlLmyEv5MChTQ390MVyfeNvGB2V6i4nZXe
        q+IkF1lwhwpOds32y9OsFaMqYRspm19s
X-Google-Smtp-Source: ABdhPJzj+DRd/r+o7SI7nYp8e12bchjv+CuNXLe3kLBjoXqKkC9kGWCdYq0uOjNWSaj4kl3lHTCjuQ==
X-Received: by 2002:ae9:eb12:: with SMTP id b18mr25268113qkg.459.1621981208938;
        Tue, 25 May 2021 15:20:08 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:08 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 3/4] generic/{455,457,482}: make dmlogwrites tests work on bcachefs
Date:   Tue, 25 May 2021 18:19:54 -0400
Message-Id: <20210525221955.265524-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525221955.265524-1-kent.overstreet@gmail.com>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
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

