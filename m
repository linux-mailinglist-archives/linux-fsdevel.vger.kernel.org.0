Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5878DAEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjH3SiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbjH3K7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C79CC2;
        Wed, 30 Aug 2023 03:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 163C6627B9;
        Wed, 30 Aug 2023 10:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0326BC433C7;
        Wed, 30 Aug 2023 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693393156;
        bh=6ZcuktGl77PTi6fYDnXDniAnW1Ylz3ZPnE9Co3jY++U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CNzARJtTpBxffDaZFmhviHmHjNj8K8mFlb8UsKvUtfx7OSCKVoZent8tT2dNVISWj
         1eHfbrEya9TEEoR2x3wskyGun6SgTuSYu0gVP61djGcrtfod53xiD+VMt2M3LMPsbs
         WKc4jUXm3hIrsFrOOAA09M+ZeIcPpTD3j/OQH4x4DO6ZaHwU/OdXp7ZiqGhnLXgAcp
         wyrogB8pcDVuZsmDNpC3vD2nHvvQcMkPjmZ8cs6gvfK93Sd0vFUZZZruqKuxUT4Ph+
         59X4EjUjdwRlNN8qI7pO/3AMxdSNlgG0cdrqN5hVrThnHsBuLw5QaKdcXhuCnhCsuT
         7STJGsKkAsC2w==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 30 Aug 2023 06:58:52 -0400
Subject: [PATCH fstests v4 3/3] generic/*: add a check for security attrs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-fixes-v4-3-88d7b8572aa3@kernel.org>
References: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
In-Reply-To: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3223; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6ZcuktGl77PTi6fYDnXDniAnW1Ylz3ZPnE9Co3jY++U=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk7yEBJq9tUG0ZJ0m5AmrA91Wq5W/JnR3kWb94y
 ywiFKhNVoSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZO8hAQAKCRAADmhBGVaC
 FVFpD/4xsfXdQhOYaKKwEGPDPYpgeJ75GUDwk6C+jVKUnm5Elf63+qNVW5G7C1t33bPwrdH1OUQ
 0tj/n+DXykL+4lcgTNcudXOhgxXQ9ieO9EHsTc9MZeCugM67c47MS2D5FvQPIieanaOYfaOsogq
 7HVtYgzGcDQIHJEvaBE2iDeZKUH3z5Epq6NvcsJ+m/T6G1k6wzr9iraabN2RyCz1OAfhorYrGQp
 1ccSx67+xauA/095Bt3AhJmVWMxhDkr1h0Q2Fa2bIt8AlXG1OuoQTSGQt5yTeL/nC10DtngsXEa
 DVY4bbirfNsUdMs4TiipM9LvMhPF7TpmGE+QD6h3ELUvG1hTA2ZPVaIC1X0ay2NvxMmdzsEpr0k
 mDstI2s06VH7wtdoSb3nN/8PXboRlndb+lVLWbiH7/d2ba+Cw1Afbt9SPAYciYW31LTF6csNlJO
 bzcbUbjqp6BZr8l9d4nUhNs6uDhzsa+8VVgRV1pEhQT5zEXFLT4ZHkU2h+2a2Fxg1W1By4vG2LY
 MEV8RsHpl6ZlLsCkXuYWRg6SNAVsVVmEnHkMSF6RL9DfLFMOovsBgJoDUwPNRem5T8psCirjvQ+
 ZVk6x56FVhvj3Si9cFzAUXundM5JXGyX+jNZc/uBv690lkvGttobJ+36q29rlh12yv4xC2HJRgN
 YLI5rGveAJa+0Jg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are several generic tests that require "setcap", but don't check
whether the underlying fs supports security attrs. Add the appropriate
checks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/270 | 2 ++
 tests/generic/513 | 2 ++
 tests/generic/675 | 2 ++
 tests/generic/688 | 2 ++
 tests/generic/727 | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/tests/generic/270 b/tests/generic/270
index 8a6a2822b76b..e7329c2f3280 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -13,6 +13,7 @@ _begin_fstest auto quota rw prealloc ioctl enospc stress
 # Import common functions.
 . ./common/filter
 . ./common/quota
+. ./common/attr
 
 # Disable all sync operations to get higher load
 FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
@@ -58,6 +59,7 @@ _require_user
 _require_scratch
 _require_command "$KILLALL_PROG" killall
 _require_command "$SETCAP_PROG" setcap
+_require_attrs security
 
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
diff --git a/tests/generic/513 b/tests/generic/513
index dc082787ae4e..7ff845cea35b 100755
--- a/tests/generic/513
+++ b/tests/generic/513
@@ -12,12 +12,14 @@ _begin_fstest auto quick clone
 # Import common functions.
 . ./common/filter
 . ./common/reflink
+. ./common/attr
 
 # real QA test starts here
 _supported_fs generic
 _require_scratch_reflink
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
+_require_attrs security
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
diff --git a/tests/generic/675 b/tests/generic/675
index 189251f20c0d..cc4309e45a04 100755
--- a/tests/generic/675
+++ b/tests/generic/675
@@ -12,6 +12,7 @@ _begin_fstest auto clone quick
 # Import common functions.
 . ./common/filter
 . ./common/reflink
+. ./common/attr
 
 # real QA test starts here
 
@@ -21,6 +22,7 @@ _require_user
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 _require_scratch_reflink
+_require_attrs security
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
diff --git a/tests/generic/688 b/tests/generic/688
index 426286b6c6ce..e2bf12b4457d 100755
--- a/tests/generic/688
+++ b/tests/generic/688
@@ -18,6 +18,7 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
+. ./common/attr
 
 # real QA test starts here
 
@@ -29,6 +30,7 @@ _require_command "$SETCAP_PROG" setcap
 _require_xfs_io_command falloc
 _require_test
 _require_congruent_file_oplen $TEST_DIR 65536
+_require_attrs security
 
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
diff --git a/tests/generic/727 b/tests/generic/727
index 58a89e3eda70..2cda49eadab3 100755
--- a/tests/generic/727
+++ b/tests/generic/727
@@ -19,6 +19,7 @@ _begin_fstest auto fiexchange swapext quick
 
 # Import common functions.
 . ./common/filter
+. ./common/attr
 
 # real QA test starts here
 
@@ -30,6 +31,7 @@ _require_command "$SETCAP_PROG" setcap
 _require_xfs_io_command swapext '-v vfs -a'
 _require_xfs_io_command startupdate
 _require_scratch
+_require_attrs security
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount

-- 
2.41.0

