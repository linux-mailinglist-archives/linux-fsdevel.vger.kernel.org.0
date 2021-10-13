Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB442B3C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 05:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhJMDnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 23:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhJMDny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634096511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9QQpHMzPqOGAUAgrM92CQtjCHKsEXKEq2E7CGbFGTs=;
        b=FCGuTLXqaKbORxt68jvecb+cOY8K6lYUomVBsY6I8aRuTVdXAKYOVV/9hZcWslkth17u8h
        mwHnlIVuwKrF+bAdDP5E9Zugx4bOpR9c1P6UuA/1VYkyfekeUMozPbgfhzR3ti4/ok/5Vy
        f3S0sZsWjgaGRGIbtbpJhLWDt0U4CV0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-NeT5wfcbMzeE3qv1tMTDCg-1; Tue, 12 Oct 2021 23:41:50 -0400
X-MC-Unique: NeT5wfcbMzeE3qv1tMTDCg-1
Received: by mail-pj1-f70.google.com with SMTP id nn1-20020a17090b38c100b001a063449823so1017036pjb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 20:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9QQpHMzPqOGAUAgrM92CQtjCHKsEXKEq2E7CGbFGTs=;
        b=ku+CnN2sT5IOmqaAkjIJtplo/3BsRqDTeU5lDpTsvXLHSaHoMGAevvdnuGM680SNmG
         bIMOjRJtuU0wiOsbKjA5bK23Ep0bCQptCOLrybI8KT7DJk7omks9WR/5qmYzljoKYKxj
         Sj5pI7rUAebMtLXYCy9gkppOFnGGipDSYgnZcnEEc1XeYQc9fAs80CdHxbO1oQlbroOl
         opCzp0sKWnt97jaB2oyMXjsUblapjyuVtPmq7zTJmgnDQrj4qZBZgwXkzl7N6gGOHg1G
         TRPLo9C4ou7V15cfsO18fPDGBr5A7dapFYCyppMMoDeBsGNwbrMnHCbSNt/XIAJX2ink
         Py3g==
X-Gm-Message-State: AOAM531fJsV7Bd3PAdXOAV5ULYtudoDjY7CSOxXEJcf0QTgwjaNiX9K/
        dym0WCMyCnQ104aOjQpmX2HPpX4ljomie1wGy4IRrZEJ9z5r5KU7/QFIjXRfAiNY8NBq0p0ZuZo
        yJNHzpB3wc8/D/MtYDgttp42waQ==
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id b140-20020a621b92000000b003eb3f920724mr35757518pfb.3.1634096508717;
        Tue, 12 Oct 2021 20:41:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTsSrRU70L24zyehCxjIOcnI0fW5T3TZ6w598G0eEchUTE4T6Elozl+lg8k4lS16yUUCus6A==
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id b140-20020a621b92000000b003eb3f920724mr35757499pfb.3.1634096508378;
        Tue, 12 Oct 2021 20:41:48 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v13sm12837847pgt.7.2021.10.12.20.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 20:41:47 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:41:40 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YWZVdDSS/4rnFbqK@t490s>
References: <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
 <YWTobPkBc3TDtMGd@t490s>
 <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s>
 <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
 <YWZMDTwCCZWX5/sQ@t490s>
 <CAHbLzkp8QkORXK_y8hnrg=2kTRFyoZpJcXbkyj6eyCdcYSbZTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkp8QkORXK_y8hnrg=2kTRFyoZpJcXbkyj6eyCdcYSbZTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:27:06PM -0700, Yang Shi wrote:
> > But this also reminded me that shouldn't we be with the page lock already
> > during the process of "setting hwpoison-subpage bit, split thp, clear
> > hwpoison-subpage bit"?  If it's only the small window that needs protection,
> > while when looking up the shmem pagecache we always need to take the page lock
> > too, then it seems already safe even without the extra bit?  Hmm?
> 
> I don't quite get your point. Do you mean memory_failure()? If so the
> answer is no, outside the page lock. And the window may be indefinite
> since file THP doesn't get split before this series and the split may
> fail even after this series.

What I meant is that we could extend the page_lock in try_to_split_thp_page()
to cover setting hwpoison-subpage too (and it of course covers the clearing if
thp split succeeded, as that's part of the split process).  But yeah it's a
good point that the split may fail, so the extra bit seems still necessary.

Maybe that'll be something worth mentioning in the commit message too?  The
commit message described very well on the overhead of looping over 512 pages,
however the reader can easily overlook the real reason for needing this bit -
IMHO it's really for the thp split failure case, as we could also mention that
if thp split won't fail, page lock should be suffice (imho).  We could also
mention about why soft offline does not need that extra bit, which seems not
obvious as well, so imho good material for commit messages.

Sorry to have asked for a lot of commit message changes; I hope they make sense.

Thanks,

-- 
Peter Xu

