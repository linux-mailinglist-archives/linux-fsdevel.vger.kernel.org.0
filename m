Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E068550029
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356130AbiFQWsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356143AbiFQWsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:48:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B931EEF7
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ucXKldS6+Ez2tOJuAiG6ZubKPP+RQrJZEWgiqT436nk=; b=Fwx/FBqppb7DtfnUv9bBzKoHWx
        8ezs8BRzNqbLFOfLDLuu8XD0d1a2rK062xblMkpCBEfekEEnTONWHjEvElzMnacBHLK+GMxV5SCqk
        26Z4kvS4QkPZ1hYqzOzMWe8NjD2+NT4k96vk1s1JyWHu3P+8eyGmDgyz0+O96zu0DfbHjJJCO76L6
        swsKW/TFInAIcYQ9uzjxkgZM9VuEJXI6WafJXJmAK1UkNqNaHeHPru7Q6x/B9xi8YIrKmjHU1u/Bb
        pIgR6b2FT7JLH97FAM0/f6kZY2iPzuAK/nREluGT7OAvfaz4/BLO3PFU5SfdwcT78YDjx88vOEceB
        mv9K7DhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2Kkz-001OZT-GE;
        Fri, 17 Jun 2022 22:48:01 +0000
Date:   Fri, 17 Jun 2022 23:48:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC][PATCHES] iov_iter stuff
Message-ID: <Yq0EoTzFE+dSAYY1@ZenIV>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <8fb435a4-269d-9675-9a44-d37605c84314@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb435a4-269d-9675-9a44-d37605c84314@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 04:30:49PM -0600, Jens Axboe wrote:

> Al, looks good to me from inspection, and I ported stuffed this on top
> of -git and my 5.20 branch, and did my send/recv/recvmsg io_uring change
> on top and see a noticeable reduction there too for some benchmarking.
> Feel free to add:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> to the series.
> 
> Side note - of my initial series I played with, I still have this one
> leftover that I do utilize for io_uring:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/io_uring-iter&id=a59f5c21a6eeb9506163c20aff4846dbec159f47
> 
> Doesn't make sense standalone, but I have it as a prep patch.
> 
> Can I consider your work.iov_iter stable at this point, or are you still
> planning rebasing?

Umm...  Rebasing this part - probably no; there's a fun followup to it, though,
I'm finishing the carve up & reorder at the moment.  Will post for review
tonight...

Current state:

Al Viro (43):
      No need of likely/unlikely on calls of check_copy_size()
      9p: handling Rerror without copy_from_iter_full()
      teach iomap_dio_rw() to suppress dsync
      btrfs: use IOMAP_DIO_NOSYNC
      struct file: use anonymous union member for rcuhead and llist
      iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
      keep iocb_flags() result cached in struct file
      copy_page_{to,from}_iter(): switch iovec variants to generic
      new iov_iter flavour - ITER_UBUF
      switch new_sync_{read,write}() to ITER_UBUF
      iov_iter_bvec_advance(): don't bother with bvec_iter
      fix short copy handling in copy_mc_pipe_to_iter()
      splice: stop abusing iov_iter_advance() to flush a pipe
      ITER_PIPE: helper for getting pipe buffer by index
      ITER_PIPE: helpers for adding pipe buffers
      ITER_PIPE: allocate buffers as we go in copy-to-pipe primitives
      ITER_PIPE: fold push_pipe() into __pipe_get_pages()
      ITER_PIPE: lose iter_head argument of __pipe_get_pages()
      ITER_PIPE: clean pipe_advance() up
      ITER_PIPE: clean iov_iter_revert()
      ITER_PIPE: cache the type of last buffer
      fold data_start() and pipe_space_for_user() together
      iov_iter_get_pages{,_alloc}(): cap the maxsize with LONG_MAX
      iov_iter_get_pages_alloc(): lift freeing pages array on failure exits into wrapper
      iov_iter_get_pages(): sanity-check arguments
      unify pipe_get_pages() and pipe_get_pages_alloc()
      unify xarray_get_pages() and xarray_get_pages_alloc()
      unify the rest of iov_iter_get_pages()/iov_iter_get_pages_alloc() guts
      ITER_XARRAY: don't open-code DIV_ROUND_UP()
      iov_iter: lift dealing with maxpages into iov_iter_get_pages()
      iov_iter: massage calling conventions for first_{iovec,bvec}_segment()
      found_iovec_segment(): just return address
      fold __pipe_get_pages() into pipe_get_pages()
      iov_iter: saner helper for page array allocation
      iov_iter: advancing variants of iov_iter_get_pages{,_alloc}()
      block: convert to advancing variants of iov_iter_get_pages{,_alloc}()
      iter_to_pipe(): switch to advancing variant of iov_iter_get_pages()
      af_alg_make_sg(): switch to advancing variant of iov_iter_get_pages()
      9p: convert to advancing variant of iov_iter_get_pages_alloc()
      ceph: switch the last caller of iov_iter_get_pages_alloc()
      get rid of non-advancing variants
      pipe_get_pages(): switch to append_pipe()
      expand those iov_iter_advance()...

 arch/powerpc/include/asm/uaccess.h |   2 +-
 arch/s390/include/asm/uaccess.h    |   4 +-
 block/bio.c                        |  15 +-
 block/blk-map.c                    |   7 +-
 block/fops.c                       |   8 +-
 crypto/af_alg.c                    |   3 +-
 crypto/algif_hash.c                |   5 +-
 drivers/nvme/target/io-cmd-file.c  |   2 +-
 drivers/vhost/scsi.c               |   4 +-
 fs/aio.c                           |   2 +-
 fs/btrfs/file.c                    |  19 +-
 fs/btrfs/inode.c                   |   3 +-
 fs/ceph/addr.c                     |   2 +-
 fs/ceph/file.c                     |   5 +-
 fs/cifs/file.c                     |   8 +-
 fs/cifs/misc.c                     |   3 +-
 fs/direct-io.c                     |   7 +-
 fs/fcntl.c                         |   1 +
 fs/file_table.c                    |  17 +-
 fs/fuse/dev.c                      |   7 +-
 fs/fuse/file.c                     |   7 +-
 fs/gfs2/file.c                     |   2 +-
 fs/io_uring.c                      |   2 +-
 fs/iomap/direct-io.c               |  21 +-
 fs/nfs/direct.c                    |   8 +-
 fs/open.c                          |   1 +
 fs/read_write.c                    |   6 +-
 fs/splice.c                        |  54 +-
 fs/zonefs/super.c                  |   2 +-
 include/linux/fs.h                 |  21 +-
 include/linux/iomap.h              |   6 +
 include/linux/pipe_fs_i.h          |  29 +-
 include/linux/uaccess.h            |   4 +-
 include/linux/uio.h                |  50 +-
 lib/iov_iter.c                     | 978 ++++++++++++++-----------------------
 mm/shmem.c                         |   2 +-
 net/9p/client.c                    | 125 +----
 net/9p/protocol.c                  |   3 +-
 net/9p/trans_virtio.c              |  37 +-
 net/core/datagram.c                |   3 +-
 net/core/skmsg.c                   |   3 +-
 net/rds/message.c                  |   3 +-
 net/tls/tls_sw.c                   |   4 +-
 43 files changed, 589 insertions(+), 906 deletions(-)

