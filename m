Return-Path: <linux-fsdevel+bounces-77289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDvrG0Yek2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:40:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1526143EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B05F0302B22A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E0314A73;
	Mon, 16 Feb 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksVRT/TC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2A3101D2;
	Mon, 16 Feb 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248790; cv=none; b=QAPlG5lIME0QL/SIte0hlXVU5JrE6jVMI2XD9NFgCAc86Y+EBpyZII6F4wQeA0zi6LjhVwOmqUbaLNSnfg5i+N8a8HeaAg3QdLTIHfVMLDo7Cz5xg+kJ9Wpps5MtJK0uoOMYJnV2kATJZEi3k/fvjWqJCvm8HKE0neC9sUnl/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248790; c=relaxed/simple;
	bh=hvRp6kqMtP01OL7JzalGLx5e4r/2rC/9MUn7FHvN4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idvFit61RYP1Xyktd7M/h8y5Yj9laNqOtuWK5Ol4s7mtC3fe/qLR+QShb8ezetHdCEiWT1ERIeUK6gdolYgaMcoR0U/JuzvuPjOd/+BCUSYIIdlrRJwc/2FEwcwJrAsBsyUy1SxfGnC0klgz0v7QdTUcpjFU5PwqPaF9IUvJBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksVRT/TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EADC19423;
	Mon, 16 Feb 2026 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248790;
	bh=hvRp6kqMtP01OL7JzalGLx5e4r/2rC/9MUn7FHvN4XY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ksVRT/TC3Qs/BDIBZ4Xwz+odoJUU6U4EIeZ15q9gpGsQphl0RvHMnhrcx00O/o44L
	 u8TStq3seKruuRWTCAfpzOHfvucMwPSX/C97ZOFdF4/BgJ2k5CasvzjAlBlIz8PnGE
	 xM/FeirGoDXBN6jq/9WeT3f3VLf/NQ0Pd1cSjE8XARMfC5mF+5PbhiRTClUXTLwL+M
	 Y0hFvkeZF34qG+L0Xjh4pF4S+FZRbyYI0oSk4PwJRBtMWT/ASvV16Mf/NyHc0GNp0V
	 3GVIfwPUoEmJwb3gr4GnWFSDE/pu+9wKia7m2g/O1iqCXPDbyd8Qe0i+qw3gapxDEA
	 xbK4hkdbLLewQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:10 +0100
Subject: [PATCH 14/14] selftests/xattr: test xattrs on various socket
 families
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-14-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=6636; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hvRp6kqMtP01OL7JzalGLx5e4r/2rC/9MUn7FHvN4XY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlokr042WWq769uIti0fds8S7VFz8zzcGv+fTK5kk1
 xG/XdC1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJCHIwML3UXZu86bHnFwruo
 6I2KarM716f/Dv4mfcYbKyuezPq8h+GvdEPpDo5JyQ9slPgXCLvfeSyufcV+SvqkGXd2ZKy1YH/
 LCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77289-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1526143EEF
X-Rspamd-Action: no action

Test user.* xattr operations on sockets from different address families:
AF_INET, AF_INET6, AF_NETLINK, and AF_PACKET. All socket types use
sockfs for their inodes, so user.* xattrs should work regardless of
address family.

Each fixture creates a socket (no bind needed) and verifies the full
fsetxattr/fgetxattr/flistxattr/fremovexattr cycle. AF_INET6 skips if
not supported; AF_PACKET skips if CAP_NET_RAW is unavailable.

Also tests abstract namespace AF_UNIX sockets, which live in sockfs
(not on a filesystem) and should support user.* xattrs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/filesystems/xattr/.gitignore |   1 +
 tools/testing/selftests/filesystems/xattr/Makefile |   2 +-
 .../filesystems/xattr/xattr_socket_types_test.c    | 177 +++++++++++++++++++++
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/xattr/.gitignore b/tools/testing/selftests/filesystems/xattr/.gitignore
index 00a59c89efab..092d14094c0f 100644
--- a/tools/testing/selftests/filesystems/xattr/.gitignore
+++ b/tools/testing/selftests/filesystems/xattr/.gitignore
@@ -1,2 +1,3 @@
 xattr_socket_test
 xattr_sockfs_test
