Return-Path: <linux-fsdevel+bounces-63352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41EBB662B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34585344CFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CFA2DECA0;
	Fri,  3 Oct 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djqqn6FY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D22DCBEE
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484125; cv=none; b=PQKGDjePYU8eatsTrYtSNYb81YhPt1pFgu06ueueepMCvYhxGvVpBwX92Pan+iWy2QgGP75k0qfPg42iOv9lTQHimDmU2/OWvIf/Rtw10zJBkTTtVmMRexCQeB92+jxoUepQmqIXQDzdMV2PBVvw3OFyrQQeF6pnFxiugic920M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484125; c=relaxed/simple;
	bh=iP704VcV9TwuIpm8jhivhPESkzrVpMnittyD2c4PXZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFt4g8siaHk4YMBXSeKLJg5F9lFL+tVscveMNgP+4iCmDx4afN3bI5rdQM5SNEshrNf0a1elHWTU4PbNm4EbItYJ+nsDqDmbJJK8/1gvIAeHRE4kVgMHy7ESI0mlBQ7cFr8SN0HefcL5PgWJC5I91SW6rixkgIPB32LXJz3QKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djqqn6FY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759484121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PoxSHvCbr1UV4RUhVsu0NexP55KnHGnjc+JW7ihq9M=;
	b=djqqn6FYkq4uZW7hfJM4mA8kc5FYjjMSkkkYrHFtwoJQ8/tpphEPgUeG0Ejc/0DDufsBhR
	RUQYGbOX52+8nDqRzAk8aKfs9e1NmJVz2SUqCC7oVwRpvGg8Pr+wt3lbsx5SbFNzbuq3vL
	XoGCfFWuni+n7yhQmWIY3A84TDWTXnE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-7dIsBIsGMFKjBxj9rOVPkQ-1; Fri, 03 Oct 2025 05:35:18 -0400
X-MC-Unique: 7dIsBIsGMFKjBxj9rOVPkQ-1
X-Mimecast-MFC-AGG-ID: 7dIsBIsGMFKjBxj9rOVPkQ_1759484118
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so13917225e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 02:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484117; x=1760088917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PoxSHvCbr1UV4RUhVsu0NexP55KnHGnjc+JW7ihq9M=;
        b=L7fzX9tBzbM/5HTkqQtbwOM9o0T6S87Xkj6uv9awKp0/DNp/GdGAXa1jxJ7rqowdlI
         KdA4qzsqiqt7nl7x118ZmrEAy3WGRg2g/qrLKmk3HaB/bT9O1QuxeBd9ZhgieYCe/3yg
         QNlgefxbCynE2w1OiyXsnZsuajMYEWcXiaWcYbOFkPCt5m4rPhccvgyBRRmOOGjkpCYT
         /+FzY8IWFBG6EJdUXriaK4wWnaVRqiVmGr0bRBIXtetuFuY+W1eNDTLsX+RmMGZPkdbc
         h/tDUEviLJO0FzAiXMNmdtqL8xYybDJiyNsOfHP74yBlfZn1kpOdQeAXgzpsEIQcJpXM
         4Jew==
X-Forwarded-Encrypted: i=1; AJvYcCWbAVV3w04iIZo/ArWhcWXlQjnG4bd/LsugwLEcT+tvXKjYoGTYq24aANHHmINFw3DTlqmmpnes5EtIV6y/@vger.kernel.org
X-Gm-Message-State: AOJu0YyREt1l/5AwGnJfzAfWMLT9x6R4AGpw4vCigjaaZ2OssRPdxbYs
	KS/Ko/GqCF0C/RwTTdDELU5RJfsFR7BJRSvU1YKEniRLqXYGYFP3pJmrenroCZ8O/2f2jOU9kvN
	7jrdJvgwxcsLUdvDsy62zAys8PkBNWg2wZbK1GyL0c7Tccm5Y5iC3Mmgs5hOm+g5HjA==
