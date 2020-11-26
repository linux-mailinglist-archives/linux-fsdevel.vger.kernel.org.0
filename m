Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB02C5C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbgKZTZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 14:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgKZTZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:25:15 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0FC0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2020 11:25:15 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id o25so3331842oie.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2020 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ViCmWRKE+pPFgMfgXX95fmQBtr/0Bp2EoCIrnvSRlR0=;
        b=v2xW4TCdDnILHxtMD8+qN7xcXERVQhE9QzfxnnXsewMQpCys3+AtvNtATD4sabxHIY
         rb5zV3C85W5dyMzlXrJX93jNM1Pkc2VJ9bY/hBs1NHsqSgq0JJj8Pac7n6px8GmMtu+o
         vTm7KUhR1W9n7dYmchbQNm7yCgArHuBhSlhDL0iQnbfyPRlrfZiIBncU4i0lWsGzz04O
         MF7DrFjtk1GAydq/oJtLsM3l6BGDzxI0vl7jRVQbi79URE7rRTOfB2e67DZ7PwNyETab
         MkEqePjG5SSLNyAosQujDaxYibQ4gn46jl+7PSlUKHhqEbJvv4hGjA+Uz5W0Qw2SBxUq
         QOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ViCmWRKE+pPFgMfgXX95fmQBtr/0Bp2EoCIrnvSRlR0=;
        b=gD3wCBfJFMvfZiYjGRDrJIvGVASsSTOHCiaywzDwKe30MFqhfbda+20DilgnmSOVVY
         M+RvfG8Btn4ESEXdQSZtQIRk38QyKYGG3PeConBt4bXgByhfMAcPsLLNoIXF6/HQ6oaW
         ztdhlMhGi9OhHYwavjNkOSmB782VHPUFxw3Kw/B7heJfq9qYmGb+OsZFEZ+b2R1iV6Oh
         jvsi5wz7D2E/ljg0RpC3FddxPR/3fZuQV/+oBnaYNGT5pW50GfYCD/KVFa1/ITCz18AS
         W9GlUmoY8504VxJp3zKd9dTnODDYwZ78PKZ/byaCRFL1E2hqHu7fzm0KAgmM/1yOnxwt
         Jy6A==
X-Gm-Message-State: AOAM533FM0gcOlx7XlQwc9qtYVfaNPnqkMA/7pH/mWkIm2ZqK9SPl7F3
        gHts5bXKYXnJjhKibW59tuHWDA==
X-Google-Smtp-Source: ABdhPJxpk/51vMB7k6EYiP62U6kuxEfxalIXOkmJd5upcs8ktF8zKQG4sLw7Xk5SHNncDBQ5meESXg==
X-Received: by 2002:aca:d586:: with SMTP id m128mr2928947oig.73.1606418714084;
        Thu, 26 Nov 2020 11:25:14 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z12sm3348947oti.45.2020.11.26.11.25.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 26 Nov 2020 11:25:13 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:24:59 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, dchinner@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <20201126121546.GN4327@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2011261101230.2851@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org> <20201125023234.GH4327@casper.infradead.org> <20201125150859.25adad8ff64db312681184bd@linux-foundation.org> <CANsGZ6a95WK7+2H4Zyg5FwDxhdJQqR8nKND1Cn6r6e3QxWeW4Q@mail.gmail.com>
 <20201126121546.GN4327@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Nov 2020, Matthew Wilcox wrote:
> On Wed, Nov 25, 2020 at 04:11:57PM -0800, Hugh Dickins wrote:
> > > +                               index = truncate_inode_partial_page(mapping,
> > > +                                               page, lstart, lend);
> > > +                               if (index > end)
> > > +                                       end = indices[i] - 1;
> > >                         }
> > > -                       unlock_page(page);
> > 
> > The fix needed is here: instead of deleting that unlock_page(page)
> > line, it needs to be } else { unlock_page(page); }
> 
> It also needs a put_page(page);

Oh yes indeed, sorry for getting that wrong.  I'd misread the
pagevec_reinit() at the end as the old pagevec_release().  Do you
really need to do pagevec_remove_exceptionals() there if you're not
using pagevec_release()?

> 
> That's now taken care of by truncate_inode_partial_page(), so if we're
> not calling that, we need to put the page as well.  ie this:

Right, but I do find it confusing that truncate_inode_partial_page()
does the unlock_page(),put_page() whereas truncate_inode_page() does
not: I think you would do better to leave them out of _partial_page(),
even if including them there saves a couple of lines somewhere else.

But right now it's the right fix that's important: ack to yours below.

I've not yet worked out the other issues I saw: will report when I have.
Rebooted this laptop, pretty sure it missed freeing a shmem swap entry,
not yet reproduced, will study the change there later, but the non-swap 
hang in generic/476 (later seen also in generic/112) more important.

Hugh

> 
> +++ b/mm/shmem.c
> @@ -954,6 +954,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>                                                 page, lstart, lend);
>                                 if (index > end)
>                                         end = indices[i] - 1;
> +                       } else {
> +                               unlock_page(page);
> +                               put_page(page);
>                         }
>                 }
>                 index = indices[i - 1] + 1;
> 
> > >                 }
> > > +               index = indices[i - 1] + 1;
> > >                 pagevec_remove_exceptionals(&pvec);
> > > -               pagevec_release(&pvec);
> > > -               index++;
> > > +               pagevec_reinit(&pvec);
