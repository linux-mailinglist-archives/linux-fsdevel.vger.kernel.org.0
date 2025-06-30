Return-Path: <linux-fsdevel+bounces-53278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C0AED2AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF65167BC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342991C4609;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ciUA1kHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FC1C1AAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=NeH1JaehZuzpdby2lHYG0+6jYit3/wjLya5nJd5EPxzCCopmjsP1FHpvk3ruTudukQrI2U7TEPsjjb1mmsTW46uusxkF8i/5O/xJGYMuqHfB4kqGBHUyar/eEI4htbDqJBkXbhAfbbmc5pTzkjqwNEQbn/3ziJMkAhDHYSnbzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=D1H6wy+5kQETNR2B233ptfjfRR3Y5iEj2RWCqRhh72I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2cLoH1cq7F7pKarOD8Kokch/TjcN1RKVGZ6uXe2xOvzahW9GpgSsQTgQasggr7Nm9qmaAdIoxOEyf7KDPXpDuy4JGmrhqgsicu+SEaenAK8cRdQ6W72sbs474ZzatGJIsxQhcfuJA176/0YLZQHKiAFXlSnzayTiXzKdLBMLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ciUA1kHr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=en6HP2R17EAFEAljq++ZzN8H3my3I/Vm1mo4nnnITTk=; b=ciUA1kHrc/NxSZ02orryYO5jFJ
	6598o3jhIkgJ9ridACdcjG2lR53XQfRSRgm1V3MolVVyW+/d138Y1kwIiGFYnY1VYSwAwBUz28BJv
	nJBdAYYc3FvzgltURjMzPeoFrNB4BNOifhsDcWlzLLuEPiSZCAjx49GQKbvGlj8iQDazSMQk4AFdt
	32pJ+HzFFfdkd0XwYjQi6R6lv27tgOlObvg4PPAnmqI5QRAo9qXpOBeDU1y8oie5UrfpFcsgtyX7i
	v4hEYDguw4W3Oomrn90jV6l+6D+qqMeO5afbw0oZKahaLByOsz7oVcyEqSvOFUNWzatGyDL1r2z8h
	y5wU1oVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4df-00000005p1r-14qx;
	Mon, 30 Jun 2025 02:52:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 35/48] fs/pnode.c: get rid of globals
Date: Mon, 30 Jun 2025 03:52:42 +0100
Message-ID: <20250630025255.1387419-35-viro@zeniv.linux.org.uk>
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

this stuff can be local in propagate_mnt() now (and in some cases
duplicates the existing variables there)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index aeaec24f7456..e01f43820a93 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -214,10 +214,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 	}
 }
 
-/* all accesses are serialized by namespace_sem */
-static struct mount *last_dest, *first_source, *last_source;
-static struct hlist_head *list;
-
 static bool need_secondary(struct mount *m, struct mountpoint *dest_mp)
 {
 	/* skip ones added by this propagate_mnt() */
@@ -273,18 +269,11 @@ static struct mount *find_master(struct mount *m,
 int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		    struct mount *source_mnt, struct hlist_head *tree_list)
 {
-	struct mount *m, *n, *child;
+	struct mount *m, *n, *copy, *this, *last_dest;
 	int err = 0, type;
 
-	/*
-	 * we don't want to bother passing tons of arguments to
-	 * propagate_one(); everything is serialized by namespace_sem,
-	 * so globals will do just fine.
-	 */
 	last_dest = dest_mnt;
-	first_source = source_mnt;
-	last_source = source_mnt;
-	list = tree_list;
+	copy = source_mnt;
 	if (dest_mnt->mnt_master)
 		SET_MNT_MARK(dest_mnt->mnt_master);
 
@@ -303,26 +292,26 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 			if (peers(n, last_dest)) {
 				type = CL_MAKE_SHARED;
 			} else {
-				last_source = find_master(n, last_source, first_source);
+				copy = find_master(n, copy, source_mnt);
 				type = CL_SLAVE;
 				/* beginning of peer group among the slaves? */
 				if (IS_MNT_SHARED(n))
 					type |= CL_MAKE_SHARED;
 			}
-			child = copy_tree(last_source, last_source->mnt.mnt_root, type);
-			if (IS_ERR(child)) {
-				err = PTR_ERR(child);
+			this = copy_tree(copy, copy->mnt.mnt_root, type);
+			if (IS_ERR(this)) {
+				err = PTR_ERR(this);
 				break;
 			}
 			read_seqlock_excl(&mount_lock);
-			mnt_set_mountpoint(n, dest_mp, child);
+			mnt_set_mountpoint(n, dest_mp, this);
 			read_sequnlock_excl(&mount_lock);
 			if (n->mnt_master)
 				SET_MNT_MARK(n->mnt_master);
 			last_dest = n;
-			last_source = child;
-			hlist_add_head(&child->mnt_hash, list);
-			err = count_mounts(n->mnt_ns, child);
+			copy = this;
+			hlist_add_head(&this->mnt_hash, tree_list);
+			err = count_mounts(n->mnt_ns, this);
 			if (err)
 				break;
 		} while ((n = next_peer(n)) != m);
-- 
2.39.5


