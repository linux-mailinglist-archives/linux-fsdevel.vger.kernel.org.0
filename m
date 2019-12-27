Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A629012B534
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfL0OaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 09:30:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50890 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0OaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:30:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so8192427wmb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZFCfc1E7yMgcAJciG6l7dUXwZ4x3kLHqDvF2Arxg6ok=;
        b=w9o/nJsPLEOZSknlgauPuVKVe6LOkPke3OkKZ37AjiUGmp/AkEXZEuXrxMD7RQv+G8
         2RHWwrAzu24af2Z8L0DQF+tHRJPMWogK9IMdrwjZBD1pjLyDP6m5oy4pHRMHPyA/qeR8
         OEObU/setq5dk3ViZdzgaInvyTULCBnpdaz8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZFCfc1E7yMgcAJciG6l7dUXwZ4x3kLHqDvF2Arxg6ok=;
        b=ZoTjQSUQIgJZ8rZRZrp4YvxfGfeJd6QQyHHy9bqrhDyI6D8MXfrZjOwKQWi6rCEPPd
         nEQEbzNDhmrmCJRuxMJiAi7uP278IUkdf9rXj6GUFGRAL7RfHXUYE6+SM60TWgV4WFd/
         YnyGnh1qPX3vxsLwKM7I5NZ3UcDuUQbbEDol01gtX/LviMHfbNm/pDsbg1N/mnDFpLWa
         kWHoo91XUG3PV4EeHrAOuYChSyw7FhELtf+8K8/Nak3hQ1EiyBKla4UVkebJwjt3NxJI
         HOD/LX86MIZtGkT4PKHZqxsAE2QNAYO3msVQ6yXymo99I1MgiOMXDNjald2xTotTK3si
         63/g==
X-Gm-Message-State: APjAAAUUHiWDyuXAJkTumDP//4cnKQlpROE6KdrRO1QiZLY6QX8oIIjL
        SPss+wR9CarRioR27VxVASoZm86BwjQ=
X-Google-Smtp-Source: APXvYqxPbJElumJDEtj6YlLoG4Wb/u5ns4UMg0mSV00CIeRPUgm6IEtUZLuJZwso0srFCCR1nARitw==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr20827094wmg.66.1577457003393;
        Fri, 27 Dec 2019 06:30:03 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id s8sm33745752wrt.57.2019.12.27.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 06:30:02 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:30:01 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/3] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1577456898.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In Facebook production we are seeing heavy i_ino wraparounds on tmpfs.
On affected tiers, in excess of 10% of hosts show multiple files with
different content and the same inode number, with some servers even
having as many as 150 duplicated inode numbers with differing file
content.

This causes actual, tangible problems in production. For example, we
have complaints from those working on remote caches that their
application is reporting cache corruptions because it uses (device,
inodenum) to establish the identity of a particular cache object, but
because it's not unique any more, the application refuses to continue
and reports cache corruption. Even worse, sometimes applications may not
even detect the corruption but may continue anyway, causing phantom and
hard to debug behaviour.

In general, userspace applications expect that (device, inodenum) should
be enough to be uniquely point to one inode, which seems fair enough.
One might also need to check the generation, but in this case:

1. That's not currently exposed to userspace
   (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY on tmpfs);
2. Even with generation, there shouldn't be two live inodes with the
   same inode number on one device.

In order to mitigate this, we take a two-pronged approach:

1. A mitigation that works both for 32- and 64-bit inodes: we reuse
   inode numbers from recycled slabs where possible (ie. where the
   filesystem uses their own private inode slabs instead of shared inode
   slabs), allowing us to significantly reduce the risk of 32 bit
   wraparound.
2. A fix that works on machines with 64-bit ino_t only: we allow users
   to mount tmpfs with a new inode64 option that uses the full width of
   ino_t. Other filesystems can also use get_next_ino_full to get
   similar behaviour as desired.

Chris Down (3):
  fs: inode: Recycle volatile inode numbers from private slabs
  fs: inode: Add API to retrieve global next ino using full ino_t width
  shmem: Add support for using full width of ino_t

 fs/hugetlbfs/inode.c     |  4 +++-
 fs/inode.c               | 44 +++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h       |  1 +
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 41 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.24.1

