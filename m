Return-Path: <linux-fsdevel+bounces-24629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35235941EBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F37284A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8D189905;
	Tue, 30 Jul 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqV86MCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37621A76A5;
	Tue, 30 Jul 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360751; cv=none; b=HxeuOrgUKaR2o0MuM7Mp2cf6RvQ6lbe8RI+mtC/hOLu3Y4nr8ujRtt6zusb7/4YM5zYfXygwCTcFa8wOagTmVw40XsTvncVn/2kBG1bHGp9ds4Nr1mexO1P/QgVBSLEQi03CCaqVs6zir8OgEf6cJoOl6Bmtlnp15fFXF+vquFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360751; c=relaxed/simple;
	bh=6HKrVpCh038ALVGKfmwKomASOXh2xU4n+pSFA20jBoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8dXhhdPKinS4BI2HHz4uy8gqEhiVNTpQb3xTurU2V6epW1dBhmEv/zDiKwFZix57U4XvLq9fXIzUKpcI/IEhc2ZxnXcfEhKt6ixtvGtveoXQjHUIDcbTj9oIEAcyepTkGpAV/Yc8WW9U/a43OlYED0s9p2ELq6lSXfO9D5Y7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqV86MCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C54C32782;
	Tue, 30 Jul 2024 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360751;
	bh=6HKrVpCh038ALVGKfmwKomASOXh2xU4n+pSFA20jBoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqV86MCTJ+hB0ZomRFVF4M80A+tJVsiX05ChH9oMnpxr/TCJ6/0wErjGVEyA/hDyE
	 2qr7aIWiiP1NjKQZCV2Pp/of35Lq1dmNMQxHTlBvHhVeT+YonphJ7Foa7b58Ph3Ajb
	 uFylVhPgUqDiIY2Akzbhd/nNXxCKY65wnxJ/NXVY=
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
Subject: [PATCH 6.10 765/809] netfs: Fix writeback that needs to go to both server and cache
Date: Tue, 30 Jul 2024 17:50:41 +0200
Message-ID: <20240730151755.181800045@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

[ Upstream commit 212be98aa19303cbf376d61faf9de3ec9997c1cd ]

When netfslib is performing writeback (ie. ->writepages), it maintains two
parallel streams of writes, one to the server and one to the cache, but it
doesn't mark either stream of writes as active until it gets some data that
needs to be written to that stream.

This is done because some folios will only be written to the cache
(e.g. copying to the cache on read is done by marking the folios and
letting writeback do the actual work) and sometimes we'll only be writing
to the server (e.g. if there's no cache).

Now, since we don't actually dispatch uploads and cache writes in parallel,
but rather flip between the streams, depending on which has the lowest
so-far-issued offset, and don't wait for the subreqs to finish before
flipping, we can end up in a situation where, say, we issue a write to the
server and this completes before we start the write to the cache.

But because we only activate a stream when we first add a subreq to it, the
result collection code may run before we manage to activate the stream -
resulting in the folio being cleaned and having the writeback-in-progress
mark removed.  At this point, the folio no longer belongs to us.

This is only really a problem for folios that need to be written to both
streams - and in that case, the upload to the server is started first,
followed by the write to the cache - and the cache write may see a bad
folio.

Fix this by activating the cache stream up front if there's a cache
available.  If there's a cache, then all data is going to be written to it.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1599053.1721398818@warthog.procyon.org.uk
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_issue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index d7c971df88660..32bc88bee5d18 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -122,6 +122,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	wreq->io_streams[1].transferred		= LONG_MAX;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
+		wreq->io_streams[1].active	= true;
 		wreq->io_streams[1].prepare_write = wreq->cache_resources.ops->prepare_write_subreq;
 		wreq->io_streams[1].issue_write = wreq->cache_resources.ops->issue_write;
 	}
-- 
2.43.0




