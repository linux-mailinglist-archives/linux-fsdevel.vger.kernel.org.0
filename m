Return-Path: <linux-fsdevel+bounces-60435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95EB46A97
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F935A82E7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB822D2384;
	Sat,  6 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WR6+gmcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782532853E9
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149904; cv=none; b=Nf2no0jAq73vv+EF3kRz0FTe00B2GvNWT1sWEd1RwI9/9kfDFhlvyf/ehEwYvwdbZHA7/DCvWvqFREF8xPOvySyAC9zh0gddW8lOkC1rFsSLDmbgUUpHsnAHXB0ZEB31Bif87zTDUblaW+ZqhAAfJQbweV1iUlEDbYOXmIhUA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149904; c=relaxed/simple;
	bh=ukCp/b0q0FJ4Kc9dK3499d7aVKZ5lc7Fa0MNEF1QF4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhngEYc5AKUdpvovm8ELEwwOZtvskremdf4fUTQJdeTOqhEAPBUO5blL/4rpNh8TndZkcaShVxLZ/FdEYzfg26dCBHXPknI576kTDNvT795HEyxf26mJJma12J1tmd4vCGuJG6iUqF3v6svpvHO3FbS8DcuIo7IxHwJoHxPdUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WR6+gmcU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0eQv8itUCNnfIW/7SMANkHmVdzW4FphblxKEFFWJuPw=; b=WR6+gmcUd+oDrVjTtjRlhTR2v1
	L5cPUWqFkp73lbOvkTo7u4jwug4sC+bYv7rTo/C2xpeVm63OzTFLR77eu4Y8cHsynedtkAaffzNXi
	FrcAVEodBGQieWsOc1vZbFyGPKowutytuDY4J5dsaeQSovsBe9tY6OBddWnh1sBIsvK5a4458h26K
	Kpz7JFDMkMZGjZN4rtIKGx07gr/NKfacZrQzA5tGD7zKPGoQ0KGoMLbR7/pqF9oY4p1kbvtpuonDS
	MjjzdlFbAeW6fRXXUQOEi0kPxojVrfq8qLmV6bAcmZyt5yrtfiG10uoNEe7SzXlAyN/CiwgYGk+1U
	WG/nlttg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxO-00000000Os8-3VA2;
	Sat, 06 Sep 2025 09:11:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 06/21] nfs: constify path argument of __vfs_getattr()
Date: Sat,  6 Sep 2025 10:11:22 +0100
Message-ID: <20250906091137.95554-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
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
 fs/nfs/localio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index bd5fca285899..1f5d8c5f67ec 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -529,7 +529,7 @@ nfs_set_local_verifier(struct inode *inode,
 }
 
 /* Factored out from fs/nfsd/vfs.h:fh_getattr() */
-static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
+static int __vfs_getattr(const struct path *p, struct kstat *stat, int version)
 {
 	u32 request_mask = STATX_BASIC_STATS;
 
-- 
2.47.2


