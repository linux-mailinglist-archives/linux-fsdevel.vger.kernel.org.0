Return-Path: <linux-fsdevel+bounces-39270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE99A12060
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77921188908C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC1D1E98F7;
	Wed, 15 Jan 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UXaL2Uoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D3248BA6;
	Wed, 15 Jan 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937863; cv=none; b=cVzLmRemL/O9vfodHBYPTai6lNI+UgHnwOK3QUcDdk/zOLkbewcPNiLtiPyRP9ftlKjgaP7UhaNWCmJfJsf4D17/Kr5O0E2Mgr1aMjR0RA2I7w0i+AfPMNz8piV23cAIZFeuHI9tGBx8JO85HvQCPDOh4u8CmQz4Gerf5GQUDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937863; c=relaxed/simple;
	bh=Kdxz0lyK8z7zX6L+U+/sPw/y8Tp+1OjDoriWgrtvo5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt4jzhpOiFjw3SD2ANDDpQ7TTBZ0bJ2MgXbV6NUkjdDyqnRBQWH3fy7nmle3Rh0FXwoJMH8AQDGcuND+rsCSXcA7VH1mQiEZnm3mXiuAhPbGWIJJi/F9m+1urgMU7Btz0pPBZPDE+zsVPZh+wiLL7c3SfJeA/mZSAX1WnO/MvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UXaL2Uoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D96C4CEE1;
	Wed, 15 Jan 2025 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937863;
	bh=Kdxz0lyK8z7zX6L+U+/sPw/y8Tp+1OjDoriWgrtvo5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXaL2UoavBmn/x5S41BULnKnAn6ZjiQGJgAROkAG/Y7gEmrdNPMWYWpxzTBNGhiyr
	 HSJMIk43KvEBPBONzbZHLlgeiX++roR+XlVTQL+w94rtm8N3O3KEpXGOCAj4oqZwWS
	 UnCKyiAuZEkAnyl95nFoQb1w0k9CJJ0/OKml9HKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 014/189] netfs: Fix is-caching check in read-retry
Date: Wed, 15 Jan 2025 11:35:10 +0100
Message-ID: <20250115103606.930204147@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

[ Upstream commit d4e338de17cb6532bf805fae00db8b41e914009b ]

netfs: Fix is-caching check in read-retry

The read-retry code checks the NETFS_RREQ_COPY_TO_CACHE flag to determine
if there might be failed reads from the cache that need turning into reads
from the server, with the intention of skipping the complicated part if it
can.  The code that set the flag, however, got lost during the read-side
rewrite.

Fix the check to see if the cache_resources are valid instead.  The flag
can then be removed.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/3752048.1734381285@warthog.procyon.org.uk
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_retry.c | 2 +-
 include/linux/netfs.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0350592ea804..2701f7d45999 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -49,7 +49,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	 * up to the first permanently failed one.
 	 */
 	if (!rreq->netfs_ops->prepare_read &&
-	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
+	    !rreq->cache_resources.ops) {
 		struct netfs_io_subrequest *subreq;
 
 		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5eaceef41e6c..474481ee8b7c 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -269,7 +269,6 @@ struct netfs_io_request {
 	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
-#define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
-- 
2.39.5




