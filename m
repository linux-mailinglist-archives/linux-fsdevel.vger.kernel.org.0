Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089C61685E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBUSCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:02:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729545AbgBUSCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyJi62FBwsHTe3Zl4H44iXaw4BfzG8ra8uaMuD9rQ7s=;
        b=GhOpGCmJDr4KjUg2Ba9/FxJsG8zCEssW6Cl5oaJvi/BmWXeFPW064clYErOtkVX8QVDfqw
        v85iEQJ+O4xoDuHRzOAgpOi9GOw0754NMm3yL/UdHrkmGpue9Y8tjycT9vNK7dVm/utKR8
        SJXnbXtlKaedo0u2H9WWOnLDnR+nG10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216--scizVTAMaqFNbUQPxuW4Q-1; Fri, 21 Feb 2020 13:02:40 -0500
X-MC-Unique: -scizVTAMaqFNbUQPxuW4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D014E1005513;
        Fri, 21 Feb 2020 18:02:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17C7660C63;
        Fri, 21 Feb 2020 18:02:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/17] watch_queue: sample: Display superblock notifications
 [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:02:36 +0000
Message-ID: <158230815634.2185128.9507318728078606539.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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


