Return-Path: <linux-fsdevel+bounces-53254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1BAED294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354723B4DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906481DF723;
	Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qJQUvAMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08828191F92
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=jfflzrzD1IWcnUwYBYUao3ca3KRfTSu3iZUeKe1Eda6b8ulv9WUpZD1z5o2f+a8+v1cWUt+9lekwpyV4+RVd/g2f+Ksa39hW5ApoqjOwXFBoOurjkCd446urPm7H6OnKRHxcZPh7TowtcY1LFJRvxe7tjr1FQ8YuqosUPhsMvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=XM0aiAO8sHArIUmXK9BSg4aR0qVtqElyd08qoTIxCDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7rIrRVZot2pifi8Z72SgaCSSr72Kxx7NRYd0K/dHktp/hg6u0KpU9AHlXugpj3vTDydKc4qf+pmzTh0VcGeK3M96zwByrV/L0aBxVSckstUv0u85fVvLqcMBSJnWMRhh6qRFSLSad4DTuejMDpzzG3WkqwWcmmOfB6IUcIHS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qJQUvAMO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nFmy63mTkkNKchzq/vI+oHZQFlAXDPXxkKziHzjyDZ0=; b=qJQUvAMOcTaDsZJNYjHkM7EMT1
	0UJEt2UwMezCluD32kHFzL8cHvBI9wBnZcH+20RX/y9+d9bGiW5jPCkqNCFL4JnueJBdlSTby/fs9
	LgCxLzK5scaOxi+AKbyYGYwQk7aa5N95gYGx19f28a9WVWuHep0ho9zlbl36p1LL/5HdXAFtDOsaE
	sc2QNMIhu4+esOyriXFH3kckS2Ilal13mCzw6OS3ByLBlA6enK5XG1KI5lCNtdThriIBvArs5WI8d
	HtV5yBaXzx+usUand8YLWKvHAkkJa79ZqWK5Su4nVxNvY5xNBZwiTPT072cAfruasTJvsr1L7BhqJ
	gAnUiJMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005oxH-2gY2;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 14/48] do_umount(): simplify the "is it still mounted" checks
Date: Mon, 30 Jun 2025 03:52:21 +0100
Message-ID: <20250630025255.1387419-14-viro@zeniv.linux.org.uk>
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

Calls of do_umount() are always preceded by can_umount(), where we'd
done a racy check for mount belonging to our namespace; if it wasn't,
can_unmount() would've failed with -EINVAL and we wouldn't have
reached do_umount() at all.

That check needs to be redone once we have acquired namespace_sem
and in do_umount() we do that.  However, that's done in a very odd
way; we check that mount is still in rbtree of _some_ namespace or
its mnt_list is not empty.  It is equivalent to check_mnt(mnt) -
we know that earlier mnt was mounted in our namespace; if it has
stayed there, it's going to remain in rbtree of our namespace.
OTOH, if it ever had been removed from out namespace, it would be
removed from rbtree and it never would've re-added to a namespace
afterwards.  As for ->mnt_list, for something that had been mounted
in a namespace we'll never observe non-empty ->mnt_list while holding
namespace_sem - it does temporarily become non-empty during
umount_tree(), but that doesn't outlast the call of umount_tree(),
let alone dropping namespace_sem.

Things get much easier to follow if we replace that with (equivalent)
check_mnt(mnt) there.  What's more, currently we treat a failure of
that test as "quietly do nothing"; we might as well pretend that we'd
lost the race and fail on that the same way can_umount() would have.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 12cf69da4320..57b0974a5d1e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1983,8 +1983,11 @@ static int do_umount(struct mount *mnt, int flags)
 	namespace_lock();
 	lock_mount_hash();
 
-	/* Recheck MNT_LOCKED with the locks held */
+	/* Repeat the earlier racy checks, now that we are holding the locks */
 	retval = -EINVAL;
+	if (!check_mnt(mnt))
+		goto out;
+
 	if (mnt->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
 
@@ -1993,16 +1996,14 @@ static int do_umount(struct mount *mnt, int flags)
 
 	event++;
 	if (flags & MNT_DETACH) {
-		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
-			umount_tree(mnt, UMOUNT_PROPAGATE);
+		umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
 		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
-			if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
-				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+			umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 			retval = 0;
 		}
 	}
-- 
2.39.5


