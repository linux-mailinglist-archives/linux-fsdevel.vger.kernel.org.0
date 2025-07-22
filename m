Return-Path: <linux-fsdevel+bounces-55693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D723B0DE8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F40858439C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E02ED857;
	Tue, 22 Jul 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DEIoFje1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01602EAB69;
	Tue, 22 Jul 2025 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193773; cv=none; b=QXb5+lfGw+uyGw4OFIbqvS39PUKB6/NDK0cz5iaX2cS6M971QyQaTB2O1Efm5Hsl3g8v6NJSGXOVsk2XBTZ/s2l3/+Um599aILnAX3qoWDvWkG2ODrdr21ylyPjxoizGc/Firo/52771m58SMpC1rAVmJDJnOpz/2bsVuFP3ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193773; c=relaxed/simple;
	bh=6UqfK+HDjsjqgHsoquL2sjPA0DxMcK557ULo5Gof2nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAe/Ey8wgbIee0pi+Kb87VAIXaGUl/v5LOopF81EGSyw1N7GFVtq8sRIhtLJ8eWectuE6hL1mAmVUUm+hBqvrITI6lMAT8HNM23Q7nW16a6PF+AqDGcUt6d+umH9HGjearQXN+N7sDQ/ziyQ49p0cEt+3AXREutq9FbKj+taVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DEIoFje1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD6FC4CEEB;
	Tue, 22 Jul 2025 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193773;
	bh=6UqfK+HDjsjqgHsoquL2sjPA0DxMcK557ULo5Gof2nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEIoFje1zQGwT63+8l/1EWZbT7nFGqhPJ+il9IlJyeVUmM9bQlvxVdBlr5rTJwx/A
	 oj2kDGxBNkvYHfqiHIL6iC/ua+2LS85SI0/ywb1BA9JQcqc3N+7t+42W4uilLKVVfx
	 ue9rdJ42G4zppMzTKj4S8ip5rQ8aLHLUhzFRXAGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Metzmacher <metze@samba.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 181/187] cifs: Fix the smbd_response slab to allow usercopy
Date: Tue, 22 Jul 2025 15:45:51 +0200
Message-ID: <20250722134352.509236048@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 43e7e284fc77b710d899569360ea46fa3374ae22 upstream.

The handling of received data in the smbdirect client code involves using
copy_to_iter() to copy data from the smbd_reponse struct's packet trailer
to a folioq buffer provided by netfslib that encapsulates a chunk of
pagecache.

If, however, CONFIG_HARDENED_USERCOPY=y, this will result in the checks
then performed in copy_to_iter() oopsing with something like the following:

 CIFS: Attempting to mount //172.31.9.1/test
 CIFS: VFS: RDMA transport established
 usercopy: Kernel memory exposure attempt detected from SLUB object 'smbd_response_0000000091e24ea1' (offset 81, size 63)!
 ------------[ cut here ]------------
 kernel BUG at mm/usercopy.c:102!
 ...
 RIP: 0010:usercopy_abort+0x6c/0x80
 ...
 Call Trace:
  <TASK>
  __check_heap_object+0xe3/0x120
  __check_object_size+0x4dc/0x6d0
  smbd_recv+0x77f/0xfe0 [cifs]
  cifs_readv_from_socket+0x276/0x8f0 [cifs]
  cifs_read_from_socket+0xcd/0x120 [cifs]
  cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
  kthread+0x396/0x830
  ret_from_fork+0x2b8/0x3b0
  ret_from_fork_asm+0x1a/0x30

The problem is that the smbd_response slab's packet field isn't marked as
being permitted for usercopy.

Fix this by passing parameters to kmem_slab_create() to indicate that
copy_to_iter() is permitted from the packet region of the smbd_response
slab objects, less the header space.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Stefan Metzmacher <metze@samba.org>
Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@samba.org/
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Tested-by: Stefan Metzmacher <metze@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smbdirect.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1452,6 +1452,9 @@ static int allocate_caches_and_workqueue
 	char name[MAX_NAME_LEN];
 	int rc;
 
+	if (WARN_ON_ONCE(sp->max_recv_size < sizeof(struct smbdirect_data_transfer)))
+		return -ENOMEM;
+
 	scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
 	info->request_cache =
 		kmem_cache_create(
@@ -1469,12 +1472,17 @@ static int allocate_caches_and_workqueue
 		goto out1;
 
 	scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
+
+	struct kmem_cache_args response_args = {
+		.align		= __alignof__(struct smbd_response),
+		.useroffset	= (offsetof(struct smbd_response, packet) +
+				   sizeof(struct smbdirect_data_transfer)),
+		.usersize	= sp->max_recv_size - sizeof(struct smbdirect_data_transfer),
+	};
 	info->response_cache =
-		kmem_cache_create(
-			name,
-			sizeof(struct smbd_response) +
-				sp->max_recv_size,
-			0, SLAB_HWCACHE_ALIGN, NULL);
+		kmem_cache_create(name,
+				  sizeof(struct smbd_response) + sp->max_recv_size,
+				  &response_args, SLAB_HWCACHE_ALIGN);
 	if (!info->response_cache)
 		goto out2;
 



