Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171C9B99F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407056AbfITXKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:10:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46429 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407049AbfITXKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:10:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so6088053lfc.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO+3q5x038gSPZF/nLZWoOveo/vi3BJr9fEYGq5u1Qs=;
        b=b0bLoLz9YWB+dnb6SUOQYyE1UG7Fm/CiRt9E6LOt5jNDkZBpysWuFmg6W9pLGQLDKb
         WEpU9p2xmLJOYOSUMCpecUg+sWWLcFbpwLUo70evRNP41Q3StF1A42Il21OBbR6H99xJ
         iNnVTFFFgkWYCoAEIw6rXlpjOGG/wqJpFAmnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO+3q5x038gSPZF/nLZWoOveo/vi3BJr9fEYGq5u1Qs=;
        b=TXqoc4UlAKO5X3Pjg0Gy/NZsnqGxNZgKJxL9uCway8vnJQmrzmCJOi0QMSzvW4wPTx
         S+looeKRdHOx9bp116hP+3cUlUKrLCQziC6287cK+2MXhHPwVRHvbLjUlP63J9rZCVw0
         Dew5LKimJMpUVM9c4ICqddC7uNRWfB7snl1Em5JsQ78adRH2NUmkzfFeKEMX6NDrmYgZ
         l1+p3O7t93FfgWzAHMwh5zUIIyiltHS688jQfHqSMvFgimg7/1y0yvjkI/KBMmypnEfm
         GgCektYUPPwEs3fdxBaJsb2EYOr8hmBX/j/1sbkjgN2fucvS5oFzA1XyNeQ1EDyjXB/7
         NDfQ==
X-Gm-Message-State: APjAAAX9XeYcpYr1ngC6Y4ZU+3EsQfFqEfXGH4UgDciuDaYZO8PLwBL1
        gCSxW/ihKSIJhj66btNDJaiUUnL4woo=
X-Google-Smtp-Source: APXvYqy8hJqtOYpA/MSivR05Sq/IZ4OvsNY7QOI5aC+evAd9sZSpLIxWg9Y2s7QEjgY74Y5Myng7dw==
X-Received: by 2002:a19:c14a:: with SMTP id r71mr9844017lff.55.1569021021249;
        Fri, 20 Sep 2019 16:10:21 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 3sm769183ljs.20.2019.09.20.16.10.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 16:10:18 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b20so3192037ljj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:10:18 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr10586601lja.180.1569021018229;
 Fri, 20 Sep 2019 16:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz> <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
In-Reply-To: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 16:10:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
Message-ID: <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file writes
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> Now, I hear you say "those are so small these days that it doesn't
> matter". And maybe you're right. But particularly for slow media,
> triggering good streaming write behavior has been a problem in the
> past.

Which reminds me: the writebehind trigger should likely be tied to the
estimate of the bdi write speed.

We _do_ have that avg_write_bandwidth thing in the bdi_writeback
structure, it sounds like a potentially good idea to try to use that
to estimate when to do writebehind.

No?

            Linus
