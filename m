Return-Path: <linux-fsdevel+bounces-58058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F7B288D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B11C8297D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762E23C503;
	Fri, 15 Aug 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qi9+FOU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF0165F16
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300894; cv=none; b=gwddI3YbY/YAJmZrW8UZeMBfWciQMErWl62to/ILlDWXLu5LAXj0QVJazqhhry6Kx/JwBoLNdzRUODElql8+9uZmaDnESIFDRp3y4Q9jZf7VceF0O1dyH4FXWBBAJLKPxRStvqrCG1zGOebCIIJAbdlkqyjmADMl/WpLsSDN3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300894; c=relaxed/simple;
	bh=DUEByRUel3ecKDpii0ymUDawhn4NOZ+aGuMbOxNb1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYpt9fhaqhbMhjG1JAxPB5fk2CLKQKccdOdIgavUqCsdPQV2xNFZLyXtFY2bXblxSSsfNGL91SfrQh6bRKsRW/KxPCuSRCmSRA5JnnHbIFx509Rel3n3e4+Zj/NIITIsoBTOcItFZWWmhQi8RGbIN4dU5tWhAp3wVqyysFNWPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qi9+FOU/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1OX+URpavSUVC5udDAadgXXw/t7EG8Yoccc1Jb+E61Y=; b=qi9+FOU/gHY0Z32phE8PzJCYe5
	3cR52AXfKJzRAJECRuRn6gEQ5jIMYA7l7LWOcMsSkpk+esKjzTxFR5XiPk6c+ANp5dT4N78u79D1U
	NUaA81QH++9mGhSUaFjKP6pCptK3s8UaR4u0lCBgh3meW4JREN5ohWW/n76OCqIaDLXvtm4ylOpVW
	v71LpSVEl7K3n5hjRkZTDWBwS9VEaWlem6wM3ALyJXHfAcPpVNqC1dwnPtn8AxsR984dDMwZ9qI6F
	0Fi5dVgEnKyqaBvxrjrvQwBZsvAyWZmMXgShncXe0HhanHZr4xFXtVXC5qcC1mOCpbDR1vwB7v2pW
	N1tbwUlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un3wg-00000008tnS-1hNR;
	Fri, 15 Aug 2025 23:34:50 +0000
Date: Sat, 16 Aug 2025 00:34:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: [PATCH 2/4] propagate_umount(): only surviving overmounts should be
 remounted
Message-ID: <20250815233450.GB2117906@ZenIV>
References: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815233316.GS222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... as the comments in reparent() clearly say.  As it is, we reparent
*all* overmounts of the mounts being taken out, including those that
are taken out themselves.  It's not only a potentially massive slowdown
(on a pathological setup we might end up with O(N^2) time for N mounts
being kicked out), it can end up with incorrect ->overmount in the
surviving mounts.

Fixes: f0d0ba19985d "Rewrite of propagate_umount()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 81f7599bdac4..1c789f88b3d2 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -637,10 +637,11 @@ void propagate_umount(struct list_head *set)
 	}
 
 	// now to_umount consists of all acceptable candidates
-	// deal with reparenting of remaining overmounts on those
+	// deal with reparenting of surviving overmounts on those
 	list_for_each_entry(m, &to_umount, mnt_list) {
-		if (m->overmount)
-			reparent(m->overmount);
+		struct mount *over = m->overmount;
+		if (over && !will_be_unmounted(over))
+			reparent(over);
 	}
 
 	// and fold them into the set
-- 
2.47.2


