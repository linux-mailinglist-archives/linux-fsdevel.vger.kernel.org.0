Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0648337CBC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhELQho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 12:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237424AbhELQUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 12:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620836340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJ4upse7khFQlrmEcgIqmwBiGfPoV54IRNxitLsmg/M=;
        b=QXRxFnPDGTwNBZnkvIHKHYC6XjpvPmD6nmJyAnk0cIl61vYJkWtp5zITxlusQ7RiQBuk2F
        rG8MpfbQwHTrCnVbR0QTVWZgl450JDrztg4k9MF6W48k+DrHWD5rNOYJDDAr4Pgf1VZpmp
        d/kkNgKdjovn5lXOKJW0tvEOmcrVylM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-XwRP9WpjNACYd1NfZ9kMkA-1; Wed, 12 May 2021 12:18:57 -0400
X-MC-Unique: XwRP9WpjNACYd1NfZ9kMkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D35107ACE8;
        Wed, 12 May 2021 16:18:56 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9A1D6D8C0;
        Wed, 12 May 2021 16:18:55 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com, synarete@gmail.com
Subject: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 17:18:48 +0100
Message-Id: <20210512161848.3513818-2-rjones@redhat.com>
In-Reply-To: <20210512161848.3513818-1-rjones@redhat.com>
References: <20210512161848.3513818-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current fuse module filters out fallocate(FALLOC_FL_ZERO_RANGE)
returning -EOPNOTSUPP.  libnbd's nbdfuse would like to translate
FALLOC_FL_ZERO_RANGE requests into the NBD command
NBD_CMD_WRITE_ZEROES which allows NBD servers that support it to do
zeroing efficiently.

This commit treats this flag exactly like FALLOC_FL_PUNCH_HOLE.

A way to test this, requiring fuse >= 3, nbdkit >= 1.8 and the latest
nbdfuse from https://gitlab.com/nbdkit/libnbd/-/tree/master/fuse is to
create a file containing some data and "mirror" it to a fuse file:

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

