Return-Path: <linux-fsdevel+bounces-48559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CCAB10AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8461C26418
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6529187C;
	Fri,  9 May 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS0nppIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33428F520;
	Fri,  9 May 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786387; cv=none; b=OyGksnzZ8xRZMuyByP26YRAs9GLFl1sn0j6Vo1kPrKT0vnCjnqhDSmPW+VuF3rZw2RUEOXPx8LbS30KGkw7PBnqPpgPQJnzjZdNeM4Lt1LKv6FTqHj7w+9vlQiSE68hjDwDRwzCpzXn+dHJt3G6258ggQFoTUMB/g9QNpLDu0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786387; c=relaxed/simple;
	bh=XtYAn9qxMv6rK3q0zBvwCKauIZoqUJCYXQhXC/1IcFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRgl/Q5SfzBF0kOpz5fT4GLfldDjR7WiGyuCvy+jP9Vl2PcaHXcjq2XD1E+sttdJSjInG21mPdHLR4t/hQZJIcrqnLkmlcs3hNe/F2oe1Y8jmKxt/TIWSavAWkcpEXZC5YVIlLu9L9fE098aYsish8KbCP2GWoiAtuWZzO+Gzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS0nppIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE512C4CEE9;
	Fri,  9 May 2025 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786387;
	bh=XtYAn9qxMv6rK3q0zBvwCKauIZoqUJCYXQhXC/1IcFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nS0nppImxSVITjGKUFHL/HFCSEU2yLsr7sPnSCzwevQeL3IESIxm1XdI3Ra0p7hfG
	 9cZhKns1Q5Ca4BinkAkD9cPZOMzuPPffkJFTiUN6qvUx+pUA+5NpdHaRN8WbioH0nU
	 OlBUFBahfc6A2n5zF/ZOMSmEH91hqD1bR5gGm/6Thx4cUC+2mShiooJ+4eClKcs3fv
	 zQOlV15CT9xZrDUgL8BL+0L4ArJaxUwprD+JEXyw1no3WG82ovnhpBmzVqEOM3LtZw
	 a9bgqI5sUvTiIJgNQjp0bYEeShxUme32Ux6F7/jnMpX/RTtoEE368IGe8lIc5dCbAC
	 Q56slUqnLfRyg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 May 2025 12:25:39 +0200
Subject: [PATCH v5 7/9] coredump: validate socket name as it is written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-work-coredump-socket-v5-7-23c5b14df1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XtYAn9qxMv6rK3q0zBvwCKauIZoqUJCYXQhXC/1IcFM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tBqXzpXddNFvjkbaotuaTbIzJm9NOTg4tKVj5jzR
 JS3ssdv7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI4wJGhsPTFqw8fmJ5Aue3
 N71Wov3Op296p13jl14418VXts9Ik4fhn6HAy+TrSnN3WV25+rGY8+nqX6+/+F//YeZXpvlkclr
 JVkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In contrast to other parameters written into
/proc/sys/kernel/core_pattern that never fail we can validate enabling
the new AF_UNIX support. This is obviously racy as hell but it's always
been that way.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index fa50a681b225..19e776769b21 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1254,10 +1254,21 @@ void validate_coredump_safety(void)
 static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int error = proc_dostring(table, write, buffer, lenp, ppos);
+	int error;
+	ssize_t retval;
+	char old_core_pattern[CORENAME_MAX_SIZE];
 
-	if (!error)
-		validate_coredump_safety();
+	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
+
+	error = proc_dostring(table, write, buffer, lenp, ppos);
+	if (error)
+		return error;
+	if (core_pattern[0] == '@' && strcmp(core_pattern, "@linuxafsk/coredump.socket")) {
+		strscpy(core_pattern, old_core_pattern, retval + 1);
+		return -EINVAL;
+	}
+
+	validate_coredump_safety();
 	return error;
 }
 

-- 
2.47.2


