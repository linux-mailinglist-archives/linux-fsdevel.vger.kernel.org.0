Return-Path: <linux-fsdevel+bounces-51122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E8AD2FFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E41D18954AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966E28151A;
	Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mKpl3oOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503421C9E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543712; cv=none; b=Phdnsz1fc7DyslBH/tbduaqT+ee2909cpSAGy9neeq5LHJdGjrnS9P/pDYucL7eP+vokkGn467ej/lCmHJ4Ro5TLzH8PUkQEQEuCrjuGErFHHNCtDl4icK/Ih+M+U1ywc2Z6tMqR7doBRPmt9FlzBiOfiFUApBgC7m5cS3wHjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543712; c=relaxed/simple;
	bh=Lf9P/wXR7jVPPsuDn6xpsaXi13NKJYAZJuabMqhmOTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/Qzg2FsG25yb0MaEq5YkQ/5BrR3Xnf5Tzx3XpOyx58FzlIhZiIIvAx3n6eBHdsJE0WFgH7FxOHpJwAc+JCBy/a9A9fohYyeguKUDLx751l4ShYJvr/6/RpL5zvtdDdWcIaWlfQCR96G/mB16Yl+PewvJ5J+PskJAz4rtBQqJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mKpl3oOG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bXNS8YNCBBBDQnLKk/GBA+e+NbbfUjncLANe0prOIPo=; b=mKpl3oOGOsiNcCZRYQ0g7LKJ3H
	mfmAM5R153WUp0qDUAMmkNHN94ly5wLj4li3UuxXErdxWzdrNPY46M05CbDFHe0mtIjA9xlLyIPh7
	kcojagL0B3mTnMd8WMTgxPnZEL+96PsTObHc/kEZSHW+ByyBde4AkFakoSj/roeMl9l3O/tVsaJYC
	ugNrUmmBOoyivMC24zeepohwUXhELcXIrZ5AAa6/n231jsUubpgQUVEdYDxUaGRarX2WzE+9McC71
	Xltra+k7sMBjH8hwaIwyrlFp/FHdDASIIAdn0r92KKlkmqlSV6nw8q0oC93AEQcq3/+WTBv7oInuz
	nIChqHtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEv-00000004jKU-04Ha;
	Tue, 10 Jun 2025 08:21:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 01/26] copy_tree(): don't set ->mnt_mountpoint on the root of copy
Date: Tue, 10 Jun 2025 09:21:23 +0100
Message-ID: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610081758.GE299672@ZenIV>
References: <20250610081758.GE299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It never made any sense - neither when copy_tree() had been introduced
(2.4.11-pre5), nor at any point afterwards.  Mountpoint is meaningless
without parent mount and the root of copied tree has no parent until we get
around to attaching it somewhere.  At that time we'll have mountpoint set;
before that we have no idea which dentry will be used as mountpoint.
IOW, copy_tree() should just leave the default value.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e13d9ab4f564..5eeb17c39fcb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2259,7 +2259,6 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 		return dst_mnt;
 
 	src_parent = src_root;
-	dst_mnt->mnt_mountpoint = src_root->mnt_mountpoint;
 
 	list_for_each_entry(src_root_child, &src_root->mnt_mounts, mnt_child) {
 		if (!is_subdir(src_root_child->mnt_mountpoint, dentry))
-- 
2.39.5


