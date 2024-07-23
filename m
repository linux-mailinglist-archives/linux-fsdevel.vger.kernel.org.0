Return-Path: <linux-fsdevel+bounces-24126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774EF93A04A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2272E1F22AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837E15217F;
	Tue, 23 Jul 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iEUrWquD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0B1514D8;
	Tue, 23 Jul 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735545; cv=none; b=Q2Z4QottBeEJv85NVEv7IWmtU4fgQK1kOlCyKH+W9kqcbX/tiABnAnE3z2HgYeX1jTtogkAosKIgWTiBXsuQpJECD7MlrAI3lY9r8dnq6rCjBmrRELe9J3Q4k+6+HuG4xTGYYPxbNoEqCRViZm2kWPt9r+Ki6B7V7B/fSzF55mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735545; c=relaxed/simple;
	bh=rpzxlJEBBCiEECX+RvinXqIQLDMmKhy9XI04FJp2CUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi7sfVJzfgvWGgRagZqYhmBfXpKqpZlhs4fN2v71ff3e3NnoKNeQiipgGb7EMkLOCOO52aBpaVzBERZ/xd+WYIYF3frEe0zfL5beRfAxJMzKnLfQyFZ7BrdqAOMiFud+nfZR4WqYZmjaWa3srYBQNYLWq5yX68Jt57mm8H+S+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iEUrWquD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1064FC4AF0A;
	Tue, 23 Jul 2024 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721735544;
	bh=rpzxlJEBBCiEECX+RvinXqIQLDMmKhy9XI04FJp2CUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEUrWquDt7OsVmpLr+32/Es+vOZGAWeeyVHhU4MnWFm0dWaoW2GIBH7tY3kEdy0hn
	 0WM/vpdGE9TD7ylejz0dKAwWYD3U44Pz3mXDu60wxR+XFKO4/ulIzIEAl4VP+la4B6
	 B3pmDLxN2Ox43Ye/22moS2kFPmoqaMv0i+m80Etg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Aurelien Aptel <aaptel@suse.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 5/9] cifs: Fix server re-repick on subrequest retry
Date: Tue, 23 Jul 2024 13:51:59 +0200
Message-ID: <20240723114047.475343175@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723114047.281580960@linuxfoundation.org>
References: <20240723114047.281580960@linuxfoundation.org>
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

commit de40579b903883274fe203865f29d66b168b7236 upstream.

When a subrequest is marked for needing retry, netfs will call
cifs_prepare_write() which will make cifs repick the server for the op
before renegotiating credits; it then calls cifs_issue_write() which
invokes smb2_async_writev() - which re-repicks the server.

If a different server is then selected, this causes the increment of
server->in_flight to happen against one record and the decrement to happen
against another, leading to misaccounting.

Fix this by just removing the repick code in smb2_async_writev().  As this
is only called from netfslib-driven code, cifs_prepare_write() should
always have been called first, and so server should never be NULL and the
preparatory step is repeated in the event that we do a retry.

The problem manifests as a warning looking something like:

 WARNING: CPU: 4 PID: 72896 at fs/smb/client/smb2ops.c:97 smb2_add_credits+0x3f0/0x9e0 [cifs]
 ...
 RIP: 0010:smb2_add_credits+0x3f0/0x9e0 [cifs]
 ...
  smb2_writev_callback+0x334/0x560 [cifs]
  cifs_demultiplex_thread+0x77a/0x11b0 [cifs]
  kthread+0x187/0x1d0
  ret_from_fork+0x34/0x60
  ret_from_fork_asm+0x1a/0x30

Which may be triggered by a number of different xfstests running against an
Azure server in multichannel mode.  generic/249 seems the most repeatable,
but generic/215, generic/249 and generic/308 may also show it.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Cc: stable@vger.kernel.org
Reported-by: Steve French <smfrench@gmail.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Aurelien Aptel <aaptel@suse.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2pdu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2ae2dbb6202b..bb84a89e5905 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4859,9 +4859,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
 
-	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
-		server = wdata->server = cifs_pick_channel(tcon->ses);
-
 	/*
 	 * in future we may get cifs_io_parms passed in from the caller,
 	 * but for now we construct it here...
-- 
2.45.2




