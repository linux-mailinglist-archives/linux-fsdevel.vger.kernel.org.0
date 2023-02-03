Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16368A636
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 23:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjBCWbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 17:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBCWbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:31:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70640127
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 14:31:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw12so19332845ejc.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWWZZt8Kd4jgexM3P2TiZQc8VKtIMzPQG+XBMGoXd3A=;
        b=KAaaQyjPGwK5bqIhRr/0vsX0mK/cllOocnrd3InMcbq4UNsMPH1EAzHpj8k0DULfrU
         LYeN9IuTZZ9KunpCXqpNhekp1fgZqmzx0V/QSjn6LccSZhKmUuVjz9zwJ2g8gLLyGGy3
         tcYLvcuNXZZEpSvrQBRUDtmDAGF0958HA1yJotBPrUuJZqSA/tlwjPNwgO5fSfAiPM9P
         wlfJbx5VPi7Hdgerg+cet3bseBQsyi2WNDLbb5zCzh/xjuGdpAeAWS+IKsqvoEB6WsCK
         nTaOW9nT3V3BCJekQVJL8dHPe1q4Jo2TTriZYQB+IHe0PdZFa1oQ4p4N3UkM0IV8yHik
         oXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWWZZt8Kd4jgexM3P2TiZQc8VKtIMzPQG+XBMGoXd3A=;
        b=FKsvtZyoR3HByhHZcPFht/CekeKF8RlxDrxijkvf/rl/SMtbuzuQGK505eZIHdFgz2
         P9t2w+MIE3m7kZLVzGFnWI0XA0AkNZ+ryRVf/xLTG7xHtV0lhcUA8qGNStpu2itMTDVT
         5gv0iUSCP3KLBz6/BufPRLu7lSv/rgtIrI3Ib3r5PMOq4Ba8mckm2zRPkimvUSpc7i3K
         CEdYcBAf16V9yrYRHI9VWZNNjZMRg/rzdsjuo0oaUQVAydvGx59JFcUTz6TpAGKzfgNH
         Va1SiFHdP+ucyh1+0iOdxP0Ug/nqCaCu3EYmYDQuNC1DFEZalCLGu6OzpylBuKhfr9ti
         9J5g==
X-Gm-Message-State: AO0yUKVsC374cUQ+7Fl5mQ3NVw248MLLBpWnf8JfmjmbF8AFczslDYir
        SmfNN5bjXjnc74WAGULW1tGLWyZ2dIOIfFEQuzQ5jg==
X-Google-Smtp-Source: AK7set/ngCUt3CFIMK1ZEA00e8oy4dFzGJAM1H1PmSx4A9FBTa8WDKIPnYAqeI3LGjP/KCfjZut7Hqka4SW9V2e2hvU=
X-Received: by 2002:a17:906:c319:b0:878:7bc7:958a with SMTP id
 s25-20020a170906c31900b008787bc7958amr3493108ejz.220.1675463477828; Fri, 03
 Feb 2023 14:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com>
 <20230202233229.3895713-2-yosryahmed@google.com> <Y900tl+kRWoZac/T@casper.infradead.org>
In-Reply-To: <Y900tl+kRWoZac/T@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 3 Feb 2023 14:30:41 -0800
Message-ID: <CAJD7tkb9qTZRFUDGaBQM+nz2-HDpAJJ8SSB+rxgctBfC3K9mHw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm: vmscan: refactor updating reclaimed pages
 in reclaim_state
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 3, 2023 at 8:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 02, 2023 at 11:32:28PM +0000, Yosry Ahmed wrote:
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index 54c774af6e1c..060079f1e966 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -286,8 +286,7 @@ xfs_buf_free_pages(
> >               if (bp->b_pages[i])
> >                       __free_page(bp->b_pages[i]);
> >       }
> > -     if (current->reclaim_state)
> > -             current->reclaim_state->reclaimed_slab += bp->b_page_count;
> > +     report_freed_pages(bp->b_page_count);
>
> XFS can be built as a module

I didn't know that, thanks for pointing it out!

>
> > +++ b/mm/vmscan.c
> > @@ -204,6 +204,19 @@ static void set_task_reclaim_state(struct task_struct *task,
> >       task->reclaim_state = rs;
> >  }
> >
> > +/*
> > + * reclaim_report_freed_pages: report pages freed outside of LRU-based reclaim
> > + * @pages: number of pages freed
> > + *
> > + * If the current process is undergoing a reclaim operation,
> > + * increment the number of reclaimed pages by @pages.
> > + */
> > +void report_freed_pages(unsigned long pages)
> > +{
> > +     if (current->reclaim_state)
> > +             current->reclaim_state->reclaimed += pages;
> > +}
> > +
>
> report_free_pages is not EXPORT_SYMBOLed

Will do that for the next version, thanks!
