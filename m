Return-Path: <linux-fsdevel+bounces-52444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F577AE3473
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD929188D467
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C391DF96F;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DKozQDa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7E1BFE00
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=mFpe8oyPbdaNAkbU2r8783BdC2SifclWD4IrM9Zyf7Ki8C9kpjs/OPutvZidLdtqr9Z+Xbu8NSbh4x0JMXn33SmYfy6IrFdaNkWLrhemRpY+T1j8EdJWaz6daWuVK/V937jFRtTQ0YPY7DSt5edgVB6SdPJgjNDL2mMKU7WMmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=9PLA1R/ahhpdN4/0udkBPSY9ZO6yfbO3It6R3c65Fxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efCAex2jmGtONpsB1JD8uBM9y3FBTQbu/OBkXpUVwxixDRm5kAsXR8YksxP2L06KPLQxurCxjdPnLmAtZLd7waG+2xtWu0OPnguD0CT/hmObS4NaU35IUbiaMxZWHZpAuTnhP+EyqlcggI9dT2hZKq3Ip1omoXOXEimCGFGxSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DKozQDa+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fPdBY5kkgMmJIA2Pf5I3Bx89JzxUbmeYWrtLaUA9uTM=; b=DKozQDa+Q0IGnF4xYtBP4tm3XL
	YnFZtHzG+4MuMNgnt9ZOXN5lENT7MH7iZPdZFoNJMzhdoHQSJqZAeMVtsQVSUgqlpeWffB4s2YV7L
	e/BH70Uyx4HO3ZVd8H/43Lzy6pfXS66gg/bojuUNsacjh/7s7IS3POs9xChzHDmry2aF5MYClp5jw
	lQ5SE/zXnjWWbrfaDx9d2WW8oT4DQwz+wlWTpL7evOoEvOcXwewlgtb9IfCjQjyZdw3RlkdbP3NMF
	8Luyz5T4NqBYraCpKJNw/eRNy+Gk87Y90X9DnEZDWMdQ9UbheHxMGTrunIXjYm/cCJ2yvV9m1zI2q
	vXV6iq9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCO-00000005Kob-4BXf;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 06/35] copy_tree(): don't set ->mnt_mountpoint on the root of copy
Date: Mon, 23 Jun 2025 05:53:59 +0100
Message-ID: <20250623045428.1271612-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
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
index ea10e32ca80f..e5b4ea106b94 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2222,7 +2222,6 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 		return dst_mnt;
 
 	src_parent = src_root;
-	dst_mnt->mnt_mountpoint = src_root->mnt_mountpoint;
 
 	list_for_each_entry(src_root_child, &src_root->mnt_mounts, mnt_child) {
 		if (!is_subdir(src_root_child->mnt_mountpoint, dentry))
-- 
2.39.5


