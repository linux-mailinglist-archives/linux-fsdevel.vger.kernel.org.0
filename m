Return-Path: <linux-fsdevel+bounces-70568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB76C9F974
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DCFA30052CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76523191CA;
	Wed,  3 Dec 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeJEksz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F111317706;
	Wed,  3 Dec 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776607; cv=none; b=BcImtwnhXKYIm9SPZEp17bGpCmPt5dfqemVdwbrShe8brTqn4qA/8+dwX9vdePz0CP/fwl5INYNnjx4TRcBlPFQRu9aR+ccAuJ+NEwKjor5ZavjdGnQpAtJQXFSD0E1aOcex4XBuiCpL3t0lrWj2uYhE7bH0KoFd3OwxpPwvUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776607; c=relaxed/simple;
	bh=+OTzyRXwiLvIrWwlon4BEbFksQlQ2zkRfT5ZmRH3HvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fm2/+gyG3ISLRQWxGpTFIy+9ic4+c8i15dKTcRqcQcC/S/fFrwADvdMkCPsy9o6wvS9QH90ZwDRbGNSgAoQ8fSL2sT/ACGNOA3n8M0CVOlN0GE6mJ4tPLMMubYH893td74sLTJjjVi2u2wprw8PVHJIgJqWLTMPcRXAod5dsblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeJEksz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924DAC116C6;
	Wed,  3 Dec 2025 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764776607;
	bh=+OTzyRXwiLvIrWwlon4BEbFksQlQ2zkRfT5ZmRH3HvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KeJEksz/dBTLTg8ky97REA77h1RfNF23I6H3NK9p6l0DlvyPxqWP1/cvQuvrKzB+p
	 d3hpnfapibze0FxAZp+FINpPyXmAErdh5QKU5hlqWhyUR01yTzsbgOqj1ep4VkElC4
	 C/rGkAdYMqOoTZPz6pIMjVScUu8eAyCZ/SciuoMGJPmnZPaWMQwcZpn1jnvyvfyh9x
	 glIfGfghKKexXDLiDf+izY2FnNPAKqA0jW0+oz9lx6zMVvLOO0EnZezdtkym7Fedjb
	 oqWz2rIWaJjILeZ6nUYWkKJD05HXvz3n4p6lVlQ0F3M0nX/FWmvTgZaJRSheh+CGMd
	 F3GjXKDKa/5Cw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 03 Dec 2025 10:43:09 -0500
Subject: [PATCH fstests v3 3/3] generic: add tests for file delegations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
In-Reply-To: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11336; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+OTzyRXwiLvIrWwlon4BEbFksQlQ2zkRfT5ZmRH3HvA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMFqcJgP6RtXdrGzPEQpT+Vsbk4av8itQ5QZGt
 o7vLTLSpvWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTBanAAKCRAADmhBGVaC
 Fc/fD/4/30ze3Kty5gVlIc9gq4wW0ctbYtmoqt1ydXfinXm4zVaSaeEYWI7s1/Z/LkxFRkPZFp8
 gf9KBGhmw+pSPLuIB/LNewas2yg5J1MlZpGSqMd3MNV+N3SquQByOhc8i5RqD06tKDIlrmZmw7/
 DhpOZcZ7exuSFEfvX8axuBaUWmJAIy2K6a7YZ5XeoxYd1N/dAbeTpMXDTL+fnf+ga+JPNlD2+FK
 1kLdNQZWJDscDXrxqt70I7QxjlwHrkTk/XbXjl4cDVGqADu3y7TKAuyKfSZ/p0dT8ZEjYx4Z/kI
 tBA00gsGObH16zSBiY+6Le4gdN7z2rV+CEOYASY97KJxZRUxGr4oNjCzII+3wZMR4xQ3oQJAad/
 g/4+HIDIbnEOKJOI3V+v3OXhmXm0xHzDnvpCJRqi+gTYLgOaGPR49YJZLpYDXiMYTNfXzZbJLOd
 qCpQ7dErPfkvoESPR3knaD41WdRmOQu+gVaNoz83GLhcz7MaeSFI8I8ci8hD6coCe+BG00bbq/O
 wDW8QIrP4I5GgEOV2yA2gpunuMhwaZdB6jSX+V3V6Ti/HpaKv5zWV9xyZ2uvldebyJU45BgvqN4
 2s22R0DOSxIruOakljSWfRhK5NQ9wR0cj7ICnrjr7+PGnANhovI9OrxCqVI6a7wwp0QojOdZqFA
 on6oFFIoOBzrkUg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Mostly the same ones as leases, but some additional tests to validate
