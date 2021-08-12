Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566543EACBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhHLVmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbhHLVmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:42:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEAC061756;
        Thu, 12 Aug 2021 14:41:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 557BF1F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 21/21] docs: Document the FAN_FS_ERROR event
Date:   Thu, 12 Aug 2021 17:40:10 -0400
Message-Id: <20210812214010.3197279-22-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the FAN_FS_ERROR event for user administrators and user space
developers.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes Since v4:
  - Update documentation about reporting non-file error.
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
index 000000000000..b03093567a93
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
+the error through the combination of fsid and file handle.  A file system
+specific application can use that information to attempt a recovery
+procedure.  Errors that are not related to an inode are reported with an
+empty file handle, with type FILEID_INVALID.
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

