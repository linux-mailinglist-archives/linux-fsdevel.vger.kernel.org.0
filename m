Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615B6600CFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJQK5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJQK5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1845C9D7;
        Mon, 17 Oct 2022 03:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0D66103A;
        Mon, 17 Oct 2022 10:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F241C433C1;
        Mon, 17 Oct 2022 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666004233;
        bh=6YT8a4bXoeXs8XCfVDx3M0Me+DkkbCjCyiu7tCiJL+s=;
        h=From:To:Cc:Subject:Date:From;
        b=Gj7zxfDuAX7XjOBrXuruhtxnquTTTafw/403MMHjD9isqBeJP2M9YniIOu5CZ1rHj
         urP61o2T+SVbkLdDx4Kd4xuw55ioynZlC4Lts975BLgtdZjhxrBrXpWc907xShB3RC
         2ZtNUB7vJ3PGARKYGkDXHUC8mlqaFGHy/HCM1lXgkJYGBdj96W0XXcWMLrWc4m1lFy
         uriZS+qEWlw2JfLC10mtBf4dpwQp2BpxhMSFxWgOepFJiQxd3HvBBFvhpJSHu3/Osg
         XvQn8aLxzoFoN6LtpkL6PD5Y3unGQ4WVbpFaN7RMDEA+ldANE+GjmmbKMMjYkCMBnr
         9I+ZFiT+pBJSA==
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
Subject: [PATCH v7 0/9] fs: clean up handling of i_version counter
Date:   Mon, 17 Oct 2022 06:57:00 -0400
Message-Id: <20221017105709.10830-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is intended to clean up the handling of the i_version
counter by nfsd. Most of the changes are to internal interfaces.

This set is not intended to address crash resilience, or the fact that
the counter is bumped before a change and not after. I intend to tackle
those in follow-on patchsets.

My intention is to get this series included into linux-next soon, with
an eye toward merging most of it during the v6.2 merge window. The last
patch in the series is probably not suitable for merge as-is, at least
until we sort out the semantics we want to present to userland for it.

Jeff Layton (9):
  fs: uninline inode_query_iversion
  fs: clarify when the i_version counter must be updated
  vfs: plumb i_version handling into struct kstat
  nfs: report the inode version in getattr if requested
  ceph: report the inode version in getattr if requested
  nfsd: move nfsd4_change_attribute to nfsfh.c
  nfsd: use the getattr operation to fetch i_version
  nfsd: remove fetch_iversion export operation
  vfs: expose STATX_VERSION to userland

 fs/ceph/inode.c           | 16 +++++++----
 fs/libfs.c                | 36 ++++++++++++++++++++++++
 fs/nfs/export.c           |  7 -----
 fs/nfs/inode.c            | 15 +++++++---
 fs/nfsd/nfs4xdr.c         |  4 ++-
 fs/nfsd/nfsfh.c           | 42 ++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h           | 29 +-------------------
 fs/nfsd/vfs.h             |  7 ++++-
 fs/stat.c                 |  7 +++++
 include/linux/exportfs.h  |  1 -
 include/linux/iversion.h  | 58 ++++++++++++++-------------------------
 include/linux/stat.h      |  2 +-
 include/uapi/linux/stat.h |  6 ++--
 samples/vfs/test-statx.c  |  8 ++++--
 14 files changed, 148 insertions(+), 90 deletions(-)

-- 
2.37.3

