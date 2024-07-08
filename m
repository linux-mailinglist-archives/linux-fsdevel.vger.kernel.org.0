Return-Path: <linux-fsdevel+bounces-23295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4617192A64F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96564B22396
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A614B95B;
	Mon,  8 Jul 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snEZEZZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A414A609;
	Mon,  8 Jul 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454035; cv=none; b=SQgZsxw3jvtT+4QOJNKwYJA7ex6U8Z/3H0gt59jEInSKfn5UgYQkZo+CCxTETh7JUIwcsku90GCHf6sABx+t+YLOHevIsjRZvBDow1hIG0EjBkvr5JQI0DEhPMDn3lE2LeFe0eIkW4edKcvp6R712fwnMZTco7AlCLFoLZAPuU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454035; c=relaxed/simple;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGdKGd1AWkm0Jms2vjt7MpL+rC+wbtutamoHXT5Exhz7BKLElq5obqrBo77XTU4yzA3mNbQO6FyNBCVU3vCDqP+sqg/wvqBMP0VgLsGLJrgGHPXCqkU4r6kJ+IJUrTbLJu67bnnZRx5mlR6BL62qfjL0MEAhiSkmhbK5CBgHInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snEZEZZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E048C116B1;
	Mon,  8 Jul 2024 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454035;
	bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=snEZEZZYYlDIZjMeR0Td2Px4FknQRH3fmM4PTBqA1d7M6RXOxjxczgJGVuJ3P4GRQ
	 ysSySTtnx+quYylWaidML4XGNklkrRMjIqpIe8UeFAh6fHMNYp3pCuNa5yheh/2xqi
	 +wsTLz1ey0cfjW3yrcN2MAki2ZIhVRIpvH072F1MiLO26e12C+CH8eYH7dvEyYAibA
	 aGbLq7+A1yYlyWQNzJKsppiAyNwSDcqZ+OcaCwOF4QVX1prMyLtbRPInAiBxLEaiUo
	 DdtmLzKbMUTY5kdzF5nSR+HLmMMhK7doBtBaiLTyGCtcwMOFVonevbVz8SqbrjWqSc
	 evKhj7yKOb6Ag==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:37 -0400
Subject: [PATCH v4 4/9] fs: have setattr_copy handle multigrain timestamps
 appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-4-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/g1ddIto05q7VUdUuGmHZRulUXiGWzaifPHAIEfpWmk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuEL4klBEgs/SfbfKR94rLthGFfhBSMCDbIG
 o5m14n1BsCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLhAAKCRAADmhBGVaC
 FUjqD/45ex7zNf19dNV4LHtGLYWtZ70YPvkdUMIkEdLkrKjWeWdIIKpGP1kG8D1U+0QY/cVdZQG
 /9dg3txWF9kkA7P5ghcdrHIk+gP7qVfFEqlBwTxtnLOjaiWbO06hgl9ii52/I2z1ndnTd2O8Xrx
 n24iowjJq3gdx8wfi8LqmlBCsvZVWPUf6OmUscBEtdcwEWTPCZMEUrl15JJ8MAJGRLDLjesvoE6
 snCuGvaKcDXizPA7X+YpZBYoMtL1HWE61qQfvskO4F2Nkvxj2cCKAZTcSyaGx36j5MROw3XH0y4
 4Mw/YCUcJ5OoZiqAZg79fS+AicFIykbZXLERNZ58tf8y6ESylFZsI+uFV4ydKW/IXNbB3I21EG8
 RNv6agbK8HNsPvQLJMr6IhghR0QPI0KTEyw4dpVCMFiYoF8671jwrq+O7SfVGJRpY8Bi7G6SOpA
 UZ8izyjrGP/lkbGicScFy7QkJ3AZwvePIFh5JcT6j9mjykJ90V0cTg/7VDFEwFM7b+ptXN7GBZp
 zBjWzxR8CGq1293ZOBFGuk0a4mCqBmjD2yZifaP01mBzmnHZFeHpeQPAZwsI3i3fLi94Ct6CyZU
 9FXumDSEBy/akWO9HZWy+HQGzR/Pe9fTc2kyWC93w3fSqfRlXMsRj7DCU7viYe3L4qk0ZYzgFJV
 G8Tql0DRGFseNHw==
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


