Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3007E6186B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 18:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiKCR5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCR5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196961D32D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667498166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJJR4iR5+ugKjLbbYIb6Y9N5cv7dB2LX1UeXmZJCzLg=;
        b=gY0g0WOlO6lHhvd0ZUP5yZqY0asUVK09T9FSwnZUM19TSCNSRKZRtLr1qr/PV4HiPHk/il
        BiJ+9GiKp3DtNwjDXnKPq7SRrIPsojmoPWhM0gP6RociYtEo70E0dHkntMVKlF0XqLv9ZY
        blOoRb1VXBbvqtzt7j5zGslugrcVhLI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-Y7KYIC7kP2eJGi0-I-EYCA-1; Thu, 03 Nov 2022 13:56:04 -0400
X-MC-Unique: Y7KYIC7kP2eJGi0-I-EYCA-1
Received: by mail-qt1-f200.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso2323264qtx.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 10:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJJR4iR5+ugKjLbbYIb6Y9N5cv7dB2LX1UeXmZJCzLg=;
        b=r0N5nSlIJRTtz8ZrIXZPaqYvQ3/JRBi2AbBE47LWU+skWRJrduRHi5XoXNJEj/P2m+
         m6OqsCRWF7maLjY9n0xI8J2+cxJTB5OhRFUMvJ8KDEBUOkX/CbRlY2YPNKyxiNYtg5E3
         apvl8VamnsROUcWQDlrkI7jzP+jEoFKbTwxBijG4h4hkcb4t2VvLPdUKWXxqyhhH9EJQ
         9vlD9wgSKcTmB61+50IntRoiJGZwp5IRS7yfyEX6Vrzba/M7S5TlhR8xtSykOGXA7SL2
         BzlMU5FfepJV9pfSs7ScXHMvAtmreCRkIIVMjCgr/RuInUmDndyQtOSKA7Rt+7o5IExP
         b/7g==
X-Gm-Message-State: ACrzQf1DpEYBWlKH8R6Zr7LTS1gJYNFNgnJDyKexJwFrzn/KkMwUQTul
        63ZnJxWmXZbQts6xAXO4sulIHWkMeCz8BcvbAAqSuFB1vURBkV5iWifRCIBuA+6Zwp/20Anfui6
        rE9foE/JiRfbw1pj161kArW5WNQ==
X-Received: by 2002:ae9:ec19:0:b0:6ea:d0cd:a4ed with SMTP id h25-20020ae9ec19000000b006ead0cda4edmr22930154qkg.472.1667498164238;
        Thu, 03 Nov 2022 10:56:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7iPvcgAu3eL/1xePl7SgFmQ4Hn6DrpgbAeo3IVHTl3ixTcvbJc/N/GDydkySQ5WUcCJFrC6w==
X-Received: by 2002:ae9:ec19:0:b0:6ea:d0cd:a4ed with SMTP id h25-20020ae9ec19000000b006ead0cda4edmr22930137qkg.472.1667498163990;
        Thu, 03 Nov 2022 10:56:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a450a00b006cbc6e1478csm1230727qkp.57.2022.11.03.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:56:03 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:56:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2QAsrDRBAg6bJet@x1n>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
 <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
 <Y2K+y7wnhC4vbnP2@x1n>
 <Y2LDL8zjgxDPCzH9@casper.infradead.org>
 <Y2LWonzCdWkDwyyr@x1n>
 <CAJHvVcj-j6EWm5vQ74Uv1YWHbmg6-BP0hOEO2L9jRADJPEwb1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj-j6EWm5vQ74Uv1YWHbmg6-BP0hOEO2L9jRADJPEwb1A@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:34:38AM -0700, Axel Rasmussen wrote:
> On Wed, Nov 2, 2022 at 1:44 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Nov 02, 2022 at 07:21:19PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 02, 2022 at 03:02:35PM -0400, Peter Xu wrote:
> > > > Does the patch attached look reasonable to you?
> > >
> > > Mmm, no.  If the page is in the swap cache, this will be "true".
> >
> > It will not happen in practise, right?
> >
> > I mean, shmem_get_folio() should have done the swap-in, and we should have
> > the page lock held at the meantime.
> >
> > For anon, mcopy_atomic_pte() is the only user and it's passing in a newly
> > allocated page here.
> >
> > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 3d0fef3980b3..650ab6cfd5f4 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > > >     pte_t _dst_pte, *dst_pte;
> > > >     bool writable = dst_vma->vm_flags & VM_WRITE;
> > > >     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > > > -   bool page_in_cache = page->mapping;
> > > > +   bool page_in_cache = page_mapping(page);
> > >
> > > We could do:
> > >
> > >       struct page *head = compound_head(page);
> > >       bool page_in_cache = head->mapping && !PageMappingFlags(head);
> >
> > Sounds good to me, but it just gets a bit complicated.
> >
> > If page_mapping() doesn't sound good, how about we just pass that over from
> > callers?  We only have three, so quite doable too.
> 
> For what it's worth, I think I like Matthew's version better than the
> original patch. This is because, although page_mapping() looks simpler
> here, looking into the definition of page_mapping() I feel it's
> handling several cases, not all of which are relevant here (or, as
> Matthew points out, would actually be wrong if it were possible to
> reach those cases here).
> 
> It's not clear to me what is meant by "pass that over from callers"?
> Do you mean, have callers pass in true/false for page_in_cache
> directly?

Yes.

> 
> That could work, but I still think I prefer Matthew's version slightly
> better, if only because this function already takes a lot of
> arguments.

IMHO that's not an issue, we can merge them into flags, cleaning things
alongside.

The simplest so far is still just to use page_mapping() to me, but no
strong opinion here.

If to go with Matthew's patch, it'll be great if we can add a comment
showing what we're doing (something like "Unwrapped page_mapping() but
avoid looking into swap cache" would be good enough to me).

Thanks,

-- 
Peter Xu

