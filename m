Return-Path: <linux-fsdevel+bounces-48058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A93AA91C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78ECC3A9E30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0C20E31B;
	Mon,  5 May 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxOs8Qdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6198202C44;
	Mon,  5 May 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443659; cv=none; b=Cr13gSqBOwu0C/idsaBn1/BjqBy9srREgqC3wBgxCd9HXY4yZ1RthswKez3U+INxbI2Zop7Yt/dmAotW2maEurngS8/5yJQz4uilgc18mr4VkFF+ZJ2sDYJdrqSwRSUYKZuOeH4ZHotitV8Zybg6z23H6JDmbdHDt0groTJdb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443659; c=relaxed/simple;
	bh=/uknDbEVxAQovH7hvslY3diyqJp2ptgrXNsx1BL3wHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goa5o+5yx6TsFhg/N3WJ5AJq1ypGLABmeMH7iE5rcZNAJskcl6mMmXLbwqn8BIjf8x1H2f6322Y4UqDz9U+YuJDzLBQEAa4hpghPqdGjrxJeXRkDaoTpMh8RWHJTMvkM2hU8ZPJgibi2NI8L/4KiY1LWbdkTME/U1b6+I8dabkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxOs8Qdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59B0C4CEE4;
	Mon,  5 May 2025 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443658;
	bh=/uknDbEVxAQovH7hvslY3diyqJp2ptgrXNsx1BL3wHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SxOs8QdpRcwG0cRi+wlg9v8wO8QA0gftgcfF2/il8Y+UjNiDqrGeLnznp5sdnwLwD
	 qyMuZRoVPu8gXt/5GUvtP5MKT9YpL1HSxujmYsAGNeOpgex5aHS2SRkh26jMJT0URA
	 +vjLNNdAEKsamsEoYT7lzBfgHmNPNlQA01upJjMP4Yn+gbUXQIMsNHDk8hjRS3u2Xl
	 LwrOjOiCX2B9euxmuaCXY4qlr/PwCGzwn2DA7N6CmaKPSDHirGGh6wZ8BtvCexCtx1
	 9gxuPw1WSlSrVWtWhbCsXX6j8rd9FMEwFsDpZyZqgvKIhXdWELzF5Tcoxd3lLgm7oh
	 DBgJ4JtXI7D/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:43 +0200
Subject: [PATCH RFC v3 05/10] coredump: validate socket name as it is
 written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-5-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
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
 h=from:subject:message-id; bh=/uknDbEVxAQovH7hvslY3diyqJp2ptgrXNsx1BL3wHc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM1jlo9n8Jua97dx1aRDIfO1Qh23aO30E24Vfv31Q
 fy9m61/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy3Y3hnyWj5Kr/t/c2+fvE
 bPbO8v/Dxfw+f/HhnMTiw5N8lGTVHRn+yl03zHu/+cNCXaP0wvURG2++ufv01CFdlUObDnD4fFW
 2ZAEA
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
index c60f86c473ad..d3f12ba0f150 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1183,10 +1183,21 @@ void validate_coredump_safety(void)
 static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int error = proc_dostring(table, write, buffer, lenp, ppos);
+	int error;
+	ssize_t retval;
+	char old_core_pattern[CORENAME_MAX_SIZE];
+
+	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
+
+	error = proc_dostring(table, write, buffer, lenp, ppos);
+	if (error)
+		return error;
+	if (core_pattern[0] == '@' && strcmp(core_pattern, "@linuxafsk/coredump.socket")) {
+		strscpy(core_pattern, old_core_pattern, retval + 1);
+		return -EINVAL;
+	}
 
-	if (!error)
-		validate_coredump_safety();
+	validate_coredump_safety();
 	return error;
 }
 

-- 
2.47.2


