Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCAB7F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390603AbfISRDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 13:03:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42368 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISRDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:03:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so2898731lfg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+Le165FOxvtzRMwfFqjOH0U+XVnKpWjfAd4ukIEWR4=;
        b=FL9rhk1LXaWaOToMWtkofnf+ifZC7L6LjK+IHdHsF/ZjKrMGyWQHvozYfnjOkbc2Aa
         NaQT+Ln1+A5psdVMqEdRU37SGn1dPcL1GnHoARhDT9QcKBubA/swLTsvj8azaK1+sKlm
         HBGHGssbScaIPzuXiY0UhyHgSHDfp0ZEzinrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+Le165FOxvtzRMwfFqjOH0U+XVnKpWjfAd4ukIEWR4=;
        b=s4IGOPm0RcYLo402TsvyipmnrO67YItKs1sbIbU2grsJzunC2vtZVwcGXvd9WqrlwN
         +QZ6QXn32CbExK51WDe3bXygTHNcJa5Hx4Hp3rInlGreYVZDJgiHjpAOZAJuq+XFYn79
         q9UnCDQpQedjFJjaoJxF6Qdi1/Df21XzXJqw4UsfNC1EMRUasPRG2+Iunjg0NPLDBpbI
         XCKOunk20EipGTsheXe0/IW0iVujGOghVQGWp5YeZoRHHvXXNRXK1bdq4w4epFU7ezeE
         fdA2KOt4p7ZMlLrj4LEjIOh3Pfc5nBBqGuXFfmpdApvCfg0q+z4m1W8hn24ul0BrWIQ5
         jyQQ==
X-Gm-Message-State: APjAAAU7i7Lj1S0z0MbATrNRqLWvZAB9u6PCaTaoblM71erwyYOtWsjV
        y+IaoTGQaXl+ol/kEwA8EAJeK6YxKB8=
X-Google-Smtp-Source: APXvYqx4kai5M3FH6w+CrFzbtBvm0Tn4tk+6NnPsbGkQtNB9kVLqjK7qrXbzbgkSxrxPvqIYMCoLYQ==
X-Received: by 2002:a19:431e:: with SMTP id q30mr5521104lfa.171.1568912628221;
        Thu, 19 Sep 2019 10:03:48 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i17sm1752710ljd.2.2019.09.19.10.03.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:03:47 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id r22so2931191lfm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:03:47 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr5667771lfp.61.1568912626555;
 Thu, 19 Sep 2019 10:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
 <20190919034502.GJ2229799@magnolia>
In-Reply-To: <20190919034502.GJ2229799@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 10:03:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
Message-ID: <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:45 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> I propose the following (assuming Linus isn't cranky enough to refuse
> the entire iomap patchpile forever):

Since I don't think the code was _wrong_, it was just that I didn't
want to introduce a new pattern for something we already have, I'd be
ok with just a fix patch on top too.

And if the xfs people really want to use the "pop" model, that's fine
too - just make it specific to just the iomap_ioend type, which is all
you seem to really want to pop, and make the typing (and naming) be
about that particular thing.

As mentioned, I don't think that whole "while (pop)" model is _wrong_
per se.  But I also don't like proliferating new random list users in
general, just because some subsystem has some internal preference.
See?

And I notice that one of the users actually does keep the list around
and modifies it, ie this one:

        while ((ioend = list_pop_entry(&tmp, struct xfs_ioend, io_list))) {
                xfs_ioend_try_merge(ioend, &tmp);
                xfs_end_ioend(ioend);
        }

actually seems to _work_ on the remaining part of the list in that
xfs_ioend_try_merge() function.

So inside of xfs, that "pop ioend from the list" model really may make
perfect sense, and you could just do

    static inline struct xfs_ioend *xfs_pop_ioend(struct list_head *head)
    {
        struct xfs_ioend *ioend = list_first_entry_or_null(head,
struct xfs_ioend *, io_list);
        if (ioend)
                list_del(&ioend->io_list);
        return ioend;
    }

and I don't think it's wrong.

It's just that we've survived three decades without that list_pop(),
and I don't want to make our header files even bigger and more complex
unless we actually have multiple real users.

             Linus
