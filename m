Return-Path: <linux-fsdevel+bounces-51133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0EAD3005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB22D1895D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEED2836B5;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n0+FJRjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49756281359
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543715; cv=none; b=q8iwHgTBNE9qdAi1vfO8EjNosl6k6n8eaBDmFrBGmuyO/0KfknnT93HGf2RsLVA7hOOBNVEZcVGoOgXxW5TcQzHcV7Zm8fraix+NXKrpftWs9013nl+NMAlrJe1Fkk9uQeUgF0c96gw3e+DFHlvjZNq2OFGg9snbHbErPUot8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543715; c=relaxed/simple;
	bh=F3rJYCHLaVEYi3ty1WV1dRp4FAe1S2YyQ7ASciP9SEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI/yUWcnlgXLnPZymBO5G/eSOTe+xNzNGjJD3S95eI76mOd36zXSWb7DUXqkYMUDxztqW1pJU5722S9me+VC+kgNvEfn72TC3RhKozuBto9q/Fb8NAhWSRRQ5spJUwa9XJmPkJuVLIp1stUbOCKP8ctmsQl6OkgV+osl9RvnqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n0+FJRjn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8a3WS7sRwQ+FM0oehP8/gAeWgKcd3yUCiP07/gJFzS0=; b=n0+FJRjnAib4pyI5do8WenEmF/
	RB3MbUfWRziQ0FPSFOaIJj1rcrA25s7AWQ/h1TJ3vtKPu1Ajo86tFG5orlP8RXck6tBp+X62LthK8
	jyu8uiBf4f6hbfzLN4v+u2g1AAjFKWlmq+kBnm3hv5JWsJC3mX4Bm1GWhrrZzTnLEmzNtS3bhY1Ye
	/byllOyVOT5RNXtKlfm+ko1KkgXO2+zOWY0HPkptiNj6c3e3O2f5fuzDBB/PCgZWQpwr//2IxQlAW
	jlls6W+nRoxiWa0rTju2S6fBYo23TXOjBwqX/KWMn72ghNSu34KBcl2YNdNr+36vmB13diUCNCIiU
	YHazJiSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jNg-2HBY;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 17/26] attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
Date: Tue, 10 Jun 2025 09:21:39 +0100
Message-ID: <20250610082148.1127550-17-viro@zeniv.linux.org.uk>
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

The logics used for tucking under existing mount differs for original
and copies; copies do a mount hash lookup to see if mountpoint to be is
already overmounted, while the original is told explicitly.

But the same logics that is used for copies works for the original,
at which point the only place where we get very close to eliminating
the need of passing 'beneath' flag to attach_recursive_mnt().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 50c46c084b13..0e43301abb91 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2675,9 +2675,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-	if (beneath)
-		mnt_change_mountpoint(source_mnt, smp, top_mnt);
-	commit_tree(source_mnt);
+	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
 
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
-- 
2.39.5


