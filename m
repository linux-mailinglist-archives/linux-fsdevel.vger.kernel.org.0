Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B325B02F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 13:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIGLdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 07:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIGLdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A5B655A;
        Wed,  7 Sep 2022 04:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84DBE61877;
        Wed,  7 Sep 2022 11:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE89EC433C1;
        Wed,  7 Sep 2022 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662550401;
        bh=eSN0n/IkID6iu50PBYm3RnaU+v/IM0jwWYB5a53uu8A=;
        h=From:To:Cc:Subject:Date:From;
        b=KSZwkZYZKBPuaxafmBZ5aO+76Tj8qkHBYFfpn0bweyu2Z1gJs8uKq8iYLK3XXH61K
         F4tJdMCoRXbhHS2LmfmKO+SIKgCFb/Xmt6yblXQr/jsU6sCZC4aWcr+M1FL+hKJJ4o
         YGHDZEQG6355vKfHOPUwfzyyTc+2N5fxTkOmYQRN77myZ8Qq0rI346dmZTA+4ugmFl
         03Qv1l8A8nQs+Xu02m4ftOvN2ElhaKQR0PmmRoMWNAZ3M/h8u06TnQ6OsydXWEkEaZ
         QdkFkcBb4NgoexVOR9chiCpEnk0qW6Mo+1eDSp48yejY4Sb7LWNdCbDMv9umt3llZZ
         hGH83NZLnLOoQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 0/6] vfs: clean up i_version behavior and expose it via statx
Date:   Wed,  7 Sep 2022 07:33:12 -0400
Message-Id: <20220907113318.21810-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v4: drop xfs patch
    revise comment update patch with latest proposed semantics

This is a small revision to the patchset I sent a little over a week
ago [1]. Since then, this has also garnered a LWN article [2], so I
won't go into great detail on the basic premise and rationale.

The biggest change here is that I've dropped the xfs patch. Dave Chinner
stated that they'd need to add a new on-disk field instead of modifying
the behavior of the existing di_changecount field [3]. I'll leave that
to the xfs devs, but this does mean that xfs will have "buggy" behavior
until that's done.

I've also sent a revised manpage patchset separately to make sure that
the semantics are acceptable [4]. That hasn't gotten a lot of comments,
so I'm operating under the assumption that the semantics proposed there
are acceptable to most.

[1]: https://lore.kernel.org/linux-nfs/20220826214703.134870-1-jlayton@kernel.org/
[2]: https://lwn.net/Articles/905931/
[3]: https://lore.kernel.org/linux-nfs/20220830000851.GV3600936@dread.disaster.area/
[4]: https://lore.kernel.org/linux-nfs/20220907111606.18831-1-jlayton@kernel.org/T/#u

Jeff Layton (6):
  iversion: update comments with info about atime updates
  ext4: fix i_version handling in ext4
  ext4: unconditionally enable the i_version counter
  vfs: report an inode version in statx for IS_I_VERSION inodes
  nfs: report the inode version in statx if requested
  ceph: fill in the change attribute in statx requests

 fs/ceph/inode.c           | 14 +++++++++-----
 fs/ext4/inode.c           | 15 +++++----------
 fs/ext4/ioctl.c           |  4 ++++
 fs/ext4/move_extent.c     |  6 ++++++
 fs/ext4/super.c           | 13 ++++---------
 fs/ext4/xattr.c           |  1 +
 fs/nfs/inode.c            |  7 +++++--
 fs/stat.c                 |  7 +++++++
 include/linux/iversion.h  | 10 ++++++++--
 include/linux/stat.h      |  1 +
 include/uapi/linux/stat.h |  3 ++-
 samples/vfs/test-statx.c  |  8 ++++++--
 12 files changed, 58 insertions(+), 31 deletions(-)

-- 
2.37.3

