Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A875A62A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGTGRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 02:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGTGRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:17:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CD2690;
        Wed, 19 Jul 2023 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=E0e/1EaMH+1miSlpA0RwJh3aYGH/AphNFDYbxLsUolQ=; b=3odo3/Lj8tk3rE8/ntxjabRO4E
        lxt9ncq9FExqd5ZkyeMi6ma9MzZIEYBJUTW7ULmBW9JDV8BUDKe2MIg7ay1ttStMr3oMrwO7aQqGz
        cn+lZiOOBT+nKxSce/umz8brqrvh2nq+OmAzVQtvrgMj1K/tvdX3AJ0Jwc3l2EKaoK8TgjlHk0/55
        irpSg44jb+a+IgGBvb5JQxUyh8VhH00ERYeWjKW6rnP/joCuCXndNABsm7xS0NQC73oJ4VtD/Hvt2
        9vX1T0BS4szVt4ecZ6Ev1zZ84OGjrqbvOggMhe3STS7m7g4+o4TjUpYFihRYE04IGBBfgolFzXrr/
        ie5EqRuQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMMye-009usH-0G;
        Thu, 20 Jul 2023 06:17:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] fstests: add helper to canonicalize devices used to enable persistent disks
Date:   Wed, 19 Jul 2023 23:17:27 -0700
Message-Id: <20230720061727.2363548-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The filesystem configuration file does not allow you to use symlinks to
devices given the existing sanity checks verify that the target end
device matches the source.

Using a symlink is desirable if you want to enable persistent tests
across reboots. For example you may want to use /dev/disk/by-id/nvme-eui.*
so to ensure that the same drives are used even after reboot. This
is very useful if you are testing for example with a virtualized
environment and are using PCIe passthrough with other qemu NVMe drives
with one or many NVMe drives.

To enable support just add a helper to canonicalize devices prior to
running the tests.

This allows one test runner, kdevops, which I just extended with
support to use real NVMe drives. The drives it uses for the filesystem
configuration optionally is with NVMe eui symlinks so to allow
the same drives to be used over reboots.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 check         |  1 +
 common/config | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 89e7e7bf20df..d063d3f498fd 100755
--- a/check
+++ b/check
@@ -734,6 +734,7 @@ function run_section()
 	fi
 
 	get_next_config $section
+	_canonicalize_devices
 
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
diff --git a/common/config b/common/config
index 936ac225f4b1..f5a3815a0435 100644
--- a/common/config
+++ b/common/config
@@ -655,6 +655,47 @@ _canonicalize_mountpoint()
 	echo "$parent/$base"
 }
 
+# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
+# over reboots
+_canonicalize_devices()
+{
+	if [ ! -z "$TEST_DEV" ] && [ -L $TEST_DEV ]; then
+		TEST_DEV=$(realpath -e $TEST_DEV)
+	fi
+
+	if [ ! -z "$SCRATCH_DEV" ] && [ -L $SCRATCH_DEV ]; then
+		SCRATCH_DEV=$(realpath -e $SCRATCH_DEV)
+	fi
+
+	if [ ! -z "$TEST_LOGDEV" ] && [ -L $TEST_LOGDEV ]; then
+		TEST_LOGDEV=$(realpath -e $TEST_LOGDEV)
+	fi
+
+	if [ ! -z "$TEST_RTDEV" ] && [ -L $TEST_RTDEV ]; then
+		TEST_RTDEV=$(realpath -e $TEST_RTDEV)
+	fi
+
+	if [ ! -z "$SCRATCH_RTDEV" ] && [ -L $SCRATCH_RTDEV ]; then
+		SCRATCH_RTDEV=$(realpath -e $SCRATCH_RTDEV)
+	fi
+
+	if [ ! -z "$LOGWRITES_DEV" ] && [ -L $LOGWRITES_DEV ]; then
+		LOGWRITES_DEV=$(realpath -e $LOGWRITES_DEV)
+	fi
+
+	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
+		NEW_SCRATCH_POOL=""
+		for i in $SCRATCH_DEV_POOL; do
+			if [ -L $i ]; then
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(realpath -e $i)"
+			else
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
+			fi
+		done
+		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
+	fi
+}
+
 # On check -overlay, for the non multi section config case, this
 # function is called on every test, before init_rc().
 # When SCRATCH/TEST_* vars are defined in config file, config file
@@ -785,7 +826,6 @@ get_next_config() {
 	fi
 
 	parse_config_section $1
-
 	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
 		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
@@ -901,5 +941,7 @@ else
 	fi
 fi
 
+_canonicalize_devices
+
 # make sure this script returns success
 /bin/true
-- 
2.39.2

