Return-Path: <linux-fsdevel+bounces-23231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ADA928CB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468D81C20E34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D8172BB4;
	Fri,  5 Jul 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyz8CZ2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C939171069;
	Fri,  5 Jul 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198987; cv=none; b=ejLGjKQaaHHQQyXwJuiG/TKyuWwJn5PugsxaoeGkcfKZIslycSt1nQfQdlbjvwe3hyn2jCZNE4ZtMpUti9qD6N0nKJGp6/COcPWX33IW6Znzh+MgIa8EigKZeJ7oIVTSGloMeEq5NzNxyTYCecuUV3U7GLHVRT3uVPRQxnYKcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198987; c=relaxed/simple;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUYQrwWuFlIcDXxBfbUo54tZIk+R9VouTn41NxIGYEkk0Tdl516bDtFInduCH5+0HhufTDvsGriI4ZoCWU8D4tQCaaWYa+APqpWk1P2aE0UW/dxUcPODCa5jHwNfNKXaBhL4VahR0be1UkxzMjAyUA/eQduDJH3plxsVqfygtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyz8CZ2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01278C116B1;
	Fri,  5 Jul 2024 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198987;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cyz8CZ2I8i9mmYGb6ZNUwNOM+PE3vABCpnlA3oN3yzR9v4w0ZVF3UIEsGVMUP98gG
	 jjN1TaIRrsc6xDHJGucWD6Crn+ugFP3rbPn0DWbaSa1EkmfB1wRQkTrVBq6mkyYObE
	 2jZQgjGSdd0lqGgZ686afBlmBFPI/V8rsl7idRLWf9Gvvm8JpZu+fqkKPj1gBuje4s
	 ZgfyPqvxLkG10WOZPeGGITJ7lOZOKjezg+nKTnFCQV4+ZvcAM7DOD4IsAgB6OcP/pa
	 f5TrQYDghSURE9jMAOc9HS99fKf0NXO6QDQIr6ML5cAUoPdCP3r07ylQmhCo/XJ609
	 E3zzhwsarXOFw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:38 -0400
Subject: [PATCH v3 4/9] fs: have setattr_copy handle multigrain timestamps
 appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-4-85b2daa9b335@kernel.org>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
In-Reply-To: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
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
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc9jHht+laBBOwQf5fabXQzRZYLzNmz+tU17
 u0Pkhtrd3CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPQAKCRAADmhBGVaC
 FflrD/9UNmmTOjbmFEi/KAzSSVbAVfNgsbqqX+5s63+bZfwuZYllGcNP+F9G4xrOyuE1U5D9qiC
 xmuwsN2Py5WyoEunyvofUP6i+DH2nWEE3nnXDrW+AZhwWbqSkqh6kq9PAA8pjy/njoAc1qyjJsk
 p1eoQgk2IKxROPgrfbuNzEDem7vxiqxANMjiC6dz+grRH6m0T8pPELw2oQSWsUliHAMeK/tSRee
 ff2NVdm+R/v2frifR6dbtweCcIVJii4wCGsg0bWWjpLx96ljg/pVaHxx5t6wWkMyp7zKqCF+39L
 +iKcZtzGsYbSjN4upIotuFyzeFqZeBbNeF/6vFtMY90KhWzDWG/8wYGr0rXehKglm+P3eI4CuYo
 zUhsoyoRkcUJKSogV7zqtRRBjS+BKs8I4DivCkUwIY/VwOhOMJoZ+j7E9zgrWsiNrK6muZQjwRR
 gTUJzzp3rApfGkUNKkxWlneOvRnXdgvR/Gr9EuxTXxnuPoxKr45Wo3x+LV98RTyWs3a9EcVrjtl
 WIu7NFt95+80lPNtMYBTY5ccCV1Ioi8JHnwpb1OhmiW6rqYVU6xBGbqgy20YQ0vrVkJmxgEMFOE
 B++cCxOX2PSFLtRn+cuaqfSD91T7uY450SrteDzWd5TUEWXl7JgAnU/vOHfPAmoDqN0XcpOPijS
 mz7WpBTEbj3VEiA==
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


