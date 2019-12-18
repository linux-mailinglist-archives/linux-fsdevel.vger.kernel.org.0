Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E82125819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLRXzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 18:55:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36077 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLRXzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:55:43 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so3251951iln.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bsnkXvaQ10kV4zp6dMk/ZIEKA3y1WpZ3zC9oUJDDtdc=;
        b=0eEjh/OdXeIgj1aM+Oh0HGrXT18ou7SPtI0uu6STMMXHzd+/P0jiJg6aZXHKPs9WF2
         Lf7dzYsADi2eixaE/+87i6jd70S4iS40f14z2dq8omFw2tq79VSEXHZ5MaCzZRtDPz4q
         j2ZcBoOsXVy2jKuDlDWkNM5ivXZOtHQ2tr9LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bsnkXvaQ10kV4zp6dMk/ZIEKA3y1WpZ3zC9oUJDDtdc=;
        b=V8UQeY5fq9CDC8fMBxxYxSl3c8w9lhbHgPCkdwkhG/ZKuGPoZO00SJzvmFxxc6Sj0G
         463Hc+tazQeY3GZaysgi4FgvVNblXK+NqLpqkxWmlbOKUIrm5JdIZ4HEE4vYlAQADFNH
         h0zY5hVRxLi4BAhF8WvBShlpDQowyMOredES0mdkFOYQrSoz7p7peKvSULjsF9XzH4Hy
         2TSz9x3rRyOkA0MPFJPTUBF+r19adKUowMReTQ+K3UWN2BlWqzywD4zpWiKOhLkjDDKt
         0Jd7PJkIlvnce89Na5H4G80CWNYPHOgXBKLdQXEtEKXbiMZGksMr4gIsuqrtfzsl/nwL
         Ohsg==
X-Gm-Message-State: APjAAAWLlunDHLx+dLs2gLcflbrA4dUupe8geJwMwM8RBNJ5Kqueeo4i
        37yymAz3hQ1uKJnihkcJ0+UKhw==
X-Google-Smtp-Source: APXvYqyLi/IAbJ3dTC0X8anY2lW59DQH0iawE3xmYPpzw17E1PpQfk+e44xl8dYr9z7EhMAjT8y5vw==
X-Received: by 2002:a92:ab0b:: with SMTP id v11mr4147786ilh.159.1576713342545;
        Wed, 18 Dec 2019 15:55:42 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id p5sm1135927ilg.69.2019.12.18.15.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 15:55:41 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:55:40 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v4 4/5] samples: Add example of using pidfd getfd in
 conjunction with user trap
Message-ID: <20191218235538.GA17292@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This sample adds the usage of SECCOMP_RET_USER_NOTIF together with pidfd
GETFD ioctl. It shows trapping a syscall, and handling it by extracting
the FD into the parent process without stopping the child process.
Although, in this example, there's no explicit policy separation in
the two processes, it can be generalized into the example of a transparent
proxy.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 samples/seccomp/.gitignore        |   1 +
 samples/seccomp/Makefile          |   9 +-
 samples/seccomp/user-trap-pidfd.c | 185 ++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 samples/seccomp/user-trap-pidfd.c

diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
index d1e2e817d556..f37e3692a1dd 100644
--- a/samples/seccomp/.gitignore
+++ b/samples/seccomp/.gitignore
@@ -2,3 +2,4 @@ bpf-direct
 bpf-fancy
 dropper
 user-trap
+user-trap-pidfd
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 82b7347318d1..c3880869cadc 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef CROSS_COMPILE
-hostprogs-y := bpf-fancy dropper bpf-direct user-trap
+hostprogs-y := bpf-fancy dropper bpf-direct user-trap user-trap-pidfd
 
 HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
 HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
@@ -24,6 +24,11 @@ HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
 HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
 user-trap-objs := user-trap.o user-trap-helper.o
 
+HOSTCFLAGS_user-trap-pidfd.o += -I$(objtree)/usr/include
+HOSTCFLAGS_user-trap-pidfd.o += -idirafter $(objtree)/include
+user-trap-pidfd-objs := user-trap-pidfd.o user-trap-helper.o
+
+
 # Try to match the kernel target.
 ifndef CONFIG_64BIT
 
@@ -39,10 +44,12 @@ HOSTCFLAGS_dropper.o += $(MFLAG)
 HOSTCFLAGS_bpf-helper.o += $(MFLAG)
 HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
 HOSTCFLAGS_user-trap.o += $(MFLAG)
+HOSTCFLAGS_user-trap-pidfd.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
 HOSTLDLIBS_user-trap += $(MFLAG)
+HOSTLDLIBS_user-trap-pidfd += $(MFLAG)
 endif
 always := $(hostprogs-y)
 endif
