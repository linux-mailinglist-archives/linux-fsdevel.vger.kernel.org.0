Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF65A425761
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbhJGQIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 12:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230452AbhJGQIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633622800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2f7G2WKXlw2VVvH2sPBaPxflHdQi/DqI+SXI7iCozBY=;
        b=dqnJL0prfXgWYQIQoK/pU5YgSeb/v2fbfGLnAyF30AUtE6Vh8nW9umXp16LNULAHUBhXTe
        szrw+fDeRgcvblFVKz2Okun4JL4ZxYERgxNSNL8n+Egx8+zNIKhRLblZCTjbfy6g8Haqr6
        lEqj66akDoAvrADCJRNAfsj3ha+Y8X4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-dHUxFIyQPO64UqCEoWAulg-1; Thu, 07 Oct 2021 12:06:38 -0400
X-MC-Unique: dHUxFIyQPO64UqCEoWAulg-1
Received: by mail-qk1-f197.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so5530611qkp.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2f7G2WKXlw2VVvH2sPBaPxflHdQi/DqI+SXI7iCozBY=;
        b=BJQDG9K4OW/jiKn0QkevFFqJqoyc77S3lSXSY/5NRE4ZT+EMX2GEX9VKtaizcPha+e
         6+8kjfnNYumUDcWfbBVeYTuY80VV8rj8zKhKBSjHvI9Fv8e0Fcd9EOQYlN9t+pZdE/P2
         JR18APcxVb8Rhp/c1cjtQ4aAEHRqP3x7lzuFTGENvt0LFH3E5YYAwHEEZXn9MDBu995F
         sV+H+QsTpzlrq207+wkbhRDT+hucM3wLDZp6qQv5bxYej9zIjhcw0BIcGGuRCn0Sv156
         sV7cSk45u6H+OJh3ZdsZkBum4oAuMnQmfPlLAWgm2mAId8mvc5BLxyIY6u/g8/HIcRYK
         AtCQ==
X-Gm-Message-State: AOAM530cMuyox9thdsWqwO/QXeJTf1ZSfBCZPCaIlyUFUU+JqB8w98Nu
        xpsqDFeXEdNkTQ9gnJ6K2QnlddFhzdcFVI4DAGLJaMGLXNe+Vkl2UdDnArO8HyhmQu5N11lNPBZ
        Wl1aJ5QmsBOMbqexCnkj4+eIzrg==
X-Received: by 2002:a05:622a:316:: with SMTP id q22mr5879947qtw.225.1633622797391;
        Thu, 07 Oct 2021 09:06:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQLtzYt82r2CQEo/KkLz+OGcn7fBHhOWmfQckkRZ52geA1vPZXzGXWU4k0xWh+LgMLH0BJxA==
X-Received: by 2002:a05:622a:316:: with SMTP id q22mr5879906qtw.225.1633622797114;
        Thu, 07 Oct 2021 09:06:37 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id a16sm13820149qkn.16.2021.10.07.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:06:36 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:06:34 -0400
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
Message-ID: <YV8bChbXop3FuwPC@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 04:57:38PM -0700, Yang Shi wrote:
> > For example, I see that both unpoison_memory() and soft_offline_page() will
> > call it too, does it mean that we'll also set the bits e.g. even when we want
> > to inject an unpoison event too?
> 
> unpoison_memory() should be not a problem since it will just bail out
> once THP is met as the comment says:
> 
> /*
> * unpoison_memory() can encounter thp only when the thp is being
> * worked by memory_failure() and the page lock is not held yet.
> * In such case, we yield to memory_failure() and make unpoison fail.
> */

But I still think setting the subpage-hwpoison bit hides too deep there, it'll
be great we can keep get_hwpoison_page() as simple as a safe version of getting
the refcount of the page we want.  Or we'd still better touch up the comment
above get_hwpoison_page() to show that side effect.

> 
> 
> And I think we should set the flag for soft offline too, right? The

I'm not familiar with either memory failure or soft offline, so far it looks
right to me.  However..

> soft offline does set the hwpoison flag for the corrupted sub page and
> doesn't split file THP,

.. I believe this will become not true after your patch 5, right?

> so it should be captured by page fault as well. And yes for poison injection.

One more thing: besides thp split and page free, do we need to conditionally
drop the HasHwpoisoned bit when received an unpoison event?

If my understanding is correct, we may need to scan all the subpages there, to
make sure HasHwpoisoned bit reflects the latest status for the thp in question.

> 
> But your comment reminds me that get_hwpoison_page() is just called
> when !MF_COUNT_INCREASED, so it means MADV_HWPOISON still could
> escape. This needs to be covered too.

Right, maybe that's also a clue that we shouldn't set the new page flag within
get_hwpoison_page(), since get_hwpoison_page() is actually well coupled with
MF_COUNT_INCREASED and all of them are only about refcounting of the pages.

-- 
Peter Xu

