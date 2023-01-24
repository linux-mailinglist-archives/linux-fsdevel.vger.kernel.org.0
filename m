Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB167A2B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjAXTae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjAXTad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:30:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5614DBDC;
        Tue, 24 Jan 2023 11:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23866132C;
        Tue, 24 Jan 2023 19:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C702C433EF;
        Tue, 24 Jan 2023 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588629;
        bh=vp0vqry2/AY0zb9xuGn4mOcoj9OvZ/inpse2FNVpqBI=;
        h=From:To:Cc:Subject:Date:From;
        b=Oq1fgOAvloQhlKFMsUavNC5pfqfY+THTTPrx5v8fc8B/UiuEChO4F4Ko8COr+On1Z
         nwj3yF3nKBIIdXf8ovX6RRVvFfV3kTuyLA+rGZCxRzNiRWHpQT2Nl3Vr5MJDPw2p9B
         vvzFgOJBXMYg7ARNBK7bvQblMMhqZHBRJKRVEg8A4unGw0qmIbSFLfyq14bYKhdaFk
         bQqYGnaccCUoQ0dyCv0zAs8Zdbaqw41mt3wgK2mbnnY0EGhtA5D9OVcOR4Bs03VgRN
         44MUutfnQgaDajRpEHQjS7oGw8anySs8tLBtiyUFU58t6GNz0yp2NVR9IvrMiLOo89
         1kcsW3Ky8XpQA==
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
Subject: [PATCH v8 RESEND 0/8] fs: clean up internal i_version handling
Date:   Tue, 24 Jan 2023 14:30:17 -0500
Message-Id: <20230124193025.185781-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I had inteded to send a PR for this for v6.2, but I got sidetracked
with different issues, and didn't get it together in time. This set has
been sitting in linux-next since October, and it seems to be behaving,
so I intend to send a PR when the v6.3 merge window opens.

Though nothing has really changed since last year, I'm resending now
in the hopes I can collect a few more Reviewed-bys (ones from Al, Trond
and Anna would be particularly welcome).

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
 fs/libfs.c               | 36 ++++++++++++++++++++++++
 fs/nfs/export.c          |  7 -----
 fs/nfs/inode.c           | 16 ++++++++---
 fs/nfsd/nfs4xdr.c        |  4 ++-
 fs/nfsd/nfsfh.c          | 42 ++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h          | 29 +-------------------
 fs/nfsd/vfs.h            |  7 ++++-
 fs/stat.c                | 17 ++++++++++--
 include/linux/exportfs.h |  1 -
 include/linux/iversion.h | 59 ++++++++++++++--------------------------
 include/linux/stat.h     |  9 ++++++
 12 files changed, 156 insertions(+), 87 deletions(-)

-- 
2.39.1

