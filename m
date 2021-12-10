Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E91470E49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 00:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhLJXER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 18:04:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48782 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhLJXEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:04:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66864B82A0E;
        Fri, 10 Dec 2021 23:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5501C00446;
        Fri, 10 Dec 2021 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639177238;
        bh=Xf3wfuPLYn/SESXVwB3nh4TuzPlgFih4NYbO3gmcg18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqmEu0kVkT+hrHBkWwXw69EzEtYbWKYEMBbLX9z/lY5lK0gUztiNcJSbeRhtGHmJt
         vuyopJNHT0DXXA0GPDRKONnHjScc+xvb9mqzaa3/KMvH9pm8xnqdvlhv4EQBAEnIdT
         TYgG2u+Kk43a8VbIB+bTxRg3YcT2MEapslbychbtPs2F72BnyKX1Rc4ZfdmeggvIuo
         WBEeQl7h6mziPSx0TGidWC4ClwJNVHOjH4JNpc4nceKYIy6PzXcw04cEgSDrDbS9ya
         s9Gl5gplIAtOxth+h+dVp0qrMCEmzduYdv2kgkMkFbU75r7YBw/ubk6klANRb9ukXA
         rWVsX4vFjeATQ==
Date:   Fri, 10 Dec 2021 15:00:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [GIT PULL] aio poll fixes for 5.16-rc5
Message-ID: <YbPcFIUFYmEueuXX@sol.localdomain>
References: <YbOdV8CPbyPAF234@sol.localdomain>
 <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:18:12PM -0800, Linus Torvalds wrote:
> On Fri, Dec 10, 2021 at 10:33 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > This has been tested with the libaio test suite, as well as with test
> > programs I wrote that reproduce the first two bugs.  I am sending this
> > pull request myself as no one seems to be maintaining this code.
> 
> Pulled.
> 
> The "nobody really maintains or cares about epoll/aio" makes me wonder
> if we should just remove the "if EXPERT" from the config options we
> have on them, and start encouraging people to perhaps not even build
> that code any more?
> 
> Because I'm sure we have users of it, but maybe they are few enough
> that saying "don't enable this feature unless you need it" is the
> right thing to do...

Isn't epoll more commonly used than aio?  Either way, removing 'if EXPERT' from
both would make sense, so that they aren't forced on just because someone didn't
set CONFIG_EXPERT.  I think that a lot of people have these options enabled but
don't need them.  Android used to be in that boat for CONFIG_AIO (i.e. it wasn't
needed but was sometimes enabled anyway, maybe due to !CONFIG_EXPERT).
Unfortunately Android has started depending on CONFIG_AIO, so it seems Android
will need to keep it set, but I think most other Linux systems don't need it.

- Eric
