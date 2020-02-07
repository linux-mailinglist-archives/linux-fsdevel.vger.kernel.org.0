Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681B5155C82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGRE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgBGRE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:04:26 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF7320838;
        Fri,  7 Feb 2020 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581095066;
        bh=rmwdovkzPDfU6zBkkGN1DFPIW8RKH+GAVeQqP8b7sW0=;
        h=From:To:Cc:Subject:Date:From;
        b=LOKxzF2Av9uZ51jStNxCyOrUHTzlWfSJ1yYOdj5zx7m39pQpvfVYrUbC1LXADkRYe
         VgTwb5HrV262Tk+/yr7I35NMNP0FYhad2t5WPNfjNDtpJjdXDPgYq8+4HqqGak4MkJ
         VOJM6m55x7y+qTviJOBtXVG1ZqYydtnFPFg2Y6os=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: [PATCH v3 0/3] vfs: have syncfs() return error when there are writeback errors
Date:   Fri,  7 Feb 2020 12:04:20 -0500
Message-Id: <20200207170423.377931-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You're probably wondering -- Where are v1 and v2 sets?

I did the first couple of versions of this set back in 2018, and then
got dragged off to work on other things. I'd like to resurrect this set
though, as I think it's valuable overall, and I have need of it for some
other work I'm doing.

Currently, syncfs does not return errors when one of the inodes fails to
be written back. It will return errors based on the legacy AS_EIO and
AS_ENOSPC flags when syncing out the block device fails, but that's not
particularly helpful for filesystems that aren't backed by a blockdev.
It's also possible for a stray sync to lose those errors.

The basic idea is to track writeback errors at the superblock level,
so that we can quickly and easily check whether something bad happened
without having to fsync each file individually. syncfs is then changed
to reliably report writeback errors, and a new ioctl is added to allow
userland to get at the current errseq_t value w/o having to sync out
anything.

I do have a xfstest for this. I do not yet have manpage patches, but
I'm happy to roll some once there is consensus on the interface.

Caveats:

- Having different behavior for an O_PATH descriptor in syncfs is
  a bit odd, but it means that we don't have to grow struct file. Is
  that acceptable from an API standpoint?

- This adds a new generic fs ioctl to allow userland to scrape the
  current superblock's errseq_t value. It may be best to present this
  to userland via fsinfo() instead (once that's merged). I'm fine with
  dropping the last patch for now and reworking it for fsinfo if so.

Jeff Layton (3):
  vfs: track per-sb writeback errors and report them to syncfs
  buffer: record blockdev write errors in super_block that it backs
  vfs: add a new ioctl for fetching the superblock's errseq_t

 fs/buffer.c             |  2 ++
 fs/ioctl.c              |  4 ++++
 fs/open.c               |  6 +++---
 fs/sync.c               |  9 ++++++++-
 include/linux/errseq.h  |  1 +
 include/linux/fs.h      |  3 +++
 include/linux/pagemap.h |  5 ++++-
 include/uapi/linux/fs.h |  1 +
 lib/errseq.c            | 33 +++++++++++++++++++++++++++++++--
 9 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.24.1

