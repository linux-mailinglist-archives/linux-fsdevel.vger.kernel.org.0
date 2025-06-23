Return-Path: <linux-fsdevel+bounces-52458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5BAE3482
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E7C189058D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074C1EFF80;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ObB9WOPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FA1C863A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654475; cv=none; b=CjzbPSJibv/ZJ1jqZWFDMgen2yce6Io3367BE17untdM+VUJymfSyJO99gikIpRfbfhleYU1jxXSytaYuTP4+NrdtWut5BwMrbR4Ety9W+R4U0Nc7f1EaubVtADNkOiR+4Ep6ICI044ttnfHdwWk0cPTgVsW4FwXexA8/MX+/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654475; c=relaxed/simple;
	bh=MTIJEdaX7RY6spuI30YUJ423lndcAW/6Aq2e32Fxx4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoKsgabmynK0JnlZX0TEL6VNlXNzGEmBjjCHDmKdq8LpY7WyArLKfXejjp1ibv80Cq64d160kgeF6lo2KLfJrNfH/gYLcW1u8hDgqmHB+qWfjnATzewKK/08z8+myVw3LeOCXZOe4ucYpVVQp86CTPr35Mo0HYQ5bg5o7IAuhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ObB9WOPg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4dzTPQciaosLMooPxGjtaU2Jgy+fhtIq0rv0jjMuwbc=; b=ObB9WOPgLNJFwmZKHfjRzUAfYD
	f2h8NP+Stzd1FajQlNoH/wPbRLg3sdsAJBGhWsOl2urNV1NMJ2+2dnuFa28T5HoTNjoi+HXMmr6+C
	HnUplEze32I7tBUzIEUqiVVokqeUI6/yb0B770GvBwMDWXlJhnxInl8vKAZXHTsaQhBgTYAAYtfK2
	HSQn3zQoAu3XQEGwTC2k8ARmBC7Pg5ZrM7D3KvAPYzKLYa4yqo8r84j4TBrm1lK6tHnL0atI/MM1G
	l8F8ZEQU7R6B2C12SqE1ErbI1FHdSqxzBlaHdfDUuaMtwkWTWDO5wI5yfArnfwpnZi3zQfae59TZi
	wYkvZB9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCQ-00000005Kqn-17XD;
	Mon, 23 Jun 2025 04:54:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 16/35] do_umount(): simplify the "is it still mounted" checks
Date: Mon, 23 Jun 2025 05:54:09 +0100
Message-ID: <20250623045428.1271612-16-viro@zeniv.linux.org.uk>
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
index fd453848c2c7..a7bf07d88da4 100644
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


