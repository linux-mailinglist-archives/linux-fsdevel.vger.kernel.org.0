Return-Path: <linux-fsdevel+bounces-33298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74119B6DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 21:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E19328185F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 20:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8421730A;
	Wed, 30 Oct 2024 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="mPikVvjp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjSz8CwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62E215005;
	Wed, 30 Oct 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320710; cv=none; b=crRp1Nbnn7tuwJXPIj060N/UB7mGlJkxJ4ahCl761cd1bM0H6SSUtQllSMCO0ZuGuGuhFLXTl28tVJE3mDguUoqIClJbSfh+AJMTzvunFtS8cJ7hk0HhKgtArU5DTe+9xvyRBqFLZRsNhu7U6zq7dU6pPzrGJScX6GulotZgPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320710; c=relaxed/simple;
	bh=qJC5bmo2TZwtOLDTxtUGWYWo3+SWCxPuOFuCU4846j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StgySZUaXL4f5hHNku/FQ0jd9jLmVtMFBOM5XZaVk6VjQ0bJ0H5AL8sh4a8msCH3Ufc7PgRyYxsmqkr07EtJT52P0kEx+51chJkuH/0x2QW7rUeDaZb85py1JHXS32Q+Y+UjDT5OMH2yXfzMCWjmUPKEKmJUfj+nwvsoE7gidzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=mPikVvjp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjSz8CwY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C97D25400FD;
	Wed, 30 Oct 2024 16:38:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 30 Oct 2024 16:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730320707; x=
	1730407107; bh=0r+XHUZuZsMcFUus8OxUh/faPdt2sC3qEYpfg2ntVAY=; b=m
	PikVvjpOOulDgJtt8fgJTv9y0iR5xoLilAgtN6rIt4VVviX/+ngC9myYslvm/doh
	BJvXJFkgmvCETTLYEODn7SulKFV7FWMcl8JO1FCtZbP01LrCQ/SDZAwk4g8QW8Bk
	sQAJBim33GWyg/irw9rXQ0TyWQ1WIJo/JRPUM5BwqR/fbokPszgZ+aUPyuNRuATc
	fC34fYM5q6EFIttJlGQjWSptyN7mkfS07nxTfpNqAdayUt8UyFMPFlAOZXW+GWG9
	mHlzbYvCAC+zthlVkg6Oc/b+2mXYeNX+Tzy83saT7TyYnV4KQuT/NrVB/7yjtFDK
	3FpBnzmiCACXWZnL4g87w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730320707; x=1730407107; bh=0
	r+XHUZuZsMcFUus8OxUh/faPdt2sC3qEYpfg2ntVAY=; b=UjSz8CwY2Ltr8JVOc
	KvByOmqULkJtsP4Om3hiYbwJ0nDqXUcNidrQg0YsM5ueB6BfceukpCsorVRBGao2
	uLJX0YKuwALEvDBPlISSHXKc5oK8lF1VdU6h1xazpDP5ecLxI2jTf0hQC6XqlN/4
	QXizqbm4iwoWxYOtl4Hx0H8OfRbL6ot6DkTpxxGcVPJIN3GquoiJZnQVqnvZhSpH
	4+hi/wqYD0v6422jQ5dgF6AoZVKLLgroXcfeOtUq1YnhMkaZJTt0ww4XVzA9baec
	oAUmm3fbbc/0J8dXidWmfjmNAf84Zh/E3817Ze4CaRfnvPd3c7RJmOicLI7zyLQ1
	IUPJw==
X-ME-Sender: <xms:QpkiZ_ZG2COgeJADxAodu8lWWkkhOmoL_SsAjLn2UL6MmGb4zgI5xw>
    <xme:QpkiZ-ZWlZnoFBvh1B5NMx6BqVfesPNOyjvkSxuZGtmr_ehR0nyxRKLAUMIJJuOun
    iM2NOmyzDew2CISLdE>
