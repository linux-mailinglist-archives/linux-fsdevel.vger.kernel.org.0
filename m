Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828E6302E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbhAYVsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbhAYVia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:38:30 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53555C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 13:36:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so9158380pfu.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 13:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbflCwsTzdwckYq+nt69B7PshniTZLSQZH2EgtCpbjY=;
        b=MisYfjeV1+yJJ3EyNZVbYKhxvcL1wdfp1GqYzgg9aS0kBU94oBe/N6zUSbMWDLG830
         YkS4v+Hst0dNPffxnmExEbjnK45EgbnlofP9DWgU9FUMyW7mg7h8fvOUG7UPxTS7Wgbt
         gTyEQcQLXFphymi9GsX8nBAPRJ5l1X40+e5JdBLk7YkXcbswQjYIckZtHxkDbKKnEtNZ
         ynMGBjJtS2gGBxzv7q7q2G4T8oTW0b5iadd7f77fpVH9Xgyrzo0SciZMPTIwdKPhETJ5
         xjJ4T2hW2j/jbGFHJGfWlsK3nguhKrfxqsgWC7zzs4RiYUHpy67GR/d4cdpgkewwejQA
         +nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbflCwsTzdwckYq+nt69B7PshniTZLSQZH2EgtCpbjY=;
        b=sQePuONmGuV6ghdD2T267n74OreiopkIRSAr/SCAp6e75McLaanewGZbU1FtGRFSm9
         HVm3APB7LRYiQLfAMNmZFwO5ZvpMFVBghaWl4N5J/GNErcDjK9CBqakIHwVGeYMC1H4M
         kccsyhl/sXin/dfgy+DQt4rHhVrGI2HGt1Z2Zk3hc3hU9PC/x+FgY7bXJBnZ94W8MDTS
         YF8XOoLDwq0QAZD5x0DwxKwSIgUynOcGfXyn0YNChbQiOO57CAps7GokUyqkumtbx9Wx
         HbptvP7K+q41FtYWLnfbGzcZCYwEdk2vr8Zu1eG77ub8GfhipNsGIhXfVGKbyuz242nv
         rpQQ==
X-Gm-Message-State: AOAM533rdwXOCZsXQT9x05a2+GaxUDKCGM/lo6fgsazd7LDLawpxvRmT
        mmvahLuqpJZg7J1eWG/5g/3j0EQf3MBnKQ==
X-Google-Smtp-Source: ABdhPJyi3f44AaldZMWwmJEJwDD7SHMh1XbqHzmCX87Sv4/Q9ziBfSw/HSo3aH7WyjHYY/jwk5ojGw==
X-Received: by 2002:a62:7e46:0:b029:19e:786b:9615 with SMTP id z67-20020a627e460000b029019e786b9615mr2274628pfc.37.1611610581555;
        Mon, 25 Jan 2021 13:36:21 -0800 (PST)
Received: from localhost.localdomain (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i3sm9638913pfq.194.2021.01.25.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:36:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET RFC] support RESOLVE_CACHED for statx
Date:   Mon, 25 Jan 2021 14:36:11 -0700
Message-Id: <20210125213614.24001-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is a followup to the RESOLVE_CACHED addition that allows us to
speedup the io_uring open side (and enable RESOLVE_CACHED through
openat2). Mostly straight forward, as you can see from patch 1, this
just adds AT_STATX_CACHED that sits on top of that. Patch 2 is the
mostly ugly part, but not sure how we can do this any better - we need
to ensure that any sort of revalidation or sync in ->getattr() honors
it too. Patch 3 is just adapting to this in io_uring.

 fs/9p/vfs_inode.c          |  2 ++
 fs/afs/inode.c             |  3 +++
 fs/ceph/inode.c            |  2 ++
 fs/cifs/inode.c            |  3 +++
 fs/coda/inode.c            |  7 ++++++-
 fs/ecryptfs/inode.c        |  3 +++
 fs/fuse/dir.c              |  2 ++
 fs/gfs2/inode.c            |  2 ++
 fs/io_uring.c              | 21 ++++++++++++++-------
 fs/kernfs/inode.c          |  8 +++++++-
 fs/nfs/inode.c             |  3 +++
 fs/ocfs2/file.c            |  3 +++
 fs/orangefs/inode.c        |  3 +++
 fs/stat.c                  |  4 +++-
 fs/ubifs/dir.c             |  7 ++++++-
 fs/udf/symlink.c           |  3 +++
 fs/vboxsf/utils.c          |  4 ++++
 include/uapi/linux/fcntl.h |  2 ++
 18 files changed, 71 insertions(+), 11 deletions(-)

-- 
Jens Axboe


