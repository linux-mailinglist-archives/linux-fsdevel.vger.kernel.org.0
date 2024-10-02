Return-Path: <linux-fsdevel+bounces-30819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39A98E750
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F12883EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C321C6F48;
	Wed,  2 Oct 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bka5vrt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD31C2DBE;
	Wed,  2 Oct 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912735; cv=none; b=mKkOrocDSv2BC2DJcYF5JtridPG68+3OeNKFuzwf/yU2UP/Zq+rVw5GtmKEnMkbsAszFyDV3/AP4CiuM6Lv2VgAGndineiZ04RGB9Az8IA53eoxuh6oZIDqXZ/CRbygArudSLbXeOzNXnqaZggCartpNnDe628Pw131D/fxgob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912735; c=relaxed/simple;
	bh=baYyqH1zkRLR2JTEM1uWa5kkwLV6py0GhE+cOwhsPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSKxPymW42Kf89pWr5uC1isnmDWEL9Lp9jalM3cboJWZR241XVXGOijDST6wlxmHqQJSNrceh0DZ8GabMb07kTJFZsbxMY8n2uWojSrOe2LKxHbOGhe0RUSKdV+RNLvjtP1FTVUfPWCSbK21wcPRjhncsY2NYTcrsK0mK958AR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bka5vrt0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Quu0dtbQ9E+zFuEMK6MzcOIEYam2pR7bqkVHBNP4Z1M=; b=bka5vrt0u16euP1xIhWZ/Kg1wh
	ar8IE3EbJsB3viwk03hqbcr4jQJ2jK9Xd6LueY/9eMGT++ho5OGh5/nR0NfR5aDwNNIoORZs/tzPz
	xFCknGIhr9MWfGMTi7ksYaVVUUNTC7KXm0a4Ifde3cNKpmNSRYxCGMWk/4ECZlxRe2NbGewsG7ttU
	t9jE5ElARxyxdq15MgdjrRrqqiW5cAx8boixraK6bpaUw1r/5E6uO6yzCTq45C4dbRy9hfU7qwsMV
	CmUkUxxnREwLcSVoSqLD/1vhksx9xUx1OfIaSteNU0kxODerKgSU6VvcJH3wt1Syiovvb9s8Zj6NQ
	rIR49aAA==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw924-0045tc-N1; Thu, 03 Oct 2024 01:45:25 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 06/10] tmpfs: Always set simple_dentry_operations as dentry ops
Date: Wed,  2 Oct 2024 20:44:40 -0300
Message-ID: <20241002234444.398367-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002234444.398367-1-andrealmeid@igalia.com>
References: <20241002234444.398367-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set simple_dentry_operations as the superblock dentry ops, so all tmpfs
dentries can inherit it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4f11b5506363..162d68784309 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4662,6 +4662,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
+
+	sb->s_d_op = &simple_dentry_operations;
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
-- 
2.46.0


