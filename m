Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF47E470F93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 01:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbhLKAtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 19:49:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52131 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345515AbhLKAtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:49:42 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BB0jeK9013733
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:45:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9C31E4205DB; Fri, 10 Dec 2021 19:45:39 -0500 (EST)
Date:   Fri, 10 Dec 2021 19:45:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [GIT PULL] aio poll fixes for 5.16-rc5
Message-ID: <YbP0s7E1a5s+6q9B@mit.edu>
References: <YbOdV8CPbyPAF234@sol.localdomain>
 <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
 <YbPcFIUFYmEueuXX@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPcFIUFYmEueuXX@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:00:36PM -0800, Eric Biggers wrote:
> 
> Isn't epoll more commonly used than aio?  Either way, removing 'if EXPERT' from
> both would make sense, so that they aren't forced on just because someone didn't
> set CONFIG_EXPERT.  I think that a lot of people have these options enabled but
> don't need them.  Android used to be in that boat for CONFIG_AIO (i.e. it wasn't
> needed but was sometimes enabled anyway, maybe due to !CONFIG_EXPERT).
> Unfortunately Android has started depending on CONFIG_AIO, so it seems Android
> will need to keep it set, but I think most other Linux systems don't need it.

Mysql and Postgress both can use libaio, and I suspect many
distributions are compiling them with AIO enabled, since you can get
better performance with AIO.  Fio also uses AIO, and many fio recipes
that are trying to benchmark file systems or block devices use
AIO/DIO.

It's fair to say that the libaio programming interface is pretty
horrendo, and so very few application programmers will happy choosing
to use it.  But if you really care about storage performance, whether
you're implementing a database, or a cluster file system, it's likely
that you will find yourself deciding to try to use it.

The fact that so many storage-centric userspace programs use it
*desite* libaio's developer-hostile interface is a proof point of how
much AIO can help with performance.  Maybe over time we can get folks
to switch to io_uring, and we will eventually be able to get us to the
happy place where most Linux systems won't need CONFIG_AIO.  But that
day is not today.  :-/

So removing the dependency on CONFIG_EXPERT is probably a good idea,
at least for now.

Cheers,

						- Ted
