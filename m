Return-Path: <linux-fsdevel+bounces-50540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3669ACD02C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83257A8087
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A522B8C2;
	Tue,  3 Jun 2025 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ICLT2AMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2917A30A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992754; cv=none; b=cDHSPwaKVlIxEgvUBDDOOvnzZlXRwHG5UtI6FwJYAt7jUlkqLNiNxg68ZUulpS1+Qu8dWM0ZsNv5mfotRyQ8eUwCVAvrkSIuPYiwD+NrjD/6KO5IzAubGA/aX+mHMfgBxomrmjWEpocAtU6m9TF/PHQc3Pqsm/Qm0Pqb1BBkyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992754; c=relaxed/simple;
	bh=oNtuzbbxSzj4yCo1dWZLwETrl/MQJr6WO/tjgZKnF5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIGPW5bxCrK/RjR/aT+RYk+X4rfQ9hSjeMs3GgozSNbX/Amjz9tnn2tu58gv3GqxTn13tYp+kgrJk6ME+meqCcTmC78abSjkmHJxz3EdvbZBR7i+I8t0TFtr9hwl/vKTVPcSsR9eEysOApMqO06CFN5qZRCE4E6nqrH+v9vQNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ICLT2AMT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8QqzFAhWoSY21kJINwZFAU6J8lxXl1p2MGIdlq5c1fM=; b=ICLT2AMTN2yg0TCf1C8aZlt756
	WBqyT2aGr7pL+uhhI2tg2vMiyM6FGY/QwwhscLmtXk5NIX4TBURMcMniQD0HgBQxeFeUUJxU2Cg2E
	Wa7yAhGIA0RmyIrj9b22i+wWhDe6ck0bb6r2sYc9O854oJaYdTa/2MqdwxiUEYe7EobM6/WfaIUOV
	pR/XjCqpsYbgID6LGCPsYeHwf2u3Tqejv3RC9WZW/iY4Vqy/NYVsXzYy8rxh8BayhJOX/PPLhGJPk
	mLdR83vdrEoa+ClESv2B4HpHzQk1BeEqPTTZPtLXixHo3EfmDbM2Kf+O7WHl1vrIralKtxTTfKjMJ
	Xuh1VMqQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMauV-00000000dLE-1b5f;
	Tue, 03 Jun 2025 23:19:11 +0000
Date: Wed, 4 Jun 2025 00:19:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 4/5] fix propagation graph breakage by MOVE_MOUNT_SET_GROUP
 move_mount(2)
Message-ID: <20250603231911.GD145532@ZenIV>
References: <20250603231500.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603231500.GC299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

9ffb14ef61ba "move_mount: allow to add a mount into an existing group"
breaks assertions on ->mnt_share/->mnt_slave.  For once, the data structures
in question are actually documented.

Documentation/filesystem/sharedsubtree.rst:
        All vfsmounts in a peer group have the same ->mnt_master.  If it is
	non-NULL, they form a contiguous (ordered) segment of slave list.

do_set_group() puts a mount into the same place in propagation graph
as the old one.  As the result, if old mount gets events from somewhere
and is not a pure event sink, new one needs to be placed next to the
old one in the slave list the old one's on.  If it is a pure event
sink, we only need to make sure the new one doesn't end up in the
middle of some peer group.

"move_mount: allow to add a mount into an existing group" ends up putting
the new one in the beginning of list; that's definitely not going to be
in the middle of anything, so that's fine for case when old is not marked
shared.  In case when old one _is_ marked shared (i.e. is not a pure event
sink), that breaks the assumptions of propagation graph iterators.

Put the new mount next to the old one on the list - that does the right thing
in "old is marked shared" case and is just as correct as the current behaviour
if old is not marked shared (kudos to Pavel for pointing that out - my original
suggested fix changed behaviour in the "nor marked" case, which complicated
things for no good reason).

Fixes: 9ffb14ef61ba ("move_mount: allow to add a mount into an existing group")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1722deadfb88..6c94ecbe2c2c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3453,7 +3453,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 	if (IS_MNT_SLAVE(from)) {
 		struct mount *m = from->mnt_master;
 
-		list_add(&to->mnt_slave, &m->mnt_slave_list);
+		list_add(&to->mnt_slave, &from->mnt_slave);
 		to->mnt_master = m;
 	}
 
-- 
2.39.5


