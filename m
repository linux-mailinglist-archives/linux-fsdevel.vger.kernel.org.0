Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4724A776
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHSUHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 16:07:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:07:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id BFAB2295E70
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] Consolidate DIO behavior on unaligned EOF read
Date:   Wed, 19 Aug 2020 16:07:29 -0400
Message-Id: <20200819200731.2972195-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When issuing a DIO read past EOF on a file that doesn't end on a block
boundary, behavior varies among filesystems. Most filesystems (including
the ones using iomap for DIO) will return EOF, but the old generic DIO
mechanism changed behavior accidently after commit 9fe55eea7e4b ("Fix
race when checking i_size on direct i/o read") and started returning
-EINVAL.

This can be observed with a simple read over a file that doesn't end on
a block boundary, forcing the last read to be unaligned.

 while (done < total) {
   ssize_t delta = pread(fd, buf + done, total - done, off + done);
   if (!delta)
     break;
   ...
 }

On the final read, delta will be 0 on most filesystems, including ext4,
xfs and btrfs, but it started being -EINVAL after said commit, for
filesystems using do_blockdev_direct_IO.

BTRFS, even though relying on this generic code, doesn't have this
issue, because it does the verification beforehand, on check_direct_IO.
Finally, f2fs requires a specific fix, since it checks for alignment
before calling the generic code.

It is arguable whether filesystems should actually return EOF or
-EINVAL, but since the original ABI returned 0 and so does most
filesystems and original DIO code, it seems reasonable to consolidate on
that.  Therefore, this patchset fixes the filesystems returning EINVAL
to return EOF.

I ran smoke tests over f2fs, and didn't observe regressions.

Gabriel Krisman Bertazi (1):
  f2fs: Return EOF on unaligned end of file DIO read

Jamie Liu (1):
  direct-io: defer alignment check until after EOF check

 fs/direct-io.c | 31 ++++++++++++++++++-------------
 fs/f2fs/data.c |  3 +++
 2 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.28.0