that they are broken on metadata changes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/locktest       |   5 ++
 src/locktest.c        | 202 +++++++++++++++++++++++++++++++++++++++++++++++++-
 tests/generic/784     |  20 +++++
 tests/generic/784.out |   2 +
 4 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/common/locktest b/common/locktest
index 12b5c27e0c03ad4c60985e3882026fce04e7330e..9344c43d8ee97679b49357b4e75de89ad56221ff 100644
--- a/common/locktest
+++ b/common/locktest
@@ -101,3 +101,8 @@ _run_dirdelegtest() {
 	TESTFILE=$DELEGDIR
 	_run_generic "-D"
 }
+
+_run_filedelegtest() {
+	TESTFILE=$DELEGDIR
+	_run_generic "-F"
+}
diff --git a/src/locktest.c b/src/locktest.c
index eb40dce3f1b28ef34752518808ec2f3999cd4257..54ee1f07539ef08e768d2c809c40327f315d43e7 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -126,6 +126,8 @@ static char *child[] = { "child0", "child1" };
 #define		CMD_CHMOD	19
 #define		CMD_MKDIR	20
 #define		CMD_RMDIR	21
+#define		CMD_UNLINK_S	22
+#define		CMD_RENAME_S	23
 
 #define		PASS 	0
 #define		FAIL	1
@@ -169,6 +171,8 @@ static char *get_cmd_str(int cmd)
 		case CMD_CHMOD: return "Chmod"; break;
 		case CMD_MKDIR: return "Mkdir"; break;
 		case CMD_RMDIR: return "Rmdir"; break;
+		case CMD_UNLINK_S: return "Remove Self"; break;
+		case CMD_RENAME_S: return "Rename Self"; break;
 	}
 	return "unknown";
 }
@@ -716,6 +720,150 @@ static int64_t lease_tests[][6] =
 		{0,0,0,0,0,CLIENT}
 	};
 
