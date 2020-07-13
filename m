Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEB321DB63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgGMQPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgGMQPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:15:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB8CC061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:15:34 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bm28so12176920edb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qYE0MGzN5oZiWXIC6Rq6ejY3VVjgiXoPpvYjyKeBdiI=;
        b=dqAuVp/Md6dltU2+wWd9YmXmJl0gjR4sK5zDAvjpTsJSVJFEJFpBOpTEFPSYpZrDap
         FvgwvNzH7PYXXjZj0kRjjJYnHYbr40UVkpwOFFuDRfDDDHTwKOApy25cUst736JqiSEN
         1pXb/1YwmZ1btxsaqDTInRVQlHzc3Smv65CFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qYE0MGzN5oZiWXIC6Rq6ejY3VVjgiXoPpvYjyKeBdiI=;
        b=JeBLISV8n1qfUeh6aU7icvfL7EtDGP8NE0krryUbB8ZMaYdPa03N4wBCSHQwI0OjY7
         E/ePhwZqcaJPtYdwd6Y9EdwWWSpeTBU+OgU/bdLunpqN2h1l9Ej0PYy1p4TFictvPlO7
         nxTLrgIpaqjbnvoiLtTjxaQ0gcGSe+mEFaIjIp5BxzIyEuKNk1lJYtiMfiTgI7tM8iLr
         byUjR/vYEzeyBe52ehZiZq8ntzaNLEJWweb35nzqpUAZ0setE5cPSljBnt9EBHWQEYH1
         dfVENViwHa8FEl1iVmYFs8hQKCOvpzDcLiin8/aVPQKamBGvSa5JU0OICI0HuQm5YkYk
         YePg==
X-Gm-Message-State: AOAM531R1o7fonY2NUnoyekR/8T/tb+EJxjlsbcIxhjubbFWeJy8txeU
        E4MP4qD1WDLSrxBe6ZYXkGU43g==
X-Google-Smtp-Source: ABdhPJzsRdZY8noRNZwAyszwwF9P9Y/ARLnpJW6z3ijXs5crRBCn6Voi+/JfVOJDz2petEtU+vf66w==
X-Received: by 2002:a50:bf09:: with SMTP id f9mr133964edk.249.1594656932825;
        Mon, 13 Jul 2020 09:15:32 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id n9sm12163985edr.46.2020.07.13.09.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:15:32 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:15:32 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 0/2] tmpfs: inode: Reduce risk of inum overflow
Message-ID: <cover.1594656618.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
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

Changes since v5 (it's been a while, eh?):

- Implement percpu batching for SB_KERNMOUNT at Hugh's suggestion.
- Hugh also pointed out that user-exposed tmpfs can also now have
  max_inodes == 0, so we have to account for that. I just use
  SB_KERNMOUNT to do that in all the places we used to look at
  max_inodes.

Chris Down (2):
  tmpfs: Per-superblock i_ino support
  tmpfs: Support 64-bit inums per-sb

 Documentation/filesystems/tmpfs.rst |  11 +++
 fs/Kconfig                          |  15 ++++
 include/linux/fs.h                  |  15 ++++
 include/linux/shmem_fs.h            |   3 +
 mm/shmem.c                          | 127 ++++++++++++++++++++++++++--
 5 files changed, 166 insertions(+), 5 deletions(-)

-- 
2.27.0

