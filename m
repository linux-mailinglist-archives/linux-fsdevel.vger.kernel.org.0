Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE77414D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjF1PXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjF1PXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:23:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1334C268E
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 08:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C754C21847;
        Wed, 28 Jun 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687965794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=7pwIpdQMWlxYQjRr+HZket7lPeD42uyNEejjRu0feXU=;
        b=NN0D1TU70fZFecE0sJE+24O0FVLOpw0GngEK/90FORGpWh6kz4QVxyPLfpe6Fw/Oy+xquY
        7hUtxg8PKQMBVT2nqTxBVYKVFaA6PTP0ykdt+LZOmmG86r2J+XdbvBWkBLO1OzoqhWRItO
        8KswH/QtX+vbWKcO8OUF3yse5bwLyzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687965794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=7pwIpdQMWlxYQjRr+HZket7lPeD42uyNEejjRu0feXU=;
        b=GF5Ma3P2LGC4yvvenh1XnsjjFc4xIQPjWW/RTy2T5ZLoQ6AEiMN5m1QqZ7jHgTdL5yunR4
        tisaaRB6BIbtHICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD137138E8;
        Wed, 28 Jun 2023 15:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i2Y6KmJQnGQ2PAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 15:23:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 41767A0707; Wed, 28 Jun 2023 17:23:14 +0200 (CEST)
Date:   Wed, 28 Jun 2023 17:23:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Filesystem fixes for 6.5-rc1
Message-ID: <20230628152314.ynd5xt4ip3zk53go@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.5-rc1

to get:
* Rewrite of kmap_local() handling in ext2
* Conversion of ext2 direct IO path to iomap (with some infrastructure
  tweaks associated with that)
* Conversion of two boilerplate licenses in udf to SPDX identifiers
* Other small udf, ext2, and quota fixes and cleanups

Top of the tree is 028f6055c912. The full shortlog is:

Al Viro (6):
      ext2_rename(): set_link and delete_entry may fail
      ext2: use offset_in_page() instead of open-coding it as subtraction
      ext2_get_page(): saner type
      ext2_put_page(): accept any pointer within the page
      ext2_{set_link,delete_entry}(): don't bother with page_addr
      ext2_find_entry()/ext2_dotdot(): callers don't need page_addr anymore

Bagas Sanjaya (2):
      fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX identifier
      fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier

Jan Kara (4):
      fs: Drop wait_unfrozen wait queue
      quota: Properly disable quotas when add_dquot_ref() fails
      ext2: Drop fragment support
      udf: Fix uninitialized array access for some pathnames

Ritesh Harjani (IBM) (6):
      ext2/dax: Fix ext2_setsize when len is page aligned
      fs/buffer.c: Add generic_buffers_fsync*() implementation
      ext4: Use generic_buffers_fsync_noflush() implementation
      ext2: Use generic_buffers_fsync() implementation
      ext2: Move direct-io to use iomap
      ext2: Add direct-io trace points

Ye Bin (1):
      quota: fix warning in dqgrab()

The diffstat is

 fs/buffer.c                 |  70 +++++++++++++++++++++++
 fs/ext2/Makefile            |   5 +-
 fs/ext2/dir.c               | 136 +++++++++++++++++++-------------------------
 fs/ext2/ext2.h              |  23 ++------
 fs/ext2/file.c              | 126 +++++++++++++++++++++++++++++++++++++++-
 fs/ext2/inode.c             |  58 ++++++++++++-------
 fs/ext2/namei.c             |  63 ++++++++------------
 fs/ext2/super.c             |  23 ++------
 fs/ext2/trace.c             |   6 ++
 fs/ext2/trace.h             |  94 ++++++++++++++++++++++++++++++
 fs/ext4/fsync.c             |  33 ++++++-----
 fs/quota/dquot.c            |   5 +-
 fs/quota/quota.c            |   5 +-
 fs/super.c                  |   4 --
 fs/udf/balloc.c             |   6 +-
 fs/udf/dir.c                |   6 +-
 fs/udf/directory.c          |   6 +-
 fs/udf/file.c               |   6 +-
 fs/udf/ialloc.c             |   6 +-
 fs/udf/inode.c              |   6 +-
 fs/udf/lowlevel.c           |   6 +-
 fs/udf/misc.c               |   6 +-
 fs/udf/namei.c              |   6 +-
 fs/udf/partition.c          |   6 +-
 fs/udf/super.c              |   6 +-
 fs/udf/symlink.c            |   6 +-
 fs/udf/truncate.c           |   6 +-
 fs/udf/udftime.c            |  18 +-----
 fs/udf/unicode.c            |   8 +--
 include/linux/buffer_head.h |   4 ++
 include/linux/fs.h          |   1 -
 31 files changed, 469 insertions(+), 291 deletions(-)
 create mode 100644 fs/ext2/trace.c
 create mode 100644 fs/ext2/trace.h

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
