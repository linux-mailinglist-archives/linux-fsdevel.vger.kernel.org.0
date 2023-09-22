Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235837AB6F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjIVRO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjIVROz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:14:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE465197;
        Fri, 22 Sep 2023 10:14:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C60EC433C8;
        Fri, 22 Sep 2023 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695402888;
        bh=RATeZnXh5R72GIn+XDIT+T4I9Ey9Dt25YMsmWUhQM1k=;
        h=From:Subject:Date:To:Cc:From;
        b=o/4UwmRgvVgOrjivAZ0m2Yp8TDz52mHti/dCTL2sfkQcSJuPMzlDIluOBnvqFXYD+
         CxHYtc9eF5F4VlqHq3juQHqwx8G3pfckhSGlnTqVx0D4mOILYlZc0+m8ueqmdrIkuN
         vQdfTa5f7ko3QROIKMUQcPBnM1bt62OqKQkRM0fYkAcQnj7lNWY33R5NisTSwmeC3M
         WR8CjRHqf/pFIUXM3Is/j+ViOx2OhIkKRV6IjJIXRqsv3rs3MNo2A626KAA6OKyieO
         so8kqb5eoFDgx6GddHxQX4lWw9z+dEnA+eRsfAJBuW9vIT2JTe84E7FFMTQxOg2PLl
         KuUYbB8g4pbXg==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
Date:   Fri, 22 Sep 2023 13:14:39 -0400
Message-Id: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDLDWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHQUlJIzE
 vPSU3UzU4B8JSMDI2MDSyND3eSSzNxUXdMk80QzI4tEkyRLUyWg2oKi1LTMCrA50bG1tQBXw+L
 xVwAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2634; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RATeZnXh5R72GIn+XDIT+T4I9Ey9Dt25YMsmWUhQM1k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlDcuGuFF5a+fCeaA02G7XyP4SUITqXWcEhddVl
 pUMI5rHcZKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQ3LhgAKCRAADmhBGVaC
 FVDZEACWaWtx8XKSHyv+QPSPgv21QuoUzBkMMJiaicQvu63y6uFY7cNRcVE6YquS0WwW3AidxAR
 wvPXe0tS9EsUzwKMdb29WFzy6ftqJj1vVdQDIWD+lIE2ywO6G6rGOLLjhOucQuiMbcnDoj4kUfk
 Wb9BcBnqqWQJC+UJd92dV+stZgJ+vrHGHiN3n6x54Oe67xI7s6k8t04ybGT5KDHW0lKfQbXWD5S
 NLdnn31Au8xE6gTLaLqKco/q1yjQpGLeWiQt8h9L0JFS/UXd30ahuki0LWZLh+Vqppwg099r+rV
 IQnEeobAP1tKKXLI9M/5xzPU49QVhgmG/ixnucX12t3SNIG38kYgv/5JtLJT4OPqhwuPBQgcnSv
 cuXjNwmON5rlGZHKvA7DdQbgscRcWLd64v1jcEYQ7JS4mgY6Mx9OV/hpD60pF4rkfPIFKFETjMo
 IxlfJFERXdHgymKUb7BINuwC9eI4yB8z3pOgMMfw1eeUUvNpS6r88Hix+Suhc5ay/7Ne0NH68EJ
 YBceJVU7VM9iGPc+jmj4Ya27fr0jKdr8qidY++g/K/E9Vn3wEezCeTT2PTc3NSnTlo4+4mckzn6
 Y8aXxGTD/qJ4ukjH7hvKKK10ENSBehzbwrmwHtTl2YeZMRMvgaJE35fCJ1U5B67YaxitY1JrROX
 MLZTVrRZDTltulQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My initial goal was to implement multigrain timestamps on most major
filesystems, so we could present them to userland, and use them for
NFSv3, etc.

With the current implementation however, we can't guarantee that a file
with a coarse grained timestamp modified after one with a fine grained
timestamp will always appear to have a later value. This could confuse
some programs like make, rsync, find, etc. that depend on strict
ordering requirements for timestamps.

The goal of this version is more modest: fix XFS' change attribute.
XFS's change attribute is bumped on atime updates in addition to other
deliberate changes. This makes it unsuitable for export via nfsd.

Jan Kara suggested keeping this functionality internal-only for now and
plumbing the fine grained timestamps through getattr [1]. This set takes
a slightly different approach and has XFS use the fine-grained attr to
fake up STATX_CHANGE_COOKIE in its getattr routine itself.

While we keep fine-grained timestamps in struct inode, when presenting
the timestamps via getattr, we truncate them at a granularity of number
of ns per jiffy, which allows us to smooth over the fuzz that causes
ordering problems.

This set only converts XFS to use this scheme. All of the other
commonly-exported local filesystems have a native change attribute and
wouldn't clearly benefit from mgtime support at this time. Still, it
should be possible to add this support to other filesystems in the
future, as the need arises (bcachefs?).

I'd like to see this go in for v6.7 if possible, so getting it into
linux-next now would be great if there are no objections.

[1]: https://lore.kernel.org/linux-fsdevel/20230920124823.ghl6crb5sh4x2pmt@quack3/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (5):
      fs: add infrastructure for multigrain timestamps
      fs: optimize away some fine-grained timestamp updates
      fs: have setattr_copy handle multigrain timestamps appropriately
      fs: add timestamp_truncate_to_gran helper
      xfs: switch to multigrain timestamps

 fs/attr.c                       |  52 ++++++++++++--
 fs/inode.c                      | 151 ++++++++++++++++++++++++++++++++++++----
 fs/xfs/libxfs/xfs_trans_inode.c |   6 +-
 fs/xfs/xfs_iops.c               |  26 +++++--
 fs/xfs/xfs_super.c              |   2 +-
 include/linux/fs.h              |  64 ++++++++++++++++-
 6 files changed, 269 insertions(+), 32 deletions(-)
---
base-commit: f8f2d6d669b91ea98ec8f182c22e06d3d0663e15
change-id: 20230921-ctime-5b7a628a4b95

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

