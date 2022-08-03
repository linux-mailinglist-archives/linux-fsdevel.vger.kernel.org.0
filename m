Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71B85892D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiHCTir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiHCTip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:38:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214245B787;
        Wed,  3 Aug 2022 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/DHGHFZuYgsH6ko6kq6vYm0GCpPQD7bj42ojNUkWlss=; b=CpfBmrjh1OKTV3g66B0otkSAo2
        aoU7pW91bEJOAxde0Y1zCSLQ+F/DN7iPLEzPlayWEoduVTaI3yaEI/AhUNxtUcxYZRBW+rrcaJjRS
        pKsyOy51NLftRc00+DZj3YzbD9KFdOl2U/sx82lYMK0IYqhziPr7XkkIJeVAWcPFJoWqNHSMjaXo4
        EHiawV2VyM1gL+gsdGhLx29h2f/qaiugCmK3EF0IcSzUyuApjsX4gxvRhAUOAvINV+Qrmq4BOZUrj
        LKqeDqDqA6CIAoS0gwz7vZcWwuXMyB6K5qU12GQ3AqlFdNzoP5chIWywZnNeYUXVEdltF+oDhfKnI
        oYpBq96w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oJKCY-000vSh-6Y;
        Wed, 03 Aug 2022 19:38:42 +0000
Date:   Wed, 3 Aug 2022 20:38:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 4 - beginning of iov_iter series
Message-ID: <YurOwiZoOKkj+kNW@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.iov_iter-base

for you to fetch changes up to dd45ab9dd28c82fc495d98cd9788666fd8d76b99:

  first_iovec_segment(): just return address (2022-07-06 20:32:34 -0400)

	Two trivial conflicts - one in block/fops.c::dio_bio_write_op()
(one-liner in this series applied to corresponding line in mainline),
another in io_rw_init_file() which got moved from fs/io_uring.c to
io_uring/rw.c.

----------------------------------------------------------------
iov_iter work, part 1 - isolated cleanups and optimizations.

	One of the goals is to reduce the overhead of using ->read_iter()
and ->write_iter() instead of ->read()/->write(); new_sync_{read,write}()
has a surprising amount of overhead, in particular inside iocb_flags().
That's why the beginning of the series is in this pile; it's not directly
iov_iter-related, but it's a part of the same work...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (13):
      No need of likely/unlikely on calls of check_copy_size()
      teach iomap_dio_rw() to suppress dsync
      btrfs: use IOMAP_DIO_NOSYNC
      struct file: use anonymous union member for rcuhead and llist
      iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
      keep iocb_flags() result cached in struct file
      copy_page_{to,from}_iter(): switch iovec variants to generic
      iov_iter_bvec_advance(): don't bother with bvec_iter
      iov_iter_get_pages{,_alloc}(): cap the maxsize with MAX_RW_COUNT
      iov_iter: lift dealing with maxpages out of first_{iovec,bvec}_segment()
      iov_iter: first_{iovec,bvec}_segment() - simplify a bit
      iov_iter: massage calling conventions for first_{iovec,bvec}_segment()
      first_iovec_segment(): just return address

 arch/powerpc/include/asm/uaccess.h |   2 +-
 arch/s390/include/asm/uaccess.h    |   4 +-
 block/fops.c                       |   2 +-
 drivers/nvme/target/io-cmd-file.c  |   2 +-
 fs/aio.c                           |   2 +-
 fs/btrfs/file.c                    |  19 +--
 fs/btrfs/inode.c                   |   3 +-
 fs/direct-io.c                     |   2 +-
 fs/fcntl.c                         |   1 +
 fs/file_table.c                    |  17 +--
 fs/fuse/file.c                     |   2 +-
 fs/io_uring.c                      |   2 +-
 fs/iomap/direct-io.c               |  19 +--
 fs/open.c                          |   1 +
 fs/zonefs/super.c                  |   2 +-
 include/linux/fs.h                 |  21 +--
 include/linux/iomap.h              |   6 +
 include/linux/uaccess.h            |   4 +-
 include/linux/uio.h                |  15 +-
 lib/iov_iter.c                     | 283 +++++++------------------------------
 20 files changed, 113 insertions(+), 296 deletions(-)
