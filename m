Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784DC4C6F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 15:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiB1OdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 09:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbiB1Oc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:32:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FE7EB3A;
        Mon, 28 Feb 2022 06:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4328D609E9;
        Mon, 28 Feb 2022 14:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A281FC340E7;
        Mon, 28 Feb 2022 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646058738;
        bh=uxwjuc0iqnBJQwJbt9pqUbwsGAijryZDB2ezT0C3nTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Z8U3Ac7/+hLw1L2V7ag+Bg7hC59cH06hMUCKCHxX8Ajz+uWnDKa02iXpoFZiuBWL8
         tHI/HB6EaDI8lPT948tvKYnLv3XXiqas+mnOrjIwo/mtSkd3/0WQ4Ci2Luu6jJP7Hh
         3sl5VH9oO74mqmeZXUBB9a7RoG60b0nXV6fpvWnvrtyshEPHa2Wd3YVBvnuTYPMLu5
         YGdKVVgWK6yUBPAr1vf3YxTu57pOp5c63U4m3YJfB6Sp7svWT8iEasFSicd2aM9/F6
         XQQxuLVQipBNM6EEEAPdDEVw5Ggb/4nGdmwxofVbgA75xwx0UVMIIOpwr0/kS4+zCK
         OE6lkolGer1dQ==
From:   fdmanana@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        djwong@kernel.org, hch@infradead.org, cluster-devel@redhat.com,
        agruenba@redhat.com, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] iomap: fix incomplete async dio reads when using IOMAP_DIO_PARTIAL
Date:   Mon, 28 Feb 2022 14:32:03 +0000
Message-Id: <1f34c8435fed21e9583492661ceb20d642a75699.1646058596.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some users recently reported that MariaDB was getting a read corruption
when using io_uring on top of btrfs. This started to happen in 5.16,
after commit 51bd9563b6783d ("btrfs: fix deadlock due to page faults
during direct IO reads and writes"). That changed btrfs to use the new
iomap flag IOMAP_DIO_PARTIAL and to disable page faults before calling
iomap_dio_rw(). This was necessary to fix deadlocks when the iovector
corresponds to a memory mapped file region. That type of scenario is
exercised by test case generic/647 from fstests, and it also affected
gfs2, which, besides btrfs, is the only user of IOMAP_DIO_PARTIAL.

For this MariaDB scenario, we attempt to read 16K from file offset X
using IOCB_NOWAIT and io_uring. In that range we have 4 extents, each
with a size of 4K, and what happens is the following:

1) btrfs_direct_read() disables page faults and calls iomap_dio_rw();

2) iomap creates a struct iomap_dio object, its reference count is
   initialized to 1 and its ->size field is initialized to 0;

3) iomap calls btrfs_iomap_begin() with file offset X, which finds the
   first 4K extent, and setups an iomap for this extent consisting of
   a single page;

4) At iomap_dio_bio_iter(), we are able to access the first page of the
   buffer (struct iov_iter) with bio_iov_iter_get_pages() without
   triggering a page fault;

5) iomap submits a bio for this 4K extent
   (iomap_dio_submit_bio() -> btrfs_submit_direct()) and increments
   the refcount on the struct iomap_dio object to 2; The ->size field
   of the struct iomap_dio object is incremented to 4K;

6) iomap calls btrfs_iomap_begin() again, this time with a file
   offset of X + 4K. There we setup an iomap for the next extent
   that also has a size of 4K;

7) Then at iomap_dio_bio_iter() we call bio_iov_iter_get_pages(),
   which tries to access the next page (2nd page) of the buffer.
   This triggers a page fault and returns -EFAULT;

8) At __iomap_dio_rw() we see the -EFAULT, but we reset the error
   to 0 because we passed the flag IOMAP_DIO_PARTIAL to iomap and
   the struct iomap_dio object has a ->size value of 4K (we submitted
   a bio for an extent already). The 'wait_for_completion' variable
   is not set to true, because our iocb has IOCB_NOWAIT set;

9) At the bottom of __iomap_dio_rw(), we decrement the reference count
   of the struct iomap_dio object from 2 to 1. Because we were not
   the only ones holding a reference on it and 'wait_for_completion' is
   set to false, -EIOCBQUEUED is returned to btrfs_direct_read(), which
   just returns it up the callchain, up to io_uring;

