Return-Path: <linux-fsdevel+bounces-31334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E255D994BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ABB1C24EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644C1DE898;
	Tue,  8 Oct 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4Gvm20H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA79183CB8;
	Tue,  8 Oct 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391594; cv=none; b=kLzwjh6LNen2iqFkGpf7VzHA9GcL/WW65Zuvkj9zI/cjRb6A1TAW7IcdjWjn7m3bURWaTjCGTFEIOi6gMMdaDxn+4vPsq++fLKdbonUkf+SEWO9lz9NDaEQEg45f0AZ870nbRQ/UVYpNLLYO5oDasWykLHeDXiLgsDMEovZCVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391594; c=relaxed/simple;
	bh=7BkutiVyB04IBNjI6GLaVpa4RxD2t0aFOJ/N6jkWcYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlcsifrRbTWYNPhA5CNuScnQ0jQ832gp/Nt6L2HoxoYl1PM3cN8woyfyZiIuHHAHkspUCUSvw/1Isslxl/a1JGQpHAlHS+Tz3hogeisRVzD4lkf7npX2SrCvY/XEZpxx4mzYsfNA4bWDVH0NHH+D0LdUsV11zKUf5aaAANRrFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4Gvm20H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F03C4CEC7;
	Tue,  8 Oct 2024 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391594;
	bh=7BkutiVyB04IBNjI6GLaVpa4RxD2t0aFOJ/N6jkWcYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4Gvm20HPNWYKUzo2gBhUNUxnkYCLI8SEw0DDRJ/sDWdIo8aQTMPUHSaomoz7PBNk
	 gxPLIogk+sK3hQaQ9HkQAMrUpiCjRQRX7iLz/McEMRjdsSGxCbULtydCeeBTJnZmkb
	 NhaSH258yMk7jew5LP7Lkv/ajPP6CrqDJwkOny6M=
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
Subject: [PATCH 6.11 163/558] netfs: Cancel dirty folios that have no storage destination
Date: Tue,  8 Oct 2024 14:03:13 +0200
Message-ID: <20241008115708.772965997@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9486e54b1e563..b08673d97470c 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -410,13 +410,17 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
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
index 606b4a0f92dae..edcc3b3a3ecf8 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -141,6 +141,7 @@
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	/* The rest are for writeback */			\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
+	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-- 
2.43.0




