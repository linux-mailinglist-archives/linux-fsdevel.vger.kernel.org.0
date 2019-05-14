Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB91E508
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfENWTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:19:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfENWTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so417636wrr.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v2F2rrbfKbfirXnVeXPVG/EfPWcHwpuHRTY3mRxxY6I=;
        b=XpF9fAgH2ESSf+YArlK7eLBZdwPOHqS0A2FzQP5P1bQzuclOG1GHrQ9XTXzQRnCRo2
         oDPE6tHkfkj+GCn0gcp+U1Rqve5X24rjSglQ0cYAb/mShQXkirtWb2+UyR1+kOaHYCOw
         QWtW9tubRR5jrMmhoFQYRgR1szyTm5wBM8aEvaKU+lG1zYMIXHoquwT1WOz+Vd+HX+mw
         M95yrKtNgbAH8XcL8AHv4MEjdLpT1pCvOd14WuA5/RPBaS/uexHIJAnbShpeMty1EaAW
         s4bNYLG+2aCRKiMeL8eIOYXS0ays+bmodNdJtUJmlYl7u+DINDlgqXpaXBMLAfJaWpa6
         y0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v2F2rrbfKbfirXnVeXPVG/EfPWcHwpuHRTY3mRxxY6I=;
        b=H+cYpf7RRIXjDcvDI4HYwYppKGbgvanx1R2EeFHcRnwuhiO4GRljA6pbMNAf0T0CWi
         LKfCRj3aQ5dLcxoI01w+t75NJUqeeXxXWgxW7xzPBlKGC1Xn4ziPi/XK6cf/dDvVyAqt
         LcXdsjG4kJ0WiF4Uw24bJvyOHUwQQvkIO7mHNTXHd9Wg8G9ZcdZYWWlCwK7UWR5uVBn0
         N4ML1fMgE1AMwrRYoffz36VxQT3cqNEY1mTizE3uGBPTdC7EHki8WN5l7qD11LlANCtr
         Qwht/oSb11asLkITpXQ5UbMDLsgjhVOuvSS3fH5d+Fjs4fLZETLuAsJyzBZlL3eBAMfF
         o19g==
X-Gm-Message-State: APjAAAUs9YpJrMR+JarPyqzmOQ7SdwALgVOHpmHZpGXLj5Yf2HeN1rtG
        igQUTCjL8IP3BoQbwCLBi+/LR0iP
X-Google-Smtp-Source: APXvYqzm6BibqAVmGXlHee+1nIvZaym06Hoq7vqdjTu756dxcp7V/qCCzyBhWNzzn0UC58LOj80x7g==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr7237222wrv.297.1557872350724;
        Tue, 14 May 2019 15:19:10 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id h188sm423553wmf.48.2019.05.14.15.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:19:10 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 0/4] Sort out fsnotify_nameremove() mess
Date:   Wed, 15 May 2019 01:18:57 +0300
Message-Id: <20190514221901.29125-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

I started out working on your suggestion [1] of annotating
simple_unlink/rmdir_notify() callers when I realized we could
do better (IMO).

Please see this RFC. If you like the idea, I can split patches 3-4
to per filesystem patches and a final patch to make the switch from
fsnotify_nameremove() to fsnotify_remove().

I audited all the d_delete() call sites that will NOT generate
fsnotify events after these changes and noted to myself why that
makes sense.  I will include those notes in next posting if this
works out for you.

Note that configfs got a special treatment, because its helpers
that call simple_unlink/rmdir() are called from both vfs_XXX code
path and non vfs_XXX code path.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190513163309.GE13297@quack2.suse.cz/

Amir Goldstein (4):
  fs: create simple_remove() helper
  fsnotify: add empty fsnotify_remove() hook
  fs: convert filesystems to use simple_remove() helper
  fsnotify: move fsnotify_nameremove() hook out of d_delete()

 arch/s390/hypfs/inode.c            |  9 ++-----
 drivers/infiniband/hw/qib/qib_fs.c |  3 +--
 fs/afs/dir_silly.c                 |  5 ----
 fs/btrfs/ioctl.c                   |  4 ++-
 fs/configfs/dir.c                  |  3 +++
 fs/dcache.c                        |  2 --
 fs/debugfs/inode.c                 | 20 +++------------
 fs/devpts/inode.c                  |  1 +
 fs/libfs.c                         | 25 ++++++++++++++++++
 fs/namei.c                         |  2 ++
 fs/nfs/unlink.c                    |  6 -----
 fs/notify/fsnotify.c               | 41 ------------------------------
 fs/tracefs/inode.c                 | 23 +++--------------
 include/linux/fs.h                 |  1 +
 include/linux/fsnotify.h           | 18 +++++++++++++
 include/linux/fsnotify_backend.h   |  4 ---
 net/sunrpc/rpc_pipe.c              | 16 ++----------
 security/apparmor/apparmorfs.c     |  6 +----
 18 files changed, 67 insertions(+), 122 deletions(-)

-- 
2.17.1

