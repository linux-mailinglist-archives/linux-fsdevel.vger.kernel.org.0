Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57F835000E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 14:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhCaMTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 08:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbhCaMSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:18:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE99C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 05:18:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t20so7803672plr.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79puKFkuL0Ca/f8+jKl6RvO/Xz4GFGg0BJvWz+166ig=;
        b=nWqJn20LNz7OtM4KwlpBbTprM5t5U6j1ix94M3zulz9xyIUlRakx3Efpi7pc2RgDl6
         jp2NxBWQur6vwq/VVFNS9QqBqy3Jyc5EFEjogl/XvtrJP0AUoSD6PBKZX/vnk83AbrjC
         3XLUC5zAHWy69ta++1VCvOGt8b/25tm1dZMp98TCz5BmFBmGmeRVx2qYHZUgp5uxG1fv
         rJWTY5KOHBVlfqVrymd/LulkvdLRnnoEr1tEDPeLjcAQy+BqHv8JOw3K5DdtP7myiFmK
         nUgFttPXkXU0niyFSVFBM13i+m9ODvM4tbMn8NrdjDmBdwY8DpAt2+M0VqOQogEQplar
         AYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79puKFkuL0Ca/f8+jKl6RvO/Xz4GFGg0BJvWz+166ig=;
        b=Z1/au358BTjkTjJtnYEvA8xfJNPCX1VL9b2iLLaM+My/bbC1ibKhsVaZoiuUxulidA
         O287AfxFtPJCFU6otMHbfAUi7MfU3lBYo0/o8SaB6Uj1268kVYSy5VSpdmZqcVMBduJ1
         GY7ux9lORQ8WILcYQV4V/2WVDfQ+COgcnJjaPs5uhGD6E3u6aCn85RHuAjzw/9zmxpVg
         rJefzlCJxPW6N2SmWDE3ArOKAvzJwC4D/kpO2AXIfa6jEAFoFYf6KWLcxL6Wikw7nAhL
         0EHzj/GK8KU4Y9dnKAxVDzDU6QGW4xSnFWAfBYHjNjgltye/XdX2qXQflNycXCBteQWZ
         Igdw==
X-Gm-Message-State: AOAM5325VNRH8YWuz4Nsh6OdZww01fqiAySLcsTrKlB/t76u9fzKuVDb
        KBMo5EiBpX8vuMcz2XzlhxOxqywnNYVEpePXlKFeVg4wsyGgYflR
X-Google-Smtp-Source: ABdhPJwWwXQ2UJQJDr3ZyFNOuVoXkPNN3+LsumCfAlhOj2ORYM9DqUS7FRdQlOR6At/aztdQHJVbL1I7y+stqCNf4Mg=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr3143629pjv.229.1617193118215;
 Wed, 31 Mar 2021 05:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210330092933.81311-1-songmuchun@bytedance.com> <20210330113447.GM351017@casper.infradead.org>
In-Reply-To: <20210330113447.GM351017@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 31 Mar 2021 20:18:01 +0800
Message-ID: <CAMZfGtXmj+S+Y7s_7-6tvgSqzseT4K4E9t6xevsNajusVV0-ng@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] writeback: fix obtain a reference to a
 freeing memcg css
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 7:34 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 30, 2021 at 05:29:33PM +0800, Muchun Song wrote:
> > +++ b/fs/fs-writeback.c
> > @@ -506,8 +506,10 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >       /* find and pin the new wb */
> >       rcu_read_lock();
> >       memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> > -     if (memcg_css)
> > +     if (memcg_css && css_tryget(memcg_css)) {
> >               isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> > +             css_put(memcg_css);
> > +     }
> >       rcu_read_unlock();
> >       if (!isw->new_wb)
> >               goto out_free;
>
> This seems like an unnecessary use of GFP_ATOMIC.  Why not:
>
>         rcu_read_lock();
>         memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
>         if (memcg_css && !css_tryget(memcg_css))
>                 memcg_css = NULL;
>         rcu_read_unlock();
>         if (!memcg_css)
>                 goto out_free;
>         isw->new_wb = wb_get_create(bdi, memcg_css, GFP_NOIO);
>         css_put(memcg_css);
>         if (!isw->new_wb)
>                 goto out_free;

Thanks. I will reuse this.

>
> (inode_switch_wbs can't be called in interrupt context because it takes
> inode->i_lock, which is not interrupt-safe.  it's not clear to me whether
> it is allowed to start IO or do FS reclaim, given where it is in the
> I/O path, so i went with GFP_NOIO rather than GFP_KERNEL)
>
> (also there's another use of GFP_ATOMIC in that function, which is
> probably wrong)

Do you mean the allocation of struct inode_switch_wbs_context in
inode_switch_wbs?
