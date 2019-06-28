Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA259F72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfF1Prz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfF1Pry (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A8E8308624A;
        Fri, 28 Jun 2019 15:47:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC2C35B683;
        Fri, 28 Jun 2019 15:47:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/6] fsinfo: Add documentation for mount and sb watches [ver
 #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:47:51 +0100
Message-ID: <156173687101.14728.6401356872306559415.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
References: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 15:47:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the fsinfo documentation to mention mount and sb watches.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/fsinfo.rst |   38 +++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fsinfo.rst b/Documentation/filesystems/fsinfo.rst
index 86c187a46396..ef79582b991d 100644
--- a/Documentation/filesystems/fsinfo.rst
+++ b/Documentation/filesystems/fsinfo.rst
@@ -7,7 +7,8 @@ security information beyond what stat(), statx() and statfs() can query.  It
 does not require a file to be opened as does ioctl().
 
 fsinfo() may be called on a path, an open file descriptor, a filesystem-context
-file descriptor as allocated by fsopen() or fspick().
+file descriptor as allocated by fsopen() or fspick() or a mount ID (allowing
+for mounts concealed by overmounts to be accessed).
 
 The fsinfo() system call needs to be configured on by enabling:
 
@@ -235,6 +236,10 @@ To summarise the attributes that are defined::
   FSINFO_ATTR_SERVER_NAME		N × string
   FSINFO_ATTR_SERVER_ADDRESS		N × M × struct
   FSINFO_ATTR_AFS_CELL_NAME		string
+  FSINFO_ATTR_MOUNT_INFO		struct
+  FSINFO_ATTR_MOUNT_DEVNAME		string
+  FSINFO_ATTR_MOUNT_CHILDREN		array
+  FSINFO_ATTR_MOUNT_SUBMOUNT		N × string
 
 
 Attribute Catalogue
@@ -386,6 +391,37 @@ before any superblock is attached:
     before noting any other parameters.
 
 
+Then there are attributes that convey information about the mount topology:
+
+ *  ``FSINFO_ATTR_MOUNT_INFO``
+
+    This struct-type attribute conveys information about a mount topology node
+    rather than a superblock.  This includes the ID of the superblock mounted
+    there and the ID of the mount node, its parent, group, master and
+    propagation source.  It also contains the attribute flags for the mount and
+    a change counter so that it can be quickly determined if that node changed.
+
+ *  ``FSINFO_ATTR_MOUNT_DEVNAME``
+
+    This string-type attribute returns the "device name" that was supplied when
+    the mount object was created.
+
+ *  ``FSINFO_ATTR_MOUNT_CHILDREN``
+
+    This is an array-type attribute that conveys a set of structs, each of
+    which indicates the mount ID of a child and the change counter for that
+    child.  The kernel also tags an extra element on the end that indicates the
+    ID and change counter of the queried object.  This allows a conflicting
+    change to be quickly detected by comparing the before and after counters.
+
+ *  ``FSINFO_ATTR_MOUNT_SUBMOUNT``
+
+    This is a string-type attribute that conveys the pathname of the Nth
+    mountpoint under the target mount, relative to the mount root or the
+    chroot, whichever is closer.  These correspond on a 1:1 basis with the
+    elements in the FSINFO_ATTR_MOUNT_CHILDREN list.
+
+
 Then there are filesystem-specific attributes.
 
  *  ``FSINFO_ATTR_SERVER_NAME``

