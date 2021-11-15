Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60884510DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbhKOSzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 13:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbhKOSxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:53:32 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1CC0A3BDD
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 09:53:13 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k2so29766304lji.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NsJwQViYjBx6x1vnKWwbVuDzGBfSCVWT/rbaDdS07o=;
        b=KO3K519hv/U7eBTcKvTNDP2eKFUA2AUXYqJpuH3H7HpyMWbd/okypmhcyl68qsgEMB
         Tk6M3OgdZeFJesvlAB5Bhgl6XW/O9P8mk3dMd4fFh80iqqMofW9VhwiDp62KQ0N/YUUx
         kuKS6PM57Mxitv2Gso7uX6bsb3i2CsyEFARebzexwMlXFoA74eOMXb002OmB9tn9+Y85
         wR9hyRPYMFGUdQX09cuC8rvxOvFIKVUi7nFklVRic3dV6iooqaWcyuL5oVncWpD+oPvG
         mL1mSaV4SWgyrxi/iuT2d03XoYCARQJVASW7AGQBqLHs2tgGfUQfKdhwJr20mXiPSoOr
         4lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NsJwQViYjBx6x1vnKWwbVuDzGBfSCVWT/rbaDdS07o=;
        b=MpXUMWLldXTqBbr1K3pOGRWCejPNquFMmXIELRlCbWlFVo5ySt/ZDrLbtG5ck2/Aa4
         RU7sTD7OB8QRqz6q6I9o8a5M0Tr4K9bCcYJr+QfwYqd9NqRZl5pCcvsoaK/9EOjxaahk
         wTv3SON4ejYPtgiKD7xOH4L+BedoJHpWnEW6OMoTsJSiyYaXiVLb47DzX+4xh256IBdM
         6NbdM3I/1LBTfG8JbQ7SGr2O0vBFRPqTuQXyUIE3EUj7fryviASjGMtjU04iPDbohM29
         yOXV2BFCQJurdl1O0OyL6LvEuZNz04H1BclaDdV8P9RLYjd0Wn8+i5+1Bsc68LPpQHLi
         Evkg==
X-Gm-Message-State: AOAM531e9cdADwGYlGhpJO0RwQAjR6u2mrUsKjMxYdftGN8S6gmvelsk
        FMF558CCjSQ2mcGnO5tebtQET7IERiiG5Ezwz4k+8g==
X-Google-Smtp-Source: ABdhPJwhwO7vj3l7PglblWhEu/u5R0j6w6RyAXBfY3b1tMLAwK4ATaXsbDMVLHDtN2AxslDULON1DIcW72dsbChwW+w=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr448399lji.6.1636998791657;
 Mon, 15 Nov 2021 09:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com> <20211108221047.GE418105@dread.disaster.area>
 <YYm1v25dLZL99qKK@casper.infradead.org> <20211109011837.GF418105@dread.disaster.area>
In-Reply-To: <20211109011837.GF418105@dread.disaster.area>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Nov 2021 09:53:00 -0800
Message-ID: <CALvZod72uULZ1TfJbk5q-0cVTmGfBG=a5zNb69nb4A2bv+pPWA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 8, 2021 at 5:18 PM Dave Chinner <david@fromorbit.com> wrote:
>
[...]
>
> > If we are to have this for all filesystems, then let's do that properly
> > and make it generic functionality from its introduction.
>
> Fully agree.
>

Mina, I think supporting all filesystems might be a much cleaner
solution than adding fs specific code.

We need to:

1) Add memcg option handling in vfs_parse_fs_param() before fs
specific param handling.
2) Add a new page cache memcg charging interface (similar to swap).

With (1), no need to change any fs specific code.

With (2), fs codepaths will be free of memcg specific handling. This
new interface will be used in __filemap_add_folio(),
shmem_add_to_page_cache() and collapse_file().

thanks,
Shakeel