10) The bio submitted for the first extent (step 5) completes and its
    bio endio function, iomap_dio_bio_end_io(), decrements the last
    reference on the struct iomap_dio object, resulting in calling
    iomap_dio_complete_work() -> iomap_dio_complete().

11) At iomap_dio_complete() we adjust the iocb->ki_pos from X to X + 4K
    and return 4K (the amount of io done) to iomap_dio_complete_work();

12) iomap_dio_complete_work() calls the iocb completion callback,
    iocb->ki_complete() with a second argument value of 4K (total io
    done) and the iocb with the adjust ki_pos of X + 4K. This results
    in completing the read request for io_uring, leaving it with a
    result of 4K bytes read, and only the first page of the buffer
    filled in, while the remaining 3 pages, corresponding to the other
    3 extents, were not filled;

13) For the application, the result is unexpected because if we ask
    to read N bytes, it expects to get N bytes read as long as those
    N bytes don't cross the EOF (i_size).

So fix this by making __iomap_dio_rw() assign true to the boolean variable
'wait_for_completion' when we have IOMAP_DIO_PARTIAL set, we did some
progress for a read and we have not crossed the EOF boundary. Do this even
if the read has IOCB_NOWAIT set, as it's the only way to avoid providing
an unexpected result to an application. This results in returning a
positive value to the iomap caller, which tells it to fault in the
remaining pages associated to the buffer (struct iov_iter), followed by
another call to iomap_dio_rw() with IOMAP_DIO_PARTIAL set, in order to
continue the rest of the read operation.

The problem can also be triggered with the following simple program:

  /* Get O_DIRECT */
  #ifndef _GNU_SOURCE
  #define _GNU_SOURCE
  #endif

  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <fcntl.h>
  #include <errno.h>
  #include <string.h>
  #include <liburing.h>

  int main(int argc, char *argv[])
  {
      char *foo_path;
      struct io_uring ring;
      struct io_uring_sqe *sqe;
      struct io_uring_cqe *cqe;
      struct iovec iovec;
      int fd;
      long pagesize;
      void *write_buf;
      void *read_buf;
      ssize_t ret;
      int i;

      if (argc != 2) {
          fprintf(stderr, "Use: %s <directory>\n", argv[0]);
          return 1;
      }

      foo_path = malloc(strlen(argv[1]) + 5);
      if (!foo_path) {
          fprintf(stderr, "Failed to allocate memory for file path\n");
          return 1;
      }
      strcpy(foo_path, argv[1]);
      strcat(foo_path, "/foo");

      /*
       * Create file foo with 2 extents, each with a size matching
       * the page size. Then allocate a buffer to read both extents
       * with io_uring, using O_DIRECT and IOCB_NOWAIT. Before doing
       * the read with io_uring, access the first page of the buffer
       * to fault it in, so that during the read we only trigger a
       * page fault when accessing the second page of the buffer.
       */
       fd = open(foo_path, O_CREAT | O_TRUNC | O_WRONLY |
                O_DIRECT, 0666);
       if (fd == -1) {
           fprintf(stderr,
                   "Failed to create file 'foo': %s (errno %d)",
                   strerror(errno), errno);
           return 1;
       }

       pagesize = sysconf(_SC_PAGE_SIZE);
       ret = posix_memalign(&write_buf, pagesize, 2 * pagesize);
       if (ret) {
           fprintf(stderr, "Failed to allocate write buffer\n");
           return 1;
       }

       memset(write_buf, 0xab, pagesize);
       memset(write_buf + pagesize, 0xcd, pagesize);

       /* Create 2 extents, each with a size matching page size. */
       for (i = 0; i < 2; i++) {
           ret = pwrite(fd, write_buf + i * pagesize, pagesize,
	                i * pagesize);
           if (ret != pagesize) {
               fprintf(stderr,
                     "Failed to write to file, ret = %ld errno %d (%s)\n",
                      ret, errno, strerror(errno));
               return 1;
           }
           ret = fsync(fd);
           if (ret != 0) {
               fprintf(stderr, "Failed to fsync file\n");
               return 1;
           }
       }

       close(fd);
       fd = open(foo_path, O_RDONLY | O_DIRECT);
       if (fd == -1) {
           fprintf(stderr,
                   "Failed to open file 'foo': %s (errno %d)",
                   strerror(errno), errno);
           return 1;
       }

       ret = posix_memalign(&read_buf, pagesize, 2 * pagesize);
       if (ret) {
           fprintf(stderr, "Failed to allocate read buffer\n");
           return 1;
       }

       /*
        * Fault in only the first page of the read buffer.
        * We want to trigger a page fault for the 2nd page of the
        * read buffer during the read operation with io_uring
        * (O_DIRECT and IOCB_NOWAIT).
        */
       memset(read_buf, 0, 1);

       ret = io_uring_queue_init(1, &ring, 0);
       if (ret != 0) {
           fprintf(stderr, "Failed to create io_uring queue\n");
           return 1;
       }

       sqe = io_uring_get_sqe(&ring);
       if (!sqe) {
           fprintf(stderr, "Failed to get io_uring sqe\n");
           return 1;
       }

       iovec.iov_base = read_buf;
       iovec.iov_len = 2 * pagesize;
       io_uring_prep_readv(sqe, fd, &iovec, 1, 0);

       ret = io_uring_submit_and_wait(&ring, 1);
       if (ret != 1) {
           fprintf(stderr,
                   "Failed at io_uring_submit_and_wait()\n");
           return 1;
       }

       ret = io_uring_wait_cqe(&ring, &cqe);
       if (ret < 0) {
           fprintf(stderr, "Failed at io_uring_wait_cqe()\n");
           return 1;
       }

       printf("io_uring read result for file foo:\n\n");
       printf("  cqe->res = %d (expected %d)\n", cqe->res, 2 * pagesize);
       printf("  memcmp(read_buf, write_buf) == %d (expected 0)\n",
              memcmp(read_buf, write_buf, 2 * pagesize));

       io_uring_cqe_seen(&ring, cqe);
       io_uring_queue_exit(&ring);

       return 0;
  }

