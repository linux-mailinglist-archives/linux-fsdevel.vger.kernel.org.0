Return-Path: <linux-fsdevel+bounces-30765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66198E2EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EA31F23914
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023572178F9;
	Wed,  2 Oct 2024 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/usSVuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A72141BD;
	Wed,  2 Oct 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895001; cv=none; b=fYvcx942L4BMFD/d5fF1l/GoHwMFskl+ebKAGs65UEFZFhfOdZO1ppFV7NJKzNcBKGcc2xEFV3fEF+Eg7qq6P3x5gd7pjVCB4w4vGOE3grtR4gTUNbui6JIhsz1J4NOQUVbLw4o+wSq7W1K+QLqWkh5HZbRvsTp+zCgu/j5PDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895001; c=relaxed/simple;
	bh=lFYSNqHeRNdwWK/XmB3fXwkWmQ/Yur1I7QduAGtTJ+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDTtpFTQvGsMs5DCwrVo9tI+S6hNVL3Eq6V1cIhgQ9sqV9Zs9qDOuhfSy5m0HGgdzjq1wzj7/OSRi2PKTRhYA8PFDynY2StqK1pg2xrMfGEaYN93bFUb6U5qlNBLbDmkZ7T0by5lUaYLTFTVIR21aHfVJ30k7JXY31xzq5cpVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/usSVuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493A0C4CED5;
	Wed,  2 Oct 2024 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895000;
	bh=lFYSNqHeRNdwWK/XmB3fXwkWmQ/Yur1I7QduAGtTJ+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b/usSVuScvrhwtxn3KQ3g8X7gxx+GLcKCda37HDaKPKadL7yvk4Qxq6H7ckAaZwnZ
	 ybxJcUQK6FOY+03t4AL49mpKmpcBoZpKGCMNKYC+DAFlO0/9Co2eSvxg77BVwhF4F7
	 RqGep6DbLs92sxXLQgsQGQCheuqGJwPkgrMZZuHwGNm5HoaLqXomIdAm62ThqgDsWF
	 litXVEKjtv1iuby+l0bSGF5LglapLW+nGjAkxKlGfHV3MV0RQ3JE2xopJQqnnzjF3Z
	 hhtx3uNEUPqlJNsoitanLbQVTESccX/tuKGHFmiQzJGS3sNQbaWB2ZUcnlUiXXj5N6
	 pkkReY8oZEE+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:31 -0400
Subject: [PATCH v9 03/12] fs: have setattr_copy handle multigrain
 timestamps appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-3-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3567; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lFYSNqHeRNdwWK/XmB3fXwkWmQ/Yur1I7QduAGtTJ+o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXLyz50rdlWAisS9Rf+dtjs/DFcV4kQkosAS
 gsaH3DiB1eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VywAKCRAADmhBGVaC
 FdnyD/0T67VbA87szAGb/s1YdZ5BTkf8gOF2Numd/G9SJyW8QcFJ6/yvfLD4bdsK4CpgmSinn/M
 krQHTiP3fLpmQLCFa41sT/mzaXSvPE9nTGuhJcM0UDjUJ1U5Tho484hKLCp+80b1o6WaSytN9DA
 LeLu3X35R/BoMq58P3wpvEqZC7nMtUH4WdC0uD6wjBxZG4VjTqIBh3+ur5DefXYKFYvRFpLIRmN
 FjVHQ/1vkuteTVAiEFNVAaz3wRu51qO++aatDnPpEujYwdW4R52GpCZasPXNLAlovjocwJF7vTr
 AlEV7hs1LvxxsCptjClbAltWbbrZdQi04CBS+88BhDb524XUpqJjsYc8KvNXs+IVy0qYBJZZn8b
 IGWgT+mvBgUfqTb2CR/KocbLTHQlNSIKFakoIiike8KdNFl0pky+9ZpZT+pLYe9M5f1pzgzeWWk
 c7lTuQKw5CPpDrlQSBs8egJZx1F33lrdtTuGJngk2rJpxpkd/8BF+3FTlFPfUkNoNLMNRj72FWx
 y2ssowrBJF8YWClqMU7xkMwq/uJBL7xkCQJPv/o24YQ8ruFoYC76JwYwD5kcQA58wg+radHxDei
 kVBt9tfuyNeKuDFuY1rdUimnUXnnJjPEto+PvVjgvvVVgbH2y4Qr4t4+qMI01h7Uva5k1X6+i7Z
 brYV4SA9Mhi5igA==
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
index c04d19b58f12..0309c2bd8afa 100644
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


