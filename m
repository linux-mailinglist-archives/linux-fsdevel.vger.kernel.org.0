Return-Path: <linux-fsdevel+bounces-60051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CCB413C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E68681701
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D72D661C;
	Wed,  3 Sep 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FVa5yv9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253212D4B4B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=HyKyuwpiL7htezbTi9YbeEBk2YZjkZYCU1SuKn0GQ4HEWD69t1iOfqyeI3Oxi50SHgzs3w0uoaQJvSSqnHxBM0cGt62RE7WEdutqNykEAM+wj41l2H1hKKm1LWfrTaNgoM8ORsioeqKLsWjurM2pyhqWSmMPGuJVEMIEEBXE8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=PKmc3FbUQjTUYy6SY+ce3KB6JTIGjEtZmGp7zzlLEY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivDId8UkUyLca1Wdus7pwafeHHy+sVY9lPmujwPSS+ifZV+ErbY579I0vqgN+ch2NOJ4iKEHfP/WX/fZBBByINDCPP5a9aRp37TuZiNIyb8hk0cwpu+q2uZFIsbR2ORatXZIsj6xJn80eMs9nzGPaIk1bxYikUNEz0LW/UgaJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FVa5yv9E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ie3WjbHVzwJ3BMk7ywP55q4UVjfXeya3Oim2h3C5d5w=; b=FVa5yv9EYZmg4LE/+0SYhJdA7B
	xErT7BezleW+ecmaW8dbqr0wWMFeEpG0jVpmal7+UPW8vVGg3Gf0rGyMzKsod6X5duE8TKYCvZVXZ
	AGYLnybZAnKueOcY84HZVLLS/iE3dH3dfWfstU6m4syGlUe7KAe54PjuEhQs7Oau2+8rSKy7kMyAY
	N9v1JNRGxSCV3DKMGjaPZ7Auw0V+V4RSRG8q94O+IsO1SBebboJSQL4fnM9ukIB1qilUKZdecPKKQ
	MMXfggIwqvHqquQUD2xCMjEp7pfOyNIzJ746k1X9FpaTudHmM6pjWoZxhoYdfgkrVmeTYXCIgEp4b
	jT0ML2pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX1-0000000Ap68-2AIv;
	Wed, 03 Sep 2025 04:55:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 06/65] do_change_type(): use guards
Date: Wed,  3 Sep 2025 05:54:27 +0100
Message-ID: <20250903045537.2579614-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

clean fit; namespace_excl to modify propagation graph

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f1460ddd1486..a6a7b068770a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2899,7 +2899,7 @@ static int do_change_type(struct path *path, int ms_flags)
 	struct mount *mnt = real_mount(path->mnt);
 	int recurse = ms_flags & MS_REC;
 	int type;
-	int err = 0;
+	int err;
 
 	if (!path_mounted(path))
 		return -EINVAL;
@@ -2908,23 +2908,22 @@ static int do_change_type(struct path *path, int ms_flags)
 	if (!type)
 		return -EINVAL;
 
-	namespace_lock();
+	guard(namespace_excl)();
+
 	err = may_change_propagation(mnt);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
-			goto out_unlock;
+			return err;
 	}
 
 	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
 		change_mnt_propagation(m, type);
 
- out_unlock:
-	namespace_unlock();
-	return err;
+	return 0;
 }
 
 /* may_copy_tree() - check if a mount tree can be copied
-- 
2.47.2


