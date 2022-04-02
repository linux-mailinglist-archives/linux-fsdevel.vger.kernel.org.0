Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA1A4EFD94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 03:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiDBBFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 21:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352895AbiDBBFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B3DB1;
        Fri,  1 Apr 2022 18:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C705661BA0;
        Sat,  2 Apr 2022 01:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B9C340F2;
        Sat,  2 Apr 2022 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648861419;
        bh=5VYMrcOx8O4wrYuwRZe41/ymZHbb4meqyu+BuXg43TM=;
        h=Date:From:To:Cc:Subject:From;
        b=o69ahH8l3DpKQWxIT9y2Xz/XqPazxGdZT0+BD6WzBAz/QjQhsG4vc8p7gpA9QdduD
         lATi6RfDiaikw/gIAVxxLC04jtUjEbyVZLVShGq6i8H9poDRvJbkPSTbphvxANPN1s
         HjU8kUA0P7eFP2pYeKby3qzpGxw45KWFfP/+QxXeEbPkoAaTQvZ4bxIqvKYMu74Lgr
         ngh5ef4QymamT1n5s2HytcWC9uEDWJoUXS3qgCn2k5uOzwV2fmg5/dWGWcEGv6WXiV
         y4LkRY3eX/LisT9f7SUs8vSaDRcYqncwfUTqBehSn0pyUTZ2IFuRoFDRnmSr5LmPBF
         +WZEi8nHTPwRg==
Date:   Fri, 1 Apr 2022 18:03:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] vfs: fixes for 5.18-rc1
Message-ID: <20220402010338.GP27690@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch of VFS bugfixes for 5.18-rc1.  The erofs
developers felt that FIEMAP should handle ranged requests starting at
s_maxbytes by returning EFBIG instead of passing the filesystem
implementation a nonsense 0-byte request.

Not sure why they keep tagging this 'iomap', but the VFS shouldn't be
asking for information about ranges of a file that the filesystem
already declared that it does not support.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.18-merge-1

for you to fetch changes up to 49df34221804cfd6384135b28b03c9461a31d024:

  fs: fix an infinite loop in iomap_fiemap (2022-03-30 09:49:28 -0700)

----------------------------------------------------------------
Fixes for 5.18-rc1:
 - Fix a potential infinite loop in FIEMAP by fixing an off by one error
   when comparing the requested range against s_maxbytes.

----------------------------------------------------------------
Guo Xuenan (1):
      fs: fix an infinite loop in iomap_fiemap

 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
