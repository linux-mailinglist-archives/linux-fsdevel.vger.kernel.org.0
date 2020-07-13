Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F121DEB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgGMR2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMR2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF34C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so18149706ejb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pH1K2vUzPfJhwEBVdOMPKdK/A94n7hLqQfvszT16hv4=;
        b=NRegjh3LBWDlrzUeOyPaQJxImhcWMjvignzs5E6UY4PzLSDkmPbyXeWAHNwJECOTmS
         cwenOTW+EsLhulDrayiQ/2zwo5NgqG4xyARuMoN+FCHCM4FS8fduE6c0yLQ92Dik+fN9
         qPQsCSXMlAdYzgiDDf30IbAHXQyAltxf+sHHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pH1K2vUzPfJhwEBVdOMPKdK/A94n7hLqQfvszT16hv4=;
        b=saKL4Z7oTkKKYvHLlF3jf1UVkuvIcpDSM7dkK79UEVbtGgUGHnNzflN5OJm2hleKKw
         2r8TM1SpsQm6O5nCKMyyruaAV1mvR1CrFjNmelbANfdOlSdEwyqqdizy1tBGxMwpJHrK
         C641bnt1y73Q8NgZ0iNfJ9m7BEXeJ1Xhh/qwK3gGTX4moiLqSPfFnf9/52s2+9JYGMYq
         Fjj7hrTJHsH8yk/v9hm8Zy7mvtpWo3ywUPcQ7yTNMvLYX5L2bsWjpW0JRCvN68VMQwQ1
         rxHtUZpW6yOh6B7ff6h4vWU6hAZh81IMxfppjbMRj1kJM5Mo/HRhV3bnzIaT3JgS/lKw
         J18A==
X-Gm-Message-State: AOAM531zNUH5nHXCTn51nlHTn98T1DBQ4e3Df/8ye6pL6TjqhwTzZFvT
        2IsRrjCnyqNAguh5VFsF5wl+yg==
X-Google-Smtp-Source: ABdhPJxBuP+bUAv3rzAwsjjREEpJYKQWi2Eub0eeBpMQBkIX2vw77IaPWiNeyjfA4TaX3+SHhnNC/g==
X-Received: by 2002:a17:906:9244:: with SMTP id c4mr796991ejx.60.1594661288807;
        Mon, 13 Jul 2020 10:28:08 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id b14sm10150344ejg.18.2020.07.13.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:28:08 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:28:08 +0100
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
Subject: [PATCH v7 0/2] tmpfs: inode: Reduce risk of inum overflow
Message-ID: <cover.1594661218.git.chris@chrisdown.name>
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

Changes since v6:

- Fix misalignment in percpu batching, thanks Matthew.

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

