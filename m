Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0971F44217D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKAUOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKAUOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:14:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B9C061714;
        Mon,  1 Nov 2021 13:11:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j21so45363849edt.11;
        Mon, 01 Nov 2021 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1dtlr2ttKRw5mcbGdwBwUoqlnFGv0srse18GSEuA/E=;
        b=lR9c+VPHFth7/wTuGv19MXV7Sh9KrYJqwW0Lu4dmt+zUbOJ7eXYofScd52+sKnxfzY
         7CtK71KbQNvq34HbjcbVVhq1qeUAxVy2OBdXjVvnyURaomVxYHSEiWNPkjGBO3kqXmnH
         kbUbs+aUrydQUxo+6ZvE0xEwVfuqrZnqo36Mt1JjWlfTJeZn/SLAGiXYRsAOGlCDkITR
         5xiG1Rk5ea+qSeASLBhrjplx2BDFcl0jXG+j/LmdCkW5BfDe5Ha/q4z7Bawmt7Ze/w23
         qTgpH62oR/23zbked23tUsHC8ACOP1+sP4xKBd/1xERFd90/klBc64D4cA+hfM0UQ/Kc
         aEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1dtlr2ttKRw5mcbGdwBwUoqlnFGv0srse18GSEuA/E=;
        b=hfN1R8NHaA757rOQ1Q9VgLhrzxdu9PKFJfi6vw+THSDpw8d4saIb/mTVq46tj7FNRQ
         zuJNSSSSyYoMj1AqO1XE1ljnmA/0/Ig+sMcCfIID2UIr0L6EBiNleaHofU3psBMHpg3D
         QCyqGhM8fkfUwuHbxJ2SViwsPbn8JC+RvG+hmwB7QBfa1JyzZAhtHaL0NeCvtBIKpPt3
         glWDAXY4ewTVa4SLV6J9X1POAC/4C/x5hTRb1nKlEjqsXJxy+pcTt68+IHyGc1q0FTwG
         P1Wbz56lii6012caaboNw7V4RRUm4jRvAK5BeMb4T7PfuimgPcFIuUoNSGIIPltWt3J7
         ATBw==
X-Gm-Message-State: AOAM533guo3wxfHhdHGYVbJAAi1a9m3sEWMjonwYl9MOpzVg9/M2xO7r
        sr9HPzTiufbUj+4oxNbeABkVeoZRnkRyTkz4MDA=
X-Google-Smtp-Source: ABdhPJxzEafZO0APCZgW5QUTNPh/n1I4XHakLQ9mc8d0LoGJcSYim8KSK74eWHhVtpIV0msHmDj6fm2bWHKeML6kq6E=
X-Received: by 2002:a17:907:2953:: with SMTP id et19mr2320740ejc.311.1635797505564;
 Mon, 01 Nov 2021 13:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ5rgmyswPN5kL8-Mk2hk7MCjHXVy6pS50i=KQKzUGFHfA@mail.gmail.com>
In-Reply-To: <CAPcxDJ5rgmyswPN5kL8-Mk2hk7MCjHXVy6pS50i=KQKzUGFHfA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Nov 2021 13:11:33 -0700
Message-ID: <CAHbLzkp7mN0ePsZiSY4obA_cVqmReSnDd6tF-yxRAmALBzzKAw@mail.gmail.com>
Subject: Re: [v5 PATCH 6/6] mm: hwpoison: handle non-anonymous THP correctly
To:     Jue Wang <juew@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 1, 2021 at 12:38 PM Jue Wang <juew@google.com> wrote:
>
> A related bug but whose fix may belong to a separate series:
>
> split_huge_page fails when invoked concurrently on the same THP page.
>
> It's possible that multiple memory errors on the same THP get consumed
> by multiple threads and come down to split_huge_page path easily.

Yeah, I think it should be a known problem since the very beginning.
The THP split requires to pin the page and does check if the refcount
is expected or not and freezes the refcount if it is expected. So if
two concurrent paths try to split the same THP, one will fail due to
the pin from the other path, but the other one will succeed.

I don't think of a better way to remediate it other than retrying from
the very start off the top of my head. We can't simply check if it is
still a THP or not since THP split will just move the refcount pin to
the poisoned subpage so the retry path will lose the refcount for its
poisoned subpage.

Did you run into this problem on any real production environment? Or
it is just a artificial test case? I'm wondering if the extra
complexity is worth or not.

>
> Thanks,
> -Jue
