Return-Path: <linux-fsdevel+bounces-69117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD2CC6FD39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39F0D4FC257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF282E973F;
	Wed, 19 Nov 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhkCUMCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500527F16C;
	Wed, 19 Nov 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567000; cv=none; b=uKzbXuloyTpueHtGsZxkp6YAnITHi3Hv/205ofkOvYds8j+TWUfVMPOH4NmI6TWJlVtOmSiY+FjmbflaQRlP41dJKqZEdHMmQyvu4VZ4yOEDFd2Mu3hP48ZEZp9I56GHG1OpGbL2PD0cjvGeKBMOBrS5QDXyQ/wO9ir6P9UsYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567000; c=relaxed/simple;
	bh=7BjXx3mEgAh8vrx8RJAPZ5HBe6wN4mhQLqpyv1v7Un0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HL+VtfCyppGKLgQxUvA+3xbS4IYORLlvwz63LgU7ei95k8FZslQ3YcffIGqsoV7qs0gTGi4dI8W8tLWXBYQeO8WKFWj1ozaCZKccEt0a6NttA/rw2V3Y+upOGRJOWwaSETrv3xGdxXUSW00ZSRfUAuqbtZ//m1uMINk1vDW/7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhkCUMCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A213EC116C6;
	Wed, 19 Nov 2025 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567000;
	bh=7BjXx3mEgAh8vrx8RJAPZ5HBe6wN4mhQLqpyv1v7Un0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OhkCUMCiQZprY418Zo6U954wRWPHnJsh0ZGttII5kR1niokvDE12GgewWr94+Udk3
	 bjpe4ra5qSLA8z62FDTlQEVWwBvWXBEdPIVR0HQUGxv9XacEgR8Lf2eva5qcfy9sJV
	 YUoy1GCyg90aaPUzgfBsY3oWzz6lmjrzcorG6iiMDQgtDWi7Yi58maJa9ywCXZl0aS
	 7L8TS0rjsnlBtxl7TjIgWamgcUW6DPoHwpFUyBa5P6wSbkAWlcJViDNq9ONkFlZ+ie
	 XMya0ReeQFcra/AVpupNiA2+i9aPjhuiqZnE2nnIzKNJXi5/aynfloPIrTP48pmg2r
	 F2itGu4T0dJlw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Nov 2025 10:43:04 -0500
Subject: [PATCH fstests v2 2/3] generic: add test for directory delegations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-dir-deleg-v2-2-f952ba272384@kernel.org>
References: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
In-Reply-To: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19579; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7BjXx3mEgAh8vrx8RJAPZ5HBe6wN4mhQLqpyv1v7Un0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHeWVYWTpYw/S6qSz6ek7Mhb3MFBthhTd9VWiw
 MBv9Jobp32JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3llQAKCRAADmhBGVaC
 FRGLD/9WLz0p51l4lTZZikWWIrBAtUEncGP6pcF7F95Ys5dhGJoW7D2Krh4lOXTazVGPM9yfXuh
 LZWNIjrdDTBSdVklTtXYEZXggkEYYlRs43a0bzGH3pAlQAXU+bPvH+K4KEiX4PCdx3oVC3++8nM
 tD3S8VpFZYzb2xK8B1OZwB+ulL7SBcev71wqmjEr3We6yA+NvQVL9N0PW2VDWiEvVlq1oop9X3q
 arWt/Ss6uSFXKYo1dPjJ8Aw1uqmfI/3/8tmxhV1JHtd7NXqDIXdX79bqj0D6ZtBVmuYjLxuBb5V
 HjaNrxUg0m46PS+RsGTLe3fNJAJLi4Jd1A6b2QDl82Y0rv8Je/zJV5msyFuR/RPTJak8riOskMA
 KroGjCPlg4w8/Yz52QO6xTWgScIqFvDN+yh3VpvV6UMTZE3WfQHJdXG0zs1dg8FLStuZPvwU8Wo
 IQ2CaudDastIFDnvYA2nYUNyHkt19hdhrgSenTWc2MxPkoTYkQLcO5rom8zLT40adwVJk7sKq/2
 9Wf2iYolLOzbMAg7fhaRxPhFZM+GhmTrpOK/UaB3E1RuswwILjmgRInM51BVjaW1QSkhlsQvND0
 ctq9gGis5tBS62PmWkXubZenk9ib5/t6m1FJ0JaONBEMgTNu/EwZkKB4jhMUxpajRLxGqVlUSNn
 5ut2ZzliMGkGapA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the advent of directory delegation support coming to the kernel,
