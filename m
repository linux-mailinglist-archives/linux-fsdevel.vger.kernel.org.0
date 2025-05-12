Return-Path: <linux-fsdevel+bounces-48709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2EAB3260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0030F188B29F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5325B680;
	Mon, 12 May 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK+wIdZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87725A2C1;
	Mon, 12 May 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040157; cv=none; b=ZqiD+NNCjCn9RqMOCFElgPSSXpcI36xD611gndXYOkpFsM5FH52I0KlMsFn0jLQovYc/d815/iqbWzGto9O5N9/VPbbsW+bAFwoFO4eyHzwooXW1zzYc37Z489ScoxNKF0dUg+MRTNDTf3JNbzoSwT5Lap2UFuBDZAlaC6a07sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040157; c=relaxed/simple;
	bh=D7Loxo9G/kcLmw4x1TO7tL5CmVqFKJ1HEu4OaNHweVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NP6qVkOuENQyzPPhkStWKeG8G/GkMBffh5PfRqPJGdA7XMFSetRlgHi21tKa9D13ppDMOEMsNOUu9BsXKjoeSxKA6EDxc3ldSSJFl/BKdBz55XR8iQ9MWHzkDKl95L5lgBQX0pCDqy+h3fKByc3Oh7UIm2phlgrVOlwMFRG1kUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK+wIdZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E04C4CEE7;
	Mon, 12 May 2025 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040156;
	bh=D7Loxo9G/kcLmw4x1TO7tL5CmVqFKJ1HEu4OaNHweVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YK+wIdZdMuVMOaTh9U0gR8on6/ypY/ssKHSyL4HuyjAxNFrlOXEOlPLjtwsrg6IYe
	 1LvSSGTWABx4pPmSKXSo+5TtvEWPeCTmP3Y4mgxlIT2y3EXD+UuXNEU3lNz7pdE/DP
	 0MWaLjPyU1ftFYoXx2J8aeDmVDLTuZhvdCgnLxMwGYMH/72Zir65KTjuic+XjY4VmI
	 XMMwrHRseITsG8UOq6ETZW84jRB+9TOL/4qilxnI3c/vrqgzC38bB9+wjGPXsC1v9d
	 c2nRsmTePAbtVxjNZADIzYXQsbogB38/MZM7XebW5gO06jDdRCiEwhj/BncYjToeTe
	 A5o955z6+3oBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:22 +0200
Subject: [PATCH v6 3/9] coredump: reflow dump helpers a little
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-work-coredump-socket-v6-3-c51bc3450727@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D7Loxo9G/kcLmw4x1TO7tL5CmVqFKJ1HEu4OaNHweVk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQobm93XnFo595ahifW9jN01j87eMyjSvnoJOHHqjNuM
 XaVd1Yt6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI9SlGhiaRK49S1qna2Z0T
 UFz4bcurnwuEf7P9e39giZqWyW7uCa4M/1SXTQ1lFX+kb77yzO9Yr4Mb1Nb4vBC/HfiLQ+zzkvb
 PizkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They look rather messy right now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0e97c21b35e3..a70929c3585b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -867,10 +867,9 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	struct file *file = cprm->file;
 	loff_t pos = file->f_pos;
 	ssize_t n;
+
 	if (cprm->written + nr > cprm->limit)
 		return 0;
-
-
 	if (dump_interrupted())
 		return 0;
 	n = __kernel_write(file, addr, nr, &pos);
@@ -887,20 +886,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
+
 	if (file->f_mode & FMODE_LSEEK) {
-		if (dump_interrupted() ||
-		    vfs_llseek(file, nr, SEEK_CUR) < 0)
+		if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
 			return 0;
 		cprm->pos += nr;
 		return 1;
-	} else {
-		while (nr > PAGE_SIZE) {
-			if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
-				return 0;
-			nr -= PAGE_SIZE;
-		}
-		return __dump_emit(cprm, zeroes, nr);
 	}
+
+	while (nr > PAGE_SIZE) {
+		if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
+			return 0;
+		nr -= PAGE_SIZE;
+	}
+
+	return __dump_emit(cprm, zeroes, nr);
 }
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)

-- 
2.47.2


