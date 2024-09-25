Return-Path: <linux-fsdevel+bounces-30075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F19985D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D2288052
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9611D86F0;
	Wed, 25 Sep 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjAs29vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EB1D86D8;
	Wed, 25 Sep 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265686; cv=none; b=MkEjgAxDV86PHjXxMv4WcnGniTkXp7tJARmInG+mJKLgE14RBLij7gm33udgk0LGe75TVbTCHsP97tTTNAUfoeLxeao2KT4XVxNMKHb9gVWWP4PZ11uAMf1EItldKEITN6+cv4mpBmJejxIeVlM/BmAXhRM8t1RZkmNKTsO0G/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265686; c=relaxed/simple;
	bh=siFgHDU3+DIfq5cAByMJnmPETN9KVVCUrvCYwmjKU9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMO6yWsvmBzwtQk71NpQwS5fMSsDDvb+AHWxIGcvuoq/ls9yG9oD1TdbZ/kB0p2J8Ln53t7F5/euT7w9YFAHLMpejCvo6O/lu+sIaYc/Q/W9v7JkTjUSLdM9Azz/1ZH3MPKh8uCk+f8QzencyNG3+CHJWvB8p3QGqUERfJCbJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjAs29vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E49C4CEC7;
	Wed, 25 Sep 2024 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265686;
	bh=siFgHDU3+DIfq5cAByMJnmPETN9KVVCUrvCYwmjKU9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjAs29vZE6mNBj00nqpNSSlO6+whgvx0r+t6lRpCGZDthNJ0No9GPjIlOK/mwqWEm
	 LdQx4G7vS4Vs8YrjjbHnY/nxoEZzR9EHgyvRp2exj4Mt/34YmkEA9IPut8e9VfAvK4
	 b2vXDrIvC70MLkLhfLnn4m8v9XIHINOUqmpbC24ySzbxvm+hOq4n3g19p01g4BAAeE
	 xTo0vSD7sc/zRMLRdZsEI4BJOAnZ+RtU9+y4Q5G/atwLcIF8FhuVG9aUZUFMRhhrQl
	 HRn4IoDNJEHFKM+o5X8dA21aLgoSyZHcy6znHPEJgF53NAmt9iyT0I3HEKT5zzv/SY
	 /u7F+1St/2rSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 071/197] netfs: Cancel dirty folios that have no storage destination
Date: Wed, 25 Sep 2024 07:51:30 -0400
Message-ID: <20240925115823.1303019-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8f246b7c0a1be0882374f2ff831a61f0dbe77678 ]

Kafs wants to be able to cache the contents of directories (and symlinks),
but whilst these are downloaded from the server with the FS.FetchData RPC
op and similar, the same as for regular files, they can't be updated by
FS.StoreData, but rather have special operations (FS.MakeDir, etc.).

Now, rather than redownloading a directory's content after each change made
to that directory, kafs modifies the local blob.  This blob can be saved
out to the cache, and since it's using netfslib, kafs just marks the folios
dirty and lets ->writepages() on the directory take care of it, as for an
regular file.

This is fine as long as there's a cache as although the upload stream is
disabled, there's a cache stream to drive the procedure.  But if the cache
goes away in the meantime, suddenly there's no way do any writes and the
code gets confused, complains "R=%x: No submit" to dmesg and leaves the
dirty folio hanging.

Fix this by just cancelling the store of the folio if neither stream is
active.  (If there's no cache at the time of dirtying, we should just not
mark the folio dirty).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240814203850.2240469-23-dhowells@redhat.com/ # v2
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_issue.c       | 6 +++++-
 include/trace/events/netfs.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 32bc88bee5d18..3c7eb43a2ec69 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -408,13 +408,17 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		if (!fscache_resources_valid(&wreq->cache_resources)) {
+		if (!cache->avail) {
 			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
 			netfs_issue_write(wreq, upload);
 			netfs_folio_written_back(folio);
 			return 0;
 		}
 		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
+	} else if (!upload->avail && !cache->avail) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		netfs_folio_written_back(folio);
+		return 0;
 	} else if (!upload->construct) {
 		trace_netfs_folio(folio, netfs_folio_trace_store);
 	} else {
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 24ec3434d32ee..102696abe8c9e 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -140,6 +140,7 @@
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	/* The rest are for writeback */			\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
+	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-- 
2.43.0


