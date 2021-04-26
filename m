Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB37D36B948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhDZSpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbhDZSoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:44:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3035C06138E;
        Mon, 26 Apr 2021 11:43:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4ABEC1F422DD
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 15/15] Documentation: Document the FAN_ERROR framework
Date:   Mon, 26 Apr 2021 14:42:01 -0400
Message-Id: <20210426184201.4177978-16-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../admin-guide/filesystem-monitoring.rst     | 103 ++++++++++++++++++
 Documentation/admin-guide/index.rst           |   1 +
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst

diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
new file mode 100644
index 000000000000..e19bf792dd7a
--- /dev/null
+++ b/Documentation/admin-guide/filesystem-monitoring.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+File system Monitoring with fanotify
+====================================
+
+fanotify supports the FAN_ERROR mark for file system-wide error
+reporting.  It is meant to be used by file system health monitoring
+daemons who listen on that interface and take actions (notify sysadmin,
+start recovery) when a file system problem is detected by the kernel.
+
+By design, A FAN_ERROR notification exposes sufficient information for a
+monitoring tool to map a problem to specific region of the file system
+or its code and trigger recovery procedures.  It doesn't necessarily
+provide a user space application with semantics to verify an IO
+operation was successfully executed.  That is outside of scope of this
+feature. Instead, it is only meant as a framework for early file system
+problem detection and reporting recovery tools.
+
+At the time of this writing, the only file system that emits this
+FAN_ERROR notifications is ext4.
+
+An example code for ext4 is provided at ``samples/fanotify/fs-monitor.c``.
+
+Usage
+=====
+
+In order to guarantee notification delivery on different error
+conditions, FAN_ERROR requires the fanotify group to be created with
+FAN_PREALLOC_QUEUE.  This means a group that emits FAN_ERROR
+notifications currently cannot be reused for any other kind of
+notification.
+
+To setup a group for error notification::
+
+  fanotify_init(FAN_CLASS_NOTIF | FAN_PREALLOC_QUEUE, O_RDONLY);
+
+Then, enable the FAN_ERROR mark on a specific path::
+
+  fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_ERROR, AT_FDCWD, "/mnt");
+
+Notification structure
+======================
+
+A FAN_ERROR Notification has the following format::
+
+  [ Notification Metadata (Mandatory) ]
+  [ Generic Error Record  (Mandatory) ]
+  [ Error Location Record (Optional)  ]
+  [ FS-Specific Record    (Optional)  ]
+
+With the exception of the notification metadata and the generic
+information, all information records are optional.  Each record type is
+identified by its unique ``struct fanotify_event_info_header.info_type``.
+
+Generic error Location
+----------------------
+
+The Generic error record provides enough information for a file system
+agnostic tool to learn about a problem in the file system, without
+requiring any details about the problem.::
+
+  struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;  /* info_type = FAN_EVENT_INFO_TYPE_ERROR */
+	int version;
+	int error;
+	__kernel_fsid_t fsid;
+  };
+
+Error Location Record
+---------------------
+
+Error location is required by some use cases to easily associate an
+error with a specific line of code.  Not every user case requires it and
+they might not be emitted for different file systems.
+
+Notice this field is variable length, but its size is found in ```hdr.len```.::
+
+  struct fanotify_event_info_location {
+	struct fanotify_event_info_header hdr; /* info_type = FAN_EVENT_INFO_TYPE_LOCATION */
+	int line;
+	char function[0];
+  };
+
+File system specific Record
+---------------------------
+
+The file system specific record attempts to provide file system specific
+tools with enough information to uniquely identify the problem and
+hopefully recover from it.
+
+Since each file system defines its own specific data, this record is
+composed by a header, followed by a data blob, that is defined by each
+file system.  Review the file system documentation for more information.
+
+While the hdr.info_type identifies the presence of this field,
+``hdr.len`` field identifies the length of the file system specific
+structure following the header.::
+
+  struct fanotify_event_info_fsdata {
+	struct fanotify_event_info_header hdr; /* info_type = FAN_EVENT_INFO_TYPE_FSDATA */
+	struct data[0];
+  };
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 423116c4e787..a0d1bf76629f 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -83,6 +83,7 @@ configure specific aspects of kernel behavior to your liking.
    edid
    efi-stub
    ext4
+   filesystem-monitoring
    nfs/index
    gpio/index
    highuid
-- 
2.31.0

