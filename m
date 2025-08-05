Return-Path: <linux-fsdevel+bounces-56710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D1B1ACA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D978180556
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF11F1315;
	Tue,  5 Aug 2025 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KmFif95L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D21E5B78;
	Tue,  5 Aug 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363375; cv=none; b=ezQGGuHYrUf1dejSJMJsYpkHid6EobTWMnF8ON/cnfX5ODA2Otufv604tlAJu+9mQQCVX30TBnT40s5VTA2f+AB6umJG9m1UA48QP1IQg5IHjeidoZ6ytZkOUtgOfOKVcG0IQafGUgE3q65HiyDraHWQg3GcQgitl74cTfZaX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363375; c=relaxed/simple;
	bh=se7k2jYLkmCCJf6OzPRIBN6BVtEJXINkpUlnhHgwbyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hazc9RdGuGu8uPI1rqARZXZeTXcnyyTMAHs5u4YLMDiq6pDk1NWlsOwK0ClSJ7qV/XF2/o/pHUAOWC06rZRJ5LQNCUH3XBXzMlD2JCq5tFKKLchUILogjIk8Ek/cltL42zxAPuZNyaV4SrUyOLxsBm30Wm34AqlgIxwFjV3Rrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KmFif95L; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AuaiQMyoNko/Bv7nJGtZn0B3kdMsZfWg7xvk0nStPoM=; b=KmFif95LMyPV8nX1CZWmA8d/JU
	SLOkLp7viNGSP+fDeyO+SY0ELeDCr0+aroQLu5y9ZWKlZC/RhjUoyqSgvd61ZOg4ctbRbQ/AIBXNJ
	BsmMJdDnGXBTqtTBeT80xZciTw6JlaZta7XNcYhS03DUPfyGNd4bgP68fpLUXVEfmELSi6lteubK9
	5KAjg0wKuAwTly6UnRb7sXZgM7eJGMtjuu2DRmzCdJbXn+OpSiiSi4vnLQgJbYSsVQvyzsrm9V1V2
	KRKKwqO/h1INIWQ/QsNIvv1KdEhocGLX11RokRMRr4Sa7jv6rAyqtarhpZfTy22nwoBlJGcUXxco+
	nvzb24OQ==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83P-009TiJ-Az; Tue, 05 Aug 2025 05:09:31 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:10 -0300
Subject: [PATCH RFC v2 6/8] ovl: Set inode S_CASEFOLD for casefolded
 dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-6-0e54281da318@igalia.com>
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
In-Reply-To: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

For casefolded dentries, set their inode flag with S_CASEFOLD.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395ecd01a124ad029375b1a1d13ebb5..5dec29811b6a5088f838793eb2f561abd12db1d2 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1301,6 +1301,13 @@ struct inode *ovl_get_inode(struct super_block *sb,
 
 	if (inode->i_state & I_NEW)
 		unlock_new_inode(inode);
+
+	if (realpath.dentry && ovl_dentry_casefolded(realpath.dentry)) {
+		int flags = inode->i_flags | S_CASEFOLD;
+
+		inode_set_flags(inode, flags, flags);
+	}
+
 out:
 	return inode;
 

-- 
2.50.1


