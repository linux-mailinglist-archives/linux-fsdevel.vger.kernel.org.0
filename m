Return-Path: <linux-fsdevel+bounces-42522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B5A42EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E3A16587E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55B1FC10D;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jkyD3uAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526A1DBB03
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=RREvCAa+6n676hAMaD3aD1i03hWO3tuc38+W/qacwYPjclewF88rE64NevvYKExOszO0EmHnNwSEFaeutvGJqpUUAaV9R+Hm8F4gWvNbCBdPzY2alfJGL9tDCdXwY2J+paz2gDv3dmoBc7qf0EAozw/5AfpJ+P33SoYppTg78Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=83nk0FVDJeqrg7Q5kyyoA6JxH0aJCiga6QPnEGbcOlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqanY5rHaAqxbfgG+uHJu5sxMVXFxINXKbFhH4IEQaqBHIspDS4WiZUVmgVOn3QPhR2wdb4GsO/DJ8/9gU7eanYzrSYhBbcm7onmSHZrvTgua7DBYayg6bOTGxzOW9z/+XcZCDnfzwSrnhpyuSZ1309o2bM5E76cKsRz78Xr0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jkyD3uAr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JK8SlADR+RwR4cMfo/XBrXrCpCIVHOdtaHNb4A2Eiv4=; b=jkyD3uArLDWx+36T/3pi69oJqx
	/kpjO2WGPKHHNCmT0UiY3FeMdrAhWNuodPHAk0EOgua8W5j8LxtFWEBOdVIvQC2Uoj93HOmKtwQ1+
	XmKBk6DyLHguYBS+QTpXJR6lkBoXk5xXnm5k7JXlnOQ5f4p4FhNsIlbm+MxD+JKqY+5bpC4j0Vzeu
	FNMAcpuM+CjgX1myWVSIn//EWBMBN1rSgoSEI+h0dqcLBHN3d81iIrxC/+2dqpUTbbM71NPg/3PsW
	mt/EVOY3lHZO5REn3PqsjUTo94bZQ5KwraR/FSqwi5ntDE2CekLs5Lae+wR8yjaCQJwRnLmlHvvEt
	Jkh21w6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007MyH-3wai;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 14/21] hostfs: don't bother with ->d_op
Date: Mon, 24 Feb 2025 21:20:44 +0000
Message-ID: <20250224212051.1756517-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All we have there is ->d_delete equal to always_delete_dentry() and we
want that for all dentries on that things.  Setting DCACHE_DONTCACHE in
->s_d_flags will do just that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a0e0563a29d7..52479205cefe 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -920,7 +920,7 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = HOSTFS_SUPER_MAGIC;
 	sb->s_op = &hostfs_sbops;
-	set_default_d_op(sb, &simple_dentry_operations);
+	sb->s_d_flags = DCACHE_DONTCACHE;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	err = super_setup_bdi(sb);
 	if (err)
-- 
2.39.5


