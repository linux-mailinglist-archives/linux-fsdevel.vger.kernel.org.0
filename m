Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BB49C12A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiAZCSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiAZCSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A57C06173B;
        Tue, 25 Jan 2022 18:18:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167D760BB9;
        Wed, 26 Jan 2022 02:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2FCC340E5;
        Wed, 26 Jan 2022 02:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163524;
        bh=VaCduY2bNo2axGtKHgPfUcASKvtmy9+1zKT+eyIJBC0=;
        h=Subject:From:To:Cc:Date:From;
        b=LIhSX2uAoRdkhtWm27h8b/H01QUP/SI80CatGjPoy2TrDa/EGhAh//7p3woQJpj8C
         xebNjyIVRikWuyYDspUFDk0mM5RGoLBrHxOC7+1F4pMWDUhK+ddTBX08zs4wuRy/0Y
         5Nw+47vOCk8/mwbzAsdO8CT4RCwdxhCZJj9GeGAZ5HMKAzZEw+DdNyGky+upBPU3GV
         NCxp9qMhvSs3NDp06/L6uVRPV9qxLqV8hfHtPW1MyJeatARBVu1nbSGMcuRSegRPSP
         iCDMCLDajMofa5/ryqCyoLelU+xKiF0YF62U2ysdxf7GqjSI5nzajPwxjmrirfgrI6
         hOODX/p/CH6Aw==
Subject: [PATCHSET 0/3] xfs: fix permission drop and flushing in fallocate
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 18:18:44 -0800
Message-ID: <164316352410.2600373.17669839881121774801.stgit@magnolia>
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

