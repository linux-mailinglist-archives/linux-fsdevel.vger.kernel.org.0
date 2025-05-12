Return-Path: <linux-fsdevel+bounces-48713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5012AB3270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7164C17ABEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951A62609FF;
	Mon, 12 May 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdQtyeyb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB725A2B8;
	Mon, 12 May 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040180; cv=none; b=PAmKQiFmKZ6FidXRWagYomZxk5Ptd6Rmi+Tspy6RKPBzX+hxNZTltkieEmvnqVtPh9Xgy9tbKn/BFLqvJ0s62tE46r0qby/Ge++THoSQnHB6JPijhFy+dUb437Hb6t1/tKuW47cFHPEN/EUsSGhJRJmLKymJViBPJ/B0XQTxt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040180; c=relaxed/simple;
	bh=0BiGaI9QZtmJlstEuxiCKxHauy4PjCyPjPux0hQjYQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=docWvxaoiBKN8y8PRo9QGlgCaudBGpDe3uzQxsahN4nSCha5j3y00ImyMJy4OWb3wof3stfXsrIhTYiGtiT37QMrbXR63s1ln9/wT5C518QUunB2LqqQm7Gg8Zx3XIbN8Vt3vbIiHrE4FnbFbDhnVn6P+dh0Wu4hGQO33eEf5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdQtyeyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643A8C4CEE9;
	Mon, 12 May 2025 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040178;
	bh=0BiGaI9QZtmJlstEuxiCKxHauy4PjCyPjPux0hQjYQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EdQtyeybwNHIadd4alM80IN3dI8TfX7rI1MrguNmxaj5Gor+BOXgdcy1FHi/3P9pg
	 rD2tdO+ANB6qHN7uhilP1UwkltKg1W3wAvEfzoDLWLcNFDb1iPrkbyACz5sIW0DhQy
	 7on/P6ht/CrIzuh0UiU9fNYRTQ+dG9aqj0+tvX7a6c3WFzMzeKLMMEF925wXU09HNc
	 1wBpmaEnqjsSX2s+AZSJU0JpspMwVh3T92phzQGB2AoVuw6W8/WeJ8BFvy1mZhBouv
	 TX+Y1BBqcA7AKWjGT0GOPfyEu7yfWzLxKZgqbCFhJ0iaZNoxAlgLB7EU8jYyvM433B
	 n7aEnMV9ADBQw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:26 +0200
Subject: [PATCH v6 7/9] coredump: validate socket name as it is written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-work-coredump-socket-v6-7-c51bc3450727@kernel.org>
References: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
In-Reply-To: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0BiGaI9QZtmJlstEuxiCKxHauy4PjCyPjPux0hQjYQA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQobm9PlXhpHxhTyMm1S3/G9DfizEfMC01542d+Fytlb
 GiasfhRRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETuHWf4X9s90Y9VMnpyy/nI
 PgURru8RxzpXByRzLhd1aJVrTXdiY/gr+Env2/IVsw/9jVHIn255fPZCGaEDtbM97h/tXhPLEXC
 OHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In contrast to other parameters written into
/proc/sys/kernel/core_pattern that never fail we can validate enabling
the new AF_UNIX support. This is obviously racy as hell but it's always
been that way.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index deee52bff6bc..5b9d2e063f8f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1242,13 +1242,36 @@ void validate_coredump_safety(void)
 	}
 }
 
+static inline bool check_coredump_socket_address(void)
+{
+	if (core_pattern[0] != '@')
+		return true;
+
+	/* Leave enough space for the socket cookie. */
+	if (strcspn(core_pattern, " ") >= (UNIX_PATH_MAX - sizeof(u64)))
+		return false;
+
+	return true;
+}
+
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
+	if (!check_coredump_socket_address()) {
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


