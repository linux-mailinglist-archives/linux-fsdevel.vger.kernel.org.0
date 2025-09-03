Return-Path: <linux-fsdevel+bounces-60064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E23B413D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA706817F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B42D7DCD;
	Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CbYvfFeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9902D5A07
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875345; cv=none; b=B0tMVvRUM/ZgdZVtgPMPRhfG8x2OGgvTkdsI5OPbe8Ij3yNZMvYEwyR0mCEDBh2klZTDeu9KohrJHNGJPVyfjjnCb0r7ka3S1Fn0y77gLCc6qZ2viNmpb3WTWBL1gh16dII4wyNuEjZ+Blagaw2Hqv0hs053Dqxx8uEmdbThyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875345; c=relaxed/simple;
	bh=A6eFYKAe+K9F0JuCCPcqCziDbJMWIyORbTE8OAQJ6bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUgVhP2Q7YvOB4Z/ZJEvHv9t2a4XX2OkpFHZDg92vaD84QtAd4iu0ECzpuR0A5xHb9WrPpEBNJkdGRuiPXVJaZFk9rZflXiQuPc/uP4RCUrUaCOVa1gdEk0vVJHXxTYrynazMQEjF7zh1+E6apgujQC1vWarBPxEkTESJylNRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CbYvfFeB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PPBzEbkpJlDHWxiav/JTtF9Xpz+QWIApqrHOIC3tM8E=; b=CbYvfFeBBA+FqGR5dIDyVzEbo8
	woEMZ8UK35pCjfcfL9xxwvpxjd34IXFXh2myHKPFEezFOXWKsKG7jdgBKIcY77GiYopXH/vJ8EQe/
	cBLTGQbUjgf5mVRGLyy0QMPdspVXf59GGbv7jX0095OY//ikItujSbt3h++l5xpT2eVmO8VCWXei1
	WxbsEHZFNHZufHGJPQxCKqFviHQAYXz4Ta6ppDSilGrSjI/pYnLvJekfhpspi9iYN3yxUAbUuj8dg
	sHUdbRp9mqOfvhy14j9O9dc0WRYg12qXAG9sKFvuD8lNaVwLyWyOBMDqL68mPaJPNBdrXvXcA723c
	bcFeu41Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap96-2jhy;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 23/65] do_loopback(): use __free(path_put) to deal with old_path
Date: Wed,  3 Sep 2025 05:54:44 +0100
Message-ID: <20250903045537.2579614-23-viro@zeniv.linux.org.uk>
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

preparations for making unlock_mount() a __cleanup();
can't have path_put() inside mount_lock scope.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bdb33270ac6e..245cf2d19a6b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3014,7 +3014,7 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 static int do_loopback(struct path *path, const char *old_name,
 				int recurse)
 {
-	struct path old_path;
+	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL, *parent;
 	struct pinned_mountpoint mp = {};
 	int err;
@@ -3024,13 +3024,12 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (err)
 		return err;
 
-	err = -EINVAL;
 	if (mnt_ns_loop(old_path.dentry))
-		goto out;
+		return -EINVAL;
 
 	err = lock_mount(path, &mp);
 	if (err)
-		goto out;
+		return err;
 
 	parent = real_mount(path->mnt);
 	if (!check_mnt(parent))
@@ -3050,8 +3049,6 @@ static int do_loopback(struct path *path, const char *old_name,
 	}
 out2:
 	unlock_mount(&mp);
-out:
-	path_put(&old_path);
 	return err;
 }
 
-- 
2.47.2