add support for testing them to the existing locktest.c program, and add
testcases for all of the different ways that they can be broken.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/locktest       |  14 +-
 common/rc             |  10 ++
 src/locktest.c        | 423 ++++++++++++++++++++++++++++++++++++++++++++++++--
 tests/generic/999     |  22 +++
 tests/generic/999.out |   2 +
 5 files changed, 456 insertions(+), 15 deletions(-)

diff --git a/common/locktest b/common/locktest
index 61e7dd42785dd3d4f21050e10bd5ec9d76a3b15a..609078485dac9358da7298082ad5ca5acada51dc 100644
--- a/common/locktest
+++ b/common/locktest
@@ -6,6 +6,7 @@ SERVER_LOG=$TEST_DIR/server.out
 SERVER_PORT=$TEST_DIR/server.port
 CLIENT_LOG=$TEST_DIR/client.out
 TESTFILE=$TEST_DIR/lock_file
+DELEGDIR=$TEST_DIR/dirdeleg
 client_pid=""
 server_pid=""
 
@@ -13,7 +14,7 @@ _cleanup()
 {
 	kill $client_pid > /dev/null 2>&1
 	kill $server_pid > /dev/null 2>&1
-	rm -f $TESTFILE
+	rm -rf $TESTFILE $DELEGDIR
 }
 
 _dump_logs_fail()
@@ -42,8 +43,6 @@ _run_generic() {
 	rm -f $CLIENT_LOG
 	touch $CLIENT_LOG
 
-	touch $TESTFILE
-
 	# Start the server
 	$here/src/locktest $mode $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
 	server_pid=$!
@@ -87,9 +86,18 @@ _run_generic() {
 }
 
 _run_locktest() {
+	touch $TESTFILE
+
 	_run_generic ""
 }
 
 _run_leasetest() {
+	touch $TESTFILE
+
 	_run_generic "-L"
 }
+
+_run_dirleasetest() {
+	TESTFILE=$DELEGDIR
+	_run_generic "-D"
+}
diff --git a/common/rc b/common/rc
index 116216ca8aeb4e53f3e0d741cc99a050cb3a7462..8df2b387a8a85c7dafeea02f9f9422f52a7d0d01 100644
--- a/common/rc
+++ b/common/rc
@@ -4662,6 +4662,16 @@ _require_test_fcntl_setlease()
 		_notrun "NFS requires delegation before setlease"
 }
 
