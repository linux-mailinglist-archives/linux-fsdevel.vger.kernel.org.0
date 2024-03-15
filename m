Return-Path: <linux-fsdevel+bounces-14425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD187C820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 04:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EB01F22071
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75702FBE8;
	Fri, 15 Mar 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jh0/rgLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCDD530
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474802; cv=none; b=t3Xi5UKVjd3yrkBrHJp+ZXPAKN3OsBlAazVPOx8UjQqK9URU6LK7MHuS8o8HFvXbqQJ0xcHwArK+CbOAQlaAyoUAPwQwoyQWOvv3DLRs2jcJ3UkkSKk4KUfTCoY8WYT/C/c9sCSKQAX37vtCmD2IaIOgQcvbJIT3C9QbWqWlfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474802; c=relaxed/simple;
	bh=/LueQ1G13mqVU1G0GdjbjC3M2usr9mpEcPu/Uaxz5sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmqdHHreAlivbqis2pnoNDXXfCakk5PsPJa0QbGHYEyPL4y7Z1uC0lqgb9r9Ni59vfCqiG3ske/GKZJ/VzDDyH/5WbxXuzf1dRrTY0qMOrlHcuuZtGE1Ccr0Dd0zsS61SdqmUJYvh1NWm9VWg83vaK/Ql9mGjF5mTrIsXYrx1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jh0/rgLs; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710474798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gsmBQw4bUZ2D0XG7tW7X5KxLNhuOa5nEfyJ0hbF4Nw=;
	b=jh0/rgLsvq+FTJEEueBkFHFB0Y2sj+exqZBFAxRCPMtcQ0cm9Kh3AzXvnvBgaXxhKk9cLW
	LNreMPbNb5jXwQNOl2E9v4O7CL9Ge78QBx1R88jMTtkBRzMeQGxkWJE5YAd1Zo4opcg9pk
	/J/JdcenZfUvnDwy9IKOYkC99Nr4+NY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: torvalds@linux-foundation.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/3] bcachefs: Switch to uuid_to_fsid()
Date: Thu, 14 Mar 2024 23:53:00 -0400
Message-ID: <20240315035308.3563511-2-kent.overstreet@linux.dev>
In-Reply-To: <20240315035308.3563511-1-kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

switch the statfs code from something horrible and open coded to the
more standard uuid_to_fsid()

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 77ae65542db9..ec9cf4b8faf1 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1572,7 +1572,6 @@ static int bch2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * number:
 	 */
 	u64 avail_inodes = ((usage.capacity - usage.used) << 3);
-	u64 fsid;
 
 	buf->f_type	= BCACHEFS_STATFS_MAGIC;
 	buf->f_bsize	= sb->s_blocksize;
@@ -1583,10 +1582,7 @@ static int bch2_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files	= usage.nr_inodes + avail_inodes;
 	buf->f_ffree	= avail_inodes;
 
-	fsid = le64_to_cpup((void *) c->sb.user_uuid.b) ^
-	       le64_to_cpup((void *) c->sb.user_uuid.b + sizeof(u64));
-	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
-	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
+	buf->f_fsid	= uuid_to_fsid(c->sb.user_uuid.b);
 	buf->f_namelen	= BCH_NAME_MAX;
 
 	return 0;
-- 
2.43.0


