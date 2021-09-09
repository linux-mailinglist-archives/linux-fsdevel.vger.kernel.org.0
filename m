Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4E405BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhIIRSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbhIIRSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:18:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F2C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 10:17:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m4so4115371ljq.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlWzkECk20+XqmMBmmlhgHERfUmOY5RNnADt8Z36qog=;
        b=EK8cd8m3N90BRu7k+tQtRObfDdPm0WNzqcuF6FrjTVlzmoTGEV2VxpLRUXVf9jH8aT
         G4eBWVkI6uQCMRJzKE9fKssV/wmh8IHKnfFtSZCCFwM1RslKOwFVYeqDmIxarH/iLLjP
         HwKvShhp9FmcqErZVIckI4ZtDeQufVRuWD4Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlWzkECk20+XqmMBmmlhgHERfUmOY5RNnADt8Z36qog=;
        b=H7PlnXIrYvLvfAKWtWcPUya7MoucvWq8oXMyKY+kTyH1LFSAE7e3GpRRZROBdbjkgh
         LpgVmfgGIfChUVYWapDzvvpwnQBHm2EKmCfYd/rewGAI3YUU5V/DQFtKF5sxmAFzWY7P
         hUc9BCEWTe1h3TSa+e02hhc5DcLGqr5KlYto8JEbU7Tt2D+upEnW9faF/ji0RkBI64Gl
         ISW9V/rrgKLLpV9dSvcftPNfQKRzJqS2CQbkCOs1+Lu5KEcA8u6Bm0t3CoC1fQUuUX6P
         SZYzJYeNnbhrJtm+uB1pl5dGF6fc6BlJg6h9WEnMzUnLRNO3aNYPcnPT/tW3JstLNlB5
         AxsQ==
X-Gm-Message-State: AOAM532ZhgZyhv3sKgRs8kYuWrcHK47ffqc8MYenYglp55Dxu5xjLuav
        FysfkdeB5i836CnMTkDT/8Obm68YSUuoSiTZUxc=
X-Google-Smtp-Source: ABdhPJxrLfxWbGBvBiuuNsKdsTsAeLNRlgPhrdvRpSwsf/jH/Si47XOkOwCtG2qnErC7UgQZSYgcow==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr779488ljg.396.1631207851929;
        Thu, 09 Sep 2021 10:17:31 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id x4sm265024ljm.98.2021.09.09.10.17.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:17:30 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y6so4149416lje.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 10:17:30 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr734988ljg.31.1631207850194;
 Thu, 09 Sep 2021 10:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-18-agruenba@redhat.com>
 <YTnxruxm/xA/BBmQ@infradead.org>
In-Reply-To: <YTnxruxm/xA/BBmQ@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 10:17:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4RER3XeG34nLH2PgvuRuj_NRgDx=wLTKv=jYaQnFe+Q@mail.gmail.com>
Message-ID: <CAHk-=wj4RER3XeG34nLH2PgvuRuj_NRgDx=wLTKv=jYaQnFe+Q@mail.gmail.com>
Subject: Re: [PATCH v7 17/19] gup: Introduce FOLL_NOFAULT flag to disable page faults
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 9, 2021 at 4:36 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 27, 2021 at 06:49:24PM +0200, Andreas Gruenbacher wrote:
> > Introduce a new FOLL_NOFAULT flag that causes get_user_pages to return
> > -EFAULT when it would otherwise trigger a page fault.  This is roughly
> > similar to FOLL_FAST_ONLY but available on all architectures, and less
> > fragile.
>
> So, FOLL_FAST_ONLY only has one single user through
> get_user_pages_fast_only (pin_user_pages_fast_only is entirely unused,
> which makes totally sense given that give up on fault and pin are not
> exactly useful semantics).

So I think we should treat FOLL_FAST_ONLY as a special "internal to
gup.c" flag, and perhaps not really compare it to the new
FOLL_NOFAULT.

In fact, maybe we could even just make FOLL_FAST_ONLY be the high bit,
and not expose it in <linux/mm.h> and make it entirely private as a
name in gup.c.

Because FOLL_FAST_ONLY really is meant more as a "this way we can
share code easily inside gup.c, by having the internal helpers that
*can* do everything, but not do it all when the user is one of the
limited interfaces".

Because we don't really expect people to use FOLL_FAST_ONLY externally
- they'll use the explicit interfaces we have instead (ie
"get_user_pages_fast()"). Those use-cases that want that fast-only
thing really are so special that they need to be very explicitly so.

FOLL_NOFAULT is different, in that that is something an external user
_would_ use.

Admittedly we'd only have one single case for now, but I think we may
end up with other filesystems - or other cases entirely - having that
same kind of "I am holding locks, so I can't fault into the MM, but
I'm otherwise ok with the immediate mmap_sem lock usage and sleeping".

End result: FOLL_FAST_ONLY and FOLL_NOFAULT have some similarities,
but at the same time I think they are fundamentally different.

The FAST_ONLY is the very very special "I can't sleep, I can't even
take the fundamental MM lock, and we export special interfaces because
it's _so_ special and can be used in interrupts etc".

In contrast, NOFAULT is not _that_ special. It's just another flag,
and has generic use.

               Linus
