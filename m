Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C280037BACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELKi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 06:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhELKi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 06:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620815838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOVMN72sKeKCS1PFdOW/P2Twf1MTO/8asgvKsZIuneY=;
        b=VZ55gDp8kBQ9Z+N/Y+qaP+i2IKgSMeo2RPlJYUZ13Gd0L1pFvFEwTwaljZenP8ExMVJB6z
        XDraRUd6zCqdYsNkvxkVN9b+NKkN6DzOGoxEBEvqFeAG5C/exO5nIbXhcK9xwMGTRRp3zu
        N79rde9Ogr7ljnvLyvSbh4HCCcbM7pA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-ZqO7vMrOMTa0rqxr37eUaQ-1; Wed, 12 May 2021 06:37:16 -0400
X-MC-Unique: ZqO7vMrOMTa0rqxr37eUaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53C62802938;
        Wed, 12 May 2021 10:37:15 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 261117770F;
        Wed, 12 May 2021 10:37:13 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com
Subject: [PATCH v2] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 11:37:04 +0100
Message-Id: <20210512103704.3505086-2-rjones@redhat.com>
In-Reply-To: <20210512103704.3505086-1-rjones@redhat.com>
References: <20210512103704.3505086-1-rjones@redhat.com>
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
  #!/bin/bash
  # Requires fuse >= 3, nbdkit >= 1.8, and latest nbdfuse from
  # https://gitlab.com/nbdkit/libnbd/-/tree/master/fuse
  set -e
  set -x

  export output=$PWD/output
  rm -f test.img $output

  # Create an nbdkit instance that prints the NBD requests seen.
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

  # Fuse-mount NBD instance as a file.
  touch test.img
  nbdfuse test.img nbd://localhost & sleep 2
  ls -lh test.img

  # Run a read, write, trim and zero request.
  dd if=test.img of=/dev/null bs=512 skip=1024 count=1
  dd if=/dev/zero of=test.img bs=512 skip=2048 count=1
  fallocate -p -l 512 -o 4096 test.img
  fallocate -z -l 512 -o 8192 test.img

  # Print the output from the NBD server.
  cat $output

  # Clean up.
  fusermount3 -u test.img
  killall nbdkit
  rm test.img $output
  --------------------

which will print:

  pread  4096 524288    # number depends on readahead
  pwrite  512 0
  trim  512 4096
  zero  512 8192 may_trim

The last line indicates that the FALLOC_FL_ZERO_RANGE request was
successfully passed through by the kernel module to nbdfuse,
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

