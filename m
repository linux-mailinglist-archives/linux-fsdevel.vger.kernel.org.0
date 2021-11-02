Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0356C44334C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhKBQoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhKBQod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:44:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF68C061714;
        Tue,  2 Nov 2021 09:41:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f4so20000593edx.12;
        Tue, 02 Nov 2021 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9fLE2sZ7FZWPP/ecK148FNaLK2v6+054zpNZUAw408=;
        b=GIC0or1lIv/x6KQ6dzmOaG72s2IQPXTII1ERwaYomoiFx+bptqPQe+uikUc5izujFr
         dpVr2v8+y3TnmrFnFMjREDsY7E0uCosKQ+rOnXHP8LoaSgGAz/daBOBE5dSeyazWLO9R
         HbQCOX7g6VUk7D7G6+vTPEQsTo7/aQl8spZd2TF1f5l0nEOV0eLjOR7C14DueTzMLDGF
         tZF/apg9alp1dilggx1wwo5VME145khVjtJLD9MljtlJNx9+bcq8yVrSrpG3jj1Ho1Cb
         XFFoR/pYN+xwvdg+X/WiuRmozIOuZPTc++y0ZE6zhC1YwQom7ps9DyyLmMtj4ZzClubW
         2uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9fLE2sZ7FZWPP/ecK148FNaLK2v6+054zpNZUAw408=;
        b=wBUqbHzbtAmm5gO22G6aiVHw4MHYtKCH+FgE+oYXJeK5XL6PrpWT3dryVlbiuP+8op
         jVQoDYDM2q8MFkFEW3nwJKDPmcvDozlgj2dgnIydvAlNsveERJO+jtDa4Az8X0FRgrDu
         FECJs8Y0SGbACIdaM7SJOH7/UMCfatZ4XMw4zgnXnP+teOMEBHKkQxMLs+MEbhW3Pfl4
         Za7mEWwL1hj/pUJu7A5e21KdA3xxf3v/3+ASC/P9QWY641rV/lz+6S0VXdSkfzA2HsOM
         3HZDlJWOIEydTjn766Oi14rpZ5qMUagx+fXMBL3VKUhCdDzyUz2jpDwYgApC49p1Tiw1
         cY9A==
X-Gm-Message-State: AOAM531G9NpNME0xLIoQxEvlRr6k1lPu9eiCSthOK2mw6ASZ3tYkXN9R
        2grylmh5AAaHPkq7w4wXl2dOGWa+aWt3kxvd7GE=
X-Google-Smtp-Source: ABdhPJxNeZEbOBiIM49ywxwCSNfzBI/QMJoNQe6/4NSu5+j4OYAjl7q4OkVEUsDhoUS2abnWGBw07ql4nTXVWnAqi5c=
X-Received: by 2002:a17:906:3f83:: with SMTP id b3mr47174068ejj.233.1635871315881;
 Tue, 02 Nov 2021 09:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ5rgmyswPN5kL8-Mk2hk7MCjHXVy6pS50i=KQKzUGFHfA@mail.gmail.com>
 <CAHbLzkp7mN0ePsZiSY4obA_cVqmReSnDd6tF-yxRAmALBzzKAw@mail.gmail.com> <YYC1Phb5eFn9hJfG@casper.infradead.org>
In-Reply-To: <YYC1Phb5eFn9hJfG@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 2 Nov 2021 09:41:43 -0700
Message-ID: <CAHbLzkrwEsTgwmaMsOFHRbM6TEvBZA965N+FJwe-ZwSzbrL-VQ@mail.gmail.com>
Subject: Re: [v5 PATCH 6/6] mm: hwpoison: handle non-anonymous THP correctly
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jue Wang <juew@google.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 1, 2021 at 8:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 01, 2021 at 01:11:33PM -0700, Yang Shi wrote:
> > On Mon, Nov 1, 2021 at 12:38 PM Jue Wang <juew@google.com> wrote:
> > >
> > > A related bug but whose fix may belong to a separate series:
> > >
> > > split_huge_page fails when invoked concurrently on the same THP page.
> > >
> > > It's possible that multiple memory errors on the same THP get consumed
> > > by multiple threads and come down to split_huge_page path easily.
> >
> > Yeah, I think it should be a known problem since the very beginning.
> > The THP split requires to pin the page and does check if the refcount
> > is expected or not and freezes the refcount if it is expected. So if
> > two concurrent paths try to split the same THP, one will fail due to
> > the pin from the other path, but the other one will succeed.
>
> No, they can both fail, if the timing is just right, because they each
> have a refcount, so neither will succeed.

Oh, yes, if there is race between unlock_page and put_page.