+char *filedeleg_descriptions[] = {
+    /*  1 */"Take Read Deleg",
+    /*  2 */"Take Write Deleg",
+    /*  3 */"Fail Write Deleg if file is open somewhere else",
+    /*  4 */"Fail Read Deleg if opened with write permissions",
+    /*  5 */"Read deleg gets SIGIO on write open",
+    /*  6 */"Write deleg gets SIGIO on read open",
+    /*  7 */"Read deleg does _not_ get SIGIO on read open",
+    /*  8 */"Read deleg gets SIGIO on write open",
+    /*  9 */"Write deleg gets SIGIO on truncate",
+    /* 10 */"Read deleg gets SIGIO on truncate",
+    /* 11 */"Read deleg gets SIGIO on chmod",
+    /* 12 */"Read deleg gets SIGIO on unlink",
+    /* 13 */"Read deleg gets SIGIO on rename",
+};
+
+static int64_t filedeleg_tests[][6] =
+	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
+	/*			[sigio_wait_time]						*/
+	{
+	/* Various tests to exercise delegs */
+
+	/* SECTION 1: Simple verification of being able to take delegs */
+	/* Take Read Deleg */
+	{1,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+	{1,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+	{1,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{1,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+	{1,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{1,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{1,	CMD_SETDELEG,	F_UNLCK,	0,	PASS,		SERVER	},
+	{1,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{1,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Take Write Deleg */
+	{2,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+	{2,	CMD_SETDELEG,	F_WRLCK,	0,	PASS,		SERVER	},
+	{2,	CMD_GETDELEG,	F_WRLCK,	0,	PASS,		SERVER	},
+	{2,	CMD_SETDELEG,	F_UNLCK,	0,	PASS,		SERVER	},
+	{2,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	/* Fail Write Deleg with other users */
+	{3,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT  },
+	{3,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+	{3,	CMD_SETDELEG,	F_WRLCK,	0,	FAIL,		SERVER	},
+	{3,	CMD_GETDELEG,	F_WRLCK,	0,	FAIL,		SERVER	},
+	{3,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{3,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+	/* Fail Read Deleg if opened for write */
+	{4,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+	{4,	CMD_SETDELEG,	F_RDLCK,	0,	FAIL,		SERVER	},
+	{4,	CMD_GETDELEG,	F_RDLCK,	0,	FAIL,		SERVER	},
+	{4,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+
+	/* SECTION 2: Proper SIGIO notifications */
+	/* Get SIGIO when read deleg is broken by write */
+	{5,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+	{5,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{5,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{5,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+	{5,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+	{5,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+	{5,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{5,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when write deleg is broken by read */
+	{6,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
+	{6,	CMD_SETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
+	{6,	CMD_GETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
+	{6,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+	{6,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+	{6,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+	{6,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{6,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Don't get SIGIO when read deleg is taken by read */
+	{7,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+	{7,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{7,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{7,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+	{7,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+	{7,	CMD_WAIT_SIGIO,	5,		0,	FAIL,		CLIENT	},
+	{7,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{7,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Read deleg is broken by Write */
+	{8,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+	{8,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{8,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{8,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+	{8,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+	{8,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+	{8,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	{8,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Write deleg is broken by Truncate */
+	{9,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
+	{9,	CMD_SETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
+	{9,	CMD_GETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
+	{9,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+	{9,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		CLIENT	},
+	{9,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+	{9,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Read deleg is broken by Truncate */
+	{10,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+	{10,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{10,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
+	{10,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+	{10,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		SERVER	},
+	{10,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+	{10,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Read deleg is broken by Chmod */
+	{11,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+	{11,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{11,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{11,	CMD_SIGIO,	0,		0,	PASS,		SERVER	},
+	{11,	CMD_CHMOD,	0644,		0,	PASS,		CLIENT	},
+	{11,	CMD_WAIT_SIGIO,	5,		0,	PASS,		SERVER	},
+	{11,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+
+	/* Get SIGIO when file is unlinked */
+	{12,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+	{12,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{12,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{12,	CMD_SIGIO,	0,		0,	PASS,		SERVER	},
+	{12,	CMD_UNLINK_S,	0,		0,	PASS,		CLIENT	},
+	{12,	CMD_WAIT_SIGIO,	5,		0,	PASS,		SERVER	},
+	{12,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+
+	/* Get SIGIO when file is renamed */
+	{13,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+	{13,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{13,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
+	{13,	CMD_SIGIO,	0,		0,	PASS,		SERVER	},
+	{13,	CMD_RENAME_S,	0,		0,	PASS,		CLIENT	},
+	{13,	CMD_WAIT_SIGIO,	5,		0,	PASS,		SERVER	},
+	{13,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+
+	/* indicate end of array */
+	{0,0,0,0,0,SERVER},
+	{0,0,0,0,0,CLIENT}
+};
+
 char *dirdeleg_descriptions[] = {
     /*  1 */"Take Read Lease",
     /*  2 */"Write Lease Should Fail",
@@ -1124,6 +1272,37 @@ int do_chmod(int mode)
 	return PASS;
 }
 
+int do_unlink_self(void)
+{
+	int ret;
+
+	ret = unlink(filename);
+	if (ret < 0) {
+		perror("unlink");
+		return FAIL;
+	}
+	return PASS;
+}
+
+int do_rename_self(void)
+{
+	int ret;
+	char target[PATH_MAX];
+
+	ret = snprintf(target, sizeof(target), "%s2", filename);
+	if (ret >= sizeof(target)) {
+		perror("snprintf");
+		return FAIL;
+	}
+
+	ret = rename(filename, target);
+	if (ret < 0) {
+		perror("unlink");
+		return FAIL;
+	}
+	return PASS;
+}
+
 static int do_lock(int cmd, int type, int start, int length)
 {
     int ret;
@@ -1347,6 +1526,7 @@ main(int argc, char *argv[])
     int fail_count = 0;
     int run_leases = 0;
     int run_dirdelegs = 0;
+    int run_filedelegs = 0;
     int test_setlease = 0;
     
     atexit(cleanup);
@@ -1360,7 +1540,7 @@ main(int argc, char *argv[])
 	    prog = p+1;
     }
 
-    while ((c = getopt(argc, argv, "dDLn:h:p:t?")) != EOF) {
+    while ((c = getopt(argc, argv, "dDFLn:h:p:t?")) != EOF) {
 	switch (c) {
 
 	case 'd':	/* debug flag */
@@ -1371,6 +1551,10 @@ main(int argc, char *argv[])
 	    run_dirdelegs = 1;
 	    break;
 
+	case 'F':
+	    run_filedelegs = 1;
+	    break;
+
 	case 'L':	/* Lease testing */
 	    run_leases = 1;
 	    break;
@@ -1430,7 +1614,7 @@ main(int argc, char *argv[])
     if (test_setlease == 1) {
 	struct delegation deleg = { .d_type = F_UNLCK };
 
-	if (run_dirdelegs)
+	if (run_dirdelegs || run_filedelegs)
 		fcntl(f_fd, F_SETDELEG, &deleg);
 	else
 		fcntl(f_fd, F_SETLEASE, F_UNLCK);
@@ -1568,6 +1752,8 @@ main(int argc, char *argv[])
      */
     if (run_dirdelegs)
 	fail_count = run(dirdeleg_tests, dirdeleg_descriptions);
+    else if (run_filedelegs)
+	fail_count = run(filedeleg_tests, filedeleg_descriptions);
     else if (run_leases)
 	fail_count = run(lease_tests, lease_descriptions);
     else
@@ -1673,6 +1859,12 @@ int run(int64_t tests[][6], char *descriptions[])
 			case CMD_RMDIR:
 			    result = do_rmdir(tests[index][ARG]);
 			    break;
+			case CMD_UNLINK_S:
+			    result = do_unlink_self();
+			    break;
+			case CMD_RENAME_S:
+			    result = do_rename_self();
+			    break;
 		    }
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
@@ -1817,6 +2009,12 @@ int run(int64_t tests[][6], char *descriptions[])
 		case CMD_RMDIR:
 		    result = do_rmdir(ctl.offset);
 		    break;
+		case CMD_UNLINK_S:
+		    result = do_unlink_self();
+		    break;
+		case CMD_RENAME_S:
+		    result = do_rename_self();
+		    break;
 	    }
 	    if( result != ctl.result ) {
 		fprintf(stderr,"Failure in %d:%s\n",
diff --git a/tests/generic/784 b/tests/generic/784
new file mode 100755
index 0000000000000000000000000000000000000000..6c20bac9b7fb719af05afd507849213359f9ca0f
--- /dev/null
+++ b/tests/generic/784
@@ -0,0 +1,20 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Jeff Layton <jlayton@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 784
+#
+# Test file delegation support
+#
+. ./common/preamble
+_begin_fstest auto quick locks
+
+# Import common functions.
+. ./common/filter
+. ./common/locktest
+
+_require_test
+_require_test_fcntl_setdeleg
+
+_run_filedelegtest
+_exit 0
diff --git a/tests/generic/784.out b/tests/generic/784.out
new file mode 100644
index 0000000000000000000000000000000000000000..7b499e08fed85d0430ecad03c824f745cb42ec44
--- /dev/null
+++ b/tests/generic/784.out
@@ -0,0 +1,2 @@
+QA output created by 784
+success!

-- 
2.52.0


