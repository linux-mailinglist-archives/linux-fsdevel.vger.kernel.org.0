Return-Path: <linux-fsdevel+bounces-55721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B2B0E3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BE27A4457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F7280CD5;
	Tue, 22 Jul 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chi3x1FG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72B284B29;
	Tue, 22 Jul 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210363; cv=none; b=ElulJ1azfoQu6+sFLPPs1nQfQGX6p3pRZgSZnW26F5lDxB3Mv1CVseQnUTayH9M0/b3ENOfJvMjXMdACWmlZjG8htndeZ8tIZdrHZQc/j7gFNTE/s7sEsYNUzZo6XrIKCxZQif09whqLRhN1PpPxC3v2WJGvZ0LbbHWedZ0y/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210363; c=relaxed/simple;
	bh=iYBw4xhCGRCvfAF5MhNNiyX1HVH5Ue5u6Xd0TVVd7Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/hwRK28pe0sqrWzI7tOkTpNYDV1o6Mu2zyQW/EYTTqqreezV8xMlN+Q/2uexnGDWe1mBDYxv94tAcm7Ex/j1XYcI7vrNUurbz4AmmcniEMcwB9OMEqVbpvgENjngXbvx2r0Sqku9lwkPYoyVtMXIHKwsYlkBXcK57wcPFACjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chi3x1FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2FBC4CEF6;
	Tue, 22 Jul 2025 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753210363;
	bh=iYBw4xhCGRCvfAF5MhNNiyX1HVH5Ue5u6Xd0TVVd7Yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=chi3x1FGBfA1OeZG+zcjT9/+5HlFk5TvmI3otGjcymBEksXGDCC5xfWQdmbCaEtW/
	 oYECfWACgWyorQOn5mJy5fpkuCqjvLgWVr6AEx4y5vrbivaA7mCTkoYrPJe5wmmOyv
	 Vm7e2jkRa7UgyLyIwUIdnkW7W1C0fB0XQ/0E5ZPvwIfRRj6WEQzQUhXD7NIUW3FLZT
	 Sil5rE4eWIfxX+VYEfxaU32Pfy0jueE4hUlqteQLlnU4xfjGZO+n35kFhwz6/JjcR8
	 4UMFeFUQTovVYHel4MjqYpd9W7svy2SrebS68ULTt8mYxLxF86xqH30SMOPDA1hFb4
	 C7UCPPOQIq+Og==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 22 Jul 2025 14:52:28 -0400
Subject: [PATCH 2/2] vfs: fix delegated timestamp handling in
 setattr_copy()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-nfsd-testing-v1-2-31321c7fc97f@kernel.org>
References: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
In-Reply-To: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4536; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iYBw4xhCGRCvfAF5MhNNiyX1HVH5Ue5u6Xd0TVVd7Yc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBof933jwSVWVC4Wssc+UXoCLXpXXdOe6OBGByDN
 FfNnqfKaKKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaH/d9wAKCRAADmhBGVaC
 FaJqD/9VKfJEvpwwpjcl+kilKWRcwygCTf3opH97hbOIq0FSw/ENAU394+huxg23jAZr4dfY5LE
 EmWcdMcxZC4lpnL5YlRyXDQoVjxVX6I5x3MJWHqBx80X27QWeKjrRdEMPWe1d8V5mxLpeRvBdJj
 wwijWMD+W+CmQ2+6wa/r3i+oVWy8lJ03QGarpEfGG9Y8Hn7SuyurBnS5AA2Wiz2XRcqJndCncDa
 +v82IsVJa6qB2jK52HQ46GBzalRL3NjkVI532lHqz6vTFsWVupRNJ6tzkKYKGHmGP9cAF/PqaKQ
 lH4kxNYYqWNY8lKwvgzA+2C5a1g4Y79EejnQLJednWJqI2Vz6VDbq7ARVH1qEYMXweVCLRsX2w3
 ZOhhI740oirzbGxlQTSvwPy/JxlOc6deByEsd1e0owEQ7WGmMNxnbwgNHZgbK7ijhdRK7DriP69
 FNG9QsZXoJ79QJkgPKJOb2A3wmqo3GYq6qF/X1T3zF5l90q6k8OgroFC9O9IC3IVTznMOa4cvfd
 ksrrujp8QXosxmUWT0VK2uRR49Xnnn9B2SEYwqQ2WS5eUAm+nJMl9RB6jnvkitIDhnKcZx4u+oq
 YBXBK9f1fIzV36vycwqws3aTMVZIQvGCafsgTYIjzUn6yyyxgWXoY3HkbOa7e6HsjM7qFGI+I+1
 Dny5qYhaSRi9Skw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

