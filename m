Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4677B4A3409
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 05:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbiA3E70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 23:59:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44836 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiA3E7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 23:59:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D7660FD8;
        Sun, 30 Jan 2022 04:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D6EC340E4;
        Sun, 30 Jan 2022 04:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643518764;
        bh=HxHf+IvjRMV7v+/jJRSRTLgoyiyZkNg6U22aGpsMUgg=;
        h=Subject:From:To:Cc:Date:From;
        b=K1NxNUQApWbkDM2AFQOVtEQUlb+bujzz6+pwUN4kgCq1G3TavpiOQAFy+08E9t1f8
         I0Z4UGpB8hrdeeW5+/ooKLwAAC6DGfTL9hBC/EXfBZngSHEyUVwAfz5ngJrj+2LLzb
         sORFOs671ocmgEAN5CUs1NSZuVf2rSOX95pdkS0UEnstRcyI9nW/Dkrz77F7K0gpaH
         Rik49zl0isZvGagqIWyUzytccWNwTtbxZ3pISXiB+Fs/xO5KbLhSyli9zbhkYWMtkx
         argolMx6FGEp9bggP7IHAK6lLntsUMoBj3WCzHJqoZ21alaJWiKB1jf4l+RShEfqp+
         hN9p6HLcyZaHA==
Subject: [PATCHSET v2 0/3] xfs: fix permission drop and flushing in fallocate
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org
Date:   Sat, 29 Jan 2022 20:59:23 -0800
Message-ID: <164351876356.4177728.10148216594418485828.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

While auditing the file permission dropping for fallocate, I reached the
conclusion that fallocate can modify file contents, and therefore should
be treated as a file write.  As such, it needs to update the file
modification and file (metadata) change timestamps, and it needs to drop
file privileges such as setuid and capabilities, just like a regular
write.  Moreover, if the inode is configured for synchronous writes,
then all the fallocate changes really ought to be persisted to disk
before fallocate returns to userspace.

Unfortunately, the XFS fallocate implementation doesn't do this
correctly.  setgid without group-exec is a mandatory locking mark and is
left alone by write(), which means that we shouldn't drop it
unconditionally.  Furthermore, file capabilities are another vector for
setuid to be set on a program file, and XFS ignores these.

I also noticed that fallocate doesn't flush the log to disk after
fallocate when the fs is mounted with -o sync or if the DIFLAG_SYNC flag
is set on the inode.

Therefore, refactor the XFS fallocate implementation to use the VFS
helper file_modified to update file metadata instead of open-coding it
incorrectly.  Refactor it further to use xfs_file_sync_writes to decide
if we need to flush the log; and then fix the log flushing so that it
flushes after we've made /all/ the changes.

v2: fix some bisection problems

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=falloc-fix-perm-updates-5.17
---
 fs/xfs/xfs_file.c |   72 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 20 deletions(-)

