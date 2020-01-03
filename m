Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A270B12FB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgACRaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:30:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgACRaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:30:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so43128330wrr.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 09:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=14DHRqjq6UbdTIX5dem/5OxqwGhXov1jquEng4bxQ7Y=;
        b=CPGcTX4kIjO9icc8sWv1If3f+TsdB2RJjJRa4rP/WhdrabOprxLdiu7kwaEEiDqhLc
         Axvtqxn74Y3g2yYdougj+N9fa3lN/bzFsoLsqVXNf78yWe8bkD38SjImmHxOc5s2T8e4
         aHp8j049xZtNDnikBS4ssVIy8C8u+9JnzdpHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=14DHRqjq6UbdTIX5dem/5OxqwGhXov1jquEng4bxQ7Y=;
        b=doVCJ6yiVS7neICw0xRKOS1DhJeS1gfcgCeXquBuFG/SzfwPC7ZCTJn1gaS8r7Iftn
         HCY/gmykYalBt/f06nBVSn1NNiMTu07vQ1mOYkDtNLqyqogNlkFn9Xrn6WPTTY8QFMBZ
         eOrR9WIOwmcgAZw13qvIyy6UssfK+vzRBQUUB5Upq6FbYvU+714g3dfxSUyH2ow1OSpM
         sbBQ45EF1QL3AtLKqMC/XVdy/G+9EFi/GrZbNdBK3zUwzWFU/pnb5pdTlHrLv0UdaDD4
         BB6XVkQSAsQxY4cNJuTUtD9HRA4QxBNCLxRshT5IATbT6VSzgKg2XQ8pSZaIPBw3p/xG
         hB5A==
X-Gm-Message-State: APjAAAW6SalATaXBaebcD5q8kHN3EkfOA+ZZoXbh8RD+BPsri9gYMZn3
        3B/3ZHA4cbLJ/PuRKZXHmYfsuRBQDTimIQ==
X-Google-Smtp-Source: APXvYqyju+UyXDDEqLAN1HLw2GATxjDJNHoFZTA6nb2/tfCIV0BHMyUI5vIxNIInZsjasbglFhX2TA==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr90454955wrp.142.1578072617676;
        Fri, 03 Jan 2020 09:30:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:5238])
        by smtp.gmail.com with ESMTPSA id a9sm12339697wmm.15.2020.01.03.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:30:17 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:30:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 0/2] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1578072481.git.chris@chrisdown.name>
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

1. Moving inum generation from being global to per-sb for tmpfs. This
   itself allows some reduction in i_ino churn. This works on both 64-
   and 32- bit machines.
2. Adding inode{64,32} for tmpfs. This fix is supported on machines with
   64-bit ino_t only: we allow users to mount tmpfs with a new inode64
   option that uses the full width of ino_t, or CONFIG_TMPFS_INODE64.

Chris Down (2):
  tmpfs: Add per-superblock i_ino support
  tmpfs: Support 64-bit inums per-sb

 Documentation/filesystems/tmpfs.txt | 11 ++++
 fs/Kconfig                          | 15 +++++
 include/linux/shmem_fs.h            |  2 +
 mm/shmem.c                          | 97 ++++++++++++++++++++++++++++-
 4 files changed, 124 insertions(+), 1 deletion(-)

-- 
2.24.1