+_require_test_fcntl_setdeleg()
+{
+	_require_test_program "locktest"
+	mkdir $TEST_DIR/setdeleg_testdir
+	$here/src/locktest -t -D $TEST_DIR/setdeleg_testdir >/dev/null 2>&1
+	local ret=$?
+	rm -rf $TEST_DIR/setdeleg_testdir
+	[ $ret -eq 22 ] && _notrun "Require fcntl setdeleg support"
+}
+
 _require_ofd_locks()
 {
 	# Give a test run by getlk wrlck on testfile.
diff --git a/src/locktest.c b/src/locktest.c
index a6cf3b1d5a99dc2cf78f7ceb79622e1ab135c42c..eb40dce3f1b28ef34752518808ec2f3999cd4257 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+#include <limits.h>
 
 #define     HEX_2_ASC(x)    ((x) > 9) ? (x)-10+'a' : (x)+'0'
 #define 	FILE_SIZE	1024
@@ -60,8 +61,6 @@ extern int h_errno;
 #define SOCKET_CLOSE(S)     (close(S))
 #define INVALID_SOCKET      -1
 
-#define O_BINARY            0
-       
 #define HANDLE              int
 #define INVALID_HANDLE      -1
 #define SEEK(H, O)          (lseek(H, O, SEEK_SET))
@@ -78,6 +77,17 @@ extern int h_errno;
 #define ALLOC_ALIGNED(S)    (memalign(65536, S)) 
 #define FREE_ALIGNED(P)     (free(P)) 
 
+#ifndef F_GETDELEG
+#define F_GETDELEG	(1024 + 15)
+#define F_SETDELEG	(1024 + 16)
+
+struct delegation {
+	uint32_t d_flags;
+	uint16_t d_type;
+	uint16_t __pad;
+};
+#endif
+
 static char	*prog;
 static char	*filename = 0;
 static int	debug = 0;
@@ -86,11 +96,14 @@ static int	port = 0;
 static int 	testnumber = -1;
 static int	saved_errno = 0;
 static int      got_sigio = 0;
+static int	lease_is_deleg = 0;
 
 static SOCKET	s_fd = -1;              /* listen socket    */
 static SOCKET	c_fd = -1;	        /* IPC socket       */
 static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 
+static char *child[] = { "child0", "child1" };
+
 #define 	CMD_WRLOCK	0
 #define 	CMD_RDLOCK	1
 #define		CMD_UNLOCK	2
@@ -103,9 +116,19 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		CMD_SIGIO	9
 #define		CMD_WAIT_SIGIO	10
 #define		CMD_TRUNCATE	11
-
-#define		PASS 	1
-#define		FAIL	0
+#define		CMD_GETDELEG	12
+#define		CMD_SETDELEG	13
+#define		CMD_CREATE	14
+#define		CMD_UNLINK	15
+#define		CMD_RENAME	16
+#define		CMD_SYMLINK	17
+#define		CMD_MKNOD	18
+#define		CMD_CHMOD	19
+#define		CMD_MKDIR	20
+#define		CMD_RMDIR	21
+
+#define		PASS 	0
+#define		FAIL	1
 
 #define		SERVER	0
 #define		CLIENT	1
@@ -119,6 +142,7 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		FLAGS		2 /* index 2 is also used for do_open() flag, see below */
 #define		ARG		FLAGS /* Arguments for Lease operations */
 #define		TIME		FLAGS /* Time for waiting on sigio */
+#define		ARG2		3 /* second argument for dir operations */
 
 static char *get_cmd_str(int cmd)
 {
@@ -135,6 +159,16 @@ static char *get_cmd_str(int cmd)
 		case CMD_SIGIO:    return "Setup SIGIO"; break;
 		case CMD_WAIT_SIGIO: return "Wait for SIGIO"; break;
 		case CMD_TRUNCATE: return "Truncate"; break;
+		case CMD_SETDELEG: return "Set Delegation"; break;
+		case CMD_GETDELEG: return "Get Delegation"; break;
+		case CMD_CREATE: return "Create"; break;
+		case CMD_UNLINK: return "Remove"; break;
+		case CMD_RENAME: return "Rename"; break;
+		case CMD_SYMLINK: return "Symlink"; break;
+		case CMD_MKNOD: return "Mknod"; break;
+		case CMD_CHMOD: return "Chmod"; break;
+		case CMD_MKDIR: return "Mkdir"; break;
+		case CMD_RMDIR: return "Rmdir"; break;
 	}
 	return "unknown";
 }
@@ -682,6 +716,123 @@ static int64_t lease_tests[][6] =
 		{0,0,0,0,0,CLIENT}
 	};
 
