Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598A22C5ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGXNMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:12:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53276 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726768AbgGXNMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595596327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9IWhWk5HzoWyY9gKtQuImL5iYcdli7keEly6++cGLs=;
        b=fJR7ObC1wahEkZ7LyrgrVBWBIO+ULmt8GSBIUc45my4fUzbBp8mUtL3+qVg/T4nlnVAFVI
        ESA2/BsAdINMM3Ee2Ijyot4cpi/0axiyZua9L3lrJI6x4HkCOxM5e5FtxbkxN+5PnKqaIP
        9WmeY2eF6RGGKYLQZ56an0OY9DBHKN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-JIP63JXoOeCM8qjG8CCIWA-1; Fri, 24 Jul 2020 09:12:05 -0400
X-MC-Unique: JIP63JXoOeCM8qjG8CCIWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C26A2106B245;
        Fri, 24 Jul 2020 13:12:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF4D726B1;
        Fri, 24 Jul 2020 13:11:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/4] watch_queue: sample: Display mount tree change
 notifications
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        jlayton@redhat.com, kzak@redhat.com, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:11:58 +0100
Message-ID: <159559631836.2141315.12757117418181245451.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is run like:

	./watch_test

and watches "/" for changes to the mount topology and the attributes of
individual mount objects.

	# mount -t tmpfs none /mnt
	# mount -o remount,ro /mnt
	# mount -o remount,rw /mnt

producing:

	# ./watch_test
	read() = 16
	NOTIFY[000]: ty=000002 sy=00 i=02000010
	MOUNT 00000060 change=0[new_mount] aux=416
	read() = 16
	NOTIFY[000]: ty=000002 sy=04 i=02010010
	MOUNT 000001a0 change=4[setattr] aux=0
	read() = 16
	NOTIFY[000]: ty=000002 sy=04 i=02010010
	MOUNT 000001a0 change=4[setattr] aux=0

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/watch_queue/watch_test.c |   44 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 46e618a897fe..b526de016de4 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -26,6 +26,9 @@
 #ifndef __NR_keyctl
 #define __NR_keyctl -1
 #endif
+#ifndef __NR_watch_mount
+#define __NR_watch_mount -1
+#endif
 
 #define BUF_SIZE 256
 
@@ -58,6 +61,32 @@ static void saw_key_change(struct watch_notification *n, size_t len)
 	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
 }
 
+static const char *mount_subtypes[256] = {
+	[NOTIFY_MOUNT_NEW_MOUNT]	= "new_mount",
+	[NOTIFY_MOUNT_UNMOUNT]		= "unmount",
+	[NOTIFY_MOUNT_EXPIRY]		= "expiry",
+	[NOTIFY_MOUNT_READONLY]		= "readonly",
+	[NOTIFY_MOUNT_SETATTR]		= "setattr",
+	[NOTIFY_MOUNT_MOVE_FROM]	= "move_from",
+	[NOTIFY_MOUNT_MOVE_TO]		= "move_to",
+};
+
+static void saw_mount_change(struct watch_notification *n, size_t len)
+{
+	struct mount_notification *m = (struct mount_notification *)n;
+
+	if (len != sizeof(struct mount_notification))
+		return;
+
+	printf("MOUNT %08x change=%u[%s] aux=%u ctr=%x,%x actr=%x\n",
+	       m->triggered_on, n->subtype, mount_subtypes[n->subtype],
+	       m->auxiliary_mount,
+	       m->topology_changes,
+	       m->attr_changes,
+	       m->aux_topology_changes);
+
+}
+
 /*
  * Consume and display events.
  */
@@ -134,6 +163,9 @@ static void consumer(int fd)
 			default:
 				printf("other type\n");
 				break;
+			case WATCH_TYPE_MOUNT_NOTIFY:
+				saw_mount_change(&n.n, len);
+				break;
 			}
 
 			p += len;
@@ -142,12 +174,17 @@ static void consumer(int fd)
 }
 
 static struct watch_notification_filter filter = {
-	.nr_filters	= 1,
+	.nr_filters	= 2,
 	.filters = {
 		[0]	= {
 			.type			= WATCH_TYPE_KEY_NOTIFY,
 			.subtype_filter[0]	= UINT_MAX,
 		},
+		[1] = {
+			.type			= WATCH_TYPE_MOUNT_NOTIFY,
+			// Reject move-from notifications
+			.subtype_filter[0]	= UINT_MAX & ~(1 << NOTIFY_MOUNT_MOVE_FROM),
+		},
 	},
 };
 
@@ -181,6 +218,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (syscall(__NR_watch_mount, AT_FDCWD, "/", 0, fd, 0xde) == -1) {
+		perror("watch_mount");
+		exit(1);
+	}
+
 	consumer(fd);
 	exit(0);
 }


