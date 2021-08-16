Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9273A3EDEFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 23:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhHPVFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 17:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhHPVFv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:05:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B9960EE5;
        Mon, 16 Aug 2021 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629147919;
        bh=n8/CrazHIJitOBvrkWAi8jW2R/e/YwKtcUnX8JaRs8Q=;
        h=Subject:From:To:Cc:Date:From;
        b=C5s1N70FgrxgSwsPCk0PnoUciK+k+Fqfd/1TQ7NpZwEKhYOJXoTizujUDxYSbzGEw
         P82KWmVdx7wJowQM+aoa2GpLxr3Fi8Q2OG6zOl4k3agqGAPxoDIrZHTrrvK7rGft49
         IUhZtJlrnk2/OtFK34xY5UzvKiJ5/Y1KXFrbpa66TKtQT7n0GO3rCIM1r8wpswECOI
         5tfL7AL16D0zWh5GofVn+d96Jz2/kpy84lk0LT5IcEB+pEPgfMyW9IxI1yJcaBmY9G
         PqrX1kQmz5WTylCb+NMdRwUQohx5JYSOBDhMh/afdNdqIMym5VXbYkGaI6DxEH6OrU
         EXCs07xmqzTGw==
Subject: [PATCHSET 0/2] dax: fix broken pmem poison narrative
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, jane.chu@oracle.com,
        willy@infradead.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sandeen@sandeen.net
Date:   Mon, 16 Aug 2021 14:05:18 -0700
Message-ID: <162914791879.197065.12619905059952917229.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Our current "advice" to people using persistent memory and FSDAX who
wish to recover upon receipt of a media error (aka 'hwpoison') event
from ACPI is to punch-hole that part of the file and then pwrite it,
which will magically cause the pmem to be reinitialized and the poison
to be cleared.

Punching doesn't make any sense at all -- we don't allow userspace to
allocate from specific parts of the storage, and another writer could
grab the poisoned range in the meantime.  In other words, the advice is
seriously overfitted to incidental xfs and ext4 behavior and can
completely fail.  Worse yet, that concurrent writer now has to deal with
the poison that it didn't know about, and someone else is trying to fix.

AFAICT, the only reason why the "punch and write" dance works at all is
that the XFS and ext4 currently call blkdev_issue_zeroout when
allocating pmem as part of a pwrite call.  A pwrite without the punch
won't clear the poison, because pwrite on a DAX file calls
dax_direct_access to access the memory directly, and dax_direct_access
is only smart enough to bail out on poisoned pmem.  It does not know how
to clear it.  Userspace could solve the problem by calling FIEMAP and
issuing a BLKZEROOUT, but that requires rawio capabilities.

The whole pmem poison recovery story is is wrong and needs to be
corrected ASAP before everyone else starts doing this.  Therefore,
create a dax_zeroinit_range function that filesystems can call to reset
the contents of the pmem to a known value and clear any state associated
with the media error.  Then, connect FALLOC_FL_ZERO_RANGE to this new
function (for DAX files) so that unprivileged userspace has a safe way
to reset the pmem and clear media errors.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=dax-zeroinit-clear-poison-5.15
---
 fs/dax.c            |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c   |   19 +++++++++++++
 fs/xfs/xfs_file.c   |   20 ++++++++++++++
 include/linux/dax.h |    7 +++++
 4 files changed, 118 insertions(+)

