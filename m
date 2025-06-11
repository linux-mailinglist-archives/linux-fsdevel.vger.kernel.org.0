Return-Path: <linux-fsdevel+bounces-51258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB5AD4DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84953A62AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88F247DF9;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d4UVWpF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2223E355
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628484; cv=none; b=Uo9ERqssXj+x2B9hg80YLPnW+oJTY4hSL23q1v3ED3zNveM6ZzZxC3Do1vCFit6/R+xIg7fnK5iWcJIF/Dk1Nr9ENSipCo90TShw6CZdJiomEQgD+LTCdR/FlSkV07a3PZRK+Lsvu6KiM+TVrpF6mgcsvfrVfkkIvTzDM8qJWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628484; c=relaxed/simple;
	bh=8jhfWXIyUDWzSxxs2BrIfpAEIXhFInod2hBAgImXLS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXGjSHeFBSqJu5g6SvBAe91aIk1H9rNyUdhTHuipKEh+68lWURu6PqhD/FuvKBHTwi/Ozyxzjat8VI508SxlJiwTyXi2yT1zRDCVZmnPtVD2GSBMv/N9FblQaQzRmnwHTWFT6sTKy1SsDh9T+z5jvDTD5so/Zus1cSBUoVK6ECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d4UVWpF0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xg4X3GjaCPa6gmVGSmaYYfbzlGL/Rg0ypiNHZX3qqIs=; b=d4UVWpF0VbntTNMLcXlpI54JDP
	28felgB5ghPVKy43Ia9WcvSj2eu6EvekK2E7U7XSnOmPgDbVMlrL7o8JQTfV9N205vePimZoqzRy7
	x1Uf5Q+Iau4BfDJEGhAQNMZCHHG8B7nKrMPebt7isRQ3ONNh0cngvgZsWxpmRihYV+zyL8VYkNbbo
	8bJ+6DMl4IlZdnWRhF6/ZwY3N32T2PYM8JwK9TVOnd3PmYRG8DW8CJu7T2mZduacP5rVGK3WjUKZ7
	aMMgGp2doOOwq6cHJWcVufqZrRdyaBqTFBKsC2O4RIh3u0IYbIzHoTHQOnCeFRrNONoqOxnnXxeIw
	KqCnbeIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIC-0000000HU03-3iSa;
	Wed, 11 Jun 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 19/21] debugfs: use DCACHE_DONTCACHE
Date: Wed, 11 Jun 2025 08:54:35 +0100
Message-ID: <20250611075437.4166635-19-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 29c5ec382342..441e3547a4f3 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -258,7 +258,6 @@ static struct vfsmount *debugfs_automount(struct path *path)
 }
 
 static const struct dentry_operations debugfs_dops = {
-	.d_delete = always_delete_dentry,
 	.d_release = debugfs_release_dentry,
 	.d_automount = debugfs_automount,
 };
@@ -274,6 +273,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_op = &debugfs_super_operations;
 	set_default_d_op(sb, &debugfs_dops);
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 
 	debugfs_apply_options(sb);
 
-- 
2.39.5