When running it on an unpatched kernel:

  $ gcc io_uring_test.c -luring
  $ mkfs.btrfs -f /dev/sda
  $ mount /dev/sda /mnt/sda
  $ ./a.out /mnt/sda
  io_uring read result for file foo:

    cqe->res = 4096 (expected 8192)
    memcmp(read_buf, write_buf) == -205 (expected 0)

After this patch, the read always returns 8192 bytes, with the buffer
filled with the correct data. Although that reproducer always triggers
the bug in my test vms, it's possible that it will not be so reliable
on other environments, as that can happen if the bio for the first
extent completes and decrements the reference on the struct iomap_dio
object before we do the atomic_dec_and_test() on the reference at
__iomap_dio_rw().

A test case for fstests will followup later.

Link: https://lore.kernel.org/linux-btrfs/CABVffEM0eEWho+206m470rtM0d9J8ue85TtR-A_oVTuGLWFicA@mail.gmail.com/
Link: https://lore.kernel.org/linux-btrfs/CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/iomap/direct-io.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 03ea367df19a..9a6fdefa34f3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -606,7 +606,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		iov_iter_revert(iter, iomi.pos - dio->i_size);
 
 	if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {
-		if (!(iocb->ki_flags & IOCB_NOWAIT))
+		/*
+		 * If we are a NOWAIT request we don't want to wait for the
+		 * completion of any previously submitted bios. However there
+		 * is one exception: if we are doing a read and we have not
+		 * submitted bios for everything we are supposed to read, then
+		 * we have to wait for completion - otherwise we may end up
+		 * returning -EIOCBQUEUED without having read everything we
+		 * can read, making our caller think we have reached EOF.
+		 */
+		if (!(iocb->ki_flags & IOCB_NOWAIT) ||
+		    (iov_iter_rw(iter) == READ &&
+		     iomi.len > 0 &&
+		     iomi.pos < dio->i_size))
 			wait_for_completion = true;
 		ret = 0;
 	}
-- 
2.33.0

