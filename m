Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC612EA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 19:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgABSsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 13:48:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgABSsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:48:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so40171400wro.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=l3OFUy01IjMTwLawSkNlT+41eTpZsTGyEW7Ge4pw1qY=;
        b=qtNWNXMMQTNt7Sb4Zvbx17CBYbUPk2/vRRHkvI75iGywSr+V5K8Gv2PuD7pJrMYRaq
         6rsyHiNoZP1LGcEBaYTmWq7MVC3j1+MZrfiBJVJ3yX8cXmSGmjZGlFzEtjDxQ3ugLkjO
         krmzdDTn460P90D+mSKzb5LwTQkGd4LsBXwZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=l3OFUy01IjMTwLawSkNlT+41eTpZsTGyEW7Ge4pw1qY=;
        b=fxuKRUHAG6RZR3WAtN8wDIZbzIw0I1/ae7w2XSXTSEM7tUmYVtX5R1vUA9j13a66k6
         dUf3yeEX3UbiTHawULXz4aurrQ/uOBpQr8q1FLYICexSXRFPTl1+Z6GsqNuru0IlSfKH
         5SWpdcArudBaQufExwfBb+qgDkSZb1lbaFbcwoJRfWcnmQh32UzW17/69BZImqwXPHoB
         2F+xkdtXV8pPWzaHjBjI7GmVRcm1sQcDf4Uy2gpIyAGlwsAQhyo8w43Q+eslvXP84FWV
         isTLv2xHM/ZFAv/AjcLjvPjAYy/93f5trdFVFiWMfkE1Q2rxethYrTacGBtJLFbf8tfr
         onkg==
X-Gm-Message-State: APjAAAV9PQYs5ap8RREcJBXrB8sa1Dp/WHIUTHnrkuRT9OXMsSS7uyYZ
        4+yYEYkWKyakXO4f14omHQT7BkEN0jzQ+g==
X-Google-Smtp-Source: APXvYqy1UAmfBdnjTWdf3/Z+GH+D1RLQd7a2V36/mVwYTjcK5sdem56Dc/B4rWSGbykqPRb8SzE/Ig==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr80050680wrs.217.1577990930961;
        Thu, 02 Jan 2020 10:48:50 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:3256])
        by smtp.gmail.com with ESMTPSA id n1sm56012389wrw.52.2020.01.02.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:48:50 -0800 (PST)
Date:   Thu, 2 Jan 2020 18:48:50 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/2] tmpfs: Reduce risk of inum overflow
Message-ID: <cover.1577990599.git.chris@chrisdown.name>
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

 Documentation/filesystems/tmpfs.txt |  11 +++
 fs/Kconfig                          |  18 +++++
 include/linux/shmem_fs.h            |   2 +
 mm/shmem.c                          | 110 ++++++++++++++++++++++++++--
 4 files changed, 133 insertions(+), 8 deletions(-)

-- 
2.24.1
