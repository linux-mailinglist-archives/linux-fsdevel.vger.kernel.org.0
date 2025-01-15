Return-Path: <linux-fsdevel+bounces-39266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B881A12055
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842527A0FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBAD248BA8;
	Wed, 15 Jan 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HgW7zuNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD9248BC5;
	Wed, 15 Jan 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937851; cv=none; b=WBnx3mFpyIVdVX0pjc/ngakgp5o1hqRRA4M5T/48225of32lpW42Cv1rfrKyxWZmLNiQZaaFnGHuE96tO4HrfKl1cSHOGxnciTV0HQLGMH4ehcBru+ig9SfF7bR6ul/WVRp8JnFn0Lw7/WBFE8O0v14LJ1QqJt+3V0bkYdM0aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937851; c=relaxed/simple;
	bh=1nOLWDSbTVwfmqkWr0V5bhex74kvRor7yesZUJp+KFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBAQXxKvIj5xaV3lfw6tRF8kWNd5ffUOjf+FqbnNneC++QEdvahXoWlzv7zSM6Y+8N/kCQMJxV9ZOqNuKnLwTdSyeMtlj1JZTYhFsI0jvy04S9hG0qddKjIgRbVpSMO0+QAzpfcDGHPJ154YMd41gLTh31yzUQIVpsARR81HQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HgW7zuNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0F0C4CEE3;
	Wed, 15 Jan 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937850;
	bh=1nOLWDSbTVwfmqkWr0V5bhex74kvRor7yesZUJp+KFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgW7zuNXHkSaW2olR/aOiwzmjfbBCJuXoHps/7sFGUHgP6c5da/+2exnM2uVwQlGH
	 BB6r1dtfZ9vE0dfC9D/jcOv3SyyNl7FQhWpRrIOJewOla4ASuW86UHFAqcfDHb8St9
	 9wFlqqzvmLLoHfqExiRxP2aAyaTEYNTUtB6iRrjo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Dave Wysochanski <dwysocha@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 010/189] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
Date: Wed, 15 Jan 2025 11:35:06 +0100
Message-ID: <20250115103606.772390097@linuxfoundation.org>
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

[ Upstream commit 86ad1a58f6a9453f49e06ef957a40a8dac00a13f ]

When netfslib wants to copy some data that has just been read on behalf of
nfs, it creates a new write request and calls nfs_netfs_init_request() to
initialise it, but with a NULL file pointer.  This causes
nfs_file_open_context() to oops - however, we don't actually need the nfs
context as we're only going to write to the cache.

Fix this by just returning if we aren't given a file pointer and emit a
warning if the request was for something other than copy-to-cache.

Further, fix nfs_netfs_free_request() so that it doesn't try to free the
context if the pointer is NULL.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241213135013.2964079-5-dhowells@redhat.com
cc: Trond Myklebust <trondmy@kernel.org>
cc: Anna Schumaker <anna@kernel.org>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/fscache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 810269ee0a50..d49e4ce27999 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *ractl)
 static atomic_t nfs_netfs_debug_id;
 static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	if (!file) {
+		if (WARN_ON_ONCE(rreq->origin != NETFS_PGPRIV2_COPY_TO_CACHE))
+			return -EIO;
+		return 0;
+	}
+
 	rreq->netfs_priv = get_nfs_open_context(nfs_file_open_context(file));
 	rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
@@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *fi
 
 static void nfs_netfs_free_request(struct netfs_io_request *rreq)
 {
-	put_nfs_open_context(rreq->netfs_priv);
+	if (rreq->netfs_priv)
+		put_nfs_open_context(rreq->netfs_priv);
 }
 
 static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sreq)
-- 
2.39.5




