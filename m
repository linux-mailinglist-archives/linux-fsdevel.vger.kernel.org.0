Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11230595D74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiHPNeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiHPNeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57714BA43;
        Tue, 16 Aug 2022 06:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C1E60A09;
        Tue, 16 Aug 2022 13:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B84C433D6;
        Tue, 16 Aug 2022 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656855;
        bh=yRKmarZ3sRxQHVQpotVy13wyeGDSiZwkyWwSPPwpR8k=;
        h=From:To:Cc:Subject:Date:From;
        b=jf5NIatr6GZhYsZZyJlmCEcWyUKj9flwn1j27o1iBmRGXNSVUadJilWlWdU4PBWRg
         5C/cbYBVmuQklGg0x95Yp67CRBHDBA1XUegQr+wdZ3/LSeNwSw2/Y90ttE3N2DjIA0
         nxqdOXsSRItLyuOEOHJCuwy6KWVmKpucZnK27Lh2p2UGmDxHMaHIMruFZAltUoPjCv
         +PQGbp+4J6Wpi8BkmDqdjyvWuD2CGkkdr4e78hYVxFa8ZLwnMDBNjHRk74Wl0fSeWH
         6qTqTUxGE/6PLpdBEE012PwdQ035injVXzU8+N3ypi1rbSC5EVw3AseFjOUjO0TxH5
         KL6+W1g8TKUaQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [xfstests PATCH] generic/693: add basic change attr test
Date:   Tue, 16 Aug 2022 09:34:13 -0400
Message-Id: <20220816133413.44298-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have the ability to query the change attribute in userland,
test that the filesystems implement it correctly. Fetch the change
attribute before and after various operations and validate that it
changes (or doesn't change) as expected.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc             |  17 ++++++
 tests/generic/693     | 138 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/693.out |   1 +
 3 files changed, 156 insertions(+)
 create mode 100755 tests/generic/693
 create mode 100644 tests/generic/693.out

Please look and make sure I'm not missing other operations that we
should be testing here!

diff --git a/common/rc b/common/rc
index 197c94157025..b9cb47f99016 100644
--- a/common/rc
+++ b/common/rc
@@ -5052,6 +5052,23 @@ hexdump()
 	_fail "Use _hexdump(), please!"
 }
 
+_require_change_attr ()
+{
+
+	_mask=$($XFS_IO_PROG -f -c "statx -m 0x2000 -r" $TEST_DIR/change_attr_test.$$ \
+		| grep "^stat.mask" | cut -d' ' -f 3)
+	rm -f $TEST_DIR/change_attr_test.$$
+	if [ $(( ${_mask}&0x2000 )) -eq 0 ]; then
+		_notrun "$FSTYP does not support inode change attribute"
+	fi
+}
+
+_get_change_attr ()
+{
+	$XFS_IO_PROG -r -c "statx -m 0x2000 -r" $1 | grep '^stat.change_attr' | \
+		cut -d' ' -f3
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/693 b/tests/generic/693
new file mode 100755
index 000000000000..fa92931d2ac8
--- /dev/null
+++ b/tests/generic/693
@@ -0,0 +1,138 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
+#
+# FS QA Test No. 693
+#
+# Test the behavior of the inode change attribute
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_change_attr
+
+# from the stat.h header file
+UTIME_OMIT=1073741822
+
+testdir="$TEST_DIR/test_iversion_dir.$$"
+testfile="$testdir/test_iversion_file.$$"
+
+mkdir $testdir
+
+# DIRECTORY TESTS
+#################
+# Does dir change attr change on a create?
+old=$(_get_change_attr $testdir)
+touch $testfile
+new=$(_get_change_attr $testdir)
+if [ $old = $new ]; then
+	_fail "Change attr of dir did not change after create!"
+fi
+
+# on a hardlink?
+old=$new
+ln $testfile $testdir/linky
+new=$(_get_change_attr $testdir)
+if [ $old = $new ]; then
+	_fail "Change attr of dir did not change after hardlink!"
+fi
+
+# on an unlink?
+old=$new
+rm -f $testfile
+new=$(_get_change_attr $testdir)
+if [ $old = $new ]; then
+	_fail "Change attr of dir did not change after unlink!"
+fi
+
+# on a rename (within same dir)
+old=$new
+mv $testdir/linky $testfile
+new=$(_get_change_attr $testdir)
+if [ $old = $new ]; then
+	_fail "Change attr of dir did not change after rename!"
+fi
+
+# on a mknod
+old=$new
+mknod $testdir/pipe p
+new=$(_get_change_attr $testdir)
+if [ $old = $new ]; then
+	_fail "Change attr of dir did not change after mknod!"
+fi
+
+
+# REGULAR FILE TESTS
+####################
+# ensure change_attr changes after a write
+old=$(_get_change_attr $testfile)
+$XFS_IO_PROG -c "pwrite -W -q 0 32" $testfile
+new=$(_get_change_attr $testfile)
+if [ $old = $new ]; then
+	_fail "Change attr did not change after write!"
+fi
+
+# ensure it doesn't change after a sync
+old=$new
+sync
+new=$(_get_change_attr $testfile)
+if [ $old != $new ]; then
+	_fail "Change attr changed after sync!"
+fi
+
+# ensure change_attr does not change after read
+old=$new
+cat $testfile > /dev/null
+new=$(_get_change_attr $testfile)
+if [ $old != $new ]; then
+	_fail "Change attr changed after read!"
+fi
+
+# ensure it changes after truncate
+old=$new
+truncate --size 0 $testfile
+new=$(_get_change_attr $testfile)
+if [ $old = $new ]; then
+	_fail "Change attr did not change after truncate!"
+fi
+
+# ensure it changes after only atime update
+old=$new
+$XFS_IO_PROG -c "utimes 1 1 $UTIME_OMIT $UTIME_OMIT" $testfile
+new=$(_get_change_attr $testfile)
+if [ $old = $new ]; then
+	_fail "Change attr did not change after atime update!"
+fi
+
+# ensure it changes after utimes atime/mtime update
+old=$new
+$XFS_IO_PROG -c "utimes 1 1 1 1" $testfile
+new=$(_get_change_attr $testfile)
+if [ $old = $new ]; then
+	_fail "Change attr did not change after mtime update!"
+fi
+
+# after setting xattr
+old=$new
+setfattr -n user.foo -v bar $testfile
+new=$(_get_change_attr $testfile)
+if [ $old = $new ]; then
+	_fail "Change attr did not change after setxattr!"
+fi
+
+# after removing xattr
+old=$new
+setfattr -x user.foo $testfile
+new=$(_get_change_attr $testfile)
+if [ $old = $new ]; then
+	_fail "Change attr did not change after rmxattr!"
+fi
+
+status=0
+exit
diff --git a/tests/generic/693.out b/tests/generic/693.out
new file mode 100644
index 000000000000..89ad553d911c
--- /dev/null
+++ b/tests/generic/693.out
@@ -0,0 +1 @@
+QA output created by 693
-- 
2.37.2

