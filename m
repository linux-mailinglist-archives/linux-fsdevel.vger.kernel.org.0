Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAC31D8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfFAN3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jun 2019 09:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfFAN0r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:26:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9802273D6;
        Sat,  1 Jun 2019 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395606;
        bh=3UPIdmXIdADXaiJl+kkjj0qnijCPhtrHNPwoEaZBDMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuvVB9HMK+SCbEl6EZ9oXsN5+u6qacoSnk6WrslEhO7/KxtQ2DUzSyQhM/YUh27Uz
         1ueFQrRW7/N8yBtaaFX2VZtJdX1coyCz3H0qhRaJ2TUX9NSx+s9IUDVmIHRQiWm1BT
         GatragTZdhp5ie5DzZtwXSQlwfHUuMbMtr2kalC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 25/56] fuse: retrieve: cap requested size to negotiated max_write
Date:   Sat,  1 Jun 2019 09:25:29 -0400
Message-Id: <20190601132600.27427-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kirill Smelkov <kirr@nexedi.com>

[ Upstream commit 7640682e67b33cab8628729afec8ca92b851394f ]

FUSE filesystem server and kernel client negotiate during initialization
phase, what should be the maximum write size the client will ever issue.
Correspondingly the filesystem server then queues sys_read calls to read
requests with buffer capacity large enough to carry request header + that
max_write bytes. A filesystem server is free to set its max_write in
anywhere in the range between [1*page, fc->max_pages*page]. In particular
go-fuse[2] sets max_write by default as 64K, wheres default fc->max_pages
corresponds to 128K. Libfuse also allows users to configure max_write, but
by default presets it to possible maximum.

If max_write is < fc->max_pages*page, and in NOTIFY_RETRIEVE handler we
allow to retrieve more than max_write bytes, corresponding prepared
NOTIFY_REPLY will be thrown away by fuse_dev_do_read, because the
filesystem server, in full correspondence with server/client contract, will
be only queuing sys_read with ~max_write buffer capacity, and
fuse_dev_do_read throws away requests that cannot fit into server request
buffer. In turn the filesystem server could get stuck waiting indefinitely
for NOTIFY_REPLY since NOTIFY_RETRIEVE handler returned OK which is
understood by clients as that NOTIFY_REPLY was queued and will be sent
back.

Cap requested size to negotiate max_write to avoid the problem.  This
aligns with the way NOTIFY_RETRIEVE handler works, which already
unconditionally caps requested retrieve size to fuse_conn->max_pages.  This
way it should not hurt NOTIFY_RETRIEVE semantic if we return less data than
was originally requested.

Please see [1] for context where the problem of stuck filesystem was hit
for real, how the situation was traced and for more involving patch that
did not make it into the tree.

[1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2
[2] https://github.com/hanwen/go-fuse

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fbb978e75c6be..217ceca3eb063 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1734,7 +1734,7 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
 	offset = outarg->offset & ~PAGE_CACHE_MASK;
 	file_size = i_size_read(inode);
 
-	num = outarg->size;
+	num = min(outarg->size, fc->max_write);
 	if (outarg->offset > file_size)
 		num = 0;
 	else if (outarg->offset + num > file_size)
-- 
2.20.1

