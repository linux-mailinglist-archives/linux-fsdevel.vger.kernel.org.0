Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E8123C41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLRBNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:13:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34053 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRBNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:13:50 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so217255iof.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 17:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWW1R8ZCDToBc/PK6L9Ink23+g9Ne4wMqodrYhzn0C0=;
        b=SiwRAc36jE4Lc/JY3ghiKg/tcM8SPGmCv19BkUAhWFYaNdYf3AACGPQUatyudC3hFm
         7aNOqZmHVEHNTvcdFSaUdAEUeLue/wElkCpZe6+Y60+VgwNsWfmv7nVOWhe5ldFIv3S+
         SX9/yBmPBqyYSmoiKqM3lpKS3w/dmGZf+N6k+qZMzh6SVumY1OCG5G4Okp1GMv5UPxlx
         4bdTyqO3cQrRkwPM3ea3nWyrIizkjNOCFJxyd1oY47re2jAna6IPM/NhosmPDkbDD4nI
         sVKhjDGDEwPSbp8yM4mNgzDp4A2zI6108/iU2z65n2+0ADC6kXmnzj46yuLLOP6P29B8
         CDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWW1R8ZCDToBc/PK6L9Ink23+g9Ne4wMqodrYhzn0C0=;
        b=T7P7AVtrGE9/BXtR5qdG0Qm1pMjxIkbQRSguyJ2NGjuiTmNOJSX76i8j5JwuahOsus
         y/my3AV5b6YqAngZbQUIeh+aZpyNX6QlsMS7Yhxgh7lI2ilhp2CAoIuNM9hsXpRxxLaV
         WWHgeZbqDLDDdX6JHOKekEY6KEG1gsY1Ze09lG88oXEX9N0Iwi3ex4QAu+LwKdrGxhkr
         kLBsbyqz+hL8v5B6hExHObL0nG/Y/aK6DiV3APktxCgPgIFHTHDkJa9hApicSjiGb0ZS
         XEzzJtrw905EAEhBX1LVnN82OBX4P+mpPqOFWYgnUnkf8GVcZqeiFCPXNgkOUm8CBv5V
         W+zQ==
X-Gm-Message-State: APjAAAUGHVWl+aYwwM7QR0PvdpshL6CzGOAStQoR/q/H85Pnjnri4MZn
        BxUvm/tn1nPTZP7gi7wMbOhKQlWROVoMhwzaSRVcCjWN3AY=
X-Google-Smtp-Source: APXvYqziSFYYXXDWN9RnCFdOIvkGq+RFr1tXgyvHE4ueUnj2jxDrAN/qw4qeBG5GL+j+CuUVCdpmsgoB4aEuOyBBlKo=
X-Received: by 2002:a02:856a:: with SMTP id g97mr9572jai.97.1576631629836;
 Tue, 17 Dec 2019 17:13:49 -0800 (PST)
MIME-Version: 1.0
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <1576582159-5198-4-git-send-email-laoar.shao@gmail.com> <20191217142050.GA131030@chrisdown.name>
In-Reply-To: <20191217142050.GA131030@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 18 Dec 2019 09:13:13 +0800
Message-ID: <CALOAHbBsrbKkgHEYGPj4aX+fqmLqMHv45hHxYiEG6S7=_pqFvg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm, memcg: reset memcg's memory.{min, low} for
 reclaiming itself
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:20 PM Chris Down <chris@chrisdown.name> wrote:
>
> Hi Yafang,
>
> Yafang Shao writes:
> >memory.{emin, elow} are set in mem_cgroup_protected(), and the values of
> >them won't be changed until next recalculation in this function. After
> >either or both of them are set, the next reclaimer to relcaim this memcg
> >may be a different reclaimer, e.g. this memcg is also the root memcg of
> >the new reclaimer, and then in mem_cgroup_protection() in get_scan_count()
> >the old values of them will be used to calculate scan count, that is not
> >proper. We should reset them to zero in this case.
>
> If the memcg in question is passed as "root" to mem_cgroup_protected with a
> child as the new "memcg" argument, then I still don't see what is wrong.
> mem_cgroup_protected must be called top-down from the root of the hierarchy in
> order to work already, which we already do in shrink_node_memcgs. This will
> already update the tree's cached effective protections properly, as far as I
> can see.
>

Right.

> As such I'm not sure I understand what you mean in the changelog or in the
> patch. emin/elow as a mechanism is already intended to be racy/best-effort,
> since by the time we get to doing work it's always possible that reclaim
> eligibility state changed, and callers have to consider that.
>
> Could you please explain further the situation you're trying to guard against?
> Thanks.
>

Considering bellow case,

         root_mem_cgroup
           /
        A   memory.max=1024M memory.min=512M memory.current=800M

Once kswapd is waked up, it will try to scan all MEMCGs, including
this A, and it will assign memory.emin of A to 512M.
After that, A may reach its hard limit(memory.max), and then it will
do memcg reclaim. Because A is the root of this reclaimer, so it will
not calculate its memory.emin. So the memory.emin is the old vaule
512M, and then this old value will be used to in
mem_cgroup_protection() in get_scan_count() to get the scan count.
That is not proper.

Right ?


Thanks
Yafang

> >Cc: Chris Down <chris@chrisdown.name>
> >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >---
> > mm/memcontrol.c | 11 ++++++++++-
> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >
> >diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >index f35fcca..234370c 100644
> >--- a/mm/memcontrol.c
> >+++ b/mm/memcontrol.c
> >@@ -6287,8 +6287,17 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> >
> >       if (!root)
> >               root = root_mem_cgroup;
> >-      if (memcg == root)
> >+      if (memcg == root) {
> >+              /*
> >+               * Reset memory.(emin, elow) for reclaiming the memcg
> >+               * itself.
> >+               */
> >+              if (memcg != root_mem_cgroup) {
> >+                      memcg->memory.emin = 0;
> >+                      memcg->memory.emin = 0;
> >+              }
> >               return MEMCG_PROT_NONE;
> >+      }
> >
> >       usage = page_counter_read(&memcg->memory);
> >       if (!usage)
> >--
> >1.8.3.1
> >
