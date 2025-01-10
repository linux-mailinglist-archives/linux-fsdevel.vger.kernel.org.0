Return-Path: <linux-fsdevel+bounces-38782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A5A08591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22913188BD50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6864F206F1F;
	Fri, 10 Jan 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h1MN5U4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865031E2607;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476988; cv=none; b=qww9aKlstUTPG7NOJInCarDOc7lbNCfP8R3veikzRnRyEIZevSG5uuWXYUu2Jm9C3V78GRR/Mw8IqeYkqS+hvdwrpsxmX6ceMeQerB3lMmGW7mXQCzbbZTb+snhLHM9JWFXugKs1XpaaYloFsQcTkst21mdoVV0r97Ww7n1WB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476988; c=relaxed/simple;
	bh=SHs2ilSWDO/pKgcDk/TzeH6WoJeSPAPSLHBpIkfNX14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds8UTE+nVM7PPeU+/4h8aZrmcrZzsarHZ/K1t6OpZ8aE7EXxxPcwY9/arv3oVtyMak91xhuQMEazmaJgn035R0gJQIjmBqhYdn78C2ybN62nN+cQKECwkfI5EbVgYIlq8cpxunxEOR4EMnLbpGyciuqI5Sps9btgTpSXEZIMSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h1MN5U4N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e09c+mh4a1QxHTNrOzqotxokwF7Jj+VLy4WQY4XpFUQ=; b=h1MN5U4Nml5YcwrliNCXqQQAvH
	tyoTx2F8SE5q3TaWKydbG4YdxyfiN4KhiUpMOf9m885iiEtruzg3rcwEu98cp0yaA+S8kq0NNQuS6
	pDc2PlumH2Mfsj3K6H35Mvtm68QQUd9Xwjf86PNUVFIqnh+lApGcAzvLSSL/tSW8n5mZhvjFqZu3y
	Ti2Q2Spouou32ndxc+aU8HLRTufWVB+5UEpCmwUnev7Swy/aZzFtwF95J4kSLkIFKmGDlc9T0M3lY
	V1O+7xyu+A9Nmt7mg4kLXL7XhuvkPPW1YCq0uiyRtf5d+F00dL2wfMt2+mYkIVzrXrcfpEEZU7GiT
	YGqOjAYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zI-0000000HRcE-3gO1;
	Fri, 10 Jan 2025 02:43:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH 12/20] exfat_d_revalidate(): use stable parent inode passed by caller
Date: Fri, 10 Jan 2025 02:42:55 +0000
Message-ID: <20250110024303.4157645-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... no need to bother with ->d_lock and ->d_parent->d_inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exfat/namei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e3b4feccba07..61c7164b85b3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -34,8 +34,6 @@ static inline void exfat_d_version_set(struct dentry *dentry,
 static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 			      struct dentry *dentry, unsigned int flags)
 {
-	int ret;
-
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
@@ -59,11 +57,7 @@ static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
 
-	spin_lock(&dentry->d_lock);
-	ret = inode_eq_iversion(d_inode(dentry->d_parent),
-			exfat_d_version(dentry));
-	spin_unlock(&dentry->d_lock);
-	return ret;
+	return inode_eq_iversion(dir, exfat_d_version(dentry));
 }
 
 /* returns the length of a struct qstr, ignoring trailing dots if necessary */
-- 
2.39.5


