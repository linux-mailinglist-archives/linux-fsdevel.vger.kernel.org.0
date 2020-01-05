Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477481307D5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAEMF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 07:05:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40226 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgAEMF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:05:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so46599010wrn.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2020 04:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H1hJLNQee379aq3/tU9tTxHeBbBKoIXcCyb5gddw+z0=;
        b=s9D99V0hhwG8BrJ6pW+LVYSffkdsoaBLwNeOukJHDMIXgSD6bHgOQzR65WF7hdzmWF
         4igDoTk2Jrc30WIXJjWsJvUibhNZACpbR9WKX7169TL7ASJL/qcm1BM/8Gb+MM4kLEe/
         VlFkIr8G08H9znscjvgmDqE19S23KbBnTyYrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H1hJLNQee379aq3/tU9tTxHeBbBKoIXcCyb5gddw+z0=;
        b=sjhOD0X1fPpcwe02UKzv/Ab3lFQYt7/1quc3ORMDSbEZGq6QQ5f+/V2fL0tPJMgkp1
         9uxQS54ONxIutxuabv6zsskMkS4SM71mvUtbj11jHjauvOTNoea5VS1OmpfLen7UH3gj
         C7an6ZVlM6nBwLLoG4ePNo9GdkC/xIPrQdtwjt4d7gFZgE0iILzdk0BbjHgDwQfDKQzA
         nbbH9xVJjqaknOY9TRYZzU/ZcmuntG/2STngo5V7YYsVjihUvPBxPBoBMNeU1NEmVKnY
         UT+ilCTXvY/mp0Lw640xRUJIgy40BpNvPDk05cn0h1aFeMw2c6rzfBz6e74XK2eQavxd
         vFaQ==
X-Gm-Message-State: APjAAAWAmFvk2bUgHIKOWQbSC49sy7hHEQJJbvbhi+JOUSZdaiFBRnVC
        FJfmaiRPEivtR9k3ZWN3Lc25kw==
X-Google-Smtp-Source: APXvYqy0G+txcVO2FRvfPrzeMAhObxnRpEQHoeswgwkjOKalPYou8MtvQe2UloqhBRZl+eSQ80pw9g==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr8357673wrv.302.1578225923244;
        Sun, 05 Jan 2020 04:05:23 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:e1d7])
        by smtp.gmail.com with ESMTPSA id p5sm69068815wrt.79.2020.01.05.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 04:05:22 -0800 (PST)
Date:   Sun, 5 Jan 2020 12:05:22 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 0/2] fs: inode: shmem: Reduce risk of inum overflow
Message-ID: <cover.1578225806.git.chris@chrisdown.name>
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

You can see how this compares to previous related patches which didn't
implement this per-superblock:

- https://patchwork.kernel.org/patch/11254001/
- https://patchwork.kernel.org/patch/11023915/

Chris Down (2):
  tmpfs: Add per-superblock i_ino support
  tmpfs: Support 64-bit inums per-sb

 Documentation/filesystems/tmpfs.txt | 11 ++++
 fs/Kconfig                          | 15 +++++
 include/linux/shmem_fs.h            |  2 +
 mm/shmem.c                          | 94 ++++++++++++++++++++++++++++-
 4 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.24.1

