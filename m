Return-Path: <linux-fsdevel+bounces-52455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A31AE347D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914613B05CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537C1EC014;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E4QiD9sW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D01CCB40
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654475; cv=none; b=rPVZaGHvLnEyx3hPCXHBfkjalj7B4F6VzlIMwKnhJlNcLBpLyYGUip2GWOUIZGncwbgbNTp3NOy3ktT4+SESiguz8qPzz3LoJXn1K83H8e8sYb0NCIIAhVkS0dlPyt/kwPPlz64/+B+hKvN127lNOJel0EtuyaWrHyuMLsLLB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654475; c=relaxed/simple;
	bh=zUOCjmn4eye1879TstrMqdUc0nrCD/tmjJ5Q9LUIfRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajlWERuEsBQbB4H8jLQCQAiPWqiNN6Jfys52nWA551lyDMzkTycgIHUuPx0DMQV1MkKXfZvH3APV729N8LEjNAxtuNLHfFGXtDXXf1DJDqEiw21mAhrCBj5QYOtdC5GJR5tylLTGefD1vUUgsqp8LCHJ1uVxVNDTDGx6fo0ViNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E4QiD9sW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vDDFtvCKBLzFxDEfEEvCeNdZpeKzt+KnaDfruTuJHks=; b=E4QiD9sWlZHA+JQi1KIxJ2dGx/
	Q2Y6SUzPqrrofI2DdfljjMqe67MtLIzCQfcLxKntKl+Z9EoVC78CS150+iCDRId3QG9LisTbE8IOQ
	dDJjyiwgVV84jRIWZt5yAbIF8bNUYGgNMdvvNJCzAahdnsxKKIzejRNNLkuIVBJ9rXiHAGKrT1r+g
	Vzx4ql+QLkRJhffv+siYQnp28kfpspdKWJcBxre8aw7X+oyvmRFZT8jRU0EWQ5XVJMVZ58TeVVrrG
	pEX4DUa2v3xnU0EsqH6cCJ7EUkP9m9F8gbMGqfQSzXlAzJ86bNUoRqgpVe55ijDxvcJjkJNhRyhlV
	3dexfvPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCR-00000005Ksd-3n9b;
	Mon, 23 Jun 2025 04:54:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 24/35] do_move_mount(): get rid of 'attached' flag
Date: Mon, 23 Jun 2025 05:54:17 +0100
Message-ID: <20250623045428.1271612-24-viro@zeniv.linux.org.uk>
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

'attached' serves as a proxy for "source is a subtree of our namespace
and not the entirety of anon namespace"; finish massaging it away.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 912c64d1dd79..b6f2172aa5e1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3600,7 +3600,7 @@ static int do_move_mount(struct path *old_path,
 	struct mount *parent;
 	struct mountpoint *mp;
 	int err;
-	bool attached, beneath = flags & MNT_TREE_BENEATH;
+	bool beneath = flags & MNT_TREE_BENEATH;
 
 	mp = do_lock_mount(new_path, beneath);
 	if (IS_ERR(mp))
@@ -3609,7 +3609,6 @@ static int do_move_mount(struct path *old_path,
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
-	attached = mnt_has_parent(old);
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3622,6 +3621,9 @@ static int do_move_mount(struct path *old_path,
 		/* ... and the target should be in our namespace */
 		if (!check_mnt(p))
 			goto out;
+		/* parent of the source should not be shared */
+		if (IS_MNT_SHARED(parent))
+			goto out;
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
@@ -3649,11 +3651,6 @@ static int do_move_mount(struct path *old_path,
 	if (d_is_dir(new_path->dentry) !=
 	    d_is_dir(old_path->dentry))
 		goto out;
-	/*
-	 * Don't move a mount residing in a shared parent.
-	 */
-	if (attached && IS_MNT_SHARED(parent))
-		goto out;
 
 	if (beneath) {
 		err = can_move_mount_beneath(old_path, new_path, mp);
@@ -3686,7 +3683,7 @@ static int do_move_mount(struct path *old_path,
 out:
 	unlock_mount(mp);
 	if (!err) {
-		if (attached) {
+		if (!is_anon_ns(ns)) {
 			mntput_no_expire(parent);
 		} else {
 			/* Make sure we notice when we leak mounts. */
-- 
2.39.5


