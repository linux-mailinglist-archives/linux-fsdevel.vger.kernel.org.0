Return-Path: <linux-fsdevel+bounces-54277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C3AFD208
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB44854333A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14892E2F0D;
	Tue,  8 Jul 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="os05mZPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319E23A98D;
	Tue,  8 Jul 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992799; cv=none; b=DeFLysoNBgDuQyeNBTl7GxUK3TIbL1pC5hux3HbXM57oZjvZgTzrtKE1KEim29pSozeX/Nmyhym/5ILu6zuybBiFyyA13Am16EoL7CwyOlYame6RMH2t2Ub+u9ngCnBqKWdRc4Da02NGZ/hCNpsv0hzOhRVFRnxT/YlTtpe7nqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992799; c=relaxed/simple;
	bh=f6K/Daqx6q/WwY4okpNJSRysLXFPQ7n+5l/14UgM1QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGnzMF0isfaXlt/aOmTChGoMZtxsaZEJW2gfAouEVv7gKvNcyRvUk9CHNYsym8WVD1Z1F0/7P+LNgF8/wATQ0vfZCxov2bd492uC8KEeMVaUqhlsk0QxVzBU0CVEO8RwE/ackyeMaNtc0jBFRJUYjqxUlMPFOq7nFJ/Y5FQcTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=os05mZPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E3AC4CEF6;
	Tue,  8 Jul 2025 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992798;
	bh=f6K/Daqx6q/WwY4okpNJSRysLXFPQ7n+5l/14UgM1QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=os05mZPCG3V11eOQ0KuE48uyhBxDN80xcPDAb0/kWb7AiEcutT0R0U2n9o9pJuk/I
	 vha+3Cs8SmbMvIAyDBRG16xbOHUOECZs6RTylHteZYmROLzp/QXz1JpDkzb5gUvGOI
	 rP4kY/X0x8alP6hx4QPrSTU5+LI3nwUfke0+61XI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 084/232] netfs: Fix i_size updating
Date: Tue,  8 Jul 2025 18:21:20 +0200
Message-ID: <20250708162243.647578407@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2e0658940d90a3dc130bb3b7f75bae9f4100e01f ]

Fix the updating of i_size, particularly in regard to the completion of DIO
writes and especially async DIO writes by using a lock.

The bug is triggered occasionally by the generic/207 xfstest as it chucks a
bunch of AIO DIO writes at the filesystem and then checks that fstat()
returns a reasonable st_size as each completes.

The problem is that netfs is trying to do "if new_size > inode->i_size,
update inode->i_size" sort of thing but without a lock around it.

This can be seen with cifs, but shouldn't be seen with kafs because kafs
serialises modification ops on the client whereas cifs sends the requests
to the server as they're generated and lets the server order them.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250701163852.2171681-11-dhowells@redhat.com
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c | 2 ++
 fs/netfs/direct_write.c   | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b3910dfcb56d3..896d1d4219ed9 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -64,6 +64,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 		return;
 	}
 
+	spin_lock(&inode->i_lock);
 	i_size_write(inode, pos);
 #if IS_ENABLED(CONFIG_FSCACHE)
 	fscache_update_cookie(ctx->cache, NULL, &pos);
@@ -77,6 +78,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 					DIV_ROUND_UP(pos, SECTOR_SIZE),
 					inode->i_blocks + add);
 	}
+	spin_unlock(&inode->i_lock);
 }
 
 /**
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 26cf9c94deebb..8fbfaf71c154c 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -14,13 +14,17 @@ static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
 	struct inode *inode = wreq->inode;
 	unsigned long long end = wreq->start + wreq->transferred;
 
-	if (!wreq->error &&
-	    i_size_read(inode) < end) {
+	if (wreq->error || end <= i_size_read(inode))
+		return;
+
+	spin_lock(&inode->i_lock);
+	if (end > i_size_read(inode)) {
 		if (wreq->netfs_ops->update_i_size)
 			wreq->netfs_ops->update_i_size(inode, end);
 		else
 			i_size_write(inode, end);
 	}
+	spin_unlock(&inode->i_lock);
 }
 
 /*
-- 
2.39.5




