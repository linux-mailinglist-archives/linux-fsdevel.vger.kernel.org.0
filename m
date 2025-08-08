Return-Path: <linux-fsdevel+bounces-57159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FBB1F00E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6311650F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20024293B;
	Fri,  8 Aug 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fQXa4fw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64EF284B36;
	Fri,  8 Aug 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686775; cv=none; b=IMBNlN0PKXTbE1RIRumV7VUSdNNJsb6GrRmS9l5plBgcsNAm10wGP+6xiQXO5qCv5cYSFyOF6izjduItqHHaY9papzzFWVXklC3d5PFOnr9CllgOyhzAtkU/wqef2CyVyozG2diXq3hqIYloWDdqqF6uHh3q/7DOgwGkU6OpE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686775; c=relaxed/simple;
	bh=bEyQbg6R1kJB0oUzkrNONklZ6LLiDcLYZ8kKhCpu1lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgxLyJB+bXwdXu3p/jRQnEwRY0AhAGQygdKAwlT5YX7a/UGlr2Cwbg+mmYIEwwKLkZNMGKhZM7qjzliQuT2p2igalqCa+AxY7BOsWsZs/5atTHC2/75FmRtk+/QR9Se6LgVQU08IDy2Rf4V3GQjH/MwI+FscPkh+2QtZskCe6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fQXa4fw8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GHI81D+kXndW/mWzdJKZDgD5mhBdjY+srQPntrHrfVY=; b=fQXa4fw8D6UztZlMCUWL6ezRgV
	e9FxJOBSACftIH4tJE4oSBAkEr8hTS0cRf1Ogd4aQCGSNv1WRRTy5F7kZ8Q+KrADEjtnp2WliLyZP
	9AHtQIKFvdoYwcp1KuMO9UrHruOeHsBkT5h3MGxEhsNgbwXds/a7+VNzzzazlruP2oIVUC7kdIJWN
	/5qfN3XUUzQlZTCAlHM7LtA6/U21SC7vBT7CaOWc/ahubLE6zRUEcrZdXiJFC+VJs4m5idYwAAM7Q
	hDiTnux7RnONZp14ey/F7FjnbkiovKw3Mh/bOF2OB/Zb5LJKHlyvKg8fn8VoIAqjnflqYGO+5NOT5
	ns5cgRTw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBU-00BiQh-Pq; Fri, 08 Aug 2025 22:59:28 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:48 -0300
Subject: [PATCH RFC v3 6/7] ovl: Add S_CASEFOLD as part of the inode flag
 to be copied
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-6-30f9be426ba8@igalia.com>
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To keep ovl's inodes consistent with their real inodes, add the
S_CASEFOLD flag as part of the flags that need to be copied.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- Instead of manually setting the flag if the realpath dentry is
  casefolded, just add this flag as part of the flags that need to be
  copied.
---
 fs/overlayfs/overlayfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bb0d7ded8e763a4a7a6fc506d966ed2f3bdb4f06..8a9a67d2933173c61b0fa0af5634d91e092e00b2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -822,7 +822,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 void ovl_copyattr(struct inode *to);
 
 /* vfs inode flags copied from real to ovl inode */
-#define OVL_COPY_I_FLAGS_MASK	(S_SYNC | S_NOATIME | S_APPEND | S_IMMUTABLE)
+#define OVL_COPY_I_FLAGS_MASK	(S_SYNC | S_NOATIME | S_APPEND | S_IMMUTABLE | S_CASEFOLD)
 /* vfs inode flags read from overlay.protattr xattr to ovl inode */
 #define OVL_PROT_I_FLAGS_MASK	(S_APPEND | S_IMMUTABLE)
 

-- 
2.50.1


