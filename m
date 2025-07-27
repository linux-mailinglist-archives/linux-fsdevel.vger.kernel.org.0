Return-Path: <linux-fsdevel+bounces-56102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC2B13145
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A217817745E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078AE233133;
	Sun, 27 Jul 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyCUoYyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DD22FDE6;
	Sun, 27 Jul 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641389; cv=none; b=bB369UShcyyPMKCReH009aW33cUNQZcRWu9XfRaeZSBy5m/1xIPg2qWzoqow/D7Jr84Jyp8hT1VHBVfnSd5UfPDvEGShEiKyXwV4nNba9WN7N09UymTqw87eP6cyQVL2lMIPRVkkGTLc0b2m5U8J/ao3cMjc0fK/83w2gC+WfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641389; c=relaxed/simple;
	bh=aP036MEInZMizMlEkvsGvCO+OnhGglaFKY/Y/gbmCZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLD7LNBU4Way4B35nGvxJa9lrEhdvex1WBFvyBesyPgrvFKbYhNOzkKsLTVaR0n7+uLWNDc+4UdTm0XRj3zCcA947ljIzbdQ2Fzm0q5YDdwkTwyMU4/dmc4Uw9CQ4eAa4M9EM8SLl1hpDvVuDoB0oKZrQYarDdB0gsPwz+6YNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyCUoYyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BC2C4CEF7;
	Sun, 27 Jul 2025 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641388;
	bh=aP036MEInZMizMlEkvsGvCO+OnhGglaFKY/Y/gbmCZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YyCUoYyjvMqMYuzlR1GY4uv0wTZvrSlaUD7wSb1ZZ0d0KUbH2y/S5fPuI8s6yu4fu
	 NeHQoWLF79aRtMQLF68f6WvNS88GAUVdGSXaGpn45ryrm3eZZXKCzs9vyrlW7WzOAl
	 Aho/y4nagcbSf9XLFpCiWrq7LSG78mjsGfCUF5dH/XLSo5+gheUV5d99it3Ny1iZEj
	 CXv6md/5fTuSMLoN5MDcMdNAopRmTISZXgDGB3P++YEXx8e1Q4s6fh5oe0gqRfBqNW
	 jhqLRAok5x/s13GZzGUOYayJ1Y7P62MEPyCCfq32iCwD/BY6bCa/SVHsTDr6MnCgFR
	 lko3JSQDNTV7Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 27 Jul 2025 14:36:13 -0400
Subject: [PATCH v3 3/8] vfs: add ATTR_CTIME_SET flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-nfsd-testing-v3-3-8dc2aafb166d@kernel.org>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
In-Reply-To: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGlNatSEAsI2nkY9cwBq32UW332MKTLEJEM1
 0dWQHHTmbaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxpQAKCRAADmhBGVaC
 FeHxD/4rKGngRhnCLaIvQdMGx5mwjQOs/WouDzHR45dgfaV7tuXq+fxdQavaMHNmC4YLwmJojh/
 Icf40CijDQDSdO21b4fj7DbZm9SgYAjqDym+6Eu0A3v1hsr2UrdzQqH1Ohj7Xl+5+KVHORjX/qB
 dD0gYB9MhisAHvE0La+lS5YH1yutR5yCsNk7l8fa97qEifDeYZ9r7W8Qt3KqI+ex5AMd32WmMPo
 CX4qXv8OtMsLuN9Peu1mYOKZwXC1Cgwqk2GGfeyZjdHLkV6SRFja1YobrEBfl0mSg1dz3eW1BF8
 i1pcSbavV2s4B+x4qG2oNW6+y27tzFbOFywBYONHZ7Qewk0qbkODq5+4OquTRxYoD/obkW9H2ky
 M4EvWVbqqCLzIbQqIGRDMdvjH/gvt1SHkv4CZpqqX6TRsi0yXvpW1REskKyYaR/5GZub19bv4xf
 D2FYmlLVy2I4MBDvctPQ7JvGIZSd+0iSW9td6Cj+CD/3KIwBRxcvK39RB9qssJH3bwcurwDRdT/
 W1j6UbcDdW6AM4Y6zZcaBQa2UNP2B6HWZtl0GQhm9H06w8Zpy9vqaXSE4ZFKMkxPlnq826ZEVX1
 4X2J0Cw/I38Wg3PjCFSZsKNQ9ckPIZ2nqW9EOsi1gZUmuZ+oXdmEy0bc+ZZFMcT4OY32+3QimC0
 20C9cLu5rU7cAgg==
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


