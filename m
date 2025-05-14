Return-Path: <linux-fsdevel+bounces-49013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6DDAB789A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800A77AA584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29622B8AA;
	Wed, 14 May 2025 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeBMtrf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D50223DDD;
	Wed, 14 May 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260254; cv=none; b=Ltdd3/cWa47A8s1JRDjNa0S5Q1phAzg+TIjG4fJqx26/pwHNN72vxcm9bt4AFlSfphoAZh8IRR9BYkTcBcydkMu0TdEna+4rFAjXCW4+Y9N/amvH5LRFjH2cxP4vOK8AZCCXOvBanj15Kil+pDl0eFZOpbBO0NuNtDuRueU5pnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260254; c=relaxed/simple;
	bh=D7Loxo9G/kcLmw4x1TO7tL5CmVqFKJ1HEu4OaNHweVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+XIiFiIiPwbPWHtHYKpnkRBCAVdh8kaaLFoT5e5poWpVlE2kmAmDtaEaWCZx81ZI+Ee36as6XYGvMH4S7u+NfuiIRu7ndIA+y0dAeNuuZddtpyeQyqqlP7sLNu84HQPBrPY6bHC+GORMewavvC+iP35+/xog9Bw8hX3RpYk89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeBMtrf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA44C4CEEF;
	Wed, 14 May 2025 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260253;
	bh=D7Loxo9G/kcLmw4x1TO7tL5CmVqFKJ1HEu4OaNHweVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HeBMtrf/TyA0/y/R55ampa8iLylsNPOIQfb8FGOr62bDnCnJgcKFKYsMzmQJqxcHz
	 jy58bMdGRTrRItR/mjn3gtljP5Oa/kKvNyrT/WgCrusU1hK5IBZydPCDFZe7FnDpn6
	 6B3UkqPExTeef/m24oyuSSbJcDKu1s9BLUtuwdrNygw7lxt8RImmQkJN4l/w5Yxl4l
	 hQpAyaBJhMf/+bx8/XuiUq6oz5SBgVpZAIBxJYV8jQByFzEN42X8F0a7DrciE2JiK3
	 sa/nh196quN3FGwdlbhIGmKxTb2DKuXdOPhgRNNfOJBGnUnoNXBUEk18KYmLw3m5Pl
	 MUXgjRsrsM7PQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:36 +0200
Subject: [PATCH v7 3/9] coredump: reflow dump helpers a little
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
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
 b=kA0DAAoWkcYbwGV43KIByyZiAGglE0jISMl5DdGL0t075cM4WKmWRMcvt3OeO/99UMI59U7hX
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmglE0gACgkQkcYbwGV43KIWJgEAtDoH
 vbvbLyFI4TeVuzq3rWMFpbu1z3P+EcIcgUvpaGEBAMLLiQuEVbF8lR1ry/DW02JqTx0klpa8Fz1
 CdOdgEHMH
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


