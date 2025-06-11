Return-Path: <linux-fsdevel+bounces-51260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B45AD4DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85EB17C6EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D548C246778;
	Wed, 11 Jun 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A+SnriOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457923E346
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628486; cv=none; b=Wh77uinupmKVGVAamgSsuFPuI94ZKrkJYzMuaGJy9iinhVNzapeyZXp1TrpZQtA7cK/DwsBYjOA5NNJs/crSwzDxHHerO/xhIYB3ktHftNlbXWPehurGMD5JXV1CQVka+oVt+D5JhTJMU7ES5CXyWQ2r2/xGk6PxuS065Nzz/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628486; c=relaxed/simple;
	bh=tBHZBLeXBE96UdflTTYxI3yhDsLj382iHv9o9xZt3nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hc1K3jgwwpfwPSxCo4RpmK40Lgd2dG7v+JRPG8gYpOFQpfwE6GFlqdd68RYBa5PS6KhAIy8256pNY8n8h86LeDPXITM+3Hrz1RT2WbtKR3bU7d2U1o+nET+yNihi7YNbEpgOjc1bDOE9xy125ypauDJlCHCzLOvXycabAtEQFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A+SnriOl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JzcD2N0Bj+aJ6+4MdqWjFAFqXAlAGqDy75nsVM3AEas=; b=A+SnriOlI8T2CqKvzpYAmwuZbl
	JGjYecLbufo2Pgb0hSmVciA6jSwpSfb0Bp7yhdiTYGpX8MfSbQRXNJ/8ZuS8bcSj4QH4Fh4S9txbu
	pqdD9iOoUeVCudtqJ4dL9oma5QHZ7du4Fy7PxsvD2r5PLevyYiCqydtbvk210iF7JEgRt6fcPGf8X
	xt4s5cz0cDsZQz+DJaEmz5lQVjnMr88yYtA7Vc9m7u/tSIGfqpac98idqCGqsq5jRxmTF5Em+/ra+
	A6bevIec/0/o9J40Otqk0REJCGG30EhZ2IrxnfjFshDSlYQt4KZdDy+q4451sC6EUMWfQJ0uGBhq/
	lcX39rgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGID-0000000HU0M-0J3O;
	Wed, 11 Jun 2025 07:54:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 21/21] tracefs: set DCACHE_DONTCACHE
Date: Wed, 11 Jun 2025 08:54:37 +0100
Message-ID: <20250611075437.4166635-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

*NOTE* - this does change behaviour; as it is, cache misses are hashed
and retained there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/tracefs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index c8ca61777323..40fa6220189d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -481,6 +481,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_op = &tracefs_super_operations;
 	set_default_d_op(sb, &tracefs_dentry_operations);
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 
 	return 0;
 }
-- 
2.39.5


