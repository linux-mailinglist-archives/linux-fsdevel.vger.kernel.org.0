Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93209B48B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436709AbfHWQel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 12:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389827AbfHWQek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:34:40 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA325205C9;
        Fri, 23 Aug 2019 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566578079;
        bh=wKJz9YOkE0fj8OFVZwyerZJCWFSIUVaGmXLkqc4eHQU=;
        h=Date:From:To:Cc:Subject:From;
        b=ehiQ1jlRR/1ZPpGwcgYweF1sBjS3BoFZw8yWbXh+J9bvjP69gPEORLQDgIv2FL39H
         9RS7AS3meA/8h7f3zoEwyfRexpZzYQ77Nxegt4U0hM8YkKPtQT8+ikxsLdO+MEu1bM
         tj7Fg349rFcEk89yvGJrTch0tBDOPf6oAInCZ0AM=
Date:   Fri, 23 Aug 2019 09:34:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.3-rc6
Message-ID: <20190823163439.GL1037350@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here are a few more bug fixes that trickled in since the last pull.
They've survived the usual xfstests runs and merge cleanly with this
morning's master.  Please let me know if anything strange happens.

I expect there to be one more pull request tomorrow for the fix to that
quota related inode unlock bug that we were reviewing last night, but it
will continue to soak in the testing machine for several more hours.

--D

The following changes since commit 8612de3f7ba6e900465e340516b8313806d27b2d:

  xfs: don't crash on null attr fork xfs_bmapi_read (2019-08-12 09:32:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-fixes-4

for you to fetch changes up to b68271609c4f16a79eae8069933f64345afcf888:

  fs/xfs: Fix return code of xfs_break_leased_layouts() (2019-08-19 18:15:28 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix missing compat ioctl handling for get/setlabel
- Fix missing ioctl pointer sanitization on s390
- Fix a page locking deadlock in the dedupe comparison code
- Fix inadequate locking in reflink code w.r.t. concurrent directio
- Fix broken error detection when breaking layouts

----------------------------------------------------------------
Christoph Hellwig (2):
      xfs: fall back to native ioctls for unhandled compat ones
      xfs: compat_ioctl: use compat_ptr()

Darrick J. Wong (2):
      vfs: fix page locking deadlocks when deduping files
      xfs: fix reflink source file racing with directio writes

Ira Weiny (1):
      fs/xfs: Fix return code of xfs_break_leased_layouts()

 fs/read_write.c      | 49 +++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_ioctl32.c | 56 +++-------------------------------------------
 fs/xfs/xfs_pnfs.c    |  2 +-
 fs/xfs/xfs_reflink.c | 63 ++++++++++++++++++++++++++++++----------------------
 4 files changed, 82 insertions(+), 88 deletions(-)
