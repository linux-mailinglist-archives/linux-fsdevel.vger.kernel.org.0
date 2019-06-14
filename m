Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92FF451F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 04:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfFNCiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 22:38:50 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33933 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfFNCit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:38:49 -0400
Received: by mail-lj1-f180.google.com with SMTP id p17so779708ljg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54SzfXIM0CUZELnkDPId2LFnAOP2eMm66mZYeVaiMIc=;
        b=b6wus35DaLhs8FFeq7PNRZ3hYyz4oMdypJnhTcMZaFiSx3caRk6yJHOkFLmXfc68gQ
         FYnDbGsYmvinxpLwPoM2+Xa2pga+BkCWG8bI9aaj+MagRJ3SZ/YT13ZFs5CQZvlGQwk+
         z315q1qxQWAhXJ4qm5Fc+0jzeL3t3lDjn2XKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54SzfXIM0CUZELnkDPId2LFnAOP2eMm66mZYeVaiMIc=;
        b=V187JhdbjpWQnr9ce6oe8UNggnbfydRA9UUU8WPWyFru8uAGguE3DYtiZA4lF9UEFY
         SVHY8IPtXmqnybifJ5GP3TmYDign/TnLF49gVlEXK8SFw3ERpRxVPCXLvX5+RDl1f+9+
         9YCXIHISMqoH1PeHB/znq2875NqLysUx9A7qskDSd5JWRYlg+ZfG/1MpL13yvuGGk6I4
         zolYFmmlsNPA6ruDGg0c7eD0IR7B1Jag3EYvHhy3peTjFL3lJsIPBLXuOx4Igy9NOlkO
         xTb8SsC74ugIZhlfF6vLRV/JDDJ2Q/PJM4mbjd2wz6YWrIlys+ZAHwj+b0AappYvjcAz
         SceQ==
X-Gm-Message-State: APjAAAU5X45Zh7fg09C7YwCo9dpoMgdrVK4PtandpTpXsQ4Ew1lXUDMo
        6NWb9p9pcxj8/u3vW5NnCmML7VnFEqM=
X-Google-Smtp-Source: APXvYqzs1b84T2jRXdAgbQHDkob/b4+ha+B+1yfTz8Xe1kwXHM6s6esq+D9kQpB9yd65xGECmKwQiA==
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr618361lji.133.1560479927609;
        Thu, 13 Jun 2019 19:38:47 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l15sm345587ljh.0.2019.06.13.19.38.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 19:38:47 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v18so749190ljh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 19:38:47 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr11450885ljk.90.1560479452914;
 Thu, 13 Jun 2019 19:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
In-Reply-To: <20190613235524.GK14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jun 2019 16:30:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com>
Message-ID: <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:56 PM Dave Chinner <david@fromorbit.com> wrote:
>
> That said, the page cache is still far, far slower than direct IO,

Bullshit, Dave.

You've made that claim before, and it's been complete bullshit before
too, and I've called you out on it then too.

Why do you continue to make this obviously garbage argument?

The key word in the "page cache" name is "cache".

Caches work, Dave. Anybody who thinks caches don't work is
incompetent. 99% of all filesystem accesses are cached, and they never
do any IO at all, and the page cache handles them beautifully.

When you say that the page cache is slower than direct IO, it's
because you don't even see or care about the *fast* case. You only get
involved once there is actual IO to be done.

So you're making that statement without taking into account all the
cases that you don't see, and that you don't care about, because the
page cache has already handled them for you, and done so much better
than DIO can do or ever _will_ do.

Is direct IO faster when you *know* it's not cached, and shouldn't be
cached? Sure. But that/s actually quite rare.

How often do you use non-temporal stores when you do non-IO
programming? Approximately never, perhaps? Because caches work.

And no, SSD's haven't made caches irrelevant. Not doing IO at all is
still orders of magnitude faster than doing IO. And it's not clear
nvdimms will either.

So stop with the stupid and dishonest argument already, where you
ignore the effects of caching.

                Linus
