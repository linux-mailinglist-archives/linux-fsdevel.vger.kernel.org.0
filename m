Return-Path: <linux-fsdevel+bounces-56078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C37FB12AF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC841C24FA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6996E286D6F;
	Sat, 26 Jul 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFYr4FLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42D28641F;
	Sat, 26 Jul 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540323; cv=none; b=mp09gkPodKPQdPDinvDKpfP+il6N9/NgaA9v81sgiQ+2xLoHsJq3Ms6+DqEgAf1giqdL2HjWA7+AU4cXyWyRWXNj0et2zkPrLluJPuUv8jkzwRJVkBfs1lgROg/JNAOU2GwI8JX2VDndvb7YQvtxOQoIOBOx8psbeU/boOmpmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540323; c=relaxed/simple;
	bh=aP036MEInZMizMlEkvsGvCO+OnhGglaFKY/Y/gbmCZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+TTw5/os2drPKlWEsPSPYb5SOVXRmtleOwJUQQCnsu94IjmU6a/MHf7ETOWcm8DQeNZ+115xLQ5Bxv8A/NQlLzBH1l3OdwiYPTZS5p4W0PJi/6j5qNuvDlDIK9/wy+Ya0JEW298FJDQ/lH7R8MIpws60tWUrx/BxMjEboxgAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFYr4FLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5991C4CEF4;
	Sat, 26 Jul 2025 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540323;
	bh=aP036MEInZMizMlEkvsGvCO+OnhGglaFKY/Y/gbmCZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QFYr4FLw3bKohdGu4z0asjzB4xpQSnIQgnlDvtkbIIh4kX5m/KKwmPO48YC0TJKYf
	 JvYTJTKoptlrW/E96WvQ8rdMklfYdtoV+zMWYhK+5JfE+GZ7ZLWhDwlb1UmqlDL3D5
	 /5W2e5oux4FiYUgcOMX2hMKYNhS/gErkFUZTyNxALus4YZBUGaiNLV4BjHgzjlyimq
	 wlpt0I/QVX2MwxLIKk2E10f+6vngx5K3vKO/IAjb+dODCqEAHZHhrMeDpPvf83R1Tl
	 QsVIsgowvrYdwcpTRKpSQIEJYyevhViC8BWfN+IMAo/IgBtjwEdeY53jaXSOgSu8O4
	 fQVfEr4WAlaEA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:31:55 -0400
Subject: [PATCH v2 1/7] vfs: add ATTR_CTIME_SET flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-1-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aP036MEInZMizMlEkvsGvCO+OnhGglaFKY/Y/gbmCZE=;
 b=owEBbAKT/ZANAwAKAQAOaEEZVoIVAcsmYgBohObf3Ua9aEkOOtAl23noP5O10AxVC+aOHQJZ6
 4Cld9XGRnKJAjIEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 FaZHD/j9Bqt9Pq69NbRYG/7x7ZLTE/r6zIE+2w03+oeGO/1f7g6+/1SQ0N6G5Yx4H6iyd4fUtqw
 DzFdbwL+WjJhp7hSVjTxrcqfGmSLwFGqCgNnQnkbYMovmz+UDs48Xh4exek4RsVjK1V0Y29O72a
 cjD49Pe/ossqEIhwyYIlmlsElsg7mkw/L7j8FjqaWTTUkUsd8bJQMm6QgUwCUUKaKXWF32syomz
 O/q9/FwtPVEZBFbhketQrkYJoNlqd/mvmB/4BnqOtGADIo172swUb+v1Qc9q3W9ihjXvbaRFu7T
 o3O0r7E+EvbxDXA/8yfeJqLwzv4swYu69Ej/zbfyX4CM8raMyu/LjnHSJa0LcCIstEy+BRy1gdV
 c2ZFkgFZuJZHVATnO81/2LR1iQGKcIeBfml1YHgRMNdQUwAq/2+GT9IdT8RBUVSf9E+DXNSBs3s
 hnEKkLKja0v8/kEc3g2MP2jmjaXUcR0okrjRqbcaUDcncsLxjd78GMFzGHNQCytPWV/JlhhgCaZ
 Qx38v3j+Cu1glB/SdPEs2yM9YXsBEVXUGudKLW2d6Bpx7XMx8AM6GkNNi10Q0/+mw3eFH6sK0fN
 8y0O3RuhdkoOe/RHTZhLRAh+BglNtfl1+bbhF9p08D1gzcVzrBAr1JYus2aCRNLfTpzfVrm9Cpi
 oiZAlzvK948P3
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When ATTR_ATIME_SET and ATTR_MTIME_SET are set in the ia_valid mask, the
notify_change() logic takes that to mean that the request should set
those values explicitly, and not override them with "now".

With the advent of delegated timestamps, similar functionality is needed
for the ctime. Add a ATTR_CTIME_SET flag, and use that to indicate that
the ctime should be accepted as-is. Also, clean up the if statements to
eliminate the extra negatives.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 15 +++++++++------
 include/linux/fs.h |  1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..f0dabd2985989d283a931536a5fc53eda366b373 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -463,15 +463,18 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	now = current_time(inode);
 
-	attr->ia_ctime = now;
-	if (!(ia_valid & ATTR_ATIME_SET))
-		attr->ia_atime = now;
-	else
+	if (ia_valid & ATTR_ATIME_SET)
 		attr->ia_atime = timestamp_truncate(attr->ia_atime, inode);
-	if (!(ia_valid & ATTR_MTIME_SET))
-		attr->ia_mtime = now;
 	else
+		attr->ia_atime = now;
+	if (ia_valid & ATTR_CTIME_SET)
+		attr->ia_ctime = timestamp_truncate(attr->ia_ctime, inode);
+	else
+		attr->ia_ctime = now;
+	if (ia_valid & ATTR_MTIME_SET)
 		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
+	else
+		attr->ia_mtime = now;
 
 	if (ia_valid & ATTR_KILL_PRIV) {
 		error = security_inode_need_killpriv(dentry);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 040c0036320fdf87a2379d494ab408a7991875bd..f18f45e88545c39716b917b1378fb7248367b41d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -237,6 +237,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define ATTR_ATIME_SET	(1 << 7)
 #define ATTR_MTIME_SET	(1 << 8)
 #define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
+#define ATTR_CTIME_SET	(1 << 10)
 #define ATTR_KILL_SUID	(1 << 11)
 #define ATTR_KILL_SGID	(1 << 12)
 #define ATTR_FILE	(1 << 13)

-- 
2.50.1


