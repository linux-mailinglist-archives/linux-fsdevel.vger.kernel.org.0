Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83AE4EE6AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 05:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbiDADZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiDADZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:25:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31692D1F8
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 20:23:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e64a6b20eeso19257907b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 20:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQmEc11aIbx+ZtNr6xhDNIOvDmC310KGZSAfuh7/n4o=;
        b=U2sd5IBeDZM9I11jk51mO17fAqz78NJ9AkSAFGNgkLDMHoTwPcuzlCX0EJbmd9bb/H
         fP4CvGZIHZj4HHO5u90gNLl3WMM6i3r468t2r4byAfmm2eMWDnVBZ/zkIq/aCvYjWtKS
         71Iw8C3q63aPogvu4Rp2N3lhiYPzCqEOTu3zrLJ0tA/wKS3Pzihb34DdzTTMtGW6wwsm
         9PvekKjKqPVnHzp2WlDmgVJzU4eP0AKp2zaTKnakYKifBbiVSape10kLEbT6je8VLFOF
         aaNnqaFeXKLP2wDuS8/I2cRd07mwfhzDgGaOmp1+dsRhNRdzxyl+f1jFuiXITaE384Zr
         Pygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQmEc11aIbx+ZtNr6xhDNIOvDmC310KGZSAfuh7/n4o=;
        b=3RF2dWbCMmGElSgJ320bG6lfEhuCS8OhJh0xGH8rlezImucRQv6++/WwXgQcJpRGqs
         Yt89gCungg0CTq48k9c8fc5B0qXuueu/Q6hB09vUhV9VYE2LXdB5LLvRRJNmsoMUqSb7
         VSb6jFCR7K7q0BzhH7faCLj6mrYOXH2oOHRUEP2BmOo10/Tgvj4HPWbzqEwGQCaljjzr
         ERTvyX48ccCL8wuS9Zj1ACJ/lRcaggihsj/AqEqEF7reyNxqKLM8T6Wjs3BqAFOrsXO7
         nEslrl3wqHSX1JL0zZI8izOgn5d+1iXt9vpPd/aZnIjviMP1W77QcG0ztph7i70BeVFc
         8D4Q==
X-Gm-Message-State: AOAM530v8kpmMh/gm0yL9BLs5XRodg4N8siAj6omU9QI3VDOHeN5uLyc
        PCY8MoleYw9PdjS7ngpN45SgMyZsK3qj7eRXgKwbEg==
X-Google-Smtp-Source: ABdhPJyfBNiFGOcyCVVnQq3QlsWIGX+YGW+qL+Jm/E/uL9rdKI+a88ky2Pv25kLFMeoOO0k8ts7UGdkHow0gWNpe3hE=
X-Received: by 2002:a0d:f685:0:b0:2e2:22e6:52d7 with SMTP id
 g127-20020a0df685000000b002e222e652d7mr8046178ywf.418.1648783416948; Thu, 31
 Mar 2022 20:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220228122126.37293-1-songmuchun@bytedance.com>
 <20220228122126.37293-13-songmuchun@bytedance.com> <YkXCWW7ru9Gxyy6G@casper.infradead.org>
In-Reply-To: <YkXCWW7ru9Gxyy6G@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 1 Apr 2022 11:23:01 +0800
Message-ID: <CAMZfGtXiVDxO1hqiOChR2a_nwK5kUiWafEXML7=YfuPBy0zH5w@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 28, 2022 at 08:21:22PM +0800, Muchun Song wrote:
> > @@ -586,27 +508,48 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
> >               }
> >       }
> >
> > +     xas_lock_irqsave(&xas, flags);
> >       while (i--) {
> > +             int index = READ_ONCE(table[i].memcg->kmemcg_id);
> >               struct list_lru_per_memcg *mlru = table[i].mlru;
> >
> > +             xas_set(&xas, index);
> > +retry:
> > +             if (unlikely(index < 0 || xas_error(&xas) || xas_load(&xas))) {
> >                       kfree(mlru);
> > +             } else {
> > +                     xas_store(&xas, mlru);
> > +                     if (xas_error(&xas) == -ENOMEM) {
> > +                             xas_unlock_irqrestore(&xas, flags);
> > +                             if (xas_nomem(&xas, gfp))
> > +                                     xas_set_err(&xas, 0);
> > +                             xas_lock_irqsave(&xas, flags);
> > +                             /*
> > +                              * The xas lock has been released, this memcg
> > +                              * can be reparented before us. So reload
> > +                              * memcg id. More details see the comments
> > +                              * in memcg_reparent_list_lrus().
> > +                              */
> > +                             index = READ_ONCE(table[i].memcg->kmemcg_id);
> > +                             if (index < 0)
> > +                                     xas_set_err(&xas, 0);
> > +                             else if (!xas_error(&xas) && index != xas.xa_index)
> > +                                     xas_set(&xas, index);
> > +                             goto retry;
> > +                     }
> > +             }
> >       }
> > +     /* xas_nomem() is used to free memory instead of memory allocation. */
> > +     if (xas.xa_alloc)
> > +             xas_nomem(&xas, gfp);
> > +     xas_unlock_irqrestore(&xas, flags);
> >       kfree(table);
> >
> > +     return xas_error(&xas);
> >  }
>
> This is really unidiomatic.  And so much more complicated than it needs
> to be.
>
>         while (i--) {
>                 do {
>                         int index = READ_ONCE(table[i].memcg->kmemcg_id);
>                         struct list_lru_per_memcg *mlru = table[i].mlru;
>
>                         xas_set(&xas, index);
>                         xas_lock_irqsave(&xas, flags);
>                         if (index < 0 || xas_load(&xas))
>                                 xas_set_err(&xas, -EBUSY);
>                         xas_store(&xas, mlru);
>                         if (!xas_error(&xas))
>                                 break;
>                         xas_unlock_irqrestore(&xas, flags);
>                 } while (xas_nomem(&xas, gfp));
>
>                 if (xas_error(&xas))
>                         kfree(mlru);
>         }
>
>         kfree(table);
>         return xas_error(&xas);
>
> (you might want to mask out the EBUSY error here)
>

I'm not familiar with xarray APIs.  I'll dig deeper to see if this code works
properly.  Thanks for your suggestions.
