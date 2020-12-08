Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916712D213E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 04:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgLHDEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 22:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgLHDEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:04:53 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB7C061749;
        Mon,  7 Dec 2020 19:04:07 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id v3so14285185ilo.5;
        Mon, 07 Dec 2020 19:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqV+RZduulUj6NbGqyUOp9hoM7sI3vwmhR3qosb54tw=;
        b=dj3psY39njc3nsUNvx5F87Ydsh/VPUG3DePATtF8R5QDSa/ZQYcFtM08dZKZz0cpga
         vqA6FqcIrRvQ8N214nzx/+md9sVh6EN377hOmUWjPkeRqHDhN4W6kvkShQWhCaj1SLVd
         NyYsWXEmU2+dBOWWVreKQ851/BIXKM0AAJNJIbzDSgdGQ99gZ2pBlTbsVN5/5295k8tS
         SAzxpmg1PLKBJr3dqEcK51UQfP3t75kA2h3RJ6NATAH5ELnTOenXkv5JXJr55TdS6w2r
         t0eh5Vnv7EuyMe2AgdLPY2xc/+O41MpCY8bT8hPwD1LNqRzZXI8XVti3GaqbNbQOgFXk
         8IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqV+RZduulUj6NbGqyUOp9hoM7sI3vwmhR3qosb54tw=;
        b=ZvR6j8lSk3e059sE73NVM5rZJ1jNOKPuusTPz/8c9eUh2hYLfLn4/yrMJTlHTcr0Xc
         Cs9/r+ax3VYxZbvypKH8SxhCU31gFjsEadtkA6JIiF+CIvhtfhO8IFQ+sLPl20Gynw2V
         CP2Z78mvS4QgDm8UTR+ZukcTAT8j1EDf1pb4TyjgsGh2KYCjAzlsqCPQNMsuy2Sw5itz
         5WLw8C9akzHmAUxovHQd5hsHGeBumk1mvLSRkIjiO0uiR2FEVfP6oskQf2kVbtQ95WwO
         CZk7Asj9Ebmv7MKZntUHz+fzO8eetqJp4frlMr/O1jfbhRrH8ZxpLLumN4a3z5RI+G8G
         flYA==
X-Gm-Message-State: AOAM53223FhjzB9TyaRDYpXGTzIdhn1Hq6iJxROvIq9s3fUa7dOooiRF
        QiW9RsnhTi81wMMPCglWXPD3fUIwQAmXGbZ03+c=
X-Google-Smtp-Source: ABdhPJzYL1yRHIfcv/yWDBMbtYSBYQ5IsNwznZbZh4rfJfdR29NH+nqOy74D8K+MjJGY5+ETdEjkP/+n+puhVHGd8Do=
X-Received: by 2002:a92:ae10:: with SMTP id s16mr25678688ilh.142.1607396647025;
 Mon, 07 Dec 2020 19:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20201208021543.76501-1-laoar.shao@gmail.com> <20201208021543.76501-5-laoar.shao@gmail.com>
 <20201208024158.GF7338@casper.infradead.org>
In-Reply-To: <20201208024158.GF7338@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 8 Dec 2020 11:03:31 +0800
Message-ID: <CALOAHbCS9Np3KPh9O4TgCUCynG3yw0+z2Q9KBANE7KVS9ecazA@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] xfs: use current->journal_info to avoid
 transaction reservation recursion
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 10:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 08, 2020 at 10:15:43AM +0800, Yafang Shao wrote:
> > -     /*
> > -      * Given that we do not allow direct reclaim to call us, we should
> > -      * never be called in a recursive filesystem reclaim context.
> > -      */
> > -     if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > -             goto redirty;
> > -
> >       /*
> >        * Is this page beyond the end of the file?
> >        *
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index 2371187b7615..28db93d0da97 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -568,6 +568,16 @@ xfs_vm_writepage(
> >  {
> >       struct xfs_writepage_ctx wpc = { };
> >
> > +     /*
> > +      * Given that we do not allow direct reclaim to call us, we should
> > +      * never be called while in a filesystem transaction.
> > +      */
> > +     if (xfs_trans_context_active()) {
> > +             redirty_page_for_writepage(wbc, page);
> > +             unlock_page(page);
> > +             return 0;
> > +     }
>
> Dave specifically asked for this one to WARN too.

I put the warn in xfs_trans_context_active(), pls. see the definition of it.
Is that okay ?

-- 
Thanks
Yafang
