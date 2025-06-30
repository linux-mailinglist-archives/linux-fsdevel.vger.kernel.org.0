Return-Path: <linux-fsdevel+bounces-53279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02F7AED2B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9FC189546F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976D1D63E4;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YVTtB1p1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DB1C860E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=Q83bt2Ol1MkohwMiCqFqAyFE6iSFWKW/4/GEAkCFWUW1sOr3GVYo91PIVBczrNUwCGq/WxZm49f+iMzKV7oggnQRMtmrxmTXfJJYWM4qh7iA/MExykjvce5pceb3HXG/8pACr6jtCkJ1EvThIUaaL/IpvQzs0ZWAMr3UgEQ0OSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=HHIZfSLMRZDz/5nvW3FLVmJvB3gh9pdx0pzk8ByJ2PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrQPp83LlK5su60WCGl1HVo8TRucy5WPrJn790Hqg7bvUStMk3Z4UwOz1CpYQnk25TAXIIcWY1Vk5vab5KWrsEqzDTfRp8EaJipvSeDQyIVVikEqn9t0ujrrXK7cksMEnHyrF6DcKJjurb6wGNhzZRUzRs2PhR1t/6Z+kgJc7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YVTtB1p1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EXjMAkV5SYZoLQkyoEW4EZj/mUVKg3vGnrrE5VmUzIM=; b=YVTtB1p1q6Z4+RpIXskWIIUp84
	6ozBSuIrmLyWv+Lh7XmCuxuLTCRwSQQTduCc6f0l/5Z+jCu2NOf9c4ZYsZuG68XvFIFZXe3t70FMD
	OTsBMIzvMJuh2M/Kq/cgllIVX6iGG2wBQrnUd5YAWkDv+1IggM/4X2GyP85xmL/RMucfeus3n7uhQ
	ln6jeerRU0tS53GwKPGLTaI3snk6J2QW1LbAObPfp6OuyCgsW4wpMqK8ArGGy7st3ZNyk8G/jnpOP
	Dl+kvPdG1nUidmCwrKjQwFY+pb06Ceurji8K9LLYILHRMctwJ902ZI7rr47KtjtYd2LfSHXsVHtEU
	sjr7vtyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4df-00000005p27-2NpU;
	Mon, 30 Jun 2025 02:52:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 37/48] propagate_mnt(): fix comment and convert to kernel-doc, while we are at it
Date: Mon, 30 Jun 2025 03:52:44 +0100
Message-ID: <20250630025255.1387419-37-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Mountpoint is passed as struct mountpoint *, not struct dentry *
(and called dest_mp, not dest_dentry) since 2013.

Roots of created copies are linked via mnt_hash, not mnt_list since
a bit before the merge into mainline back in 2005.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index b3af55123a82..b887116f0041 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -253,21 +253,20 @@ static struct mount *find_master(struct mount *m,
 	return last_copy;
 }
 
-/*
- * mount 'source_mnt' under the destination 'dest_mnt' at
- * dentry 'dest_dentry'. And propagate that mount to
- * all the peer and slave mounts of 'dest_mnt'.
- * Link all the new mounts into a propagation tree headed at
- * source_mnt. Also link all the new mounts using ->mnt_list
- * headed at source_mnt's ->mnt_list
+/**
+ * propagate_mnt() - create secondary copies for tree attachment
+ * @dest_mnt:    destination mount.
+ * @dest_mp:     destination mountpoint.
+ * @source_mnt:  source mount.
+ * @tree_list:   list of secondaries to be attached.
  *
- * @dest_mnt: destination mount.
- * @dest_dentry: destination dentry.
- * @source_mnt: source mount.
- * @tree_list : list of heads of trees to be attached.
+ * Create secondary copies for attaching a tree with root @source_mnt
+ * at mount @dest_mnt with mountpoint @dest_mp.  Link all new mounts
+ * into a propagation graph.  Set mountpoints for all secondaries,
+ * link their roots into @tree_list via ->mnt_hash.
  */
 int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
-		    struct mount *source_mnt, struct hlist_head *tree_list)
+		  struct mount *source_mnt, struct hlist_head *tree_list)
 {
 	struct mount *m, *n, *copy, *this;
 	int err = 0, type;
-- 
2.39.5


