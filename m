Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA92E0147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgLUTwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 14:52:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgLUTwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608580279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wMleRDSwz6xsXeUbgRCfLYniffObUPtn4CN9Ykh/eBg=;
        b=Ol/8Ku4L0ckvp2HKSIafFJx2+q2Sttt9Uqf1OjfiKHrN3GIVrYoK6ba9ftdVnL8azqtDz3
        OfJ25VUGRhfft/GYt14Fa5xyiO2Tc1xJm9HeZv1Jv1eviUw0tOVelQ+75d1iDRIUou5QQF
        nnlLHjgqPM+7Jzau4mwf410jv38+LCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-xwgI0t3-P9OopSbByjSh5Q-1; Mon, 21 Dec 2020 14:51:15 -0500
X-MC-Unique: xwgI0t3-P9OopSbByjSh5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45062107ACE4;
        Mon, 21 Dec 2020 19:51:12 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-244.rdu2.redhat.com [10.10.114.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B716F984;
        Mon, 21 Dec 2020 19:51:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2541E220BCF; Mon, 21 Dec 2020 14:51:11 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: [RFC PATCH 0/3][v3] vfs, overlayfs: Fix syncfs() to return correct errors
Date:   Mon, 21 Dec 2020 14:50:52 -0500
Message-Id: <20201221195055.35295-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is v3 of patches which try to fix syncfs() error handling issues
w.r.t overlayfs and other filesystems.

Previous version of patches are here.
v2: 
https://lore.kernel.org/linux-fsdevel/20201216233149.39025-1-vgoyal@redhat.com/
v1:
https://lore.kernel.org/linux-fsdevel/20201216143802.GA10550@redhat.com/

This series basically is trying to fix two problems.

- First problem is that we ignore error code returned by ->sync_fs().
  overlayfs file system can return error and there are other file
  systems which can return error in certain cases. So to fix this issue,
  first patch captures the return code from ->sync_fs and returns to
  user space.

- Second problem is that current syncfs(), writeback error detection
  logic does not work for overlayfs. current logic relies on all
  sb->s_wb_err being update when errors occur but that's not true for
  overlayfs. Real errors happen on underlyig filessytem and overlayfs
  has no clue about these. To fix this issue, it has been proposed
  that for filesystems like overlayfs, this check should be moved into
  filesystem and then filesystem can check for error w.r.t upper super
  block.

  There seem to be multiple ways of how this can be done.

  A. Add a "struct file" argument to ->sync_fs() and modify all helpers.
  B. Add a separate file operation say "f_op->syncfs()" and call that
     in syncfs().
  C. Add a separate super block operation to check and advance errors.

Option A involves lot of changes all across the code. Also it is little
problematic in the sense that for filesystems having a block device,
looks like we want to check for errors after ___sync_blockdev() has
returned. But ->sync_fs() is called before that. That means
__sync_blockdev() will have to be pushed in side filesystem code as
well. Jeff Layton gave something like this a try here.

https://lore.kernel.org/linux-fsdevel/20180518123415.28181-1-jlayton@kernel.org/

I posted patches for option B in V2. 

https://lore.kernel.org/linux-fsdevel/20201216233149.39025-1-vgoyal@redhat.com/

Now this is V3 of patches which implements option C. I think this is
simplest in terms of implementation atleast.

These patches are only compile tested. Will do more testing once I get
a sense which option has a chance to fly.

I think patch 1 should be applied irrespective of what option we end
up choosing for fixing the writeback error issue.

Thanks
Vivek

Vivek Goyal (3):
  vfs: Do not ignore return code from s_op->sync_fs
  vfs: Add a super block operation to check for writeback errors
  overlayfs: Report writeback errors on upper

 fs/overlayfs/file.c      |  1 +
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/readdir.c   |  1 +
 fs/overlayfs/super.c     | 23 +++++++++++++++++++++++
 fs/overlayfs/util.c      | 13 +++++++++++++
 fs/sync.c                | 13 ++++++++++---
 include/linux/fs.h       |  1 +
 7 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.25.4

