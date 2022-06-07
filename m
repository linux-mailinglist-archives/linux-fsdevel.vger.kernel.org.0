Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11353F4D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiFGEIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFGEIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:08:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B665C6E5C
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/32PqYKkg3p7PY81HRnudN6KBTfqZHXOfc4dk5u5pCk=; b=l+8TrHnr6WCJadj6+rgyY0+L0+
        M9zosBrA4ZiDKkkc2cJpUyVMTazThb+wAHTcZQAwVBLeZ8WIMB2VU2l/AvIbL3mCFfbwmboOheMLB
        CR84Y8qqV71gzp8/Dmp5gPK0vWVNHVqiEfGsCojtfL3VtgtbT1NSpzqKc69Vg6MZCuhm5yNdBcN2N
        ZQ9oA/7wyc0eExwz/DF8/AvxuAvT5lt7HWPvyg30ICRuQCQdXPHjZMCIy5mCeebVhfY8FUSDGCn6y
        cFo3O5qPhsvsDmtSwLLXPHap/3XDgXazzEAHU3m2L/dOhvQ2zaDS6i+Vvr5c9C/eU2/78olGxe2CZ
        aZMYAoYg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQWL-004Yi4-V5; Tue, 07 Jun 2022 04:08:46 +0000
Date:   Tue, 7 Jun 2022 04:08:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC][PATCHES] iov_iter stuff
Message-ID: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Rebased to -rc1 and reordered.  Sits in vfs.git #work.iov_iter,
individual patches in followups

1/9: No need of likely/unlikely on calls of check_copy_size()
	not just in uio.h; the thing is inlined and it has unlikely on
all paths leading to return false

2/9: btrfs_direct_write(): cleaner way to handle generic_write_sync() suppression
	new flag for iomap_dio_rw(), telling it to suppress generic_write_sync()

3/9: struct file: use anonymous union member for rcuhead and llist
	"f_u" might have been an amusing name, but... we expect anon unions to
work.

4/9: iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
	makes iocb_flags() much cheaper, and it's easier to keep track of
the places where it can change.

5/9: keep iocb_flags() result cached in struct file
	that, along with the previous commit, reduces the overhead of
new_sync_{read,write}().  struct file doesn't grow - we can keep that
thing in the same anon union where rcuhead and llist live; that field
gets used only before ->f_count reaches zero while the other two are
used only after ->f_count has reached zero.

6/9: copy_page_{to,from}_iter(): switch iovec variants to generic
	kmap_local_page() allows that.  And it kills quite a bit of
code.

7/9: new iov_iter flavour - ITER_UBUF
	iovec analogue, with single segment.  That case is fairly common and it
can be handled with less overhead than full-blown iovec.

8/9: switch new_sync_{read,write}() to ITER_UBUF
	... and this is why it is so common.  Further reduction of overhead
for new_sync_{read,write}().

9/9: iov_iter_bvec_advance(): don't bother with bvec_iter
	AFAICS, variant similar to what we do for iovec/kvec generates better
code.  Needs profiling, obviously.

Diffstat:
 arch/powerpc/include/asm/uaccess.h |   2 +-
 arch/s390/include/asm/uaccess.h    |   4 +-
 block/fops.c                       |   8 +-
 drivers/nvme/target/io-cmd-file.c  |   2 +-
 fs/aio.c                           |   2 +-
 fs/btrfs/file.c                    |  19 +--
 fs/btrfs/inode.c                   |   2 +-
 fs/ceph/file.c                     |   2 +-
 fs/cifs/file.c                     |   2 +-
 fs/direct-io.c                     |   4 +-
 fs/fcntl.c                         |   1 +
 fs/file_table.c                    |  17 +-
 fs/fuse/dev.c                      |   4 +-
 fs/fuse/file.c                     |   4 +-
 fs/gfs2/file.c                     |   2 +-
 fs/io_uring.c                      |   2 +-
 fs/iomap/direct-io.c               |  24 +--
 fs/nfs/direct.c                    |   2 +-
 fs/open.c                          |   1 +
 fs/read_write.c                    |   6 +-
 fs/zonefs/super.c                  |   2 +-
 include/linux/fs.h                 |  21 ++-
 include/linux/iomap.h              |   2 +
 include/linux/uaccess.h            |   4 +-
 include/linux/uio.h                |  41 +++--
 lib/iov_iter.c                     | 308 +++++++++++--------------------------
 mm/shmem.c                         |   2 +-
 27 files changed, 191 insertions(+), 299 deletions(-)
