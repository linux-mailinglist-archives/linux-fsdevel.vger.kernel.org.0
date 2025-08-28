Return-Path: <linux-fsdevel+bounces-59550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57FB3AE0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105D11C28034
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6F2F066B;
	Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V/IVldNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF92D0C97
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=fAT/B7pyi05Gaib0b/V/fFszVRGETdFg9eOUdbOfLZCONbjLb8YeDko8fr6Z1r4F4ldyykGxsH7ok3hZnwwl/V0aiApeNsm4znginOI0BlIN9AIVDMs+TIpeF5BH8wyzCbRtt37VwYkVOawQdcE06RxRiRZCIErV0Ga64OUL2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=A6eFYKAe+K9F0JuCCPcqCziDbJMWIyORbTE8OAQJ6bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVMkWygLaJGZ03lAknnR1fGesnFJ2D3hKFfIQzDyxPqb47LtK2vqz/VF9dxsaSv87SfS/c5naUzm+TzZHshy/bXw2WxYbgRSxKf/Yi973OPbDhywWRO0pC9QW5ZwzD2azfpH+I56uDfCPlq2vaor0+GaFjsXY7k+Rwspdrgol3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V/IVldNR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PPBzEbkpJlDHWxiav/JTtF9Xpz+QWIApqrHOIC3tM8E=; b=V/IVldNRGYKu61FzDnigS+RLPv
	HFvfx31S3EoHJRR/enesjHVC6FxIm0Et2NR2n4BzDfRDkRXAeE+LxmtrbfImpndT2YtM+aCUQlx98
	u2HAKWs5sblml4WkQQdbq+CcQEN66PWu1uuLuUNOg5/K6/f/BGD0rK1uBlKsYk82junX9KM+gy3X0
	roChE1Lsx3aW3s1WYvV7ltI7KOPwUdG0VYTI1YThXW26pSGejuK7K5piZduFPP2Tk1JWWf5qiXRkw
	QpTlEtqdw4mB9uj5zDj4b20ZcYXQOeVJEoFCPrtZVd4+a8qztubMtOZmyR5vg6foOggugUdb25eh/
	vy+F96bg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F24C-2SUc;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 23/63] do_loopback(): use __free(path_put) to deal with old_path
Date: Fri, 29 Aug 2025 00:07:26 +0100
Message-ID: <20250828230806.3582485-23-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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


