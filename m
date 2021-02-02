Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA08E30C67C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhBBQu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236818AbhBBQs2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:48:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1C5F64F76;
        Tue,  2 Feb 2021 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612284467;
        bh=AIcsbrupvZLYfxKEEm9bMUc8wyAjniIIqMRpSSXcyLc=;
        h=Date:From:To:Subject:From;
        b=c/YUGelPpCgrAcKKfIIfKfFp9zz/hi4cTfHy/9+x99z9SHXBntSzCvRmCrtpsDBWg
         hAahX9P+sOTA72SGTg2W9CEopP/8N+4yFWuCJchCcIW1z0Atg0UMIOGU+R5MD5G0RH
         YxxbT9G/ZIExaenjOkkZxUkDnWRymNprNXniGVAOOUQCKWPaMFWntXnFc2rOXtGWb5
         IDNCisJjRkVr3s5WyYDxemWgivoNuQ88ywOMDEWk/D9NOlKkYoVb1L29pecgHOkXJd
         zEulTeAshXMtOCWSk4M/azHJ0NYHxBX766Q7BttLAl2Sb1GXOhEze8VQ7ioslzY06s
         kQ43y102i27ZA==
Date:   Tue, 2 Feb 2021 08:47:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to ed1128c2d0c8
Message-ID: <20210202164747.GK7193@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  I've been testing the xfs dio changes for a couple of
weeks now, but forgot to push them out until Christoph prompted me
yesterday.

Note that Naohiro Aota's btrfs patchset to add zoned block support will
perform some slight refactoring of fs/iomap/directio.c to add support
for REQ_OP_ZONE_APPEND.  I don't know if they're planning to push that
for 5.12, but AFAICT it should have minimal impact to everyone else.

The new head of the iomap-for-next branch is commit:

ed1128c2d0c8 xfs: reduce exclusive locking on unaligned dio

New Commits:

Christoph Hellwig (9):
      [5724be5de88f] iomap: rename the flags variable in __iomap_dio_rw
      [2f63296578ca] iomap: pass a flags argument to iomap_dio_rw
      [213f627104da] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
      [f50b8f475a2c] xfs: factor out a xfs_ilock_iocb helper
      [354be7e3b2ba] xfs: make xfs_file_aio_write_checks IOCB_NOWAIT-aware
      [ee1b218b0956] xfs: cleanup the read/write helper naming
      [670654b004b0] xfs: remove the buffered I/O fallback assert
      [3e40b13c3b57] xfs: simplify the read/write tracepoints
      [896f72d067a5] xfs: improve the reflink_bounce_dio_write tracepoint

Dave Chinner (2):
      [caa89dbc4303] xfs: split the unaligned DIO write code out
      [ed1128c2d0c8] xfs: reduce exclusive locking on unaligned dio


Code Diffstat:

 fs/btrfs/file.c       |   7 +-
 fs/ext4/file.c        |   5 +-
 fs/gfs2/file.c        |   7 +-
 fs/iomap/direct-io.c  |  26 ++--
 fs/xfs/xfs_file.c     | 351 ++++++++++++++++++++++++++++----------------------
 fs/xfs/xfs_iomap.c    |  29 +++--
 fs/xfs/xfs_trace.h    |  22 ++--
 fs/zonefs/super.c     |   4 +-
 include/linux/iomap.h |  18 ++-
 9 files changed, 269 insertions(+), 200 deletions(-)
