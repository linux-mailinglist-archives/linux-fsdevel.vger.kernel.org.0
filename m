Return-Path: <linux-fsdevel+bounces-50203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651BAC8B35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173711669D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DB22D4D8;
	Fri, 30 May 2025 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QfBx34tM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA522ACF3
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597849; cv=none; b=Jjjj+xk9hzPZM/52MKPF+sZG6p6mYX0wVHr1gs3UjFV0JuwdzjKvjnF9UoRK8EsGdo/IWjdQdKo+YzCUmCOnsegFPpJD55h8GkFH/27qcTpTS9V/Q4tBkEp0sGtLvPzU8mEYrjugrlJ2LeXgIsvTDCFB8PWF43vVb9niygcc67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597849; c=relaxed/simple;
	bh=bCYuosSzNO3MtUqiZdCPFyuVcpDUwXDrs2jBQRh3ImE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jcl/VSeKFD7aq52v8zBg+iUCOIMCRFA7iLW8tQ2mSywrzykPP1nu0wBo4BQU60pULPq/Y0z0M9VQvtU3kMxgqvGaRKl2dWTjvqodQ3ZSB6+JvL/bv/6gI/zqBJsDTHFqQXKO5u+O41xx3X6xrxAzOe0Ye6pddE3lt1ZL2w/K+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QfBx34tM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3081f72c271so1411161a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597843; x=1749202643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjVGQKkOlZOy+4fU/xUd4g+vTcZV8exC595abljBAKM=;
        b=QfBx34tMTEyJ7KNaVGJ43dQOCPJp6eA0NTc0pbqRF3s/mKeIcZaN/apy1L30o2Y7zM
         CUgILPf/uH0YNSQ6B3gGb1zCVH/zMU8kS1gNPoGq79ZZGrAzCjWFfvm10HpLjbTipwqo
         Vlo4LwkCu6urf1i8rmcjtHO+Cf51zFcw7OlU349SqrcN9ZqEpEYdSGPNgFSK5R58MtND
         qsTKgmkqC4VEuJlsuRSMS65ot5LsjEdOkBZ8j4pmjn1nk/+4+QRB4hrMPa79h2d4iYNO
         0/vK5UAzXvjOuzOWlwNAB0mx6uRfy+lyyMX16LmL/jbloTW33YsTKfHhSNAMURO+BLsw
         sWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597843; x=1749202643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjVGQKkOlZOy+4fU/xUd4g+vTcZV8exC595abljBAKM=;
        b=B8JAru3sToz10dOYqjKzrskhR/szbx/pOc4iRBMySqL2KqJjHh02AIs+F+9qwRLq97
         bLyEoLskk/sMuLe855ePRr7kY9MN8mfxoeVD8lgPDzOOuJFW50X65ZJU3Bar2w4b4BCh
         Ew39i2haFSmU+jghpwI4I3gRmXT7Wc7ZDwpIFHdL7D1nrEusWVkxEaPNZF3+kHFZfr0A
         1Akx7uX6FF7eL95oVL56bYzRD8w5boegxz4cgwa/f7bwLlcMkosEM/0+yM/wZyiF0thD
         SE+i3vZ3/Czgcyh7nK7JL2wgFiNfVb2Yf6M6Sd/kcaBMX5kaO9i1PNeAGFcRbN/GOITW
         ThrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLCD8zShPyEkOlCgRn42CbMaD9RjL8iCTNZni89+ddKt0bEQpdKzeqlvPs3WIp22TgFnrlaMT4H3AEykSH@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGHKLlK3RYiCqLB3VKzhm7xKiHdQV+TW8IshOnD4QuQMZC6rO
	eIXrwISEZDMLqCC2qSI4fEBr3o3jNYgMvS4M3AVEHHeZBKOyCyaliboO0WSF3pJVIzQ=
X-Gm-Gg: ASbGncuG8nf9znuoA4nnbYy9eEXWX0DbZ3ydR0pS0+v5h+lUPP7coOkpDuUZBFFGiKz
	YVs3Ebp6c3KCjsuXjzNh9bp/3kaSYPPLCXhcUKvZ8thHujS2lYEecpDtatyewT4mhP/Oe/RfZfH
	6dSyt3HUjhI+spqc+mA/ESmpGUDIvu1Sau/U/C72mmaFkks+AJD96841hjhhz+gokeSeWK78054
	XGHtWISufp2BApfskONdcCKTz18MQ8fZPjicx1RwCNObBN2WzUl3LjjaApf6NYiW/4jPM1EcnGC
	SNoTXtG1m9s19kDkvba1TfNgyrYMmZXvgMCJ62pH4NVye32dEZF+RFoeiIynVC8YhCa3hMcCSLE
	S4PUStoQhMePxWIOMOYqy
X-Google-Smtp-Source: AGHT+IFSHaG5y+mkmzSneS5RbvI+Y1/bhXtbvD9WhGteUuouTIh+462k1YHpGCKGocTvjur7aEf1Ag==
X-Received: by 2002:a17:90b:1d51:b0:311:a314:c2dc with SMTP id 98e67ed59e1d1-3125036bafdmr2653995a91.14.1748597842300;
        Fri, 30 May 2025 02:37:22 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.37.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:37:21 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 35/35] samples/rpal: add RPAL samples
Date: Fri, 30 May 2025 17:28:03 +0800
Message-Id: <b8a8d44e5b81c93598caee82254320507142d4be.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added test samples for RPAL (with librpal included). Compile via:

    cd samples/rpal && make

And run it using the following command:

    ./server & ./client

Example output:

    EPOLL: Message length: 32 bytes, Total TSC cycles: 16439927066,
    Message count: 1000000, Average latency: 16439 cycles
    RPAL: Message length: 32 bytes, Total TSC cycles: 2197479484,
    Message count: 1000000, Average latency: 2197 cycles

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 samples/rpal/Makefile                         |   17 +
 samples/rpal/asm_define.c                     |   14 +
 samples/rpal/client.c                         |  178 ++
 samples/rpal/librpal/asm_define.h             |    6 +
 samples/rpal/librpal/asm_x86_64_rpal_call.S   |   57 +
 samples/rpal/librpal/debug.h                  |   12 +
 samples/rpal/librpal/fiber.c                  |  119 +
 samples/rpal/librpal/fiber.h                  |   64 +
 .../rpal/librpal/jump_x86_64_sysv_elf_gas.S   |   81 +
 .../rpal/librpal/make_x86_64_sysv_elf_gas.S   |   82 +
 .../rpal/librpal/ontop_x86_64_sysv_elf_gas.S  |   84 +
 samples/rpal/librpal/private.h                |  341 +++
 samples/rpal/librpal/rpal.c                   | 2351 +++++++++++++++++
 samples/rpal/librpal/rpal.h                   |  149 ++
 samples/rpal/librpal/rpal_pkru.h              |   78 +
 samples/rpal/librpal/rpal_queue.c             |  239 ++
 samples/rpal/librpal/rpal_queue.h             |   55 +
 samples/rpal/librpal/rpal_x86_64_call_ret.S   |   45 +
 samples/rpal/offset.sh                        |    5 +
 samples/rpal/server.c                         |  249 ++
 20 files changed, 4226 insertions(+)
 create mode 100644 samples/rpal/Makefile
 create mode 100644 samples/rpal/asm_define.c
 create mode 100644 samples/rpal/client.c
 create mode 100644 samples/rpal/librpal/asm_define.h
 create mode 100644 samples/rpal/librpal/asm_x86_64_rpal_call.S
 create mode 100644 samples/rpal/librpal/debug.h
 create mode 100644 samples/rpal/librpal/fiber.c
 create mode 100644 samples/rpal/librpal/fiber.h
 create mode 100644 samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
 create mode 100644 samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
 create mode 100644 samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
 create mode 100644 samples/rpal/librpal/private.h
 create mode 100644 samples/rpal/librpal/rpal.c
 create mode 100644 samples/rpal/librpal/rpal.h
 create mode 100644 samples/rpal/librpal/rpal_pkru.h
 create mode 100644 samples/rpal/librpal/rpal_queue.c
 create mode 100644 samples/rpal/librpal/rpal_queue.h
 create mode 100644 samples/rpal/librpal/rpal_x86_64_call_ret.S
 create mode 100755 samples/rpal/offset.sh
 create mode 100644 samples/rpal/server.c

