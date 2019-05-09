Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495CA19303
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 21:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEITmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 15:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfEITmr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 15:42:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E287D30024AB;
        Thu,  9 May 2019 19:42:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5BC660CC0;
        Thu,  9 May 2019 19:42:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0D925220CB9; Thu,  9 May 2019 15:42:45 -0400 (EDT)
Date:   Thu, 9 May 2019 15:42:44 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] fuse: Clear setuid bit even in cache=never path
Message-ID: <20190509194244.GD24766@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 09 May 2019 19:42:46 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If fuse daemon is started with cache=never, fuse falls back to direct IO.
In that write path we don't call file_remove_privs() and that means setuid
bit is not cleared if unpriviliged user writes to a file with setuid bit set.

pjdfstest chmod test 12.t tests this and fails.

Fix this by calling fuse_remove_privs() even for direct I/O path.

I tested this as follows.

- Run fuse example pasthrough fs.

  $ passthrough_ll /mnt/pasthrough-mnt -o default_permissions,allow_other,cache=never
  $ mkdir /mnt/pasthrough-mnt/testdir
  $ cd /mnt/pasthrough-mnt/testdir
  $ prove -rv pjdfstests/tests/chmod/12.t

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

Index: rhvgoyal-linux/fs/fuse/file.c
===================================================================
--- rhvgoyal-linux.orig/fs/fuse/file.c	2019-05-09 15:08:36.782054201 -0400
+++ rhvgoyal-linux/fs/fuse/file.c	2019-05-09 15:28:09.397054201 -0400
@@ -1456,14 +1456,18 @@ static ssize_t fuse_direct_write_iter(st
 	/* Don't allow parallel writes to the same file */
 	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
-	if (res > 0) {
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-			res = fuse_direct_IO(iocb, from);
-		} else {
-			res = fuse_direct_io(&io, from, &iocb->ki_pos,
-					     FUSE_DIO_WRITE);
-		}
+	if (res <= 0)
+		goto out;
+
+	res = file_remove_privs(iocb->ki_filp);
+	if (res)
+		goto out;
+	if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
+		res = fuse_direct_IO(iocb, from);
+	} else {
+		res = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
 	}
+out:
 	fuse_invalidate_attr(inode);
 	if (res > 0)
 		fuse_write_update_size(inode, iocb->ki_pos);
