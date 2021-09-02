Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4013FF081
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhIBPwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345952AbhIBPwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630597866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbIKR6vpGbpbYb1RPSSjDiv86f88wuzCxmyG7KUinEo=;
        b=BDjXMB6I87z3SAp00FI5NckeBPuabt4OIL9akWW5WZIuNmPrBwc9Xx9Mg37Z1Qhku99EZe
        ux8UKzUqVGanpahj6eZOHx+G5I5OliKpXCyjF/i8ciMOoEG5dgwHqdQTMzYuqSOCaF0erW
        OWPpnVVsUwy0VX+L/BIoBZSFC+hJA4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-7nXw5JlVNGqxO5Q-TG1FtA-1; Thu, 02 Sep 2021 11:51:00 -0400
X-MC-Unique: 7nXw5JlVNGqxO5Q-TG1FtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04205189C44F;
        Thu,  2 Sep 2021 15:50:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3AFB77716;
        Thu,  2 Sep 2021 15:50:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4F8CA220257; Thu,  2 Sep 2021 11:50:53 -0400 (EDT)
Date:   Thu, 2 Sep 2021 11:50:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
Subject: [PATCH 4/1] xfstest: Add a new test to test xattr operations
Message-ID: <YTDy3XUxXpLKVIHH@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

generic/062 has been written with assumption that user.* xattrs will fail
on symlinks and special files. On newer kernel this will not be true. Found
it very hard to modify generic/062 so that it can deal with both the
possibilities. So creating a new test which basically is same as 062. Only
difference is that it runs only if user.* xattrs can be set on symlinks
and special files.

Given this test is more or less same as 062, I have retained original copyright
as well.

Modified the test slightly to bail out if kernel is older and user xattrs
are not supposed to be set on symlinks and special files.

This patch will need little modification if corresponding kernel changes
are merged upstream.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tests/generic/648     |  227 ++++++++++++++
 tests/generic/648.out |  766 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 993 insertions(+)

