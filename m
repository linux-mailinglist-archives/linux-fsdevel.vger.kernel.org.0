Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1BE37C362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhELPSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 11:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233778AbhELPOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 11:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620832425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOa32iIL0rOcLifOOINIT3ZdxbID0WK1fPWbMu9csHU=;
        b=B8S1Mbz5CB+lTdpGK7Zxixt2LwhBWGQl+b9hJQ8Bs6q2Ia/ggZsENhQnUk+viRePqLwjwG
        Pz6Sx4gQ+9kj7P2hCe5BQQEw22iFoFCo9Lj5F90JO2UZ4R5YRh3SyfNxefYwO/s9mWSxoO
        D5+yPm2UEBljORguMtNs4yta/0dq0lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-TgqsjOPTPu2cS2Hf3jLvnw-1; Wed, 12 May 2021 11:13:43 -0400
X-MC-Unique: TgqsjOPTPu2cS2Hf3jLvnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE38CC649;
        Wed, 12 May 2021 15:12:58 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E616D108648F;
        Wed, 12 May 2021 15:12:56 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com, synarete@gmail.com
Subject: [PATCH v3] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 16:12:23 +0100
Message-Id: <20210512151223.3512221-2-rjones@redhat.com>
In-Reply-To: <20210512151223.3512221-1-rjones@redhat.com>
References: <20210512151223.3512221-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

libnbd's nbdfuse utility would like to translate fallocate zero
requests into NBD_CMD_WRITE_ZEROES.  Currently the fuse module filters
these out, returning -EOPNOTSUPP.  This commit treats these almost the
same way as FALLOC_FL_PUNCH_HOLE except not calling
truncate_pagecache_range.

A way to test this, requiring fuse >= 3, nbdkit >= 1.8 and the latest
nbdfuse from https://gitlab.com/nbdkit/libnbd/-/tree/master/fuse is to
create a file containing data and "mirror" it to a fuse file:

  $ dd if=/dev/urandom of=disk.img bs=1M count=1
  $ nbdkit file disk.img
  $ touch mirror.img
  $ nbdfuse mirror.img nbd://localhost &

(mirror.img -> nbdfuse -> NBD over loopback -> nbdkit -> disk.img)

You can then run commands such as:

  $ fallocate -z -o 1024 -l 1024 mirror.img

and check that the content of the original file ("disk.img") stays
synchronized.  To show NBD commands, export LIBNBD_DEBUG=1 before
running nbdfuse.  To clean up:

  $ fusermount3 -u mirror.img
  $ killall nbdkit

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 fs/fuse/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09ef2a4d25ed..ec20a1801c1b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2907,11 +2907,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	};
 	int err;
 	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
-			   (mode & FALLOC_FL_PUNCH_HOLE);
+			   (mode & (FALLOC_FL_PUNCH_HOLE |
+				    FALLOC_FL_ZERO_RANGE));
 
 	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
 
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
 
 	if (fm->fc->no_fallocate)
@@ -2926,7 +2928,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 				goto out;
 		}
 
-		if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
 			loff_t endbyte = offset + length - 1;
 
 			err = fuse_writeback_range(inode, offset, endbyte);
@@ -2966,7 +2968,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 			file_update_time(file);
 	}
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
 		truncate_pagecache_range(inode, offset, offset + length - 1);
 
 	fuse_invalidate_attr(inode);
-- 
2.31.1

