Return-Path: <linux-fsdevel+bounces-30478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D298BA46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD971C2354F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78DD1C1758;
	Tue,  1 Oct 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdWGxNnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E81BF305;
	Tue,  1 Oct 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780359; cv=none; b=hkEPSEt2ipatFsFmEFn2w8bIp4iBvty0AX2BWHQqff0+ba4GC2HygQ6UOoHJ3pLiEFeqwzvZfyOyYppCBKq3MEkUROsa5WT7dCXaa8x+Xpkjsed/H2iwH2ulqr8uDI9jvmXdajQ3qljZXV83AlVwI7+VAJG1TweOWQTl66cUq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780359; c=relaxed/simple;
	bh=IlK6pMQl1VZaRTQUEj0w67Ch4gWJlIpgXXZruOpOJpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nca1RnKD0Y0T+UDtoSp6YyV94i4Ta/RZDGDrLamsHQiSCDTvBaLLmmd5c2gJvNXu/vGhfNg51liLM9SJ397w8kQSSke63uEIdm+ABe9vdmFSYgdbzeJygwZh4sgXO6aBguaPnY/feZzji7xZOfe+LRnjVUtLefQLlEjt6AnzRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdWGxNnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64621C4CED4;
	Tue,  1 Oct 2024 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780358;
	bh=IlK6pMQl1VZaRTQUEj0w67Ch4gWJlIpgXXZruOpOJpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jdWGxNnlxMwS3+6yjpiIb4x86c6Y3TIErGhniYiNJEOlBFtaxtSGyGJt+YG5JfF5f
	 Co1d4yP95nQF48Y/dcoyaN9DwQBiAFu65Q0MGvTNlhACrPKqHrmzHIAABtrJz47+Fw
	 3jm3yyjCpgoEKgki1HQlYZFsxXrxk8jaNcgNtoRRRGLXZCym4pKWd8+zTdVtwDO6x6
	 94owkToMnnnb7OJ5AxGK2IsD08ngJDcukm/REUzkRh1mhDiXycOKyXO67/ReZ60dMa
	 bDAWfvx38Ki4Gisf95iOtoLVvJ5cvcqpxn6qTV2WmySIld5q86F3P4s4KSPwK9/a7C
	 0phOrYwm4fXmg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:58:57 -0400
Subject: [PATCH v8 03/12] fs: have setattr_copy handle multigrain
 timestamps appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-3-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3610; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IlK6pMQl1VZaRTQUEj0w67Ch4gWJlIpgXXZruOpOJpc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X5YIAUQIyeGlbkZz0C3Ucs84y+6R8LaUnqt
 K6DgFg2Ba6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+QAKCRAADmhBGVaC
 FUcAD/9+TpkoTJObmH1PTrMTi9b6fcDncKerKYhSvomtiUjooe9rP/Z43xb4vfBPHr+mdv9BMDk
 vMyzIlNK4KZJczt626wn0uV7YrtEHK4SbfNP87PPyZpGztVypqDRAKlx+F5+brwhkYFacDgOiHb
 WWj6/5oN+zfWHwoMYoa7MuCyf65x1tipBW992ENarxxcFfvFXMeEX2HyJSwu/xlDSQlObSu562a
 2GqqvYxaIyJOApO1L4X3rYAoH64xrsCaXWR+4yub4SVu/T3kLXA9K4OxTtJDTnFF1K2Vc+jJEgF
 91PqQ61OrRHOuI2CeuSP+K66j/Bo+7/MuDZVhTbRPUTUbaio8MVXLyc0Ak4Q1Nwq1AsPSQPZGba
 I7htvHUy7c2gRCSoY+tbesZaCesFgqvjRD64fzIy6QNUNb1tfdfEbswaX4cbp2xRZd6mcB52Y0S
 4KA63naImLEGCVt+sEGX23x7sv/d1LsFbl/5FlJnIsx/XYNr1Zcb4MwnohlwMTZOFGRge2BXO1Y
 LxXZ+rUZPw3WDGnO9ONYeKb4juvJy2C1Psgq1Sb5RbG947cVEhpsoVUd6j6EBpXLWIP1RrTcomR
 a840JJBQ7phKKl3uGoFB/BWexhtYGZCe9RWI79hcjdxdHDq2Kd0JKKT177yuKkshdKXvQpfvVSC
 kV8NlS8NDSS/E2A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The setattr codepath is still using coarse-grained timestamps, even on
multigrain filesystems. To fix this, we need to fetch the timestamp for
ctime updates later, at the point where the assignment occurs in
setattr_copy.

On a multigrain inode, ignore the ia_ctime in the attrs, and always
update the ctime to the current clock value. Update the atime and mtime
with the same value (if needed) unless they are being set to other
specific values, a'la utimes().

Note that we don't want to do this universally however, as some
filesystems (e.g. most networked fs) want to do an explicit update
elsewhere before updating the local inode.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index c04d19b58f12..3bcbc45708a3 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -271,6 +271,42 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 }
 EXPORT_SYMBOL(inode_newsize_ok);
 
+/**
+ * setattr_copy_mgtime - update timestamps for mgtime inodes
+ * @inode: inode timestamps to be updated
+ * @attr: attrs for the update
+ *
+ * With multigrain timestamps, we need to take more care to prevent races
+ * when updating the ctime. Always update the ctime to the very latest
+ * using the standard mechanism, and use that to populate the atime and
+ * mtime appropriately (unless we're setting those to specific values).
+ */
+static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
+{
+	unsigned int ia_valid = attr->ia_valid;
+	struct timespec64 now;
+
+	/*
+	 * If the ctime isn't being updated then nothing else should be
+	 * either.
+	 */
+	if (!(ia_valid & ATTR_CTIME)) {
+		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
+		return;
+	}
+
+	now = inode_set_ctime_current(inode);
+	if (ia_valid & ATTR_ATIME_SET)
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+	else if (ia_valid & ATTR_ATIME)
+		inode_set_atime_to_ts(inode, now);
+
+	if (ia_valid & ATTR_MTIME_SET)
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+	else if (ia_valid & ATTR_MTIME)
+		inode_set_mtime_to_ts(inode, now);
+}
+
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
  * @idmap:	idmap of the mount the inode was found from
@@ -303,12 +339,6 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
-	if (ia_valid & ATTR_ATIME)
-		inode_set_atime_to_ts(inode, attr->ia_atime);
-	if (ia_valid & ATTR_MTIME)
-		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
@@ -316,6 +346,16 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
+
+	if (is_mgtime(inode))
+		return setattr_copy_mgtime(inode, attr);
+
+	if (ia_valid & ATTR_ATIME)
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+	if (ia_valid & ATTR_MTIME)
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+	if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 

-- 
2.46.2


