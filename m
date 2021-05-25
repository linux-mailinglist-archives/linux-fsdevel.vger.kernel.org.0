Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AC390C14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEYWVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhEYWVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:37 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECBC06175F;
        Tue, 25 May 2021 15:20:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f18so32094367qko.7;
        Tue, 25 May 2021 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9a11YZ/p1awTBwVbz3YzCFeSTuy6nImBmPUHPega8M=;
        b=XX0Uvnr2luYU/EOjFVeTq8gxUKKhmykyff/2yFv8fP1A8ym6dWZv+tsaX5S7Z9LVHJ
         qH+sJn/XDHilLxEeMDdrISB1W5PGWetEaGhbT/UY2V5tRD4PrZ+32DHv6EzPcFsis7kf
         0jy5jnbAVEPzFwzttwjUg792CKDbx+KigZt50ftPD2kNcN0SCfVGCnNS9LNPQuzTmePj
         5ddpt3F5KIMrTW8VIuNule7p54Pnl3Q6WmhrL6LueX9mMfxJrssbmsNmCU9Cevsz+8nl
         7cgnq0bixOwtn7BKN9hqXte4OVmA9vrQvHMvk4LM/RQ8y8It1utq+efpndlD+oov7PvN
         rztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9a11YZ/p1awTBwVbz3YzCFeSTuy6nImBmPUHPega8M=;
        b=jryrNRx3KC1asqAZc2Iqir+RXNH9AAd/BGFOHiH/rV+N9xDczgUny2zD2LNd80s3AW
         GQASeGGvXvgkG6IXllF4Ioq9NPLzrK0qZjwZ66eXo/UHFbMdclvHkIvIA+xJnjbk0Yot
         b59A5m3nm/ScNFJt5fHmB53zzwIC3LOd4kVAnnj02uwTTs3Ao5kzrKdBVgyQD6SV2fQX
         fdekobLqIgzg/jBUuCXAnVpWEWh0v/KjJK+z5CTpd/prxiSWLpj+a3OtOQqmovHws7QY
         iEH2H9I3sCvnnbA72EJBxNcWf9NBU8Y98QAkgnVhJdHfsNIqL7eg5qBJDIeCBPYa9P+c
         XoFQ==
X-Gm-Message-State: AOAM530LiKHgVfiw/nb1IY15LNT880KBZM+5xV4E7mDCoDc116XkxNOS
        GwpJwtgGseLt8olzQs2Cneu4W2fSu+c9
X-Google-Smtp-Source: ABdhPJzreItQbekpelo4f7bZiXM6Bnpr5GTWokRklhms9dvhT+gpm0gyKZryv/cWHl9knkQETQfv7Q==
X-Received: by 2002:a05:620a:745:: with SMTP id i5mr27173408qki.324.1621981205119;
        Tue, 25 May 2021 15:20:05 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:04 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 3/4] generic/{455,457,482}: make dmlogwrites tests work on bcachefs
Date:   Tue, 25 May 2021 18:19:50 -0400
Message-Id: <20210525221955.265524-3-kent.overstreet@gmail.com>
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

