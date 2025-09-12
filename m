Return-Path: <linux-fsdevel+bounces-61130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EDB556B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E6717FE24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B19338F37;
	Fri, 12 Sep 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UNPuSzAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D5334389
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703561; cv=none; b=J5mlb4woStzqSrseIngkRQGEWTiE3B/+Q4t9Bo/8XuDDP5xg5+o7Ck+yRiiaXGvO7PkLzzPQfdpdstTsJ3jCga8fOE/qlmv9RL8Yb2hpjMb/4Kh150tgLCxSoDPRMeNff6WQeepYO9lUZ4qmHbxR3/3NA4T+zs0BILEFbiEFjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703561; c=relaxed/simple;
	bh=nuwYaPXx+xpC3evnFeNAdH8jjfh1tmqpRaWKGX/hNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1JGNIWWekIBU3EGdHY+OGbwU7g/pgSGGG6JUVAzHhFdGboyKSoNNrNbBlabnk+4UQVzU2fSN0KDiN1ZxAsz+LAhW3fDKZfZ4XTx+cVP7Xe8SL1zpAOzVh63ESKQJ3CoWe3RhSbJNuNS95g+MSHiMXxtVBGfQBrevA3oxbxtN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UNPuSzAI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eFDpZDThO9ZUXhvLr943J7tFbqJ2oSmbcZOg2Nf6vKs=; b=UNPuSzAIBPkMwZL4iDKxp6HRGx
	GLDA/nWEF/LcfXIW/dIt75ASHCfczHUdQip8NlNKo/ENusc2jIM/E2NjrJxeNjv8FKt1AGmnimxfu
	AXiX5JI+hTknZFAD5k41MiwHar1a4UwfzbokCLAFsUXRTl+PYdkklahnEbDFNietbBN7X68crXDHG
	J6M42g42xaAyrsODpJNstAOeI0JTOJDtbPpns47Kd96xbCe8b0KYr1IaAuBKrr0ev+B6I8rdcfKD1
	OzpQcKEMdarMzQejtMtpTMJaMnjv0BYbawmpovBNOISKgc2VrgjWUIl8mvQzoaKZfA1QnatzOCzlG
	pdC0rWLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zO-00000001g9h-0oIE;
	Fri, 12 Sep 2025 18:59:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 9/9] slightly simplify nfs_atomic_open()
Date: Fri, 12 Sep 2025 19:59:16 +0100
Message-ID: <20250912185916.400113-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
References: <20250912185530.GZ39973@ZenIV>
 <20250912185916.400113-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c8dd1d0b8d85..5f7d9be6f022 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2198,8 +2198,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		else
 			dput(dentry);
 	}
-	if (IS_ERR(res))
-		return PTR_ERR(res);
 	return finish_no_open(file, res);
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
-- 
2.47.2


