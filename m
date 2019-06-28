Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7E59FF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfF1PvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfF1PvP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:51:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 761BF3086215;
        Fri, 28 Jun 2019 15:51:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D68671001B17;
        Fri, 28 Jun 2019 15:51:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/6] Add sample notification program [ver #5]
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
Date:   Fri, 28 Jun 2019 16:51:11 +0100
Message-ID: <156173707116.15650.11875602081597740176.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
References: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 28 Jun 2019 15:51:14 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This needs to be linked with -lkeyutils.

It is run like:

	./watch_test

and watches "/" for mount changes and the current session keyring for key
changes:

	# keyctl add user a a @s
	1035096409
	# keyctl unlink 1035096409 @s
	# mount -t tmpfs none /mnt/nfsv3tcp/
	# umount /mnt/nfsv3tcp

producing:

	# ./watch_test
	ptrs h=4 t=2 m=20003
	NOTIFY[00000004-00000002] ty=0003 sy=0002 i=01000010
	KEY 2ffc2e5d change=2[linked] aux=1035096409
	ptrs h=6 t=4 m=20003
	NOTIFY[00000006-00000004] ty=0003 sy=0003 i=01000010
	KEY 2ffc2e5d change=3[unlinked] aux=1035096409
	ptrs h=8 t=6 m=20003
	NOTIFY[00000008-00000006] ty=0001 sy=0000 i=02000010
	MOUNT 00000013 change=0[new_mount] aux=168
	ptrs h=a t=8 m=20003
	NOTIFY[0000000a-00000008] ty=0001 sy=0001 i=02000010
	MOUNT 00000013 change=1[unmount] aux=168

Other events may be produced, such as with a failing disk:

	ptrs h=5 t=2 m=6000004
	NOTIFY[00000005-00000002] ty=0004 sy=0006 i=04000018
	BLOCK 00800050 e=6[critical medium] s=5be8

This corresponds to:

	print_req_error: critical medium error, dev sdf, sector 23528 flags 0

in dmesg.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/watch_queue/watch_test.c |   76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index f792c13614f4..0018ecac188a 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -30,6 +30,12 @@
 #ifndef __NR_watch_devices
 #define __NR_watch_devices -1
 #endif
+#ifndef __NR_watch_mount
+#define __NR_watch_mount -1
+#endif
+#ifndef __NR_watch_sb
+#define __NR_watch_sb -1
+#endif
 
 #define BUF_SIZE 4
 
@@ -61,6 +67,47 @@ static void saw_key_change(struct watch_notification *n)
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
+static void saw_mount_change(struct watch_notification *n)
+{
+	struct mount_notification *m = (struct mount_notification *)n;
+	unsigned int len = (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+
+	if (len != sizeof(struct mount_notification) / WATCH_LENGTH_GRANULARITY)
+		return;
+
+	printf("MOUNT %08x change=%u[%s] aux=%u\n",
+	       m->triggered_on, n->subtype, mount_subtypes[n->subtype], m->changed_mount);
+}
+
+static const char *super_subtypes[256] = {
+	[NOTIFY_SUPERBLOCK_READONLY]	= "readonly",
+	[NOTIFY_SUPERBLOCK_ERROR]	= "error",
+	[NOTIFY_SUPERBLOCK_EDQUOT]	= "edquot",
+	[NOTIFY_SUPERBLOCK_NETWORK]	= "network",
+};
+
+static void saw_super_change(struct watch_notification *n)
+{
+	struct superblock_notification *s = (struct superblock_notification *)n;
+	unsigned int len = (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+
+	if (len < sizeof(struct superblock_notification) / WATCH_LENGTH_GRANULARITY)
+		return;
+
+	printf("SUPER %08llx change=%u[%s]\n",
+	       s->sb_id, n->subtype, super_subtypes[n->subtype]);
+}
+
 static const char *block_subtypes[256] = {
 	[NOTIFY_BLOCK_ERROR_TIMEOUT]			= "timeout",
 	[NOTIFY_BLOCK_ERROR_NO_SPACE]			= "critical space allocation",
@@ -159,6 +206,12 @@ static int consumer(int fd, struct watch_queue_buffer *buf)
 			case WATCH_TYPE_USB_NOTIFY:
 				saw_usb_event(n);
 				break;
+			case WATCH_TYPE_MOUNT_NOTIFY:
+				saw_mount_change(n);
+				break;
+			case WATCH_TYPE_SB_NOTIFY:
+				saw_super_change(n);
+				break;
 			}
 
 			tail += (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
@@ -186,6 +239,19 @@ static struct watch_notification_filter filter = {
 			.type			= WATCH_TYPE_USB_NOTIFY,
 			.subtype_filter[0]	= UINT_MAX,
 		},
+		[3] = {
+			.type			= WATCH_TYPE_MOUNT_NOTIFY,
+			// Reject move-from notifications
+			.subtype_filter[0]	= UINT_MAX & ~(1 << NOTIFY_MOUNT_MOVE_FROM),
+		},
+		[4]	= {
+			.type			= WATCH_TYPE_SB_NOTIFY,
+			// Only accept notification of changes to R/O state
+			.subtype_filter[0]	= (1 << NOTIFY_SUPERBLOCK_READONLY),
+			// Only accept notifications of change-to-R/O
+			.info_mask		= WATCH_INFO_FLAG_0,
+			.info_filter		= WATCH_INFO_FLAG_0,
+		},
 	},
 };
 
@@ -229,5 +295,15 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (syscall(__NR_watch_mount, AT_FDCWD, "/", 0, fd, 0x02) == -1) {
+		perror("watch_mount");
+		exit(1);
+	}
+
+	if (syscall(__NR_watch_sb, AT_FDCWD, "/mnt", 0, fd, 0x03) == -1) {
+		perror("watch_sb");
+		exit(1);
+	}
+
 	return consumer(fd, buf);
 }

