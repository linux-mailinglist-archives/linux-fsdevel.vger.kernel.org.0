Return-Path: <linux-fsdevel+bounces-48555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C69AB109E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E32AB23D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344728FFF0;
	Fri,  9 May 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXjriyq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF128EA72;
	Fri,  9 May 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786367; cv=none; b=em9wNU2nYep0XtEpFiW/0vIAspV+AFUlQ2FQ+1AHq+tThoYZwU0YqCjr9XcPwZHJBDiqJDR3xWFsbyWn9vUXjOyOU99JEtxpdaN3oBA7WO52eUsrTqOLbRLdl7ave5kF+GSLOSmM+ZK6j4cSg99aW1gw1aCIin15FXUEAvpPols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786367; c=relaxed/simple;
	bh=/Y2E1rjGOsMzeWWjGsal4y5faQxb4D6kQkcZ+mAHVGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYz36LmI4gAlw0CDZvHEL6A6UMNi/QEDuxDJyfTvtb3l2pL9Acjb1y1gso6T5JfU+cbHgEiG0Suz/6rghXILPeyJA77VEyobszYhqaQebWh9RBOt5rJeyCVAOGZMm8/x93sXWsydQqa9pu++9s78luZV6TE1/kyJbvhlzB/yW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXjriyq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85418C4CEE9;
	Fri,  9 May 2025 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786367;
	bh=/Y2E1rjGOsMzeWWjGsal4y5faQxb4D6kQkcZ+mAHVGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YXjriyq5q7v2aiE7bTCxzhfhBVLd3QkGFNuJlC21+J8uG0zDiUkwVyYm1nm70GaWE
	 nBI/7GMN4qrf4NjANF6a7UD5eorq2cW0CEeEHh+x7BjnJw7b4OcAM7fiKf/Z4Fl65c
	 ZfiA1bJ3OjiJnmyviOpW4j9rXaKogTs8O1NGjwrKvAkiFyp1VvkJivRj/XnzE3gN9a
	 VpJzOj5EkYWykNMbMU3HQ068FOZ3aEcluY3mQCgntLaooMW4l9CDeNorxPj+7RwdfH
	 09F9OswKPlK65JVNy+CBtzVSkb6yGQm8FHphi+NhR46wPvoWPfg2btNPfWygJ3A+rl
	 zdAcz4j9CNzuA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 May 2025 12:25:35 +0200
Subject: [PATCH v5 3/9] coredump: reflow dump helpers a little
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-work-coredump-socket-v5-3-23c5b14df1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/Y2E1rjGOsMzeWWjGsal4y5faQxb4D6kQkcZ+mAHVGY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tB6Hycp7nUu5d5U09q5ntUhRw6Ecyd8fG5/jeODd
 rWJaNG6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImk+zP8M3gQkL/9Zwn3dIa3
 axvavr+991OimaP9/nlfRZmjcpqZxxgZJp9I3yOcsuZFjNDd9u6NMSwzpoTVSB5eZcwg6PT2xKE
 rHAA=
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


