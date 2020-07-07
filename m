Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03D217A9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgGGVme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGGVme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:42:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E60C061755;
        Tue,  7 Jul 2020 14:42:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i4so44763266iov.11;
        Tue, 07 Jul 2020 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEphcFSLy8QcL2YgiuOYJ/038OCI0x9oymTZf0ealxU=;
        b=E44Npy+uD9w9OdRwhIZI8Eg596xSQB5BuN5tTCsfBVLb3wIB2ftJHf4hYQ1VdIgGzT
         ILX4A6wUkGdfVD00JELfXSv2arJ0OJ46HvKLA8nVtOHWQ6cUR///emWAakv8t0ax/4Ch
         xU6ihHXBkiGPNCFB0aaBoNuzU6x8Wpa8PtgGPuhiFEIxx+7+Z661VhObYrAYIgy/HgkZ
         f2LXtoeD8pjfl3ZgBYy+f6hwfPVTrOI4huglmsTpTaQNhlSc/4Tm8dccT0beKKwDvnKd
         hR+EopVSR8+8GKVpinFtIMhL3JZBsO29W9sMXcJm4/wWEYeCBbJSe6iw/Ekf0zLnCWpp
         WAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEphcFSLy8QcL2YgiuOYJ/038OCI0x9oymTZf0ealxU=;
        b=i7kfZuKlY2bDHu8AZaw6D4TEbkVKJg/tNbZY1UaDR7T/aXRwfDhGZaD8XeGNtjFKqz
         Xp3okzZwl4pDEkmPz3UOJ3PXYLqfF8Rm7PrqEsAV3Wc6kuGwxHBrKF2mgDr+OS/lYhUZ
         6W+04AdQXj31oc4doXX/iceswaZ7V79hqTaMo0KxGn8AXfGXE3MU+4S2mhG2XLYqVfd1
         Q5vcjb6kXyW5AljA9gTWIjd2XXdS+DjA/BXZENaZCpOn8SKuR2zSwhhKb9JzrjJI5u99
         Nx8wvGwSBhvKfgbhF8eLzxjy7L2MZWDrWQUZoRVDj+MEP6IlBp2v2zoWRkv4kgBNpNkR
         dyjQ==
X-Gm-Message-State: AOAM531YW4MT9ryVFh3EYZakziKzZZyNq2AEY/qZTO6Kd4kQiQjHp/ym
        PsanLSzaBMQ++jVhVSGYDO3WdkbigUi/yvAk3iI=
X-Google-Smtp-Source: ABdhPJx6vXCFv0Sq8KiF3sflQwhJCic0rGSxeKwIiWlFas4fu6Fka6BqgyVfZM8yhXkk3dtsXcNLPYkxUjnUr6ICrAg=
X-Received: by 2002:a5d:8f01:: with SMTP id f1mr33454675iof.20.1594158153413;
 Tue, 07 Jul 2020 14:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200707144457.1603400-1-agruenba@redhat.com> <20200707144457.1603400-2-agruenba@redhat.com>
 <e49c5a2b-866f-14ae-9665-284726815bbd@kernel.dk>
In-Reply-To: <e49c5a2b-866f-14ae-9665-284726815bbd@kernel.dk>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 7 Jul 2020 23:42:22 +0200
Message-ID: <CAHpGcM+mpg9vCT=jGYq0r2aezBY921O06D5aAxLozx8RDJ63-g@mail.gmail.com>
Subject: Re: [RFC v3 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 7. Juli 2020 um 20:40 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
> On 7/7/20 8:44 AM, Andreas Gruenbacher wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 3f881a892ea7..1ab2ea19e883 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -315,6 +315,7 @@ enum rw_hint {
> >  #define IOCB_SYNC            (1 << 5)
> >  #define IOCB_WRITE           (1 << 6)
> >  #define IOCB_NOWAIT          (1 << 7)
> > +#define IOCB_NOIO            (1 << 8)
>
> Just to make this even more trivial in terms of merge conflicts, could
> you do 1 << 9 instead?

Sure.

Andreas
