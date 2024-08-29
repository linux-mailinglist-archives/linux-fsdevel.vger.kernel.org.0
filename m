Return-Path: <linux-fsdevel+bounces-27842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B904964695
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131F4281136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188C1B4C25;
	Thu, 29 Aug 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrHQVTng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DA1B3F1C;
	Thu, 29 Aug 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938029; cv=none; b=UNZehtgZodj1IuQjReOaSV4y7gwSsaNl70rnY7IPSumK7QpvGbf6KzuiqGzjG2PenWMiaB4jP7oc6YwVahDNmxHt0VuaoNKIzojPTEwwVJ3C8bWjkQqJcIAC+ChyHLOlp/q0VnvDPCIxGsnh238YDByvFQwvgHRCBxry4xDfdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938029; c=relaxed/simple;
	bh=LiV0clf9L6NQX5LxYkFyOmngi4CQOovdgBWSLgxIFp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzMtILGDWneaZE24nknLa/8MWYR963+pTbn/96SxzJ1GuRTAqtuym1gsBsUG6f2QzXEpWM0jrE3xq15chBL30sB5MLZnyTac4bUmrGl8lYBPeYbmVA6JM774Z1DDxoK0TCgIE9jntGIVkHN+6QMl1yX6QukC+gYYyucv7WI4PAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrHQVTng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D276C4CEC7;
	Thu, 29 Aug 2024 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938028;
	bh=LiV0clf9L6NQX5LxYkFyOmngi4CQOovdgBWSLgxIFp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YrHQVTngZZ/1IQ9bDXBLFXR0iubrYHxp6Y4eN6pm/EISlBsHQGwJNxXAG73KAB4eY
	 qbsxXu3Bqs9be5gPNnJT+Z+WFNfoqUCXUEvcQOeDiliDoXSi+rcaxCdbEXW/Q7n44g
	 /wFpSYgD9GzCTLV2J+zFIZsiXoHpS3dNVFegWoNuQXflSLCQxrIyaLbZZ45njh9uEo
	 N0u2G/9j3wTIz+LcuR+vk+V1RTq4Vp3Zw07xWE3CF2TTCQ/eDdXN/H+0pYjM21b38y
	 fuVrCiUSis0DW0RSBOG2Jq4JoG7VYRyPENyuDbZRovVwg5OAOAE4imk0TvCpwL2nug
	 LC+Q3agfPktbg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:49 -0400
Subject: [PATCH v3 11/13] fs: handle delegated timestamps in
 setattr_copy_mgtime
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-11-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6296; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LiV0clf9L6NQX5LxYkFyOmngi4CQOovdgBWSLgxIFp8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcYsGRT/Hg0/UhwWErfUgDndlc9/qEX7oIEH
 W+bEv3QoW6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3GAAKCRAADmhBGVaC
 FXdRD/96A29Ruw6BLNUsoLlPcOC5dsqJ7itF/Nxm+ExHHgKpXK02eFmxzq/3sorQHZj+uvIg3N1
 rnIZBFls4lOv1sCv3DrzHAnXBx+2H6LE/ZbNr2m+Uthqd/5tZC0rSLnswJ7uVkueo08TrXho9aH
 nu2tclMvx+eSu7DLkH4QD/VJxTh1HQRkF+QDI+LdLrKohGaLKFs670xcoFIUabhRy9wDBJp9nC6
 oPB1ZCYtMDI5rHi5XGCyZ2Wpscfc3JzdQ8uCByv8QHiLGdQ6/6Dlp0KRcusEOABBf95qE7nUyhr
 HYpJBSq+6DFZtM7mhS1ey0QXTY+bVXTjByuH2dl8F439ye1oMc6BsSJ0tWUP2DVQBRtM1XNBEvB
 Z674XdGDwKp2N1F746lCblBqjA1mryK6ZClqJ4VebdUFY2l6KLFvBfDqMvbFP4QKhw8rs33L0QZ
 98wAGVBGI0g9dQmN9L3Cp3+icGSVkdt6zBlWrbiwymuw+XQKsDKWEnFS+xwcJy+XkC+eegQySmR
 5GmqDYeGTlMWgPlWfiBHkTxJnq9pQAI9Tbpa6OTGoyxzPgKIDqz+ZLrN0VfJy036W1lPRPuGlY4
 RaV2N+HSQTCOvA/DInAqH3EJ6CoOmZaZkSqmmuXqSERihPx6v5NiLfFfPfxmn5trcuSoNOBIn2I
 wy1SHvTdob2CTiQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When updating the ctime on an inode for a SETATTR with a multigrain
filesystem, we usually want to take the latest time we can get for the
ctime. The exception to this rule is when there is a nfsd write
delegation and the server is proxying timestamps from the client.

