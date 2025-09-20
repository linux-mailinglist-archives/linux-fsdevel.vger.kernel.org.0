Return-Path: <linux-fsdevel+bounces-62282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF98B8C209
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF353B0DC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E9289376;
	Sat, 20 Sep 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o3oTpbJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229326C3B6;
	Sat, 20 Sep 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354486; cv=none; b=acGYZqsgd5bDl/iag8VMwPkTG8mhUyGUzeaQPrhRQpg5JQT23VfFFyw0qG+sHhU45kH/cE1x9qGJzADb9HkTYeSh42Jrcsy49gqV0ywS4wYE0VDdbKi8eRRrtZ+mdtl/O0EO5s1hpgbkuyBDCTuqLgiv8sqXxBkYoVv9U3Y7AVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354486; c=relaxed/simple;
	bh=uIkWhT5lBZMbGKboTZYEGGJGOnQwh5txmBIVng9mTCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0xkwPG6qhf4m/FQS7B9XJHPqWX77p6qTOeh/HVB2WH/D1nk4sBLjA/UKF0A2OBq1HKu1PQeMw5v/7juUtu77yjapeBVlVAMePv09ICTm61weYCL03MfV/jT4wZ3985GTNE373QMdDxzfmwDoIQHkpX5VZW8dMJDIABA0CYivfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o3oTpbJK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nXGw1nJCnekakkZR178NLSh8+iviODtKUClSm5rridQ=; b=o3oTpbJKkO0Lf5LxTLzK7R+SjW
	TY+nHLhBwrZkYyS9WBssOe4sbsADlN+jFSeqzXZkOQjGi2O4Aeo4KhKCAL+uoM08I/W6ppWx/eK1G
	YY8o3Jj4jFbuvUFckeTwI7kn0RccvdITK6eax7xeINKs4OwT/iQ0BWdCvr1W1NtLfklNt2YFIfGss
	68ABYs9XQgrWJX+naaa+H9ogU1NzX9gubWis+XzSZ+Z7Tx5H+qt9YdoGGZ7ruUliSz3cMb8b90ji/
	7Mbnbd+9p8UeOzS7783Z6QXJvmks9Z1wfcIsVpewlB6Iyx3Yx+N1W+Yy8PBzZxrdZ5aUqlwZ39did
	6Uy9Kuyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsK9-0000000ExCj-0reI;
	Sat, 20 Sep 2025 07:48:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 09/39] convert xenfs
Date: Sat, 20 Sep 2025 08:47:28 +0100
Message-ID: <20250920074759.3564072-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

entirely static tree, populated by simple_fill_super().  Can switch
to kill_anon_super() without any other changes.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/xen/xenfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index d7d64235010d..37ea7c5c0346 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -88,7 +88,7 @@ static struct file_system_type xenfs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"xenfs",
 	.init_fs_context = xenfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 MODULE_ALIAS_FS("xenfs");
 
-- 
2.47.3


