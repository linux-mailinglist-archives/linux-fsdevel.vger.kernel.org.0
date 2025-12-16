Return-Path: <linux-fsdevel+bounces-71470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EACFCC2C3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 13:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97FD530406BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFE3563F3;
	Tue, 16 Dec 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yt044RUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA333563EF;
	Tue, 16 Dec 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886546; cv=none; b=Jj/H6NF5H82O4vQr16CKFwx1rXaqr/kgiDHAIi0rn0ReTtVXSsggJYMrpwUIvj7JwzF293hUu4pJ84J+D6aPGZZaJa4XkIPi/XLC92zRxWrpQijHkGlPPZFN0U9dn5MTfnyqlQA1o0PY482hmF/ookyoUrjsrDq9VPg3WH51oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886546; c=relaxed/simple;
	bh=YY41xyySWZ4cCWie3TjwOEGGBsdhXtJHUaYMj8hl8NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDJBaP75pgUXF9xWFmI7rxLEB2C3LKQF9K0l7Aj/PzawVAKX3W1IMlnVtR/n2cZuO2E1GMiURDCoTrYuv2tJ9l3OigMllpH/YG66Es/w58lSEgz+VZrXTgPO9Ed2nP4hO12q96267qOWzbdxpr6bW3z+LIlXbhlJG2AApEOwnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yt044RUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E78C19422;
	Tue, 16 Dec 2025 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886545;
	bh=YY41xyySWZ4cCWie3TjwOEGGBsdhXtJHUaYMj8hl8NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yt044RUWmAt+ig/+7wdfee92qPq6x/3ESXe7WXbXBaJd3cGasrJZAj0N/HB1Qc3Rp
	 Yj9QT3URPkvoT64iT+8vTwLy5uzn6MkGU3oAFchaG2wy4oGk9VDu94SagExV8wz/Cv
	 IEIYUkKEuszBL4kg4+ydo7E/WPBW3L1P96jnf8jI=
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
Subject: [PATCH 6.17 469/507] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1
Date: Tue, 16 Dec 2025 12:15:10 +0100
Message-ID: <20251216111402.436037772@linuxfoundation.org>
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

[ Upstream commit 9d85ac939d52e93d80efb01a299c6f0bedb30487 ]

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

This can be reproduced by mounting with "cache=none,sign,vers=1.0" and
doing a read of a file that's significantly bigger than the size of the
file (e.g. attempting to read 64KiB from a 16KiB file).

Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d20766f664c49..4368771aad167 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1364,7 +1364,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans == ictx->remote_i_size) {
+		    rdata->subreq.start + trans >= ictx->remote_i_size) {
 			rdata->result = 0;
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		} else if (rdata->got_bytes > 0) {
-- 
2.51.0




