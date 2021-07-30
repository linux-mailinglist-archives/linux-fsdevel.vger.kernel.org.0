Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169763DB46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhG3HXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbhG3HXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:23:01 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5EC0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:22:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id k7so8539711qki.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=W19ulHdbRii8uGULgM4xCYIrYZn/kkVxbVYhZIEWkWk=;
        b=IWpcSmeCeF6GGdHsOxfv5cO5VtTb2UpZlZv2kMHjrK1vD6llmIA49c41Kip/TzTPQC
         8pyBPuaKLUt3CjflHMs0OcSM+lv74B8UjBe+RIJUDmnzvVHB/Bbg4VUAjDXfXjK+BcTp
         MmJPREd21f/WQPa3PW2F8+95/NsMu7LXr6OSruWBxnRNlia9jC4qRKe3RsVg1R5wuih3
         94Y2iPdQjcGv3Xae+Nov4IWLssQ3IhpyOAHDgRmhqziDfcNMB3WJ1I7WzK5+NhU6zq/F
         4BrZa229o2W9RrXccNVRCyv1J+u+UhtBoHYbQWfKC0saEpi1N9y2FUBDFT2sA+xQVltK
         DKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=W19ulHdbRii8uGULgM4xCYIrYZn/kkVxbVYhZIEWkWk=;
        b=QLxd44dgI9geT7IW3/Atf0BEBJO3IyWSiP+34VIZOOMU6TFUS+w4eveDZDGxzqL+K/
         vdKc0EAHZ++P8QXVTBlJXvsO2pjMwMlBWjCRxS9VHiMekyCEcEcsZlJiMR49670j1nCc
         hdeTKEbKH9euge/3YGYys6gcuFx490paKEJK4j9xfzkJQoHHDGXZAzxHuIREZnPY8lpA
         OXQXP0JNjNmcizU/eAY+EJeJsKJiBz9Yla6dVodl9M8LEe2SrX38aVVWSZ9GoPzLJU06
         9YAZh3wdsoUHAwR911AEscRowQMk2wRodCfk+Kj5KKSAt3SxvH/pmnNiXC7iTSz+FXKb
         CJOQ==
X-Gm-Message-State: AOAM5314f+QwrWJYsEa4lzb88reVBXLnOZCOGE67ciSV6HWslFwqxVBw
        4SBEoGbwmx2xF+QLXXqiQgVQiQ==
X-Google-Smtp-Source: ABdhPJykA6Jb3yBOp5zc/TcieykN44zj2IVlu/Hldx8zKyLBorE+22RYQHjNgr4D6QAgGwOovh/0Sw==
X-Received: by 2002:a05:620a:1227:: with SMTP id v7mr998851qkj.3.1627629776350;
        Fri, 30 Jul 2021 00:22:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b204sm490194qkg.76.2021.07.30.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:22:55 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:22:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 00/16] tmpfs: HUGEPAGE and MEM_LOCK fcntls and memfds
Message-ID: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A series of HUGEPAGE and MEM_LOCK tmpfs fcntls and memfd_create flags,
after fixes (not essential for stable) and cleanups in related areas.

Against 5.14-rc3: currently no conflict with linux-next or mmotm.

01/16 huge tmpfs: fix fallocate(vanilla) advance over huge pages
02/16 huge tmpfs: fix split_huge_page() after FALLOC_FL_KEEP_SIZE
03/16 huge tmpfs: remove shrinklist addition from shmem_setattr()
04/16 huge tmpfs: revert shmem's use of transhuge_vma_enabled()
05/16 huge tmpfs: move shmem_huge_enabled() upwards
06/16 huge tmpfs: shmem_is_huge(vma, inode, index)
07/16 memfd: memfd_create(name, MFD_HUGEPAGE) for shmem huge pages
08/16 huge tmpfs: fcntl(fd, F_HUGEPAGE) and fcntl(fd, F_NOHUGEPAGE)
09/16 huge tmpfs: decide stat.st_blksize by shmem_is_huge()
10/16 tmpfs: fcntl(fd, F_MEM_LOCK) to memlock a tmpfs file
11/16 tmpfs: fcntl(fd, F_MEM_LOCKED) to test if memlocked
12/16 tmpfs: refuse memlock when fallocated beyond i_size
13/16 mm: bool user_shm_lock(loff_t size, struct ucounts *)
14/16 mm: user_shm_lock(,,getuc) and user_shm_unlock(,,putuc)
15/16 tmpfs: permit changing size of memlocked file
16/16 memfd: memfd_create(name, MFD_MEM_LOCK) for memlocked shmem

 fs/fcntl.c                 |    8 
 fs/hugetlbfs/inode.c       |    4 
 include/linux/mm.h         |    4 
 include/linux/shmem_fs.h   |   31 ++-
 include/uapi/linux/fcntl.h |   17 +
 include/uapi/linux/memfd.h |    4 
 ipc/shm.c                  |    4 
 mm/huge_memory.c           |    6 
 mm/khugepaged.c            |    2 
 mm/memfd.c                 |   27 ++
 mm/mlock.c                 |   19 -
 mm/shmem.c                 |  397 ++++++++++++++++++++++++++-------------
 12 files changed, 370 insertions(+), 153 deletions(-)

Hugh
