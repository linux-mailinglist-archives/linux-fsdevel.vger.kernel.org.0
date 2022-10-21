Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA3607791
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJUNGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJUNGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:06:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A926B4AE;
        Fri, 21 Oct 2022 06:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7024CE2AB5;
        Fri, 21 Oct 2022 13:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DCBC433C1;
        Fri, 21 Oct 2022 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357565;
        bh=WAuTFW3O+DY8MVhZwhFFkTH4TiFW9rYutffTWkjHS1o=;
        h=From:To:Cc:Subject:Date:From;
        b=iufBETIxL2UBu1twVnFCO0KsIKfIO8XexyQpAyERQJ2FVgGV6YUxADauBUZpucT1V
         V1Pp5MGo0KE9itLR+J4QHsdEzaduvnc38rL0dE4eS2EaOVJB5MyHwLNGuMitP7ihC4
         VZMkhKv9hRGVB5GFNdVW2fjPzEpigGMZMgyv1XGQXIhfDs+sOswdKR3nQvlwXg9zGV
         gHxhx32GOxYuBz7UDuetQt2Agbs+dLEs7qIrQmiJKzxLP62nVZwMd32ANMFecLDCjL
         Mp+PF0MthMctfI2Tve2DGDiX9OTdwZ50fSkj3cVUI4rX8aubR0mdDLTOfNY9JOJJNe
         BHhmtzv/ojRUw==
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
Subject: [PATCH v8 0/8] fs: clean up internal i_version handling
Date:   Fri, 21 Oct 2022 09:05:54 -0400
Message-Id: <20221021130602.99099-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The main consumer of i_version field (knfsd) has to jump through a
number of hoops to fetch it, depending on what sort of inode it is.
Rather than do this, we want to offload the responsibility for
presenting this field to the filesystem's ->getattr operation, which is
a more natural way to deal with a field that may be implemented
differently.

The focus of this patchset is to clean up these internal interfaces.
This should also make it simple to present this attribute to userland in
the future, which should be possible once the semantics are a bit more
consistent across different backing filesystems.

The change are fairly small, but they cross several subsystems. I'd
appreciate R-b's and A-b's from maintainers whose subsystems I'm
touching (Chuck, Al, Trond, and Xiubo in particular).

For now, I'm leaving out more siginificant behavioral changes to
i_version handling so that we can keep the focus on this set rather
narrow. The next stap is to get this into linux-next with an aim toward
merge in v6.2.

Thanks!

Jeff Layton (8):
  fs: uninline inode_query_iversion
  fs: clarify when the i_version counter must be updated
  vfs: plumb i_version handling into struct kstat
  nfs: report the inode version in getattr if requested
  ceph: report the inode version in getattr if requested
  nfsd: move nfsd4_change_attribute to nfsfh.c
  nfsd: use the getattr operation to fetch i_version
  nfsd: remove fetch_iversion export operation

 fs/ceph/inode.c          | 16 +++++++----
 fs/libfs.c               | 36 +++++++++++++++++++++++++
 fs/nfs/export.c          |  7 -----
 fs/nfs/inode.c           | 16 ++++++++---
 fs/nfsd/nfs4xdr.c        |  4 ++-
 fs/nfsd/nfsfh.c          | 42 +++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h          | 29 +-------------------
 fs/nfsd/vfs.h            |  7 ++++-
 fs/stat.c                | 17 ++++++++++--
 include/linux/exportfs.h |  1 -
 include/linux/iversion.h | 58 ++++++++++++++--------------------------
 include/linux/stat.h     |  9 +++++++
 12 files changed, 155 insertions(+), 87 deletions(-)

-- 
2.37.3

