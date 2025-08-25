Return-Path: <linux-fsdevel+bounces-58906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7AB33563
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C38D188B7BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08527A11E;
	Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W/CQelA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123625A357
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=cSAS2AmENGhzBHdm6aD6UU3pVwVfz3/N60gXRWUItabz65XKJ/zIaggJscirZaYcEzS/OvAgSWU0TFZRFAS3KO/VXRaWDKts6XZRgwQsPNE/e+vjVe1sW6g70o6H2TqmfRkwZWQ79GJiC4C4dDr5hp1vaxe9xAqiiLS1e3JE9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=E5Aqb2TJxyL/jGbOcthdAeZpL7RiTti1Z1TPtMJTRRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnsLhOc3dRxOEeRD5wxk5O6QHgVgTXyh6VCS+bjNrgJfpBQQrcwm3Ji8UGJXHyPnrxRfgQzby+ARHG7PCQCnvP4nUeXGKQPYZ+nktGh43EXB2ojxkKBwQ6PAXk8PUzzzOygtW0CyIO/nVD6Px/XY+E5E9L5DIMxJ4JN9Irb6JzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W/CQelA0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qzK7qb2lqJAxDuS1JNxLPSUq5F/kgp16tOfwbemjji4=; b=W/CQelA0y4+QEiAD6LcRhf3Wwk
	yz2lxjbM67+icRe7WhcvkknnvO5HttXeK2ztNHXZWHH0R4FC+eju/ypu8jQymiFhBTbisr8o/YW0q
	eHS4Inu3ZNWa0AL9ZNOEhDezVzNlMaEZhz07VJ5TziLkXoKFdoVBh/WHAnMpf91eETQaQlpShxpoi
	jYTjmE53/8+quVrkkv35WIQ9OjHGIkMrKgHV/nvvhlVcmQBL4T4ht9rUhdn04I6XIbZm+sCiapmWH
	yJYLi6U4jG+huVaO3tAE953CTDYbmdXYWUdQqCuy4fdve1PXG2Mr0Gb3r8g8/IKPr/sd5P/QyUm+6
	QnkRAQCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T98-213u;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 08/52] mark_mounts_for_expiry(): use guards
Date: Mon, 25 Aug 2025 05:43:11 +0100
Message-ID: <20250825044355.1541941-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Clean fit; guards can't be weaker due to umount_tree() calls.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 13e2f3837a26..898a6b7307e4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3886,8 +3886,8 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	if (list_empty(mounts))
 		return;
 
-	namespace_lock();
-	lock_mount_hash();
+	guard(namespace_excl)();
+	guard(mount_writer)();
 
 	/* extract from the expiration list every vfsmount that matches the
 	 * following criteria:
@@ -3909,8 +3909,6 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 		touch_mnt_namespace(mnt->mnt_ns);
 		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
-- 
2.47.2


