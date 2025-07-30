Return-Path: <linux-fsdevel+bounces-56335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD4B16170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1565A7629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCDD29C328;
	Wed, 30 Jul 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk1kb3R3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08B29B8C7;
	Wed, 30 Jul 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881903; cv=none; b=O94mHfw43LOVP9dYz53Y0gHCppELe3T63FVjWmGEh/l7G2Kz0/Fu84yN5PNSxRDZ7D33wRK5NxjuslL6L/f/4FxonYv/hq2q9ui1J8wPOVjK9yo7Gha814tS+RPBlaVeyexIkCqgK10+DKB+BJ0HDrwis8hNZHaZEMebBiBvM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881903; c=relaxed/simple;
	bh=D6Xk7cn+dUV5CrFWyLhNEZEfnQS3I5r0LFUPIwKxpUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkapSBqv4VJgBzFebqu7FPBJ2sLYZw65QroD8a4UYiyCoFRNOmtizuRGmnc4WGMaFEw5r2VwkthPOUTJaKzmEBt/kUevCymx5svBRNInLWLlvryEqJloxhnUUxHg+fA2YZ23M8PUaCIKsmz11b3+BnD5tKksUXCcwK6CeUmqV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk1kb3R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D799C4CEEB;
	Wed, 30 Jul 2025 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881903;
	bh=D6Xk7cn+dUV5CrFWyLhNEZEfnQS3I5r0LFUPIwKxpUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uk1kb3R30UQu2lY0efGS0dztFSlqBz2fZdhPk8oHhqokQ+KeHBm5hokzm5Npceh6c
	 z4jq9LUUyhttmio+fXrDU43uCgre5Il2uWmznzYpk+gQJZLUARCqg3KYBRigTz7vAJ
	 PDzSdTAf9O+BnNOh700kaP9dORl2WgQcG/7jltHmxlzY4pQYqWxQ+MpuDz9I9Rwwyl
	 ZQ5Mkh2QCIllkKygq7JPNqlby5RkIsnihxyWMmQZ90OuxXLkGMzB6AX5ksHPVAEmxZ
	 mqfd7wmWwiv/E/eJlCCKJyVEYK8TAEXOUuyUpriF04u8XlOsWe0CetsfoGuTcANube
	 62A30RHTgClkw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:32 -0400
Subject: [PATCH v4 3/8] vfs: add ATTR_CTIME_SET flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-3-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D6Xk7cn+dUV5CrFWyLhNEZEfnQS3I5r0LFUPIwKxpUo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0nRzSwihwapJKgk4mLNsYH/l6BTSPqvX1dr
 P+0628pYWyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodJwAKCRAADmhBGVaC
 FR7RD/4ma/rj5Drpc8mgvteRSdUbtRYsu1DmL9xn3VKrQdRZISvT+XnFrGF4RBPU+903PqdxWDT
 o+BXJUov/C5TlB04Ua/SL1eL/2K4jHO3oRaMJkb6ZBMqFYD/ytM2WAv2vhY7O9TV69gy+gSv7gf
 nvIWPYaZJrqHKcjx+NFJubuhuIdp/zIpfU/woSDrjahYwh24XYhhK56EcJrxRM9Fht9p5zMlnoa
 ClEBVfDGzs1DAoe/9S4/RtrZOqT3c6qrz37GIHUbDxfuBDHCRtC7sgFuPQBptBN9WTvqw9n20S2
 5vS7beqK8BfQeqnDOXlBdI0Mjk/V8gp5xCejBMLhDVGKN8OQIN/8sGje05T+7EOXFaTBDu+y/jU
 gQ7x7H/6Flva653hv+wqGMXJsLp9fsh/PXGPqC6ctH48P7MO4alYG0ejgPxValLbbXsYn+P2yAc
 4SybPlOZXHzQLQAsAKYAL6RAcFI6cnOdJYEv4XLPAB2D3nCz3FMvqUzowyrBKQoqCm6ZFbed9bV
 6gid06pxt55YDBhrv8H7RrFgkTJGFjCFbhjqJdHkC2XSEqrwsoAAwqOTGRjJiWTIMEg6L0c/F0k
 t5YLVYweFtIbMG+ZUx0gexgQjq4UgFCvRuhIxORVAveTHg0K1hq3eV1yrpxyf8Vuf1iDU37M1uk
 ivp/stbG1/co+rQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When ATTR_ATIME_SET and ATTR_MTIME_SET are set in the ia_valid mask, the
notify_change() logic takes that to mean that the request should set
those values explicitly, and not override them with "now".

With the advent of delegated timestamps, similar functionality is needed
for the ctime. Add a ATTR_CTIME_SET flag, and use that to indicate that
the ctime should be accepted as-is. Also, clean up the if statements to
eliminate the extra negatives.

In setattr_copy() and setattr_copy_mgtime() use inode_set_ctime_deleg()
when ATTR_CTIME_SET is set, instead of basing the decision on ATTR_DELEG.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 44 +++++++++++++++++++-------------------------
 include/linux/fs.h |  1 +
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..f8bb2b6011ca87243765bb444850b3b4bb91e275 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -286,20 +286,12 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	struct timespec64 now;
 
-	if (ia_valid & ATTR_CTIME) {
-		/*
-		 * In the case of an update for a write delegation, we must respect
-		 * the value in ia_ctime and not use the current time.
-		 */
-		if (ia_valid & ATTR_DELEG)
-			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			now = inode_set_ctime_current(inode);
-	} else {
-		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
-		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
+	if (ia_valid & ATTR_CTIME_SET)
+		now = inode_set_ctime_deleg(inode, attr->ia_ctime);
+	else if (ia_valid & ATTR_CTIME)
+		now = inode_set_ctime_current(inode);
+	else
 		now = current_time(inode);
-	}
 
 	if (ia_valid & ATTR_ATIME_SET)
 		inode_set_atime_to_ts(inode, attr->ia_atime);
@@ -359,12 +351,11 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
 		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME) {
-		if (ia_valid & ATTR_DELEG)
-			inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			inode_set_ctime_to_ts(inode, attr->ia_ctime);
-	}
+
+	if (ia_valid & ATTR_CTIME_SET)
+		inode_set_ctime_deleg(inode, attr->ia_ctime);
+	else if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 
@@ -463,15 +454,18 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
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


