Return-Path: <linux-fsdevel+bounces-58907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5FB3356B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA06D3B29FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C132127A455;
	Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="La6B8VFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86724A05D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=Hgjepzb5iPnAmHbcLoc2fKsPVdDh1tRNdj/qLgtUqUZAwN8WKk//j6WhlwvjkP/a4BFgAhMCTtYsMqERU3AXvAe2E8e3kTxuT4InkeVx3sgtrHREZyRtksF8hSgDZXwKBAqiP+3BEv8i37j31wtdnCtww6gFF+Yljxfp0x+DGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=to9MpXnL29pqubFKxyya0557zrKdFVTSl7l8yJ8v+tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGPlVhiBryqMMg9+ZUhw/vZvrFvI9sS24aBtYJoiFnwEUehLSzAt/xkNcGyEkLNg/j65yf06F9TjGkFQPFO5P/o1BUVBqhUXTN3KdG++25cOg1vFvCDLvpUSBygmaSN3M2YaBT3tHwZfuB7mgQXtoz9T2qFap/+Tw5GPKqH3gtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=La6B8VFc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G8VZoWcXU5bS9KtraJC0D/WDfKrV1dQvv8+BzLLAIfs=; b=La6B8VFcnzX0Ndql5NqSiaaeAV
	ggOdob6dFjs0RMdLKENa8o7mRjYnEGkEI00n0JqzKdSaH5DwDbu4yXP3YYitILgePDX08ny5+7dKC
	S/zCDtjKYXbHBEJ0YLmtVAtILSSAW/xrZGZomX+7mimGLCwdjdbJQwyyd1OMzgGZ/r3axnNd2SBqL
	HvNImI+fMD1HEuC9esMpeFppbED9iXRGYuCsPolNjS+VTCZfYJ9zGJb/Xc+ZRaECBoZylfRpaP2/y
	vqat2DDJBFZLix8O6JMyT6Ew2mfWOO/hCSC2ycKYLd1+t8CIZRly0pg8EPhs2xvzopmZbZiOnWxbv
	Eu9ZAo9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T9G-2LM4;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 09/52] put_mnt_ns(): use guards
Date: Mon, 25 Aug 2025 05:43:12 +0100
Message-ID: <20250825044355.1541941-9-viro@zeniv.linux.org.uk>
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

clean fit; guards can't be weaker due to umount_tree() call.
Setting emptied_ns requires namespace_excl, but not anything
mount_lock-related.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 898a6b7307e4..86a86be2b0ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6153,12 +6153,10 @@ void put_mnt_ns(struct mnt_namespace *ns)
 {
 	if (!refcount_dec_and_test(&ns->ns.count))
 		return;
-	namespace_lock();
+	guard(namespace_excl)();
 	emptied_ns = ns;
-	lock_mount_hash();
+	guard(mount_writer)();
 	umount_tree(ns->root, 0);
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 struct vfsmount *kern_mount(struct file_system_type *type)
-- 
2.47.2


