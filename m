Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B863F7544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhHYMqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 08:46:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHYMqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:46:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7342820103;
        Wed, 25 Aug 2021 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629895516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ugJbIgRXeXiVk36AiNLI+PeUY90GeLHaX7Ko/boil4U=;
        b=ciU6sVsx1saGz4yqkViUKc6txHrUHxXUwdp5HBCxU8v3StHNpuURPLtPNxca3PynGVPoCR
        eDxIFg4A6gtEh06/yroU2Wgqql+aEEm0KcLs106bV5K7s2WLHYXtMH7nEITmgv/XRICAq1
        3STpzuD7g3icFtHgUXOCPIPoPngkrPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629895516;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ugJbIgRXeXiVk36AiNLI+PeUY90GeLHaX7Ko/boil4U=;
        b=V+nVejSV1Lqj0uSgje5jgG92nWtXP1+/yN+BxRchjyTRVFqItSuFGaBOKtDbKg15Evj311
        IMicEOByzP3hsDAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 67EC8A3B90;
        Wed, 25 Aug 2021 12:45:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 424611F2BA4; Wed, 25 Aug 2021 14:45:15 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:45:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for v5.15-rc1
Message-ID: <20210825124515.GE14620@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  my vacation collides with the merge window which I expect to open next
week so I'm sending pull requests for the merge window early. Could you please
pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.15-rc1

to get fsnotify speedups when notification actually isn't used and support
for identifying processes which caused fanotify events through pidfd
instead of normal pid.

Top of the tree is e43de7f0862b. The full shortlog is:

Amir Goldstein (4):
      fsnotify: replace igrab() with ihold() on attach connector
      fsnotify: count s_fsnotify_inode_refs for attached connectors
      fsnotify: count all objects with attached connectors
      fsnotify: optimize the case of no marks of any type

Matthew Bobrowski (5):
      kernel/pid.c: remove static qualifier from pidfd_create()
      kernel/pid.c: implement additional checks upon pidfd_create() parameters
      fanotify: minor cosmetic adjustments to fid labels
      fanotify: introduce a generic info record copying helper
      fanotify: add pidfd support to the fanotify API

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 251 ++++++++++++++++++++++++++-----------
 fs/notify/fsnotify.c               |   6 +-
 fs/notify/fsnotify.h               |  15 +++
 fs/notify/mark.c                   |  52 ++++++--
 include/linux/fanotify.h           |   3 +
 include/linux/fs.h                 |   7 +-
 include/linux/fsnotify.h           |   9 ++
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  13 ++
 kernel/pid.c                       |  15 ++-
 10 files changed, 276 insertions(+), 96 deletions(-)

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
