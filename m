Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F25129D07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 04:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLXDEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 22:04:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36953 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXDEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:04:23 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so9262495ioc.4;
        Mon, 23 Dec 2019 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYZhtmD+9NUOzLwE4DFDXgTJzhRtHeQxHMYH/iS7zTg=;
        b=GtqZ/SMOo36thoZU+8R+cZitg8ycgYRxrL/6kquEe+itVLv6GaDb5VQsU3/P1YDwjp
         QCCISU1WVoaJ43Cfd/tTKWlxLEGflSIbVzYl7GRlkofOZWL7Yz0oTl8XJeglS4PWJ/Dk
         vmy0XuFySBPplrSQ9z/jxURdiX9f4IBn7oAX/CV7Z23Dq+CVnEcgVN9qBA9Q1lNW6EPa
         vH4v1sxMW653eZZnVlaX8ZX0QltvW7YOHDsHRIfHMTFtx/46GthozQlIIBzjJqxVs6WO
         6QgQgTCCYdvVJCEIbPajbdCzndjGcPMJymJfD1uyzC5vvh58wCdOaFyvKNQfFyroB3yF
         nHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYZhtmD+9NUOzLwE4DFDXgTJzhRtHeQxHMYH/iS7zTg=;
        b=VnVLMyoofA3kclaNXGCaJUrm+wK9l+tmGiktep+NkxyDXsjz8X6SydDUWMpCmeSY2W
         Qr+jBFw79dCB3R5Y7YQp2Kolid15H1thzjzr0zjzJCbYN/V+/yp90XZv+S6v0HhXwJ6r
         FEjQVUDGM57HMB9rc8oaWv8k07luWYz6NmMpEbDOlWAAmutGsCAGZ1R4F1emJ1W6AMci
         yozyniUlpCLzIt9G+gQZnU4ZoSj5cHWl2qEMMEaz+EzaV4Me91WIyXUCzRhM6hi1G6ZU
         xTL/A9tj0vuh2aoUKuT57P0Gvsr4qGtQVu/r/rULGwtOu46S/4UpAxSWMo5sdC54uGHB
         9Ssg==
X-Gm-Message-State: APjAAAU7NMKdn4n5wwwhGen4x4L5ABU7vWW2E1SZKbHY4hIhjdgoQnPg
        /KO6ajFGBKzwa+MfXg9HVhbBXwaeJrQqYmRvQBs=
X-Google-Smtp-Source: APXvYqxNJpyvPf0M59389mxT+myYRm4xzwa48U6muH+RL2eRVXW4c6c+uQjL6n2XIeh+OAp91AJnAC/BvyEUaNL19HI=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr23268086iob.9.1577156662858;
 Mon, 23 Dec 2019 19:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20191220024936.GA380394@chrisdown.name> <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name> <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
 <20191220164632.GA26902@bombadil.infradead.org> <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
 <20191220195025.GA9469@bombadil.infradead.org> <20191223204551.GA272672@chrisdown.name>
In-Reply-To: <20191223204551.GA272672@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Dec 2019 05:04:11 +0200
Message-ID: <CAOQ4uxjm5JMvfbi4xa3yaDwuM+XpNOSDrbVsHvJtkms00ZBnAg@mail.gmail.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
To:     Chris Down <chris@chrisdown.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "zhengbin (A)" <zhengbin13@huawei.com>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The slab i_ino recycling approach works somewhat, but is unfortunately neutered
> quite a lot by the fact that slab recycling is per-memcg. That is, replacing
> with recycle_or_get_next_ino(old_ino)[0] for shmfs and a few other trivial
> callsites only leads to about 10% slab reuse, which doesn't really stem the
> bleeding of 32-bit inums on an affected workload:
>
>      # tail -5000 /sys/kernel/debug/tracing/trace | grep -o 'recycle_or_get_next_ino:.*' | sort | uniq -c
>          4454 recycle_or_get_next_ino: not recycled
>           546 recycle_or_get_next_ino: recycled
>

Too bad..
Maybe recycled ino should be implemented all the same because it is simple
and may improve workloads that are not so MEMCG intensive.

> Roman (who I've just added to cc) tells me that currently we only have
> per-memcg slab reuse instead of global when using CONFIG_MEMCG. This
> contributes fairly significantly here since there are multiple tasks across
> multiple cgroups which are contributing to the get_next_ino() thrash.
>
> I think this is a good start, but we need something of a different magnitude in
> order to actually solve this problem with the current slab infrastructure. How
> about something like the following?
>
> 1. Add get_next_ino_full, which uses whatever the full width of ino_t is
> 2. Use get_next_ino_full in tmpfs (et al.)

I would prefer that filesystems making heavy use of get_next_ino, be converted
to use a private ino pool per sb:

ino_pool_create()
ino_pool_get_next()

flags to ino_pool_create() can determine the desired ino range.
Does the Facebook use case involve a single large tmpfs or many
small ones? I would guess the latter and therefore we are trying to solve
a problem that nobody really needs to solve (i.e. global efficient ino pool).

> 3. Add a mount option to tmpfs (et al.), say `32bit-inums`, which people can
>     pass if they want the 32-bit inode numbers back. This would still allow
>     people who want to make this tradeoff to use xino.

inode32|inode64 (see man xfs(5)).

> 4. (If you like) Also add a CONFIG option to disable this at compile time.
>

I Don't know about disable, but the default mode for tmpfs (inode32|inode64)
might me best determined by CONFIG option, so distro builders could decide
if they want to take the risk of breaking applications on tmpfs.

But if you implement per sb ino pool, maybe inode64 will no longer be
required for your use case?

Thanks,
Amir.
