Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02346DDE1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDKOhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDKOhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D69246AF;
        Tue, 11 Apr 2023 07:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02937627A7;
        Tue, 11 Apr 2023 14:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41813C433D2;
        Tue, 11 Apr 2023 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223825;
        bh=IRCClithvgPTE04hKaJiM2EAL0BbX3ippre0W+x0FD4=;
        h=From:To:Cc:Subject:Date:From;
        b=t4qT7x6t2LTb4FTbywjpwvf4EZgxgoZDbquly4oCmuXuqeQHVn8s3QnZNlI8SwIt+
         pjjvDJdWxP73tNqCgdJkKkph2o3QfeFww7QhfVDKoKt92Cgbu3ROm7x5RtpjebsiJT
         TTVr2x9eaw3xhwKJuT4FJbUWsqcNUK3AVcl7oSJoyNRESlqJvFls5gMWhdOXNdU1aa
         y/xNNgsCceoYVMtskUS+ytTRKik/3kWiXiYxZDIjWZLGkVgvXnr6g6zhIXyb2LkX3p
         dPVQMmiI2WSWyRm6wI+wARvMxps10ptSmgDmffgC65ZOuOJqIqsxQmI5ED1yYIPJA/
         wYw7FCMju4k6Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/3][RESEND] fs: opportunistic high-res file timestamps
Date:   Tue, 11 Apr 2023 10:36:59 -0400
Message-Id: <20230411143702.64495-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(Apologies for the resend, but I didn't send this with a wide enough
distribution list originally).

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

This patchset is a first stab at a scheme to do this. It declares a new
i_state flag for this purpose and adds two new vfs-layer functions to
implement conditional high-res timestamp fetching. It then converts both
tmpfs and xfs to use it.

This seems to behave fine under xfstests, but I haven't yet done
any performance testing with it. I wouldn't expect it to create huge
regressions though since we're only grabbing high res timestamps after
each query.

I like this scheme because we can potentially convert any filesystem to
use it. No special storage requirements like with i_version field.  I
think it'd potentially improve NFS cache coherency with a whole swath of
exportable filesystems, and helps out NFSv3 too.

This is really just a proof-of-concept. There are a number of things we
could change:

1/ We could use the top bit in the tv_sec field as the flag. That'd give
   us different flags for ctime and mtime. We also wouldn't need to use
   a spinlock.

2/ We could probably optimize away the high-res timestamp fetch in more
   cases. Basically, always do a coarse-grained ts fetch and only fetch
   the high-res ts when the QUERIED flag is set and the existing time
   hasn't changed.

If this approach looks reasonable, I'll plan to start working on
converting more filesystems.

One thing I'm not clear on is how widely available high res timestamps
are. Is this something we need to gate on particular CONFIG_* options?

Thoughts?

Jeff Layton (3):
  fs: add infrastructure for opportunistic high-res ctime/mtime updates
  shmem: mark for high-res timestamps on next update after getattr
  xfs: mark the inode for high-res timestamp update in getattr

 fs/inode.c                      | 40 +++++++++++++++++++++++++++++++--
 fs/stat.c                       | 10 +++++++++
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_acl.c                |  2 +-
 fs/xfs/xfs_inode.c              |  2 +-
 fs/xfs/xfs_iops.c               | 15 ++++++++++---
 include/linux/fs.h              |  5 ++++-
 mm/shmem.c                      | 23 ++++++++++---------
 8 files changed, 80 insertions(+), 19 deletions(-)

-- 
2.39.2