When nfsd gets a CB_GETATTR response, we want to update the timestamp
value in the inode to the values that the client is tracking. The client
doesn't send a ctime value (since that's always determined by the
exported filesystem), but it can send a mtime value. In the case where
it does, then we may need to update the ctime to a value commensurate
with that instead of the current time.

If ATTR_DELEG is set, then use ia_ctime value instead of setting the
timestamp to the current time.

With the addition of delegated timestamps we can also receive a request
to update only the atime, but we may not need to set the ctime. Trust
the ATTR_CTIME flag in the update and only update the ctime when it's
set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 28 +++++++++++++--------
 fs/inode.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 3bcbc45708a3..392eb62aa609 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -286,16 +286,20 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	struct timespec64 now;
 
-	/*
-	 * If the ctime isn't being updated then nothing else should be
-	 * either.
-	 */
-	if (!(ia_valid & ATTR_CTIME)) {
-		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
-		return;
+	if (ia_valid & ATTR_CTIME) {
+		/*
+		 * In the case of an update for a write delegation, we must respect
+		 * the value in ia_ctime and not use the current time.
+		 */
+		if (ia_valid & ATTR_DELEG)
+			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
+		else
+			now = inode_set_ctime_current(inode);
+	} else {
+		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
+		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
 	}
 
-	now = inode_set_ctime_current(inode);
 	if (ia_valid & ATTR_ATIME_SET)
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	else if (ia_valid & ATTR_ATIME)
@@ -354,8 +358,12 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
 		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
+	if (ia_valid & ATTR_CTIME) {
+		if (ia_valid & ATTR_DELEG)
+			inode_set_ctime_deleg(inode, attr->ia_ctime);
+		else
+			inode_set_ctime_to_ts(inode, attr->ia_ctime);
+	}
 }
 EXPORT_SYMBOL(setattr_copy);
 
diff --git a/fs/inode.c b/fs/inode.c
index 01f7df1973bd..f0fbfd470d8e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2835,6 +2835,80 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
 
+/**
+ * inode_set_ctime_deleg - try to update the ctime on a delegated inode
+ * @inode: inode to update
+ * @update: timespec64 to set the ctime
+ *
+ * Attempt to atomically update the ctime on behalf of a delegation holder.
+ *
+ * The nfs server can call back the holder of a delegation to get updated
+ * inode attributes, including the mtime. When updating the mtime we may
+ * need to update the ctime to a value at least equal to that.
+ *
+ * This can race with concurrent updates to the inode, in which
+ * case we just don't do the update.
+ *
+ * Note that this works even when multigrain timestamps are not enabled,
+ * so use it in either case.
+ */
+struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 update)
+{
+	ktime_t now, floor = atomic64_read(&ctime_floor);
+	struct timespec64 now_ts, cur_ts;
+	u32 cur, old;
+
+	/* pairs with try_cmpxchg below */
+	cur = smp_load_acquire(&inode->i_ctime_nsec);
+	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
+	cur_ts.tv_sec = inode->i_ctime_sec;
+
+	/* If the update is older than the existing value, skip it. */
+	if (timespec64_compare(&update, &cur_ts) <= 0)
+		return cur_ts;
+
+	now = coarse_ctime(floor);
+	now_ts = ktime_to_timespec64(now);
+
+	/* Clamp the update to "now" if it's in the future */
+	if (timespec64_compare(&update, &now_ts) > 0)
+		update = now_ts;
+
+	update = timestamp_truncate(update, inode);
+
+	/* No need to update if the values are already the same */
+	if (timespec64_equal(&update, &cur_ts))
+		return cur_ts;
+
+	/*
+	 * Try to swap the nsec value into place. If it fails, that means
+	 * we raced with an update due to a write or similar activity. That
+	 * stamp takes precedence, so just skip the update.
+	 */
+retry:
+	old = cur;
+	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
+		inode->i_ctime_sec = update.tv_sec;
+		mgtime_counter_inc(mg_ctime_swaps);
+		return update;
+	}
+
+	/*
+	 * Was the change due to someone marking the old ctime QUERIED?
+	 * If so then retry the swap. This can only happen once since
+	 * the only way to clear I_CTIME_QUERIED is to stamp the inode
+	 * with a new ctime.
+	 */
+	if (!(old & I_CTIME_QUERIED) && (cur == (old | I_CTIME_QUERIED)))
+		goto retry;
+
+	/* Otherwise, it was a new timestamp. */
+	cur_ts.tv_sec = inode->i_ctime_sec;
+	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
+	return cur_ts;
+}
+EXPORT_SYMBOL(inode_set_ctime_deleg);
+
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
  * @idmap:	idmap of the mount @inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index eff688e75f2f..ea7ed437d2b1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1544,6 +1544,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 
 struct timespec64 current_time(struct inode *inode);
 struct timespec64 inode_set_ctime_current(struct inode *inode);
+struct timespec64 inode_set_ctime_deleg(struct inode *inode,
+					struct timespec64 update);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {

-- 
2.46.0


