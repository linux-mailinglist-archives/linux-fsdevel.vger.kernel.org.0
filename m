Return-Path: <linux-fsdevel+bounces-60082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A432EB4141D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 07:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623D03B31AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883632D7DE2;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MCrDhrnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14D2D7DF6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875348; cv=none; b=CjPPS0ZIQcXt3KigSN0ZIEx1Qmruhxm+j9kNBl5kuRPfkL66D0QDS7G4G9vOCHFVjKuMxDwRNtvf1y9KHcT62j7c441FWhuEL9txkYhFQGTdqsevgmOlfO8CnEQ/5FkUFszJs0Pv/5MaVcHkNULa+z7LHj+VnPbsnjV5eznZTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875348; c=relaxed/simple;
	bh=PE0Dbpjxru8hciFSdjQI4IFUqr+Zs43zxn9IU8153Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6zM6cynO+b9HaTCfOY1aSjdEtZ8sRu7U5yKN+uTsGXWnizGmnHvMsp2Z47jzhuzF9dwMUB+GHQ3cj3WwzWKwoWIlcbau9Xujm2g3mS76cFp1/jBnyN1xp+1hIf42ijxsXNLRdZZTH3YleYci0A82TqNCLNXEiOYXc2W6Ugcos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MCrDhrnM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BV1eJYJ7ThjNWy+N2bbQ7lwyzHRAuIwkIwGq+IlhM6c=; b=MCrDhrnMNBmBgITvuoYAvhahF1
	50NsdS83UYHZ5OwD1OXhpjhmjwQlTT1Gc/+NpX0aU/Jq/oS08G8F79Q70QZSas3mOQeV5Ppxf7ISd
	MEuKgLIM3A267S25j1XvevGnPJNEQGCWbn0FTGcy/lUxsg9vs40uJHf2EBt7rfFATX6y/vUsOkxg/
	g73AjFiTvn3Id2KQIbx+LyPztINtVxZnr0dXxhn9KVCal7bUJhldwCHqKG8AG9Ae+JvvRts7AXQ3A
	Zv7/GK38vKgOHqkT4VjH/d5veHDYb5FHO4J1dWFFaxp+svAp21hW4QZ2nTg3G/d/++n/FkEiTQkfs
	q4226kww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX7-0000000ApCf-1TX0;
	Wed, 03 Sep 2025 04:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 40/65] collect_paths(): constify the return value
Date: Wed,  3 Sep 2025 05:55:02 +0100
Message-ID: <20250903045537.2579614-41-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

callers have no business modifying the paths they get

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        | 4 ++--
 include/linux/mount.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 704eff14735d..759bfd24d1a0 100644
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


