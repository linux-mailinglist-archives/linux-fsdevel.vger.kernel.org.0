Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6876288DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 20:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiKNTET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 14:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiKNTEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:04:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A8233B7;
        Mon, 14 Nov 2022 11:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811F8B811F9;
        Mon, 14 Nov 2022 19:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C728C4314C;
        Mon, 14 Nov 2022 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668452650;
        bh=nUqWfCtlmYqBNGi7ej8f7+iT+7NVUJryQtiHW8JZp8g=;
        h=Date:From:To:Subject:From;
        b=vFo7XEPo2+cW1fI2eH6sar2bhJ75JmjlaAOxdxRj9rkZU8C7XxLrpHf8oGdgJhFDK
         ZW43ygrpL10nFJc0ncaER2Nlq7aDc1MMUTfRDNQD/HUYu8cUS9D6MPOxAPFeOOTFIy
         HCk7fMvA5XHE8S9ykdgSbmKzc7rNJRuKRZK8XhByzsrB75wkzyWiw4sbPMGJo5syK6
         Z9nN1Gwx4n32VPSRq8Ncb5NRkBiV5izYIPjvS7SSYH/fQw8GzXspw278GitTs1KBYT
         /K1T3K933tmG38iiHyDSr/f2LoNJ2dgtZ3Xb9WYkdtHbUBTFR88rjIO+eNBs9wU37x
         1ZTz0VvvmJiWw==
Date:   Mon, 14 Nov 2022 11:04:09 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: for-next updated to eab06d36b0ac
Message-ID: <Y3KRKa7YeJZ+bYdg@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  There's a number of fix patches still out for review:

Also, I've noticed a new corruption problem that only seems to manifest
on arm64, wherein every now and then the incore extent tree records
become out of order, which causes xfs_repair failures afterwards.  I've
not figured out what's going on there, and I can only seem to reproduce
it on the VM that runs the online scrub stress tests.

There's also Dave's write()/writeback race bugfixes, which I resent with
some extra cleanups and bugfixes:
https://lore.kernel.org/linux-xfs/166801774453.3992140.241667783932550826.stgit@magnolia/T/#t

There are also a few other fixes that I'll try to get to this week...

There's also the problem that dax+reflink throw weird corruption errors
everywhere.  I don't know what the status of those are, and I still
don't have time to get to them. :/

The new head of the for-next branch is commit:

eab06d36b0ac xfs: Print XFS UUID on mount and umount events.

23 new commits:

Darrick J. Wong (21):
      [d9edd4209c00] xfs: fully initialize xfs_da_args in xchk_directory_blocks
      [41ed0096fe28] xfs: don't track the AGFL buffer in the scrub AG context
      [b6fe5ce07044] xfs: log the AGI/AGF buffers when rolling transactions during an AG repair
      [e11cbc59fc47] xfs: make AGFL repair function avoid crosslinked blocks
      [f0609db1e65d] xfs: standardize GFP flags usage in online scrub
      [3e561e5d9e9e] xfs: initialize the check_owner object fully
      [b0a3c53255a9] xfs: pivot online scrub away from kmem.[ch]
      [d2bf05bbc2e0] xfs: return EINTR when a fatal signal terminates scrub
      [5440e1f2553c] xfs: fix return code when fatal signal encountered during dquot scrub
      [d7a74d930c33] xfs: don't retry repairs harder when EAGAIN is returned
      [c946cf092eda] xfs: load rtbitmap and rtsummary extent mapping btrees at mount time
      [5be117cd8462] xfs: make rtbitmap ILOCKing consistent when scanning the rt bitmap file
      [929b24984cf5] xfs: skip fscounters comparisons when the scan is incomplete
      [eabd0e965710] xfs: online checking of the free rt extent count
      [64b1fd1cb7ae] xfs: fix perag loop in xchk_bmap_check_rmaps
      [4898b3d4d18f] xfs: teach scrub to check for adjacent bmaps when rmap larger than bmap
      [58dab0d4cfe3] xfs: block map scrub should handle incore delalloc reservations
      [340e2a33cf17] xfs: check quota files for unwritten extents
      [433b8bbe35d4] xfs: check that CoW fork extents are not shared
      [1064c4c1de60] xfs: teach scrub to flag non-extents format cow forks
      [4f7fc3981aaf] xfs: fix incorrect error-out in xfs_remove

Long Li (1):
      [7cecd500d901] xfs: fix sb write verify for lazysbcount

Lukas Herbolt (1):
      [eab06d36b0ac] xfs: Print XFS UUID on mount and umount events.

Code Diffstat:

 fs/xfs/libxfs/xfs_sb.c         |   4 +-
 fs/xfs/scrub/agheader.c        |  47 ++++++++-----
 fs/xfs/scrub/agheader_repair.c |  81 +++++++++++++++++++----
 fs/xfs/scrub/attr.c            |  11 ++-
 fs/xfs/scrub/bitmap.c          |  11 +--
 fs/xfs/scrub/bmap.c            | 147 +++++++++++++++++++++++++++++++++--------
 fs/xfs/scrub/btree.c           |  14 ++--
 fs/xfs/scrub/common.c          |   8 ---
 fs/xfs/scrub/common.h          |   2 +-
 fs/xfs/scrub/dabtree.c         |   4 +-
 fs/xfs/scrub/dir.c             |  10 +--
 fs/xfs/scrub/fscounters.c      | 109 ++++++++++++++++++++++++++++--
 fs/xfs/scrub/quota.c           |   8 ++-
 fs/xfs/scrub/refcount.c        |  12 ++--
 fs/xfs/scrub/repair.c          |  47 ++++++++-----
 fs/xfs/scrub/scrub.c           |   6 +-
 fs/xfs/scrub/scrub.h           |  18 ++---
 fs/xfs/scrub/symlink.c         |   2 +-
 fs/xfs/xfs_fsmap.c             |   4 +-
 fs/xfs/xfs_inode.c             |   2 +-
 fs/xfs/xfs_log.c               |  10 +--
 fs/xfs/xfs_mount.c             |  15 +++++
 fs/xfs/xfs_rtalloc.c           |  60 +++++++++++++++--
 fs/xfs/xfs_super.c             |   2 +-
 24 files changed, 486 insertions(+), 148 deletions(-)
