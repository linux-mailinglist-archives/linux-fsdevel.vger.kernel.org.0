Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7393C42FDA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 23:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhJOVuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOVue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:50:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968E5C061570;
        Fri, 15 Oct 2021 14:48:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w19so42995557edd.2;
        Fri, 15 Oct 2021 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fy8JX1MISO+E6iiO8M4K0L0jBN1ZBpTt5D/TgO1B54U=;
        b=U7+cTP+WOIeSHVdUukK9i8mAbLqOyx+qsv7LKqyA1d9LnYKxTxqGp1qFfzQBmZyub+
         2WS2AsPbS3Bzn0j4xDW2BZBmYT14PRpRBy200SYYKaHLTLw5c++3nj7sinEL6J2+v0Zr
         rwP3kfkTJquHOTMXOuyjwxtkES4zGr5M9wjHJJZ1J7bAr3qG12JioOORDjt/yCPNKI2e
         LCBig775MW/n7T7ugT5XMIRgbePHsJppd0XpLXu8CRjlyDYyls5yD3jDl1bWo+cVwgwE
         tK3WeidHc6CVSXMf6j/+gPQKKU8wM75aPxRVHInezczSE8WO1B73zapsU87whFU0gn35
         Xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fy8JX1MISO+E6iiO8M4K0L0jBN1ZBpTt5D/TgO1B54U=;
        b=IS2z4he2rfqmoIqn7vOAUWODR0vH4THyLLPjakhl+4arwJKk0Up2ZdVeFVZPWDeDvI
         5GJpHKQxcKlfHoqIJM+HwMuQ+WXWQnblrwvHvowiJY6r17qJRLf4M+OPXVjrEnf7Bopf
         a3AU574tZmFqUkpU8bhMf5PFTSM816mTOyqwxyVfq28XzHyoMdYZv4mAzDD+VLBfOKls
         6o6JR8UF+Pu6tz8EgrbtAdC7V2zxOO2LhFrbIN3EX7FOzdGHLpPd1r8A6MHiRT06j9TR
         f2mjm0Paz8MXW5RYP/3eF3l5m6fAeZ8QvNYjB5co1i6xgOo/1SQYvifD5nSTWsGVad2f
         +JHA==
X-Gm-Message-State: AOAM531dE+XkkKFXtkWVNBAXPfdKAaOhJ+ka68CEVCjOc1g2RJYZIqm0
        Eu2NC40lrzWmeSu2K933oDnwEXxjd3PxDCXB9zg=
X-Google-Smtp-Source: ABdhPJxzPoBGmacpktimn0FUL9PLamaLUctIWvwvIPEK4LcwDaz5KhCkQGyMHTGRHT4amHjaBl4V4kjNsLgEvuuxKys=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr10244354ejc.62.1634334506069;
 Fri, 15 Oct 2021 14:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211014191615.6674-1-shy828301@gmail.com> <20211015132800.357d891d0b3ad34adb9c7383@linux-foundation.org>
In-Reply-To: <20211015132800.357d891d0b3ad34adb9c7383@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 15 Oct 2021 14:48:14 -0700
Message-ID: <CAHbLzkrRdT1gZm-FBmZU8WKqsLYfC6Q2cF8iGDWqOV6==xfsnA@mail.gmail.com>
Subject: Re: [RFC v4 PATCH 0/6] Solve silent data loss caused by poisoned page
 cache (shmem/tmpfs)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 1:28 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 14 Oct 2021 12:16:09 -0700 Yang Shi <shy828301@gmail.com> wrote:
>
> > When discussing the patch that splits page cache THP in order to offline the
> > poisoned page, Noaya mentioned there is a bigger problem [1] that prevents this
> > from working since the page cache page will be truncated if uncorrectable
> > errors happen.  By looking this deeper it turns out this approach (truncating
> > poisoned page) may incur silent data loss for all non-readonly filesystems if
> > the page is dirty.  It may be worse for in-memory filesystem, e.g. shmem/tmpfs
> > since the data blocks are actually gone.
> >
> > To solve this problem we could keep the poisoned dirty page in page cache then
> > notify the users on any later access, e.g. page fault, read/write, etc.  The
> > clean page could be truncated as is since they can be reread from disk later on.
> >
> > The consequence is the filesystems may find poisoned page and manipulate it as
> > healthy page since all the filesystems actually don't check if the page is
> > poisoned or not in all the relevant paths except page fault.  In general, we
> > need make the filesystems be aware of poisoned page before we could keep the
> > poisoned page in page cache in order to solve the data loss problem.
>
> Is the "RFC" still accurate, or might it be an accidental leftover?

Yeah, I think it can be removed.

>
> I grabbed this series as-is for some testing, but I do think it wouild
> be better if it was delivered as two separate series - one series for
> the -stable material and one series for the 5.16-rc1 material.

Yeah, the patch 1/6 and patch 2/6 should go to -stable, then the
remaining patches are for 5.16-rc1. Thanks for taking them.

>
