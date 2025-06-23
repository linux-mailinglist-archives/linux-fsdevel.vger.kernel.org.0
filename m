Return-Path: <linux-fsdevel+bounces-52445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADAAE3472
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CE916D333
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B881DF97C;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wwQeVZjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC01C6FFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=IysOmMwOBBMEK0TAUowq5vDnrivzHadbFvuongkawU5Z5nFkAlk9xkCCkAgMArJUAc/6f2lSwQBduMMYuZ6UDft3ys2FD0+iy84BhbYyMvJ7k5rs5ZwliPXov0Z6NjwA09aZ+6i/Jpo5X6RZg2LTZ/2Qsd0Cjzhkkx46x/Xq0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=3xH9yDxY19J3NSn82mGwz0biSNOboD7HA6foVkfwheE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArlNMhgKFBg60I2QsMABTay77g9iN/CcA3Cxk5o0ibdtiYJ511+hpUlWcmZevl46CZVr37RszJ0cX33jkgSbnuomby3wfZ5FDq3rBR4llVEYuSh/aaWMBsUy7mMqrbhUszsR4AAAn+zV+JfuMLvpa9jSIcc8ingrpjNKaLB5/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wwQeVZjB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JcP3QrPi0F8umk24r6u6Citrm+zoXWSxNWkwzHtezZ0=; b=wwQeVZjBz8iZGInL7tk4NBux3U
	fo9lX7USoJEplnMxGvJ2Zjy6nWVJS2hnQGwmyund5c1F6LBXUQH9KEwfnkN5ymarg9ACYDcMgmFCJ
	JPvNa9Pb5cnOylifbSjHFt2gSpkP6/1djln0jYMr84EDoKPspdsI6gV8/sNvcCcuT14MRGo6on6xO
	j2kZPwg3e0jNK+X7BBTIaiMJQKNMmC9YrLEI1k2kSIMAuZ04PRnA9dEa/eNoIZJeOFVVPqX0+jRyW
	u2asutCjtM9rvbnaL+0uucoRt7rttXL21OMOggEmHLOqmlwMqm2/mAg64f7OC+ngrcBpFigLcGV0j
	INFSfJBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005KpA-1KD3;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 09/35] new predicate: mount_is_ancestor()
Date: Mon, 23 Jun 2025 05:54:02 +0100
Message-ID: <20250623045428.1271612-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

mount_is_ancestor(p1, p2) returns true iff there is a possibly
empty ancestry chain from p1 to p2.

Convert the open-coded checks.  Unlike those open-coded variants
it does not depend upon p1 not being root...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e5b4ea106b94..7454f9efaa27 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3483,6 +3483,17 @@ static inline bool path_overmounted(const struct path *path)
 	return unlikely(!no_child);
 }
 
+/*
+ * Check if there is a possibly empty chain of descent from p1 to p2.
+ * Locks: namespace_sem (shared) or mount_lock (read_seqlock_excl).
+ */
+static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
+{
+	while (p2 != p1 && mnt_has_parent(p2))
+		p2 = p2->mnt_parent;
+	return p2 == p1;
+}
+
 /**
  * can_move_mount_beneath - check that we can mount beneath the top mount
  * @from: mount to mount beneath
@@ -3534,9 +3545,8 @@ static int can_move_mount_beneath(const struct path *from,
 	if (parent_mnt_to == current->nsproxy->mnt_ns->root)
 		return -EINVAL;
 
-	for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
-		if (p == mnt_to)
-			return -EINVAL;
+	if (mount_is_ancestor(mnt_to, mnt_from))
+		return -EINVAL;
 
 	/*
 	 * If the parent mount propagates to the child mount this would
@@ -3705,9 +3715,8 @@ static int do_move_mount(struct path *old_path,
 	err = -ELOOP;
 	if (!check_for_nsfs_mounts(old))
 		goto out;
-	for (; mnt_has_parent(p); p = p->mnt_parent)
-		if (p == old)
-			goto out;
+	if (mount_is_ancestor(old, p))
+		goto out;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
 	if (err)
-- 
2.39.5


