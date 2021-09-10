Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF940717E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhIJSwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 14:52:08 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:43852 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJSv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:51:58 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOlZi-002y21-5p; Fri, 10 Sep 2021 18:48:34 +0000
Date:   Fri, 10 Sep 2021 18:48:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk>
References: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
 <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk>
 <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:31:00AM -0700, Linus Torvalds wrote:
> On Fri, Sep 10, 2021 at 10:26 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 9/10/21 10:58 AM, Linus Torvalds wrote:
> > > On Fri, Sep 10, 2021 at 9:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >>
> > >> What's the point of all those contortions, anyway?  You only need it for
> > >> iovec case; don't mix doing that and turning it into flavour-independent
> > >> primitive.
> > >
> > > Good point, making it specific to iovec only gets rid of a lot of
> > > special cases and worries.
> > >
> > > This is fairly specialized, no need to always cater to every possible case.
> >
> > Alright, split into three patches:
> >
> > https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter
> 
> That looks sane to me.
> 
> Please add some comment about how that
> 
>         i->iov -= state->nr_segs - i->nr_segs;
> 
> actually is the right thing for all the three cases (iow how 'iov',
> 'kvec' and 'bvec' all end up having a union member that acts the same
> way).
> 
> But yeah, I like how the io_uring.c code looks better this way too.
> 
> Al, what do you think?

I think that sizeof(struct bio_vec) != sizeof(struct iovec):
struct bio_vec {
        struct page     *bv_page;
	unsigned int    bv_len;
	unsigned int    bv_offset;
};
takes 3 words on 32bit boxen.
struct iovec
{
        void __user *iov_base;  /* BSD uses caddr_t (1003.1g requires void *) */
	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
};
takes 2 words on 32bit boxen.
