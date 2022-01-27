Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17DF49D827
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiA0CrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:47:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiA0CrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:47:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB2D621905;
        Thu, 27 Jan 2022 02:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643251625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yDPdolIqP1BqbqmgH35S+RrYDCrJz/kAXtj6i96pLsQ=;
        b=hAN5Dg0REL/K5jKsVHYqM3X+M7oL7DolmPiPn5nkKXAbr4U3cj5oAi65hMwxiSWo27QmOB
        cLQTty8i2cI986CYr180STDwieVyetu7kQ3qHdYo7SeahuPrc14qirLFBA73zPbrr4po2f
        zGgWZWBXgqAPi8k0xRaMTCQlkN1djpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643251625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yDPdolIqP1BqbqmgH35S+RrYDCrJz/kAXtj6i96pLsQ=;
        b=x6ydMXUFPK4DvzDKO6csSNrS9nejdxdCvtHG4Sf6wjFPHRmP2fhorasjEjQ6+4R4FunEK1
        J47b6RQj8pZ6MXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E280813E46;
        Thu, 27 Jan 2022 02:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d+tYJ6IH8mGjKwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 02:46:58 +0000
Subject: [PATCH 0/9] Remove remaining parts of congestions tracking code.
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 27 Jan 2022 13:46:29 +1100
Message-ID: <164325106958.29787.4865219843242892726.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Congestion hasn't been reliably tracked for quite some time.
Most MM uses of it for guiding writeback decisions were removed in 5.16.
Some other uses were removed in 17-rc1.

This series removes the remaining places that test for congestion, and
the few places which still set it.

The second patch touches a few filesystems.  I didn't think there was
much value in splitting this out by filesystems, but if maintainers
would rather I did that, I will.

The f2fs, cephfs, fuse, NFS, and block patches can go through the
respective trees proving the final patch doesn't land until after they
all do - so maybe it should be held for 5.18-rc2 if all the rest lands
by 5.18-rc1.

Thanks,
NeilBrown

---

NeilBrown (9):
      Remove inode_congested()
      Remove bdi_congested() and wb_congested() and related functions
      f2fs: change retry waiting for f2fs_write_single_data_page()
      f2f2: replace some congestion_wait() calls with io_schedule_timeout()
      cephfs: don't set/clear bdi_congestion
      fuse: don't set/clear bdi_congested
      NFS: remove congestion control.
      block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"
      Remove congestion tracking framework.


 block/bfq-iosched.c              |  2 +-
 drivers/block/drbd/drbd_int.h    |  3 --
 drivers/block/drbd/drbd_req.c    |  3 +-
 fs/ceph/addr.c                   | 27 ---------------
 fs/ceph/super.c                  |  2 --
 fs/ceph/super.h                  |  2 --
 fs/ext2/ialloc.c                 |  2 --
 fs/f2fs/compress.c               |  6 ++--
 fs/f2fs/data.c                   |  9 +++--
 fs/f2fs/segment.c                | 14 ++++----
 fs/f2fs/super.c                  |  8 ++---
 fs/fuse/control.c                | 17 ----------
 fs/fuse/dev.c                    |  8 -----
 fs/nfs/sysctl.c                  |  7 ----
 fs/nfs/write.c                   | 53 +----------------------------
 fs/nilfs2/segbuf.c               | 11 ------
 fs/xfs/xfs_buf.c                 |  3 --
 include/linux/backing-dev-defs.h |  8 -----
 include/linux/backing-dev.h      | 28 ----------------
 include/linux/nfs_fs.h           |  1 -
 include/linux/nfs_fs_sb.h        |  1 -
 include/trace/events/writeback.h | 28 ----------------
 mm/backing-dev.c                 | 57 --------------------------------
 mm/vmscan.c                      |  4 +--
 24 files changed, 25 insertions(+), 279 deletions(-)

--
Signature

