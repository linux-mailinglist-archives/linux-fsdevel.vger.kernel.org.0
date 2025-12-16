Return-Path: <linux-fsdevel+bounces-71472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC9CC2FE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 13:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAC86302B789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E193570DA;
	Tue, 16 Dec 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceSLbCIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1C3570C6;
	Tue, 16 Dec 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886550; cv=none; b=m3QM/gNYEeE5DGxJrP2AreYAf7pzoTMrQm6590bTh7rNjVEPXBdbU1W3C/8M2AOXJf8njZvHSZ8c62Ve4utlf4eFwmJhzXHJX/JgvQE7uZYXGldrX8iAd2aHNnfI7ideRHsyAbNGSw3lxSvPUqbAJEuGpsCFzgM/vHCKlGL7cHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886550; c=relaxed/simple;
	bh=36VYshdriOcE46Tx1LMjxHl3F0RddSQCDoLFep7w098=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHpZzLBN2rk7/xYA2Rqy76Zigidw7zm43tsl4bGh3l3P9uIvkpFJS1PmLkk2r59TBr+yoTOaxvnURQTaffBM4MuHEYhBkykOG5+p1w1NdU6oGvR3x/cDglX+JtaiPJ0wrqjNyor8yxwQ5WZOLNldCQNU5fHy4qA3rOpCTk8WFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceSLbCIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDD1C16AAE;
	Tue, 16 Dec 2025 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886549;
	bh=36VYshdriOcE46Tx1LMjxHl3F0RddSQCDoLFep7w098=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceSLbCIMgneJamJSPsjqhGuXoygbFjYn1rvIFVHW+TJh9++ZGXt2hySmpW3//W+Pi
	 XwaPjz4RCrPa0y040CHghPu31sMOdSjxSvT/kPLIIq3WqT0OEpHWSXMQ3oqNqq94D1
	 x2Su7AFCRfcJVUlw6yvf35+gySqwg82g1yDt3EG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 470/507] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB2
Date: Tue, 16 Dec 2025 12:15:11 +0100
Message-ID: <20251216111402.472265965@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 4ae4dde6f34a4124c65468ae4fa1f915fb40f900 ]

If a DIO read or an unbuffered read request extends beyond the EOF, the
server will return a short read and a status code indicating that EOF was
hit, which gets translated to -ENODATA.  Note that the client does not cap
the request at i_size, but asks for the amount requested in case there's a
race on the server with a third party.

Now, on the client side, the request will get split into multiple
subrequests if rsize is smaller than the full request size.  A subrequest
that starts before or at the EOF and returns short data up to the EOF will
be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
indicating to netfslib that we can't read more.

If a subrequest, however, starts after the EOF and not at it, HIT_EOF will
not be flagged, its error will be set to -ENODATA and it will be abandoned.
This will cause the request as a whole to fail with -ENODATA.

Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyond
the EOF marker.

Fixes: 1da29f2c39b6 ("netfs, cifs: Fix handling of short DIO read")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f925b2da76c1d..64fe2de662ff9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4629,7 +4629,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans == ictx->remote_i_size) {
+		    rdata->subreq.start + trans >= ictx->remote_i_size) {
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
 		}
-- 
2.51.0




