Return-Path: <linux-fsdevel+bounces-27642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C1963377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DC2281837
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD51AE04D;
	Wed, 28 Aug 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCbH2FjZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A731AD3FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879011; cv=none; b=aTYIf2EmhJMwGyIM1b58gYsQP2KNuHzd9a8AI3RCLY5zG8T7DDT09Vtcn/vkc6+pBZCoTCTiGRQ2bX+j6DvQljFHa6cbWrf28F9P1qEg8gAV99xS7qElGgTAc/MaQpANYfTMRD/aSd3lM30jNgdxDiVG77ytWbWiHR00CbkegOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879011; c=relaxed/simple;
	bh=vV14LkLlJc5C8XMmAWqSUEreXBiRwT8flr5r5K1CT0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAaQSlczv0KFGrHCupXe21vwlsv8DNzpykftvA2xH8752CQSUeAKUd0gRVfK0PYH9cNm0qt19HRYmPVO2REJlQirkeZULOzLjYnShXkYC07sVPyO2TOvK0U9Qf8yWDWtBAfcUb4hG/IqoYPKm/K11Epel5lBR1wKaWB+RUzpfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCbH2FjZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29rNMGcbzhhOXDnkGZZqENHeVIOwTy/JkQWfMjJEQZk=;
	b=PCbH2FjZOna6MV7D7B3LoaRqc7//Zan18XONNCPXqk6w5agxjYH2MHW74OV3yZwYQo5udS
	RGE8yCpUp16iAPIfSJGkT51s1jUhCcCCMRpbQnD1z4q3qJuVuE4L/T5AO8oBqGZJdwuddY
	73P1cqPcsCgpN73MtWB7q5E6kZn1xVk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Gp7aQV_ZPh6R-b_4tg_Akg-1; Wed,
 28 Aug 2024 17:03:24 -0400
X-MC-Unique: Gp7aQV_ZPh6R-b_4tg_Akg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30BFC19560B7;
	Wed, 28 Aug 2024 21:03:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B57471955F1B;
	Wed, 28 Aug 2024 21:03:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH 3/6] cifs: Fix copy offload to flush destination region
Date: Wed, 28 Aug 2024 22:02:44 +0100
Message-ID: <20240828210249.1078637-4-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
---
 fs/smb/client/cifsfs.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d89485235425..2a2523c93944 100644
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


