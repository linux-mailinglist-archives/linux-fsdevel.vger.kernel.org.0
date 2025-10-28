Return-Path: <linux-fsdevel+bounces-65900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C584C139FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0C562761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F702EBDF4;
	Tue, 28 Oct 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0MnbcbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD62EBB86;
	Tue, 28 Oct 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641250; cv=none; b=q1kh6NWpWvIsRxQsIiMk4Apf3tk3vlyLX8sowc1dTy8w9RPKR4pifKwfKnhqjVtTeorOXTxrNXqxcsTqNyO8IdDPJ9GBuxMpoPZumNQ3aye05jM2BxObmnmMlHCAOhQP7AAKtJg5djdaErsO7kTTikfjhZUKojsa0FtPBugdAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641250; c=relaxed/simple;
	bh=rpDHbmaasl+ntrsC4mcpJJdeQ8AEZE/m9hK+dPnDY8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J40mULmCmXmCsQQermp2TzHfQNnhsu21+HkrGbrqxAfwGH0fnPumHzsXztYdPxA412cBjFGb2VIePvt0PlIStZH1jPi6sFU/A4tJLDWV6v+m1mXKyRx9/RP6LSZcAhFhib+0Mya3D8SGAYrxDeo29uSt9uTXezHbBSeAFfkjOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0MnbcbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186C9C116C6;
	Tue, 28 Oct 2025 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641249;
	bh=rpDHbmaasl+ntrsC4mcpJJdeQ8AEZE/m9hK+dPnDY8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F0MnbcbQrgVIKuL5t5rHrq953FlTE5pfYoMnOixg5Ll0SY/ADW4/znpdHup4ja3OS
	 avEff1vJ7CDcznp6jz5acDktuvCGWeafDbIWxGceGMHb/YnbZNIdEgyGoBfuxFlQcf
	 PFSo2yarFk2tWQLFm6+zAE71yYyYYVrt2zoVvVap+v3+hOuaJ3lm9WCx91jbiFds5o
	 bxJsnuRXbdIqXsUYAU6FldPfoydXPqI2r5IUh9mZfT0XQ271YowstBu5rzTA42ho6m
	 SrOvuxq5ceXiFSTMo9sSrk51Dpc/I7Ra70uBMx4c1dINhckuWGqQMVmixt+9ccxeR4
	 8xAtu67++eQow==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:46:05 +0100
Subject: [PATCH 20/22] selftests/coredump: ignore ENOSPC errors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-20-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3068; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rpDHbmaasl+ntrsC4mcpJJdeQ8AEZE/m9hK+dPnDY8Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB1qrr44o3/pUdPtt6+VaqxzydOJOOD3+uOO5ZWxP
 DwOs5KcOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayn4mRYcKKtVdv/DafrC8b
 r77gYOf9m1+zzmddrBRac5nng5T8eWOGv+KHr+34msT8uOjiq5eNzvZCx5inGwj5HTk2Z15wzTu
 VXE4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If we crash multiple processes at the same time we may run out of space.
Just ignore those errors. They're not actually all that relevant for the
test.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_socket_protocol_test.c | 4 ++++
 tools/testing/selftests/coredump/coredump_socket_test.c          | 5 +++--
 tools/testing/selftests/coredump/coredump_test_helpers.c         | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index 566545e96d7f..d19b6717c53e 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -184,6 +184,8 @@ TEST_F(coredump, socket_request_kernel)
 
 			bytes_write = write(fd_core_file, buffer, bytes_read);
 			if (bytes_read != bytes_write) {
+				if (bytes_write < 0 && errno == ENOSPC)
+					continue;
 				fprintf(stderr, "socket_request_kernel: write to core file failed (read=%zd, write=%zd): %m\n",
 					bytes_read, bytes_write);
 				goto out;
@@ -1366,6 +1368,8 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
 
 				bytes_write = write(fd_core_file, buffer, bytes_read);
 				if (bytes_read != bytes_write) {
+					if (bytes_write < 0 && errno == ENOSPC)
+						continue;
 					fprintf(stderr, "write failed for fd %d: %m\n", fd_core_file);
 					goto out;
 				}
diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 0a37d0456672..da558a0e37aa 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -158,8 +158,9 @@ TEST_F(coredump, socket)
 
 			bytes_write = write(fd_core_file, buffer, bytes_read);
 			if (bytes_read != bytes_write) {
-				fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n",
-					bytes_read, bytes_write);
+				if (bytes_write < 0 && errno == ENOSPC)
+					continue;
+				fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n", bytes_read, bytes_write);
 				goto out;
 			}
 		}
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 65deb3cfbe1b..a6f6d5f2ae07 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -357,6 +357,8 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
 					goto done;
 				ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
 				if (bytes_write != bytes_read) {
+					if (bytes_write < 0 && errno == ENOSPC)
+						continue;
 					fprintf(stderr, "Worker: write() failed (read=%zd, write=%zd): %m\n",
 						bytes_read, bytes_write);
 					goto out;

-- 
2.47.3


