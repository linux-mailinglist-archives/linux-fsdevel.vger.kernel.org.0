Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8971EC5CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFBXd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 19:33:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54611 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgFBXd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:33:58 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jgGPs-0001xM-5J; Tue, 02 Jun 2020 23:33:56 +0000
Date:   Wed, 3 Jun 2020 01:33:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v5 0/3] close_range()
Message-ID: <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:03:09PM -0700, Linus Torvalds wrote:
> On Tue, Jun 2, 2020 at 1:42 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This is a resend of the close_range() syscall, as discussed in [1]. There weren't any outstanding
> > discussions anymore and this was in mergeable shape. I simply hadn't gotten around to moving this
> > into my for-next the last few cycles and then forgot about it. Thanks to Kyle and the Python people,
> > and others for consistenly reminding me before every merge window and mea culpa for not moving on
> > this sooner. I plan on moving this into for-next after v5.8-rc1 has been released and targeting the
> > v5.9 merge window.
> 
> Btw, I did have one reaction that I can't find in the original thread,
> which probably means that it got lost.
> 
> If one of the designed uses for this is for dropping file descriptors
> just before execve(), it's possible that we'd want to have the option
> to say "unshare my fd array" as part of close_range().
> 
> Yes, yes, you can do
> 
>         unshare(CLONE_FILES);
>         close_range(3,~0u);
> 
> to do it as two operations (and you had that as the example typical
> use), but it would actually be better to be able to do
> 
>         close_range(3, ~0ul, CLOSE_RANGE_UNSHARE);
> 
> instead. Because otherwise we just waste time copying the file
> descriptors first in the unshare, and then closing them after.. Double
> the work..
> 
> And maybe this _did_ get mentioned last time, and I just don't find
> it. I also don't see anything like that in the patches, although the
> flags argument is there.

I spent some good time digging and I couldn't find this mentioned
anywhere so maybe it just never got sent to the list?
It sounds pretty useful, so yeah let me add a patch for this tomorrow.

Christian
