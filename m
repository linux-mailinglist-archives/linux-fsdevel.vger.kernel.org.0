Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7375F0A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiI3L04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiI3L02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC56FAEA;
        Fri, 30 Sep 2022 04:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC356B827AA;
        Fri, 30 Sep 2022 11:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5374EC433C1;
        Fri, 30 Sep 2022 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536724;
        bh=qW5czRWn4GLiEtwmzJqFOMVb5w3oIFlZuNEbzaPShnI=;
        h=From:To:Cc:Subject:Date:From;
        b=qclGvuAaez5oX3gT5MUceMEYs9CNEX5R4R1bJF3WZ+L0+aYeWJ84DC5WTsT2xi8ia
         U6cqxRjw80Txiw9vnu1hf973zEHsjPBWdl8q8vj7PSw8GbhVSfgi/4a5NVCGKZOFIU
         BpT/1wGxzvsMtbjFGbXSIjk1VDdol6BqOFBhGa/z+KyWOLCN3krK9RFIpF/7dg0cLx
         p6ye45BNLcd1z55bJMnBvTPVQcy4ZQA0nChO3ZKY63MmuWekHHjZTQnp5zC7tNugQh
         FNt3Gv9RE0QvUuoMNl57bfwV9VVo6BLFr0yJH7M/cCMBzImSL2XuPSc1fpR8Xthb0H
         z2UeJq0yMeptA==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 0/9] vfs/nfsd: clean up handling of i_version counter
Date:   Fri, 30 Sep 2022 07:18:31 -0400
Message-Id: <20220930111840.10695-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v6: add support for STATX_ATTR_VERSION_MONOTONIC
    add patch to expose i_version counter to userland
    patches to update times/version after copying write data

An updated set of i_version handling changes! I've dropped the earlier
ext4 patches since Ted has picked up the relevant ext4 ones.

This set is based on linux-next, to make sure we don't collide with the
statx DIO alignment patches, and some other i_version cleanups that are
in flight.  I'm hoping those land in 6.1.

There are a few changes since v5, mostly centered around adding
STATX_ATTR_VERSION_MONOTONIC. I've also re-added the patch to expose
STATX_VERSION to userland via statx. What I'm proposing should now
(mostly) conform to the semantics I layed out in the manpage patch I
sent recently [1].

Finally, I've added two patches to make __generic_file_write_iter and
ext4 update the c/mtime after copying file data instead of before, which
Neil pointed out makes for better cache-coherency handling. Those should
take care of ext4 and tmpfs. xfs and btrfs will need to make the same
changes.

One thing I'm not sure of is what we should do if update_times fails
after an otherwise successful write. Should we just ignore that and move
on (and maybe WARN)? Return an error? Set a writeback error? What's the
right recourse there?

I'd like to go ahead and get the first 6 patches from this series into
linux-next fairly soon, so if anyone has objections, please speak up!

[1]: https://lore.kernel.org/linux-nfs/20220928134200.28741-1-jlayton@kernel.org/T/#u

Jeff Layton (9):
  iversion: move inode_query_iversion to libfs.c
  iversion: clarify when the i_version counter must be updated
  vfs: plumb i_version handling into struct kstat
  nfs: report the inode version in getattr if requested
  ceph: report the inode version in getattr if requested
  nfsd: use the getattr operation to fetch i_version
  vfs: expose STATX_VERSION to userland
  vfs: update times after copying data in __generic_file_write_iter
  ext4: update times after I/O in write codepaths

 fs/ceph/inode.c           | 16 +++++++++----
 fs/ext4/file.c            | 20 +++++++++++++---
 fs/libfs.c                | 36 +++++++++++++++++++++++++++++
 fs/nfs/export.c           |  7 ------
 fs/nfs/inode.c            | 10 ++++++--
 fs/nfsd/nfs4xdr.c         |  4 +++-
 fs/nfsd/nfsfh.c           | 40 ++++++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h           | 29 +----------------------
 fs/nfsd/vfs.h             |  7 +++++-
 fs/stat.c                 |  7 ++++++
 include/linux/exportfs.h  |  1 -
 include/linux/iversion.h  | 48 ++++++++-------------------------------
 include/linux/stat.h      |  2 +-
 include/uapi/linux/stat.h |  6 +++--
 mm/filemap.c              | 17 ++++++++++----
 samples/vfs/test-statx.c  |  8 +++++--
 16 files changed, 163 insertions(+), 95 deletions(-)

-- 
2.37.3

