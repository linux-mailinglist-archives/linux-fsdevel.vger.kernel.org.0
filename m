Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3B3B66CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhF1QfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 12:35:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhF1QfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:35:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 09051202E5;
        Mon, 28 Jun 2021 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624897970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjzGZYePvIIaGO11WBPWnpQt5eSI/Ls63u3nQRytpxM=;
        b=v5P5suiPXZIsXITysRQW8T4KMY+HTzJY06wwv9ANmWT0+UoRk0KF2UcNSgGAcU8/xrnnyF
        kPpUVGYkpHSgNykI30VVBsAWWwV+JZ/NUZTUXx/jze71iGhD7eXPDiNlx2lkJ1KGufh45l
        F24EpgMLP+MgR+HzUjF07HT0FmnQU8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624897970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjzGZYePvIIaGO11WBPWnpQt5eSI/Ls63u3nQRytpxM=;
        b=D1mI1F4oNy1ntZwMqfAaXFZh0By6E5mcAqJTJRlL2LDTIsrfdcrngZyYSiO77RRsiF88Od
        AeY1VaqSDh4oEuCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id CE6C6A3B94;
        Mon, 28 Jun 2021 16:32:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9B57A1E125C; Mon, 28 Jun 2021 18:32:49 +0200 (CEST)
Date:   Mon, 28 Jun 2021 18:32:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] writeback: fix obtain a reference to a freeing memcg
 css
Message-ID: <20210628163249.GC17026@quack2.suse.cz>
References: <20210402091145.80635-1-songmuchun@bytedance.com>
 <CAMZfGtUZgXsNOiyR==G+zLSN91PREss=XcbcfE0COkB8APcDxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUZgXsNOiyR==G+zLSN91PREss=XcbcfE0COkB8APcDxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Thu 20-05-21 11:45:23, Muchun Song wrote:
> It seems like this patch has not been added to the linux-next
> tree. Can anyone help with this? Thanks.

Muchun, did someone pickup this patch? I don't see it merged so unless
somebody yells, I'll pick it up to my tree and send it to Linus for rc2.

								Honza

> 
> On Fri, Apr 2, 2021 at 5:13 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The caller of wb_get_create() should pin the memcg, because
> > wb_get_create() relies on this guarantee. The rcu read lock
> > only can guarantee that the memcg css returned by css_from_id()
> > cannot be released, but the reference of the memcg can be zero.
> >
> >   rcu_read_lock()
> >   memcg_css = css_from_id()
> >   wb_get_create(memcg_css)
> >       cgwb_create(memcg_css)
> >           // css_get can change the ref counter from 0 back to 1
> >           css_get(memcg_css)
> >   rcu_read_unlock()
> >
> > Fix it by holding a reference to the css before calling
> > wb_get_create(). This is not a problem I encountered in the
> > real world. Just the result of a code review.
> >
> > Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> > Changelog in v3:
> >  1. Do not change GFP_ATOMIC.
> >  2. Update commit log.
> >
> >  Thanks for Michal's review and suggestions.
> >
> > Changelog in v2:
> >  1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.
> >
> >
> >  fs/fs-writeback.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 3ac002561327..dedde99da40d 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -506,9 +506,14 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >         /* find and pin the new wb */
> >         rcu_read_lock();
> >         memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> > -       if (memcg_css)
> > -               isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> > +       if (memcg_css && !css_tryget(memcg_css))
> > +               memcg_css = NULL;
> >         rcu_read_unlock();
> > +       if (!memcg_css)
> > +               goto out_free;
> > +
> > +       isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> > +       css_put(memcg_css);
> >         if (!isw->new_wb)
> >                 goto out_free;
> >
> > --
> > 2.11.0
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
