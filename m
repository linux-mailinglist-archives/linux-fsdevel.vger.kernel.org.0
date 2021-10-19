Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91465433ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhJSPmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhJSPmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:42:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16DC06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 08:40:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r19so8366369lfe.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5qLpGOaG+oQiwUY6IZoloZawU2xGFjPWL0KZDD5Sqk=;
        b=Wmr7RZGDwVuUUI0LgeG+526Yzd808WwmB0Gv3Ef8vlN4fSo+FWdGkt2ewAZlHCizf2
         AOj6nKdkBK/50v2SslKwFKgXMONLSaQQZm/2hQbpblrN5k/KDVfxEf5XH7GllHiFtRBq
         4jqVHC4XfB57XB9V0yinVHJ5h8DIkkpImv8f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5qLpGOaG+oQiwUY6IZoloZawU2xGFjPWL0KZDD5Sqk=;
        b=YtLq7nZEU/kahIMjQKzG11XqoPWTSVNqFRSHrRZrXmMhbyQ94SUhK3LW5VPyt26oO4
         0ALzqFRppS3vpe2ySyJJKVShNCXyPdKvImMiMyPP+4Klu32F+ZlOXeD+tsi7VYyp9yNP
         zQPt8erkKUGJ0UVZbtNGQJpHZunl4DrasEQsKEZ8TE4q/1b5yuIZW5Mlr7cG1oI3RrnZ
         TbyydEWKInJLCR4YpxagfTUoRCOin5DTdhC2AB6IXdXngXUvBuu0dkpSESLTunZ8V71t
         RUFHAb0vsQvYGsWmfIDliZlFDYOrF3NbWsvcTP2sCr2HKOyGNZ0I7736ZAyguroLOnFe
         BiCg==
X-Gm-Message-State: AOAM530Rp7XDbNSc9237lUqnvS2YUPm+eeHS/UL8ZZjGpNx4uxCjS7q4
        hwsttzbk/he2W5ryJdjXDzpzF42ZhP+bRw==
X-Google-Smtp-Source: ABdhPJzGsbUble03fPcry0UuujGZta5Z8Ba0JfFatmjBca9d3L8nA/4ghv4Fb6Ky9Bf6lH2nYsDKXw==
X-Received: by 2002:ac2:4bc2:: with SMTP id o2mr6863255lfq.9.1634658031423;
        Tue, 19 Oct 2021 08:40:31 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x10sm1696640lff.44.2021.10.19.08.40.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:40:29 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x27so8436976lfu.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 08:40:29 -0700 (PDT)
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr6559053lfu.402.1634658028835;
 Tue, 19 Oct 2021 08:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com>
In-Reply-To: <20211019134204.3382645-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Oct 2021 05:40:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
Message-ID: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> From my point of view, the following questions remain:
>
>  * I hope these patches will be merged for v5.16, but what process
>    should I follow for that?  The patch queue contains mm and iomap
>    changes, so a pull request from the gfs2 tree would be unusual.

Oh, I'd much rather get these as one pull request from the author and
from the person that actually ended up testing this.

It might be "unusual", but it's certainly not unheard of, and trying
to push different parts of the series through different maintainers
would just cause lots of extra churn.

Yes, normally I'd expect filesystem changes to have a diffstat that
clearly shows that "yes, it's all local to this filesystem", and when
I see anything else it raises red flags.

But it raises red flags not because it would be wrong to have changes
to other parts, but simply because when cross-subsystem development
happens, it needs to be discussed and cleared with people. And you've
done that.

So I'd take this as one pull request from you. You've been doing the
work, you get the questionable glory of being in charge of it all.
You'll get the blame too ;)

>  * Will Catalin Marinas's work for supporting arm64 sub-page faults
>    be queued behind these patches?  We have an overlap in
>    fault_in_[pages_]readable fault_in_[pages_]writeable, so one of
>    the two patch queues will need some adjustments.

I think that on the whole they should be developed separately, I don't
think it's going to be a particularly difficult conflict.

That whole discussion does mean that I suspect that we'll have to
change fault_in_iov_iter_writeable() to do the "every 16 bytes" or
whatever thing, and make it use an actual atomic "add zero" or
whatever rather than walk the page tables. But that's a conceptually
separate discussion from this one, I wouldn't actually want to mix up
the two issues too much.

Sure, they touch the same code, so there is _that_ overlap, but one is
about "the hardware rules are a-changing" and the other is about
filesystem use of - and expansion of - the things we do. Let's keep
them separate until ready, and then fix up the fallout at that point
(either as a merge resolution, or even partly after-the-fact).

                     Linus
