Return-Path: <linux-fsdevel+bounces-71474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B415CC2F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69E3B3042B29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6F36404D;
	Tue, 16 Dec 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1uIyKtRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C93362157;
	Tue, 16 Dec 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888560; cv=none; b=B06z3YVR5TV/RKW4LkvcozmfvHQFMsYSbaZSxzSEyoo0rSRMqjHYYOQyt1OZ+px/D+YFrXyvuT7WN3FQ4cAiE3dcT/Ljr0oihRhqJuE/A/xz+OKdRFd/h2FRNeMe4BTvBDpj1OuA/N4meH0XFUs9MSGDdJMb9kCPbkJq8LQFupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888560; c=relaxed/simple;
	bh=opeds8yRJNNYXJgiuaKmtvKgiy3PhOZCv9/bb+mn+wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQw0mL1OtD98aLAbEMlim4+eKokR0L27EuuIt4VSLTfeDmLzgN8FCZq4D422tjotFQB5oeI0LCdYT0S5hVPhdBrtAuIj+ICSGXVbFsQGum2CpCI6QIfnvb8Q0VKJPYWlPvS1YPRTIWBKvCdW0Lw/84dlUkfg2pYlgbGbLq8lPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1uIyKtRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FF5C4CEF5;
	Tue, 16 Dec 2025 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888559;
	bh=opeds8yRJNNYXJgiuaKmtvKgiy3PhOZCv9/bb+mn+wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1uIyKtRLM67d7siktqXo+1TwJwZMIcbyZDP92ncVl+E8kdkFVV/Pc6FZ61VipZhF3
	 AwFXXevWFxuTcpBKs1OM9xuGZ+WUYpCiE+iZAkZ0Si0xPMw8WjK0MfeWSElJ+EthKU
	 S/ZsaZL2LmSGRvoVFmAjz/BgzwqMFLscW2Ed6Uk8=
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
Subject: [PATCH 6.18 571/614] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB2
Date: Tue, 16 Dec 2025 12:15:38 +0100
Message-ID: <20251216111422.071547937@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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
index 8b4a4573e9c37..e661d40213eab 100644
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




