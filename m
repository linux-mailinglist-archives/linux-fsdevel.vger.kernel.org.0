Return-Path: <linux-fsdevel+bounces-10200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C13848A7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8FD28683E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3D8C02;
	Sun,  4 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Tgjp9rq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2B77475;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=jVjWJuo1nZ5qTdTTi7kVRp/w0fD4TsHEDmTDI0NYDtoU4vSQhoXg2ExW465Fp/JEbxhiBjKJlcUSNcrbh7T7IVMTXlmoOhPzkiDCuTiqaJhMlcP6f+v6DDdJeuZ6VTm8v2ruMYr1fg7sO5Uic/me+lO9YJ5EEKrJpC1dmm7N0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=ESeuy+sRmSqcgc4J62uxsN9xRpufWmLKZ9Z0jimpwkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MM2sJ1Gf1jTsPCvc+VI8X1drcQCuxNHSOiN1EDUaoUUbtWYiYOjEy//2D4Z2Wn1PyMUkpCNyYxN5RS78N+HKCz5hLOeohxPDrRYmZ0DI59m0nlmGsF+JCHhVSuBX0ZorhIi+2tSYP7ZLbMi2Y7sKT19nEzjkmdWKcYWFEVcA0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Tgjp9rq2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MbX9tJudD6m9OahDFqTMdqQPpdHnN+yBPYQKKXuKt8M=; b=Tgjp9rq27MqRdktDJN+34uxz1K
	BFCAjAJYerA2pn/+4DZkb5qCDauknX80pKN47HZs1vz0zmBshCvTYpox0FhExQ8LNFTa+M0iOl18+
	zWugqvaVdQHUPcLEFvXLhuu4TD15YU1LX+zEVR7c6vNugP16y9YbYYhZsQBP2e4SWigXVZ41eyJP8
	8iNn8S2C2dzWFy5aLECafk4BaK5szIX2/t537N6Ch3UEhkb+GrbUVboKmTW3EKyZHwGbcTqKlW7Fr
	1GTt0w5k2m9RXKLsh7+4tNELpU5Lx963XKuVGEhOXw5aJFErk2LTKRkmXAORfjb4+qC5COXKTHV0k
	hogs5ssw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDD-06;
	Sun, 04 Feb 2024 02:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 07/13] nfs: make nfs_set_verifier() safe for use in RCU pathwalk
Date: Sun,  4 Feb 2024 02:17:33 +0000
Message-Id: <20240204021739.1157830-7-viro@zeniv.linux.org.uk>
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

nfs_set_verifier() relies upon dentry being pinned; if that's
the case, grabbing ->d_lock stabilizes ->d_parent and guarantees
that ->d_parent points to a positive dentry.  For something
we'd run into in RCU mode that is *not* true - dentry might've
been through dentry_kill() just as we grabbed ->d_lock, with
its parent going through the same just as we get to into
nfs_set_verifier_locked().  It might get to detaching inode
(and zeroing ->d_inode) before nfs_set_verifier_locked() gets
to fetching that; we get an oops as the result.

That can happen in nfs{,4} ->d_revalidate(); the call chain in
question is nfs_set_verifier_locked() <- nfs_set_verifier() <-
nfs_lookup_revalidate_delegated() <- nfs{,4}_do_lookup_revalidate().
We have checked that the parent had been positive, but that's
done before we get to nfs_set_verifier() and it's possible for
memory pressure to pick our dentry as eviction candidate by that
time.  If that happens, back-to-back attempts to kill dentry and
its parent are quite normal.  Sure, in case of eviction we'll
fail the ->d_seq check in the caller, but we need to survive
until we return there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c8ecbe999059..ac505671efbd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1431,9 +1431,9 @@ static bool nfs_verifier_is_delegated(struct dentry *dentry)
 static void nfs_set_verifier_locked(struct dentry *dentry, unsigned long verf)
 {
 	struct inode *inode = d_inode(dentry);
-	struct inode *dir = d_inode(dentry->d_parent);
+	struct inode *dir = d_inode_rcu(dentry->d_parent);
 
-	if (!nfs_verify_change_attribute(dir, verf))
+	if (!dir || !nfs_verify_change_attribute(dir, verf))
 		return;
 	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		nfs_set_verifier_delegated(&verf);
-- 
2.39.2


