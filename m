Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187A3342F8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 21:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCTUju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCTUj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:39:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35260C061764
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Mar 2021 13:39:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v23so4564528ple.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Mar 2021 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHBC6QZXpxmNvS4AKrcv1feZzlh3YLdyfSboLcCgalw=;
        b=LV5XunF4WpyNMtdfOBeJWjNaaCWuoSliYkz4GyOXgJevN9hca8vbBFNa5xbJRZQZoE
         KoRYrdHdn6xNinPJ19tA7nD0qwyhhP+YRRDsFlMNOwfMoz5VFNBqteQcOKzfQYD0IHkN
         VS7m9Zu9hff+u0USfPPMQ7VHVtDIhlkGhfqXUXs89XuHX5WXHd4s8qFDmc85hkI2LoiH
         2cy4buwUJUiIojM8J6njI6wPPDr8eNwWYVvTcPC1pR04ew7gqtk69HEjTGDaUQI0mlKN
         AxvbFfFmAF/Zs0PnO36Jh4+FF1C5xwt150M52+3JE2HnojGHQHoysX2u5pI6b8P+f+bQ
         eaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHBC6QZXpxmNvS4AKrcv1feZzlh3YLdyfSboLcCgalw=;
        b=rocxMc3XKVfsD/w6xp7zbVTNVqKmUTByk9DrXTNSmeHoMp++KC9ktxtpDBWEbwsUA3
         t5AfRlsizBChr4fMNz5dcwChc3qFRbIGRmpVdeH2rqFYjcqWzAY+MJUXiIMqHKAwUBzg
         7naQPqZxVSG2HH9dpVrNKOVuEcOqSZDqbdbgnef8nGzTtB/dljjzYv7lZQ0WerATzBxj
         8bV4VHaupMtjjoaUCAqdUQ4kAI0KE4G5VrGeByvwy+Lf3VpltkFJK1LCQFZ3sxbEBg1/
         UzYelNKKjr3E/EJtq3/lbWOekrYCasVgFSOap2q+AMVWoFgah1BYcAmm5R62Nhs9edaO
         UjsA==
X-Gm-Message-State: AOAM532wsA2Tm4lFIKMRQZHpu+HQFPYvshjfjHecI9reG2GzES2HfHJL
        au+C7KXw4xDNupfELAaCTt1sVg==
X-Google-Smtp-Source: ABdhPJy1nXvWpOwSg8k85m3SSWUhsCzgDXO/rPo5cViY3+eCGtXw6dpISBhCCp/vC0s8wgOIUanX7Q==
X-Received: by 2002:a17:90a:e646:: with SMTP id ep6mr5134775pjb.101.1616272767462;
        Sat, 20 Mar 2021 13:39:27 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::9e01])
        by smtp.gmail.com with ESMTPSA id v13sm8425303pfu.54.2021.03.20.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:39:26 -0700 (PDT)
Date:   Sat, 20 Mar 2021 13:39:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <YFZdemoHyMcrEGQm@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain>
 <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain>
 <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
 <YFUpvFyXD0WoUHFu@relinquished.localdomain>
 <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 05:31:18PM -0700, Linus Torvalds wrote:
> On Fri, Mar 19, 2021 at 3:46 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > Not much shorter, but it is easier to follow.
> 
> Yeah, that looks about right to me.
> 
> You should probably use kmap_local_page() rather than kmap_atomic()
> these days, but other than that this looks fairly straightforward, and
> I much prefer the model where we very much force that "must be the
> first iovec entry".

To be exact, this code only enforces that the iov_iter is at the
beginning of the current entry. As far as I can tell, iov_iter doesn't
track its position overall, so there's no way to tell whether the
current entry is the first one.

> As you say, maybe not shorter, but a lot more straightforward.
> 
> That said, looking through the patch series, I see at least one other
> issue. Look at parisc:
> 
>     +#define O_ALLOW_ENCODED 100000000
> 
> yeah, that's completely wrong. I see how it happened, but that's _really_ wrong.

Ugh, that's embarrassing. It also happens to add exactly one new bit to
VALID_OPEN_FLAGS, so the BUILD_BUG_ON() in fcntl_init() didn't catch it.

> I would want others to take a look in case there's something else. I'm
> not qualified to comment about (nor do I deeply care) about the btrfs
> parts, but the generic interface parts should most definitely get more
> attention.
> 
> By Al, if possible, but other fs people too..

That's all I ask. I'll fix your comments and wait a few days to get some
more feedback on the fs side before I resend the patch bomb.

Thanks,
Omar