X-Gm-Gg: ASbGncs2T4YaJPdqeoxR9+XYesuD696nFK5lv3SjA+yirZeRaI63dz5QeQq8EbU8I8T
	crjpiyb+FoKBMG6XrFc2y/XgRqsCPM63VWXogGljY3tQxyg8qd+ruLF2DizXkLscQT9eL8D5u9s
	ez8LUcwZoqEksHNAzK4r0mxCiG9Wb7gjctlUKfskydmYQRBMBGMRVQgThlubkYzRhpqeEOe5LxC
	JUQXFqy21UB16rsglpHNi+71EhTz5NCEk6OU5848pn7Fl7Ido2przRDld5RQUG+z7gQUNHtff5D
	U7qG01D+KMOZ4r1yDbzUdtsGOqHVzM1q5AON3CPmlD5ggtOe99CeXsKZqshpTAmhs+kiMGOM
X-Received: by 2002:a05:600c:3b0a:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46e71140bbemr14206215e9.23.1759484116839;
        Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfbd3Ro3K1biENsTxKxXhS4/gs2QzktTtVsOnNuk3kWFxKAkDjJiRqxFPJQlkIu74ous66XQ==
X-Received: by 2002:a05:600c:3b0a:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46e71140bbemr14206035e9.23.1759484116280;
        Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm121695005e9.10.2025.10.03.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:15 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 03 Oct 2025 11:32:45 +0200
Subject: [PATCH v4 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-xattrat-syscall-v4-2-1cfe6411c05f@kernel.org>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
In-Reply-To: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6564; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=iP704VcV9TwuIpm8jhivhPESkzrVpMnittyD2c4PXZg=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMu7PuKgWMC+IR/2ErFGLHN8WUZnjTKUWB2v37JdnO
 H9vWvb0RYs7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATMQgmpGh12H2wvfGa7u/
 ncz4NuPvqh2Xs9+umR0eb2XjxD1fI0N3IsNPxuN7TuQ2P/XKdJCbdmzmkzm6ccemKm74VBX8j/u
 X8yJGdgDdH0iv
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to test basic functionality of file_getattr() and
file_setattr() syscalls. Most of the work is done in file_attr
utility.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/filter          |  15 +++++++
 tests/generic/2000     | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++++++++++++
 3 files changed, 161 insertions(+)

diff --git a/common/filter b/common/filter
index bbe13f4c8a8d..b330b27827d0 100644
--- a/common/filter
+++ b/common/filter
@@ -683,5 +683,20 @@ _filter_sysfs_error()
 	sed 's/.*: \(.*\)$/\1/'
 }
 
