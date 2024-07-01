Return-Path: <linux-fsdevel+bounces-22861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F591DC9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A111E28906F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930A158879;
	Mon,  1 Jul 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAq/h+Og"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A65157A59;
	Mon,  1 Jul 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829642; cv=none; b=Maza/2KD+I2hinGNMl8qaf06ybVqNqYT5ymBdDSMng5Ov3IN2RxXScIP+Yj1rschX5WOIy54sWx5PcPDHBe65gUN5QMjsKEKBHeaEusOJcEVWOh59e8tiTWkHWTXOcCXVb2GOgE+C4P8BDRa8MXY0TPMktu3x9WCEJKrXUlgvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829642; c=relaxed/simple;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiW5twlBovgi1jYiIDuQu8y/sEJwiH4E5ylyZTzoGYaEO/1/up8flVn+Dyr25DWAql/gZ5Zx4+CnVc1Z7a/dC0TC7WiNezjBnj73n+AZLcLuPh4aGBWXS9FhcZut+fVwp/yECJn9x99J/dW58TnaIA9birV2JMrGI+hj1tSx7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAq/h+Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FDAC4AF0E;
	Mon,  1 Jul 2024 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829642;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rAq/h+OgmIHQ3zIMfxX5Nuh5uArKUwvnAQ5rWPuLEqT+4ESYLcn2+s1iNn4IGVUPq
	 N7swqaL3CTB0PdUqHWJ9SubqD3nH71n7W/o1mN29bXoOWHACe4NqegsWU8PiQPR8ah
	 oUEzcWEwpwsJJoDzzvpir8kZH4qbg+7bKMjYC0GxxTnplvJUP02GdTCqqHoOIyJS9c
	 jkWX8+1eDjx7q3QpnEZY3Fb090XnzRKi/KlvE06DyPMUynB3PeuNoYLj2yp4bxxeSe
	 7361qvaMwFlGPQOD813l+53urert7qzRw8sAwh/N6p7+KS++d/BjFguSwdMj5FW5rn
	 6L/peMMFmlglQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:42 -0400
Subject: [PATCH v2 06/11] fs: have setattr_copy handle multigrain
 timestamps appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-6-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR58LRBm5BdNBCR+TQergAamM4jMJnuDIZZS
 0IWUHHOHNWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeQAKCRAADmhBGVaC
 FZfqD/4vNuUYPBi66c7J5PKDuQoOJPTZ2eyZ2nWW1bPmwywtj35VKbgYYgxU4MJDDMRd64oP3NI
 24gdEfnDRr62udorC7vft1gdWkaoEHOgTnIowpeTOif6eWWMfHLtvEf4ufB7qWjv6HiiQXt6FWs
 XUZE/TixP/ajfJvyLsXnJxY2gl26mob5W3HcHZWs2VjJ01bunCKF9z7SlSzWWjfNpRb9IOIBWTq
 YQG/90bLm7SLCygE64o8fLAjfPV2/v8/G/aeyGKkKtBdu3Uc7x8Vspwrm/aDlqBRJ1XC98bY4HU
 s5Fkzi7qN/V+eBZ+4mYBNzd93T+Wx17Ecw11QqmT7ifv/108rmjfo+spE3rMBzVBq2Zh9VZGT7N
 Qf/+TzlzcpRl7L89fCFtJ76kjXWb2phjeMClxn2lvkJwr9oVjeOJyoKcbw9TeE4FQN3LiYghU2m
 MwiaGUVHC7njwSvbjhFjnImAoEXZGyQs+9yYCyhPxzsFxWyCWxzh2hXqNUUhM7k12s1X3SWZT8o
 CbHvLMVs0MUFu8ac/a2pNs9d1acf5vTsZw0KmsivcZhL7pAJHfWDUYamlJaQXAIL2q4lDHL4uTk
 CtMaR4MfeiwBBJ24nwgCpUftL1f/t6d1Z7o72PuSUKGqurGllmzX/bG3Ine+IKa1KwQeqhuiGDk
 UId2Z/axztB/vFw==
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


