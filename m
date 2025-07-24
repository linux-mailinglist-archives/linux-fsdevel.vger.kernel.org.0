Return-Path: <linux-fsdevel+bounces-55927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278AB10248
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865E37AE82B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E526A088;
	Thu, 24 Jul 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Wos8wTCA";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="D2F4cB7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20826D4C0;
	Thu, 24 Jul 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343424; cv=none; b=C5oeyXJTJfKZfPDqezYWQDUaGReJpP+VAODY0N3b7mmdvcHOYgZ3Er+GYJ7MrZly27RQj/7lAV6PmiWe/2vEljyG7zkKErpyCXIGkX3GES94+M0VfNf2qUQqhVUBqLteF4mLTjP0m7GIjWJZuhTDORwJdOBr7sZ+6YJ+eXduXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343424; c=relaxed/simple;
	bh=5QP2P5egl4AeR6eIxyU7F3LAbR9QCKx4qzg1UlBntS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1NZoByysFB4DFMaAD40kxqmJyEAvZE4DGOXi0rwATnYArPDZGfPb/RSOwSrpkPgKirMTnmkvGK655cg4UDTuRfQPJQSbyCNc4uL1JEK5lh7+6Lqh2GY+U5msLFWOci6nxVcO4yVgZBFrSYRp1OqfvhxVlhWc34urT9q0OmtGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Wos8wTCA; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=D2F4cB7n; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 0EFD52075526;
	Thu, 24 Jul 2025 16:42:12 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1753342932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPPPPGsRY/QNRlNqcuF0sCT1ZGcNPFSHSDST9Ann/Jo=;
	b=Wos8wTCAErBVEUOXcQVOTw+GMfILWTDDgDfqreGPXflHd9emj2cRITMzb6v4sP/7Dfvxos
	kMSk/H1YHAo5lwHF5J43gny1ve3gZ4YO/wUtXoUi1+7PRjnfP50TRKt9Rffyb27WGAeY9B
	KzzOZDm7NvQvwBhmFkYoAXi2dvtVc7C9u973RkrdPc46WMzgIFweLZ7dn+D9tbeYC060vJ
	cGSaRAZOklPkvEWLZk3OdYAlJ1QhQJ2QscaZDtd+au1LroXkRfFwI0XuoVziyCs0nRW6HG
	xgzylpeQ0wHYifQqrE9MloeZ7UXjRKAei2KNnNf0TTj5OmKfIHqemVwuJ4Phxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1753342932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPPPPGsRY/QNRlNqcuF0sCT1ZGcNPFSHSDST9Ann/Jo=;
	b=D2F4cB7nfQP9gA8xmSOmJPoaCyzCjC+lq2W+DmjQPISJfOq/SclVt5lV9atrNZJKg5vXXA
	+4jjjFEp0lzubKDA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 56O7gAUo262530
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 16:42:11 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 56O7gAX2856669
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 16:42:10 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 56O7gAi9856589;
	Thu, 24 Jul 2025 16:42:10 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+fa7ef54f66c189c04b73@syzkaller.appspotmail.com>,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] fat: Fix too many log in fat_chain_add()
In-Reply-To: <68811964.050a0220.248954.0006.GAE@google.com>
References: <68811964.050a0220.248954.0006.GAE@google.com>
Date: Thu, 24 Jul 2025 16:42:10 +0900
Message-ID: <87qzy611d9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


This log was too many for serial console. So this patch uses ratelimit
version instead.

Reported-by: syzbot+fa7ef54f66c189c04b73@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa7ef54f66c189c04b73
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/misc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index c7a2d27..950da09 100644
--- a/fs/fat/misc.c	2025-07-24 16:14:10.499172171 +0900
+++ b/fs/fat/misc.c	2025-07-24 16:16:10.252088550 +0900
@@ -158,9 +158,9 @@ int fat_chain_add(struct inode *inode, i
 			mark_inode_dirty(inode);
 	}
 	if (new_fclus != (inode->i_blocks >> (sbi->cluster_bits - 9))) {
-		fat_fs_error(sb, "clusters badly computed (%d != %llu)",
-			     new_fclus,
-			     (llu)(inode->i_blocks >> (sbi->cluster_bits - 9)));
+		fat_fs_error_ratelimit(
+			sb, "clusters badly computed (%d != %llu)", new_fclus,
+			(llu)(inode->i_blocks >> (sbi->cluster_bits - 9)));
 		fat_cache_inval_inode(inode);
 	}
 	inode->i_blocks += nr_cluster << (sbi->cluster_bits - 9);
_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

