Return-Path: <linux-fsdevel+bounces-48403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C319EAAE675
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01694188A24E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B928DEEF;
	Wed,  7 May 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7MJjfZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877E28C2A2;
	Wed,  7 May 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634458; cv=none; b=KS9GQCVyG0WxlJNONCF7wc2kqpLy/G7IZbsz/2P/x+7j3/orA750917PgUcXcPFXMDTAHaf7gaszPZzUH+gRiN2kGU6fgIcsOEdoDtFoWMqPeSN6ZFnMIle52V0sif/SqNyNWXqFAnfi0XpdQeIZPkafHchgxxoTHhNSEP8VDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634458; c=relaxed/simple;
	bh=6nqvwh3i7pYcCmLUo6yNb/a7vH5qP7uGXblBD1xyfls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDaBq7uqRnkoVBbYmuK7jubg4sZp5pHCQoPc2XH6w/7vO1Q9Py95w1saUNIabYf1fe7ilsFQ+oyLWWYHPcbKznIkCw/PCnJJN7FpJEcOqYB9ZgENTUHN/KJdT+bOOKDdGujb4Y6HqeYWf2eFNgKMPc68N8xAyIZzw+0r62oJhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7MJjfZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15883C4CEE9;
	Wed,  7 May 2025 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634458;
	bh=6nqvwh3i7pYcCmLUo6yNb/a7vH5qP7uGXblBD1xyfls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E7MJjfZj2G9psWsfoa0aPSW9JH5YpD7kwjtfcqAJ0StXJXGbDQnaHtbWd1MRrhlLT
	 r7lrLrOMyzvctTNYdF+MF6xGoms/IYvKA95I5hprvaHcCOLMWBdU+XZ3I8rqhzQUJO
	 4S+E4pEQuZaswwIP3fqrG4mZfJg3NiGBEAGOmJpmezAi6BIyQB7RgsRL9C8hc1RgBr
	 KCv6d8Ntcrn8IF8M7HwF2An1dECuICrH0x8Lo1Jgp74ll9XBgFY4sHuUs67TcCxIrl
	 j3aMEoTOLhP1W4T1wuYV6HrWfxzhT3ZDfxcAtEhFeKUj1P+pWCR3w7kzKXccGIjHOt
	 a32YsRAUKSlzw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:40 +0200
Subject: [PATCH v4 07/11] coredump: show supported coredump modes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-7-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
In-Reply-To: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
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
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6nqvwh3i7pYcCmLUo6yNb/a7vH5qP7uGXblBD1xyfls=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt21lecp9yPXGI9FQh/2GrRWHmZcrsQVol2mWcLs0r
 nVxNmztKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAjXK0aGM7eCgq+u/+AS8Uta
 Yc279EabJW+WFIuEL3vL5rDVQGbvQkaGl6rGkUsE87evevdKpuXIYj4pn0DtsMu7tY+ttOhZ6N/
 LAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow userspace to discover what coredump modes are supported.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0f00f77be988..e1e6f02e0ed7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1220,6 +1220,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 
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
@@ -1263,6 +1269,13 @@ static const struct ctl_table coredump_sysctls[] = {
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


