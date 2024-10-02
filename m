Return-Path: <linux-fsdevel+bounces-30790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD398E506
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F041C22334
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137D21BAF2;
	Wed,  2 Oct 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrg8jFdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479021BAF3;
	Wed,  2 Oct 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904462; cv=none; b=RkDTLhOzLpuW54XA65creR0JbPvhDqCHl2+kqx13rPH3T6Rm3CJoBffczTcIdF3rYOp90vE63KeWcuGD2Q/vEnpf5frhZlJPPSrO8gQob1OAhFPwKDad95FLXqEjhdpMxznlaZAuF8yr/S8QOTfMyisyWq5jVc621CRyE0o4wUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904462; c=relaxed/simple;
	bh=nWAObiv1pT63De3yrHB7U+GTf1hLNrlZ3AMOKfvjPAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lp5yYXgHHkhK5ILmfCNNa3Om8EN/eejmT+YT5eoTZpqsxoNQ+EWtfnK6eAwu4lrIcTNSjDnVNhohVcqvBFYxcS0quKJS2cHDyiDqBRIzx8CSgf1QoK4rGskJpmBX1dGMoXqZF1U6EdKDiOrhVaVktTRYKSJL5sXjQ83RIuy52gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrg8jFdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAC9C4CED0;
	Wed,  2 Oct 2024 21:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904462;
	bh=nWAObiv1pT63De3yrHB7U+GTf1hLNrlZ3AMOKfvjPAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rrg8jFdosDYWMwAA92V2hbU+Yuic3cTXnqQJL7/CjaS4rr5GNRsDVyFogFc7wde8b
	 3+ytxmfZcVBW7BHEAGL4MUuw8r8fjtd6551m/mw3PBYEMfUcJX5EVnFh9Dl4h9g9bq
	 E+0f3RyVBQuyVN+jR02fOAGU05QU3hphedY25tfubjbgoT7Ovjfw1tUksa+EGwTKEP
	 cQw9zf61IzShMjY9Nc7Pn7ReERF7yn1KIs8f8bQPZs7a9O4goDuhvZZeDLeqBbBWs0
	 G1gFKZ/7FA/CHJ+OL4QeRprqQq6UL2esAzsdREnCvyhDIodZoeCmPj/niFarTH0M/n
	 olAqzjyT6/E3Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:19 -0400
Subject: [PATCH v10 04/12] fs: have setattr_copy handle multigrain
 timestamps appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-4-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3623; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nWAObiv1pT63De3yrHB7U+GTf1hLNrlZ3AMOKfvjPAI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq/ifAGWvuvl6BRwMs4Uby9r2RObyp81rJWQ
 t0O66nsopCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26vwAKCRAADmhBGVaC
 FUFdEACg0WGt0WZDsR4lYHjv29oOUq3iMhe6DMxJ/AIvWuxlPjl9W5bf1/v4xbhac64hqIi9t75
 Ed8baE1O4menek+QPLY2fRZnnBQGeQXQg9S9rBIhp0xF3IDD+27FJYF8TT5BItAgxM+tE08Jj79
 TxEMXfS4ytrx3H/6P8gkkrxj/Vq2KgyY+pXxhr6SJL09O3NDWwkl+CmZlhsbJqaDtd0Bu2Nkqoc
 7XU2I/HmGc9+oXYAi4FK+WjMwm+NdZxBDxUf+mxJELst25MI6Gn7ZqLMfihTZDlg/lkXmnjoMYc
 CpIIZoyJ+HTB+U9Kge0Knzi+yySpldS6Jv2RXPCtm4ptKKFDi2JO1mhHQyQ6U0oVux1XaGQMEda
 hhXz0O+U2tobDuICI10a29pVUBbbzgFMTN60MymsFmu7SunVDjCCb1GVEoIOOfAITwjZdcdxth/
 d8tPUuSxoGy4Xm9bPfSc6kUuaWp/GqTpsjbtT22UjDOKz1DJfLRmBLrSNeW2c+1WW6yPWoA5wCX
 gAjJGRkY+f5UkqUIhYc/guqwfh2fkG5UVSrwX7YjFkNlNJjQxYPkFfaC5YpfqjGNJjS8Mm/XNw8
 RuKnlGcHgkVhCZdFDdF9m9DCLNYtwbNGQmPRyak0iaHm3uyL+MOfkADpMxPn3YOLLNHu/1Gw7j9
 rHKf7yUI65eskTQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The setattr codepath is still using coarse-grained timestamps, even on
multigrain filesystems. To fix this, fetch the timestamp for ctime
updates later, at the point where the assignment occurs in setattr_copy.

On a multigrain inode, ignore the ia_ctime in the attrs, and always
update the ctime to the current clock value. Update the atime and mtime
with the same value (if needed) unless they are being set to other
specific values, a'la utimes().

Do not do this universally however, as some filesystems (e.g. most
networked fs) want to do an explicit update elsewhere before updating
the local inode.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index c04d19b58f1224c2149da57e3224b7bbbc83561f..0309c2bd8afa04bc43db6ff207f8a58d9f6a617d 100644
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
+ * With multigrain timestamps, take more care to prevent races when
+ * updating the ctime. Always update the ctime to the very latest using
+ * the standard mechanism, and use that to populate the atime and mtime
+ * appropriately (unless those are being set to specific values).
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


