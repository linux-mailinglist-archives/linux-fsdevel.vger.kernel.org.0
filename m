Return-Path: <linux-fsdevel+bounces-53277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1764AAED2B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6BA18914B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739F214813;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AyunrFDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCD19C553
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=U/Tv5sLepldje+pbU2GnnUaIab0PBnN7Fwm2qv+D2qGwSSRad4s41pTo+O6x7jaSrGc0MxA0oz+AWxkHXY6RbLiHoIcFdL1aWDmG5QAVKCvgXlzegKvmx/AhA2oJOYnhqsqQ/ACoZiSAfe8lHyz1ppxMYZo0jiMB/Kmbu8p83Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=7+nRLkI2BGiIGoBCUEvska2PQrn17cUxtSvZvsToIW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vosbqmh0hlfz191ZUuJTLjL/BVBFUUylf8BahmPJifneyH05KQCynEUPDUECu8Saur0gYwTQdmxE1n8Je5io29kKvGB2AZR1ZGMyNcJQrlmMuRbT/e/4HnKbOHYC5swGC5MrM7M+88K/L5/Su/Ir4L5iZeF0fEovLw2Ao1PYTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AyunrFDG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C0L7ZR/sV713+aO4AW64z+kyy6DhyQ8BElm+SV0YamU=; b=AyunrFDGmD9UpBaM7i+H1W+TWf
	hEQnW7J64bM7JrzqTDhdXIhgEr3bmFVGv9amv3/VFmPHmbAA30rL0CpKRbs41ykFRu2bL1Go3ejKe
	3lx/Oft1viJcSYkRt24PPxB8CVOb3f239mA6BeNpgQWXm7xWPq/OhLazVnwu1tkxHxJgIGh2emaMI
	ec1KYJKCfsKGoWbjhpBPZa1V4snmeOdR1N4T5hBczldZL+C/T8LJUrTKnScf+PEvYEn4A6bmlgmen
	BqTuUocfHmPxy0rkrXynX//tQPbiYAed0935cJdU1Ma+TpYdLRaoQAyy9yAr1kyHL+bTA/jIRXrog
	poA4+ciQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4de-00000005p1O-2pPn;
	Mon, 30 Jun 2025 02:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 31/48] propagate_mnt(): handle all peer groups in the same loop
Date: Mon, 30 Jun 2025 03:52:38 +0100
Message-ID: <20250630025255.1387419-31-viro@zeniv.linux.org.uk>
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

the only difference is that for the original group we want to skip
the first element; not worth having the logics twice...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 870ebced10aa..f55295e26217 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -289,7 +289,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		    struct mount *source_mnt, struct hlist_head *tree_list)
 {
 	struct mount *m, *n;
-	int ret = 0;
+	int err = 0;
 
 	/*
 	 * we don't want to bother passing tons of arguments to
@@ -303,26 +303,23 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	if (dest_mnt->mnt_master)
 		SET_MNT_MARK(dest_mnt->mnt_master);
 
-	/* all peers of dest_mnt, except dest_mnt itself */
-	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
-		ret = propagate_one(n, dest_mp);
-		if (ret)
-			goto out;
-	}
-
-	/* all slave groups */
-	for (m = next_group(dest_mnt, dest_mnt); m;
-			m = next_group(m, dest_mnt)) {
-		/* everything in that slave group */
-		n = m;
+	/* iterate over peer groups, depth first */
+	for (m = dest_mnt; m && !err; m = next_group(m, dest_mnt)) {
+		if (m == dest_mnt) { // have one for dest_mnt itself
+			n = next_peer(m);
+			if (n == m)
+				continue;
+		} else {
+			n = m;
+		}
 		do {
-			ret = propagate_one(n, dest_mp);
-			if (ret)
-				goto out;
+			err = propagate_one(n, dest_mp);
+			if (err)
+				break;
 			n = next_peer(n);
 		} while (n != m);
 	}
-out:
+
 	hlist_for_each_entry(n, tree_list, mnt_hash) {
 		m = n->mnt_parent;
 		if (m->mnt_master)
@@ -330,7 +327,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	}
 	if (dest_mnt->mnt_master)
 		CLEAR_MNT_MARK(dest_mnt->mnt_master);
-	return ret;
+	return err;
 }
 
 /*
-- 
2.39.5


