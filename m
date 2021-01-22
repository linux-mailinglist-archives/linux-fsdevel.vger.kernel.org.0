Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A082300E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbhAVVGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbhAVUxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A17C0698DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so3973472plr.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SYEPqYHLibi3PveqMabFu43GSxBmBmjTzenpve/yh8=;
        b=smdgq5CoEdiKVLQoseZrDt0Eo6B5Z3pPmV+Kj+nex+UpgLdGMRttyACCxdPrd9kNum
         GPaIbEz+CqSX5OJ5YzclHPpnkoTI5kZB9+aU5cfCQxVyLBG6nWpqNFE4OhdBRM6ZvefG
         mUmDLCUaicS3w0897/5gW/iAR47yFjFMO9CJFYMZNtnpTf6jZo+aWaA5t6JY0kTa2y9m
         E7j6EsR8c0j/UA7cRgd2FDAZjv7u02fdOJA4fKOFoVgnXm404sHwW0Dv5FaAIgDSWaDG
         gr1UVP+tNKk2HrhDN4MbRRzO9k6t2qmwDfacfL1Pt68Js+swd41jALnKbfJjmaugXanM
         RtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SYEPqYHLibi3PveqMabFu43GSxBmBmjTzenpve/yh8=;
        b=dsiExrfxqWUT4ecX/LjPyQPeUV54F5hRPmw9RLaXLzvJC1dF2IA36ewglmqVy3/Hon
         MPNz16BWGCgCEi2xeOaxlZlw9l+C4LdyVcpPvCR4r9fIHedyNE1TnxLYlwnmcRsrqhKS
         k9QoQDBck30eBXWFWc72yWkY9vT6xTFGhjN5hQeOuz8BmLJWNWAvd1ImIxwz+Nt6GtCr
         4ewcpyHBGMSrmqSx46hJEGmHNkKPyQVJdZ/J5SG5C1xEl88pPyQQdf9Dq6gLZ1YJC7Bb
         HZ6rJxHe+3lc5YQDrii7U7jKVWzbIvhkk/EGAZNLAvmcauSzBlATGld1/pEPqpELWmjh
         iRmg==
X-Gm-Message-State: AOAM5329PsURZ02uftgK9tU5P0Y5ZVYMYN0P+SjatB+/uxJ/NMnkDLyc
        t3T/B2zxolOUBgPy1bSjPcl2Ew==
X-Google-Smtp-Source: ABdhPJxc1kextmn3Pm67olcNPQ9Ly1lNQnGPodrfu09B9M3GnuwCeM5LqWLR0LwA/SKQDkzuj6Winw==
X-Received: by 2002:a17:902:a504:b029:da:fbca:d49 with SMTP id s4-20020a170902a504b02900dafbca0d49mr937005plq.72.1611348535482;
        Fri, 22 Jan 2021 12:48:55 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:53 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 11/11] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Fri, 22 Jan 2021 12:47:58 -0800
Message-Id: <6e36570df3d4a42b586a0e783ec062c7badafa1d.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Adapt the existing send/receive tests by passing '-o --force-compress'
to the mount commands in a new test. After writing a few files in the
various compression formats, send/receive them with and without
--force-decompress to test both the encoded_write path and the
fallback to decode+write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 .../043-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/043-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/043-receive-write-encoded/test.sh b/tests/misc-tests/043-receive-write-encoded/test.sh
new file mode 100755
index 00000000..b9390e88
--- /dev/null
+++ b/tests/misc-tests/043-receive-write-encoded/test.sh
@@ -0,0 +1,114 @@
+#!/bin/bash
+#
+# test that we can send and receive encoded writes for three modes of
+# transparent compression: zlib, lzo, and zstd.
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+here=`pwd`
+
+# assumes the filesystem exists, and does mount, write, snapshot, send, unmount
+# for the specified encoding option
+send_one() {
+	local str
+	local subv
+	local snap
+
+	algorithm="$1"
+	shift
+	str="$1"
+	shift
+
+	subv="subv-$algorithm"
+	snap="snap-$algorithm"
+
+	run_check_mount_test_dev "-o" "compress-force=$algorithm"
+	cd "$TEST_MNT" || _fail "cannot chdir to TEST_MNT"
+
+	run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$subv"
+	run_check $SUDO_HELPER dd if=/dev/zero of="$subv/file1" bs=1M count=1
+	run_check $SUDO_HELPER dd if=/dev/zero of="$subv/file2" bs=500K count=1
+	run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$subv" "$snap"
+	run_check $SUDO_HELPER "$TOP/btrfs" send -f "$str" "$snap" "$@"
+
+	cd "$here" || _fail "cannot chdir back to test directory"
+	run_check_umount_test_dev
+}
+
+receive_one() {
+	local str
+	str="$1"
+	shift
+
+	run_check_mkfs_test_dev
+	run_check_mount_test_dev
+	run_check $SUDO_HELPER "$TOP/btrfs" receive "$@" -v -f "$str" "$TEST_MNT"
+	run_check_umount_test_dev
+	run_check rm -f -- "$str"
+}
+
+test_one_write_encoded() {
+	local str
+	local algorithm
+	algorithm="$1"
+	shift
+	str="$here/stream-$algorithm.stream"
+
+	run_check_mkfs_test_dev
+	send_one "$algorithm" "$str" --compressed-data
+	receive_one "$str" "$@"
+}
+
+test_one_stream_v1() {
+	local str
+	local algorithm
+	algorithm="$1"
+	shift
+	str="$here/stream-$algorithm.stream"
+
+	run_check_mkfs_test_dev
+	send_one "$algorithm" "$str" --stream-version 1
+	receive_one "$str" "$@"
+}
+
+test_mix_write_encoded() {
+	local strzlib
+	local strlzo
+	local strzstd
+	strzlib="$here/stream-zlib.stream"
+	strlzo="$here/stream-lzo.stream"
+	strzstd="$here/stream-zstd.stream"
+
+	run_check_mkfs_test_dev
+
+	send_one "zlib" "$strzlib" --compressed-data
+	send_one "lzo" "$strlzo" --compressed-data
+	send_one "zstd" "$strzstd" --compressed-data
+
+	receive_one "$strzlib"
+	receive_one "$strlzo"
+	receive_one "$strzstd"
+}
+
+test_one_write_encoded "zlib"
+test_one_write_encoded "lzo"
+test_one_write_encoded "zstd"
+
+# with decompression forced
+test_one_write_encoded "zlib" "--force-decompress"
+test_one_write_encoded "lzo" "--force-decompress"
+test_one_write_encoded "zstd" "--force-decompress"
+
+# send stream v1
+test_one_stream_v1 "zlib"
+test_one_stream_v1 "lzo"
+test_one_stream_v1 "zstd"
+
+# files use a mix of compression algorithms
+test_mix_write_encoded
-- 
2.30.0

