Return-Path: <linux-fsdevel+bounces-22582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B34919CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3631C2220A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254242A91;
	Thu, 27 Jun 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSM4D+ht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB63A8D8;
	Thu, 27 Jun 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450048; cv=none; b=spgVm07QkiayhxRx1ED+0jGbiotyfpx4IssBGEedLF+diAzJ/R3sGIzVAk0ZJo5NQH4qHuZzK3JEjxMtKPdz9O97DFt7RQEWaXwC5wnldLoNPTcdoZqWS6PvfPr8Oy7tL2jpFHVL25ngpDxQIsWEn7qbL6RVnuDemScfEgPni84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450048; c=relaxed/simple;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gc0o6vlWpF/HfzXAxv0MlWq2+sv81Wz32VaMUWtv+1AontqrRu+fQWhNkp3JAM8o5XLfjGDV4ZPTzNnXXidCQFzBCcN87FehGubwhA8jqofagzz89DsLibM/ItetlRicvNJBDrRmf8pwfdWWxTYKjZ7+OkQPQau5Qln8JYht4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSM4D+ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3019C4AF0E;
	Thu, 27 Jun 2024 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450047;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KSM4D+htEiLS5wQkJ0zKSjaJMxEwEGG22qWwF5spro00SlDHI78pzriunnpq0F0r0
	 SEiKrQAn1yP0PiAuxzXGm/wpgfD6W7meGA/ajicCqaKrmAGh0UdMrYy+9VbOvrR4xn
	 wZVLZQ/sAbDRmk40zheaQiul+emOnfSR5ZIlq8Mmjva2FuMDNaAHR7SwxUqbvNUrn+
	 dgEHvLNTiA+ojAscpgRun2J2bDaZdpcD8nJqbdH934KxKG/9g0VcIGFwJ1LbbsHKP7
	 k6VTzDDiPm6BUQBeYGVtOEt7lA76YYCB6lEyFiOLjVl1fO0jBTHHTIJNN6c25FUKkG
	 VFQjHsF6PG5mQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:26 -0400
Subject: [PATCH 06/10] fs: have setattr_copy handle multigrain timestamps
 appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-6-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
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
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmvt5FijKuOW1vA/E+4WT59dqYyFM7dMPgmC
 4a5LSWoXmeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rwAKCRAADmhBGVaC
 FXZUD/9B/x8/Zq9asfvRQABKDRs5+rE6zIeYgHTsok96TS49jId7AW+yvJZzcQ60z97OjtIAwTo
 YkmpaooiGCxQNKKMQAna8eVpiHzmg9VJIeDL9bZiWowREYsAWCOpDXRAMJo1s90ZIiSDa0WrmRh
 5b/wgqt63vJ2eAJJxLQXFkbsv3j+brsUJRCCZXZBQq0Ray0Zqczrdc66Lr08hFF00X0OYtkkh+f
 mguCF4lxXVmuLkVvakLq46OWh7scp0GkjI4CmJflY11gO1qdhzjiiUCtdLok9uUjracDuHQVslb
 Q8j+odXGCtFdhLXrIWYVn5w3RQIsbGnSa2kNZTYpYKojuj8gRFXsUQksMEfOyegcLoSrWojFfci
 WoiEmrLy6Z+nOrsixHBXd0N2ePqm8cgf5l1M+ybnnIKsrBHoFN2mioRSQv2rFGIcD940lBwMCL2
 UOmWHXsj7KU/boDxh5NhAAT7uKUc8wQUrrRqZk2bt1kp3G4EY5wMkZlz+Hv9p6DjLFzMuz7oaqk
 NY/ITCGlhOXe1tBCHwLKEKYef7RQ4Hp/DiPJSJ/mxYfissEXHANFM9kcATDHFqeLC9asainf8m7
 8TUD1m1SxoBCy9x1KRRD/VsvxGq0eU3u6xtnOggG360rkUMuCK43V4F9y8eR45mYIg0XVjj/BTY
 Y7he/1P2G/b39LA==
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


