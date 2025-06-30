Return-Path: <linux-fsdevel+bounces-53258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17554AED29B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CD2188B392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E801F4289;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JsfFpkob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD319A2A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=AYrDVf6VACAvahVoseIskZMlTbsu0NZcX/HXRJvwOhwTT83N2DsEZ85o3Zsj+Rq7gqqMC8EgfaHTfwUWeRxItj3fYT1L962NB/jeyJdQYbKNDgRl9AsUsr0schEj5u6Q91mMJsShCsGqggtF+MJNojXiMfWCOZbE1MhNETZjfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=9XwWK0axH/sSno8VnTCMT0Jtkd/Z+0MyTSK3dtQcI/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC0X3nFQM93aYvntQFCSkaLgldTFylfspOSzo+in4pJmrLQMJjGhxiSSfbet8Gjs2iw09UrhY/KoZOl5V94CkjivBYGWBuhdoriCjGkJ8nD9/d5AHQVeW77hiNLlzENxEqmzrx7GFSnGVePxfZFqefJkjawas5nHgNcjSJwkRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JsfFpkob; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vMEooP1Tx5O+yUM2p4ZkTqN45LrRblVfl6wj03vzGLA=; b=JsfFpkobjkblB+pQU2dqqAg9/q
	i6m+d8vdlzOdFWeKcVXAcl0/SzssOyb6qaVZBzKN24AwoRy3k7RHBdLyevNK1EddGVqlINCOlJxeu
	QzHGFa3VnH5hSRHqYBNqy/cPi73K42fW2XwD5wblAaHomuucu5uO6eQbjEXYl3riBoAwMHOPcBF2s
	fGq0u/apLcC6tU1SCOUWxQGrtxqvQtSp9AZAESduY2uB0PuJd3d1c2xF+DYgsPeKWQr1ksxXOmjoh
	GC0HSPYcB+IWrhRiKi1QNWpuFaNbR0FMcAtRAq+Z+86fRD4B6yKn9IQv2k2tjoJfl3kd4CDHUOS/Q
	aNEOji/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005p01-2RRQ;
	Mon, 30 Jun 2025 02:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 21/48] do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
Date: Mon, 30 Jun 2025 03:52:28 +0100
Message-ID: <20250630025255.1387419-21-viro@zeniv.linux.org.uk>
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

... and fold it with unhash_mnt() there - there's no need to retain a reference
to old_mp beyond that point, since by then all mountpoints we were going to add
are either explicitly pinned by get_mountpoint() or have stuff already added
to them.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index adb37f06ba68..e5f8fde57c99 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2682,7 +2682,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	if (moving) {
-		unhash_mnt(source_mnt);
+		umount_mnt(source_mnt);
 		mnt_notify_add(source_mnt);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -3598,7 +3598,7 @@ static int do_move_mount(struct path *old_path,
 	struct mount *p;
 	struct mount *old;
 	struct mount *parent;
-	struct mountpoint *mp, *old_mp;
+	struct mountpoint *mp;
 	int err;
 	bool attached, beneath = flags & MNT_TREE_BENEATH;
 
@@ -3610,7 +3610,6 @@ static int do_move_mount(struct path *old_path,
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
-	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3684,8 +3683,6 @@ static int do_move_mount(struct path *old_path,
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
-	if (attached)
-		put_mountpoint(old_mp);
 out:
 	unlock_mount(mp);
 	if (!err) {
-- 
2.39.5


