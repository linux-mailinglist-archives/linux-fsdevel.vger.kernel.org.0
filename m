Return-Path: <linux-fsdevel+bounces-52453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D10AE3479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E59B3B05A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E621E8324;
	Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZoPURdNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3231D63F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654474; cv=none; b=YAyI7NHRggtR7KD6b+qVeNBKshZ/lZL/GBW7Ok7uiYj+V+/HCGEllHydC+R87zF5sRJEYqY0T4ZMqejViDJCcg+35gzib/0T3PrscxgEmUl0VIic1D8pAm0sMcl7m+2a61qmqYhxjGGUiPAEb0Wk7wMh4IY+4KoqpUe7ntSNKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654474; c=relaxed/simple;
	bh=FLTl/Lb+/Pf2zsqXNxdoqc3Ayl1fDcthgHzmi+Yng4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7kYXmBMqPDFpO/k7YjoHIKOD3b7sZQx2EFC4tMdGxAB1+n6MFVFoAQ7ftblXJHgtR5VwNT23V2frErRdS3koFwSGO01A6jhrLePcuzWA0GReFr4vn6WUJeB9V7fmKzkVP8SDkYxJ1ZAaRPXKV4tWJydcSH77mO5O/qtH4UCYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZoPURdNZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pbUlAwLSWfNvK+HnwtUXkiDI6czdMaZLeA+BuAdY/Qk=; b=ZoPURdNZPZ57z7ZLdnv7TGanY5
	B4eqD6RAc2eghR1q4sbfG7BzxtmuGSmzcS/6+X/rH6Bkq2Cq4Xa3XCdiNXTSVciy/MWzyEgdVLxwO
	SS5IpFNwP8Vmp2Dlxeuhi9TPEj7qEv9ZiMU6txKUHX08N8uAl9IWp7cfvwaW3GR0NuYzTkOXsqKnU
	/Rkcg/eWe2ZU2toNAjUWT88LaRl3Ij0vH/VG91iGzBmTwGSg4kRksahvYYxk3WSXQUGy7z/gUC+Vu
	YTCHYlryvwij4z3hua9m69sm1ZjL+8E798Bu3WYaBCIhFFywlQzHC4ynir9jyPL7x6bqJDH/pJ5CA
	YBb7M8YQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCR-00000005Kry-1cKH;
	Mon, 23 Jun 2025 04:54:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 21/35] attach_recursive_mnt(): pass destination mount in all cases
Date: Mon, 23 Jun 2025 05:54:14 +0100
Message-ID: <20250623045428.1271612-21-viro@zeniv.linux.org.uk>
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

... and 'beneath' is no longer used there

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6092aaf604a7..be3bfd99dc46 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2570,7 +2570,7 @@ enum mnt_tree_flags_t {
 /**
  * attach_recursive_mnt - attach a source mount tree
  * @source_mnt: mount tree to be attached
- * @top_mnt:    mount that @source_mnt will be mounted on or mounted beneath
+ * @dest_mnt:   mount that @source_mnt will be mounted on
  * @dest_mp:    the mountpoint @source_mnt will be mounted at
  * @flags:      modify how @source_mnt is supposed to be attached
  *
@@ -2635,20 +2635,20 @@ enum mnt_tree_flags_t {
  *         Otherwise a negative error code is returned.
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
-				struct mount *top_mnt,
+				struct mount *dest_mnt,
 				struct mountpoint *dest_mp,
 				enum mnt_tree_flags_t flags)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
-	struct mnt_namespace *ns = top_mnt->mnt_ns;
+	struct mnt_namespace *ns = dest_mnt->mnt_ns;
 	struct mountpoint *smp;
 	struct mountpoint *shorter = NULL;
-	struct mount *child, *dest_mnt, *p;
+	struct mount *child, *p;
 	struct mount *top;
 	struct hlist_node *n;
 	int err = 0;
-	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
+	bool moving = flags & MNT_TREE_MOVE;
 
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
@@ -2669,11 +2669,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			goto out;
 	}
 
-	if (beneath)
-		dest_mnt = top_mnt->mnt_parent;
-	else
-		dest_mnt = top_mnt;
-
 	if (IS_MNT_SHARED(dest_mnt)) {
 		err = invent_group_ids(source_mnt, true);
 		if (err)
@@ -3688,7 +3683,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, p))
 		goto out;
 
-	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
+	err = attach_recursive_mnt(old, p, mp, flags);
 	if (err)
 		goto out;
 
-- 
2.39.5


