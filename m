Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64617E008
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCIMTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 08:19:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726677AbgCIMTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583756393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyJi62FBwsHTe3Zl4H44iXaw4BfzG8ra8uaMuD9rQ7s=;
        b=bKXVbKzqgRe5FH/3GQb3LFZqmwwPQPG9A2M++Qsvtf3KoDbTTSFLYmBcsIwL3DwjIWMTYB
        anpiy9c9PQ9BaiUKa0HXqM5nsML1TQtTlYQZzkeTk+WetYprPaR/69qqf78aWyuEhJ3KKH
        84vv7ItkUXWgvt2ztNlD0Bg2Q9p4U5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Wsrr7mZfMMSBkoQbAWtN0g-1; Mon, 09 Mar 2020 08:19:51 -0400
X-MC-Unique: Wsrr7mZfMMSBkoQbAWtN0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E51A100550E;
        Mon,  9 Mar 2020 12:19:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4FE1001B3F;
        Mon,  9 Mar 2020 12:19:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 17/17] watch_queue: sample: Display superblock
 notifications [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, andres@anarazel.de, jlayton@redhat.com,
        dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 12:19:46 +0000
Message-ID: <158375638603.334846.5465237543300472274.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The notification is run as:

	./watch_test

and it then watches "/mnt" for superblock notifications:

	# mount -t tmpfs none /mnt
	# ./watch_test &
	# mount -o remount,ro /mnt
	# mount -o remount,rw /mnt

producing:

	# ./watch_test
	NOTIFY[000]: ty=000003 sy=00 i=03010010
	SUPER 157eb57ca7 change=0[readonly]
	read() = 16
	NOTIFY[000]: ty=000002 sy=04 i=02010010
	MOUNT 000001a0 change=4[setattr] aux=0
	read() = 16
	NOTIFY[000]: ty=000002 sy=04 i=02010010
	MOUNT 000001a0 change=4[setattr] aux=0

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/watch_queue/watch_test.c |   39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 49d185150506..eea3bd8c6569 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -29,6 +29,9 @@
 #ifndef __NR_watch_mount
 #define __NR_watch_mount -1
 #endif
+#ifndef __NR_watch_sb
+#define __NR_watch_sb -1
+#endif
 
 #define BUF_SIZE 256
 
@@ -82,6 +85,24 @@ static void saw_mount_change(struct watch_notification *n, size_t len)
 	       m->triggered_on, n->subtype, mount_subtypes[n->subtype], m->changed_mount);
 }
 
+static const char *super_subtypes[256] = {
+	[NOTIFY_SUPERBLOCK_READONLY]	= "readonly",
+	[NOTIFY_SUPERBLOCK_ERROR]	= "error",
+	[NOTIFY_SUPERBLOCK_EDQUOT]	= "edquot",
+	[NOTIFY_SUPERBLOCK_NETWORK]	= "network",
+};
+
+static void saw_super_change(struct watch_notification *n, size_t len)
+{
+	struct superblock_notification *s = (struct superblock_notification *)n;
+
+	if (len < sizeof(struct superblock_notification))
+		return;
+
+	printf("SUPER %08llx change=%u[%s]\n",
+	       s->sb_id, n->subtype, super_subtypes[n->subtype]);
+}
+
 /*
  * Consume and display events.
  */
@@ -161,6 +182,9 @@ static void consumer(int fd)
 			case WATCH_TYPE_MOUNT_NOTIFY:
 				saw_mount_change(&n.n, len);
 				break;
+			case WATCH_TYPE_SB_NOTIFY:
+				saw_super_change(&n.n, len);
+				break;
 			}
 
 			p += len;
@@ -169,7 +193,7 @@ static void consumer(int fd)
 }
 
 static struct watch_notification_filter filter = {
-	.nr_filters	= 2,
+	.nr_filters	= 3,
 	.filters = {
 		[0]	= {
 			.type			= WATCH_TYPE_KEY_NOTIFY,
@@ -180,6 +204,14 @@ static struct watch_notification_filter filter = {
 			// Reject move-from notifications
 			.subtype_filter[0]	= UINT_MAX & ~(1 << NOTIFY_MOUNT_MOVE_FROM),
 		},
+		[2]	= {
+			.type			= WATCH_TYPE_SB_NOTIFY,
+			// Only accept notification of changes to R/O state
+			.subtype_filter[0]	= (1 << NOTIFY_SUPERBLOCK_READONLY),
+			// Only accept notifications of change-to-R/O
+			.info_mask		= WATCH_INFO_FLAG_0,
+			.info_filter		= WATCH_INFO_FLAG_0,
+		},
 	},
 };
 
@@ -218,6 +250,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (syscall(__NR_watch_sb, AT_FDCWD, "/mnt", 0, fd, 0x03) == -1) {
+		perror("watch_sb");
+		exit(1);
+	}
+
 	consumer(fd);
 	exit(0);
 }


