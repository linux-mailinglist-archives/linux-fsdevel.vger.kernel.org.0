Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9D3A8D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhFOX7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhFOX7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:59:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39170C061574;
        Tue, 15 Jun 2021 16:56:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DA8271F43350
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 14/14] Documentation: Document the FAN_FS_ERROR event
Date:   Tue, 15 Jun 2021 19:55:56 -0400
Message-Id: <20210615235556.970928-15-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the FAN_FS_ERROR event for user administrators and user space
developers.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Drop references to location record
  - Explain that the inode field is optional
  - Explain we are reporting only the first error
---
 .../admin-guide/filesystem-monitoring.rst     | 63 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst

diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
new file mode 100644
index 000000000000..3710302676af
--- /dev/null
+++ b/Documentation/admin-guide/filesystem-monitoring.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+File system Monitoring with fanotify
+====================================
+
+fanotify supports the FAN_FS_ERROR mark for file system-wide error
+reporting.  It is meant to be used by file system health monitoring
+daemons who listen on that interface and take actions (notify sysadmin,
+start recovery) when a file system problem is detected by the kernel.
+
+By design, A FAN_FS_ERROR notification exposes sufficient information for a
+monitoring tool to know a problem in the file system has happened.  It
+doesn't necessarily provide a user space application with semantics to
+verify an IO operation was successfully executed.  That is outside of
+scope of this feature. Instead, it is only meant as a framework for
+early file system problem detection and reporting recovery tools.
+
+When a file system operation fails, it is common for dozens of kernel
+errors to cascade after the initial failure, hiding the original failure
+log, which is usually the most useful debug data to troubleshoot the
+problem.  For this reason, FAN_FS_ERROR only reports the first error that
+occurred since the last notification, and it simply counts addition
+errors.  This ensures that the most important piece of error information
+is never lost.
+
+At the time of this writing, the only file system that emits FAN_FS_ERROR
+notifications is Ext4.
+
+A user space example code is provided at ``samples/fanotify/fs-monitor.c``.
+
+Notification structure
+======================
+
+A FAN_FS_ERROR Notification has the following format::
+
+  [ Notification Metadata (Mandatory) ]
+  [ Generic Error Record  (Mandatory) ]
+
+Generic error record
+--------------------
+
+The generic error record provides enough information for a file system
+agnostic tool to learn about a problem in the file system, without
+providing any additional details about the problem.  This record is
+identified by ``struct fanotify_event_info_header.info_type`` being set
+to FAN_EVENT_INFO_TYPE_ERROR.
+
+  struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	int error;
+	__u32 error_count;
+	__kernel_fsid_t fsid;
+	__u64 ino;
+	__u32 ino_generation;
+  };
+
+The `error` field identifies the type of error.  `fsid` identifies the
+file system that originated the error, since multiple file systems might
+be reporting to the same fanotify group.  The `inode` field is optional,
+as it depends on whether the error is linked to an specific inode.
+`error_count` count tracks the number of errors that occurred and were
+suppressed to preserve the original error, since the last notification.
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index dc00afcabb95..1bedab498104 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -82,6 +82,7 @@ configure specific aspects of kernel behavior to your liking.
    edid
    efi-stub
    ext4
+   filesystem-monitoring
    nfs/index
    gpio/index
    highuid
-- 
2.31.0

