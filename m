Return-Path: <linux-fsdevel+bounces-10205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C254848A99
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C71C229BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894F10A25;
	Sun,  4 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HJi2F5da"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE687465;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=afYSAHHO2rRYLUVomqjPgGO3voo2d5qzoFHlBu2AcTu5lvH5oQXcD0YwcilP3KrYKgIZ/wc/jfvepfLanzpTeb2PIBmiA8VFDCcjvDDeuIdWEK3M7cwZBxInsUIqJyKEmHqucoEIvBcmj18sPOBHKwNsPG1DrL2ccRCaTjsGXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=0//Yu6BXY3luoPRYjvD5gzNg1J5nlPcjVRvQVUP3aW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dr6HbuDCz7MXPU4PNSv+OYkCmM9rxUlBq0johq1yIZn0FEXGcpW43ELd+gHHg6o2yZ0ChxTyKbzHEpxQxNkrrHqd+dTM4Uu4KxRhr9LVpGZHAh9MdWwnUOaherzZhQVelnJCaEXT5ddkOWP2z9/yx0F4xLOFCbeqfE9RjqAL9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HJi2F5da; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J2wtRa+Q8aO9z7aGDBhoVjKdvq+lyz4asnShgUjCJxA=; b=HJi2F5da1qO426GyqZHAWdJud3
	aDX1RoDxS01RdSvbtmsHDSOOcbPlobtlbFRajMenNsnH76opM7kXswiqn92ehF0Vi+9LEFjVYm+MM
	xRxtBkFNlMg/X0t+Dqna/nwVQcK8PPu4VDtRCElKd+iBeZOmDMwGmHEePmFRUm6RbLM2tkg3rN+7B
	oUUOP8e8kZZ8FQGyM7mHEU1MPurxMbMS1XlFXywykqn4mlF8niNvOLVqxJT1RzvBoGPnwPmoP/Qq1
	jZIhL55DIyrCXlRTFKkPc+KcH35hSpRmS9zUIIcfZB5AhjxctY27ehIXAKGOGJ0c3bIbu8fDfNa+G
	L3czJNdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4i-004rD5-2c;
	Sun, 04 Feb 2024 02:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 06/13] afs: fix __afs_break_callback() / afs_drop_open_mmap() race
Date: Sun,  4 Feb 2024 02:17:32 +0000
Message-Id: <20240204021739.1157830-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

In __afs_break_callback() we might check ->cb_nr_mmap and if it's non-zero
do queue_work(&vnode->cb_work).  In afs_drop_open_mmap() we decrement
->cb_nr_mmap and do flush_work(&vnode->cb_work) if it reaches zero.

The trouble is, there's nothing to prevent __afs_break_callback() from
seeing ->cb_nr_mmap before the decrement and do queue_work() after both
the decrement and flush_work().  If that happens, we might be in trouble -
vnode might get freed before the queued work runs.

__afs_break_callback() is always done under ->cb_lock, so let's make
sure that ->cb_nr_mmap can change from non-zero to zero while holding
->cb_lock (the spinlock component of it - it's a seqlock and we don't
need to mess with the counter).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 3d33b221d9ca..ef2cc8f565d2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -417,13 +417,17 @@ static void afs_add_open_mmap(struct afs_vnode *vnode)
 
 static void afs_drop_open_mmap(struct afs_vnode *vnode)
 {
-	if (!atomic_dec_and_test(&vnode->cb_nr_mmap))
+	if (atomic_add_unless(&vnode->cb_nr_mmap, -1, 1))
 		return;
 
 	down_write(&vnode->volume->open_mmaps_lock);
 
-	if (atomic_read(&vnode->cb_nr_mmap) == 0)
+	read_seqlock_excl(&vnode->cb_lock);
+	// the only place where ->cb_nr_mmap may hit 0
+	// see __afs_break_callback() for the other side...
+	if (atomic_dec_and_test(&vnode->cb_nr_mmap))
 		list_del_init(&vnode->cb_mmap_link);
+	read_sequnlock_excl(&vnode->cb_lock);
 
 	up_write(&vnode->volume->open_mmaps_lock);
 	flush_work(&vnode->cb_work);
-- 
2.39.2


