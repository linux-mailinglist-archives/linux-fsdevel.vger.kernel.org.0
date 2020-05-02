Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C160B1C272A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEBRIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 13:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgEBRIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 13:08:02 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104042064A;
        Sat,  2 May 2020 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588439282;
        bh=MIvxVX7zIrcs+Zk2CJWmBJutCLiO1x4xblndHQuzlI8=;
        h=Date:From:To:Cc:Subject:From;
        b=P7Fb/9p7g8Q9xKQAiYxPLPTYzWpG/mS5FuZzrA6E6a7RLA/9SZI0e31cC7g83VnSX
         ivaYz7Wlg4rQ3SHbv4BsNB9DdQsWWHuEX5fvtlL4KXktocRTP0KbbN4SHN5pe3hPi4
         oelhKiMxq1rCS/20uWIjUt4m1g3ErNhjt2xWx69U=
Date:   Sat, 2 May 2020 10:08:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, riteshh@linux.ibm.com
Subject: [GIT PULL] iomap: bug fix for 5.7-rc3
Message-ID: <20200502170801.GB6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single bug fix for 5.7 that hoists the check for an
unrepresentable FIBMAP return value into ioctl_fibmap.  The internal
kernel function can handle 64-bit values (and is needed to fix a
regression on ext4 + jbd2); it is only the userspace ioctl that is so
old that it cannot deal.  The branch merged cleanly with upstream head
as of a few minutes ago.

--D

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.7-fixes-1

for you to fetch changes up to b75dfde1212991b24b220c3995101c60a7b8ae74:

  fibmap: Warn and return an error in case of block > INT_MAX (2020-04-30 07:57:46 -0700)

----------------------------------------------------------------
Changes for 5.7:
- Move the FIBMAP range check and warning out of the backend iomap
implementation and into the frontend ioctl_fibmap so that the checking
is consistent for all implementations.

----------------------------------------------------------------
Ritesh Harjani (1):
      fibmap: Warn and return an error in case of block > INT_MAX

 fs/ioctl.c        | 8 ++++++++
 fs/iomap/fiemap.c | 5 +----
 2 files changed, 9 insertions(+), 4 deletions(-)