X-ME-Received: <xmr:QpkiZx_8EBht8xq_d1tY1NwKkiNk4XkgM8LYnFuxiVTiX4Sej3EQi-fpJC83JLTIu2Qn7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhord
    hpihiiiigrqeenucggtffrrghtthgvrhhnpefhvefhvddvffeufffgffejheelffeffeff
    ueehgeevvdeggfeufeekudeikefgleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghh
    ohesthihtghhohdrphhiiiiirgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
    pdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    grtghksehsuhhsvgdrtgiipdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihho
    nhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeii
    sgihshiivghksehinhdrfigrfidrphhlpdhrtghpthhtoheptgihphhhrghrsegthihphh
    grrhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QpkiZ1qfNhWdK5gPqH1nFSWr5a-fa6yeEOwdfA9F8yUx_7TmVKjXaQ>
    <xmx:QpkiZ6p5qEpOo4OHTM9-BZ4qrZ1ZCVoehdlHC7vqf_3O-_S0ERJ0Tw>
    <xmx:QpkiZ7QlqTwOS2jzHHi0Lk9sqYNcjAQZSfThMu1J7De1_U16dBa2rw>
    <xmx:QpkiZypXchgZ4zFsXjBSE7xgI-dSnmdLwqQNmFT0Ta0NP6Mto8YpQg>
    <xmx:Q5kiZ1Cdqrs0yan2ctnJtztcdPLvyrgYBwXGcFyWtxuutNcexreBBCKe>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 16:38:24 -0400 (EDT)
From: Tycho Andersen <tycho@tycho.pizza>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH 2/2] selftests/exec: add a test for execveat()'s comm
Date: Wed, 30 Oct 2024 14:37:32 -0600
Message-Id: <20241030203732.248767-2-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030203732.248767-1-tycho@tycho.pizza>
References: <20241030203732.248767-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

In the previous patch we've defined a couple behaviors:

1. execveat(fd, AT_EMPTY_PATH, {"foo"}, ...) should render argv[0] as
   /proc/pid/comm
2. execveat(fd, AT_EMPTY_PATH, {NULL}, ...) should keep the old behavior of
   rendering the fd as /proc/pid/comm

and just to be sure keeps working with symlinks, which was a concern in
[1], I've added a test for that as well.

The test itself is a bit ugly, because the existing check_execveat_fail()
helpers use a hardcoded envp and argv, and we want to "pass" things via the
environment to test various argument values, but it seemed cleaner than
passing one in everywhere in all the existing tests.

Output looks like:

    ok 51 Check success of execveat(6, 'home/tycho/packages/...yyyyyyyyyyyyyyyyyyyy', 0)...
    # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
    ok 52 Check success of execveat(9, '', 4096)...
    # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
    ok 53 Check success of execveat(11, '', 4096)...
    # Check execveat(AT_EMPTY_PATH)'s comm is 9
    [   25.579272] process 'execveat' launched '/dev/fd/9' with NULL argv: empty string added
    ok 54 Check success of execveat(9, '', 4096)...

[1]: https://lore.kernel.org/all/20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com/
Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
v4: fix up commit message, use ksft_perror() vs perror(), Shuah
---
 tools/testing/selftests/exec/execveat.c | 77 ++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 071e03532cba..3a05f8cbd815 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -23,9 +23,11 @@
 
 #include "../kselftest.h"
 
-#define TESTS_EXPECTED 51
+#define TESTS_EXPECTED 54
 #define TEST_NAME_LEN (PATH_MAX * 4)
 
+#define CHECK_COMM "CHECK_COMM"
+
 static char longpath[2 * PATH_MAX] = "";
 static char *envp[] = { "IN_TEST=yes", NULL, NULL };
 static char *argv[] = { "execveat", "99", NULL };
@@ -237,12 +239,36 @@ static int check_execveat_pathmax(int root_dfd, const char *src, int is_script)
 	return fail;
 }
 
