Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8833868B8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfGONll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 09:41:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbfGONiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:38:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so13950126wrm.8;
        Mon, 15 Jul 2019 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pCCGRpmdtrB1mcj5ZFa2K6njhUWpd05SyB1tjqa8GXc=;
        b=TgKqMCMdVllXgxOxq2GzIy3XUZpCFqT0jmAKYW98S0k4DUpGf1X93zwH02B7dfw2My
         OFsKZULVI9bnC3BSyOxLSRqofHO7o21mnFD7aeXqBj8DF7clFPuuXGFFuoWpxmkGc7Bm
         Ur/lkrqEQ1mwRoB9R8Yy+WO137CPmqzzBxr8O25jAvSO7rKbmAUglY1BKtkw/jbX47S5
         gAVr5flfjZjimvJ17fDG202tk4U8CWmKkWhtsnJa7uDqbAcAdGpu9YxGC3vo7L8QgCTV
         z0QURbgR+MP8PeEPpyh/51tzz5jw5aVuDf0++zoeRrjLnLM49XodWWMeBMy9lD7Pyjho
         h89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pCCGRpmdtrB1mcj5ZFa2K6njhUWpd05SyB1tjqa8GXc=;
        b=p8OL+7bPyjE57X2rvxlTRn/zAFW5++m5hBEmNCteETpqFNaIH105+e2GhkMHfs2+8N
         VbDiNiBPGlyT0M3JFaJ51PMGeJx3DeUpBcZrg+Eo3iEuBOBnBjI8MXi2s9TsA9zqbxRZ
         b+thkW0qB6RVFIXRrV4BblqqgB0RLShaVhGU+E/8o0fMUcqjn3hWL1XfMYi293iHPcu9
         0qZQjKVtNhx3Wv8xmmn44KGbCNsDAvAIv/WOOuUOs0i/5Pelr1y+RbeG/YWOXmnDJWdp
         rksT76WB0NL+wsGB0uiBMgneMVsH5bGurwjDrHGBQrJ8SnyDqFxgEx3qSEvG6SFSdBrS
         0IcA==
X-Gm-Message-State: APjAAAXdvj8q47fwZUTj9LJ83v0Z7IAgP30oCc6VDgVVVcbKpNwm1fQM
        cQUf6hOdvZWil86O5k13reY=
X-Google-Smtp-Source: APXvYqxe4wpQ+JRPJyNh7/jn1TVc8hwC8EJkhjoWG9KEzSgKmNdfisWpuyRHZrTNeFG6OCtr9cwpLw==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr26845790wrq.137.1563197929508;
        Mon, 15 Jul 2019 06:38:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s15sm4058250wrw.21.2019.07.15.06.38.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 06:38:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PFC][PATCH 0/4] Overlayfs SHUTDOWN ioctl
Date:   Mon, 15 Jul 2019 16:38:35 +0300
Message-Id: <20190715133839.9878-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

I was trying to think of a way forward w.r.t container runtime
mount leaks and overlayfs mount failures, see [1][2][3].

It does not seem reasonable to expect they will fix all the mount
leaks and that new ones will not show up. It's a hard problem to
solve.

I posted a fix patch to mitigate the recent regression with
index=off [2], but it does not seem reasonable to hold index=on feature
hostage for eternity or until all mount leaks are fixed.

The proposal I have come up with is to provide an API for containers
to shutdown the instance before unmount, so the leaked mounts become
"zombies" with no ability to do any harm beyond hogging resources.

The SHUTDOWN ioctl, used by xfs/ext4/f2fs to stop any access to
underlying blockdev is implemented in overlayfs to stop any access
to underlying layers. The real objects are still referenced, but no
vfs API can be called on underlying layers.

Naturally, SHUTDOWN releases the inuse locks to mitigate the mount
failures.

I wrote an xfstest to verify SHUTDOWN solves the mount leak issue [5].

Thoughts?

Thanks,
Amir.

[1] https://github.com/containers/libpod/issues/3540
[2] https://github.com/moby/moby/issues/39475
[3] https://github.com/coreos/linux/pull/339
[4] https://github.com/amir73il/linux/commits/ovl-overlap-detect-regression-fix
[5] https://github.com/amir73il/xfstests/commit/a56d5560e404cc8052a8e47850676364b5e8c76c

Amir Goldstein (4):
  ovl: support [S|G]ETFLAGS ioctl for directories
  ovl: use generic vfs_ioc_setflags_prepare() helper
  ovl: add pre/post access hooks to underlying layers
  ovl: add support for SHUTDOWN ioctl

 fs/overlayfs/copy_up.c   |  10 +-
 fs/overlayfs/dir.c       |  26 +++--
 fs/overlayfs/file.c      | 200 ++++++++++++++++++++++++++-------------
 fs/overlayfs/inode.c     |  64 +++++++++----
 fs/overlayfs/namei.c     |  15 ++-
 fs/overlayfs/overlayfs.h |  15 ++-
 fs/overlayfs/ovl_entry.h |   7 ++
 fs/overlayfs/readdir.c   |  17 +++-
 fs/overlayfs/super.c     |   9 +-
 fs/overlayfs/util.c      |  75 +++++++++++++--
 10 files changed, 318 insertions(+), 120 deletions(-)

-- 
2.17.1

