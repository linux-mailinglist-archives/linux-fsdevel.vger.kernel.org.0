Return-Path: <linux-fsdevel+bounces-58937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74167B3358C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F341B243F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6B284665;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PBZeeHqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9D27F017
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097044; cv=none; b=lRAO5dr768h5zZH6z+N0PcPxyqSJqFSSz4Rq6j9Un/2h28fkBw6TGKjJKZF1RWoA1tblr3tqA8pwq9pwXDvhKZ4MPQZSmX7rCqWjKtbv+FTReat4P97OKyc7U2JEwKow4yWs8n6WyP8kk8J6F4XwkNduycNXFs9L3wVJXRwTZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097044; c=relaxed/simple;
	bh=EtkJGij85A48dMQMbcZI0xZeXewQQaCVUXqOApqjY60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0vTeme1CScK3uMacur+YLE1K1Os9creZi2KMAkehtAQ+NNrbq7d7XiCKMSeB3Ewxe6ukJUJ6h+rzYdBbYXaXsa2z9ig7rfBzTrGCP3W/CCYDeOOBUpPSqAm75uKYnznac+sAvxsz3xQcC5q+hoMmCjYx97h948aci+G2XELj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PBZeeHqd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rOlXC9ssrOXozcmQnkaELi433C+lLPgFcWSPEmPYtsg=; b=PBZeeHqdQ9215sLJWURtSXgO8u
	ol1iV4b7rJuCm7cCaekIBbl5k7aIR7Hfxmfpa6G/Op418gU2Nxl0Kjj4DQs18irNEaA/XxSwP5anu
	cyQVhv+GCD3jb/gDOoi4LFN76PCZKFrnhx0AYftvJVpfw/WjQpU/eQt6e0Wx4m2Nwl8Nch8dHf3+n
	oCh4ehx9K4W9Pmqg/OLgG9RQl8lPBmYflQr7FbNakmmMDlkplwXV+H6MlFKsahj3eHvNA6ShxxLYv
	GXF1Jh+9jChtycsgxTIizdb7B1npf+jzcAyfBUiwKYb77mtgowiZ6pNWgsqex3JjXKOQtVgfwTB9t
	juUiWM2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TED-3J3q;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 39/52] collect_paths(): constify the return value
Date: Mon, 25 Aug 2025 05:43:42 +0100
Message-ID: <20250825044355.1541941-39-viro@zeniv.linux.org.uk>
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

callers have no business modifying the paths they get

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        | 4 ++--
 include/linux/mount.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d29d7c948ec1..cc4e18040506 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2300,7 +2300,7 @@ static inline bool extend_array(struct path **res, struct path **to_free,
 	return p;
 }
 
-struct path *collect_paths(const struct path *path,
+const struct path *collect_paths(const struct path *path,
 			      struct path *prealloc, unsigned count)
 {
 	struct mount *root = real_mount(path->mnt);
@@ -2334,7 +2334,7 @@ struct path *collect_paths(const struct path *path,
 	return res;
 }
 
-void drop_collected_paths(const struct path *paths, struct path *prealloc)
+void drop_collected_paths(const struct path *paths, const struct path *prealloc)
 {
 	for (const struct path *p = paths; p->mnt; p++)
 		path_put(p);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index c09032463b36..18e4b97f8a98 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -104,8 +104,8 @@ extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 int do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
-extern struct path *collect_paths(const struct path *, struct path *, unsigned);
-extern void drop_collected_paths(const struct path *, struct path *);
+extern const struct path *collect_paths(const struct path *, struct path *, unsigned);
+extern void drop_collected_paths(const struct path *, const struct path *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 extern int cifs_root_data(char **dev, char **opts);
-- 
2.47.2


