Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CDC389C00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 05:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhETDrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhETDrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 23:47:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DCFC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 20:45:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t21so8240675plo.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsx7U7xFEMYwysEjpdGkhCMavbrgfZJA5H4Xahpf5cI=;
        b=K1wI5foB/OFwa+YxtQyl0ye+iraAQYmdC/sZ87b1fWKNRpvWVu/f99q9N6jwfkD5yl
         Iy31CmZi4cuch3FS144/63jLe29jilr2SE5Cy2AF9AOZfdQIScIY5ZP9nXWDwWtTMEgN
         RMqF0Go5He+ZYyWIp9r8jNUgQ8G+JYIYhokz8jyk35r583XRegVPp637VbVUfIJnrlU+
         zNGq4IW/pZhPe35JHlrpAmKgZibJaqDyj27wEeYRemTsvGzIhAr2i/OD4rxFGAfPfbNk
         ucGbH9k5n05eqo3ZYZv24VUePrzJ/nE6ETGEJNwJFr1A2NGW+JGSXS6Xlnm7PgA9TtRZ
         Q85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsx7U7xFEMYwysEjpdGkhCMavbrgfZJA5H4Xahpf5cI=;
        b=EjGm0cxd6qXsVjwjLsOK2QDP4vPAafkbRtgTsAb1mvHhm6YVaVA0DlqA9wXm6WXgQe
         uyaVxN1V4ZqH/2+XMPKHvePRO3XfyVS0ZzH4vFtryFqeuTGfG7WIsdcP5mOAF4qfNux8
         OFS8lXwGKrQHgFUDbFCrwj5xZKifOqe0vwJGViPBavAOmoMaIfHvjHEeHc7H+Yz6pVf9
         sHpU54J8Akokfl/TzqB7tBDJ2hFsENwCeSMQ14pJN2C2+TILuiXbTlRd9EYJIm5WSy20
         e7u+UZkyo6IwJb/77vRiLVuEw8Kvt9AGw7GSIaSzD1GwDvpfVoWBT2Rz2XhzDUz5kQnU
         0ndg==
X-Gm-Message-State: AOAM532Iixh74BB1XJaDD4T0f1oXvSbEpuhbN8GKCnl3d+LcbVoX8MYZ
        a3PdTWgJoK8L15cYtdixRRkiHBUr2iiuw1RqbNSk9w==
X-Google-Smtp-Source: ABdhPJzsTfKJ0VkQK6fxhnPimvNAb8jp7vq5SsLJdXpFeRYgoELgi5Ucv3Tv8vbqJdubvqR7ufMgTbx+6ERjqnj1yjM=
X-Received: by 2002:a17:90a:6d43:: with SMTP id z61mr2855552pjj.147.1621482359005;
 Wed, 19 May 2021 20:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210402091145.80635-1-songmuchun@bytedance.com>
In-Reply-To: <20210402091145.80635-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 20 May 2021 11:45:23 +0800
Message-ID: <CAMZfGtUZgXsNOiyR==G+zLSN91PREss=XcbcfE0COkB8APcDxA@mail.gmail.com>
Subject: Re: [PATCH v3] writeback: fix obtain a reference to a freeing memcg css
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

It seems like this patch has not been added to the linux-next
tree. Can anyone help with this? Thanks.

On Fri, Apr 2, 2021 at 5:13 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The caller of wb_get_create() should pin the memcg, because
> wb_get_create() relies on this guarantee. The rcu read lock
> only can guarantee that the memcg css returned by css_from_id()
> cannot be released, but the reference of the memcg can be zero.
>
>   rcu_read_lock()
>   memcg_css = css_from_id()
>   wb_get_create(memcg_css)
>       cgwb_create(memcg_css)
>           // css_get can change the ref counter from 0 back to 1
>           css_get(memcg_css)
>   rcu_read_unlock()
>
> Fix it by holding a reference to the css before calling
> wb_get_create(). This is not a problem I encountered in the
> real world. Just the result of a code review.
>
> Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> Changelog in v3:
>  1. Do not change GFP_ATOMIC.
>  2. Update commit log.
>
>  Thanks for Michal's review and suggestions.
>
> Changelog in v2:
>  1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.
>
>
>  fs/fs-writeback.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 3ac002561327..dedde99da40d 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -506,9 +506,14 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>         /* find and pin the new wb */
>         rcu_read_lock();
>         memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> -       if (memcg_css)
> -               isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> +       if (memcg_css && !css_tryget(memcg_css))
> +               memcg_css = NULL;
>         rcu_read_unlock();
> +       if (!memcg_css)
> +               goto out_free;
> +
> +       isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> +       css_put(memcg_css);
>         if (!isw->new_wb)
>                 goto out_free;
>
> --
> 2.11.0
>
