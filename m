Return-Path: <linux-fsdevel+bounces-73943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6BD25FAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0C530A92BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB213BF2E4;
	Thu, 15 Jan 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ThwEvD+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467F394487;
	Thu, 15 Jan 2026 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496187; cv=none; b=IRL172uKCuipDx9yHCsuiH2By5FUyeFdRCyKNgN8y7ZWP2zcfrwsPPrcuGT34D/WB1W8EnYpy52Pq2eINCq/IH+vjlGw0CyNTEFEMMxQabTzJpU/DOBXuD5s/eTthwozUOcHNvwWLtv+qHYRby6347sVQU3F0zC66/ruOKt6myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496187; c=relaxed/simple;
	bh=LWNuQ48QC0Di+/AXHivZoyHcMZdYkIpnFgcaIBbdUuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxjrNL3MLrc/A7MP0YrtOEZNBDyTxUjJ+c1CDaipFoIwcdG+LIBmZNClhOFVur6bPfGHBgBF/Z/YHeN3h2kSn+pwFez34oMbp3LEsEqStKVgOuiAngBWifjg8EaSGBE0wjQ7xbDkZ7Th+u+b2YrV8jeQXdCy2UdQtoNwnLg2I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ThwEvD+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A742C116D0;
	Thu, 15 Jan 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768496187;
	bh=LWNuQ48QC0Di+/AXHivZoyHcMZdYkIpnFgcaIBbdUuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThwEvD+1SCijQdsCbKReOJ6RWF+v5VbG1DsOcUtbKR7lu+SDqHvypfxJruo8c2hjf
	 OxleZL3ky3JnSYksxJclc+4xJxwUH1oqshlZoUB/QtMq3o9ULtE2GupDeaIeFACe0S
	 fM855qw/um1dha3/sJ5kfxygJghgmko+GqUDLNlo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Howells <dhowells@redhat.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	v9fs@lists.linux.dev,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 076/181] netfs: Fix early read unlock of page with EOF in middle
Date: Thu, 15 Jan 2026 17:46:53 +0100
Message-ID: <20260115164205.066104007@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
References: <20260115164202.305475649@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 570ad253a3455a520f03c2136af8714bc780186d ]

The read result collection for buffered reads seems to run ahead of the
completion of subrequests under some circumstances, as can be seen in the
following log snippet:

    9p_client_res: client 18446612686390831168 response P9_TREAD tag  0 err 0
    ...
    netfs_sreq: R=00001b55[1] DOWN TERM  f=192 s=0 5fb2/5fb2 s=5 e=0
    ...
    netfs_collect_folio: R=00001b55 ix=00004 r=4000-5000 t=4000/5fb2
    netfs_folio: i=157f3 ix=00004-00004 read-done
    netfs_folio: i=157f3 ix=00004-00004 read-unlock
    netfs_collect_folio: R=00001b55 ix=00005 r=5000-5fb2 t=5000/5fb2
    netfs_folio: i=157f3 ix=00005-00005 read-done
    netfs_folio: i=157f3 ix=00005-00005 read-unlock
    ...
    netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
    netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=c
    netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
    netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=8
    ...
    netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 s=5fb2 0/4e s=0 e=0
    netfs_sreq: R=00001b55[2] ZERO TERM  f=102 s=5fb2 4e/4e s=5 e=0

The 'cto=5fb2' indicates the collected file pos we've collected results to
so far - but we still have 0x4e more bytes to go - so we shouldn't have
collected folio ix=00005 yet.  The 'ZERO' subreq that clears the tail
happens after we unlock the folio, allowing the application to see the
uncleared tail through mmap.

The problem is that netfs_read_unlock_folios() will unlock a folio in which
the amount of read results collected hits EOF position - but the ZERO
subreq lies beyond that and so happens after.

Fix this by changing the end check to always be the end of the folio and
never the end of the file.

In the future, I should look at clearing to the end of the folio here rather
than adding a ZERO subreq to do this.  On the other hand, the ZERO subreq can
run in parallel with an async READ subreq.  Further, the ZERO subreq may still
be necessary to, say, handle extents in a ceph file that don't have any
backing store and are thus implicitly all zeros.

This can be reproduced by creating a file, the size of which doesn't align
to a page boundary, e.g. 24998 (0x5fb2) bytes and then doing something
like:

    xfs_io -c "mmap -r 0 0x6000" -c "madvise -d 0 0x6000" \
           -c "mread -v 0 0x6000" /xfstest.test/x

The last 0x4e bytes should all be 00, but if the tail hasn't been cleared
yet, you may see rubbish there.  This can be reproduced with kafs by
modifying the kernel to disable the call to netfs_read_subreq_progress()
and to stop afs_issue_read() from doing the async call for NETFS_READAHEAD.
Reproduction can be made easier by inserting an mdelay(100) in
netfs_issue_read() for the ZERO-subreq case.

AFS and CIFS are normally unlikely to show this as they dispatch READ ops
asynchronously, which allows the ZERO-subreq to finish first.  9P's READ op is
completely synchronous, so the ZERO-subreq will always happen after.  It isn't
seen all the time, though, because the collection may be done in a worker
thread.

Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Link: https://lore.kernel.org/r/8622834.T7Z3S40VBb@weasel/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/938162.1766233900@warthog.procyon.org.uk
Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a95e7aadafd07..7a0ffa675fb17 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -137,7 +137,7 @@ static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
 		rreq->front_folio_order = order;
 		fsize = PAGE_SIZE << order;
 		fpos = folio_pos(folio);
-		fend = umin(fpos + fsize, rreq->i_size);
+		fend = fpos + fsize;
 
 		trace_netfs_collect_folio(rreq, folio, fend, collected_to);
 
-- 
2.51.0




