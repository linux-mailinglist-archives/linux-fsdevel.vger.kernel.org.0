Return-Path: <linux-fsdevel+bounces-23692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392719314C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E51C215C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF018F2C9;
	Mon, 15 Jul 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiWQXcYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41518EFDD;
	Mon, 15 Jul 2024 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047763; cv=none; b=UHXhb5n4aWw/zvzAWW05MjpQsvbmol901n4ZYO6LFKAihoUuen+vk91nmmBkbI1Z7VtfkLeMTwSbDOxFNX8uzuyRU7YiuavyeDqrdIzFg387EA3E8z5If4kI4Pa68o6mSOqR8k/BRZEOJU1I9jPX3bIYVOyAS2Mc42LZv4sSqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047763; c=relaxed/simple;
	bh=QeVccJxIIqw839FMAslwYN0cCtumM5RGorsmI4f3Ba8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ri3tzD4Rl1J4vss6U3Xf/w6X/Pr60GpvRYTa6Ko940NRgY39ZGg1WKCMRP/sJmkBYVR6dIadVjcEvLrttFWyhy4bpycwZtjsa3+hNv8gx98M58ZflOMZ2g0MVbGOIFJpk92tQ+YzctQbgpssvYg94jzEkAf4lFHTbZ3537Kh+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiWQXcYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26DC4AF0E;
	Mon, 15 Jul 2024 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047762;
	bh=QeVccJxIIqw839FMAslwYN0cCtumM5RGorsmI4f3Ba8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GiWQXcYj1to6dm4zqB3WZcP047jHZ6ztSMtTi+WxEaaMYw+niVkY9vKzScQredr+L
	 OvHfw134L8C7mHiOMPXDdO0VZiYVW34o6XUZAONLlvhtC4N5fPTgckq8KgS2iO6BmQ
	 zkfHj7wkaflVGgU4Jgpu3lhmTzfasIAtVteUGf9cgKR/Cc05mBM9z5kzj9GCiLb71/
	 C4bUPXIS6p1E/ZaQx7MUg0mdkuHVcCPzEAFMCE7HxyzaHJK7vKlYy3HmERyREnj/sB
	 egfTLiRvHuyGjPIGvm2Qpzy8c7O4wLLogMgKEJvzvlpBC9CwslWSvDuhzRRJQn/nVG
	 9/Kipe3dKWfAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:48:55 -0400
Subject: [PATCH v6 4/9] fs: have setattr_copy handle multigrain timestamps
 appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-4-48e5d34bd2ba@kernel.org>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
In-Reply-To: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3502; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QeVccJxIIqw839FMAslwYN0cCtumM5RGorsmI4f3Ba8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrCv6y9K94MS/Va6IMTGYStbxE7qbrcFZ0Ck
 ktMIQhcUj+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawgAKCRAADmhBGVaC
 FXaTD/4+907j6epNme39/Jvo42T2sVT8Gr4WtDO44maokkPWgfEq/tA5OdSZsLRKdQnyuOtxDZa
 KCzRZScbuIWev9UWubIT11gAkcf2at6Wu20ez7swsPIwbw8+BHd8+2cjjN1XFbuTEaQ2QMW1Ruo
 6MQEsCv+EgExV27/ORkA6sizkDMDb2m8dtxZ5YXpZnp9WOiF1QKDAJBU5JtgYklvKnxacG13xgd
 Wws5jbg+9FxOokzjJ5G2DHUGC5/JxmiJAx5Zf1OIqOhIEUrYzaQv/3Yo36AeskCYUqbA2q2MqH9
 j5of3fjIixxU7GHEkmq3+CdclNooG7OAIpnb7lGEHj56qewVRnxrbZBRK1z159RcXYicVi6qF65
 i1mTSjcgcz4fJ/BG1oNHRxR1S3ivBPlycHN3Y5AHr6WApq6eK9wU1sQ6X+pGdi8TttQg1K9AHOE
 Zq2mBVjy3m/YcpxJgUiYnrwiVwgq3/MQ1yOLfrczrXzkGon/hUelkp8pB96JI6yE/UsNc0eYlXM
 OA69o9g7LUH+JN5sfl0/r5jwABDL3lm5ZJXtIZXjaDklDWQUT1r2RNcjcwS4pdgRXKyhT4HZ+Hs
 Z1h74eWkZ/uHYdiWIEwtzOBFNHRHIn1eNloZ2T05WWNowSmDtEJAerXDjpCNdDrLdHvZMo7zxVC
 0Vy0lk5VKnmahgA==
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
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 825007d5cda4..e03ea6951864 100644
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
2.45.2


