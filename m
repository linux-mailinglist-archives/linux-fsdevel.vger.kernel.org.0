Return-Path: <linux-fsdevel+bounces-48399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93DAAE64A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2387BB9F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0854E28CF45;
	Wed,  7 May 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOcEQHlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DFD28C86A;
	Wed,  7 May 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634440; cv=none; b=MTcrIcIjDnA5F9FJKl16zO1sKPHunrlbFDQfjL3KhDN3sZwNYUJOYAu9zBSI5HxwUFmfIsjPdI6UnhsoT12LaK5xtmkRZOhhwY0aIMZ5quuvgSVAdnMxsxFfOvB6lT8InxcEnGpXbxKQkKFmkZHV/HeSPTGAncJan0mCA43wbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634440; c=relaxed/simple;
	bh=/Y2E1rjGOsMzeWWjGsal4y5faQxb4D6kQkcZ+mAHVGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZW77zqv8TUSDraow5UD0yergJvYE0jXOUkUFUOwfwQBzs7O6r1Tw9/vhL5uixsKktQmHD4Rk87gQ0ocYwxmsW9dcMyQWOq+Eq7DlUa0cr6DdRLoKn3HW7dlHpS93vDzW7EhhaWbLLue3lW2nAcrQdm7CgHkojpk8j7rrLZe9pgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOcEQHlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55B6C4CEEB;
	Wed,  7 May 2025 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634439;
	bh=/Y2E1rjGOsMzeWWjGsal4y5faQxb4D6kQkcZ+mAHVGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZOcEQHlTSBJ57/R/gnonojDb0eoIlgMszVLsjJdAwU0LCVxfmSAiW/cHAh7Jx5JWz
	 1JScWCdEAKeV2925F2CFhdEIz1GfgF5zl1nG2neF/6qSDnKs4SKJCXb47YV8K2JMIM
	 /9rdEVpPFilKSZYufGBrBd3XKduKzSQsbysn4MFDY/WDBPVLpe2jU2xx3ElGS4nExf
	 LoVoB8XtpljduPfazX9hYd8JesZkejBOd/s6QFie+IS8A17hkNwQQYxiuVJsALaPbH
	 joRCnkAAP3C0aYIxq1QkPXhfqHiXLQg52wuHWZqBYc8K7Wv/t5Mk043RFfXqzk26h0
	 d1uSIxhniVKGw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:36 +0200
Subject: [PATCH v4 03/11] coredump: reflow dump helpers a little
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-3-af0ef317b2d0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/Y2E1rjGOsMzeWWjGsal4y5faQxb4D6kQkcZ+mAHVGY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt20t+q3iltlgu3sLu/Iu15nrZWt/8m8Knfo6vWYZt
 8HeMyE6HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJrGD4pzhJWPnC1n0h0nYf
 pl6qezXHzM53ksB9O8V4WeuIzATxw4wM29JT7xwvmqj+4oVjf+18zea/Hv86s6ucd6/Q0s6R8lj
 HBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They look rather messy right now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 41491dbfafdf..b2eda7b176e4 100644
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


