Return-Path: <linux-fsdevel+bounces-60099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363BAB413FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EEA68193F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B62DC329;
	Wed,  3 Sep 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UyqEyfyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7522D837B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875352; cv=none; b=qydHa/VOi3udyA75UwqBZOCyY/XuRc3IZJAU1RwHny0c0+UyEmEhECrv/fGeQ2lYs93TvDSbL6WlB/+X3J3ldQL/oPG8GAyKC2VXa/Tl+ygXxdEG6xpb1/YubdhfEO3vCe7n6PZS54MOR1ljrHtoT9tHpXghlTbPkR2yC8H0dzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875352; c=relaxed/simple;
	bh=FewYrgDSdQa2CbmZic8njTGOtCjeOs0M4QcJIk7Z0eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc01DAR3DFbpOMXcMnBi7eUdcLfs/PFCchAHRYW5pIwm8MC1/IbiCTWGAfINtd6gt2PzZk/RfxXLfg++2nLdbKQBJ9rvYlDAZUhLMUV6blh9fOeHJkd0CUYoGviXTqVWl6YavkQ+ivwp3O4hB6pdQP4OW+jGtYDnVoYCNc4WeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UyqEyfyo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QItb5Ml6CFjhjPOZFdS8F9jBR12A3+kVWEwlb0Bt/Ts=; b=UyqEyfyoYG2e/t8H5U9ZQV9oVn
	LaOEG5qfEtMjbaSAY21Znkd6Uyjqm2McQM6tK22rSlX7dXssOIimkmQqTdh4lEzfnadEbVpWkLCJc
	G5Xdvb6Ipl+JmdplPvBwFs3DXscUMqtkpBjfJ4XX+kCyzAek5uUDUnQTvbv7UYyS1QFPIeF3Ne7PN
	kQSM550Chi2sf5ERNmNj65rqT/oxgTnxbbnzl00mX5rW/b4ag8BXdlYDMuus0G/9EH9Ja1zZcKSyz
	BiWQOJCj7OzGP8hrKvhDKSnox11+BfU1KVZeTUsrCeiRAadOjlRp43oaktS5xTckv/DyGue4dZjh+
	2gnEm8UQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXA-0000000ApGO-3pj6;
	Wed, 03 Sep 2025 04:55:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 54/65] path_has_submounts(): use guard(mount_locked_reader)
Date: Wed,  3 Sep 2025 05:55:17 +0100
Message-ID: <20250903045537.2579614-56-viro@zeniv.linux.org.uk>
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

Needed there since the callback passed to d_walk() (path_check_mount())
is using __path_is_mountpoint(), which uses __lookup_mnt().

Has to be taken in the caller - d_walk() might take rename_lock spinlock
component and that nests inside mount_lock.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..ab21a8402db0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1390,6 +1390,7 @@ struct check_mount {
 	unsigned int mounted;
 };
 
+/* locks: mount_locked_reader && dentry->d_lock */
 static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 {
 	struct check_mount *info = data;
@@ -1416,9 +1417,8 @@ int path_has_submounts(const struct path *parent)
 {
 	struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
 
-	read_seqlock_excl(&mount_lock);
+	guard(mount_locked_reader)();
 	d_walk(parent->dentry, &data, path_check_mount);
-	read_sequnlock_excl(&mount_lock);
 
 	return data.mounted;
 }
-- 
2.47.2


