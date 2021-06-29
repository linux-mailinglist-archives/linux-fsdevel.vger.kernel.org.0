Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0823B6CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 05:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhF2DJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 23:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhF2DJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:09:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9109C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 20:06:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g4so11550827pjk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDErPNTHeqAsnL4tn8YCrZnI3XrNMmZNrANksxZDwvQ=;
        b=ZIqb2ZZZTUFurFu4691iz5Ngf0kUICuOc8bjbHPTf+JEnONt8e6UboHwC8bfH7qOdi
         Xeol6nlo0CCEsy8YSYxrCScYIscTyIqviA62dp6T3xHnczCKUNDgIJCVLbWznaQ10Qr/
         277H2OOtSDyc/Ui/d/wdowOSrZSztbwMlHuCythTWaL7+ZIOQ0oxshAS6Jhl70284IVO
         mAVx0jpKt/fGLN5yn0yV30CyJX0OeN+F46brDgxqfuiRGTx+H/oqNkj1xoaZrTT4bK7e
         nMj7J7cFQDHbAT7cuMcTK7LCxnC9dGea/8cySFdN4tVnomzJl1Y90SbBfNcTnGXR05OR
         bgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDErPNTHeqAsnL4tn8YCrZnI3XrNMmZNrANksxZDwvQ=;
        b=Ym2u2JQLqNw+FNsHBIc0oJICxviMza1IZozPEr0knlj+k2svt+UaUpfbo2WJy/qT5/
         zF0XGwyipe900D4gwQou0UV0AqlOhGMKoqZvo4zNVrSvZRB55Jb5Ke6kLhU/lQMjoBZe
         q44RIX6leJBZLSRZ23WCNBBvGy/JTGHSiUfh1F86pi9RBEpbX0q0rUuzcdkynr5EsFhv
         TNtzl9us9Mno+nHyUQVF4jwDWQQ/z6Q4XIE2tW2khHZ75sQV+Ki/erGG95Cnhodo2nzz
         mdwxgASt0H+k+PJM0B8Sh+TBXxGP4ZMR7FYIbPh0Xc9AYY2LXE4tQTyjJEQEC6LOTqb/
         5rAQ==
X-Gm-Message-State: AOAM532Fdh5409vTnPASSDtNn589zuW7CYU9XRsBCIFZFKC9A1nQKUJI
        8qRmXcS85WXEZPV9NkNcisls115VchVq2H1Jqw2Meg==
X-Google-Smtp-Source: ABdhPJzcqOKzhEJFQaQ4CzTFveIdQfXJ3YjRzdswQWJsJWDGHo1cgxl+JlkQuVhlyzYnsAXE3RSINrhxwHn0eNO4A7Q=
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr29255817pja.13.1624936008065;
 Mon, 28 Jun 2021 20:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210402091145.80635-1-songmuchun@bytedance.com>
 <CAMZfGtUZgXsNOiyR==G+zLSN91PREss=XcbcfE0COkB8APcDxA@mail.gmail.com> <20210628163249.GC17026@quack2.suse.cz>
In-Reply-To: <20210628163249.GC17026@quack2.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 29 Jun 2021 11:06:10 +0800
Message-ID: <CAMZfGtXh=F8jsq4AU_0aT2RUUcjxHshsO1eshST-VArOMncGtQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] writeback: fix obtain a reference to a
 freeing memcg css
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 12:32 AM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Thu 20-05-21 11:45:23, Muchun Song wrote:
> > It seems like this patch has not been added to the linux-next
> > tree. Can anyone help with this? Thanks.
>
Hi,

> Muchun, did someone pickup this patch? I don't see it merged so unless

No, not yet.

> somebody yells, I'll pick it up to my tree and send it to Linus for rc2.

I'll be happy if you do that. Thanks.

>
>                                                                 Honza
>
> >
> > On Fri, Apr 2, 2021 at 5:13 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The caller of wb_get_create() should pin the memcg, because
> > > wb_get_create() relies on this guarantee. The rcu read lock
> > > only can guarantee that the memcg css returned by css_from_id()
> > > cannot be released, but the reference of the memcg can be zero.
> > >
> > >   rcu_read_lock()
> > >   memcg_css = css_from_id()
> > >   wb_get_create(memcg_css)
> > >       cgwb_create(memcg_css)
> > >           // css_get can change the ref counter from 0 back to 1
> > >           css_get(memcg_css)
> > >   rcu_read_unlock()
> > >
> > > Fix it by holding a reference to the css before calling
> > > wb_get_create(). This is not a problem I encountered in the
> > > real world. Just the result of a code review.
> > >
> > > Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > > Changelog in v3:
> > >  1. Do not change GFP_ATOMIC.
> > >  2. Update commit log.
> > >
> > >  Thanks for Michal's review and suggestions.
> > >
> > > Changelog in v2:
> > >  1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.
> > >
> > >
> > >  fs/fs-writeback.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 3ac002561327..dedde99da40d 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -506,9 +506,14 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> > >         /* find and pin the new wb */
> > >         rcu_read_lock();
> > >         memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> > > -       if (memcg_css)
> > > -               isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> > > +       if (memcg_css && !css_tryget(memcg_css))
> > > +               memcg_css = NULL;
> > >         rcu_read_unlock();
> > > +       if (!memcg_css)
> > > +               goto out_free;
> > > +
> > > +       isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> > > +       css_put(memcg_css);
> > >         if (!isw->new_wb)
> > >                 goto out_free;
> > >
> > > --
> > > 2.11.0
> > >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