+# Filter file attributes (aka lsattr/chattr)
+# To filter X:
+# 	... | _filter_file_attributes X
+# Or to filter all except X
+# 	... | _filter_file_attributes ~X
+_filter_file_attributes()
+{
+	if [[ $1 == ~* ]]; then
+		regex=$(echo "[aAcCdDeEFijmNPsStTuxVX]" | tr -d "$1")
+	else
+		regex="$1"
+	fi
+	awk "{ printf \"%s \", gensub(\"$regex\", \"-\", \"g\", \$1) } {print \$2}"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/2000 b/tests/generic/2000
new file mode 100755
index 000000000000..16045829031a
--- /dev/null
+++ b/tests/generic/2000
@@ -0,0 +1,109 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 2000
+#
+# Test file_getattr/file_setattr syscalls
+#
+. ./common/preamble
+_begin_fstest auto
+
+. ./common/filter
+
+# Modify as appropriate.
+_require_scratch
+_require_test_program "af_unix"
+_require_test_program "file_attr"
+_require_symlinks
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+file_attr () {
+	$here/src/file_attr $*
+}
+
+create_af_unix () {
+	$here/src/af_unix $* || echo af_unix failed
+}
+
+projectdir=$SCRATCH_MNT/prj
+
+# Create normal files and special files
+mkdir $projectdir
+mkfifo $projectdir/fifo
+mknod $projectdir/chardev c 1 1
+mknod $projectdir/blockdev b 1 1
+create_af_unix $projectdir/socket
+touch $projectdir/foo
+ln -s $projectdir/foo $projectdir/symlink
+touch $projectdir/bar
+ln -s $projectdir/bar $projectdir/broken-symlink
+rm -f $projectdir/bar
+
+echo "Error codes"
+# wrong AT_ flags
+file_attr --get --invalid-at $projectdir ./foo
+file_attr --set --invalid-at $projectdir ./foo
+# wrong fsxattr size (too big, too small)
+file_attr --get --too-big-arg $projectdir ./foo
+file_attr --get --too-small-arg $projectdir ./foo
+file_attr --set --too-big-arg $projectdir ./foo
+file_attr --set --too-small-arg $projectdir ./foo
+# out of fsx_xflags mask
+file_attr --set --new-fsx-flag $projectdir ./foo
+
+echo "Initial attributes state"
+file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
+file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
+file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
+file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
+file_attr --get $projectdir ./socket | _filter_file_attributes ~d
+file_attr --get $projectdir ./foo | _filter_file_attributes ~d
+file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
+
+echo "Set FS_XFLAG_NODUMP (d)"
+file_attr --set --set-nodump $projectdir
+file_attr --set --set-nodump $projectdir ./fifo
+file_attr --set --set-nodump $projectdir ./chardev
+file_attr --set --set-nodump $projectdir ./blockdev
+file_attr --set --set-nodump $projectdir ./socket
+file_attr --set --set-nodump $projectdir ./foo
+file_attr --set --set-nodump $projectdir ./symlink
+
+echo "Read attributes"
+file_attr --get $projectdir | _filter_scratch | _filter_file_attributes ~d
+file_attr --get $projectdir ./fifo | _filter_file_attributes ~d
+file_attr --get $projectdir ./chardev | _filter_file_attributes ~d
+file_attr --get $projectdir ./blockdev | _filter_file_attributes ~d
+file_attr --get $projectdir ./socket | _filter_file_attributes ~d
+file_attr --get $projectdir ./foo | _filter_file_attributes ~d
+file_attr --get $projectdir ./symlink | _filter_file_attributes ~d
+
+echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
+file_attr --set --set-nodump $projectdir ./broken-symlink
+file_attr --get $projectdir ./broken-symlink
+
+file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
+file_attr --get --no-follow $projectdir ./broken-symlink | _filter_file_attributes ~d
+
+cd $SCRATCH_MNT
+touch ./foo2
+echo "Initial state of foo2"
+file_attr --get --at-cwd ./foo2 | _filter_file_attributes ~d
+echo "Set attribute relative to AT_FDCWD"
+file_attr --set --at-cwd --set-nodump ./foo2
+file_attr --get --at-cwd ./foo2 | _filter_file_attributes ~d
+
+echo "Set attribute on AT_FDCWD"
+mkdir ./bar
+file_attr --get --at-cwd ./bar | _filter_file_attributes ~d
+cd ./bar
+file_attr --set --at-cwd --set-nodump ""
+file_attr --get --at-cwd . | _filter_file_attributes ~d
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/2000.out b/tests/generic/2000.out
new file mode 100644
index 000000000000..e6fc7381709b
--- /dev/null
+++ b/tests/generic/2000.out
@@ -0,0 +1,37 @@
+QA output created by 2000
+Error codes
+Can not get fsxattr on ./foo: Invalid argument
+Can not get fsxattr on ./foo: Invalid argument
+Can not get fsxattr on ./foo: Argument list too long
+Can not get fsxattr on ./foo: Invalid argument
+Can not get fsxattr on ./foo: Argument list too long
+Can not get fsxattr on ./foo: Invalid argument
+Can not set fsxattr on ./foo: Invalid argument
+Initial attributes state
+----------------- SCRATCH_MNT/prj
+----------------- ./fifo
+----------------- ./chardev
+----------------- ./blockdev
+----------------- ./socket
+----------------- ./foo
+----------------- ./symlink
+Set FS_XFLAG_NODUMP (d)
+Read attributes
+------d---------- SCRATCH_MNT/prj
+------d---------- ./fifo
+------d---------- ./chardev
+------d---------- ./blockdev
+------d---------- ./socket
+------d---------- ./foo
+------d---------- ./symlink
+Set attribute on broken link with AT_SYMLINK_NOFOLLOW
+Can not get fsxattr on ./broken-symlink: No such file or directory
+Can not get fsxattr on ./broken-symlink: No such file or directory
+------d---------- ./broken-symlink
+Initial state of foo2
+----------------- ./foo2
+Set attribute relative to AT_FDCWD
+------d---------- ./foo2
+Set attribute on AT_FDCWD
+----------------- ./bar
+------d---------- .

-- 
2.50.1


