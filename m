Return-Path: <linux-fsdevel+bounces-58911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE97B33566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D143C189EF2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF827D786;
	Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ae7MAvIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB9259CA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097040; cv=none; b=f6DZR0rRN6nz+6B28ab0/queV+nlRnvNwk5qbGUM1vV39ICMdDCRzGiho59QdkqAfuWwDVXfh7WCqlRCnWNJ2F2pulHtKrGbBW+z4P0BrcCT/daYTy3JM2wHo8kZ7e8Zphg31RJlxKAnUoyUAP1omsDEQPIA3MAxw96lx7bFW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097040; c=relaxed/simple;
	bh=2zbvfJElQq+vur1ojX1SLhPPuMaj1CNQJfzwUqRjpgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEBaPhOFLrB3+b14/HWEafCACTgwqvRrKPl8qDrBKJCNYPr1+j2MNFQySjMMjooG3WmnLCl/rPNuDYwpqsL69bng0QEd9ZVhyCTx0JaOT2mtGlB359AmejIhPbMITj/jC2xOQY1YYhclTv1ki2ijpLq3nx29RLubj6lkp/SoE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ae7MAvIJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BwUh33Fcq3RNe1+iIVG0VJc803Xw0BCf3P/Fjxd/wkI=; b=ae7MAvIJm65FP66iU1I4fBcbKy
	M0/Z7nh7n3fPt+T7CqIVWXtJAwaA5NPKnN2QxUp86M1hs7ni32IMOJKYfVQC61XVH0gkVF7nbCLSK
	nf5e5ph6dehYKJbdP5EJktxKbBBf6LgwudLCu03w2goaemYnVi4HP2KF4i4VtHjzal2lxsuG04U7i
	3yWKhOD+sfELSlJPzeeXEXIEcmC2Q+b7RS0etv2dJRGv3tedaPzIPFyw0h9mTDg8wb3hh6Mu1dGRd
	h41B9/FYscgrfAbXSe3HaPOPI8tqutcqcWbslDMJ3My5DKy8OfVSxFiw8QFflv9n9v2kXhp0Dzi2n
	TZsnDSzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T9U-3L9L;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 10/52] mnt_already_visible(): use guards
Date: Mon, 25 Aug 2025 05:43:13 +0100
Message-ID: <20250825044355.1541941-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

clean fit; namespace_shared due to iterating through ns->mounts.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 86a86be2b0ef..a5d37b97088f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6232,9 +6232,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 {
 	int new_flags = *new_mnt_flags;
 	struct mount *mnt, *n;
-	bool visible = false;
 
-	down_read(&namespace_sem);
+	guard(namespace_shared)();
 	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
 		struct mount *child;
 		int mnt_flags;
@@ -6281,13 +6280,10 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		/* Preserve the locked attributes */
 		*new_mnt_flags |= mnt_flags & (MNT_LOCK_READONLY | \
 					       MNT_LOCK_ATIME);
-		visible = true;
-		goto found;
+		return true;
 	next:	;
 	}
-found:
-	up_read(&namespace_sem);
-	return visible;
+	return false;
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
-- 
2.47.2