+xattr_socket_types_test
diff --git a/tools/testing/selftests/filesystems/xattr/Makefile b/tools/testing/selftests/filesystems/xattr/Makefile
index 2cd722dba47b..95364ffb10e9 100644
--- a/tools/testing/selftests/filesystems/xattr/Makefile
+++ b/tools/testing/selftests/filesystems/xattr/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := xattr_socket_test xattr_sockfs_test
+TEST_GEN_PROGS := xattr_socket_test xattr_sockfs_test xattr_socket_types_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c b/tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c
new file mode 100644
index 000000000000..bfabe91b2ed1
--- /dev/null
+++ b/tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
+/*
+ * Test user.* xattrs on various socket families.
+ *
+ * All socket types use sockfs for their inodes, so user.* xattrs should
+ * work on any socket regardless of address family. This tests AF_INET,
+ * AF_INET6, AF_NETLINK, AF_PACKET, and abstract namespace AF_UNIX sockets.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/xattr.h>
+#include <linux/netlink.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+
+#define TEST_XATTR_NAME		"user.testattr"
+#define TEST_XATTR_VALUE	"testvalue"
+
+FIXTURE(xattr_socket_types)
+{
+	int sockfd;
+};
+
+FIXTURE_VARIANT(xattr_socket_types)
+{
+	int family;
+	int type;
+	int protocol;
+};
+
+FIXTURE_VARIANT_ADD(xattr_socket_types, inet) {
+	.family = AF_INET,
+	.type = SOCK_STREAM,
+	.protocol = 0,
+};
+
+FIXTURE_VARIANT_ADD(xattr_socket_types, inet6) {
+	.family = AF_INET6,
+	.type = SOCK_STREAM,
+	.protocol = 0,
+};
+
+FIXTURE_VARIANT_ADD(xattr_socket_types, netlink) {
+	.family = AF_NETLINK,
+	.type = SOCK_RAW,
+	.protocol = NETLINK_USERSOCK,
+};
+
+FIXTURE_VARIANT_ADD(xattr_socket_types, packet) {
+	.family = AF_PACKET,
+	.type = SOCK_DGRAM,
+	.protocol = 0,
+};
+
+FIXTURE_SETUP(xattr_socket_types)
+{
+	self->sockfd = socket(variant->family, variant->type,
+			      variant->protocol);
+	if (self->sockfd < 0 &&
+	    (errno == EAFNOSUPPORT || errno == EPERM || errno == EACCES))
+		SKIP(return, "socket(%d, %d, %d) not available: %s",
+		     variant->family, variant->type, variant->protocol,
+		     strerror(errno));
+	ASSERT_GE(self->sockfd, 0) {
+		TH_LOG("Failed to create socket(%d, %d, %d): %s",
+		       variant->family, variant->type, variant->protocol,
+		       strerror(errno));
+	}
+}
+
+FIXTURE_TEARDOWN(xattr_socket_types)
+{
+	if (self->sockfd >= 0)
+		close(self->sockfd);
+}
+
+TEST_F(xattr_socket_types, set_get_list_remove)
+{
+	char buf[256], list[4096], *ptr;
+	ssize_t ret;
+	bool found;
+
+	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
+			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("fsetxattr failed: %s", strerror(errno));
+	}
+
+	memset(buf, 0, sizeof(buf));
+	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
+	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
+	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
+
+	memset(list, 0, sizeof(list));
+	ret = flistxattr(self->sockfd, list, sizeof(list));
+	ASSERT_GT(ret, 0);
+	found = false;
+	for (ptr = list; ptr < list + ret; ptr += strlen(ptr) + 1) {
+		if (strcmp(ptr, TEST_XATTR_NAME) == 0)
+			found = true;
+	}
+	ASSERT_TRUE(found);
+
+	ret = fremovexattr(self->sockfd, TEST_XATTR_NAME);
+	ASSERT_EQ(ret, 0);
+
+	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENODATA);
+}
+
+/*
+ * Test abstract namespace AF_UNIX socket.
+ * Abstract sockets don't have a filesystem path; their inodes live in
+ * sockfs so user.* xattrs should work via fsetxattr/fgetxattr.
+ */
+FIXTURE(xattr_abstract)
+{
+	int sockfd;
+};
+
+FIXTURE_SETUP(xattr_abstract)
+{
+	struct sockaddr_un addr;
+	char name[64];
+	int ret, len;
+
+	self->sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(self->sockfd, 0);
+
+	len = snprintf(name, sizeof(name), "xattr_test_abstract_%d", getpid());
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	addr.sun_path[0] = '\0';
+	memcpy(&addr.sun_path[1], name, len);
+
+	ret = bind(self->sockfd, (struct sockaddr *)&addr,
+		   offsetof(struct sockaddr_un, sun_path) + 1 + len);
+	ASSERT_EQ(ret, 0);
+}
+
+FIXTURE_TEARDOWN(xattr_abstract)
+{
+	if (self->sockfd >= 0)
+		close(self->sockfd);
+}
+
+TEST_F(xattr_abstract, set_get)
+{
+	char buf[256];
+	ssize_t ret;
+
+	ret = fsetxattr(self->sockfd, TEST_XATTR_NAME,
+			TEST_XATTR_VALUE, strlen(TEST_XATTR_VALUE), 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("fsetxattr on abstract socket failed: %s",
+		       strerror(errno));
+	}
+
+	memset(buf, 0, sizeof(buf));
+	ret = fgetxattr(self->sockfd, TEST_XATTR_NAME, buf, sizeof(buf));
+	ASSERT_EQ(ret, (ssize_t)strlen(TEST_XATTR_VALUE));
+	ASSERT_STREQ(buf, TEST_XATTR_VALUE);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


