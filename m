Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603DB59FDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfF1Puj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfF1Puj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9FDE30832D8;
        Fri, 28 Jun 2019 15:50:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404FD6013A;
        Fri, 28 Jun 2019 15:50:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] Adjust watch_queue documentation to mention mount and
 superblock watches. [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:50:35 +0100
Message-ID: <156173703546.15650.14319137940607993268.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
References: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 28 Jun 2019 15:50:39 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst |   20 +++++++++++++++++++-
 drivers/misc/Kconfig          |    5 +++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 4087a8e670a8..1bec2018d549 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -13,6 +13,10 @@ receive notifications from the kernel.  This can be used in conjunction with::
 
     * USB subsystem event notifications
 
+  * Mount topology change notifications
+
+  * Superblock event notifications
+
 
 The notifications buffers can be enabled by:
 
@@ -324,6 +328,19 @@ Any particular buffer can be fed from multiple sources.  Sources include:
     for buses and devices.  Watchpoints of this type are set on the global
     device watch list.
 
+  * WATCH_TYPE_MOUNT_NOTIFY
+
+    Notifications of this type indicate mount tree topology changes and mount
+    attribute changes.  A watch can be set on a particular file or directory
+    and notifications from the path subtree rooted at that point will be
+    intercepted.
+
+  * WATCH_TYPE_SB_NOTIFY
+
+    Notifications of this type indicate superblock events, such as quota limits
+    being hit, I/O errors being produced or network server loss/reconnection.
+    Watches of this type are set directly on superblocks.
+
 
 Event Filtering
 ===============
@@ -365,7 +382,8 @@ Where:
 	(watch.info & info_mask) == info_filter
 
     This could be used, for example, to ignore events that are not exactly on
-    the watched point in a mount tree.
+    the watched point in a mount tree by specifying NOTIFY_MOUNT_IN_SUBTREE
+    must be 0.
 
   * ``subtype_filter`` is a bitmask indicating the subtypes that are of
     interest.  Bit 0 of subtype_filter[0] corresponds to subtype 0, bit 1 to
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e53f88783fe7..8b13103b17c0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -11,8 +11,9 @@ config WATCH_QUEUE
 	help
 	  This is a general notification queue for the kernel to pass events to
 	  userspace through a mmap()'able ring buffer.  It can be used in
-	  conjunction with watches for key/keyring change notifications and device
-	  notifications.
+	  conjunction with watches for key/keyring change notifications, device
+	  notifications, mount topology change notifications, and superblock
+	  change notifications.
 
 	  Note that in theory this should work fine with NOMMU, but I'm not
 	  sure how to make that work.

