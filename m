Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA13D462B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhGXHLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhGXHLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 03:11:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A5BC061575;
        Sat, 24 Jul 2021 00:51:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r6so5261386ioj.8;
        Sat, 24 Jul 2021 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2QQPVpY5Yk4Ahbva/fAslyPabEv5/WNks/0wpOIAes=;
        b=BpYJ6zHQAIEu7GjUyHft5ZjuOPentdv6Z4rtH4qfvORFPcuzTsD1PFl9S1QSYS7Ef/
         XB/un7hQ34rx3myurppA3DMo0e9KId2gCBI3g0KwRAzqLGXCUZQjao2xDm4NWiTrlraw
         ZHJ1idxBWhlJ5tCEXC+PD82yZM9GuuJFeGkIjsMsp+mpLMcpAliJ+UZEvsf5ScpiKiBK
         kJ2j+ErGZizqjXPa0szJZmhCkzRHsTEK9aF2909B4ASV5qDPm4FqouZ+JpIXrE/DlDBx
         z9ZSHciTOVW+P+PauYWAh+8S/TQxHMqU0SUyGNhSwt2UdRpB1t//Li5LvUatFeeTyq7y
         soOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2QQPVpY5Yk4Ahbva/fAslyPabEv5/WNks/0wpOIAes=;
        b=PJvvkLrhS0qRlWjpVRFRYVsurNae4Ko99uJE1UFKG0tkxvH3GyA3v9yBZIpajBZ99v
         5HoFHfCVRjeYE2WvqOH1NjegNXlEPk6ck0MSiWIWrLU2aJL7aA30Ixj1qmY0pDHgw4Qa
         h2els6FF5a/cGbyER8INYb4TZEoIjAI2fSCcu3LHlyq3ObSLsRYkm48IbfdH00fMfrrp
         yESH9EdMyehI5qTqyiTjcouDE0+xRuxwePMjQNgKMK+GcEBj+aKqF048nTb4VUu248hW
         OZB8iL7PYuiL/BmZgWEibCciQCAQNSVTRTlwC+HWf0bM/EBrnZ0LKOnvBZvbw1U6lNUc
         EcSw==
X-Gm-Message-State: AOAM5325ABemjsqP+cnoVl40BQFt1wzpAlLcv3v80R1DWhhSkxuNw21U
        u2iXl28i1721yyixvEDYpb0/HoNd9FfIJzKMXrQ=
X-Google-Smtp-Source: ABdhPJzDdEnxvONgCmtty5Tezj88xyF1uFQQzt9Gfef9fX5MDhIGXPXu7+QsRQ7ua/GZtyyXWjULBqOJosu+Nt5XcBM=
X-Received: by 2002:a02:85a5:: with SMTP id d34mr7400013jai.132.1627113097425;
 Sat, 24 Jul 2021 00:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210723205840.299280-1-agruenba@redhat.com> <20210723205840.299280-2-agruenba@redhat.com>
 <CAHk-=wg1n8yVeKABgfx7itM5o1jXVx6WXRF5PxHx+uqeFBmsmQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg1n8yVeKABgfx7itM5o1jXVx6WXRF5PxHx+uqeFBmsmQ@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Sat, 24 Jul 2021 09:51:26 +0200
Message-ID: <CAHpGcMK7mT+QuDJZ-Aqq+gWgT2HZUkD_JkVgabEyOR1gOebUjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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

Am Sa., 24. Juli 2021 um 01:41 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
> On Fri, Jul 23, 2021 at 1:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> > Other than fault_in_pages_writeable(), this function is non-destructive.
>
> Again, as I pointed out in the previous version, "Other than" is not
> sensible language.

Thanks for pointing this out a second time. I have no idea how I
screwed up fixing that.

Andreas
