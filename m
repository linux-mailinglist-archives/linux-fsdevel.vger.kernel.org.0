Return-Path: <linux-fsdevel+bounces-24125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0093A045
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB52837A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4615251C;
	Tue, 23 Jul 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ck6kNG7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272061514DE;
	Tue, 23 Jul 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735539; cv=none; b=ft3CSn9oBa6Aifd/K+j5WQneah7q0WN02l1/rMSoN9zvb+ThQpUDe2dsZY9bdzTjjVRP7CJYqvHtlAkxRTzH0vagNIbI0KzfVaeNOMHlN5BjzOWNNd8Pn9TRNBqDYDhkWE/l2UaLED8OcOSIRVqVAvkeKsDVuntiOgPOwvozWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735539; c=relaxed/simple;
	bh=fnGlvnVVajk0n/+8DsGik+8yqDDdFWAb5kZJ8soCR1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miPMrtaVFLL+MHHxzvikrFJL5opR0MjBt1Dywd1962pN6WVtmQAUzevpMCKMCFf5RTeqvT5lteJXVsRAYd8omNhjZU1Fab0bUF++zBKlivxsGXhLavAUTuMTgdANCojukJV4gg8uds2gTtKTNXw47c6vzwdmPVA5GICCgnPEbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ck6kNG7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25498C4AF0A;
	Tue, 23 Jul 2024 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721735538;
	bh=fnGlvnVVajk0n/+8DsGik+8yqDDdFWAb5kZJ8soCR1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ck6kNG7Lq9wm9aOwFOej6R3e7K50bPLhidLKRaDhWV7xJWG9bNa8+ENkhObV3ttc2
	 ydnc/w2vAIJzqS/T7ztPL4Zi3zOi+zQPESb2CEMqUkeSPn5UXc4sYSxa6ZXoA8AEyR
	 DlG0loXnpCBNMHn3n1KVjZYW7bNFUqfFq62ab8NQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 3/9] cifs: Fix missing fscache invalidation
Date: Tue, 23 Jul 2024 13:51:57 +0200
Message-ID: <20240723114047.405296521@linuxfoundation.org>
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

commit a07d38afd15281c42613943a9a715c3ba07c21e6 upstream.

A network filesystem needs to implement a netfslib hook to invalidate
fscache if it's to be able to use the cache.

Fix cifs to implement the cache invalidation hook.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -123,6 +123,11 @@ fail:
 	goto out;
 }
 
+static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
+{
+	cifs_invalidate_cache(wreq->inode, 0);
+}
+
 /*
  * Split the read up according to how many credits we can get for each piece.
  * It's okay to sleep here if we need to wait for more credit to become
@@ -307,6 +312,7 @@ const struct netfs_request_ops cifs_req_
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
 	.issue_write		= cifs_issue_write,
+	.invalidate_cache	= cifs_netfs_invalidate_cache,
 };
 
 /*



