Return-Path: <linux-fsdevel+bounces-29008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BEF972F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2602F1C24AF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6694718DF72;
	Tue, 10 Sep 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/eP7ODT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB2186E4B;
	Tue, 10 Sep 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961699; cv=none; b=e/ImgzAh8uSJLnO1hiyzxuAMBFWc6KEUMZWQ1kbnsyb92w1/vBjeQ2DsgIqVEbkcFhnBZyxU2jI4A8hRDjuX85arMWekQVFWzyh8JrQdhwTG/5Nj+ydycPMslBM4yFHIEDouxdNNGTO//g9ORIbHSMY4kq3NMouDsIoQT7ZeszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961699; c=relaxed/simple;
	bh=x1yF9dDZYyeFxRnZxrB0yveG54HcQ45BwuGjyhr4tkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSSeceX7aLpEOJEukaH0epd6sZjzT4iBZF2eNIHwoat+fKmzDBiouFYL/L/FfIZbA4Et2uc1FIsmvfdiRkXWyxMq+io1YUdUFR+4LNjHJ0NZvoYSo8Oxb59O9SVSmeqwbb6/IXfB3+IsPVDaxobo3KvGZZMwu0ijBIM1fPeFIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/eP7ODT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133BBC4CEC3;
	Tue, 10 Sep 2024 09:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961699;
	bh=x1yF9dDZYyeFxRnZxrB0yveG54HcQ45BwuGjyhr4tkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/eP7ODT7m4Fme3JSZ+nhEnMmlcPL3SsKjux0lBBNC9zCdBWXFglJW5IsxLWQYH6P
	 5OhF9v+EffpbQMzdPza+qHyzJbeYp1CZtsXzwpaCSf4dGwad3VpE+7IVmVmwSODaki
	 5hvQFvSJoA2Oe3ZSE3q0mdh3M8eK8pVFd4S6hWKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 158/375] cifs: Fix copy offload to flush destination region
Date: Tue, 10 Sep 2024 11:29:15 +0200
Message-ID: <20240910092627.781118875@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8101d6e112e2524e967368f920c404ae445a9757 ]

Fix cifs_file_copychunk_range() to flush the destination region before
invalidating it to avoid potential loss of data should the copy fail, in
whole or in part, in some way.

Fixes: 7b2404a886f8 ("cifs: Fix flushing, invalidation and file size with copy_file_range()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2c4b357d85e2..a1acf5bd1e3a 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1341,7 +1341,6 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
 	struct cifs_tcon *target_tcon;
-	unsigned long long destend, fstart, fend;
 	ssize_t rc;
 
 	cifs_dbg(FYI, "copychunk range\n");
@@ -1391,25 +1390,13 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 			goto unlock;
 	}
 
-	destend = destoff + len - 1;
-
-	/* Flush the folios at either end of the destination range to prevent
-	 * accidental loss of dirty data outside of the range.
+	/* Flush and invalidate all the folios in the destination region.  If
+	 * the copy was successful, then some of the flush is extra overhead,
+	 * but we need to allow for the copy failing in some way (eg. ENOSPC).
 	 */
-	fstart = destoff;
-	fend = destend;
-
-	rc = cifs_flush_folio(target_inode, destoff, &fstart, &fend, true);
+	rc = filemap_invalidate_inode(target_inode, true, destoff, destoff + len - 1);
 	if (rc)
 		goto unlock;
-	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
-	if (rc)
-		goto unlock;
-	if (fend > target_cifsi->netfs.zero_point)
-		target_cifsi->netfs.zero_point = fend + 1;
-
-	/* Discard all the folios that overlap the destination region. */
-	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
 
 	fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
 			   i_size_read(target_inode), 0);
-- 
2.43.0




