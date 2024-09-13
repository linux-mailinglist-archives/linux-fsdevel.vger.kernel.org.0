Return-Path: <linux-fsdevel+bounces-29320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225AD9781B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971DA285110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAF1DCB0C;
	Fri, 13 Sep 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2SMFOaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F011DC72F;
	Fri, 13 Sep 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235669; cv=none; b=lYYvoRyifLllRLFfaLDAlwqBxJF+xx66PbjUyByakf06a2mT6JhQBj3hM+UaTr9c/jabPrL2k0Z3Sz2erMdSqZ18N0vMM+pLwpneJVtd4La3qsM2Y13WpUUPCCMb4r5AarB/T4byL9CZ8VR+h6jJJRMtaXdzyesWXXhe0eUOJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235669; c=relaxed/simple;
	bh=9/XBaGHpEs7172AZ1LJbIYF77AkYkko2J3CyGkwFfPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQ3LVo5CoNgEI4480DYVECDo1Tqnnvm7Zlrru10iP+YZZ/gHQnThrZpj6V7EWNJMsZLFOZERac5aNxx6QNKuFzmNbg6VUWeRELqV9Zl90vqbyo9QBD8eoRvv9tYR3xt55/2A2WuSfNEOaehcaydiOn3juXC7ZTf8kEPK+nmaBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2SMFOaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1C5C4CEC0;
	Fri, 13 Sep 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235669;
	bh=9/XBaGHpEs7172AZ1LJbIYF77AkYkko2J3CyGkwFfPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W2SMFOaD/89VPA5TaMWz4z9E/674HUT6m4iHpbL3vTaL4DJSVwBzyOmAMPCWFE39N
	 skL/RIsa0bOJ/FRylz7xBNdG5GKXLRcTvLLURGA0Qcf9Ik/UPyCZRbVxRsqDQ8o1+U
	 GSI5Ou0ElKh+z3NZrjh7QMMwDJ6zLwkYAkfiJpmPedXrIDR6e2+C1poHGnP+ztI5z3
	 jspgihAV0GEBOhcO0QGYg4zJsGxGgeRYsJpFRJIc+X89rv0udITx1oOx4Jmlet/t+n
	 gijgkPjqIRcPQqzLJLIIN9OHMOAgpnn/1lx9ilKxviTD4S7I8Q+8avsWCvhv9sz4ZY
	 uSA0geUmOyQjA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:12 -0400
Subject: [PATCH v7 03/11] fs: have setattr_copy handle multigrain
 timestamps appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-3-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9/XBaGHpEs7172AZ1LJbIYF77AkYkko2J3CyGkwFfPc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQI+jqtPOSShNNpOHPlbChfIJYBk0V5nXAwT
 cwVRFG+pq2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECAAKCRAADmhBGVaC
 FT/JD/9/ovwyjr6zVFnxHSlE4yPi9XMFFRZ6vjJ3PSEqTzowQ6D7m1OOjDEUp49lWuXYBm+sfsE
 6jJI40GaUDtkQKPk+I2tI1G5ki0jglFmBIIu/iJ0MJ0f7/jpwbkiyePe0oGBdlWNeyAkJQr5jII
 YDbAMtiqzB9siTAmRM4BLsZ1myu4a+sIJhiWnMx1kZM32aSfbJvcCtE50DkwrHS9CY7u5jX6spz
 oRNSNw/+Qy8FpH0KSMBa2dbO2pz0mBfz2lb1/ISS3q2FOMDPnkiB6glD40gYckHfCsffRx8hPPq
 B2qsSHoRbJXcX9+5mtH7VTfU6RMWlQ5S9J+p4bYDhGFPu6wtBvTOoxp5TpxOABtfI3R7FmwWT5P
 A/SIXpKhEaTI49RZHyO8JB2TGaPLGfZSapX2YxdUQa9+BZ5eVGjjmJjUqyV83EWu+I5japZEyMg
 cgzsE5m9Df/8Ze7c1zAdYSfUk79juoorEinuJy+qv9aX+ESEOIvU6ODnjrbeOozttxQ1FGqkjed
 CPpcP0o81OnRMHHBFutelQ5ZhKMaF3jRb0PA46kUrgY/RuJ4wqkk4+34wsmI9N0F5K9uLthvSYo
 u+NLE7I7ctuXPtJsaNXE8l/yf9yXCmc5pru6aOkDEotvqbSlojPt6Aypm4ju81hA57KsiiqVgTE
 OHDghWrSIt8b1Zg==
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
2.46.0