+char *dirdeleg_descriptions[] = {
+    /*  1 */"Take Read Lease",
+    /*  2 */"Write Lease Should Fail",
+    /*  3 */"Dir Lease Should Be Broken on Create",
+    /*  4 */"Dir Lease Should Be Broken on Unlink",
+    /*  5 */"Dir Lease Should Be Broken on Rename",
+    /*  6 */"Dir Lease Should Be Broken on Symlink",
+    /*  7 */"Dir Lease Should Be Broken on Mknod",
+    /*  8 */"Dir Lease Should Be Broken on Chmod",
+    /*  9 */"Dir Lease Should Be Broken on Mkdir",
+    /* 10 */"Dir Lease Should Be Broken on Rmdir",
+};
+
+static int64_t dirdeleg_tests[][6] =
+	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
+	/*			[sigio_wait_time]						*/
+{
+	/* Various tests to exercise leases */
+
+/* SECTION 1: Simple verification of being able to take leases */
+	/* Take Read Lease, and release it */
+	{1,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{1,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{1,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{1,	CMD_SETDELEG,	F_UNLCK,		0,	PASS,		SERVER	},
+	{1,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Write Lease should fail */
+	{2,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{2,	CMD_SETDELEG,	F_WRLCK,		0,	FAIL,		SERVER	},
+	{2,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by a create */
+	{3,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{3,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{3,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{3,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{3,	CMD_CREATE,	0,			0,	PASS,		CLIENT	},
+	{3,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{3,	CMD_UNLINK,	0,			0,	PASS,		SERVER	},
+	{3,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by unlink */
+	{4,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{4,	CMD_CREATE,	0,			0,	PASS,		SERVER	},
+	{4,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{4,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{4,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{4,	CMD_UNLINK,	0,			0,	PASS,		CLIENT	},
+	{4,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{4,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by rename */
+	{5,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{5,	CMD_CREATE,	0,			0,	PASS,		SERVER	},
+	{5,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{5,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{5,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{5,	CMD_RENAME,	0,			1,	PASS,		CLIENT	},
+	{5,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{5,	CMD_UNLINK,	1,			0,	PASS,		CLIENT	},
+	{5,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by symlink */
+	{6,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{6,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{6,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{6,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{6,	CMD_SYMLINK,	0,			1,	PASS,		CLIENT	},
+	{6,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{6,	CMD_UNLINK,	0,			0,	PASS,		CLIENT	},
+	{6,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by mknod */
+	{7,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{7,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{7,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{7,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{7,	CMD_MKNOD,	0,			0,	PASS,		CLIENT	},
+	{7,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{7,	CMD_UNLINK,	0,			0,	PASS,		CLIENT	},
+	{7,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by chmod */
+	{8,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{8,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{8,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{8,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{8,	CMD_CHMOD,	0775,			0,	PASS,		CLIENT	},
+	{8,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{8,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by mkdir */
+	{9,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{9,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{9,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{9,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{9,	CMD_MKDIR,	0,			0,	PASS,		CLIENT	},
+	{9,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{9,	CMD_RMDIR,	0,			0,	PASS,		SERVER	},
+	{9,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* Get SIGIO when dir lease is broken by rmdir */
+	{10,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
+	{10,	CMD_MKDIR,	0,			0,	PASS,		SERVER	},
+	{10,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{10,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
+	{10,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
+	{10,	CMD_RMDIR,	0,			0,	PASS,		CLIENT	},
+	{10,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
+	{10,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
+
+	/* indicate end of array */
+	{0,0,0,0,0,SERVER},
+	{0,0,0,0,0,CLIENT}
+};
+
 static struct {
     int32_t		test;
     int32_t		command;
@@ -763,9 +914,14 @@ again:
 
 void release_lease(int fd)
 {
+	struct delegation deleg = { .d_type = F_UNLCK };
 	int rc;
 
-	rc = fcntl(fd, F_SETLEASE, F_UNLCK);
+	if (lease_is_deleg)
+		rc = fcntl(fd, F_SETDELEG, &deleg);
+	else
+		rc = fcntl(fd, F_SETLEASE, F_UNLCK);
+
 	if (rc != 0)
 		fprintf(stderr, "%s Failed to remove lease %d : %d %s\n",
 			__FILE__, rc, errno, strerror(errno));
@@ -826,9 +982,39 @@ int do_wait_sigio(int32_t time)
     return (got_sigio ? PASS: FAIL);
 }
 
+int create_directory(void)
+{
+	int ret;
+	struct stat st;
+
+	ret = mkdir(filename, 0777);
+	if (ret == 0)
+		return PASS;
+
+	if (errno != EEXIST) {
+		perror("directory create");
+		return FAIL;
+	}
+
+	ret = stat(filename, &st);
+	if (ret < 0) {
+		perror("stat");
+		return FAIL;
+	}
+
+	if (S_ISDIR(st.st_mode))
+		return PASS;
+
+	fprintf(stderr, "%s is not a directory\n", filename);
+	return FAIL;
+}
+
 int do_open(int flag)
 {
-    int flags = flag|O_CREAT|O_BINARY;
+    int flags = flag;
+
+    if (!(flag & O_DIRECTORY))
+	flags |= O_CREAT;
 
     if(debug > 1)
 	fprintf(stderr, "do_open %s 0x%x\n", filename, flags);
@@ -841,6 +1027,103 @@ int do_open(int flag)
     return PASS;
 }
 
+int do_create(int idx)
+{
+	int fd;
+
+	fd = openat(f_fd, child[idx], O_WRONLY|O_CREAT, 0666);
+	if (fd < 0) {
+		perror("openat");
+		return FAIL;
+	}
+	close(fd);
+	return PASS;
+}
+
+int do_unlink(int idx)
+{
+	int ret;
+
+	ret = unlinkat(f_fd, child[idx], 0);
+	if (ret < 0) {
+		perror("unlink");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_rename(int old, int new)
+{
+	int ret;
+
+	ret = renameat(f_fd, child[old], f_fd, child[new]);
+	if (ret < 0) {
+		perror("rename");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_symlink(int path, int target)
+{
+	int ret;
+
+	ret = symlinkat(child[target], f_fd, child[path]);
+	if (ret < 0) {
+		perror("symlink");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_mknod(int idx)
+{
+	int ret;
+
+	ret = mknodat(f_fd, child[idx], S_IFREG, 0);
+	if (ret < 0) {
+		perror("mknod");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_mkdir(int idx)
+{
+	int ret;
+
+	ret = mkdirat(f_fd, child[idx], 0777);
+	if (ret < 0) {
+		perror("mkdir");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_rmdir(int idx)
+{
+	int ret;
+
+	ret = unlinkat(f_fd, child[idx], AT_REMOVEDIR);
+	if (ret < 0) {
+		perror("mkdir");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_chmod(int mode)
+{
+	int ret;
+
+	ret = chmod(filename, mode);
+	if (ret < 0) {
+		perror("chmod");
+		return FAIL;
+	}
+	return PASS;
+}
+
 static int do_lock(int cmd, int type, int start, int length)
 {
     int ret;
@@ -884,6 +1167,7 @@ static int do_lease(int cmd, int arg, int expected)
 
     errno = 0;
 
+    lease_is_deleg = 0;
     ret = fcntl(f_fd, cmd, arg);
     saved_errno = errno;
 
@@ -897,6 +1181,37 @@ static int do_lease(int cmd, int arg, int expected)
     return(ret==0?PASS:FAIL);
 }
 
+static int do_deleg(int cmd, unsigned short arg, int expected)
+{
+    struct delegation deleg = { .d_type = arg };
+    int ret;
+
+    if(debug > 1)
+	fprintf(stderr, "do_deleg: cmd=%d arg=%d exp=%X\n",
+		cmd, arg, expected);
+
+    if (f_fd < 0)
+	return f_fd;
+
+    errno = 0;
+
+    lease_is_deleg = 1;
+    ret = fcntl(f_fd, cmd, &deleg);
+    saved_errno = errno;
+
+    if (cmd == F_GETDELEG && ret == 0)
+	    ret = deleg.d_type;
+
+    if (expected && (expected == ret))
+	    ret = 0;
+
+    if(ret)
+	fprintf(stderr, "%s do_deleg: ret = %d, errno = %d (%s)\n",
+		__FILE__, ret, errno, strerror(errno));
+
+    return(ret==0?PASS:FAIL);
+}
+
 int do_close(void)
 {	
     if(debug > 1) {
@@ -1020,6 +1335,7 @@ main(int argc, char *argv[])
 {
     int		i, sts;
     int		c;
+    int		openflags;
     struct sockaddr_in	myAddr;
     struct linger	noLinger = {1, 0};
     char	*host = NULL;
@@ -1030,6 +1346,7 @@ main(int argc, char *argv[])
     extern int	optind;
     int fail_count = 0;
     int run_leases = 0;
+    int run_dirdelegs = 0;
     int test_setlease = 0;
     
     atexit(cleanup);
@@ -1043,13 +1360,17 @@ main(int argc, char *argv[])
 	    prog = p+1;
     }
 
-    while ((c = getopt(argc, argv, "dLn:h:p:t?")) != EOF) {
+    while ((c = getopt(argc, argv, "dDLn:h:p:t?")) != EOF) {
 	switch (c) {
 
 	case 'd':	/* debug flag */
 	    debug++;
 	    break;
 
+	case 'D':
+	    run_dirdelegs = 1;
+	    break;
+
 	case 'L':	/* Lease testing */
 	    run_leases = 1;
 	    break;
@@ -1090,13 +1411,29 @@ main(int argc, char *argv[])
     }
 
     filename=argv[optind];
+
+    if (run_dirdelegs && create_directory() == FAIL)
+	    exit(1);
+
     if (debug)
 	fprintf(stderr, "Working on file : %s\n", filename);
-    if (do_open(O_RDWR) == FAIL)
+
+    if (run_dirdelegs) {
+	openflags = O_RDONLY | O_DIRECTORY;
+    } else {
+	openflags = O_RDWR;
+    }
+
+    if (do_open(openflags) == FAIL)
 	exit(1);
 
     if (test_setlease == 1) {
-	fcntl(f_fd, F_SETLEASE, F_UNLCK);
+	struct delegation deleg = { .d_type = F_UNLCK };
+
+	if (run_dirdelegs)
+		fcntl(f_fd, F_SETDELEG, &deleg);
+	else
+		fcntl(f_fd, F_SETLEASE, F_UNLCK);
 	saved_errno = errno;
 	close(f_fd);
 	exit(saved_errno);
@@ -1220,7 +1557,7 @@ main(int argc, char *argv[])
 	SRAND(6789L);
     }
 
-    if (server)
+    if (server && !run_dirdelegs)
 	/* only server need do shared file */
 	initialize(f_fd);
 
@@ -1229,7 +1566,9 @@ main(int argc, char *argv[])
      *
      * real work is in here ...
      */
-    if (run_leases)
+    if (run_dirdelegs)
+	fail_count = run(dirdeleg_tests, dirdeleg_descriptions);
+    else if (run_leases)
 	fail_count = run(lease_tests, lease_descriptions);
     else
 	fail_count = run(lock_tests, lock_descriptions);
@@ -1304,6 +1643,36 @@ int run(int64_t tests[][6], char *descriptions[])
 			case CMD_TRUNCATE:
 			    result = do_truncate(tests[index][OFFSET]);
 			    break;
+			case CMD_SETDELEG:
+			    result = do_deleg(F_SETDELEG, tests[index][ARG], 0);
+			    break;
+			case CMD_GETDELEG:
+			    result = do_deleg(F_GETDELEG, tests[index][ARG], tests[index][ARG]);
+			    break;
+			case CMD_CREATE:
+			    result = do_create(tests[index][ARG]);
+			    break;
+			case CMD_UNLINK:
+			    result = do_unlink(tests[index][ARG]);
+			    break;
+			case CMD_RENAME:
+			    result = do_rename(tests[index][ARG], tests[index][ARG2]);
+			    break;
+			case CMD_SYMLINK:
+			    result = do_symlink(tests[index][ARG], tests[index][ARG2]);
+			    break;
+			case CMD_MKNOD:
+			    result = do_mknod(tests[index][ARG]);
+			    break;
+			case CMD_CHMOD:
+			    result = do_chmod(tests[index][ARG]);
+			    break;
+			case CMD_MKDIR:
+			    result = do_mkdir(tests[index][ARG]);
+			    break;
+			case CMD_RMDIR:
+			    result = do_rmdir(tests[index][ARG]);
+			    break;
 		    }
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
@@ -1418,6 +1787,36 @@ int run(int64_t tests[][6], char *descriptions[])
 		case CMD_TRUNCATE:
 		    result = do_truncate(ctl.offset);
 		    break;
+		case CMD_SETDELEG:
+		    result = do_deleg(F_SETDELEG, ctl.offset, 0);
+		    break;
+		case CMD_GETDELEG:
+		    result = do_deleg(F_GETDELEG, ctl.offset, ctl.offset);
+		    break;
+		case CMD_CREATE:
+		    result = do_create(ctl.offset);
+		    break;
+		case CMD_UNLINK:
+		    result = do_unlink(ctl.offset);
+		    break;
+		case CMD_RENAME:
+		    result = do_rename(ctl.offset, ctl.length);
+		    break;
+		case CMD_SYMLINK:
+		    result = do_symlink(ctl.offset, ctl.length);
+		    break;
+		case CMD_MKNOD:
+		    result = do_mknod(ctl.offset);
+		    break;
+		case CMD_CHMOD:
+		    result = do_chmod(ctl.offset);
+		    break;
+		case CMD_MKDIR:
+		    result = do_mkdir(ctl.offset);
+		    break;
+		case CMD_RMDIR:
+		    result = do_rmdir(ctl.offset);
+		    break;
 	    }
 	    if( result != ctl.result ) {
 		fprintf(stderr,"Failure in %d:%s\n",
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 0000000000000000000000000000000000000000..1392e98c937d65d2d6402f1eb5822f22bc265342
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,22 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
+#
+# FSQA Test No. XXX
+#
+# lease test
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+. ./common/locktest
+
+_require_test
+_require_test_fcntl_advisory_locks
+_require_test_fcntl_setdeleg
+
+_run_dirleasetest
+
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 0000000000000000000000000000000000000000..c2a252d46cdcd730cf1ed2c503fa9631e9fcdd06
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+success!

-- 
2.51.1


