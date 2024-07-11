Return-Path: <linux-fsdevel+bounces-23564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358092E5A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870631C22DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3416D4D8;
	Thu, 11 Jul 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM6rnkQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017815E5CA;
	Thu, 11 Jul 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696117; cv=none; b=jkgKt+jWCEYkoPKzikvN/j2rprYjR/FkC7sH411hdjrfteeTsHckJzCDr4v1LVi19s6FlcnAgHqkMcMX6WBk8zX3OhXJS7cGMy8gtzp9T3iqlCbyLcTj6C4Nu0spWTDXLNT5eDiF2KSOcpIaOpZjjb191B+/m6zFl2wxPEqxFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696117; c=relaxed/simple;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HeBmJFXiiBnUnyuinXhPNwFX7jtp4Wyw1lQOO5dCBo0sllRBDNSd3DjvJn0wXbwu8pYjvEKsgS58jTg32Dmweyni0uTFrbr93CZfx67PzhDVmQaPBldf/uJolg9sEnIBEAJZKFgNh8ZAPA8MwSNsUxtGdBtNh69Y+B2xL8OxoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM6rnkQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED33C4AF0F;
	Thu, 11 Jul 2024 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696117;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aM6rnkQnft67EwdDPveBEC+aLnbaz9Iw/J9cEyYCG3WskFlIH9k0egFU0+Qi2Q05c
	 PGTgq5xVMimnrOH/NEwwdPJJxHGQC59lahoqxdR1589/Od69pfsq/S4P9rCm6EDfnE
	 CCbH8QPfqjRO2bzt1m/KEINTRYYAeM41mPxo/nmz0cf7H3iakPlLS6s8HITwbeYPU+
	 i2/lDosNupJCDwHLlMu9LzEE4CucQJZFqhDTVII8U+QLk+uhFR97875JWbKdeb8kEY
	 m6RUPbotcrmnFL7PG2S+dR12jKaQ79i/hUeM6l9cFRvMyW7Ub2xHxlN/HxyaaoQOIU
	 tNrQX0xPxYWJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:08 -0400
Subject: [PATCH v5 4/9] fs: have setattr_copy handle multigrain timestamps
 appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-4-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
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
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70l0tB8wkk1mE/fQzmfxmASsaLYnQ6xULsvM
 medg6N9UiyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JQAKCRAADmhBGVaC
 FRj/D/9/qFMGv96YIkAUDVx329NA3lwGZlqp79bN1JG78zGjqY7RX8Uv8c805I25dhpqy2+jfBk
 VnWd2HCtg1ShenHgPEfnBAsQNjiSUqeF1uIuEVVrTwFaq8AsGY8LTu0QVyeuGImLKtdQomtuVwt
 FSmNefB0eXDRt6rmOFfnflJoXglp10hyeikatMaHGEr4ASXHDObg50snibOl81qye5cNJh6LbWT
 UZSgieB+TtqZzZfxAqwNVBRXLrT8QjDcSyfNuJoiB16Jnejn5qaFVEiGGqomR3//RmFSBozZ16y
 1HwtgYp+Wn/io/r+6kKUrUeYHURFsR2sVu7s/XBzTb6gJ3yMjd8YTaCSg8Oy+yKNh32pf39Lhmh
 arf0zK8/W8lt2iOWSuLYJ2//NzoH8u/p12GqCm2dhWvmIWg1CD7YqW3cDGiWc8bltkudb+doVt7
 JnP52FRHLAy8v3Sbp5QD9WLr/4lBVDEaE+ulNhzfxNjI6XIaMRQLWY83t1qsaNRRd9+l/QdIh4D
 w8GSkDpmq9M+iIPOmGLF2GndPggmO3X5p84sFpQHkNa9P8Nc+DBt0RnoIS+1FTm4LfAs3VrB9Se
 XHTcE4rfgHM0uGMDzvP3iybkgvcTipYHi9n9zPYC1UflB4CkmguObxvjJKWVAOuSCGxvMhtPjBt
 g4r/yhDL2VECz9A==
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


