Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314AF3CFECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhGTP2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:28:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhGTPUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:20:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id CF9281F4314E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 16/16] docs: Document the FAN_FS_ERROR event
Date:   Tue, 20 Jul 2021 11:59:44 -0400
Message-Id: <20210720155944.1447086-17-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720155944.1447086-1-krisman@collabora.com>
References: <20210720155944.1447086-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the FAN_FS_ERROR event for user administrators and user space
developers.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes Since v3:
  - Move FAN_FS_ERROR notification into a subsection of the file.
Changes Since v2:
  - NTR
Changes since v1:
  - Drop references to location record
  - Explain that the inode field is optional
  - Explain we are reporting only the first error
---
 .../admin-guide/filesystem-monitoring.rst     | 70 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst

diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
new file mode 100644
index 000000000000..6c8982985a27
--- /dev/null
+++ b/Documentation/admin-guide/filesystem-monitoring.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+File system Monitoring with fanotify
+====================================
+
+File system Error Reporting
+===========================
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
+FAN_FS_ERROR requires the fanotify group to be setup with the
+FAN_REPORT_FID flag.
+
+At the time of this writing, the only file system that emits FAN_FS_ERROR
+notifications is Ext4.
+
+A user space example code is provided at ``samples/fanotify/fs-monitor.c``.
+
+A FAN_FS_ERROR Notification has the following format::
+
+  [ Notification Metadata (Mandatory) ]
+  [ Generic Error Record  (Mandatory) ]
+  [ FID record            (Mandatory) ]
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
+	__s32 error;
+	__u32 error_count;
+  };
+
+The `error` field identifies the type of error. `error_count` count
+tracks the number of errors that occurred and were suppressed to
+preserve the original error, since the last notification.
+
+FID record
+----------
+
+The FID record can be used to uniquely identify the inode that triggered
+the error through the combination of fsid and file handler.  A
+filesystem specific handler can use that information to attempt a
+recovery procedure.  Errors that are not related to an inode are
+reported against the root inode.
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
2.32.0

