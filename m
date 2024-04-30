Return-Path: <linux-fsdevel+bounces-18293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E08B691E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F611F21F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A9111A2;
	Tue, 30 Apr 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLppyDyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176510A1D;
	Tue, 30 Apr 2024 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448432; cv=none; b=t1CyNwDkyowVDJNINt3wtvjIqIpDx5APsPsCZOoVYQEHoeiBbCnzkvR5ooxlZfE+TaanI8V29Y3yZ8m9Bz5yHo0aF+s++V/fd/WvTy+NJKahRnyP4FW708aOx8gW0z71MJNB2kKWI3uRH+AAyPZAp1EQkXfTZnFn1DEyV1QLDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448432; c=relaxed/simple;
	bh=FqpOy3OpxfeJJgGwxXoDU0/j2emkdd9a+CGm9UtME5I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJ5r71FzaOrEpcU50r68F+l+Kha2mpWw2eNSiAGG9k6e2ANg7iUiCMkZeV+/7vsyZgvQsGSsMx2qeLhCidQ8VEDMnVqTUtZUOE1hFIFzR52gE2AnT9qur4I8IThuZ5i2YnViwdOEigsCziramYxYQUZIyOHdRQG6p9BJXkBw7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLppyDyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A986FC116B1;
	Tue, 30 Apr 2024 03:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448432;
	bh=FqpOy3OpxfeJJgGwxXoDU0/j2emkdd9a+CGm9UtME5I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jLppyDyKbOeXNbVnYuR8H1pMPDhqiM4w9+fzqSEEmG+r9RHzv/wf+EPcd+TrctpzS
	 PvZ3v8vpG6W/9m4hjSl4g2rpwlhHD/se3HnNdxLFfFFlXAa4UApi8/wJBky4cTgZXy
	 PPNbrFmuBqxz73+FwTSTePPY/9zn+Mh0fUU5Gj6LdPp8Z7mb/aanthxCMVap35Cy3L
	 FEawoQ1QBKPXenMH49NiolWAvbmBKWe62cYsti/zl/zZ4hJHmqwXd7OVx45Nvp/CbO
	 rZagono654G7ccZwDZrZqwVvdBSdHUFZCppZOKhM4of08P5dE3H+aoZ879BBE7p4d6
	 fZRg90M2w2FQQ==
Date: Mon, 29 Apr 2024 20:40:32 -0700
Subject: [PATCH 37/38] xfs_io: create magic command to disable verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683675.960383.13899048413901232465.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a secret command to turn off fsverity if we need to.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 io/scrub.c        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 man/man8/xfs_io.8 |    3 +++
 2 files changed, 50 insertions(+)


diff --git a/io/scrub.c b/io/scrub.c
index dc40afdfb36f..8a4a7e2fc3af 100644
--- a/io/scrub.c
+++ b/io/scrub.c
@@ -19,6 +19,7 @@
 static struct cmdinfo scrub_cmd;
 static struct cmdinfo repair_cmd;
 static const struct cmdinfo scrubv_cmd;
+static const struct cmdinfo noverity_cmd;
 
 static void
 scrub_help(void)
@@ -356,6 +357,7 @@ scrub_init(void)
 
 	add_command(&scrub_cmd);
 	add_command(&scrubv_cmd);
+	add_command(&noverity_cmd);
 }
 
 static void
@@ -730,3 +732,48 @@ static const struct cmdinfo scrubv_cmd = {
 	.oneline	= N_("vectored metadata scrub"),
 	.help		= scrubv_help,
 };
+
+static void
+noverity_help(void)
+{
+	printf(_(
+"\n"
+" Disable fsverity on a file.\n"));
+}
+
+#ifndef FS_IOC_DISABLE_VERITY
+# define FS_IOC_DISABLE_VERITY _IO('f', 136)
+#endif
+
+static int
+noverity_f(
+	int		argc,
+	char		**argv)
+{
+	int		c;
+	int		error;
+
+	while ((c = getopt(argc, argv, "")) != EOF) {
+		switch (c) {
+		default:
+			noverity_help();
+			return 0;
+		}
+	}
+
+	error = ioctl(file->fd, FS_IOC_DISABLE_VERITY);
+	if (error)
+		perror("noverity");
+
+	return 0;
+}
+
+static const struct cmdinfo noverity_cmd = {
+	.name		= "noverity",
+	.cfunc		= noverity_f,
+	.argmin		= -1,
+	.argmax		= -1,
+	.flags		= CMD_NOMAP_OK,
+	.oneline	= N_("disable fsverity"),
+	.help		= noverity_help,
+};
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index 4991ad471bd7..013750faa113 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -1093,6 +1093,9 @@ Check parameters without changing anything.
 Do not print timing information at all.
 .PD
 .RE
+.TP
+.B noverity
+Disable fs-verity on this file.
 
 .SH MEMORY MAPPED I/O COMMANDS
 .TP


