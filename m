Return-Path: <linux-fsdevel+bounces-49243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5121AB9AF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B368B188CD16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9823D28E;
	Fri, 16 May 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6AMSPQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3823816B;
	Fri, 16 May 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394763; cv=none; b=tssb/yS+ogko6X1qqAWwfcEYPWOZFR5/d69MnOlRj1zO2DXzVsLwwDuTb/fPWAFditG0TVzImq98zedDV/EVc7uF0B8h83jW/iq9cTjiTTrfQ1jR3Dd7TcAUqLNui/uPX9Z7QpcRDNBoOneK60yG69C0qL7WFjfEeJysn9nRidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394763; c=relaxed/simple;
	bh=So2gG7QcCwBeFlnjr1ntJgcFQt5U/NoPavduZCJOHsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xk0R4IpOx9hsSt5ywKIo7yOjKvsa0sMJhKUOs26j9AFb7BbKU6zbiUNQ1wve5mj+H7JKjvTM/A/4tt3zTS+gdylHpMemJ4eNPLWXL+HDvgjjkfudkdaBeCZs4Mj9YyuppR03k4yXj2cOrYoEs7FZ4+SRDXARkmOLkU5MMjY4nMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6AMSPQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2FAC4CEF1;
	Fri, 16 May 2025 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394762;
	bh=So2gG7QcCwBeFlnjr1ntJgcFQt5U/NoPavduZCJOHsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E6AMSPQ/vB6VlIrTqQlpQr/nb3B+IReAJvy7OKGMKOiyNualnuZ15bqRd60MGCvo3
	 Mv0QsxsC5A/eIDFGjJkmyGwbhKTO3xDHFLEJb9b/uRMYdVuvTKGCcGxzHu3xMz5Chs
	 NUyipLdZmOYK0EGs7uJaEwQIvUNR5X68nTr5RgYisQix3lZuFpP/uj489N/vuMv5QZ
	 a3xAiyx8fDuBicIlzAwDTBN5BycXl2GfOsYmYcWL5Ntnlax2VkWnm32qkFUAROYV42
	 wh15nJfMW6VSB3+zDxuoYXRA/7sgAqAKAgviNnyD3oCi1BlR3Hmh0jWOOVHoIj2p8t
	 wGQGhfKDD8IBg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:30 +0200
Subject: [PATCH v8 3/9] coredump: reflow dump helpers a little
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-3-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=brauner@kernel.org;
 h=from:subject:message-id; bh=So2gG7QcCwBeFlnjr1ntJgcFQt5U/NoPavduZCJOHsc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2xN95rx8qYg4z9BXb9kH20LYesbUj+nPey1XOlg+
 q6n6JF3RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQs1Bj+F3/+V3h7T1xxo7D7
 hxNsk16dyPPmKvzl5bBTtyhzvds8NobfLGc0fy3tS+94La59YMX3yCW5nOuq+04UJsmz3/qtban
 FDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They look rather messy right now.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 47c811d32028..4b9ea455a59c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -864,10 +864,9 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
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
@@ -884,20 +883,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
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


