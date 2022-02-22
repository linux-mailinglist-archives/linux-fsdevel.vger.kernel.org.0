Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF20E4BF058
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 05:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiBVDSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 22:18:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiBVDSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:18:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2908F73;
        Mon, 21 Feb 2022 19:17:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FB2C210FF;
        Tue, 22 Feb 2022 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645499870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GhZHme0nl7A4JBQ0S74qk0HiW5RevCCShdffmTtXtEE=;
        b=ljl5hpqnn8XItaz2pgS0/dFbp8Or7nFEcXyK3PPQX3y1pOij2ACiitVFo1ZW1KHULTSA32
        YPbDwlZKpapBzbobU/O0VXr6WOOcd4WDNGQESKT4qQihx0Fj189ZP5Cn2KjOfrjZWle1nr
        sSBZtznZf5z+aAaHk0OnFJ6IwVJ/iwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645499870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GhZHme0nl7A4JBQ0S74qk0HiW5RevCCShdffmTtXtEE=;
        b=ZXJr3TPlVf5poY4reMjaSwIa54LBqaPVcDT+//ErMovmrjU1PnyR6RQJgfl+heyxghO0fc
        BsR4trFirlMhFPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 323C613BA7;
        Tue, 22 Feb 2022 03:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6vPPN9VVFGJPWgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 22 Feb 2022 03:17:41 +0000
Subject: [PATCH 00/11]  Remove remaining parts of congestion tracking code.
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
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
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Feb 2022 14:17:17 +1100
Message-ID: <164549971112.9187.16871723439770288255.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is another refresh of my "remove congestion tracking" series.

I removed the small tweaks to read-ahead code because they raised
questions and are actually required for this series.

Everything else is the same.

Andrew: please drop the version of this that is currently in your tree
even if you don't take this.  The changes to fuse/nfs/ceph are not
appropriate and I wouldn't want them to land by mistake.

Thanks,
NeilBrown

---

NeilBrown (11):
      DOC: convert 'subsection' to 'section' in gfp.h
      MM: document and polish read-ahead code.
      MM: improve cleanup when ->readpages doesn't process all pages.
      fuse: remove reliance on bdi congestion
      nfs: remove reliance on bdi congestion
      ceph: remove reliance on bdi congestion
      Remove inode_congested()
      Remove bdi_congested() and wb_congested() and related functions
      f2fs: replace congestion_wait() calls with io_schedule_timeout()
      block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"
      Remove congestion tracking framework.


 Documentation/core-api/mm-api.rst |  19 ++++-
 Documentation/filesystems/vfs.rst |  16 ++--
 block/bfq-iosched.c               |   2 +-
 drivers/block/drbd/drbd_int.h     |   3 -
 drivers/block/drbd/drbd_req.c     |   3 +-
 fs/ceph/addr.c                    |  22 +++---
 fs/ceph/super.c                   |   1 +
 fs/ceph/super.h                   |   1 +
 fs/ext2/ialloc.c                  |   5 --
 fs/f2fs/compress.c                |   4 +-
 fs/f2fs/data.c                    |   3 +-
 fs/f2fs/f2fs.h                    |   6 ++
 fs/f2fs/segment.c                 |   8 +-
 fs/f2fs/super.c                   |   6 +-
 fs/fs-writeback.c                 |  37 ---------
 fs/fuse/control.c                 |  17 -----
 fs/fuse/dev.c                     |   8 --
 fs/fuse/file.c                    |  17 +++++
 fs/nfs/write.c                    |  14 +++-
 fs/nilfs2/segbuf.c                |  15 ----
 fs/xfs/xfs_buf.c                  |   3 -
 include/linux/backing-dev-defs.h  |   8 --
 include/linux/backing-dev.h       |  50 ------------
 include/linux/fs.h                |   9 ++-
 include/linux/nfs_fs_sb.h         |   1 +
 include/trace/events/writeback.h  |  28 -------
 mm/backing-dev.c                  |  57 --------------
 mm/fadvise.c                      |   5 +-
 mm/readahead.c                    | 122 ++++++++++++++++++++++++++++--
 mm/vmscan.c                       |  21 +----
 30 files changed, 212 insertions(+), 299 deletions(-)

--
Signature

