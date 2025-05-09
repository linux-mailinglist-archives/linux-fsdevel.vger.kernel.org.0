Return-Path: <linux-fsdevel+bounces-48558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F7AB10A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D7A3A8287
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941C28E59D;
	Fri,  9 May 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKhMlGzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF4290BDF;
	Fri,  9 May 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786383; cv=none; b=Jkpo9I9lbC59O0DZ7uV2V1BNkS65UouwDIJs59F3rzVIvq9Yh+CM4LhnXrVHTN4cNBHBts6Shq/Z5jpyll+NteB03i3dvXRnG7H2Bw558M1Go2XS3anx4KFD5rOWrCrmTvYaAfoVxS4qGGXQc8NB4GnBMEEsiawqsGDap3Ir8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786383; c=relaxed/simple;
	bh=5W5KUoJ3iZpfXplEUqQaQMHWFuiUtasGtEN3sJaZv/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caoaYSDbDjtIJKbtocd95LaOSrCmOU3M1MjEsiMKNtTVEJJvSvU+3IGjO2PPqbO28aNSEnQSQoqsUNnab0Sm+5d93cMJeXijGaX1MFyTw98Z8f0P/t/LkJIlgECI5LIZGPm/1xYaZTN2+bq8r1S2yr92WdrHdIx55dWeai5XxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKhMlGzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34A6C4CEF1;
	Fri,  9 May 2025 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786382;
	bh=5W5KUoJ3iZpfXplEUqQaQMHWFuiUtasGtEN3sJaZv/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZKhMlGzgabUo0uZsKxFb5iBOQf9xGb7dKhLz9WyS9EoIzJ2/0BoEvhzAHTxpEPiBw
	 TnPPdoA4N8uwke23kmMQRvAkk3RQbj2/yFOYFI0ZxYpFr0QX9BK2EgULPPLm3kQ9ih
	 SH4Xaz9NQuJqH1aIad6Kz5zekafeK2NhlVuxVq8sEvinSv1abLVp8LyTD8DXmZBrhc
	 teU1BLLL6pTIhGnl+6cRCNrR1N4ZpPlaqYTWCkOQ0wfHfJma8P2rLxqsdStmc51d2T
	 cMXPZVIqKc6htcGHg/wDXSBaVvMXm3De9hnBUqD9BcWg7UbsA35VBG2fSp26uRaYlU
	 lSRGeu/DjihRA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 May 2025 12:25:38 +0200
Subject: [PATCH v5 6/9] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-work-coredump-socket-v5-6-23c5b14df1bc@kernel.org>
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5W5KUoJ3iZpfXplEUqQaQMHWFuiUtasGtEN3sJaZv/s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tBSaOK8ZztrWXDmhOKTnRti57117/yy92L+/kT/s
 D0z3vl/6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI2zZGhvN/0sJXa5j3ndfd
 I7jyg3Dx0jxV1QMNl8rMtPlzJ/qcWMvIcH1ydpAgU+u7JdwxzvOnnd98lzWnT9txl4/+KY9O0W+
 buAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index ff42688ec9ac..fa50a681b225 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1263,6 +1263,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
 static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
 static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
+static char core_modes[] = {
+	"file\npipe"
+#ifdef CONFIG_UNIX
+	"\nlinuxafsk/coredump.socket"
+#endif
+};
 
 static const struct ctl_table coredump_sysctls[] = {
 	{
@@ -1306,6 +1312,13 @@ static const struct ctl_table coredump_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "core_modes",
+		.data		= core_modes,
+		.maxlen		= sizeof(core_modes) - 1,
+		.mode		= 0444,
+		.proc_handler	= proc_dostring,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)

-- 
2.47.2