diff --git a/samples/rpal/Makefile b/samples/rpal/Makefile
new file mode 100644
index 000000000000..25627a970028
--- /dev/null
+++ b/samples/rpal/Makefile
@@ -0,0 +1,17 @@
+.PHONY: rpal
+
+all: server client offset
+
+offset: asm_define.c
+	$(shell ./offset.sh)
+
+server: server.c librpal/*.c librpal/*.S
+	$(CC) $^ -lpthread -g -o $@
+	@printf "RPAL" | dd of=./server bs=1 count=4 conv=notrunc seek=12
+
+client: client.c librpal/*.c librpal/*.S
+	$(CC) $^ -lpthread -g -o $@
+	@printf "RPAL" | dd of=./client bs=1 count=4 conv=notrunc seek=12
+
+clean:
+	rm server client
diff --git a/samples/rpal/asm_define.c b/samples/rpal/asm_define.c
new file mode 100644
index 000000000000..6f7731ebc870
--- /dev/null
+++ b/samples/rpal/asm_define.c
@@ -0,0 +1,14 @@
+#include <stddef.h>
+#include "librpal/private.h"
+
+#define DEFINE(sym, val) asm volatile("\n-> " #sym " %0 " #val "\n" : : "i" (val))
+
+static void common(void)
+{
+    DEFINE(RCI_SENDER_TLS_BASE, offsetof(rpal_call_info_t, sender_tls_base));
+    DEFINE(RCI_SENDER_FCTX, offsetof(rpal_call_info_t, sender_fctx));
+    DEFINE(RCI_PKRU, offsetof(rpal_call_info_t, pkru));
+    DEFINE(RC_SENDER_STATE, offsetof(receiver_context_t, sender_state));
+    DEFINE(RET_BEGIN, offsetof(critical_section_t, ret_begin));
+    DEFINE(RET_END, offsetof(critical_section_t, ret_end));
+}
diff --git a/samples/rpal/client.c b/samples/rpal/client.c
new file mode 100644
index 000000000000..2c4a9eb6115e
--- /dev/null
+++ b/samples/rpal/client.c
@@ -0,0 +1,178 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <x86intrin.h>
+#include "librpal/rpal.h"
+
+#define SOCKET_PATH "/tmp/rpal_socket"
+#define BUFFER_SIZE 1025
+#define MSG_NUM 1000000
+#define MSG_LEN 32
+
+char hello[BUFFER_SIZE];
+char buffer[BUFFER_SIZE] = { 0 };
+
+int remote_id;
+uint64_t remote_sidfd;
+
+#define INIT_MSG "INIT"
+#define SUCC_MSG "SUCC"
+#define FAIL_MSG "FAIL"
+
+#define handle_error(s)                                                        \
+	do {                                                                   \
+		perror(s);                                                     \
+		exit(EXIT_FAILURE);                                            \
+	} while (0)
+
+int rpal_epoll_add(int epfd, int fd)
+{
+	struct epoll_event ev;
+
+	ev.events = EPOLLRPALIN | EPOLLIN | EPOLLRDHUP | EPOLLET;
+	ev.data.fd = fd;
+
+	return rpal_epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev);
+}
+
+void rpal_client_init(int fd)
+{
+	struct epoll_event ev;
+	char buffer[BUFFER_SIZE];
+	rpal_error_code_t err;
+	uint64_t remote_key, service_key;
+	int epoll_fd;
+	int proc_fd;
+	int ret;
+
+	proc_fd = rpal_init(1, 0, &err);
+	if (proc_fd < 0)
+		handle_error("rpal init fail");
+	rpal_get_service_key(&service_key);
+
+	strcpy(buffer, INIT_MSG);
+	*(uint64_t *)(buffer + strlen(INIT_MSG)) = service_key;
+	ret = write(fd, buffer, strlen(INIT_MSG) + sizeof(uint64_t));
+	if (ret < 0)
+		handle_error("write key");
+
+	ret = read(fd, buffer, BUFFER_SIZE);
+	if (ret < 0)
+		handle_error("read key");
+
+	memcpy(&remote_key, buffer, sizeof(remote_key));
+	if (remote_key == 0)
+		handle_error("remote down");
+
+	ret = rpal_request_service(remote_key);
+	if (ret) {
+		write(fd, FAIL_MSG, strlen(FAIL_MSG));
+		handle_error("request");
+	}
+
+	ret = write(fd, SUCC_MSG, strlen(SUCC_MSG));
+	if (ret < 0)
+		handle_error("handshake");
+
+	remote_id = rpal_get_request_service_id(remote_key);
+	rpal_sender_init(&err);
+
+	epoll_fd = epoll_create(1024);
+	if (epoll_fd == -1) {
+		perror("epoll_create");
+		exit(EXIT_FAILURE);
+	}
+	rpal_epoll_add(epoll_fd, fd);
+
+	sleep(3); //wait for epoll wait
+	ret = rpal_uds_fdmap(((unsigned long)remote_id << 32) | fd,
+			     &remote_sidfd);
+	if (ret < 0)
+		handle_error("uds fdmap fail");
+}
+
+int run_rpal_client(int msg_len)
+{
+	ssize_t valread;
+	int sock = 0;
+	struct sockaddr_un serv_addr;
+	int count = MSG_NUM;
+	int ret;
+
+	if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
+		perror("socket creation error");
+		return -1;
+	}
+
+	memset(&serv_addr, 0, sizeof(serv_addr));
+	serv_addr.sun_family = AF_UNIX;
+	strncpy(serv_addr.sun_path, SOCKET_PATH, sizeof(SOCKET_PATH));
+
+	if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) <
+	    0) {
+		perror("Connection Failed");
+		return -1;
+	}
+	rpal_client_init(sock);	
+
+	while (count) {
+		for (int i = 18; i < msg_len; i++)
+			hello[i] = 'a' + i % 26;
+		sprintf(hello, "0x%016lx", __rdtsc());
+		ret = rpal_write_ptrs(remote_id, remote_sidfd, (int64_t *)hello,
+				      msg_len / sizeof(int64_t *));
+		valread = read(sock, buffer, BUFFER_SIZE);
+		if (memcmp(hello, buffer, msg_len) != 0)
+			perror("data error");
+		count--;
+	}
+
+	close(sock);
+}
+
+int run_client(int msg_len)
+{
+	ssize_t valread;
+	int sock = 0;
+	struct sockaddr_un serv_addr;
+	int count = MSG_NUM;
+
+	if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
+		perror("socket creation error");
+		return -1;
+	}
+
+	memset(&serv_addr, 0, sizeof(serv_addr));
+	serv_addr.sun_family = AF_UNIX;
+	strncpy(serv_addr.sun_path, SOCKET_PATH, sizeof(SOCKET_PATH));
+
+	if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) <
+	    0) {
+		perror("Connection Failed");
+		return -1;
+	}
+
+	while (count) {
+		for (int i = 18; i < msg_len; i++)
+			hello[i] = 'a' + i % 26;
+		sprintf(hello, "0x%016lx", __rdtsc());
+		send(sock, hello, msg_len, 0);
+		valread = read(sock, buffer, BUFFER_SIZE);
+		if (memcmp(hello, buffer, msg_len) != 0)
+			perror("data error");
+		count--;
+	}
+
+	close(sock);
+}
+
+int main()
+{
+	run_client(MSG_LEN);
+	run_rpal_client(MSG_LEN);
+
+	return 0;
+}
diff --git a/samples/rpal/librpal/asm_define.h b/samples/rpal/librpal/asm_define.h
new file mode 100644
index 000000000000..bc57586cda58
--- /dev/null
+++ b/samples/rpal/librpal/asm_define.h
@@ -0,0 +1,6 @@
+#define RCI_SENDER_TLS_BASE 0
+#define RCI_SENDER_FCTX 16
+#define RCI_PKRU 8
+#define RC_SENDER_STATE 72
+#define RET_BEGIN 0
+#define RET_END 8
diff --git a/samples/rpal/librpal/asm_x86_64_rpal_call.S b/samples/rpal/librpal/asm_x86_64_rpal_call.S
new file mode 100644
index 000000000000..538e8ac5f09b
--- /dev/null
+++ b/samples/rpal/librpal/asm_x86_64_rpal_call.S
@@ -0,0 +1,57 @@
+#ifdef __x86_64__
+#define __ASSEMBLY__
+#include "asm_define.h"
+
+.text
+.globl rpal_access_warpper
+.type rpal_access_warpper,@function
+.align 16
+
+rpal_access_warpper:
+    pushq  %r12
+    pushq  %r13
+    pushq  %r14
+    pushq  %r15
+    pushq  %rbx
+    pushq  %rbp
+
+    leaq -0x8(%rsp), %rsp
+    stmxcsr  (%rsp)
+    fnstcw   0x4(%rsp)
+
+    pushq  %rsp         // Save rsp which may be unaligned.
+    pushq  (%rsp)       // Save the original value again
+    andq   $-16, %rsp   // Align stack to 16bytes - SysV AMD64 ABI.
+
+    movq   %rsp, (%rdi)
+    call   rpal_access@plt
+retip:
+    movq   8(%rsp), %rsp	// Restore the potentially unaligned stack
+    ldmxcsr  (%rsp)
+    fldcw    0x4(%rsp)
+    leaq 0x8(%rsp), %rsp
+
+    popq   %rbp
+    popq   %rbx
+    popq   %r15
+    popq   %r14
+    popq   %r13
+    popq   %r12
+    ret
+
+.size rpal_access_warpper,.-rpal_access_warpper
+
+
+
+.globl rpal_get_ret_rip
+.type rpal_get_ret_rip, @function
+.align 16
+rpal_get_ret_rip:
+    leaq retip(%rip), %rax
+    ret
+
+.size rpal_get_ret_rip,.-rpal_get_ret_rip
+
+/* Mark that we don't need executable stack. */
+.section .note.GNU-stack,"",%progbits
+#endif
diff --git a/samples/rpal/librpal/debug.h b/samples/rpal/librpal/debug.h
new file mode 100644
index 000000000000..10d2fef8d69a
--- /dev/null
+++ b/samples/rpal/librpal/debug.h
@@ -0,0 +1,12 @@
+#ifndef RPAL_DEBUG_H
+#define RPAL_DEBUG_H
+
+typedef enum {
+	RPAL_DEBUG_MANAGEMENT = (1 << 0),
+	RPAL_DEBUG_SENDER = (1 << 1),
+	RPAL_DEBUG_RECVER = (1 << 2),
+	RPAL_DEBUG_FIBER = (1 << 3),
+
+	__RPAL_DEBUG_ALL = ~(0ULL),
+} rpal_debug_flag_t;
+#endif
diff --git a/samples/rpal/librpal/fiber.c b/samples/rpal/librpal/fiber.c
new file mode 100644
index 000000000000..2141ad9ab770
--- /dev/null
+++ b/samples/rpal/librpal/fiber.c
@@ -0,0 +1,119 @@
+#ifdef __x86_64__
+#include "debug.h"
+#include "fiber.h"
+#include "private.h"
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+#define RPAL_CHECK_FAIL -1
+#define STACK_DEBUG 1
+
+static task_t *make_fiber_ctx(task_t *fc)
+{
+	fc->fctx = make_fcontext(fc->sp, 0, NULL);
+	return fc;
+}
+
+static task_t *fiber_ctx_create(void (*fn)(void *ud), void *ud, void *stack,
+				size_t size)
+{
+	task_t *fc;
+	int i;
+
+	if (stack == NULL)
+		return NULL;
+
+	fc = (task_t *)stack;
+	fc->fn = fn;
+	fc->ud = ud;
+	fc->size = size;
+	fc->sp = stack + size;
+	for (i = 0; i < NR_PADDING; ++i) {
+		fc->padding[i] = 0xdeadbeef;
+	}
+
+	return make_fiber_ctx(fc);
+}
+
+task_t *fiber_ctx_alloc(void (*fn)(void *ud), void *ud, size_t size)
+{
+	void *stack;
+	size_t stack_size;
+	size_t total_size;
+	void *lower_guard;
+	void *upper_guard;
+
+	if (PAGE_SIZE == 4096 || STACK_DEBUG) {
+		stack_size = (size + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1);
+
+		dbprint(RPAL_DEBUG_FIBER,
+			"fiber_ctx_alloc: stack size adjusted from %lu to %lu\n",
+			size, stack_size);
+
+		// Allocate a stack using mmap with 2 extra pages, 1 at each end
+		// which will be PROT_NONE to act as guard pages to catch overflow
+		// and underflow. This will result in a SIGSEGV but should make it
+		// easier to catch a stack that is too small (or underflows).
+		//
+		// Notes:
+		//
+		// 1. On ARM64 with 64K pages this would be quite wasteful of memory
+		//    so it is behind a DEBUG flag to enable/disable on that platform.
+		//
+		// 2. If the requested stack size is not a multiple of a page size
+		//    then stack underflow wont always be caught as there is some
+		//    extra space up until the next page boundary with the guard page.
+		//
+		// 3. The task_t is placed at the top of the stack so can be overwritten
+		//    just before the stack overflows and hits the guard page.
+		//
+
+		total_size = stack_size + (PAGE_SIZE * 2);
+		lower_guard = mmap(NULL, total_size, PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANON, -1, 0);
+		if (lower_guard == MAP_FAILED) {
+			errprint("mmap of %lu bytes failed: %s\n", total_size,
+				 strerror(errno));
+			return NULL;
+		}
+
+		stack = lower_guard + PAGE_SIZE;
+		upper_guard = stack + stack_size;
+		mprotect(lower_guard, PAGE_SIZE, PROT_NONE);
+		mprotect(upper_guard, PAGE_SIZE, PROT_NONE);
+
+		dbprint(RPAL_DEBUG_FIBER,
+			"Total stack of size %lu bytes allocated @ %p\n",
+			total_size, stack);
+		dbprint(RPAL_DEBUG_FIBER,
+			"Underflow guard page %p - %p overflow guard page %p - %p\n",
+			lower_guard, lower_guard + PAGE_SIZE - 1, upper_guard,
+			upper_guard + PAGE_SIZE - 1);
+	} else {
+		stack = malloc(size);
+	}
+	return fiber_ctx_create(fn, ud, stack, size);
+}
+
+void fiber_ctx_free(task_t *fc)
+{
+	size_t stack_size;
+	size_t total_size;
+	void *addr;
+
+	if (STACK_DEBUG) {
+		stack_size = (fc->size + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1);
+		total_size = stack_size + (PAGE_SIZE * 2);
+		addr = fc;
+		addr -= PAGE_SIZE;
+		if (munmap(addr, total_size) != 0) {
+			errprint("munmap of %lu bytes @ %p failed: %s\n",
+				 total_size, addr, strerror(errno));
+		}
+	} else {
+		free(fc);
+	}
+}
+#endif
diff --git a/samples/rpal/librpal/fiber.h b/samples/rpal/librpal/fiber.h
new file mode 100644
index 000000000000..b46485ba740f
--- /dev/null
+++ b/samples/rpal/librpal/fiber.h
@@ -0,0 +1,64 @@
+#ifndef FIBER_H
+#define FIBER_H
+
+#include <stdlib.h>
+
+typedef void *fcontext_t;
+typedef struct {
+	fcontext_t fctx;
+	void *ud;
+} transfer_t;
+
+typedef struct fiber_stack {
+	unsigned long padding;
+	unsigned long r12;
+	unsigned long r13;
+	unsigned long r14;
+	unsigned long r15;
+	unsigned long rbx;
+	unsigned long rbp;
+	unsigned long rip;
+} fiber_stack_t;
+
+#define NR_PADDING 8
+typedef struct fiber_ctx {
+	void *sp;
+	size_t size;
+	void (*fn)(void *fc);
+	void *ud;
+	fcontext_t fctx;
+	int padding[NR_PADDING];
+} task_t;
+
+task_t *fiber_ctx_alloc(void (*fn)(void *ud), void *ud, size_t size);
+void fiber_ctx_free(task_t *fc);
+
+/**
+ * @brief Make a context for jump_fcontext.
+ *
+ * @param sp The stack top pointer of context.
+ * @param size The size of stack, this argument is useless. But a second argument is neccessary.
+ * @param fn The function pointer of the context function.
+ *
+ * @return The pointer of the newly made context.
+ */
+extern fcontext_t make_fcontext(void *sp, size_t size, void (*fn)(transfer_t));
+
+/**
+ * @brief jump to target context and execute fn with argument ud
+ *
+ * @param to The pointer of target context.
+ * @param ud The data part of the argument of fn.
+ *
+ * @return the pointer of the prev transfer_t struct, where RAX store
+ *  previous context, RDX store ud passed by previous caller.
+ */
+extern transfer_t jump_fcontext(fcontext_t const to, void *ud);
+
+/**
+ * @brief To be written.
+ */
+extern transfer_t ontop_fcontext(fcontext_t const to, void *ud,
+				 transfer_t (*fn)(transfer_t));
+
+#endif
diff --git a/samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S b/samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
new file mode 100644
index 000000000000..43d3a8149c58
--- /dev/null
+++ b/samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
@@ -0,0 +1,81 @@
+/*
+            Copyright Oliver Kowalke 2009.
+   Distributed under the Boost Software License, Version 1.0.
+      (See accompanying file LICENSE_1_0.txt or copy at
+            http://www.boost.org/LICENSE_1_0.txt)
+*/
+
+/****************************************************************************************
+ *                                                                                      *
+ *  ----------------------------------------------------------------------------------  *
+ *  |    0    |    1    |    2    |    3    |    4     |    5    |    6    |    7    |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |   0x0   |   0x4   |   0x8   |   0xc   |   0x10   |   0x14  |   0x18  |   0x1c  |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  | fc_mxcsr|fc_x87_cw|        R12        |         R13        |        R14        |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |    8    |    9    |   10    |   11    |    12    |    13   |    14   |    15   |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |   0x20  |   0x24  |   0x28  |  0x2c   |   0x30   |   0x34  |   0x38  |   0x3c  |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |        R15        |        RBX        |         RBP        |        RIP        |  *
+ *  ----------------------------------------------------------------------------------  *
+ *                                                                                      *
+ ****************************************************************************************/
+#ifdef __x86_64__
+.text
+.globl jump_fcontext
+.type jump_fcontext,@function
+.align 16
+jump_fcontext:
+	leaq  -0x38(%rsp), %rsp /* prepare stack */
+
+#if !defined(BOOST_USE_TSX)
+    stmxcsr  (%rsp)     /* save MMX control- and status-word */
+    fnstcw   0x4(%rsp)  /* save x87 control-word */
+#endif
+
+    movq  %r12, 0x8(%rsp)  /* save R12 */
+    movq  %r13, 0x10(%rsp)  /* save R13 */
+    movq  %r14, 0x18(%rsp)  /* save R14 */
+    movq  %r15, 0x20(%rsp)  /* save R15 */
+    movq  %rbx, 0x28(%rsp)  /* save RBX */
+    movq  %rbp, 0x30(%rsp)  /* save RBP */
+
+    /* store RSP (pointing to context-data) in RAX */
+    movq  %rsp, %rax
+
+    /* restore RSP (pointing to context-data) from RDI */
+    movq  %rdi, %rsp
+
+    movq  0x38(%rsp), %r8  /* restore return-address */
+
+#if !defined(BOOST_USE_TSX)
+    ldmxcsr  (%rsp)     /* restore MMX control- and status-word */
+    fldcw    0x4(%rsp)  /* restore x87 control-word */
+#endif
+
+    movq  0x8(%rsp), %r12  /* restore R12 */
+    movq  0x10(%rsp), %r13  /* restore R13 */
+    movq  0x18(%rsp), %r14  /* restore R14 */
+    movq  0x20(%rsp), %r15  /* restore R15 */
+    movq  0x28(%rsp), %rbx  /* restore RBX */
+    movq  0x30(%rsp), %rbp  /* restore RBP */
+
+    leaq  0x40(%rsp), %rsp /* prepare stack */
+
+    /* return transfer_t from jump */
+    /* RAX == fctx, RDX == data */
+    movq  %rsi, %rdx
+    /* pass transfer_t as first arg in context function */
+    /* RDI == fctx, RSI == data */
+    movq  %rax, %rdi
+
+    /* indirect jump to context */
+    jmp  *%r8
+.size jump_fcontext,.-jump_fcontext
+
+/* Mark that we don't need executable stack.  */
+.section .note.GNU-stack,"",%progbits
+#endif
diff --git a/samples/rpal/librpal/make_x86_64_sysv_elf_gas.S b/samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
new file mode 100644
index 000000000000..4f3af9247110
--- /dev/null
+++ b/samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
@@ -0,0 +1,82 @@
+/*
+            Copyright Oliver Kowalke 2009.
+   Distributed under the Boost Software License, Version 1.0.
+      (See accompanying file LICENSE_1_0.txt or copy at
+            http://www.boost.org/LICENSE_1_0.txt)
+*/
+
+/****************************************************************************************
+ *                                                                                      *
+ *  ----------------------------------------------------------------------------------  *
+ *  |    0    |    1    |    2    |    3    |    4     |    5    |    6    |    7    |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |   0x0   |   0x4   |   0x8   |   0xc   |   0x10   |   0x14  |   0x18  |   0x1c  |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  | fc_mxcsr|fc_x87_cw|        R12        |         R13        |        R14        |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |    8    |    9    |   10    |   11    |    12    |    13   |    14   |    15   |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |   0x20  |   0x24  |   0x28  |  0x2c   |   0x30   |   0x34  |   0x38  |   0x3c  |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |        R15        |        RBX        |         RBP        |        RIP        |  *
+ *  ----------------------------------------------------------------------------------  *
+ *                                                                                      *
+ ****************************************************************************************/
+#ifdef __x86_64__
+.text
+.globl make_fcontext
+.type make_fcontext,@function
+.align 16
+make_fcontext:
+    /* first arg of make_fcontext() == top of context-stack */
+    movq  %rdi, %rax
+
+    /* shift address in RAX to lower 16 byte boundary */
+    andq  $-16, %rax
+
+    /* reserve space for context-data on context-stack */
+    /* on context-function entry: (RSP -0x8) % 16 == 0 */
+    leaq  -0x40(%rax), %rax
+
+    /* third arg of make_fcontext() == address of context-function */
+    /* stored in RBX */
+    movq  %rdx, 0x28(%rax)
+
+    /* save MMX control- and status-word */
+    stmxcsr  (%rax)
+    /* save x87 control-word */
+    fnstcw   0x4(%rax)
+
+    /* compute abs address of label trampoline */
+    leaq  trampoline(%rip), %rcx
+    /* save address of trampoline as return-address for context-function */
+    /* will be entered after calling jump_fcontext() first time */
+    movq  %rcx, 0x38(%rax)
+
+    /* compute abs address of label finish */
+    leaq  finish(%rip), %rcx
+    /* save address of finish as return-address for context-function */
+    /* will be entered after context-function returns */
+    movq  %rcx, 0x30(%rax)
+
+    ret /* return pointer to context-data */
+
+trampoline:
+    /* store return address on stack */
+    /* fix stack alignment */
+    push %rbp
+    /* jump to context-function */
+    jmp *%rbx
+
+finish:
+    /* exit code is zero */
+    xorq  %rdi, %rdi
+    /* exit application */
+    call  _exit@PLT
+    hlt
+.size make_fcontext,.-make_fcontext
+
+/* Mark that we don't need executable stack. */
+.section .note.GNU-stack,"",%progbits
+#endif
\ No newline at end of file
diff --git a/samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S b/samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
new file mode 100644
index 000000000000..9dce797c2541
--- /dev/null
+++ b/samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
@@ -0,0 +1,84 @@
+/*
+            Copyright Oliver Kowalke 2009.
+   Distributed under the Boost Software License, Version 1.0.
+      (See accompanying file LICENSE_1_0.txt or copy at
+            http://www.boost.org/LICENSE_1_0.txt)
+*/
+
+/****************************************************************************************
+ *                                                                                      *
+ *  ----------------------------------------------------------------------------------  *
+ *  |    0    |    1    |    2    |    3    |    4     |    5    |    6    |    7    |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |   0x0   |   0x4   |   0x8   |   0xc   |   0x10   |   0x14  |   0x18  |   0x1c  |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  | fc_mxcsr|fc_x87_cw|        R12        |         R13        |        R14        |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |    8    |    9    |   10    |   11    |    12    |    13   |    14   |    15   |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |   0x20  |   0x24  |   0x28  |  0x2c   |   0x30   |   0x34  |   0x38  |   0x3c  |  *
+ *  ----------------------------------------------------------------------------------  *
+ *  |        R15        |        RBX        |         RBP        |        RIP        |  *
+ *  ----------------------------------------------------------------------------------  *
+ *                                                                                      *
+ ****************************************************************************************/
+#ifdef __x86_64__
+.text
+.globl ontop_fcontext
+.type ontop_fcontext,@function
+.align 16
+ontop_fcontext:
+    /* preserve ontop-function in R8 */
+    movq  %rdx, %r8
+
+    leaq  -0x38(%rsp), %rsp /* prepare stack */
+
+#if !defined(BOOST_USE_TSX)
+    stmxcsr  (%rsp)     /* save MMX control- and status-word */
+    fnstcw   0x4(%rsp)  /* save x87 control-word */
+#endif
+
+    movq  %r12, 0x8(%rsp)  /* save R12 */
+    movq  %r13, 0x10(%rsp)  /* save R13 */
+    movq  %r14, 0x18(%rsp)  /* save R14 */
+    movq  %r15, 0x20(%rsp)  /* save R15 */
+    movq  %rbx, 0x28(%rsp)  /* save RBX */
+    movq  %rbp, 0x30(%rsp)  /* save RBP */
+
+    /* store RSP (pointing to context-data) in RAX */
+    movq  %rsp, %rax
+
+    /* restore RSP (pointing to context-data) from RDI */
+    movq  %rdi, %rsp
+
+#if !defined(BOOST_USE_TSX)
+    ldmxcsr  (%rsp)     /* restore MMX control- and status-word */
+    fldcw    0x4(%rsp)  /* restore x87 control-word */
+#endif
+
+    movq  0x8(%rsp), %r12  /* restore R12 */
+    movq  0x10(%rsp), %r13  /* restore R13 */
+    movq  0x18(%rsp), %r14  /* restore R14 */
+    movq  0x20(%rsp), %r15  /* restore R15 */
+    movq  0x28(%rsp), %rbx  /* restore RBX */
+    movq  0x30(%rsp), %rbp  /* restore RBP */
+
+    leaq  0x38(%rsp), %rsp /* prepare stack */
+
+    /* return transfer_t from jump */
+    /* RAX == fctx, RDX == data */
+    movq  %rsi, %rdx
+    /* pass transfer_t as first arg in context function */
+    /* RDI == fctx, RSI == data */
+    movq  %rax, %rdi
+
+    /* keep return-address on stack */
+
+    /* indirect jump to context */
+    jmp  *%r8
+.size ontop_fcontext,.-ontop_fcontext
+
+/* Mark that we don't need executable stack.  */
+.section .note.GNU-stack,"",%progbits
+#endif
diff --git a/samples/rpal/librpal/private.h b/samples/rpal/librpal/private.h
new file mode 100644
index 000000000000..9dc78f449f0f
--- /dev/null
+++ b/samples/rpal/librpal/private.h
@@ -0,0 +1,341 @@
+#ifndef PRIVATE_H
+#define PRIVATE_H
+
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#ifdef __x86_64__
+#include <immintrin.h>
+#endif
+#include <pthread.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <sys/ioctl.h>
+
+#include "debug.h"
+#include "rpal_queue.h"
+#include "fiber.h"
+#include "rpal.h"
+
+#ifdef __x86_64__
+static inline void write_tls_base(unsigned long tls_base)
+{
+	asm volatile("wrfsbase %0" ::"r"(tls_base) : "memory");
+}
+
+static inline unsigned long read_tls_base(void)
+{
+	unsigned long fsbase;
+	asm volatile("rdfsbase %0" : "=r"(fsbase)::"memory");
+	return fsbase;
+}
+#endif
+
+#define likely(x) __builtin_expect(!!(x), 1)
+#define unlikely(x) __builtin_expect(!!(x), 0)
+
+// | fd_timestamp |   pad   | rthread_id | server_fd |
+// |     16       |    8    |      8     |    32     |
+#define LOW32_MASK ((1UL << 32) - 1)
+#define MIDL8_MASK ((unsigned long)(((1UL << 8) - 1)) << 32)
+
+#define HIGH16_OFFSET 48
+#define HIGH32_OFFSET 32
+
+#define get_high16(val) ({ (val) >> HIGH16_OFFSET; })
+
+#define get_high32(val) ({ (val) >> HIGH32_OFFSET; })
+
+#define get_midl8(val) ({ ((val) & MIDL8_MASK) >> HIGH32_OFFSET; })
+#define get_low32(val) ({ (val) & LOW32_MASK; })
+
+#define get_fdtimestamp(rpalfd) get_high16(rpalfd)
+#define get_rid(rpalfd) get_midl8(rpalfd)
+#define get_sfd(rpalfd) get_low32(rpalfd)
+
+#define PAGE_SIZE 4096
+#define DEFUALT_STACK_SIZE (PAGE_SIZE * 4)
+#define TRAMPOLINE_SIZE (PAGE_SIZE * 1)
+
+#define BITS_PER_LONG 64
+#define BITS_TO_LONGS(x)                                                       \
+	(((x) + 8 * sizeof(unsigned long) - 1) / (8 * sizeof(unsigned long)))
+
+#define KEY_SIZE 16
+
+enum rpal_sender_state {
+	RPAL_SENDER_STATE_RUNNING,
+	RPAL_SENDER_STATE_CALL,
+	RPAL_SENDER_STATE_KERNEL_RET,
+};
+
+enum rpal_epoll_event {
+	RPAL_KERNEL_PENDING = 0x1,
+	RPAL_USER_PENDING = 0x2,
+};
+
+enum rpal_receiver_state {
+	RPAL_RECEIVER_STATE_RUNNING,
+	RPAL_RECEIVER_STATE_KERNEL_RET,
+	RPAL_RECEIVER_STATE_READY,
+	RPAL_RECEIVER_STATE_WAIT,
+	RPAL_RECEIVER_STATE_CALL,
+	RPAL_RECEIVER_STATE_LAZY_SWITCH,
+	RPAL_RECEIVER_STATE_MAX,
+};
+
+enum rpal_command_type {
+	RPAL_CMD_GET_API_VERSION_AND_CAP,
+	RPAL_CMD_GET_SERVICE_KEY,
+	RPAL_CMD_GET_SERVICE_ID,
+	RPAL_CMD_REGISTER_SENDER,
+	RPAL_CMD_UNREGISTER_SENDER,
+	RPAL_CMD_REGISTER_RECEIVER,
+	RPAL_CMD_UNREGISTER_RECEIVER,
+	RPAL_CMD_ENABLE_SERVICE,
+	RPAL_CMD_DISABLE_SERVICE,
+	RPAL_CMD_REQUEST_SERVICE,
+	RPAL_CMD_RELEASE_SERVICE,
+	RPAL_CMD_GET_SERVICE_PKEY,
+	RPAL_CMD_UDS_FDMAP,
+	RPAL_NR_CMD,
+};
+
+/* RPAL ioctl macro */
+#define RPAL_IOCTL_MAGIC 0x33
+#define RPAL_IOCTL_GET_API_VERSION_AND_CAP                        \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_API_VERSION_AND_CAP, \
+	      struct rpal_version_info *)
+#define RPAL_IOCTL_GET_SERVICE_KEY \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_KEY, unsigned long)
+#define RPAL_IOCTL_GET_SERVICE_ID \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_ID, int *)
+#define RPAL_IOCTL_REGISTER_SENDER \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REGISTER_SENDER, unsigned long)
+#define RPAL_IOCTL_UNREGISTER_SENDER \
+	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_UNREGISTER_SENDER)
+#define RPAL_IOCTL_REGISTER_RECEIVER \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REGISTER_RECEIVER, unsigned long)
+#define RPAL_IOCTL_UNREGISTER_RECEIVER \
+	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_UNREGISTER_RECEIVER)
+#define RPAL_IOCTL_ENABLE_SERVICE \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_ENABLE_SERVICE, unsigned long)
+#define RPAL_IOCTL_DISABLE_SERVICE \
+	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_DISABLE_SERVICE)
+#define RPAL_IOCTL_REQUEST_SERVICE \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REQUEST_SERVICE, unsigned long)
+#define RPAL_IOCTL_RELEASE_SERVICE \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_RELEASE_SERVICE, unsigned long)
+#define RPAL_IOCTL_GET_SERVICE_PKEY \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_PKEY, int *)
+#define RPAL_IOCTL_UDS_FDMAP \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_UDS_FDMAP, void *)
+
+typedef enum rpal_receiver_status {
+	RPAL_RECEIVER_UNINITIALIZED,
+	RPAL_RECEIVER_INITIALIZED,
+	RPAL_RECEIVER_AVAILABLE,
+} rpal_receiver_status_t;
+
+enum RPAL_CAPABILITIES {
+	RPAL_CAP_PKU,
+};
+
+#define RPAL_SID_SHIFT 24
+#define RPAL_ID_SHIFT 8
+#define RPAL_RECEIVER_STATE_MASK ((1 << RPAL_ID_SHIFT) - 1)
+#define RPAL_SID_MASK (~((1 << RPAL_SID_SHIFT) - 1))
+#define RPAL_ID_MASK (~(0 | RPAL_RECEIVER_STATE_MASK | RPAL_SID_MASK))
+#define RPAL_MAX_ID ((1 << (RPAL_SID_SHIFT - RPAL_ID_SHIFT)) - 1)
+#define RPAL_BUILD_CALL_STATE(id, sid)                                             \
+	((sid << RPAL_SID_SHIFT) | (id << RPAL_ID_SHIFT) | RPAL_RECEIVER_STATE_CALL)
+
+typedef struct rpal_capability {
+	int compat_version;
+	int api_version;
+	unsigned long cap;
+} rpal_capability_t;
+
+typedef struct task_context {
+	unsigned long r15;
+	unsigned long r14;
+	unsigned long r13;
+	unsigned long r12;
+	unsigned long rbx;
+	unsigned long rbp;
+	unsigned long rip;
+	unsigned long rsp;
+} task_context_t;
+
+typedef struct receiver_context {
+	task_context_t task_context;
+	int receiver_id;
+	int receiver_state;
+	int sender_state;
+	int ep_pending;
+	int rpal_ep_poll_magic;
+	int epfd;
+	void *ep_events;
+	int maxevents;
+	int timeout;
+	int64_t total_time;
+} receiver_context_t;
+
+typedef struct rpal_call_info {
+	unsigned long sender_tls_base;
+	uint32_t pkru;
+	fcontext_t sender_fctx;
+} rpal_call_info_t;
+
+enum thread_type {
+	RPAL_RECEIVER = 0x1,
+	RPAL_SENDER = 0x2,
+};
+typedef struct rpal_receiver_info {
+	long tid;
+	unsigned long tls_base;
+
+	int epfd;
+	rpal_receiver_status_t status;
+	epoll_uevent_queue_t ueventq;
+	volatile uint64_t uqlock;
+
+	fcontext_t main_ctx;
+	task_t *ep_stack;
+	task_t *trampoline;
+
+	rpal_call_info_t rci;
+
+	volatile receiver_context_t *rc;
+	struct rpal_thread_pool *rtp;
+} rpal_receiver_info_t;
+
+typedef struct fd_table fd_table_t;
+/* Keep it the same as kernel */
+struct rpal_thread_pool {
+	rpal_receiver_info_t *rris;
+	fd_table_t *fdt;
+	uint64_t service_key;
+	int nr_threads;
+	int service_id;
+	int pkey;
+};
+
+struct rpal_request_arg {
+	unsigned long version;
+	uint64_t key;
+	struct rpal_thread_pool **rtp;
+	int *id;
+	int *pkey;
+};
+
+struct rpal_uds_fdmap_arg {
+	int service_id;
+	int cfd;
+	unsigned long *res;
+};
+
+#define RPAL_ERROR_MAGIC 0x98CC98CC
+
+typedef struct rpal_error_context {
+	unsigned long tls_base;
+	uint64_t erip;
+	uint64_t ersp;
+	int state;
+	int magic;
+} rpal_error_context_t;
+
+typedef struct sender_context {
+	task_context_t task_context;
+	rpal_error_context_t ec;
+	int sender_id;
+	int64_t start_time;
+	int64_t total_time;
+} sender_context_t;
+
+#define RPAL_EP_POLL_MAGIC 0xCC98CC98
+
+typedef struct rpal_sender_info {
+	int idx;
+	int tid;
+	int pkey;
+	int inited;
+	sender_context_t sc;
+} rpal_sender_info_t;
+
+typedef struct fdt_node fdt_node_t;
+
+typedef struct fd_event {
+	int epfd;
+	int fd;
+	struct epoll_event epev;
+	uint32_t events;
+	int wait;
+
+	rpal_queue_t q;
+	int pkey; // unused
+	fdt_node_t *node;
+	struct fd_event *next;
+	uint16_t timestamp;
+	uint16_t outdated;
+	uint64_t service_key;
+} fd_event_t;
+
+struct fdt_node {
+	fd_event_t **events;
+	fdt_node_t *next;
+	int *ref_count;
+	uint16_t *timestamps;
+};
+
+// when sender calls fd_event_get, we must check this number to avoid
+// accessing outdated fdt_node definitions
+
+#define FDTAB_MAG1 0x4D414731UL // add fde lazyswitch
+#define FDTAB_MAG2 0x14D414731UL // add fde timestamp
+#define FDTAB_MAG3 0x34D414731UL // add fde outdated
+#define FDTAB_MAG4 0x74D414731UL // add automatic identification rpal mode
+
+enum fde_ref_status {
+	FDE_FREEING = -100,
+	FDE_FREED = -1,
+	FDE_AVAILABLE = 0,
+};
+
+#define DEFAULT_NODE_SHIFT 14 // 2^14 elements per node
+typedef struct fd_table {
+	fdt_node_t *head;
+	fdt_node_t *tail;
+	int max_fd;
+	unsigned int node_shift;
+	unsigned int node_mask;
+	pthread_mutex_t lock;
+	unsigned long magic;
+	fd_event_t *freelist;
+	pthread_mutex_t list_lock;
+} fd_table_t;
+
+typedef struct critical_section {
+	unsigned long ret_begin;
+	unsigned long ret_end;
+} critical_section_t;
+
+struct rpal_service_metadata {
+	unsigned long version;
+	struct rpal_thread_pool *rtp;
+	critical_section_t rcs;
+	int pkey;
+};
+
+#ifndef RPAL_DEBUG
+#define dbprint(category, format, args...) ((void)0)
+#else
+void dbprint(rpal_debug_flag_t category, char *format, ...)
+	__attribute__((format(printf, 2, 3)));
+#endif
+void errprint(const char *format, ...) __attribute__((format(printf, 1, 2)));
+void warnprint(const char *format, ...) __attribute__((format(printf, 1, 2)));
+
+#endif
diff --git a/samples/rpal/librpal/rpal.c b/samples/rpal/librpal/rpal.c
new file mode 100644
index 000000000000..64bd2b93bd67
--- /dev/null
+++ b/samples/rpal/librpal/rpal.c
@@ -0,0 +1,2351 @@
+#include "private.h"
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <assert.h>
+#include <sys/socket.h>
+#include <sys/mman.h>
+#include <sys/eventfd.h>
+#include <linux/futex.h>
+#include <signal.h>
+#include <stdarg.h>
+
+#include "rpal_pkru.h"
+
+/* prints an error message to stderr */
+void errprint(const char *format, ...)
+{
+	va_list args;
+
+	fprintf(stderr, "[RPAL_ERROR] ");
+	va_start(args, format);
+	vfprintf(stderr, format, args);
+	va_end(args);
+}
+
+/* prints a warning message to stderr */
+void warnprint(const char *format, ...)
+{
+	va_list args;
+
+	fprintf(stderr, "[RPAL_WARNING] ");
+	va_start(args, format);
+	vfprintf(stderr, format, args);
+	va_end(args);
+}
+
+#ifdef RPAL_DEBUG
+void dbprint(rpal_debug_flag_t category, char *format, ...)
+{
+	if (category & RPAL_DEBUG) {
+		va_list args;
+		fprintf(stderr, "[RPAL_DEBUG] ");
+		va_start(args, format);
+		vfprintf(stderr, format, args);
+		va_end(args);
+	}
+}
+#endif
+
+#define SAVE_FPU(mxcsr, fpucw)                                                 \
+	__asm__ __volatile__("stmxcsr %0;"                                     \
+			     "fnstcw %1;"                                      \
+			     : "=m"(mxcsr), "=m"(fpucw)                        \
+			     :)
+#define RESTORE_FPU(mxcsr, fpucw)                                              \
+	__asm__ __volatile__("ldmxcsr %0;"                                     \
+			     "fldcw %1;"                                       \
+			     :                                                 \
+			     : "m"(mxcsr), "m"(fpucw))
+
+#define ERRREPORT(EPTR, ECODE, ...)                                            \
+	if (EPTR) {                                                            \
+		*EPTR = ECODE;                                                 \
+	}                                                                      \
+	errprint(__VA_ARGS__);
+
+#define RPAL_MGT_FILE "/proc/rpal"
+#define MAX_SUPPROTED_CPUS 192
+
+static __always_inline unsigned long __ffs(unsigned long word)
+{
+	asm("rep; bsf %1,%0" : "=r"(word) : "rm"(word));
+
+	return word;
+}
+
+static void __set_bit(uint64_t *bitmap, int idx)
+{
+	int bit, i;
+	i = idx / 8;
+	bit = idx % 8;
+	bitmap[i] |= (1UL << bit);
+}
+
+static int clear_first_set_bit(uint64_t *bitmap, int size)
+{
+	int idx;
+	int bit, i;
+
+	for (i = 0; i * BITS_PER_LONG < size; i++) {
+		if (bitmap[i]) {
+			bit = __ffs(bitmap[i]);
+			idx = i * BITS_PER_LONG + bit;
+			if (idx >= size) {
+				return -1;
+			}
+			bitmap[i] &= ~(1UL << bit);
+			return idx;
+		}
+	}
+	return -1;
+}
+
+extern void rpal_get_critical_addr(critical_section_t *rcs);
+static critical_section_t rcs = { 0 };
+
+#define MAX_SERVICEID 254 // Intel MPK Limit
+#define MIN_RPAL_KERNEL_API_VERSION 1
+#define TARGET_RPAL_KERNEL_API_VERSION                                         \
+	1 // RPAL will disable when KERNEL_API < TARGET_RPAL_KERNEL_API_VERSION
+
+enum {
+	RCALL_IN = 0x1 << 0,
+	RCALL_OUT = 0x1 << 1,
+};
+
+enum {
+	FDE_NO_TRIGGER,
+	FDE_TRIGGER_OUT,
+};
+
+#define EPOLLRPALINOUT_BITS (EPOLLRPALIN | EPOLLRPALOUT)
+
+#define DEFAULT_QUEUE_SIZE 32U
+
+typedef struct rpal_requested_service {
+	struct rpal_thread_pool *service;
+	int pkey;
+	uint64_t key;
+} rpal_requeseted_service_t;
+
+static int rpal_mgtfd = -1;
+static int inited;
+int pkru_enabled = 0;
+
+static rpal_capability_t version;
+static pthread_key_t rpal_key;
+static rpal_requeseted_service_t requested_services[MAX_SERVICEID];
+static pthread_mutex_t release_lock;
+
+typedef struct rpal_local {
+	unsigned int tflag;
+	rpal_receiver_info_t *rri;
+	rpal_sender_info_t *rsi;
+} rpal_local_t;
+
+#define SENDERS_PAGE_ORDER 3
+#define RPALTHREAD_PAGE_ORDER 0
+
+typedef struct rpal_thread_metadata {
+	int rpal_receiver_idx;
+	int service_id;
+	const int epcpage_order;
+	uint64_t service_key;
+	struct rpal_thread_pool *rtp;
+	receiver_context_t *rc;
+	pid_t pid;
+	int *eventfds;
+} rpal_thread_metadata_t;
+
+static rpal_thread_metadata_t threads_md = {
+	.service_id = -1,
+	.epcpage_order = RPALTHREAD_PAGE_ORDER,
+};
+
+static inline rpal_sender_info_t *current_rpal_sender(void)
+{
+	rpal_local_t *local;
+
+	local = pthread_getspecific(rpal_key);
+	if (local && (local->tflag & RPAL_SENDER)) {
+		return local->rsi;
+	} else {
+		return NULL;
+	}
+}
+
+static inline rpal_receiver_info_t *current_rpal_thread(void)
+{
+	rpal_local_t *local;
+
+	local = pthread_getspecific(rpal_key);
+	if (local && (local->tflag & RPAL_RECEIVER)) {
+		return local->rri;
+	} else {
+		return NULL;
+	}
+}
+
+static status_t rpal_register_sender_local(rpal_sender_info_t *sender)
+{
+	rpal_local_t *local;
+	local = pthread_getspecific(rpal_key);
+	if (!local) {
+		local = malloc(sizeof(rpal_local_t));
+		if (!local)
+			return RPAL_FAILURE;
+		memset(local, 0, sizeof(rpal_local_t));
+		pthread_setspecific(rpal_key, local);
+	}
+	if (local->tflag & RPAL_SENDER) {
+		return RPAL_FAILURE;
+	}
+	local->rsi = sender;
+	local->tflag |= RPAL_SENDER;
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_unregister_sender_local(void)
+{
+	rpal_local_t *local;
+	local = pthread_getspecific(rpal_key);
+	if (!local || !(local->tflag & RPAL_SENDER))
+		return RPAL_FAILURE;
+
+	local->rsi = NULL;
+	local->tflag &= ~RPAL_SENDER;
+	if (!local->tflag) {
+		pthread_setspecific(rpal_key, NULL);
+		free(local);
+	}
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_register_receiver_local(rpal_receiver_info_t *thread)
+{
+	rpal_local_t *local;
+	local = pthread_getspecific(rpal_key);
+	if (!local) {
+		local = malloc(sizeof(rpal_local_t));
+		if (!local)
+			return RPAL_FAILURE;
+		memset(local, 0, sizeof(rpal_local_t));
+		pthread_setspecific(rpal_key, local);
+	}
+	if (local->tflag & RPAL_RECEIVER) {
+		return RPAL_FAILURE;
+	}
+	local->rri = thread;
+	local->tflag |= RPAL_RECEIVER;
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_unregister_receiver_local(void)
+{
+	rpal_local_t *local;
+	local = pthread_getspecific(rpal_key);
+	if (!local || !(local->tflag & RPAL_RECEIVER))
+		return RPAL_FAILURE;
+
+	local->rri = NULL;
+	local->tflag &= ~RPAL_RECEIVER;
+	if (!local->tflag) {
+		pthread_setspecific(rpal_key, NULL);
+		free(local);
+	}
+	return RPAL_SUCCESS;
+}
+
+#define MAX_SENDERS 256
+typedef struct rpal_senders_metadata {
+	uint64_t bitmap[BITS_TO_LONGS(MAX_SENDERS)];
+	pthread_mutex_t lock;
+	int sdpage_order;
+	rpal_sender_info_t *senders;
+} rpal_senders_metadata_t;
+
+static rpal_senders_metadata_t *senders_md;
+
+static long rpal_ioctl(unsigned long cmd, unsigned long arg)
+{
+	struct {
+		unsigned long *ret;
+		unsigned long cmd;
+		unsigned long arg0;
+		unsigned long arg1;
+	} args;
+	const int args_size = sizeof(args);
+	int ret;
+
+	if (rpal_mgtfd == -1) {
+		errprint("rpal_mgtfd is not opened\n");
+		return -1;
+	}
+
+	ret = ioctl(rpal_mgtfd, cmd, arg);
+
+	return ret;
+}
+
+static inline long rpal_register_sender(rpal_sender_info_t *sender)
+{
+	long ret;
+
+	if (rpal_register_sender_local(sender) == RPAL_FAILURE)
+		return RPAL_FAILURE;
+
+	ret = rpal_ioctl(RPAL_IOCTL_REGISTER_SENDER,
+			 (unsigned long)&sender->sc);
+	if (ret < 0) {
+		rpal_unregister_sender_local();
+	}
+	return ret;
+}
+
+static inline long rpal_register_receiver(rpal_receiver_info_t *rri)
+{
+	long ret;
+
+	if (rpal_register_receiver_local(rri) == RPAL_FAILURE)
+		return RPAL_FAILURE;
+	ret = rpal_ioctl(RPAL_IOCTL_REGISTER_RECEIVER,
+			 (unsigned long)rri->rc);
+	if (ret < 0) {
+		rpal_unregister_receiver_local();
+	}
+	return ret;
+}
+
+static inline long rpal_unregister_sender(void)
+{
+	if (rpal_unregister_sender_local() == RPAL_FAILURE)
+		return RPAL_FAILURE;
+	return rpal_ioctl(RPAL_IOCTL_UNREGISTER_SENDER, 0);
+}
+
+static inline long rpal_unregister_receiver(void)
+{
+	if (rpal_unregister_receiver_local() == RPAL_FAILURE)
+		return RPAL_FAILURE;
+	return rpal_ioctl(RPAL_IOCTL_UNREGISTER_RECEIVER, 0);
+}
+
+static int rpal_get_service_pkey(void)
+{
+	int pkey, ret;
+
+	ret = rpal_ioctl(RPAL_IOCTL_GET_SERVICE_PKEY, (unsigned long)&pkey);
+	if (ret < 0 || pkey == -1) {
+		warnprint("MPK not supported on this host, disabling PKRU\n");
+		return -1;
+	}
+	return pkey;
+}
+
+static int __rpal_get_service_id(void)
+{
+	int id, ret;
+
+	ret = rpal_ioctl(RPAL_IOCTL_GET_SERVICE_ID, (unsigned long)&id);
+
+	if (ret < 0)
+		return ret;
+	else
+		return id;
+}
+
+static uint64_t __rpal_get_service_key(void)
+{
+	int ret;
+	uint64_t key;
+
+	ret = rpal_ioctl(RPAL_IOCTL_GET_SERVICE_KEY, (unsigned long)&key);
+	if (ret < 0)
+		return 0;
+	else
+		return key;
+}
+
+static void *rpal_get_shared_page(int order)
+{
+	void *p;
+	int size;
+	int flags = MAP_SHARED;
+
+	if (rpal_mgtfd == -1) {
+		return NULL;
+	}
+	size = PAGE_SIZE * (1 << order);
+
+	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, rpal_mgtfd, 0);
+
+	return p;
+}
+
+static int rpal_free_shared_page(void *page, int order)
+{
+	int ret = 0;
+	int size;
+
+	size = PAGE_SIZE * (1 << order);
+	ret = munmap(page, size);
+	if (ret) {
+		errprint("munmap fail: %d\n", ret);
+	}
+	return ret;
+}
+
+static inline int rpal_inited(void)
+{
+	return (inited == 1);
+}
+
+static inline int sender_idx_is_invalid(int idx)
+{
+	if (idx < 0 || idx >= MAX_SENDERS)
+		return 1;
+	return 0;
+}
+
+static int rpal_sender_info_alloc(rpal_sender_info_t **sender)
+{
+	int idx;
+
+	if (!senders_md)
+		return RPAL_FAILURE;
+	pthread_mutex_lock(&senders_md->lock);
+	idx = clear_first_set_bit(senders_md->bitmap, MAX_SENDERS);
+	if (idx < 0) {
+		errprint("sender data alloc failed: %d, bitmap: %lx\n", idx,
+			 senders_md->bitmap[0]);
+		goto unlock;
+	}
+	*sender = senders_md->senders + idx;
+
+unlock:
+	pthread_mutex_unlock(&senders_md->lock);
+	return idx;
+}
+
+static void rpal_sender_info_free(int idx)
+{
+	if (sender_idx_is_invalid(idx)) {
+		return;
+	}
+	pthread_mutex_lock(&senders_md->lock);
+	__set_bit(senders_md->bitmap, idx);
+	pthread_mutex_unlock(&senders_md->lock);
+}
+
+extern unsigned long rpal_get_ret_rip(void);
+
+static int rpal_sender_inited(rpal_sender_info_t *sender)
+{
+	return (sender->inited == 1);
+}
+
+status_t rpal_sender_init(rpal_error_code_t *error)
+{
+	int idx;
+	int ret = RPAL_FAILURE;
+	rpal_sender_info_t *sender;
+
+	if (!rpal_inited()) {
+		ERRREPORT(error, RPAL_DONT_INITED, "%s: rpal do not init\n",
+			  __FUNCTION__);
+		goto error_out;
+	}
+	sender = current_rpal_sender();
+	if (sender) {
+		goto error_out;
+	}
+	idx = rpal_sender_info_alloc(&sender);
+	if (idx < 0) {
+		if (error) {
+			*error = RPAL_ERR_SENDER_INIT;
+		}
+		goto error_out;
+	}
+	sender->idx = idx;
+	sender->sc.sender_id = idx;
+	sender->tid = syscall(SYS_gettid);
+	sender->pkey = rpal_get_service_pkey();
+	sender->sc.ec.erip = rpal_get_ret_rip();
+	ret = rpal_register_sender(sender);
+	if (ret) {
+		ERRREPORT(error, RPAL_ERR_SENDER_REG,
+			  "rpal_register_sender error: %d\n", ret);
+		goto sender_register_failed;
+	}
+	sender->inited = 1;
+	return RPAL_SUCCESS;
+
+sender_register_failed:
+	rpal_sender_info_free(idx);
+error_out:
+	return RPAL_FAILURE;
+}
+
+status_t rpal_sender_exit(void)
+{
+	int idx;
+	rpal_sender_info_t *sender;
+
+	sender = current_rpal_sender();
+
+	if (sender) {
+		idx = sender->idx;
+		sender->idx = 0;
+		sender->tid = 0;
+		rpal_unregister_sender();
+		rpal_sender_info_free(idx);
+		sender->pkey = 0;
+	}
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_enable_service(rpal_error_code_t *error)
+{
+	struct rpal_service_metadata rsm;
+	long ret = 0;
+
+	rsm.version = 0;
+	rsm.rtp = threads_md.rtp;
+	rsm.rcs = rcs;
+	rsm.pkey = -1;
+	ret = rpal_ioctl(RPAL_IOCTL_ENABLE_SERVICE, (unsigned long)&rsm);
+	if (ret) {
+		ERRREPORT(error, RPAL_ERR_ENABLE_SERVICE,
+			  "rpal enable service failed: %ld\n", ret)
+		return RPAL_FAILURE;
+	}
+	threads_md.rtp->pkey = rpal_get_service_pkey();
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_disable_service(void)
+{
+	long ret = 0;
+	ret = rpal_ioctl(RPAL_IOCTL_DISABLE_SERVICE, 0);
+	if (ret) {
+		errprint("rpal disable service failed: %ld\n", ret);
+		return RPAL_FAILURE;
+	}
+	return RPAL_SUCCESS;
+}
+
+static status_t add_requested_service(struct rpal_thread_pool *rtp, uint64_t key, int id, int pkey)
+{
+	struct rpal_thread_pool *expected = NULL;
+
+	if (!rtp) {
+		errprint("add requested service null\n");
+		return RPAL_FAILURE;
+	}
+
+	if (!__atomic_compare_exchange_n(&requested_services[id].service,
+					 &expected, rtp, 1, __ATOMIC_SEQ_CST,
+					 __ATOMIC_SEQ_CST)) {
+		errprint("rpal service %d already add, expected: %ld\n", id,
+			 expected->service_key);
+		return RPAL_FAILURE;
+	}
+	requested_services[id].key = key;
+	requested_services[id].pkey = pkey;
+	return RPAL_SUCCESS;
+}
+
+int rpal_get_request_service_id(uint64_t key)
+{
+	int i;
+
+	for (i = 0; i < MAX_SERVICEID; i++) {
+		if (requested_services[i].key == key)
+			return i;
+	}
+	return -1;
+}
+
+static struct rpal_thread_pool *get_service_from_key(uint64_t key)
+{
+	int i;
+	struct rpal_thread_pool *rtp;
+
+	for (i = 0; i < MAX_SERVICEID; i++) {
+		if (requested_services[i].key == key)
+			return requested_services[i].service;
+	}
+	return NULL;
+}
+
+static inline struct rpal_thread_pool *get_service_from_id(int id)
+{
+	return requested_services[id].service;
+}
+
+static inline int get_service_pkey_from_id(int id)
+{
+	return requested_services[id].pkey;
+}
+
+static struct rpal_thread_pool *del_requested_service(uint64_t key)
+{
+	int id;
+	struct rpal_thread_pool *rtp;
+
+	id = rpal_get_request_service_id(key);
+	if (id == -1)
+		return NULL;
+	rtp = __atomic_exchange_n(&requested_services[id].service, NULL,
+				  __ATOMIC_RELAXED);
+	return rtp;
+}
+
+int rpal_request_service(uint64_t key)
+{
+	struct rpal_request_arg rra;
+	long ret = RPAL_FAILURE;
+	struct rpal_thread_pool *rtp;
+	int id, pkey;
+
+	if (!rpal_inited()) {
+		errprint("%s: rpal do not init\n", __FUNCTION__);
+		goto error_out;
+	}
+
+	rra.version = 0;
+	rra.key = key;
+	rra.rtp = &rtp;
+	rra.id = &id;
+	rra.pkey = &pkey;
+	ret = rpal_ioctl(RPAL_IOCTL_REQUEST_SERVICE, (unsigned long)&rra);
+	if (ret) {
+		goto error_out;
+	}
+
+	ret = add_requested_service(rtp, key, id, pkey);
+	if (ret == RPAL_FAILURE) {
+		goto add_requested_failed;
+	}
+
+	return RPAL_SUCCESS;
+
+add_requested_failed:
+	rpal_ioctl(RPAL_IOCTL_RELEASE_SERVICE, key);
+error_out:
+	return (int)ret;
+}
+
+static void fdt_freelist_forcefree(fd_table_t *fdt, uint64_t service_key);
+
+status_t rpal_release_service(uint64_t key)
+{
+	long ret;
+	struct rpal_thread_pool *rtp;
+
+	if (!rpal_inited()) {
+		errprint("%s: rpal do not init\n", __FUNCTION__);
+		return RPAL_FAILURE;
+	}
+
+	rtp = del_requested_service(key);
+	ret = rpal_ioctl(RPAL_IOCTL_RELEASE_SERVICE, key);
+	if (ret) {
+		errprint("rpal release service failed: %ld\n", ret);
+		return RPAL_FAILURE;
+	}
+	fdt_freelist_forcefree(threads_md.rtp->fdt, key);
+	return RPAL_SUCCESS;
+}
+
+static void try_clean_lock(rpal_receiver_info_t *rri, uint64_t key)
+{
+	uint64_t lock_state = key | 1UL << 63;
+
+	if (__atomic_load_n(&rri->uqlock, __ATOMIC_RELAXED) == lock_state)
+		uevent_queue_fix(&rri->ueventq);
+
+	if (__atomic_compare_exchange_n(&rri->uqlock, &lock_state, (uint64_t)0,
+					1, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST))
+		dbprint(RPAL_DEBUG_MANAGEMENT,
+			"Serivce (key: %lu) does exit with holding lock\n",
+			key);
+}
+
+struct release_info {
+	uint64_t keys[KEY_SIZE];
+	int size;
+};
+
+status_t rpal_clean_service_start(int64_t *ptr)
+{
+	rpal_receiver_info_t *rri;
+	struct release_info *info;
+	int i, j;
+	int size;
+
+	if (!ptr) {
+		goto error_out;
+	}
+
+	info = malloc(sizeof(struct release_info));
+	if (info == NULL) {
+		errprint("alloc release_info fail\n");
+		goto error_out;
+	}
+
+	pthread_mutex_lock(&release_lock);
+	size = read(rpal_mgtfd, info->keys, KEY_SIZE * sizeof(uint64_t));
+	if (size <= 0) {
+		errprint("Read keys on rpal_mgtfd failed\n");
+		goto error_unlock;
+	}
+
+	size /= sizeof(uint64_t);
+	info->size = size;
+
+	for (i = 0; i < size; i++) {
+		for (j = 0; j < threads_md.rtp->nr_threads; j++) {
+			rri = threads_md.rtp->rris + j;
+			try_clean_lock(rri, info->keys[i]);
+		}
+	}
+	pthread_mutex_unlock(&release_lock);
+	*ptr = (int64_t)info;
+	return RPAL_SUCCESS;
+
+error_unlock:
+	pthread_mutex_unlock(&release_lock);
+	free(info);
+error_out:
+	return RPAL_FAILURE;
+}
+
+void rpal_clean_service_end(int64_t *ptr)
+{
+	int i;
+	struct release_info *info;
+
+	if (ptr == NULL)
+		return;
+	info = (struct release_info *)(*ptr);
+	if (info == NULL)
+		return;
+	for (i = 0; i < info->size; i++) {
+		dbprint(RPAL_DEBUG_MANAGEMENT, "release service: 0x%lx\n",
+			info->keys[i]);
+		rpal_release_service(info->keys[i]);
+	}
+	free(info);
+}
+int rpal_get_service_id(void)
+{
+	if (!rpal_inited()) {
+		return RPAL_FAILURE;
+	}
+	return threads_md.service_id;
+}
+
+status_t rpal_get_service_key(uint64_t *service_key)
+{
+	if (!rpal_inited() || !service_key) {
+		return RPAL_FAILURE;
+	}
+	*service_key = threads_md.service_key;
+	return RPAL_SUCCESS;
+}
+
+static fdt_node_t *fdt_node_alloc(fd_table_t *fdt)
+{
+	fdt_node_t *node;
+	fd_event_t **ev;
+	int *ref_count;
+	uint16_t *timestamps;
+	int size = 0;
+
+	node = malloc(sizeof(fdt_node_t));
+	if (!node)
+		goto node_alloc_failed;
+
+	size = sizeof(fd_event_t **) * (1 << fdt->node_shift);
+	ev = malloc(size);
+	if (!ev)
+		goto events_alloc_failed;
+	memset(ev, 0, size);
+
+	size = sizeof(int) * (1 << fdt->node_shift);
+	ref_count = malloc(size);
+	if (!ref_count)
+		goto used_alloc_failed;
+	memset(ref_count, 0xff, size);
+
+	size = sizeof(uint16_t) * (1 << fdt->node_shift);
+	timestamps = malloc(size);
+	if (!timestamps)
+		goto ts_alloc_failed;
+	memset(timestamps, 0, size);
+
+	node->events = ev;
+	node->ref_count = ref_count;
+	node->next = NULL;
+	node->timestamps = timestamps;
+	if (!fdt->head) {
+		fdt->head = node;
+		fdt->tail = node;
+	} else {
+		fdt->tail->next = node;
+		fdt->tail = node;
+	}
+	fdt->max_fd += (1 << fdt->node_shift);
+	return node;
+
+ts_alloc_failed:
+	free(ref_count);
+used_alloc_failed:
+	free(ev);
+events_alloc_failed:
+	free(node);
+node_alloc_failed:
+	errprint("%s Error!!! max_fd: %d\n", __FUNCTION__, fdt->max_fd);
+	return NULL;
+}
+
+static void fdt_node_free_all(fd_table_t *fdt)
+{
+	fdt_node_t *node, *ptr;
+
+	node = fdt->head;
+	while (node) {
+		free(node->timestamps);
+		free(node->ref_count);
+		free(node->events);
+		ptr = node;
+		node = node->next;
+		free(ptr);
+	}
+}
+
+static fdt_node_t *fdt_node_expand(fd_table_t *fdt, int fd)
+{
+	fdt_node_t *node = NULL;
+	while (fd >= fdt->max_fd) {
+		node = fdt_node_alloc(fdt);
+		if (!node)
+			break;
+	}
+	return node;
+}
+
+static fdt_node_t *fdt_node_search(fd_table_t *fdt, int fd)
+{
+	fdt_node_t *node = NULL;
+	int pos = 0;
+	if (fd >= fdt->max_fd)
+		return NULL;
+	pos = fd >> fdt->node_shift;
+	node = fdt->head;
+	while (pos) {
+		if (!node) {
+			errprint(
+				"fdt node search ERROR! fd: %d, pos: %d, fdt->max_fd: %d\n",
+				fd, pos, fdt->max_fd);
+			return NULL;
+		}
+		node = node->next;
+		pos--;
+	}
+	return node;
+}
+
+static fd_table_t *fd_table_alloc(unsigned int node_shift)
+{
+	fd_table_t *fdt;
+	pthread_mutexattr_t mattr;
+
+	fdt = malloc(sizeof(fd_table_t));
+	if (!fdt)
+		return NULL;
+	fdt->head = NULL;
+	fdt->tail = NULL;
+	fdt->max_fd = 0;
+	fdt->node_shift = node_shift;
+	fdt->node_mask = (1 << node_shift) - 1;
+	fdt->freelist = NULL;
+	pthread_mutex_init(&fdt->list_lock, NULL);
+
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&fdt->lock, &mattr);
+	return fdt;
+}
+
+static void fd_table_free(fd_table_t *fdt)
+{
+	if (!fdt)
+		return;
+	fdt_node_free_all(fdt);
+	free(fdt);
+	return;
+}
+
+static inline fd_event_t *fd_event_alloc(int fd, int epfd,
+					 struct epoll_event *event)
+{
+	fd_event_t *fde;
+	uint64_t *qdata;
+
+	fde = (fd_event_t *)malloc(sizeof(fd_event_t));
+	if (!fde)
+		return NULL;
+
+	fde->fd = fd;
+	fde->epfd = epfd;
+	fde->epev = *event;
+	fde->events = 0;
+	fde->node = NULL;
+	fde->next = NULL;
+	fde->timestamp = 0;
+	fde->service_key = 0;
+	__atomic_store_n(&fde->outdated, (uint16_t)0, __ATOMIC_RELEASE);
+
+	qdata = malloc(DEFAULT_QUEUE_SIZE * sizeof(uint64_t));
+	if (!qdata) {
+		errprint("malloc queue data failed\n");
+		goto malloc_error;
+	}
+	if (rpal_queue_init(&fde->q, qdata, DEFAULT_QUEUE_SIZE)) {
+		errprint("fde queue alloc failed, fd: %d\n", fd);
+		goto init_error;
+	}
+	return fde;
+
+init_error:
+	free(qdata);
+malloc_error:
+	free(fde);
+	return NULL;
+}
+
+static inline void fd_event_free(fd_event_t *fde)
+{
+	uint64_t *qdata;
+
+	if (!fde)
+		return;
+	qdata = rpal_queue_destroy(&fde->q);
+	free(qdata);
+	free(fde);
+	return;
+}
+
+static void fdt_freelist_insert(fd_table_t *fdt, fd_event_t *fde)
+{
+	if (!fde)
+		return;
+
+	pthread_mutex_lock(&fdt->list_lock);
+	if (fdt->freelist == NULL) {
+		fdt->freelist = fde;
+	} else {
+		fde->next = fdt->freelist;
+		fdt->freelist = fde;
+	}
+	pthread_mutex_unlock(&fdt->list_lock);
+}
+
+static void fdt_freelist_forcefree(fd_table_t *fdt, uint64_t service_key)
+{
+	fd_event_t *prev, *pos, *f_fde;
+	fdt_node_t *node;
+	int idx;
+
+	pthread_mutex_lock(&fdt->list_lock);
+	prev = NULL;
+	pos = fdt->freelist;
+	while (pos) {
+		idx = pos->fd & fdt->node_mask;
+		node = pos->node;
+		if (pos->service_key == service_key) {
+			__atomic_exchange_n(&node->ref_count[idx], FDE_FREEING,
+					    __ATOMIC_RELAXED);
+			if (!prev) {
+				fdt->freelist = pos->next;
+			} else {
+				prev->next = pos->next;
+			}
+			f_fde = pos;
+			pos = pos->next;
+			node->events[idx] = NULL;
+			__atomic_store_n(&node->ref_count[idx], -1,
+					 __ATOMIC_RELEASE);
+			fd_event_free(f_fde);
+		} else {
+			prev = pos;
+			pos = pos->next;
+		}
+	}
+	pthread_mutex_unlock(&fdt->list_lock);
+	return;
+}
+
+static void fdt_freelist_lazyfree(fd_table_t *fdt)
+{
+	fd_event_t *prev, *pos, *f_fde;
+	fdt_node_t *node;
+	int idx;
+	int expected;
+
+	pthread_mutex_lock(&fdt->list_lock);
+	prev = NULL;
+	pos = fdt->freelist;
+
+	while (pos) {
+		idx = pos->fd & fdt->node_mask;
+		// do lazyfree when ref_count less than 0
+		expected = FDE_AVAILABLE;
+		node = pos->node;
+		if (__atomic_compare_exchange_n(
+			    &node->ref_count[idx], &expected, FDE_FREEING, 1,
+			    __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)) {
+			if (!prev) {
+				fdt->freelist = pos->next;
+			} else {
+				prev->next = pos->next;
+			}
+			f_fde = pos;
+			pos = pos->next;
+			node->events[idx] = NULL;
+			__atomic_store_n(&node->ref_count[idx], -1,
+					 __ATOMIC_RELEASE);
+			fd_event_free(f_fde);
+		} else {
+			if (expected < 0) {
+				errprint("error ref: %d, fd: %d\n", expected,
+					 pos->fd);
+			}
+			prev = pos;
+			pos = pos->next;
+		}
+	}
+	pthread_mutex_unlock(&fdt->list_lock);
+	return;
+}
+
+static uint16_t fde_timestamp_get(fd_table_t *fdt, int fd)
+{
+	fdt_node_t *node;
+	int idx;
+
+	node = fdt_node_search(fdt, fd);
+	if (!node) {
+		return 0;
+	}
+	idx = fd & fdt->node_mask;
+	return node->timestamps[idx];
+}
+
+static void fd_event_put(fd_table_t *fdt, fd_event_t *fde);
+
+static fd_event_t *fd_event_get(fd_table_t *fdt, int fd)
+{
+	fd_event_t *fde = NULL;
+	fdt_node_t *node;
+	int idx;
+	int val = -1;
+	int expected;
+
+	node = fdt_node_search(fdt, fd);
+	if (!node) {
+		return NULL;
+	}
+	idx = fd & fdt->node_mask;
+
+retry:
+	val = __atomic_load_n(&node->ref_count[idx], __ATOMIC_ACQUIRE);
+	if (val < 0)
+		return NULL;
+	expected = val;
+	val++;
+	if (!__atomic_compare_exchange_n(&node->ref_count[idx], &expected, val,
+					 1, __ATOMIC_SEQ_CST,
+					 __ATOMIC_SEQ_CST)) {
+		if (expected >= 0) {
+			goto retry;
+		} else {
+			return NULL;
+		}
+	}
+	fde = node->events[idx];
+	if (!fde) {
+		errprint("error get: %d, fd: %d\n", val, fd);
+	} else {
+		if (__atomic_load_n(&fde->outdated, __ATOMIC_ACQUIRE)) {
+			fd_event_put(fdt, fde);
+			fde = NULL;
+		}
+	}
+	return fde;
+}
+
+static void fd_event_put(fd_table_t *fdt, fd_event_t *fde)
+{
+	int idx;
+	int val;
+
+	if (!fde)
+		return;
+
+	idx = fde->fd & fdt->node_mask;
+	val = __atomic_sub_fetch(&fde->node->ref_count[idx], 1,
+				 __ATOMIC_RELEASE);
+	if (val < 0) {
+		errprint("error put: %d, fd: %d\n", val, fde->fd);
+	}
+	return;
+}
+
+int rpal_access(void *addr, access_fn do_access, int *ret, va_list va);
+
+int rpal_access(void *addr, access_fn do_access, int *ret, va_list va)
+{
+	int func_ret;
+
+	func_ret = do_access(va);
+	if (ret) {
+		*ret = func_ret;
+	}
+	return RPAL_SUCCESS;
+}
+
+extern status_t rpal_access_warpper(void *addr, access_fn do_access, int *ret,
+				    va_list va);
+
+#define rpal_write_access_safety(ACCESS_FUNC, FUNC_RET, ...)                   \
+	({                                                                     \
+		status_t __access = RPAL_FAILURE;                              \
+		uint32_t old_pkru = 0;                                         \
+		old_pkru = rdpkru();                                           \
+		__access = rpal_read_access_safety(ACCESS_FUNC, FUNC_RET,      \
+						   ##__VA_ARGS__);             \
+		wrpkru(old_pkru);                                              \
+		__access;                                                      \
+	})
+
+status_t rpal_read_access_safety(access_fn do_access, int *ret, ...)
+{
+	rpal_sender_info_t *sender;
+	sender_context_t *sc;
+	rpal_error_code_t error;
+	status_t access = RPAL_FAILURE;
+	va_list args;
+
+	sender = current_rpal_sender();
+	if (!sender || !rpal_sender_inited(sender)) {
+		dbprint(RPAL_DEBUG_SENDER, "%s: sender(%d) do not init\n",
+			__FUNCTION__, getpid());
+		if (RPAL_FAILURE == rpal_sender_init(&error)) {
+			return RPAL_FAILURE;
+		}
+		sender = current_rpal_sender();
+	}
+	sc = &sender->sc;
+	sc->ec.magic = RPAL_ERROR_MAGIC;
+	va_start(args, ret);
+	access = rpal_access_warpper(&(sc->ec.ersp), do_access, ret, args);
+	va_end(args);
+	sc->ec.magic = 0;
+
+	return access;
+}
+
+static int64_t __do_rpal_uds_fdmap(int service_id, int connfd)
+{
+	struct rpal_uds_fdmap_arg arg;
+	int64_t res;
+	int ret;
+
+	arg.cfd = connfd;
+	arg.service_id = service_id;
+	arg.res = &res;
+	ret = rpal_ioctl(RPAL_IOCTL_UDS_FDMAP, (unsigned long)&arg);
+	if (ret < 0)
+		return RPAL_FAILURE;
+
+	return res;
+}
+
+static status_t do_rpal_uds_fdmap(va_list va)
+{
+	int64_t ret;
+	int sfd, cfd, sid;
+	struct rpal_thread_pool *srtp;
+	uint64_t stamp = 0;
+	uint64_t sid_fd;
+	uint64_t *rpalfd;
+	fd_event_t *fde;
+
+	sid_fd = va_arg(va, uint64_t);
+	rpalfd = va_arg(va, uint64_t *);
+
+	if (!rpalfd) {
+		return RPAL_FAILURE;
+	}
+	sid = get_high32(sid_fd);
+	cfd = get_low32(sid_fd);
+
+	ret = __do_rpal_uds_fdmap(sid, cfd);
+	if (ret < 0) {
+		errprint("%s failed %ld, cfd: %d\n", __FUNCTION__, ret, cfd);
+		return RPAL_FAILURE;
+	}
+
+	srtp = get_service_from_id(sid);
+	if (!srtp) {
+		errprint("%s INVALID service_id: %d\n", __FUNCTION__, sid);
+		return RPAL_FAILURE;
+	}
+	sfd = get_sfd(ret);
+	stamp = fde_timestamp_get(srtp->fdt, sfd);
+	ret |= (stamp << HIGH16_OFFSET);
+
+	fde = fd_event_get(threads_md.rtp->fdt, cfd);
+	if (!fde) {
+		errprint("%s get self fde error, fd: %d\n", __FUNCTION__, cfd);
+		goto out;
+	}
+	fde->service_key = srtp->service_key;
+	fd_event_put(threads_md.rtp->fdt, fde);
+out:
+	*rpalfd = ret;
+	return RPAL_SUCCESS;
+}
+
+int rpal_get_peer_rid(uint64_t sid_fd)
+{
+	int64_t ret;
+	int sid, cfd;
+	int rid;
+
+	sid = get_high32(sid_fd);
+	cfd = get_low32(sid_fd);
+
+	ret = __do_rpal_uds_fdmap(sid, cfd);
+	if (ret < 0) {
+		errprint("%s failed %ld, cfd: %d\n", __FUNCTION__, ret, cfd);
+		return RPAL_FAILURE;
+	}
+	rid = get_rid(ret);
+	return rid;
+}
+
+status_t rpal_uds_fdmap(uint64_t sid_fd, uint64_t *rpalfd)
+{
+	status_t ret = RPAL_FAILURE;
+	status_t access;
+	uint32_t old_pkru;
+
+	old_pkru = rdpkru();
+	wrpkru(old_pkru & RPAL_PKRU_BASE_CODE_READ);
+	access = rpal_read_access_safety(do_rpal_uds_fdmap, &ret, sid_fd,
+					 rpalfd);
+	wrpkru(old_pkru);
+	if (access == RPAL_FAILURE) {
+		return RPAL_FAILURE;
+	}
+	return ret;
+}
+
+static status_t fd_event_install(fd_table_t *fdt, int fd, int epfd,
+				 struct epoll_event *event)
+{
+	fdt_node_t *node;
+	fd_event_t *fde;
+	int idx;
+	int expected;
+
+	fde = fd_event_alloc(fd, epfd, event);
+	if (!fde) {
+		goto fde_error;
+	}
+	pthread_mutex_lock(&fdt->lock);
+	if (fd >= fdt->max_fd) {
+		node = fdt_node_expand(fdt, fd);
+	} else {
+		node = fdt_node_search(fdt, fd);
+	}
+	pthread_mutex_unlock(&fdt->lock);
+
+	if (!node) {
+		errprint("fd node search failed, fd: %d\n", fd);
+		goto node_error;
+	}
+	idx = fd & fdt->node_mask;
+	fdt_freelist_lazyfree(fdt);
+	expected = __atomic_load_n(&node->ref_count[idx], __ATOMIC_ACQUIRE);
+	if (expected != FDE_FREED) {
+		goto node_error;
+	}
+	fde->timestamp =
+		__atomic_add_fetch(&node->timestamps[idx], 1, __ATOMIC_RELEASE);
+	fde->node = node;
+	node->events[idx] = fde;
+	if (!__atomic_compare_exchange_n(&node->ref_count[idx], &expected,
+					 FDE_AVAILABLE, 1, __ATOMIC_SEQ_CST,
+					 __ATOMIC_SEQ_CST)) {
+		errprint("may override fd: %d, val: %d\n", fd, expected);
+		node->events[idx] = NULL;
+		goto node_error;
+	}
+	return RPAL_SUCCESS;
+
+node_error:
+	fd_event_free(fde);
+fde_error:
+	return RPAL_FAILURE;
+}
+
+static status_t fd_event_uninstall(fd_table_t *fdt, int fd)
+{
+	fd_event_t *fde;
+	fdt_node_t *node;
+	int idx;
+	int ret = RPAL_SUCCESS;
+	int expected;
+
+	node = fdt_node_search(fdt, fd);
+	if (!node) {
+		ret = RPAL_FAILURE;
+		goto out;
+	}
+	idx = fd & fdt->node_mask;
+	fde = node->events[idx];
+	if (!fde) {
+		ret = RPAL_FAILURE;
+		goto out;
+	}
+	expected = FDE_AVAILABLE;
+	__atomic_store_n(&fde->outdated, (uint16_t)1, __ATOMIC_RELEASE);
+	if (__atomic_compare_exchange_n(&node->ref_count[idx], &expected,
+					FDE_FREEING, 1, __ATOMIC_SEQ_CST,
+					__ATOMIC_SEQ_CST)) {
+		node->events[idx] = NULL;
+		__atomic_store_n(&node->ref_count[idx], -1, __ATOMIC_RELEASE);
+		fd_event_free(fde);
+	} else {
+		if (expected < FDE_AVAILABLE) {
+			errprint("error cnt: %d, fd: %d\n", expected, fde->fd);
+		}
+		// link this fde for free_head
+		fdt_freelist_insert(fdt, fde);
+	}
+
+out:
+	fdt_freelist_lazyfree(fdt);
+	return ret;
+}
+
+static status_t fd_event_modify(fd_table_t *fdt, int fd,
+				struct epoll_event *event)
+{
+	fd_event_t *fde;
+
+	fde = fd_event_get(fdt, fd);
+	if (!fde) {
+		errprint("fde MOD fd(%d) ERROR!\n", fd);
+		return RPAL_FAILURE;
+	}
+	fde->fd = fd;
+	fde->epev = *event;
+	fde->events = 0;
+	fd_event_put(fdt, fde);
+	return RPAL_SUCCESS;
+}
+
+static int rpal_receiver_info_create(struct rpal_thread_pool *rtp, int id)
+{
+	rpal_receiver_info_t *rri = &rtp->rris[id];
+
+	rri->ep_stack = fiber_ctx_alloc(NULL, NULL, DEFUALT_STACK_SIZE);
+	if (!rri->ep_stack)
+		return -1;
+
+	rri->trampoline = fiber_ctx_alloc(NULL, NULL, TRAMPOLINE_SIZE);
+	if (!rri->trampoline) {
+		fiber_ctx_free(rri->ep_stack);
+		return -1;
+	}
+
+	rri->rc = threads_md.rc + id;
+	rri->rc->receiver_id = id;
+	rri->rtp = rtp;
+
+	return 0;
+}
+
+static void rpal_receiver_info_destroy(rpal_receiver_info_t *rri)
+{
+	fiber_ctx_free(rri->ep_stack);
+	fiber_ctx_free(rri->trampoline);
+	return;
+}
+
+static struct rpal_thread_pool *rpal_thread_pool_create(int nr_threads,
+						   rpal_thread_metadata_t *rtm)
+{
+	void *p;
+	int i, j;
+	struct rpal_thread_pool *rtp;
+
+	if (rpal_inited())
+		goto out;
+	rtp = malloc(sizeof(struct rpal_thread_pool));
+	if (rtp == NULL) {
+		goto out;
+	}
+	threads_md.eventfds = malloc(nr_threads * sizeof(int));
+	if (threads_md.eventfds == NULL) {
+		goto eventfds_alloc_fail;
+	}
+	rtp->nr_threads = nr_threads;
+	rtp->pkey = -1;
+	p = malloc(nr_threads * sizeof(rpal_receiver_info_t));
+	if (p == NULL) {
+		goto rri_alloc_fail;
+	}
+	rtp->rris = p;
+	memset(p, 0, nr_threads * sizeof(rpal_receiver_info_t));
+
+	rtp->fdt = fd_table_alloc(DEFAULT_NODE_SHIFT);
+	if (!rtp->fdt) {
+		goto fdt_alloc_fail;
+	}
+
+	p = rpal_get_shared_page(rtm->epcpage_order);
+
+	if (!p)
+		goto page_alloc_fail;
+	rtm->rc = p;
+
+	for (i = 0; i < nr_threads; i++) {
+		if (rpal_receiver_info_create(rtp, i)) {
+			for (j = 0; j < i; j++) {
+				rpal_receiver_info_destroy(&rtp->rris[j]);
+			}
+			goto rri_create_fail;
+		}
+	}
+	return rtp;
+
+rri_create_fail:
+	rpal_free_shared_page(rtm->rc, rtm->epcpage_order);
+page_alloc_fail:
+	fd_table_free(rtp->fdt);
+fdt_alloc_fail:
+	free(rtp->rris);
+rri_alloc_fail:
+	free(threads_md.eventfds);
+eventfds_alloc_fail:
+	free(rtp);
+out:
+	return NULL;
+}
+
+static void rpal_thread_pool_destory(rpal_thread_metadata_t *rtm)
+{
+	int i;
+	struct rpal_thread_pool *rtp;
+
+	if (!rpal_inited()) {
+		errprint("thread pool is not created.\n");
+		return;
+	}
+	pthread_mutex_destroy(&release_lock);
+	rtp = threads_md.rtp;
+	fd_table_free(rtp->fdt);
+	for (i = 0; i < rtp->nr_threads; ++i) {
+		rpal_receiver_info_destroy(&rtp->rris[i]);
+	}
+	rpal_free_shared_page(threads_md.rc, threads_md.epcpage_order);
+	free(rtp->rris);
+	free(threads_md.eventfds);
+	free(rtp);
+}
+
+static inline int rpal_receiver_inited(rpal_receiver_info_t *rri)
+{
+	if (!rri)
+		return 0;
+	return (rri->status != RPAL_RECEIVER_UNINITIALIZED);
+}
+
+static inline int rpal_receiver_available(rpal_receiver_info_t *rri)
+{
+	return (rri->status == RPAL_RECEIVER_AVAILABLE);
+}
+
+static int rpal_receiver_idx_get(void)
+{
+	return __atomic_fetch_add(&threads_md.rpal_receiver_idx, 1,
+				  __ATOMIC_RELAXED);
+}
+
+int rpal_receiver_init(void)
+{
+	int ret = 0;
+	int receiver_idx;
+	rpal_receiver_info_t *rri;
+
+	if (!rpal_inited()) {
+		errprint("thread pool is not created.\n");
+		goto error_out;
+	}
+
+	receiver_idx = rpal_receiver_idx_get();
+	if (receiver_idx >= threads_md.rtp->nr_threads) {
+		errprint(
+			"rpal thread pool size exceeded. thread_idx: %d, thread pool capacity: %d\n",
+			receiver_idx, threads_md.rtp->nr_threads);
+		goto error_out;
+	}
+
+	rri = threads_md.rtp->rris + receiver_idx;
+	rri->status = RPAL_RECEIVER_UNINITIALIZED;
+	rri->tid = syscall(SYS_gettid);
+	rri->tls_base = read_tls_base();
+
+	rpal_uevent_queue_init(&rri->ueventq, &rri->uqlock);
+
+	rri->rc->rpal_ep_poll_magic = 0;
+	rri->rc->receiver_state = RPAL_RECEIVER_STATE_RUNNING;
+	rri->rc->ep_pending = 0;
+	__atomic_store_n(&rri->rc->sender_state, RPAL_SENDER_STATE_RUNNING,
+			 __ATOMIC_RELAXED);
+	ret = rpal_register_receiver(rri);
+	if (ret < 0) {
+		errprint("rpal thread %ld register failed %d\n", rri->tid, ret);
+		goto error_out;
+	}
+	ret = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK);
+	if (ret < 0) {
+		errprint("rpal thread %ld eventfd failed %d\n", rri->tid,
+			 errno);
+		goto eventfd_failed;
+	}
+	threads_md.eventfds[receiver_idx] = ret;
+	rri->status = RPAL_RECEIVER_INITIALIZED;
+	return ret;
+
+eventfd_failed:
+	rpal_unregister_receiver();
+error_out:
+	return RPAL_FAILURE;
+}
+
+void rpal_receiver_exit(void)
+{
+	rpal_receiver_info_t *rri = current_rpal_thread();
+	int id, fd;
+
+	if (!rpal_receiver_inited(rri))
+		return;
+	rri->status = RPAL_RECEIVER_UNINITIALIZED;
+	id = rri->rc->receiver_id;
+	fd = threads_md.eventfds[id];
+	close(fd);
+	threads_md.eventfds[id] = 0;
+	rpal_unregister_receiver();
+	return;
+}
+
+static inline void set_task_context(volatile task_context_t *tc, void *src)
+{
+	fiber_stack_t *fstack = src;
+	tc->r15 = fstack->r15;
+	tc->r14 = fstack->r14;
+	tc->r13 = fstack->r13;
+	tc->r12 = fstack->r12;
+	tc->rbx = fstack->rbx;
+	tc->rbp = fstack->rbp;
+	tc->rip = fstack->rip;
+	tc->rsp = (unsigned long)(src + 0x40);
+}
+
+static transfer_t _syscall_epoll_wait(transfer_t t)
+{
+	rpal_receiver_info_t *rri = t.ud;
+	volatile receiver_context_t *rc = rri->rc;
+	long ret;
+
+	rc->rpal_ep_poll_magic = RPAL_EP_POLL_MAGIC;
+	ret = epoll_wait(rc->epfd, rc->ep_events, rc->maxevents,
+			 rc->timeout);
+	t = jump_fcontext(rri->main_ctx, (void *)ret);
+	return t;
+}
+
+extern void rpal_ret_critical(volatile receiver_context_t *rc,
+			      rpal_call_info_t *rci);
+
+static transfer_t syscall_epoll_wait(transfer_t t)
+{
+	rpal_receiver_info_t *rri = t.ud;
+	volatile receiver_context_t *rc = rri->rc;
+	rpal_call_info_t *rci = &rri->rci;
+	task_t *estk = rri->ep_stack;
+
+	set_task_context(&rri->rc->task_context, t.fctx);
+	rri->main_ctx = t.fctx;
+
+	rpal_ret_critical(rc, rci);
+
+	estk->fctx = make_fcontext(estk->sp, 0, NULL);
+	t = ontop_fcontext(rri->ep_stack->fctx, rri, _syscall_epoll_wait);
+	return t;
+}
+
+static inline int ep_kernel_events_available(volatile int *ep_pending)
+{
+	return (RPAL_KERNEL_PENDING &
+		__atomic_load_n(ep_pending, __ATOMIC_ACQUIRE));
+}
+
+static inline int ep_user_events_available(volatile int *ep_pending)
+{
+	return (RPAL_USER_PENDING &
+		__atomic_load_n(ep_pending, __ATOMIC_ACQUIRE));
+}
+
+static inline int rpal_ep_send_events(epoll_uevent_queue_t *uq, fd_table_t *fdt,
+				      volatile receiver_context_t *rc,
+				      struct epoll_event *events, int maxevents)
+{
+	int fd = -1;
+	int ret = 0;
+	int res = 0;
+	fd_event_t *fde = NULL;
+
+	__atomic_and_fetch(&rc->ep_pending, ~RPAL_USER_PENDING,
+			   __ATOMIC_ACQUIRE);
+	while (uevent_queue_len(uq) && ret < maxevents) {
+		fd = uevent_queue_del(uq);
+		if (fd == -1) {
+			errprint("uevent get failed\n");
+			continue;
+		}
+		fde = fd_event_get(fdt, fd);
+		if (!fde)
+			continue;
+		res = __atomic_exchange_n(&fde->events, 0, __ATOMIC_RELAXED);
+		res &= fde->epev.events;
+		if (res) {
+			events[ret].data = fde->epev.data;
+			events[ret].events = res;
+			ret++;
+		}
+		fd_event_put(fdt, fde);
+	}
+	if (uevent_queue_len(uq) || ret == maxevents) {
+		dbprint(RPAL_DEBUG_RECVER,
+			"uevent queue still have events, len: %d, ret: %d, maxevents: %d\n",
+			uevent_queue_len(uq), ret, maxevents);
+		__atomic_fetch_or(&rc->ep_pending, RPAL_USER_PENDING,
+				  __ATOMIC_RELAXED);
+	}
+	return ret;
+}
+
+extern void rpal_call_critical(volatile receiver_context_t *rc,
+			       rpal_receiver_info_t *rri);
+
+int rpal_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
+		    int timeout)
+{
+	transfer_t t;
+	rpal_call_info_t *rci;
+	task_t *estk, *trampoline;
+	volatile receiver_context_t *rc;
+	epoll_uevent_queue_t *ueventq;
+	rpal_receiver_info_t *rri = current_rpal_thread();
+	long ret = 0;
+	unsigned int mxcsr = 0, fpucw = 0;
+
+	if (!rpal_receiver_inited(rri))
+		return epoll_wait(epfd, events, maxevents, timeout);
+
+	rc = rri->rc;
+	estk = rri->ep_stack;
+	trampoline = rri->trampoline;
+	rci = &rri->rci;
+	ueventq = &rri->ueventq;
+
+	rc->epfd = epfd;
+	rc->ep_events = events;
+	rc->maxevents = maxevents;
+	rc->timeout = timeout;
+
+	if (!rpal_receiver_available(rri)) {
+		rri->status = RPAL_RECEIVER_AVAILABLE;
+		estk->fctx = make_fcontext(estk->sp, 0, NULL);
+		SAVE_FPU(mxcsr, fpucw);
+		trampoline->fctx = make_fcontext(trampoline->sp, 0, NULL);
+		t = ontop_fcontext(trampoline->fctx, rri, syscall_epoll_wait);
+	} else {
+		// kernel pending events
+		if (ep_kernel_events_available(&rc->ep_pending)) {
+			rc->rpal_ep_poll_magic =
+				RPAL_EP_POLL_MAGIC; // clear KERNEL_PENDING
+			ret = epoll_wait(epfd, events, maxevents, 0);
+			rc->rpal_ep_poll_magic = 0;
+			goto send_user_events;
+		}
+		// user pending events
+		if (ep_user_events_available(&rc->ep_pending)) {
+			goto send_user_events;
+		}
+		SAVE_FPU(mxcsr, fpucw);
+		trampoline->fctx = make_fcontext(trampoline->sp, 0, NULL);
+		t = ontop_fcontext(trampoline->fctx, rri, syscall_epoll_wait);
+	}
+	rc->rpal_ep_poll_magic = 0;
+
+	/*
+     * Here is where sender starts after user context switch.
+     * The TLS may still be sender's. We should not do anything
+     * that may use TLS, otherwise the result cannot be controlled.
+     */
+
+	switch (rc->receiver_state & RPAL_RECEIVER_STATE_MASK) {
+	case RPAL_RECEIVER_STATE_RUNNING: // syscall kernel ret
+		ret = (long)t.ud;
+		break;
+	case RPAL_RECEIVER_STATE_KERNEL_RET: // receiver kernel ret
+		RESTORE_FPU(mxcsr, fpucw);
+		ret = (long)t.fctx;
+		break;
+	case RPAL_RECEIVER_STATE_CALL: // rpalcall user jmp
+		rci->sender_tls_base = read_tls_base();
+		rci->pkru = rdpkru();
+		write_tls_base(rri->tls_base);
+		wrpkru(rpal_pkey_to_pkru(rri->rtp->pkey));
+		rci->sender_fctx = t.fctx;
+		break;
+	default:
+		errprint("Error ep_status: %ld\n",
+			 rc->receiver_state & RPAL_RECEIVER_STATE_MASK);
+		return -1;
+	}
+
+send_user_events:
+	if (ret < maxevents && ret >= 0)
+		ret += rpal_ep_send_events(ueventq, rri->rtp->fdt, rc,
+					   events + ret, maxevents - ret);
+	return ret;
+}
+
+int rpal_epoll_wait_user(int epfd, struct epoll_event *events, int maxevents,
+			 int timeout)
+{
+	volatile receiver_context_t *rc;
+	epoll_uevent_queue_t *ueventq;
+	rpal_receiver_info_t *rri = current_rpal_thread();
+
+	if (!rpal_receiver_inited(rri))
+		return 0;
+
+	if (!rpal_receiver_available(rri))
+		return 0;
+
+	rc = rri->rc;
+	ueventq = &rri->ueventq;
+	if (ep_user_events_available(&rc->ep_pending)) {
+		return rpal_ep_send_events(ueventq, rri->rtp->fdt, rc, events,
+					   maxevents);
+	}
+	return 0;
+}
+
+int rpal_epoll_ctl(int epfd, int op, int fd, struct epoll_event *event)
+{
+	fd_table_t *fdt;
+	int ret;
+
+	ret = epoll_ctl(epfd, op, fd, event);
+	if (ret || !rpal_inited()) {
+		return ret;
+	}
+	fdt = threads_md.rtp->fdt;
+	switch (op) {
+	case EPOLL_CTL_ADD:
+		if (event->events & EPOLLRPALINOUT_BITS) {
+			ret = fd_event_install(fdt, fd, epfd, event);
+			if (ret == RPAL_FAILURE)
+				goto install_error;
+		}
+		break;
+	case EPOLL_CTL_MOD:
+		fd_event_modify(fdt, fd, event);
+		break;
+	case EPOLL_CTL_DEL:
+		fd_event_uninstall(fdt, fd);
+		break;
+	}
+	return ret;
+install_error:
+	epoll_ctl(epfd, EPOLL_CTL_DEL, fd, event);
+	return RPAL_FAILURE;
+}
+
+static transfer_t set_fcontext(transfer_t t)
+{
+	sender_context_t *sc = t.ud;
+
+	set_task_context(&sc->task_context, t.fctx);
+	return t;
+}
+
+static void uq_lock(volatile uint64_t *uqlock, uint64_t key)
+{
+	uint64_t init = 0;
+
+	while (1) {
+		if (__atomic_compare_exchange_n(
+			    uqlock, &init, (1UL << 63 | key), 1,
+			    __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST))
+			return;
+		asm volatile("rep; nop");
+		init = 0;
+	}
+}
+
+static void uq_unlock(volatile uint64_t *uqlock)
+{
+	__atomic_store_n(uqlock, (uint64_t)0, __ATOMIC_RELAXED);
+}
+
+static status_t do_rpal_call_jump(rpal_sender_info_t *rsi,
+				  rpal_receiver_info_t *rri,
+				  volatile receiver_context_t *rc)
+{
+	int desired, expected;
+	int64_t diff;
+
+WAKE_AGAIN:
+	desired = RPAL_BUILD_CALL_STATE(rsi->sc.sender_id,
+				    threads_md.service_id);
+	expected = RPAL_RECEIVER_STATE_WAIT;
+	if (__atomic_compare_exchange_n(&rc->receiver_state, &expected, desired, 1,
+					__ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)) {
+		__atomic_store_n(&rc->sender_state, RPAL_SENDER_STATE_CALL,
+				 __ATOMIC_RELAXED);
+		rsi->sc.start_time = _rdtsc();
+		ontop_fcontext(rri->main_ctx, &rsi->sc, set_fcontext);
+
+		if (__atomic_load_n(&rc->sender_state, __ATOMIC_RELAXED) ==
+			RPAL_SENDER_STATE_RUNNING) {
+			if (rc->receiver_state == RPAL_RECEIVER_STATE_LAZY_SWITCH)
+				read(-1, NULL, 0);
+			diff = _rdtsc() - rsi->sc.start_time;
+			rsi->sc.total_time += diff;
+			rri->rc->total_time += diff;
+			expected = desired;
+			desired = RPAL_RECEIVER_STATE_WAIT;
+			__atomic_compare_exchange_n(&rc->receiver_state, &expected,
+						    desired, 1,
+						    __ATOMIC_SEQ_CST,
+						    __ATOMIC_SEQ_CST);
+
+			if (ep_user_events_available(&rc->ep_pending)) {
+				goto WAKE_AGAIN;
+			}
+		}
+		dbprint(RPAL_DEBUG_SENDER, "app return: 0x%x, %d, %d\n",
+			rc->receiver_state, rc->sender_state, sfd);
+	}
+	return RPAL_SUCCESS;
+}
+
+static inline void set_fde_trigger(fd_event_t *fde)
+{
+	__atomic_store_n(&fde->wait, FDE_TRIGGER_OUT, __ATOMIC_RELEASE);
+	return;
+}
+
+static inline int clear_fde_trigger(fd_event_t *fde)
+{
+	int expected = FDE_TRIGGER_OUT;
+
+	return __atomic_compare_exchange_n(&fde->wait, &expected,
+					   FDE_NO_TRIGGER, 1, __ATOMIC_SEQ_CST,
+					   __ATOMIC_SEQ_CST);
+}
+
+static int do_rpal_call(va_list va)
+{
+	rpal_sender_info_t *rsi;
+	rpal_receiver_info_t *rri;
+	fd_event_t *fde;
+	volatile receiver_context_t *rc;
+	struct rpal_thread_pool *srtp;
+	uint16_t stamp;
+	uint8_t rid;
+	int sfd;
+	int ret = 0;
+	int fall = 0;
+	int pkey;
+
+	int service_id = va_arg(va, int);
+	uint64_t rpalfd = va_arg(va, uint64_t);
+	int64_t *ptrs = va_arg(va, int64_t *);
+	int len = va_arg(va, int);
+	int flags = va_arg(va, int);
+
+	rsi = current_rpal_sender();
+	if (!rsi) {
+		ret = RPAL_INVAL_THREAD;
+		goto ERROR;
+	}
+	srtp = get_service_from_id(service_id);
+	if (!srtp) {
+		ret = RPAL_INVAL_SERVICE;
+		goto ERROR;
+	}
+	pkey = get_service_pkey_from_id(service_id);
+
+	rid = get_rid(rpalfd);
+	sfd = get_sfd(rpalfd);
+	wrpkru(rpal_pkru_union(rdpkru(), rpal_pkey_to_pkru(pkey)));
+	rri = srtp->rris + rid;
+	if (!rri) {
+		errprint("INVALID rid: %u, rri is NULL\n", rid);
+		ret = RPAL_INVALID_ARG;
+		goto ERROR;
+	}
+	rc = rri->rc;
+	rsi->sc.ec.tls_base = rri->tls_base;
+
+	fde = fd_event_get(srtp->fdt, sfd);
+	if (!fde) {
+		ret = RPAL_INVALID_ARG;
+		goto ERROR;
+	}
+	stamp = get_fdtimestamp(rpalfd);
+	if (fde->timestamp != stamp) {
+		ret = RPAL_FDE_OUTDATED;
+		goto FDE_PUT;
+	}
+
+	uq_lock(&rri->uqlock, threads_md.service_key);
+	if (uevent_queue_len(&rri->ueventq) == MAX_RDY) {
+		errprint("rdylist is full: [%u, %u]\n", rri->ueventq.l_beg,
+			 rri->ueventq.l_end);
+		ret = RPAL_CACHE_FULL;
+		goto UNLOCK;
+	}
+	if (likely(flags & RCALL_IN)) {
+		if (unlikely(rpal_queue_unused(&fde->q) < (uint32_t)len)) {
+			set_fde_trigger(fde);
+			fall = 1;
+			/* fall through: try to put data to queue */
+		}
+		ret = rpal_queue_put(&fde->q, ptrs, len);
+		if (ret != len) {
+			errprint("fde queue put error: %d, data: %lx\n", ret,
+				 (unsigned long)fde->q.data);
+			ret = RPAL_QUEUE_PUT_FAILED;
+			goto UNLOCK;
+		}
+		if (unlikely(fall)) {
+			clear_fde_trigger(fde);
+		}
+		fde->events |= EPOLLRPALIN;
+	} else if (unlikely(flags & RCALL_OUT)) {
+		ret = 0;
+		fde->events |= EPOLLRPALOUT;
+	} else {
+		errprint("rpal call failed, ptrs: %lx, len: %d",
+			 (unsigned long)ptrs, len);
+		ret = RPAL_INVALID_ARG;
+		goto UNLOCK;
+	}
+
+	uevent_queue_add(&rri->ueventq, sfd);
+	uq_unlock(&rri->uqlock);
+	fd_event_put(srtp->fdt, fde);
+
+	__atomic_fetch_or(&rc->ep_pending, RPAL_USER_PENDING,
+			  __ATOMIC_RELEASE);
+	do_rpal_call_jump(rsi, rri, rc);
+	return ret;
+
+UNLOCK:
+	uq_unlock(&rri->uqlock);
+FDE_PUT:
+	fd_event_put(srtp->fdt, fde);
+ERROR:
+	return -ret;
+}
+
+static int __rpal_write_ptrs_common(int service_id, uint64_t rpalfd,
+				    int64_t *ptrs, int len, int flags)
+{
+	int ret = RPAL_FAILURE;
+	status_t access = RPAL_FAILURE;
+
+	if (unlikely(NULL == ptrs)) {
+		dbprint(RPAL_DEBUG_SENDER, "%s: ptrs is NULL\n", __FUNCTION__);
+		return -RPAL_INVALID_ARG;
+	}
+	if (unlikely(len <= 0 || ((uint32_t)len) > DEFAULT_QUEUE_SIZE)) {
+		dbprint(RPAL_DEBUG_SENDER,
+			"%s: data len less than or equal to zero\n",
+			__FUNCTION__);
+		return -RPAL_INVALID_ARG;
+	}
+
+	access = rpal_write_access_safety(do_rpal_call, &ret, service_id,
+					  rpalfd, ptrs, len, flags);
+	if (access == RPAL_FAILURE) {
+		return -RPAL_ERR_PEER_MEM;
+	}
+	return ret;
+}
+
+int rpal_write_ptrs(int service_id, uint64_t rpalfd, int64_t *ptrs, int len)
+{
+	return __rpal_write_ptrs_common(service_id, rpalfd, ptrs, len,
+					RCALL_IN);
+}
+
+int rpal_read_ptrs(int fd, int64_t *dptrs, int len)
+{
+	fd_event_t *fde;
+	fd_table_t *fdt = threads_md.rtp->fdt;
+	int ret;
+
+	if (!rpal_inited())
+		return -1;
+
+	fde = fd_event_get(fdt, fd);
+	if (!fde)
+		return -1;
+
+	ret = rpal_queue_get(&fde->q, dptrs, len);
+	fd_event_put(fdt, fde);
+	return ret;
+}
+
+int rpal_read_ptrs_trigger_out(int fd, int64_t *dptrs, int len, int service_id,
+			       uint64_t rpalfd)
+{
+	fd_event_t *fde;
+	fd_table_t *fdt = threads_md.rtp->fdt;
+	int access, ret = -1;
+	int nread;
+
+	if (!rpal_inited())
+		return -1;
+
+	fde = fd_event_get(fdt, fd);
+	if (!fde)
+		return -1;
+
+	nread = rpal_queue_get(&fde->q, dptrs, len);
+	if (nread > 0 && clear_fde_trigger(fde)) {
+		access =
+			rpal_write_access_safety(do_rpal_call, &ret, service_id,
+						 rpalfd, NULL, 0, RCALL_OUT);
+		if (access == RPAL_FAILURE || ret < 0) {
+			set_fde_trigger(fde);
+			errprint(
+				"trigger out failed! access: %d, ret: %d, id: %d, rpalfd: %lx\n",
+				access, ret, service_id, rpalfd);
+		}
+	}
+	fd_event_put(fdt, fde);
+
+	return nread;
+}
+
+static inline int pkey_is_invalid(const int pkey)
+{
+	return (pkey < 0 || pkey > 15);
+}
+
+static status_t rpal_thread_metadata_init(int nr_rpalthread,
+					  rpal_error_code_t *error)
+{
+	uint64_t key;
+	struct rpal_thread_pool *rtp;
+	key = __rpal_get_service_key();
+	if (key >= 1UL << 63) {
+		ERRREPORT(
+			error, RPAL_ERR_SERVICE_KEY,
+			"rpal service key error. Service key: 0x%lx, oeverflow, should less than 2^63\n",
+			key);
+		goto error_out;
+	}
+	threads_md.service_key = key;
+	threads_md.service_id = __rpal_get_service_id();
+	pthread_mutex_init(&release_lock, NULL);
+	rpal_get_critical_addr(&rcs);
+	rtp = rpal_thread_pool_create(nr_rpalthread, &threads_md);
+	if (rtp == NULL) {
+		goto error_out;
+	}
+	rtp->service_key = threads_md.service_key;
+	rtp->service_id = threads_md.service_id;
+	threads_md.rtp = rtp;
+	if (rpal_enable_service(error) == RPAL_FAILURE)
+		goto destroy_thread_pool;
+	threads_md.pid = getpid();
+	return RPAL_SUCCESS;
+
+destroy_thread_pool:
+	rpal_thread_pool_destory(&threads_md);
+error_out:
+	return RPAL_FAILURE;
+}
+
+static void rpal_thread_metadata_exit(void)
+{
+	rpal_disable_service();
+	rpal_thread_pool_destory(&threads_md);
+}
+
+static status_t rpal_senders_metadata_init(rpal_error_code_t *error)
+{
+	if (senders_md) {
+		ERRREPORT(error, RPAL_ERR_SENDERS_METADATA,
+			  "senders metadata is already initialized.\n");
+		return RPAL_FAILURE;
+	}
+
+	senders_md = malloc(sizeof(struct rpal_senders_metadata));
+	if (!senders_md) {
+		ERRREPORT(error, RPAL_ERR_NOMEM,
+			  "senders metadata alloc failed.\n");
+		goto sendes_alloc_failed;
+	}
+	senders_md->sdpage_order = SENDERS_PAGE_ORDER;
+	memset(senders_md->bitmap, 0xFF,
+	       sizeof(unsigned long) * BITS_TO_LONGS(MAX_SENDERS));
+	pthread_mutex_init(&senders_md->lock, NULL);
+	senders_md->senders = rpal_get_shared_page(senders_md->sdpage_order);
+	if (!senders_md->senders) {
+		ERRREPORT(error, RPAL_ERR_SENDER_PAGES,
+			  "get senders share page error.\n");
+		goto pages_alloc_failed;
+	}
+	dbprint(RPAL_DEBUG_MANAGEMENT, "senders pages addr: 0x%016lx\n",
+		(unsigned long)senders_md->senders);
+	return RPAL_SUCCESS;
+
+pages_alloc_failed:
+	free(senders_md);
+sendes_alloc_failed:
+	return RPAL_FAILURE;
+}
+
+static void rpal_senders_metadata_exit(void)
+{
+	if (!senders_md)
+		return;
+
+	rpal_free_shared_page((void *)senders_md->senders,
+			      senders_md->sdpage_order);
+	pthread_mutex_destroy(&senders_md->lock);
+	free(senders_md);
+}
+
+static int rpal_get_version_cap(rpal_capability_t *version)
+{
+	return rpal_ioctl(RPAL_IOCTL_GET_API_VERSION_AND_CAP,
+			     (unsigned long)version);
+}
+
+static status_t rpal_version_check(rpal_capability_t *ver)
+{
+	if (ver->compat_version != MIN_RPAL_KERNEL_API_VERSION)
+		return RPAL_FAILURE;
+	if (ver->api_version < TARGET_RPAL_KERNEL_API_VERSION)
+		return RPAL_FAILURE;
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_capability_check(rpal_capability_t *ver)
+{
+	unsigned long cap = ver->cap;
+
+	if (!(cap & (1 << RPAL_CAP_PKU))) {
+		return RPAL_FAILURE;
+	}
+	return RPAL_SUCCESS;
+}
+
+static status_t rpal_check_version_cap(rpal_error_code_t *error)
+{
+	int ret;
+
+	ret = rpal_get_version_cap(&version);
+	if (ret < 0) {
+		ERRREPORT(error, RPAL_ERR_GET_CAP_VERSION,
+			  "rpal get version failed: %d\n", ret);
+		ret = RPAL_FAILURE;
+		goto out;
+	}
+	ret = rpal_version_check(&version);
+	if (ret == RPAL_FAILURE) {
+		ERRREPORT(
+			error, RPAL_KERNEL_API_NOTSUPPORT,
+			"kernel rpal(version: %d-%d) API is not compatible with librpal(version: %d-%d)\n",
+			version.compat_version, version.api_version,
+			MIN_RPAL_KERNEL_API_VERSION,
+			TARGET_RPAL_KERNEL_API_VERSION);
+		goto out;
+	}
+	ret = rpal_capability_check(&version);
+	if (ret == RPAL_FAILURE) {
+		ERRREPORT(error, RPAL_HARDWARE_NOTSUPPORT,
+			  "hardware do not support RPAL\n");
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static status_t rpal_mgtfd_init(rpal_error_code_t *error)
+{
+	int err, n;
+	int mgtfd;
+	char name[1024];
+
+	mgtfd = open(RPAL_MGT_FILE, O_RDWR);
+	if (mgtfd == -1) {
+		err = errno;
+		switch (err) {
+		case EPERM:
+			n = readlink("/proc/self/exe", name, sizeof(name) - 1);
+			if (n < 0) {
+				n = 0;
+			}
+			name[n] = 0;
+			errprint("%s is not a RPAL binary\n", name);
+			break;
+		case ENOENT:
+			errprint("Not in RPAL Environment\n");
+			break;
+		default:
+			errprint("open %s fail, %d, %s\n", RPAL_MGT_FILE, err,
+				 strerror(err));
+		}
+		if (error) {
+			*error = RPAL_ERR_RPALFILE_OPS;
+		}
+		return RPAL_FAILURE;
+	}
+	rpal_mgtfd = mgtfd;
+	return RPAL_SUCCESS;
+}
+
+static void rpal_mgtfd_destroy(void)
+{
+	if (rpal_mgtfd != -1) {
+		close(rpal_mgtfd);
+	}
+	return;
+}
+
+#define RPAL_SECTION_SIZE (512 * 1024 * 1024 * 1024UL)
+
+static inline status_t rpal_check_address(uint64_t start, uint64_t end,
+					  uint64_t check)
+{
+	if (check >= start && check < end) {
+		return RPAL_SUCCESS;
+	}
+	return RPAL_FAILURE;
+}
+
+static status_t rpal_managment_init(rpal_error_code_t *error)
+{
+	int i = 0;
+
+	if (rpal_mgtfd_init(error) == RPAL_FAILURE) {
+		goto mgtfd_init_failed;
+	}
+	if (pthread_key_create(&rpal_key, NULL))
+		goto rpal_key_failed;
+
+	for (i = 0; i < MAX_SERVICEID; i++) {
+		requested_services[i].key = 0;
+		requested_services[i].service = NULL;
+		requested_services[i].pkey = -1;
+	}
+	if (rpal_check_version_cap(error) == RPAL_FAILURE) {
+		goto rpal_check_failed;
+	}
+	return RPAL_SUCCESS;
+
+rpal_check_failed:
+	pthread_key_delete(rpal_key);
+rpal_key_failed:
+	rpal_mgtfd_destroy();
+mgtfd_init_failed:
+	return RPAL_FAILURE;
+}
+
+static void rpal_managment_exit(void)
+{
+	pthread_key_delete(rpal_key);
+	rpal_mgtfd_destroy();
+	return;
+}
+
+int rpal_init(int nr_rpalthread, int flags, rpal_error_code_t *error)
+{
+	if (nr_rpalthread <= 0) {
+		dbprint(RPAL_DEBUG_MANAGEMENT,
+			"%s: nr_rpalthread(%d) less than or equal to 0\n",
+			__FUNCTION__, nr_rpalthread);
+		return RPAL_FAILURE;
+	}
+	if (rpal_managment_init(error) == RPAL_FAILURE) {
+		goto error_out;
+	}
+	if (rpal_thread_metadata_init(nr_rpalthread, error) == RPAL_FAILURE)
+		goto managment_exit;
+
+	if (rpal_senders_metadata_init(error) == RPAL_FAILURE)
+		goto thread_md_exit;
+
+	inited = 1;
+	dbprint(RPAL_DEBUG_MANAGEMENT,
+		"rpal init success, service key: 0x%lx, service id: %d, "
+		"critical_start: 0x%016lx, critical_end: 0x%016lx\n",
+		threads_md.service_key, threads_md.service_id, rcs.ret_begin,
+		rcs.ret_end);
+	return rpal_mgtfd;
+
+thread_md_exit:
+	rpal_thread_metadata_exit();
+managment_exit:
+	rpal_managment_exit();
+error_out:
+	return RPAL_FAILURE;
+}
+
+void rpal_exit(void)
+{
+	if (rpal_inited()) {
+		dbprint(RPAL_DEBUG_MANAGEMENT,
+			"rpal exit, service key: 0x%lx, service id: %d\n",
+			threads_md.service_key, threads_md.service_id);
+		rpal_senders_metadata_exit();
+		rpal_thread_metadata_exit();
+		rpal_managment_exit();
+	}
+}
diff --git a/samples/rpal/librpal/rpal.h b/samples/rpal/librpal/rpal.h
new file mode 100644
index 000000000000..e91a206b8370
--- /dev/null
+++ b/samples/rpal/librpal/rpal.h
@@ -0,0 +1,149 @@
+#ifndef RPAL_H_INCLUDED
+#define RPAL_H_INCLUDED
+
+#ifdef __cplusplus
+#if __cplusplus
+extern "C" {
+#endif
+#endif /* __cplusplus */
+
+#include <stdint.h>
+#include <stdarg.h>
+#include <sys/epoll.h>
+
+typedef enum rpal_error_code {
+	RPAL_ERR_NONE = 0,
+	RPAL_ERR_BAD_ARG = 1,
+	RPAL_ERR_NO_SERVICE = 2,
+	RPAL_ERR_MAPPED = 3,
+	RPAL_ERR_RETRY = 4,
+	RPAL_ERR_BAD_SERVICE_STATUS = 5,
+	RPAL_ERR_BAD_THREAD_STATUS = 6,
+	RPAL_ERR_REACH_LIMIT = 7,
+	RPAL_ERR_NOMEM = 8,
+	RPAL_ERR_NOMAPPING = 9,
+	RPAL_ERR_INVAL = 10,
+
+	RPAL_ERR_KERNEL_MAX_CODE = 100,
+
+	RPAL_ERR_RPALFILE_OPS, /**< Failed to open /proc/self/rpal */
+	RPAL_ERR_RPAL_DISABLED,
+	RPAL_ERR_GET_CAP_VERSION,
+	RPAL_KERNEL_API_NOTSUPPORT,
+	RPAL_HARDWARE_NOTSUPPORT,
+	RPAL_ERR_SERVICE_KEY, /**< Failed to get service key */
+	RPAL_ERR_SENDERS_METADATA,
+	RPAL_ERR_ENABLE_SERVICE,
+	RPAL_ERR_SENDER_PAGES,
+	RPAL_DONT_INITED,
+	RPAL_ERR_SENDER_INIT,
+	RPAL_ERR_SENDER_REG,
+	RPAL_INVALID_ARG,
+	RPAL_CACHE_FULL,
+	RPAL_FDE_OUTDATED,
+	RPAL_QUEUE_PUT_FAILED,
+	RPAL_ERR_PEER_MEM,
+	RPAL_ERR_NOTIFY_RECVER,
+	RPAL_INVAL_THREAD,
+	RPAL_INVAL_SERVICE,
+} rpal_error_code_t;
+
+#define EPOLLRPALIN 0x00020000
+#define EPOLLRPALOUT 0x00040000
+
+typedef enum rpal_features {
+	RPAL_SENDER_RECEIVER = 0x1 << 0,
+} rpal_features_t;
+
+typedef enum status {
+	RPAL_FAILURE = -1, /**< return value indicating failure */
+	RPAL_SUCCESS /**< return value indicating success */
+} status_t;
+
+#define RPAL_PUBLIC __attribute__((visibility("default")))
+
+RPAL_PUBLIC
+int rpal_init(int nr_rpalthread, int flags, rpal_error_code_t *error);
+
+RPAL_PUBLIC
+void rpal_exit(void);
+
+RPAL_PUBLIC
+int rpal_receiver_init(void);
+
+RPAL_PUBLIC
+void rpal_receiver_exit(void);
+
+RPAL_PUBLIC
+int rpal_request_service(uint64_t key);
+
+RPAL_PUBLIC
+status_t rpal_release_service(uint64_t key);
+
+RPAL_PUBLIC
+status_t rpal_clean_service_start(int64_t *ptr);
+
+RPAL_PUBLIC
+void rpal_clean_service_end(int64_t *ptr);
+
+RPAL_PUBLIC
+int rpal_get_service_id(void);
+
+RPAL_PUBLIC
+status_t rpal_get_service_key(uint64_t *service_key);
+
+RPAL_PUBLIC
+int rpal_get_request_service_id(uint64_t key);
+
+RPAL_PUBLIC
+status_t rpal_uds_fdmap(uint64_t sid_fd, uint64_t *rpalfd);
+
+RPAL_PUBLIC
+int rpal_get_peer_rid(uint64_t sid_fd);
+
+RPAL_PUBLIC
+status_t rpal_sender_init(rpal_error_code_t *error);
+
+RPAL_PUBLIC
+status_t rpal_sender_exit(void);
+
+/* Hook epoll syscall */
+RPAL_PUBLIC
+int rpal_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
+		    int timeout);
+
+RPAL_PUBLIC
+int rpal_epoll_wait_user(int epfd, struct epoll_event *events, int maxevents,
+			 int timeout);
+
+RPAL_PUBLIC
+int rpal_epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
+
+RPAL_PUBLIC
+status_t rpal_copy_prepare(int service_id);
+
+RPAL_PUBLIC
+status_t rpal_copy_finish(void);
+
+RPAL_PUBLIC
+int rpal_write_ptrs(int service_id, uint64_t rpalfd, int64_t *ptrs, int len);
+
+RPAL_PUBLIC
+int rpal_read_ptrs(int fd, int64_t *ptrs, int len);
+
+typedef int (*access_fn)(va_list args);
+RPAL_PUBLIC
+status_t rpal_read_access_safety(access_fn do_access, int *do_access_ret, ...);
+
+RPAL_PUBLIC
+void rpal_recver_count_print(void);
+
+RPAL_PUBLIC
+void rpal_sender_count_print(void);
+
+#ifdef __cplusplus
+#if __cplusplus
+}
+#endif
+#endif
+#endif //!_RPAL_H_INCLUDED
diff --git a/samples/rpal/librpal/rpal_pkru.h b/samples/rpal/librpal/rpal_pkru.h
new file mode 100644
index 000000000000..9590aa7203bb
--- /dev/null
+++ b/samples/rpal/librpal/rpal_pkru.h
@@ -0,0 +1,78 @@
+#include <x86intrin.h>
+#include "private.h"
+
+#define RPAL_PKRU_BASE_CODE_READ 0xAAAAAAAA
+#define RPAL_PKRU_BASE_CODE 0xFFFFFFFF
+#define RPAL_NO_PKEY -1
+
+typedef uint32_t u32;
+/*
+ * extern __inline unsigned int
+ * __attribute__((__gnu_inline__, __always_inline__, __artificial__))
+ * _rdpkru_u32 (void)
+ * {
+ *   return __builtin_ia32_rdpkru ();
+ * }
+ *
+ * extern __inline void
+ * __attribute__((__gnu_inline__, __always_inline__, __artificial__))
+ * _wrpkru (unsigned int __key)
+ * {
+ *   __builtin_ia32_wrpkru (__key);
+ * }
+ */
+// #define rdpkru _rdpkru_u32
+// #define wrpkru _wrpkru
+static inline uint32_t rdpkru(void)
+{
+	uint32_t ecx = 0;
+	uint32_t edx, pkru;
+
+	/*
+	 * "rdpkru" instruction.  Places PKRU contents in to EAX,
+	 * clears EDX and requires that ecx=0.
+	 */
+	asm volatile(".byte 0x0f,0x01,0xee\n\t"
+		     : "=a"(pkru), "=d"(edx)
+		     : "c"(ecx));
+	return pkru;
+}
+
+static inline void wrpkru(uint32_t pkru)
+{
+	uint32_t ecx = 0, edx = 0;
+
+	/*
+	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
+	 * requires that ecx = edx = 0.
+	 */
+	asm volatile(".byte 0x0f,0x01,0xef\n\t"
+		     :
+		     : "a"(pkru), "c"(ecx), "d"(edx));
+}
+
+static inline u32 rpal_pkey_to_pkru(int pkey)
+{
+	int offset = pkey * 2;
+	u32 mask = 0x3 << offset;
+
+	return RPAL_PKRU_BASE_CODE & ~mask;
+}
+
+static inline u32 rpal_pkey_to_pkru_read(int pkey)
+{
+	int offset = pkey * 2;
+	u32 mask = 0x3 << offset;
+
+	return RPAL_PKRU_BASE_CODE_READ & ~mask;
+}
+
+static inline u32 rpal_pkru_union(u32 pkru0, u32 pkru1)
+{
+	return pkru0 & pkru1;
+}
+
+static inline u32 rpal_pkru_intersect(u32 pkru0, u32 pkru1)
+{
+	return pkru0 | pkru1;
+}
diff --git a/samples/rpal/librpal/rpal_queue.c b/samples/rpal/librpal/rpal_queue.c
new file mode 100644
index 000000000000..07a90122aa16
--- /dev/null
+++ b/samples/rpal/librpal/rpal_queue.c
@@ -0,0 +1,239 @@
+#include "rpal_queue.h"
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+
+#define min(X, Y) ({ ((X) > (Y)) ? (Y) : (X); })
+
+static unsigned int roundup_pow_of_two(unsigned int data)
+{
+	unsigned int msb_position;
+
+	if (data <= 1)
+		return 1;
+	if (!(data & (data - 1)))
+		return data;
+
+	msb_position = 31 - __builtin_clz(data);
+	assert(msb_position < 31);
+	return 1 << (msb_position + 1);
+}
+
+QUEUE_UINT rpal_queue_unused(rpal_queue_t *q)
+{
+	return (q->mask + 1) - (q->tail - q->head);
+}
+
+QUEUE_UINT rpal_queue_len(rpal_queue_t *q)
+{
+	return (q->tail - q->head);
+}
+
+int rpal_queue_init(rpal_queue_t *q, void *data, QUEUE_UINT_INC usize)
+{
+	QUEUE_UINT_INC size;
+	if (usize > QUEUE_UINT_MAX || !data) {
+		return -1;
+	}
+	size = roundup_pow_of_two(usize);
+	if (usize != size) {
+		return -1;
+	}
+	q->data = data;
+	memset(q->data, 0, size * sizeof(int64_t));
+	q->head = 0;
+	q->tail = 0;
+	q->mask = size - 1;
+	return 0;
+}
+
+void *rpal_queue_destroy(rpal_queue_t *q)
+{
+	void *data = q->data;
+	if (q->data) {
+		q->data = NULL;
+	}
+	q->mask = 0;
+	q->head = 0;
+	q->tail = 0;
+	return data;
+}
+
+int rpal_queue_alloc(rpal_queue_t *q, QUEUE_UINT_INC size)
+{
+	assert(q && size);
+	if (size > QUEUE_UINT_MAX) {
+		return -1;
+	}
+	size = roundup_pow_of_two(size);
+	q->data = malloc(size * sizeof(int64_t));
+	if (!q->data)
+		return -1;
+	memset(q->data, 0, size * sizeof(int64_t));
+	q->head = 0;
+	q->tail = 0;
+	q->mask = size - 1;
+	return 0;
+}
+
+void rpal_queue_free(rpal_queue_t *q)
+{
+	if (q->data) {
+		free(q->data);
+		q->data = NULL;
+	}
+	q->mask = 0;
+	q->head = 0;
+	q->tail = 0;
+}
+
+static void rpal_queue_copy_in(rpal_queue_t *q, const int64_t *buf,
+			       QUEUE_UINT_INC len, QUEUE_UINT off)
+{
+	QUEUE_UINT_INC l;
+	QUEUE_UINT_INC size = q->mask + 1;
+
+	off &= q->mask;
+	l = min(len, size - off);
+
+	memcpy(q->data + off, buf, l << 3);
+	memcpy(q->data, buf + l, (len - l) << 3);
+	asm volatile("" : : : "memory");
+}
+
+QUEUE_UINT_INC rpal_queue_put(rpal_queue_t *q, const int64_t *buf,
+			      QUEUE_UINT_INC len)
+{
+	QUEUE_UINT_INC l;
+
+	if (!q->data) {
+		return 0;
+	}
+	l = rpal_queue_unused(q);
+	if (len > l) {
+		return 0;
+	}
+	l = len;
+	rpal_queue_copy_in(q, buf, l, q->tail);
+	q->tail += l;
+	return l;
+}
+
+static QUEUE_UINT_INC rpal_queue_copy_out(rpal_queue_t *q, int64_t *buf,
+					  QUEUE_UINT_INC len, QUEUE_UINT head)
+{
+	unsigned int l;
+	QUEUE_UINT tail;
+	QUEUE_UINT off;
+	QUEUE_UINT_INC size = q->mask + 1;
+
+	tail = __atomic_load_n(&q->tail, __ATOMIC_RELAXED);
+	len = min((QUEUE_UINT)(tail - head), len);
+	if (head == tail)
+		return 0;
+	off = head & q->mask;
+	l = min(len, size - off);
+
+	memcpy(buf, q->data + off, l << 3);
+	memcpy(buf + l, q->data, (len - l) << 3);
+
+	return len;
+}
+
+QUEUE_UINT_INC rpal_queue_peek(rpal_queue_t *q, int64_t *buf,
+			       QUEUE_UINT_INC len, QUEUE_UINT *phead)
+{
+	QUEUE_UINT_INC copied;
+	QUEUE_UINT head;
+
+	head = __atomic_load_n(&q->head, __ATOMIC_RELAXED);
+	copied = rpal_queue_copy_out(q, buf, len, head);
+	if (phead) {
+		*phead = head;
+	}
+	return copied;
+}
+
+QUEUE_UINT_INC rpal_queue_skip(rpal_queue_t *q, QUEUE_UINT head,
+			       QUEUE_UINT_INC skip)
+{
+	if (skip > rpal_queue_len(q)) {
+		return 0;
+	}
+	if (__atomic_compare_exchange_n(&q->head, &head, head + skip, 1,
+					__ATOMIC_RELAXED, __ATOMIC_RELAXED)) {
+		return skip;
+	}
+	return 0;
+}
+
+QUEUE_UINT_INC rpal_queue_get(rpal_queue_t *q, int64_t *buf, QUEUE_UINT_INC len)
+{
+	QUEUE_UINT_INC copied;
+	QUEUE_UINT head;
+
+	while (1) {
+		head = __atomic_load_n(&q->head, __ATOMIC_RELAXED);
+		copied = rpal_queue_copy_out(q, buf, len, head);
+		if (__atomic_compare_exchange_n(&q->head, &head, head + copied,
+						1, __ATOMIC_RELAXED,
+						__ATOMIC_RELAXED)) {
+			return copied;
+		}
+	}
+}
+
+void rpal_uevent_queue_init(epoll_uevent_queue_t *ueventq,
+			    volatile uint64_t *uqlock)
+{
+	int i;
+	__atomic_store_n(uqlock, (uint64_t)0, __ATOMIC_RELAXED);
+	ueventq->l_beg = 0;
+	ueventq->l_end = 0;
+	ueventq->l_end_cache = 0;
+	for (i = 0; i < MAX_RDY; ++i) {
+		ueventq->fds[i] = -1;
+	}
+	return;
+}
+
+QUEUE_UINT uevent_queue_len(epoll_uevent_queue_t *ueventq)
+{
+	return (ueventq->l_end - ueventq->l_beg);
+}
+
+QUEUE_UINT uevent_queue_add(epoll_uevent_queue_t *ueventq, int fd)
+{
+	unsigned int pos;
+	if (uevent_queue_len(ueventq) == MAX_RDY)
+		return MAX_RDY;
+	pos = __sync_fetch_and_add(&ueventq->l_end_cache, 1);
+	pos %= MAX_RDY;
+	ueventq->fds[pos] = fd;
+	asm volatile("" : : : "memory");
+	__sync_fetch_and_add(&ueventq->l_end, 1);
+	return (pos);
+}
+
+int uevent_queue_del(epoll_uevent_queue_t *ueventq)
+{
+	int fd = -1;
+	int pos;
+	if (uevent_queue_len(ueventq) == 0) {
+		return -1;
+	}
+	pos = ueventq->l_beg % MAX_RDY;
+	fd = ueventq->fds[pos];
+	asm volatile("" : : : "memory");
+	__sync_fetch_and_add(&ueventq->l_beg, 1);
+	return fd;
+}
+
+int uevent_queue_fix(epoll_uevent_queue_t *ueventq)
+{
+	__atomic_store_n(&ueventq->l_end_cache, ueventq->l_end,
+			 __ATOMIC_SEQ_CST);
+	return 0;
+}
diff --git a/samples/rpal/librpal/rpal_queue.h b/samples/rpal/librpal/rpal_queue.h
new file mode 100644
index 000000000000..224e7b449d50
--- /dev/null
+++ b/samples/rpal/librpal/rpal_queue.h
@@ -0,0 +1,55 @@
+#ifndef RPAL_QUEUE_H
+#define RPAL_QUEUE_H
+
+#include <stdint.h>
+
+// typedef uint8_t QUEUE_UINT;
+// typedef uint16_t QUEUE_UINT_INC;
+// #define QUEUE_UINT_MAX UINT8_MAX
+
+// typedef uint16_t QUEUE_UINT;
+// typedef uint32_t QUEUE_UINT_INC;
+// #define QUEUE_UINT_MAX UINT16_MAX
+
+typedef uint32_t QUEUE_UINT;
+typedef uint64_t QUEUE_UINT_INC;
+#define QUEUE_UINT_MAX UINT32_MAX
+
+typedef struct rpal_queue {
+	QUEUE_UINT head;
+	QUEUE_UINT tail;
+	QUEUE_UINT mask;
+	uint64_t *data;
+} rpal_queue_t;
+
+QUEUE_UINT rpal_queue_len(rpal_queue_t *q);
+QUEUE_UINT rpal_queue_unused(rpal_queue_t *q);
+int rpal_queue_init(rpal_queue_t *q, void *data, QUEUE_UINT_INC usize);
+void *rpal_queue_destroy(rpal_queue_t *q);
+int rpal_queue_alloc(rpal_queue_t *q, QUEUE_UINT_INC size);
+void rpal_queue_free(rpal_queue_t *q);
+QUEUE_UINT_INC rpal_queue_put(rpal_queue_t *q, const int64_t *buf,
+			      QUEUE_UINT_INC len);
+QUEUE_UINT_INC rpal_queue_get(rpal_queue_t *q, int64_t *buf,
+			      QUEUE_UINT_INC len);
+QUEUE_UINT_INC rpal_queue_peek(rpal_queue_t *q, int64_t *buf,
+			       QUEUE_UINT_INC len, QUEUE_UINT *phead);
+QUEUE_UINT_INC rpal_queue_skip(rpal_queue_t *q, QUEUE_UINT head,
+			       QUEUE_UINT_INC skip);
+
+#define MAX_RDY 4096
+typedef struct epoll_uevent_queue {
+	int fds[MAX_RDY];
+	volatile QUEUE_UINT l_beg;
+	volatile QUEUE_UINT l_end;
+	volatile QUEUE_UINT l_end_cache;
+} epoll_uevent_queue_t;
+
+void rpal_uevent_queue_init(epoll_uevent_queue_t *ueventq,
+			    volatile uint64_t *uqlock);
+QUEUE_UINT uevent_queue_len(epoll_uevent_queue_t *ueventq);
+QUEUE_UINT uevent_queue_add(epoll_uevent_queue_t *ueventq, int fd);
+int uevent_queue_del(epoll_uevent_queue_t *ueventq);
+int uevent_queue_fix(epoll_uevent_queue_t *ueventq);
+
+#endif
diff --git a/samples/rpal/librpal/rpal_x86_64_call_ret.S b/samples/rpal/librpal/rpal_x86_64_call_ret.S
new file mode 100644
index 000000000000..a7c09a1b033d
--- /dev/null
+++ b/samples/rpal/librpal/rpal_x86_64_call_ret.S
@@ -0,0 +1,45 @@
+#ifdef __x86_64__
+#define __ASSEMBLY__
+#include "asm_define.h"
+#define RPAL_SENDER_STATE_RUNNING $0x0
+#define RPAL_SENDER_STATE_CALL $0x1
+
+.text
+.globl rpal_ret_critical
+.type rpal_ret_critical,@function
+.align 16
+
+//void rpal_ret_criticalreceiver_context_t *rc, rpal_call_info_t *rci
+
+rpal_ret_critical:
+    mov     RPAL_SENDER_STATE_CALL, %eax
+    mov     RPAL_SENDER_STATE_RUNNING, %ecx
+    lock cmpxchg   %ecx, RC_SENDER_STATE(%rdi)
+ret_begin:
+    jne 2f
+    movq    RCI_PKRU(%rsi), %rax
+    xor     %edx, %edx
+    .byte 0x0f,0x01,0xef
+    movq    RCI_SENDER_TLS_BASE(%rsi), %rax
+    wrfsbase %rax
+ret_end:
+    movq    RCI_SENDER_FCTX(%rsi), %rdi
+    call    jump_fcontext@plt
+2:
+    ret
+
+.globl rpal_get_critical_addr
+.type rpal_get_critical_addr,@function
+.align 16
+rpal_get_critical_addr:
+    leaq    ret_begin(%rip), %rax
+    movq    %rax, RET_BEGIN(%rdi)
+    leaq    ret_end(%rip), %rax
+    movq    %rax, RET_END(%rdi)
+    ret
+
+.size rpal_ret_critical,.-rpal_ret_critical
+
+/* Mark that we don't need executable stack. */
+.section .note.GNU-stack,"",%progbits
+#endif
diff --git a/samples/rpal/offset.sh b/samples/rpal/offset.sh
new file mode 100755
index 000000000000..f5ae77b893e8
--- /dev/null
+++ b/samples/rpal/offset.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+
+set -e
+CUR_DIR=$(dirname $(realpath -s "$0"))
+gcc -masm=intel -S $CUR_DIR/asm_define.c -o - | awk '($1 == "->") { print "#define " $2 " " $3 }' > $CUR_DIR/librpal/asm_define.h
\ No newline at end of file
diff --git a/samples/rpal/server.c b/samples/rpal/server.c
new file mode 100644
index 000000000000..82c5c9dec922
--- /dev/null
+++ b/samples/rpal/server.c
@@ -0,0 +1,249 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/epoll.h>
+#include <x86intrin.h>
+#include "librpal/rpal.h"
+
+#define SOCKET_PATH "/tmp/rpal_socket"
+#define MAX_EVENTS 10
+#define BUFFER_SIZE 1025
+#define MSG_LEN 32
+
+#define INIT_MSG "INIT"
+#define SUCC_MSG "SUCC"
+#define FAIL_MSG "FAIL"
+
+#define handle_error(s)                                                        \
+	do {                                                                   \
+		perror(s);                                                     \
+		exit(EXIT_FAILURE);                                            \
+	} while (0)
+
+uint64_t service_key;
+int server_fd;
+int epoll_fd;
+
+int rpal_epoll_add(int epfd, int fd)
+{
+	struct epoll_event ev;
+
+	ev.events = EPOLLRPALIN | EPOLLIN | EPOLLRDHUP | EPOLLET;
+	ev.data.fd = fd;
+
+	return rpal_epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev);
+}
+
+void rpal_server_init(int fd, int epoll_fd)
+{
+	char buffer[BUFFER_SIZE];
+	rpal_error_code_t err;
+	uint64_t remote_key, service_key;
+	int remote_id;
+	int proc_fd;
+	int ret;
+
+	proc_fd = rpal_init(1, 0, &err);
+	if (proc_fd < 0)
+		handle_error("rpal init fail");
+	rpal_get_service_key(&service_key);
+
+	rpal_epoll_add(epoll_fd, fd);
+
+	ret = read(fd, buffer, BUFFER_SIZE);
+	if (ret < 0)
+		handle_error("rpal init: read");
+
+	if (strncmp(buffer, INIT_MSG, strlen(INIT_MSG)) != 0) {
+		buffer[BUFFER_SIZE - 1] = 0;
+		handle_error("Invalid msg\n");
+		return;
+	}
+
+	remote_key = *(uint64_t *)(buffer + strlen(INIT_MSG));
+	ret = rpal_request_service(remote_key);
+	if (ret) {
+		uint64_t service_key = 0;
+		ret = write(fd, (char *)&service_key, sizeof(uint64_t));
+		handle_error("request service fail");
+		return;
+	}
+	ret = write(fd, (char *)&service_key, sizeof(uint64_t));
+	if (ret < 0)
+		handle_error("write error");
+
+	ret = read(fd, buffer, BUFFER_SIZE);
+	if (ret < 0)
+		handle_error("handshake read");
+
+	if (strncmp(SUCC_MSG, buffer, strlen(SUCC_MSG)) != 0)
+		handle_error("handshake");
+
+	remote_id = rpal_get_request_service_id(remote_key);
+	if (remote_id < 0)
+		handle_error("remote id get fail");
+	rpal_receiver_init();
+}
+
+void run_rpal_server(int msg_len)
+{
+	struct epoll_event ev, events[MAX_EVENTS];
+	int new_socket;
+	int nfds;
+	uint64_t tsc, total_tsc = 0;
+	int count = 0;
+
+	while (1) {
+		nfds = rpal_epoll_wait(epoll_fd, events, MAX_EVENTS, -1);
+		if (nfds == -1) {
+			perror("epoll_wait");
+			exit(EXIT_FAILURE);
+		}
+
+		for (int n = 0; n < nfds; ++n) {
+			if (events[n].data.fd == server_fd) {
+				new_socket = accept(server_fd, NULL, NULL);
+				if (new_socket == -1) {
+					perror("accept");
+					continue;
+				}
+
+				rpal_server_init(new_socket, epoll_fd);
+			} else if (events[n].events & EPOLLRDHUP) {
+				close(events[n].data.fd);
+				goto finish;
+			} else if (events[n].events & EPOLLRPALIN) {
+				char buffer[BUFFER_SIZE] = { 0 };
+
+				ssize_t valread = rpal_read_ptrs(
+					events[n].data.fd, (int64_t *)buffer,
+					MSG_LEN / sizeof(int64_t *));
+				if (valread <= 0) {
+					close(events[n].data.fd);
+					epoll_ctl(epoll_fd, EPOLL_CTL_DEL,
+						  events[n].data.fd, NULL);
+					goto finish;
+				} else {
+					count++;
+					sscanf(buffer, "0x%016lx", &tsc);
+					total_tsc += __rdtsc() - tsc;
+					send(events[n].data.fd, buffer, msg_len,
+					     0);
+				}
+			} else {
+				perror("bad request\n");
+			}
+		}
+	}
+finish:
+	printf("RPAL: Message length: %d bytes, Total TSC cycles: %lu, "
+	       "Message count: %d, Average latency: %lu cycles\n",
+	       MSG_LEN, total_tsc, count, total_tsc / count);
+}
+
+void run_server(int msg_len)
+{
+	struct epoll_event ev, events[MAX_EVENTS];
+	int new_socket;
+	int nfds;
+	uint64_t tsc, total_tsc = 0;
+	int count = 0;
+
+	while (1) {
+		nfds = epoll_wait(epoll_fd, events, MAX_EVENTS, -1);
+		if (nfds == -1) {
+			perror("epoll_wait");
+			exit(EXIT_FAILURE);
+		}
+
+		for (int n = 0; n < nfds; ++n) {
+			if (events[n].data.fd == server_fd) {
+				new_socket = accept(server_fd, NULL, NULL);
+				if (new_socket == -1) {
+					perror("accept");
+					continue;
+				}
+
+				ev.events = EPOLLIN;
+				ev.data.fd = new_socket;
+				if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD,
+					      new_socket, &ev) == -1) {
+					close(new_socket);
+					perror("epoll_ctl: add new socket");
+				}
+			} else if (events[n].events & EPOLLRDHUP) {
+				close(events[n].data.fd);
+				goto finish;
+			} else {
+				char buffer[BUFFER_SIZE] = { 0 };
+
+				ssize_t valread = read(events[n].data.fd,
+						       buffer, BUFFER_SIZE);
+				if (valread <= 0) {
+					close(events[n].data.fd);
+					epoll_ctl(epoll_fd, EPOLL_CTL_DEL,
+						  events[n].data.fd, NULL);
+					goto finish;
+				} else {
+					count++;
+					sscanf(buffer, "0x%016lx", &tsc);
+					total_tsc += __rdtsc() - tsc;
+					send(events[n].data.fd, buffer, msg_len,
+					     0);
+				}
+			}
+		}
+	}
+finish:
+	printf("EPOLL: Message length: %d bytes, Total TSC cycles: %lu, "
+	       "Message count: %d, Average latency: %lu cycles\n",
+	       MSG_LEN, total_tsc, count, total_tsc / count);
+}
+
+int main()
+{
+	struct sockaddr_un address;
+	struct epoll_event ev;
+
+	if ((server_fd = socket(AF_UNIX, SOCK_STREAM, 0)) == 0) {
+		perror("socket failed");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&address, 0, sizeof(address));
+	address.sun_family = AF_UNIX;
+	strncpy(address.sun_path, SOCKET_PATH, sizeof(SOCKET_PATH));
+
+	if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
+		perror("bind failed");
+		exit(EXIT_FAILURE);
+	}
+
+	if (listen(server_fd, 3) < 0) {
+		perror("listen");
+		exit(EXIT_FAILURE);
+	}
+
+	epoll_fd = epoll_create(1024);
+	if (epoll_fd == -1) {
+		perror("epoll_create");
+		exit(EXIT_FAILURE);
+	}
+
+	ev.events = EPOLLIN;
+	ev.data.fd = server_fd;
+	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, server_fd, &ev) == -1) {
+		perror("epoll_ctl: listen_sock");
+		exit(EXIT_FAILURE);
+	}
+
+	run_server(MSG_LEN);
+	run_rpal_server(MSG_LEN);
+
+	close(server_fd);
+	unlink(SOCKET_PATH);
+	return 0;
+}
-- 
2.20.1