diff --git a/samples/seccomp/user-trap-pidfd.c b/samples/seccomp/user-trap-pidfd.c
new file mode 100644
index 000000000000..bd5730347a81
--- /dev/null
+++ b/samples/seccomp/user-trap-pidfd.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/seccomp.h>
+#include <linux/prctl.h>
+#include <linux/pidfd.h>
+#include <sys/socket.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ioctl.h>
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <netinet/in.h>
+#include "user-trap-helper.h"
+
+#define CHILD_PORT_TRY_BIND		80
+#define CHILD_PORT_ACTUAL_BIND	4998
+
+static int tracee(void)
+{
+	struct sockaddr_in addr = {
+		.sin_family	= AF_INET,
+		.sin_port	= htons(CHILD_PORT_TRY_BIND),
+		.sin_addr	= {
+			.s_addr	= htonl(INADDR_ANY)
+		}
+	};
+	socklen_t addrlen = sizeof(addr);
+	int sock, ret = 1;
+
+	sock = socket(AF_INET, SOCK_STREAM, 0);
+	if (sock == -1) {
+		perror("socket");
+		goto out;
+	}
+
+
+	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr))) {
+		perror("bind");
+		goto out;
+	}
+
+	printf("Child successfully performed bind operation\n");
+	if (getsockname(sock, (struct sockaddr *) &addr, &addrlen)) {
+		perror("getsockname");
+		goto out;
+	}
+
+
+	printf("Socket bound to port %d\n", ntohs(addr.sin_port));
+	assert(ntohs(addr.sin_port) == CHILD_PORT_ACTUAL_BIND);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int handle_req(int listener, int pidfd)
+{
+	struct sockaddr_in addr = {
+		.sin_family	= AF_INET,
+		.sin_port	= htons(CHILD_PORT_ACTUAL_BIND),
+		.sin_addr	= {
+			.s_addr	= htonl(INADDR_LOOPBACK)
+		}
+	};
+	struct seccomp_notif_sizes sizes;
+	struct seccomp_notif_resp *resp;
+	struct seccomp_notif *req;
+	int fd, ret = 1;
+
+	if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
+		perror("seccomp(GET_NOTIF_SIZES)");
+		goto out;
+	}
+	req = malloc(sizes.seccomp_notif);
+	if (!req)
+		goto out;
+	memset(req, 0, sizeof(*req));
+
+	resp = malloc(sizes.seccomp_notif_resp);
+	if (!resp)
+		goto out_free_req;
+	memset(resp, 0, sizeof(*resp));
+
+	if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
+		perror("ioctl recv");
+		goto out;
+	}
+	printf("Child tried to call bind with fd: %lld\n", req->data.args[0]);
+	fd = ioctl(pidfd, PIDFD_IOCTL_GETFD, req->data.args[0]);
+	if (fd == -1) {
+		perror("ioctl pidfd");
+		goto out_free_resp;
+	}
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr))) {
+		perror("bind");
+		goto out_free_resp;
+	}
+
+	resp->id = req->id;
+	resp->error = 0;
+	resp->val = 0;
+	if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, resp) < 0) {
+		perror("ioctl send");
+		goto out_free_resp;
+	}
+
+	ret = 0;
+out_free_resp:
+	free(resp);
+out_free_req:
+	free(req);
+out:
+	return ret;
+}
+
+static int pidfd_open(pid_t pid, unsigned int flags)
+{
+	errno = 0;
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+int main(void)
+{
+	int pidfd, listener, sk_pair[2], ret = 1;
+	pid_t pid;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		perror("socketpair");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		goto close_pair;
+	}
+
+	if (pid == 0) {
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			perror("prctl(NO_NEW_PRIVS)");
+			exit(1);
+		}
+		listener = user_trap_syscall(__NR_bind,
+					     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listener < 0) {
+			perror("seccomp");
+			exit(1);
+		}
+		if (send_fd(sk_pair[1], listener) < 0)
+			exit(1);
+		close(listener);
+		exit(tracee());
+	}
+
+	pidfd = pidfd_open(pid, 0);
+	if (pidfd < 0) {
+		perror("pidfd_open");
+		goto kill_child;
+	}
+
+	listener = recv_fd(sk_pair[0]);
+	if (listener < 0)
+		goto kill_child;
+
+	if (handle_req(listener, pidfd))
+		goto kill_child;
+
+	/* Wait for child to finish */
+	waitpid(pid, NULL, 0);
+
+	ret = 0;
+	goto close_pair;
+
+kill_child:
+	kill(pid, SIGKILL);
+close_pair:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+out:
+	return ret;
+}
-- 
2.20.1