Index: xfstests-dev/tests/generic/648
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/tests/generic/648	2021-09-01 13:23:47.271016463 -0400
@@ -0,0 +1,227 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 648
+#
+# Exercises the getfattr/setfattr tools
+# Derived from test 062. Modified it so that it can run on kernels which
+# support user.* xattr on symlinks and special files.
+#
+. ./common/preamble
+_begin_fstest attr udf auto quick
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# Override the default cleanup function.
+_cleanup()
+{
+        cd /
+	echo; echo "*** unmount"
+	_scratch_unmount 2>/dev/null
+	rm -f $tmp.*
+}
+
+getfattr()
+{
+    _getfattr --absolute-names -dh $@ 2>&1 | _filter_scratch
+}
+
+setfattr()
+{
+    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
+}
+
+_create_test_bed()
+{
+	echo "*** create test bed"
+	touch $SCRATCH_MNT/reg
+	mkdir -p $SCRATCH_MNT/dir
+	ln -s $SCRATCH_MNT/dir $SCRATCH_MNT/lnk
+	mkdir $SCRATCH_MNT/dev
+	mknod $SCRATCH_MNT/dev/b b 0 0
+	mknod $SCRATCH_MNT/dev/c c 1 3
+	mknod $SCRATCH_MNT/dev/p p
+	# sanity check
+	find $SCRATCH_MNT | LC_COLLATE=POSIX sort | _filter_scratch | grep -v "lost+found"
+}
+
+# real QA test starts here
+_supported_fs generic
+
+_require_scratch
+_require_attrs
+_require_symlinks
+_require_mknod
+
+user_xattr_allowed()
+{
+	local kernel_version kernel_patchlevel
+
+	kernel_version=`uname -r | awk -F. '{print $1}'`
+	kernel_patchlevel=`uname -r | awk -F. '{print $2}'`
+
+	# Kernel version 5.14 onwards allow user xattr on symlink/special files.
+	[ $kernel_version -lt 5 ] && return 1
+	[ $kernel_patchlevel -lt 14 ] && return 1
+	return 0;
+}
+
+
+# Kernel version 5.14 onwards allow user xattr on symlink/special files.
+# Do not run this test on older kernels. Instead run the old test 062
+# which has been written with the assumption that user.* xattr
+# will not succeed on symlink and special files.
+user_xattr_allowed || _notrun "Kernel does not allows user.* xattrs on symlinks and special files. Skipping this test. Run test 062 instead."
+
+rm -f $tmp.backup1 $tmp.backup2 $seqres.full
+
+# real QA test starts here
+_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
+_scratch_mount
+_create_test_bed
+
+# In kernels before 3.0, getxattr() fails with EPERM for an attribute which
+# cannot exist.  Later kernels fail with ENODATA.  Accept both results.
+invalid_attribute_filter() {
+	sed -e "s:\(No such attribute\|Operation not permitted\):No such attribute or operation not permitted:"
+}
+
+if [ "$USE_ATTR_SECURE" = yes ]; then
+    ATTR_MODES="user security trusted"
+    ATTR_FILTER="^(user|security|trusted)"
+else
+    ATTR_MODES="user trusted"
+    ATTR_FILTER="^(user|trusted)"
+fi
+
+_require_attrs $ATTR_MODES
+
+for nsp in $ATTR_MODES; do
+	for inode in reg dir lnk dev/b dev/c dev/p; do
+
+		echo; echo "=== TYPE $inode; NAMESPACE $nsp"; echo
+		echo "*** set/get one initially empty attribute"
+
+		setfattr -h -n $nsp.name $SCRATCH_MNT/$inode
+		getfattr -m $nsp $SCRATCH_MNT/$inode
+
+		echo "*** overwrite empty, set several new attributes"
+		setfattr -h -n $nsp.name -v 0xbabe $SCRATCH_MNT/$inode
+		setfattr -h -n $nsp.name2 -v 0xdeadbeef $SCRATCH_MNT/$inode
+		setfattr -h -n $nsp.name3 -v 0xdeface $SCRATCH_MNT/$inode
+
+		echo "*** fetch several attribute names and values (hex)"
+		getfattr -m $nsp -e hex $SCRATCH_MNT/$inode
+
+		echo "*** fetch several attribute names and values (base64)"
+		getfattr -m $nsp -e base64 $SCRATCH_MNT/$inode
+
+		echo "*** shrink value of an existing attribute"
+		setfattr -h -n $nsp.name2 -v 0xdeaf $SCRATCH_MNT/$inode
+		getfattr -m $nsp -e hex $SCRATCH_MNT/$inode
+
+		echo "*** grow value of existing attribute"
+		setfattr -h -n $nsp.name2 -v 0xdecade $SCRATCH_MNT/$inode
+		getfattr -m $nsp -e hex $SCRATCH_MNT/$inode
+
+		echo "*** set an empty value for second attribute"
+		setfattr -h -n $nsp.name2 $SCRATCH_MNT/$inode
+		getfattr -m $nsp -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
+
+		echo "*** overwrite empty value"
+		setfattr -h -n $nsp.name2 -v 0xcafe $SCRATCH_MNT/$inode
+		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
+
+		echo "*** remove attribute"
+		setfattr -h -x $nsp.name2 $SCRATCH_MNT/$inode
+		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
+
+		echo "*** final list (strings, type=$inode, nsp=$nsp)"
+		getfattr -m $ATTR_FILTER -e hex $SCRATCH_MNT/$inode
+
+	done
+done
+
+#
+# Test the directory descent code
+#
+echo; echo
+
+_extend_test_bed()
+{
+	echo "*** extend test bed"
+	# must set some descents' attributes to be useful
+	mkdir -p $SCRATCH_MNT/here/up/ascend
+	mkdir -p $SCRATCH_MNT/descend/down/here
+	find $SCRATCH_MNT/descend | xargs setfattr -n user.x -v yz
+	find $SCRATCH_MNT/descend | xargs setfattr -n user.1 -v 23
+	find $SCRATCH_MNT/here | xargs setfattr -n trusted.a -v bc
+	find $SCRATCH_MNT/here | xargs setfattr -n trusted.9 -v 87
+	# whack a symlink in the middle, just to be difficult
+	ln -s $SCRATCH_MNT/here/up $SCRATCH_MNT/descend/and
+	# dump out our new starting point
+	find $SCRATCH_MNT | LC_COLLATE=POSIX sort | _filter_scratch | grep -v "lost+found"
+}
+
+_extend_test_bed
+
+echo
+echo "*** directory descent with us following symlinks"
+getfattr -h -L -R -m "$ATTR_FILTER" -e hex $SCRATCH_MNT | _sort_getfattr_output
+
+echo
+echo "*** directory descent without following symlinks"
+getfattr -h -P -R -m "$ATTR_FILTER" -e hex $SCRATCH_MNT | _sort_getfattr_output
+
+#
+# Test the backup/restore code
+#
+echo; echo
+
+_backup()
+{
+	# Note: we don't filter scratch here since we need to restore too.  But
+	# we *do* sort the output by path, since it otherwise would depend on
+	# readdir order, which on some filesystems may change after re-creating
+	# the files.
+	_getfattr --absolute-names -dh -R -m $ATTR_FILTER $SCRATCH_MNT | _sort_getfattr_output >$1
+	echo BACKUP $1 >>$seqres.full
+	cat $1 >> $seqres.full
+	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"
+}
+
+echo "*** backup everything"
+_backup $tmp.backup1
+
+echo "*** clear out the scratch device"
+rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
+echo "AFTER REMOVE" >>$seqres.full
+getfattr -L -R -m '.' $SCRATCH_MNT >>$seqres.full
+
+echo "*** reset test bed with no extended attributes"
+_create_test_bed
+_extend_test_bed
+
+echo "*** restore everything"
+setfattr -h --restore=$tmp.backup1
+_backup $tmp.backup2
+
+echo "AFTER RESTORE" >>$seqres.full
+getfattr -L -R -m '.' $SCRATCH_MNT >>$seqres.full
+
+echo "*** compare before and after backups"
+diff $tmp.backup1 $tmp.backup2
+if [ $? -ne 0 ]; then
+	echo "urk, failed - creating $seq.backup1 and $seq.backup2"
+	cp $tmp.backup1 $seq.backup1 && cp $tmp.backup2 $seq.backup2
+	status=1
+	exit
+fi
+
+# success, all done
+status=0
+exit
Index: xfstests-dev/tests/generic/648.out
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/tests/generic/648.out	2021-09-01 13:08:00.260016463 -0400
@@ -0,0 +1,766 @@
+QA output created by 648
+*** create test bed
+SCRATCH_MNT
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+
+=== TYPE reg; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=user)
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=user)
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/lnk
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/lnk
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/lnk
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/lnk
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/lnk
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/lnk
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/lnk
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=user)
+# file: SCRATCH_MNT/lnk
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dev/b; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/b
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/b
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/b
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/b
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/b
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/b
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/b
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=user)
+# file: SCRATCH_MNT/dev/b
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dev/c; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/c
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/c
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/c
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/c
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/c
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/c
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/c
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=user)
+# file: SCRATCH_MNT/dev/c
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dev/p; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/p
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/p
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/p
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/p
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/p
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/p
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/p
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=user)
+# file: SCRATCH_MNT/dev/p
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE reg; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=trusted)
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=trusted)
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/lnk
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/lnk
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/lnk
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/lnk
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/lnk: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=trusted)
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dev/b; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/b
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/b: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=trusted)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dev/c; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/c
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/c: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=trusted)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dev/p; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/p
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/p: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=trusted)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+
+*** extend test bed
+SCRATCH_MNT
+SCRATCH_MNT/descend
+SCRATCH_MNT/descend/and
+SCRATCH_MNT/descend/down
+SCRATCH_MNT/descend/down/here
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/here
+SCRATCH_MNT/here/up
+SCRATCH_MNT/here/up/ascend
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+
+*** directory descent with us following symlinks
+# file: SCRATCH_MNT/descend
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/and/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/descend/down
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down/here
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/here
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+*** directory descent without following symlinks
+# file: SCRATCH_MNT/descend
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down/here
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/here
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+
+*** backup everything
+*** clear out the scratch device
+*** reset test bed with no extended attributes
+*** create test bed
+SCRATCH_MNT
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+*** extend test bed
+SCRATCH_MNT
+SCRATCH_MNT/descend
+SCRATCH_MNT/descend/and
+SCRATCH_MNT/descend/down
+SCRATCH_MNT/descend/down/here
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/here
+SCRATCH_MNT/here/up
+SCRATCH_MNT/here/up/ascend
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+*** restore everything
+*** compare before and after backups
+
+*** unmount

