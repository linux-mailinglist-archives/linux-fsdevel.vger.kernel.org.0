Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4442CF04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJMXPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 19:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhJMXPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634166808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHKHqM6joTjLTO+LAIK0a1VhLnO657jhFhkTCdfnQy4=;
        b=dDyCpTDo6h/3LhFaFxjWIF3jehTC8YmTTsV8mLMm3MmfIQJuujVpJ/Ior1zAaybZa4mYGT
        XwMN4g5za+DbepyXXFLdiYy5FYLwGeV6CfUnLgb8+hbyKfSoPOLTqxumBLRvT/Xe0AqRbB
        PtbmgZIAnJGeXKoGKlNWBSr+O4mLvHM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-lXUpQRoBO5CxeZ7CrAGIbg-1; Wed, 13 Oct 2021 19:13:27 -0400
X-MC-Unique: lXUpQRoBO5CxeZ7CrAGIbg-1
Received: by mail-pf1-f200.google.com with SMTP id j22-20020a62b616000000b0044d091c3999so2395562pff.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 16:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vHKHqM6joTjLTO+LAIK0a1VhLnO657jhFhkTCdfnQy4=;
        b=enrNGDCJFAWjMisjqX45RuzO+63ZfywDA2i1lKF5xNs+UAhhwdxG+cIrCYzXLPZNd+
         cd7sQOvnZuHV1RrXykILYOcBhfFEV/a8bpX0Y8Q6L/6jyyPUGFamdBwXUSzXR9u0S3Lf
         0XtEGY7kU5eAa2S/iYyTOQOif1XYYymeoZR69xrytw0VNvvyq7MH13bm30tnVWdAq6ra
         E9fJC8F30c77eKQ/HNF5+/a6+j2AIQy5FEBh4NiQlz7EtrbOVx9EEZikDwnKKUdxBrbH
         ffDIWZXj8naXABs+zJxzPH+jQXxXNI89x5u6xoh3AisBQl6Mwn4c703tw8f9qamqJzhs
         g6bw==
X-Gm-Message-State: AOAM5327cQGDrZVwH9XoXaHvyX3Xa20PQ4zTG+fg/69RYECSg3A6XY58
        BAHOds1KsWbBSY0t1tiqLy/VtyGs5Ua/jZyj6SfAsjNxajQyw2QW4jYJtXNQtjhCin/u1eQwj6N
        8fVm7koCo5FmD4a6fpCkV2vthug==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr2157867pfl.51.1634166806289;
        Wed, 13 Oct 2021 16:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyosAo3Rd7PHBy+R/128zfAHbsbgJfHLUuFFIbmXdGJzX054smRXN6zXt9Qeh9AnGI+ZzVpBQ==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr2157843pfl.51.1634166805966;
        Wed, 13 Oct 2021 16:13:25 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t28sm487986pfq.158.2021.10.13.16.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 16:13:25 -0700 (PDT)
Date:   Thu, 14 Oct 2021 07:13:18 +0800
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
Message-ID: <YWdoDn4uEYG8jpXH@t490s>
References: <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
 <YWTobPkBc3TDtMGd@t490s>
 <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s>
 <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
 <YWZMDTwCCZWX5/sQ@t490s>
 <CAHbLzkp8QkORXK_y8hnrg=2kTRFyoZpJcXbkyj6eyCdcYSbZTw@mail.gmail.com>
 <YWZVdDSS/4rnFbqK@t490s>
 <CAHbLzkrcOpG5AHk934hDJb2d+FocYjUc6nhBRofhTbTxLVWtYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkrcOpG5AHk934hDJb2d+FocYjUc6nhBRofhTbTxLVWtYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:42:42PM -0700, Yang Shi wrote:
> On Tue, Oct 12, 2021 at 8:41 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 08:27:06PM -0700, Yang Shi wrote:
> > > > But this also reminded me that shouldn't we be with the page lock already
> > > > during the process of "setting hwpoison-subpage bit, split thp, clear
> > > > hwpoison-subpage bit"?  If it's only the small window that needs protection,
> > > > while when looking up the shmem pagecache we always need to take the page lock
> > > > too, then it seems already safe even without the extra bit?  Hmm?
> > >
> > > I don't quite get your point. Do you mean memory_failure()? If so the
> > > answer is no, outside the page lock. And the window may be indefinite
> > > since file THP doesn't get split before this series and the split may
> > > fail even after this series.
> >
> > What I meant is that we could extend the page_lock in try_to_split_thp_page()
> > to cover setting hwpoison-subpage too (and it of course covers the clearing if
> > thp split succeeded, as that's part of the split process).  But yeah it's a
> > good point that the split may fail, so the extra bit seems still necessary.
> >
> > Maybe that'll be something worth mentioning in the commit message too?  The
> > commit message described very well on the overhead of looping over 512 pages,
> > however the reader can easily overlook the real reason for needing this bit -
> > IMHO it's really for the thp split failure case, as we could also mention that
> > if thp split won't fail, page lock should be suffice (imho).  We could also
> 
> Not only for THP split failure case. Before this series, shmem THP
> does't get split at all. And this commit is supposed to be backported
> to the older versions, so saying "page lock is sufficient" is not
> precise and confusing.

Sure, please feel free to use any wording you prefer as long as the other side
of the lock besides the performance impact could be mentioned.  Thanks,

-- 
Peter Xu

