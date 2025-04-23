Return-Path: <linux-fsdevel+bounces-47025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7FA97DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DFA17E695
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D7265CCC;
	Wed, 23 Apr 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHy0X3rB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6395265CBA;
	Wed, 23 Apr 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382336; cv=none; b=Ys8Gl987lPjYcKZ0K5wyLlPqDXPArNPlrEnM+h84jqxoDM3oE3So3or0/7ele9KM7Xv6sS2oMg+JVhv3D6etpEztMOrN7HX80/dp5V/6cvPgKz9fXXgHAQm9U5Zf5RAcLgtVO9rLGUdPZbcFG5QVbXpdqoGSg2lSh7qWr8rdN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382336; c=relaxed/simple;
	bh=T4dxTjHbMdrsjf8LVgCA3UA6psQzEm5gWO89zxcso54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv3aMbCDEpvOUyVZcWwFFOqGUal7uVoseD+AG6rbA0zJ/F58ulUjklZ1jyZ/jCk/nDieKoH7iO8W2JKOPGfNpeWVTgnSiYfFHXXr/ueeqwiLEeUTDr6mPbyWvU+vx1Nacd7Mz0Q16WHszIFjPs+ivfXs1z6TIydNBxqI0ltFTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHy0X3rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC778C4CEEE;
	Wed, 23 Apr 2025 04:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745382336;
	bh=T4dxTjHbMdrsjf8LVgCA3UA6psQzEm5gWO89zxcso54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHy0X3rB14dBHfS9hOR9bMglpxYPbnWqN4ahZb8CAG8IK4YlU67llR1bDw/Se8itr
	 CS6ch5k0FcsOjDGEEKerdlA9YQkFiIEhKZJB/JnUqz1fDgxtn7y6/ldXBb+Dm/y9Ai
	 KSxOeu57d+G378bJwoXsBx9/AEHazIBtroHQnBnDQrNbjAlDF+ud4He/3gQluJa6yM
	 /i86sSPnqctzLWUrNxwf6JkYvQPEbvAiyni3EwAOb66VvQhcprOhYcT9BtcpiDHYSQ
	 lK+X4kmz36xRRyghP8cOLxhAu5/iQAr6qF5Y/Ou8HMA5NoShlvBAiCfa1at2iBSSft
	 SMHJeuLUpj87g==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/3] NFS: Enable the RWF_DONTCACHE flag for the NFS client
Date: Wed, 23 Apr 2025 00:25:32 -0400
Message-ID: <ec165b304a7b56d1fa4c6c2b1ad1c04d4dcbd3f6.1745381692.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745381692.git.trond.myklebust@hammerspace.com>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

While the NFS readahead code has no problems using the generic code to
manage the dropbehind behaviour enabled by RWF_DONTCACHE, the write code
needs to deal with the fact that NFS writeback uses a 2 step process
(UNSTABLE write followed by COMMIT).
This commit replaces the use of the folio dropbehind flag with a local
NFS request flag that triggers the dropbehind behaviour once the data
has been written to stable storage.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c            |  2 ++
 fs/nfs/nfs4file.c        |  2 ++
 fs/nfs/write.c           | 12 +++++++++++-
 include/linux/nfs_page.h |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 033feeab8c34..60d47f141acb 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -910,5 +910,7 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+
+	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c28..e6726499c585 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -467,4 +467,6 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+
+	.fop_flags	= FOP_DONTCACHE,
 };
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 23df8b214474..e0ac439ab211 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -359,8 +359,12 @@ static void nfs_folio_end_writeback(struct folio *folio)
 static void nfs_page_end_writeback(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_WB_END)) {
+		struct folio *folio = nfs_page_to_folio(req);
+
+		if (folio_test_clear_dropbehind(folio))
+			set_bit(PG_DROPBEHIND, &req->wb_flags);
 		nfs_unlock_request(req);
-		nfs_folio_end_writeback(nfs_page_to_folio(req));
+		nfs_folio_end_writeback(folio);
 	} else
 		nfs_unlock_request(req);
 }
@@ -813,6 +817,9 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
+
+		if (test_bit(PG_DROPBEHIND, &req->wb_flags))
+			folio_end_dropbehind(folio);
 	}
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
@@ -2093,6 +2100,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 		.range_start = range_start,
 		.range_end = range_start + len - 1,
 	};
+	bool dropbehind = folio_test_clear_dropbehind(folio);
 	int ret;
 
 	trace_nfs_writeback_folio(inode, range_start, len);
@@ -2113,6 +2121,8 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			goto out_error;
 	}
 out_error:
+	if (dropbehind)
+		folio_set_dropbehind(folio);
 	trace_nfs_writeback_folio_done(inode, range_start, len, ret);
 	return ret;
 }
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff4..1a017b5b476f 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -37,6 +37,7 @@ enum {
 	PG_REMOVE,		/* page group sync bit in write path */
 	PG_CONTENDED1,		/* Is someone waiting for a lock? */
 	PG_CONTENDED2,		/* Is someone waiting for a lock? */
+	PG_DROPBEHIND,		/* Implement RWF_DONTCACHE */
 };
 
 struct nfs_inode;
-- 
2.49.0


