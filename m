Return-Path: <linux-fsdevel+bounces-54282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453EAFD34E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113271719AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45C12E5B38;
	Tue,  8 Jul 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OxbG2lOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7D8F5E;
	Tue,  8 Jul 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993544; cv=none; b=p54pmB4IJQ34lLvmdF0hPejmx+dIwP04Lt0CSeBJ9jFaiWC2OeU+phVfERjJ6KoklL9q+M4YDFtXu9WvEpyy0RHnHoQ+4wDnBHc+Aw0eJNan2rq01NKrL9Jen7a2UtzQ3Rvz/4VnQGw8RjOuNnqwCFbbzA1Z6+BhiRWopnZuNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993544; c=relaxed/simple;
	bh=CdQn3rLS/2BH1r264x+HlF7H+yzkqyetW7VG+0adQSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Id7CRZ4wNqeIQh5xvP6YpcVLPLMIfGtgQYxX+/XyLWnGODRzZPVobNm7HKf9Pbv0vj8oEpPMtpG5dwrdVYJlcUj7QKaaDAQRSRCnbzUlCC2qC2UKbtXMJthki+3r4Rv+CFByHv5ZIXW1DH3xkDCzgG8s3dVxz2bkWQhrjaph4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OxbG2lOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E0EC4CEED;
	Tue,  8 Jul 2025 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993544;
	bh=CdQn3rLS/2BH1r264x+HlF7H+yzkqyetW7VG+0adQSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxbG2lOb/31cMYv7vUfXiHR3pIVeT8+2uXA0D1avm8jYIF0tQPutHoWOITW7vZid4
	 co+v/4ZZsqTOA/Zs57sVPPSGLyhgVQQ67K12NacUJDNMr4O9aTON8MawD3s3F8BTc2
	 72TfLmlwvjEjbJwS+SxZL/oxbIPUKhrC+Qyp1qsU=
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
Subject: [PATCH 6.15 103/178] netfs: Fix i_size updating
Date: Tue,  8 Jul 2025 18:22:20 +0200
Message-ID: <20250708162239.336132436@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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
index dbb544e183d13..9f22ff890a8cd 100644
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
index fa9a5bf3c6d51..3efa5894b2c07 100644
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




