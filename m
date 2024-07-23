Return-Path: <linux-fsdevel+bounces-24127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26A93A04C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A2B1C220ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8815219B;
	Tue, 23 Jul 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XpJ7twKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1915098E;
	Tue, 23 Jul 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735548; cv=none; b=gI2v8UGquXPnaoSFy5unfyp1r7Yo68Te8iGNCNGSVTYlW/VMepaX/G9rNtitHu1VLZH/Z3MNOB52ziv+ireP8pIRuiI42+uDa3W1r+yCQOfuRE0csx8++5Gd+6BqtrMcBIAKk+W/MXwDHtL8B7GJ/h9P9CSK6izOzPraQ95Udbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735548; c=relaxed/simple;
	bh=ZggV/pIb7W5ya1ZlMMtMwfFVM9xCnefWJ/6DE6ScF8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtUdVTTg5MWmO1X3YvlPDNkJvoldVWBTvVNQuZGdbTZMBOVbyTFtJ8JGVLjB8lVVhWGzPSFHDX2tSnOCzJ28HPD6oyns5bFc4QE0pIHk8mNxWAOp6klZd8xT6lj1qIrOqk5GGA5KAn+3mZ8H8xGAdmUS8TSD+hGqjS7F18NB0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XpJ7twKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361F0C4AF09;
	Tue, 23 Jul 2024 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721735547;
	bh=ZggV/pIb7W5ya1ZlMMtMwfFVM9xCnefWJ/6DE6ScF8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpJ7twKFlTPy0BZ81mBrWN9rcMl6C8BXPy6aoz8xmv6++XMgSO8ZyhquGo22jG0d7
	 0Ruhbd7B+AvP4ikRT4oZfezw25/o7DdNxhX2lKQFOHcVCAIu3ZKectGdQYGANnckXt
	 jTqTyzdnMu3Yr/6aHBsUcwVBudpm51c1sIFSrYsk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <sfrench@samba.org>,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 6/9] cifs: Fix setting of zero_point after DIO write
Date: Tue, 23 Jul 2024 13:52:00 +0200
Message-ID: <20240723114047.508715979@linuxfoundation.org>
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

commit 61ea6b3a3104fcd66364282391dd2152bc4c129a upstream.

At the moment, at the end of a DIO write, cifs calls netfs_resize_file() to
adjust the size of the file if it needs it.  This will reduce the
zero_point (the point above which we assume a read will just return zeros)
if it's more than the new i_size, but won't increase it.

With DIO writes, however, we definitely want to increase it as we have
clobbered the local pagecache and then written some data that's not
available locally.

Fix cifs to make the zero_point above the end of a DIO or unbuffered write.

This fixes corruption seen occasionally with the generic/708 xfs-test.  In
that case, the read-back of some of the written data is being
short-circuited and replaced with zeroes.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Cc: stable@vger.kernel.org
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/file.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2364,13 +2364,18 @@ void cifs_write_subrequest_terminated(st
 				      bool was_async)
 {
 	struct netfs_io_request *wreq = wdata->rreq;
-	loff_t new_server_eof;
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+	loff_t wrend;
 
 	if (result > 0) {
-		new_server_eof = wdata->subreq.start + wdata->subreq.transferred + result;
+		wrend = wdata->subreq.start + wdata->subreq.transferred + result;
 
-		if (new_server_eof > netfs_inode(wreq->inode)->remote_i_size)
-			netfs_resize_file(netfs_inode(wreq->inode), new_server_eof, true);
+		if (wrend > ictx->zero_point &&
+		    (wdata->rreq->origin == NETFS_UNBUFFERED_WRITE ||
+		     wdata->rreq->origin == NETFS_DIO_WRITE))
+			ictx->zero_point = wrend;
+		if (wrend > ictx->remote_i_size)
+			netfs_resize_file(ictx, wrend, true);
 	}
 
 	netfs_write_subrequest_terminated(&wdata->subreq, result, was_async);



