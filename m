Return-Path: <linux-fsdevel+bounces-29382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E7E97925A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421CE284452
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235B1D45FD;
	Sat, 14 Sep 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCOpnIci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C71D31AB;
	Sat, 14 Sep 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333652; cv=none; b=RW8OeaykdGsLkKXYXG2ybq2taEpVi4Vxi/+aZsaEnkiu8rOK81CksEizIF/g431MKawHIKbcM/u+z9L3lFcdJC6IOnUxobytaQ4uW0kMl+qqNb2cFxBfqDbSjdJZwXfcsl1G46Xnu7bRoGnoTEUcUU3VvxtcLNmTG6vvcxzLYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333652; c=relaxed/simple;
	bh=9/XBaGHpEs7172AZ1LJbIYF77AkYkko2J3CyGkwFfPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/AMT9Z8d/OaqoW3/FA1s2Vuqi4t6Vqqq1RXol8b81q1VggO82AGaxPGRMQ8Sh50aLvwVOV0aaj7h4bALf+1bCKq1Z5+QpDd/sFKLCzmVKtJkSvRLSwTtICDCwD1DJrn7L4z4G39d6zdqPk8xsuBA+cuoFT0KAVFS3PNQ6DPJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCOpnIci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40BFC4CED2;
	Sat, 14 Sep 2024 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333650;
	bh=9/XBaGHpEs7172AZ1LJbIYF77AkYkko2J3CyGkwFfPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCOpnIci9ttfjhsJzdlcwY1nYcNFUbiD1dipumSZt87w3MACEWPzaGdku7J58Ocut
	 7HnIhiMDQAIoUXSnyL904jY9IAOTXxIxiIR1LWhnuDUgwkupg8+oSupET1iJss0j6j
	 58zUooisPaBhdB4W13l3tpEKZ/zhOH9LDKDAINhpnCC8r6Ajx/nmf0AhEdr/uUo0Oc
	 CjPVoNLSKEWHCQEGyvzxrzRJEqsldglkPe2BcUgUhDpbf1SwnPrBrDTtNubansxew5
	 /6dR/EZrDa8YIK8KYySDQSYx4czlItz8HflLG4e7RWbLXVLXgWgfxKuTUczpylZw1Y
	 XmuT7q3oYEnbw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:16 -0400
Subject: [PATCH v8 03/11] fs: have setattr_copy handle multigrain
 timestamps appropriately
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-3-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9/XBaGHpEs7172AZ1LJbIYF77AkYkko2J3CyGkwFfPc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLFOqolNl/xZsf6WUTQki64XUYvRpIiwgA6E
 8I95y8GTEWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxQAKCRAADmhBGVaC
 FV3xEACKkDWRY2iDTOCIYD0Vc9W6MmuR9SEw96FMPF1lO+jbD26E8dxf0hrkhre9oBUikVhQVAK
 mso6eiHYIR5pTUeQadzyNEdK8QQwVDVIq95IG5F1sp5NZBdW+myoBZzaVbX6i42BeAmKBFm+EAR
 uc0WhyS1vxp/5G2TzkAGEot1iMRUtgptkCYA1ksBNkbAQuAUpc28ksyE7gtXE+XTYRjt1+h7lb8
 cXQakAWWrU9Q6lvD5Eu3kI30Ml47tKa/aLFyPct/CMVP1wzQT79+5bCbUQeoa3EmPsYZG3i6tgS
 TXVg1FFqlViABoU1Khb1RT0U4PY2i8jCrcZbncFaS2IJqlBSy2X3Eq618IyGtKF2ZOLoZV80axd
 hJFet3BIa4P64HQ4Fwjedi/V4OdyKodhAbbAzinWTRT89vH6DMI6nNlFCRSayI4PGlcoqrD4gZK
 rDvvA59XFLCJ978lHKKngt2iaKf3f90k955si5r2iZahPIjkJNnt1y1GRg1hVrP8NwwI2cyrNxV
 q0N4yXSUlEdwbb42iJKH5aKp7AADnCwtFkCZ/W3qxfAyhlm3eVtV/60AuQS3lzjIXr+TYqy5CWC
 BFUrQdbfj9XMZMNWLwf4qTQqvZKxw+Pt2OUbDcndFIk5qB1yYq0dgaRpOrtgUPx9FAtsIGGKb+8
 vkCknd986DS7deg==
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


