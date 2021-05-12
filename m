Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337A137B9CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhELJ6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 05:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhELJ6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 05:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620813419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AuuHiyHzWCvDvpb+9mEAJUJncR56QBgtEVHCWSbhuTY=;
        b=iscHeh7do4PieTOLHpswnUqIKjcU1p+4CDepb1U7roiWkOZYl9ujK+1LVHBrVfhJezyoAP
        gV61Cx86MI35z2U+xvlzbm4ZyXU4egflptsz0dBaoQhxGfQ1u9NLmLTxpJCTF9YCOZyqIb
        sk9boQ4qwr2zYcbYo8AZDNijQ9d1Hps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-rEogLUVRNb2YinVL76uP7g-1; Wed, 12 May 2021 05:56:55 -0400
X-MC-Unique: rEogLUVRNb2YinVL76uP7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9128ACC624;
        Wed, 12 May 2021 09:56:54 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F2DC6E51D;
        Wed, 12 May 2021 09:56:49 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com
Subject: [PATCH] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 10:56:47 +0100
Message-Id: <20210512095647.3503965-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

libnbd's nbdfuse utility would like to translate fallocate zero
requests into NBD_CMD_WRITE_ZEROES.  Currently the fuse module filters
these out, returning -EOPNOTSUPP.  This commit treats these almost the
same way as FALLOC_FL_PUNCH_HOLE except not calling
truncate_pagecache_range.

A way to test this is with the following script:

--------------------
set -e
set -x

export output=$PWD/output
rm -f test.img $output

nbdkit sh - <<'EOF'
case "$1" in
  get_size) echo 1M ;;
  can_write|can_trim|can_zero|can_fast_zero) ;;
  pread) echo "$@" >>$output; dd if=/dev/zero count=$3 iflag=count_bytes ;;
  pwrite) echo "$@" >>$output; cat >/dev/null ;;
  trim|zero) echo "$@" >>$output ;;
  *) exit 2 ;;
esac
EOF

touch test.img
nbdfuse --version
nbdfuse test.img nbd://localhost & sleep 2
ls -lh test.img

dd if=test.img of=/dev/null bs=512 skip=1024 count=1
dd if=/dev/zero of=test.img bs=512 skip=2048 count=1
fallocate -p -l 512 -o 4096 test.img
fallocate -z -l 512 -o 8192 test.img

cat $output

fusermount3 -u test.img
killall nbdkit
rm test.img $output
--------------------

which will print:

pread  4096 524288    # number depends on readahea
pwrite  512 0
trim  512 4096
zero  512 8192 may_trim

with the last line indicating that the FALLOC_FL_ZERO_RANGE request
was successfully passed through by the kernel module to nbdfuse,
translated to NBD_CMD_WRITE_ZEROES and sent through to the server.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 fs/fuse/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09ef2a4d25ed..22e8e88c78d4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2907,11 +2907,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	};
 	int err;
 	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
-			   (mode & FALLOC_FL_PUNCH_HOLE);
+			   (mode & FALLOC_FL_PUNCH_HOLE) ||
+			   (mode & FALLOC_FL_ZERO_RANGE);
 
 	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
 
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
 
 	if (fm->fc->no_fallocate)
@@ -2926,7 +2928,8 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 				goto out;
 		}
 
-		if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if ((mode & FALLOC_FL_PUNCH_HOLE) ||
+		    (mode & FALLOC_FL_ZERO_RANGE)) {
 			loff_t endbyte = offset + length - 1;
 
 			err = fuse_writeback_range(inode, offset, endbyte);
-- 
2.31.1

