Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9954D43A41E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhJYUM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbhJYUMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:12:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF6C04A437;
        Mon, 25 Oct 2021 12:31:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 45CA11F43465;
        Mon, 25 Oct 2021 20:31:18 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v9 31/31] docs: Document the FAN_FS_ERROR event
Date:   Mon, 25 Oct 2021 16:27:46 -0300
Message-Id: <20211025192746.66445-32-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
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
Changes Since v8:
  - Replace fs-error specific errno bits with generic errno. (Jan)
  - Explain event order guarantees and point to example parser (Jan)
Changes Since v7:
  - Update semantics
Changes Since v6:
  - English fixes (jan)
  - Proper document error field (jan)
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
 .../admin-guide/filesystem-monitoring.rst     | 74 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst

diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
new file mode 100644
index 000000000000..5a3c84e60095
--- /dev/null
+++ b/Documentation/admin-guide/filesystem-monitoring.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+File system Monitoring with fanotify
+====================================
+
+File system Error Reporting
+===========================
+
+Fanotify supports the FAN_FS_ERROR event type for file system-wide error
+reporting.  It is meant to be used by file system health monitoring
+daemons, which listen for these events and take actions (notify
+sysadmin, start recovery) when a file system problem is detected.
+
+By design, a FAN_FS_ERROR notification exposes sufficient information
+for a monitoring tool to know a problem in the file system has happened.
+It doesn't necessarily provide a user space application with semantics
+to verify an IO operation was successfully executed.  That is out of
+scope for this feature.  Instead, it is only meant as a framework for
+early file system problem detection and reporting recovery tools.
+
+When a file system operation fails, it is common for dozens of kernel
+errors to cascade after the initial failure, hiding the original failure
+log, which is usually the most useful debug data to troubleshoot the
+problem.  For this reason, FAN_FS_ERROR tries to report only the first
+error that occurred for a file system since the last notification, and
+it simply counts additional errors.  This ensures that the most
+important pieces of information are never lost.
+
+FAN_FS_ERROR requires the fanotify group to be setup with the
+FAN_REPORT_FID flag.
+
+At the time of this writing, the only file system that emits FAN_FS_ERROR
+notifications is Ext4.
+
+A FAN_FS_ERROR Notification has the following format::
+
+  [ Notification Metadata (Mandatory) ]
+  [ Generic Error Record  (Mandatory) ]
+  [ FID record            (Mandatory) ]
+
+The order of records is not guaranteed, and new records might be added
+in the future.  Therefore, applications must not rely on the order and
+must be prepared to skip over unknown records. Please refer to
+``samples/fanotify/fs-monitor.c`` for an example parser.
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
+The `error` field identifies the type of error using errno values.
+`error_count` tracks the number of errors that occurred and were
+suppressed to preserve the original error information, since the last
+notification.
+
+FID record
+----------
+
+The FID record can be used to uniquely identify the inode that triggered
+the error through the combination of fsid and file handle.  A file system
+specific application can use that information to attempt a recovery
+procedure.  Errors that are not related to an inode are reported with an
+empty file handle of type FILEID_INVALID.
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
2.33.0

