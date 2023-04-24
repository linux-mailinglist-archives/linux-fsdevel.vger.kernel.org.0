Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62036ED0FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjDXPLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 11:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjDXPLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65D1708;
        Mon, 24 Apr 2023 08:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 090A8625E1;
        Mon, 24 Apr 2023 15:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CBCC433D2;
        Mon, 24 Apr 2023 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682349068;
        bh=BFICM1CCZSEV0CqhIoh8RfzYeucDNgED2DkWd9uMVU0=;
        h=From:To:Cc:Subject:Date:From;
        b=QY/s19LPfb6Yval8CT7YXWWpNjgYofRf1ovQPgyZFkAvrNZdW4hIQNwncYqLZHNDg
         qlms0kvj+yvkfrF5FnD35+4mRcV8QGMckmEDeXf38J8Oq5UShVplyfZ7g47/fZiw4J
         iii3gaZ8bRfPupC8JjQ2uuUBxwUWMrrYmF4AcRiwAOHLzIA8stz7QEr2JUYyyBRLQE
         h5pkw1zMZNvASVHeJHqAFnBBuMvoVvSyxnQFJmVnOe0biW9HPJl3Fu/3U/Wgq743RA
         KmPM/JK8Kyo/1YyvdBWrWvHhuouHyWtmwCkag1bmif5iJz2gWwTXaCF/yDgPC7xmbo
         zpcY+af+OaXDg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] fs: multigrain timestamps
Date:   Mon, 24 Apr 2023 11:11:01 -0400
Message-Id: <20230424151104.175456-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few weeks ago, during one of the discussions around i_version, Dave
Chinner wrote this:

"You've missed the part where I suggested lifting the "nfsd sampled
i_version" state into an inode state flag rather than hiding it in
the i_version field. At that point, we could optimise away the
secondary ctime updates just like you are proposing we do with the
i_version updates.  Further, we could also use that state it to
decide whether we need to use high resolution timestamps when
recording ctime updates - if the nfsd has not sampled the
ctime/i_version, we don't need high res timestamps to be recorded
for ctime...."

While I don't think we can practically optimize away ctime updates
like we do with i_version, I do like the idea of using this scheme to
indicate when we need to use a high-res timestamp.

This patchset is a second attempt at implementing this. The main
difference with this set is that it uses the lowest-order bit of the
tv_nsec field as the flag instead of using an i_state flag. This also
allows us to use atomic ops instead of a spinlock.

With this, the patchset also contains a new opt-in mechanism: You must
set a SB_MULTIGRAIN_TS flag in the superblock, and also raise your
sb->s_time_gran to at least 2.

The first patch adds the necessary infrastructure, and the last two
patches convert tmpfs and xfs to use it. If this looks good, I'll start
embarking on converting other filesystems to this scheme as well.

Comments and suggestions welcome!

Jeff Layton (3):
  fs: add infrastructure for multigrain inode i_m/ctime
  shmem: mark for high-res timestamps on next update after getattr
  xfs: mark the inode for high-res timestamp update in getattr

 fs/inode.c                      | 57 +++++++++++++++++++++++++++---
 fs/stat.c                       | 24 +++++++++++++
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_acl.c                |  2 +-
 fs/xfs/xfs_inode.c              |  2 +-
 fs/xfs/xfs_inode_item.c         |  2 +-
 fs/xfs/xfs_iops.c               |  9 +++--
 fs/xfs/xfs_super.c              |  5 ++-
 include/linux/fs.h              | 62 +++++++++++++++++++++++----------
 mm/shmem.c                      | 29 ++++++++-------
 10 files changed, 152 insertions(+), 42 deletions(-)

-- 
2.40.0

