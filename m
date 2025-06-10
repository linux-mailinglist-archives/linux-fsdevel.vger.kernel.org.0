Return-Path: <linux-fsdevel+bounces-51137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE819AD300E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CC51884E91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BE283FE1;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e1CASBO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584328150F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=onMOlFqgkkBu1d+rKsdzH1sYI2qSHQHDuB9ZiVJWw3dE4vNCv4aU+fB1lhEi6gisjZOdVeV6SDnd1Blvt2J1MQ80oCzhlAwLOvJv0Fdt1aW6SHKz76XVteZitw/xHn+89dIeGwE3RwWCCJTu4r7Ba/fIIHkWBYx5HVhhbQ3Nv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=8+rArhgjXHNAxVo520zSuy1XQllOVCRB/Ea0uTlS7jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXvF4JWaPrPQi7Tz/dn2b7Cb6BEVvNrBTDRPPT8n+Wx/AE5t0lCsrT9cxa4tnYYHN4Lk0F8kWWRqCn4jxs8Bt7Eako867q7gQLo94KYfDO7p2zG0AkWoKdDes4pKlw6IFDgsNY9pRka7G6QIDHGkYc+WWGNrHb/HCjtEUSuZcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e1CASBO/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=351bBdolxrQZme2BvjDjb4dxbFHaMb8r6rCtB1/iwHY=; b=e1CASBO/kWB6JI7p+eW606ItG6
	DeeAfPydxVReBouwwnZazzVvgfm8+O/Ee57wURUi+/GT2xvrBlyRXJLQPa/KxJkbJrwi0S0oudA+H
	0D+KheaL3XMj+KFwQd9GqZM8cSCzl0QvrlLI/7b6/BodNbSQtu+NDe5eMcbVu6J9NZgwYdIIAu1/h
	unIyO2CJYoesfRwXZ8pV9m+Uyt+swT7ug3U0eKuMRY55CjfK6dvrDxTJWbfnzFitlWozRYaCzZu5e
	00jBK61cNiER13w4f73FqmY6q5DuAR6vaXwVXeeuI4/N8WKgOt9LZD8v9Rdf3QshOVvbbGQrao9BX
	l0nc+bYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEy-00000004jOP-0nx1;
	Tue, 10 Jun 2025 08:21:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 21/26] attach_recursive_mnt(): remove from expiry list on move
Date: Tue, 10 Jun 2025 09:21:43 +0100
Message-ID: <20250610082148.1127550-21-viro@zeniv.linux.org.uk>
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

... rather than doing that in do_move_mount().  That's the main
obstacle to moving the protection of ->mnt_expire from namespace_sem
to mount_lock (spinlock-only), which would simplify several failure
exits.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7dffe9f71896..d9ad214b3fec 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2655,6 +2655,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	if (moving) {
 		umount_mnt(source_mnt);
 		mnt_notify_add(source_mnt);
+		/* if the mount is moved, it should no longer be expired
+		 * automatically */
+		list_del_init(&source_mnt->mnt_expire);
 	} else {
 		if (source_mnt->mnt_ns) {
 			LIST_HEAD(head);
@@ -3631,12 +3634,6 @@ static int do_move_mount(struct path *old_path,
 		goto out;
 
 	err = attach_recursive_mnt(old, p, mp);
-	if (err)
-		goto out;
-
-	/* if the mount is moved, it should no longer be expire
-	 * automatically */
-	list_del_init(&old->mnt_expire);
 out:
 	unlock_mount(mp);
 	if (!err) {
-- 
2.39.5


