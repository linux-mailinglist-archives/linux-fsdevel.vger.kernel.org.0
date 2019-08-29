Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15886A1BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfH2NlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 09:41:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32945 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfH2NlM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:41:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB09987521B;
        Thu, 29 Aug 2019 13:41:11 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FD89600C1;
        Thu, 29 Aug 2019 13:41:05 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtio-fs: add Documentation/filesystems/virtiofs.rst
Date:   Thu, 29 Aug 2019 14:41:04 +0100
Message-Id: <20190829134104.23653-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Thu, 29 Aug 2019 13:41:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add information about the new "virtiofs" file system.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Documentation/filesystems/index.rst    | 10 +++++
 Documentation/filesystems/virtiofs.rst | 60 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/filesystems/virtiofs.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 2de2fe2ab078..56e94bfc580f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -32,3 +32,13 @@ filesystem implementations.
 
    journalling
    fscrypt
+
+Filesystems
+===========
+
+Documentation for filesystem implementations.
+
+.. toctree::
+   :maxdepth: 2
+
+   virtiofs
diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
new file mode 100644
index 000000000000..4f338e3cb3f7
--- /dev/null
+++ b/Documentation/filesystems/virtiofs.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
+virtiofs: virtio-fs host<->guest shared file system
+===================================================
+
+- Copyright (C) 2019 Red Hat, Inc.
+
+Introduction
+============
+The virtiofs file system for Linux implements a driver for the paravirtualized
+VIRTIO "virtio-fs" device for guest<->host file system sharing.  It allows a
+guest to mount a directory that has been exported on the host.
+
+Guests often require access to files residing on the host or remote systems.
+Use cases include making files available to new guests during installation,
+booting from a root file system located on the host, persistent storage for
+stateless or ephemeral guests, and sharing a directory between guests.
+
+Although it is possible to use existing network file systems for some of these
+tasks, they require configuration steps that are hard to automate and they
+expose the storage network to the guest.  The virtio-fs device was designed to
+solve these problems by providing file system access without networking.
+
+Furthermore the virtio-fs device takes advantage of the co-location of the
+guest and host to increase performance and provide semantics that are not
+possible with network file systems.
+
+Usage
+=====
+Mount file system with tag ``myfs`` on ``/mnt``:
+
+.. code-block:: sh
+
+  guest# mount -t virtiofs myfs /mnt
+
+Please see https://virtio-fs.gitlab.io/ for details on how to configure QEMU
+and the virtiofsd daemon.
+
+Internals
+=========
+Since the virtio-fs device uses the FUSE protocol for file system requests, the
+virtiofs file system for Linux is integrated closely with the FUSE file system
+client.  The guest acts as the FUSE client while the host acts as the FUSE
+server.  The /dev/fuse interface between the kernel and userspace is replaced
+with the virtio-fs device interface.
+
+FUSE requests are placed into a virtqueue and processed by the host.  The
+response portion of the buffer is filled in by the host and the guest handles
+the request completion.
+
+Mapping /dev/fuse to virtqueues requires solving differences in semantics
+between /dev/fuse and virtqueues.  Each time the /dev/fuse device is read, the
+FUSE client may choose which request to transfer, making it possible to
+prioritize certain requests over others.  Virtqueues have queue semantics and
+it is not possible to change the order of requests that have been enqueued.
+This is especially important if the virtqueue becomes full since it is then
+impossible to add high priority requests.  In order to address this difference,
+the virtio-fs device uses a "hiprio" virtqueue specifically for requests that
+have priority over normal requests.
-- 
2.21.0