+static int check_execveat_comm(int fd, char *argv0, char *expected)
+{
+	char buf[128], *old_env, *old_argv0;
+	int ret;
+
+	snprintf(buf, sizeof(buf), CHECK_COMM "=%s", expected);
+
+	old_env = envp[1];
+	envp[1] = buf;
+
+	old_argv0 = argv[0];
+	argv[0] = argv0;
+
+	ksft_print_msg("Check execveat(AT_EMPTY_PATH)'s comm is %s\n",
+		       expected);
+	ret = check_execveat_invoked_rc(fd, "", AT_EMPTY_PATH, 0, 0);
+
+	envp[1] = old_env;
+	argv[0] = old_argv0;
+
+	return ret;
+}
+
 static int run_tests(void)
 {
 	int fail = 0;
 	char *fullname = realpath("execveat", NULL);
 	char *fullname_script = realpath("script", NULL);
 	char *fullname_symlink = concat(fullname, ".symlink");
+	char fd_buf[10];
 	int subdir_dfd = open_or_die("subdir", O_DIRECTORY|O_RDONLY);
 	int subdir_dfd_ephemeral = open_or_die("subdir.ephemeral",
 					       O_DIRECTORY|O_RDONLY);
@@ -389,6 +415,15 @@ static int run_tests(void)
 
 	fail += check_execveat_pathmax(root_dfd, "execveat", 0);
 	fail += check_execveat_pathmax(root_dfd, "script", 1);
+
+	/* /proc/pid/comm gives argv[0] by default */
+	fail += check_execveat_comm(fd, "sentinel", "sentinel");
+	/* /proc/pid/comm gives argv[0] when invoked via link */
+	fail += check_execveat_comm(fd_symlink, "sentinel", "sentinel");
+	/* /proc/pid/comm gives fdno if NULL is passed */
+	snprintf(fd_buf, sizeof(fd_buf), "%d", fd);
+	fail += check_execveat_comm(fd, NULL, fd_buf);
+
 	return fail;
 }
 
@@ -415,9 +450,13 @@ int main(int argc, char **argv)
 	int ii;
 	int rc;
 	const char *verbose = getenv("VERBOSE");
+	const char *check_comm = getenv(CHECK_COMM);
 
-	if (argc >= 2) {
-		/* If we are invoked with an argument, don't run tests. */
+	if (argc >= 2 || check_comm) {
+		/*
+		 * If we are invoked with an argument, or no arguments but a
+		 * command to check, don't run tests.
+		 */
 		const char *in_test = getenv("IN_TEST");
 
 		if (verbose) {
@@ -426,6 +465,38 @@ int main(int argc, char **argv)
 				ksft_print_msg("\t[%d]='%s\n'", ii, argv[ii]);
 		}
 
+		/* If the tests wanted us to check the command, do so. */
+		if (check_comm) {
+			/* TASK_COMM_LEN == 16 */
+			char buf[32];
+			int fd, ret;
+
+			fd = open("/proc/self/comm", O_RDONLY);
+			if (fd < 0) {
+				ksft_perror("open() comm failed");
+				exit(1);
+			}
+
+			ret = read(fd, buf, sizeof(buf));
+			if (ret < 0) {
+				ksft_perror("read() comm failed");
+				close(fd);
+				exit(1);
+			}
+			close(fd);
+
+			// trim off the \n
+			buf[ret-1] = 0;
+
+			if (strcmp(buf, check_comm)) {
+				ksft_print_msg("bad comm, got: %s expected: %s",
+					       buf, check_comm);
+				exit(1);
+			}
+
+			exit(0);
+		}
+
 		/* Check expected environment transferred. */
 		if (!in_test || strcmp(in_test, "yes") != 0) {
 			ksft_print_msg("no IN_TEST=yes in env\n");
-- 
2.34.1


