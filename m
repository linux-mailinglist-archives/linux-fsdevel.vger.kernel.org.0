Return-Path: <linux-fsdevel+bounces-51131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8FAD3004
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5BC170CCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742328315F;
	Tue, 10 Jun 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pmS0fQ3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B7280300
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543715; cv=none; b=OW7eGtupOPAyCGBsZMR/E8hxt77njEcnym5HWoO/VXqWXhyC/zA0TZWBXKX21Ka8x86MFO29f/0OOqUh5vV6PVdSYRLW594jZKlUKwtI0R5GL6XxAze7PlJiPgEiV9hnGi+VhY9q3JTjEgPRV+GvH7u4F7FJDucdgNNuz34HaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543715; c=relaxed/simple;
	bh=uqmKDYMVGGOUA/JopXYulHT/aK7bSPUlFf6gDwByCN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcg2PWS2I2x/o/Tf3EC7bt6M8orhRdg55UBj7LCYjtrdvwGbFC0PdT71iIAa79zf9Kdv4IN6lLJRTnP3MzLijRQ17guWOLhc5Z4KYw1tg/ZFgNS+g9ZWAjjvrdR2cklyR8KPofCYOfoB26Rgu2rrQevg+DFhdYuDzgwrXiBhj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pmS0fQ3U; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dtJ6XhqUwDZZ3YOxSFR/Apvh4d5t3nb/IGgGLf/cP6E=; b=pmS0fQ3Ur6VSBcp/X7lD6MTVec
	CVwbsG94vl7yClpl72a7UimSk3MA5ZWtYimFyeN+4fWtOesBz3Jitj4XdzgayG1p+bYnU+EumLQyw
	/MR2wXMGyT9PNQhdyN+SplFXit8zNwB2LVAXuSZ2bnaVydTSkP6qmNncV8Q/SaoZPT2+EIOD7ImD+
	LZbFqRN2yZ/WR8A1M7wbGE8/l9ruUiDy3m2wb0DQHC17YDheR/HLePfpSjY9SxNMJJTKFd5hvQB5J
	snxHeLYdMAtBlQUd88byVZymRR1VoB9Xg9qUHaxdPwUQdPxhAt2GxIxeuPTpcozdmtdOQUpLqhcuK
	DYYw3KWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEw-00000004jMV-22sL;
	Tue, 10 Jun 2025 08:21:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 10/26] do_umount(): simplify the "is it still mounted" checks
Date: Tue, 10 Jun 2025 09:21:32 +0100
Message-ID: <20250610082148.1127550-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 02e9f37f49b9..5e82f1ef042a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2019,8 +2019,11 @@ static int do_umount(struct mount *mnt, int flags)
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
 
@@ -2029,16 +2032,14 @@ static int do_umount(struct mount *mnt, int flags)
 
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


