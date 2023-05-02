Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C316F3EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjEBH5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBH5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 03:57:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E830F9;
        Tue,  2 May 2023 00:57:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-304935cc79bso3465211f8f.2;
        Tue, 02 May 2023 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683014229; x=1685606229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pACv5sNREpkMwZWTexAWOB8u6qIuWyv5q9pXglKMxz8=;
        b=sYahtDgxbHudMCho/x7iwywn3YYn4PHzZo2510a8BO+fUC8QfR8npiSnQFdgq6KQmi
         pnjKT+AZsSgS+mkI+4A/mfPA6CmeuxbUYa4jizMBpFyNzgWzcDkaw7KG9XtWUk/6+tgK
         QZjjPt1R7pfBPlMexQzmemMBAz7DJ+cYYhk0wg5afddE6cVKDyRSUJUTu+08EqWdwinR
         iqGoGAo7POQ1ouQ3FExACQPMWB9xjggxzgNM3pvCUV4AEy6PpW5BrK4lus5BZ9hvJ74B
         Kd6PJzgE4unty3vjH8u0qEUlzfj4taJ5Xmcn47GtnywxF27Wr2UVknFAducuYVGTtBDF
         0PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683014229; x=1685606229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pACv5sNREpkMwZWTexAWOB8u6qIuWyv5q9pXglKMxz8=;
        b=f8ZoW32xq31to/M7/mq7nwJzH1++guaNfRkRFtq/v/mw9R2YMGidiyc6K52zFSYIA3
         +/44FCehX+sOfWFCRVJvnkDaC4XcxDy8Iq4RxW7FwcKdfzMHOsovGybMqsRJj2vYer/D
         6AM3VFHJ2wtR1QKUoqsvFS0b4ssugnFA3cpKpSsSMyn5nJPWAfKJg3I/k5iOsFwGtYCh
         hffyHTFzaRi3JbQkAmbu54Tcstn0i3HOxCQKYbuw2Z+dyE4BPHk2gzcdlorBm47D3TgE
         w731C2wr1Nh7KuhC3Krfo8h9Z28czkqksSuWhITsIUa5dWFhopo8x4nZgBniw4P0+j9G
         elLg==
X-Gm-Message-State: AC+VfDzechMyxRbDuhzPj98x6JiBa9OmmEbzVzW50uwGuh6IJOwVW6F+
        QyInuMpw35JWzyLy8vR5+c0=
X-Google-Smtp-Source: ACHHUZ4XIbT+qDvJvtiu8jQaj1lCqwwpgK5NNUQ0OCNjgiigaO8IN4kPBYAixWknGzhXZ1y7hUunLA==
X-Received: by 2002:adf:f1d2:0:b0:2fa:88f2:b04c with SMTP id z18-20020adff1d2000000b002fa88f2b04cmr9959466wro.20.1683014228992;
        Tue, 02 May 2023 00:57:08 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b003063772a55bsm1082093wru.61.2023.05.02.00.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 00:57:07 -0700 (PDT)
Date:   Tue, 2 May 2023 08:57:07 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 3/3] mm: perform the mapping_map_writable() check
 after call_mmap()
Message-ID: <7565426e-1080-4521-afdd-4dfbfbc63c9b@lucifer.local>
References: <cover.1682890156.git.lstoakes@gmail.com>
 <6f3aea05c9cc46094b029cbd1138d163c1ae7f9d.1682890156.git.lstoakes@gmail.com>
 <CALCETrV1QWSjZR_PQgQdyS8rrg4hhrs1u+FyJh43H-gA7CzkFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrV1QWSjZR_PQgQdyS8rrg4hhrs1u+FyJh43H-gA7CzkFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 12:02:00PM -0700, Andy Lutomirski wrote:
> On Sun, Apr 30, 2023 at 3:26 PM Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> >
> > In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> > clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap()
> > handler to do so. We would otherwise fail the mapping_map_writable() check
> > before we had the opportunity to avoid it.
>
> Is there any reason this can't go before patch 3?

I don't quite understand what you mean by this? I mean sure, we could, but
intent was to build to this point and leave the most controversial change
for last :)

>
> If I'm understanding correctly, a comment like the following might
> make this a lot more comprehensible:
>
> >
> > This patch moves this check after the call_mmap() invocation. Only memfd
> > actively denies write access causing a potential failure here (in
> > memfd_add_seals()), so there should be no impact on non-memfd cases.
> >
> > This patch makes the userland-visible change that MAP_SHARED, PROT_READ
> > mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  mm/mmap.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 646e34e95a37..1608d7f5a293 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2642,17 +2642,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >         vma->vm_pgoff = pgoff;
> >
> >         if (file) {
> > -               if (is_shared_maywrite(vm_flags)) {
> > -                       error = mapping_map_writable(file->f_mapping);
> > -                       if (error)
> > -                               goto free_vma;
> > -               }
> > -
> >                 vma->vm_file = get_file(file);
> >                 error = call_mmap(file, vma);
> >                 if (error)
> >                         goto unmap_and_free_vma;
> >
>
> /* vm_ops->mmap() may have changed vma->flags.  Check for writability now. */
>

Ack, will add on next spin.

> > +               if (vma_is_shared_maywrite(vma)) {
> > +                       error = mapping_map_writable(file->f_mapping);
> > +                       if (error)
> > +                               goto close_and_free_vma;
> > +               }
> > +
>
> Alternatively, if anyone is nervous about the change in ordering here,
> there could be a whole new vm_op like adjust_vma_flags() that happens
> before any of this.

Agreed, clearly this change is the most controversial thing here. I did
look around and couldn't find any instance where this could cause an issue,
since it is purely the mapping_map_writable() that gets run at a different
point, but this is certainly an alterative.

I have a feeling people might find adding a new op there possibly _more_
nerve-inducing :) but it's an option.

>
> --Andy
