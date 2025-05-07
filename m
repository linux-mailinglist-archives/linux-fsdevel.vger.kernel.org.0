Return-Path: <linux-fsdevel+bounces-48402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E1AAE661
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD165250ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3228DB69;
	Wed,  7 May 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+kH5eYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB428DB5A;
	Wed,  7 May 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634453; cv=none; b=R7Hrj5ahkBh2sXSk/8HuYEfNW50Drn0qGChwR5pu8qxgaayYSdHPcgrR3/RPwzAHiJ+muRi4wWAKc1MVz99tGKX4IuueASQOHy6cpD+noZ9erEpvbP4wLwhdH1C6EzILFOhLYhh0f6bwvnBpWy7A0vMo/v+oiKF1c9l2vAeFLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634453; c=relaxed/simple;
	bh=zXr47MrQD+Vjun97zqt40Q7EjbQ2mE5MbGB6SQwusWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5NYp/p4JEGM1NgU4fQuWTSn2aOpjIyP8M5O1GquHuClhZDe9N8XM0uSchLwVTSl2NvRdDMrhzq6/Hanhin6e0sDNL5sYaQqkLhlMjYAzKZlEmQo9wCjJIyMBcDD+QhnVl7jQyRJFX0buwjE/dIo2xkD2b9o9D8JK9LZMY7LyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+kH5eYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B23C4CEF0;
	Wed,  7 May 2025 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634453;
	bh=zXr47MrQD+Vjun97zqt40Q7EjbQ2mE5MbGB6SQwusWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i+kH5eYem4nf1I3H3VgsaR4HySrOCoUzNfxThdOofk56Z1ASNkpmpQwkN+OoCUdEI
	 8YQcFnlFlRRAdMGGJlN32P4nD2KDJt71Gn6ExovEiCqrkUNdKiCgpt2W7LRwZSvJ7u
	 Xsppg0qGbkKGhDjl0J+i4pq/lE3b4a+gi5c2ektEqszXdZAJNdgOjb1GLOSZ7qvp+T
	 vTWaZ51rUdBMMw/cLFd7HwRjWq7m4AIAjh8BnDYHbagZvWj25bxptnVpUjkIOp3YIP
	 v9zOZU+K9onLOKMvfOiq5VyIqtRgGJkjXhXN+MfYpnO+yVy7TDChUOT7UazXPkHxxM
	 c5n8klxGGFTAw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:39 +0200
Subject: [PATCH v4 06/11] coredump: validate socket name as it is written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-6-af0ef317b2d0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zXr47MrQD+Vjun97zqt40Q7EjbQ2mE5MbGB6SQwusWw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt219u/fdS+9ViW8m/szMu/BOKPT1TJeiNY+y14rdm
 ZCWtJK9sKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiiZUM/1M4FqwzMDG9JrLb
 3Iztz2TbZQatX/RmL+V24z4fK7xu/XuGf9asZ8UXzj+cmKYpZbV6d+b0afHZ3k16hZHBnAKaso3
 MTAA=
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
index d61e15d855d2..0f00f77be988 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1200,10 +1200,21 @@ void validate_coredump_safety(void)
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