There are a couple of problems with delegated timestamp updates via
setattr:

1/ the ia_ctime is always clobbered by notify_change(), so setting the
ia_ctime to the same value as the ia_mtime in nfsd4_decode_fattr4()
doesn't work.

2/ while it does test the ctime's validity vs. the existing ctime and
current_time(), the same is not done for the atime or mtime. The spec
requires this.

Add a new setattr_copy_delegts() function that handles updating the
timestamps whenever ATTR_DELEG is set. For both atime and mtime,
validate and clamp the value to current_time(), and then set it. If the
mtime gets updated, also update the ctime.

Fixes: 7f2c86cba3c5 ("fs: handle delegated timestamps in setattr_copy_mgtime")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c         | 52 ++++++++++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4xdr.c |  4 +---
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..3e636943d26a36aeeed0ff8b428b6dd3e63f8dde 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -287,14 +287,7 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 	struct timespec64 now;
 
 	if (ia_valid & ATTR_CTIME) {
-		/*
-		 * In the case of an update for a write delegation, we must respect
-		 * the value in ia_ctime and not use the current time.
-		 */
-		if (ia_valid & ATTR_DELEG)
-			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			now = inode_set_ctime_current(inode);
+		now = inode_set_ctime_current(inode);
 	} else {
 		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
 		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
@@ -312,6 +305,39 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 		inode_set_mtime_to_ts(inode, now);
 }
 
+/*
+ * Skip update if new value is older than existing time. Clamp
+ * to current_time() if it's in the future.
+ */
+static void setattr_copy_delegts(struct inode *inode, const struct iattr *attr)
+{
+	struct timespec64 now = current_time(inode);
+	unsigned int ia_valid = attr->ia_valid;
+
+	if (ia_valid & ATTR_MTIME) {
+		struct timespec64 cur = inode_get_mtime(inode);
+
+		if (timespec64_compare(&attr->ia_mtime, &cur) > 0) {
+			if (timespec64_compare(&attr->ia_mtime, &now) > 0)
+				inode_set_mtime_to_ts(inode, now);
+			else
+				inode_set_mtime_to_ts(inode, attr->ia_mtime);
+			inode_set_ctime_deleg(inode, attr->ia_mtime);
+		}
+	}
+
+	if (ia_valid & ATTR_ATIME) {
+		struct timespec64 cur = inode_get_atime(inode);
+
+		if (timespec64_compare(&attr->ia_atime, &cur) > 0) {
+			if (timespec64_compare(&attr->ia_atime, &now) > 0)
+				inode_set_atime_to_ts(inode, now);
+			else
+				inode_set_atime_to_ts(inode, attr->ia_atime);
+		}
+	}
+}
+
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
  * @idmap:	idmap of the mount the inode was found from
@@ -352,6 +378,8 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode->i_mode = mode;
 	}
 
+	if (ia_valid & ATTR_DELEG)
+		return setattr_copy_delegts(inode, attr);
 	if (is_mgtime(inode))
 		return setattr_copy_mgtime(inode, attr);
 
@@ -359,12 +387,8 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
 		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME) {
-		if (ia_valid & ATTR_DELEG)
-			inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			inode_set_ctime_to_ts(inode, attr->ia_ctime);
-	}
+	if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..e6899a3502332d686138abee2284c87fc7fbc0ae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -537,9 +537,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 			return nfserr_bad_xdr;
 		iattr->ia_mtime.tv_sec = modify.seconds;
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
-		iattr->ia_ctime.tv_sec = modify.seconds;
-		iattr->ia_ctime.tv_nsec = modify.seconds;
-		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
+		iattr->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
 
 	/* request sanity: did attrlist4 contain the expected number of words? */

-- 
2.50.1


