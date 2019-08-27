Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8599E868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfH0Mxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 08:53:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfH0Mx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:53:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2ayS-0000Bl-FF; Tue, 27 Aug 2019 12:53:24 +0000
Date:   Tue, 27 Aug 2019 13:53:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190827125324.GR1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <20190826182017.GE15933@bombadil.infradead.org>
 <20190826192819.GO1131@ZenIV.linux.org.uk>
 <20190827085144.GA31244@miu.piliscsaba.redhat.com>
 <20190827115808.GQ1131@ZenIV.linux.org.uk>
 <CAJfpegvvi0XLhtB3JxyVfzSG4T8A0k+CZ6=8EMUDsgWcwZkvyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvvi0XLhtB3JxyVfzSG4T8A0k+CZ6=8EMUDsgWcwZkvyg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:21:50PM +0200, Miklos Szeredi wrote:
> On Tue, Aug 27, 2019 at 1:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Aug 27, 2019 at 10:51:44AM +0200, Miklos Szeredi wrote:
> >
> > > How about something like this:
> > >
> > > #if BITS_PER_LONG == 32
> > > #define F_COUNT_SHORTTERM ((1UL << 24) + 1)
> > > #else
> > > #define F_COUNT_SHORTTERM ((1UL << 48) + 1)
> > > #endif
> > >
> > > static inline void get_file_shortterm(struct file *f)
> > > {
> > >       atomic_long_add(F_COUNT_SHORTTERM, &f->f_count);
> > > }
> > >
> > > static inline void put_file_shortterm(struct file *f)
> > > {
> > >       fput_many(f, F_COUNT_SHORTTERM);
> > > }
> > >
> > > static inline bool file_is_last_longterm(struct file *f)
> > > {
> > >       return atomic_long_read(&f->f_count) % F_COUNT_SHORTTERM == 1;
> > > }
> >
> > So 256 threads boinking on the same fdinfo at the same time
> > and struct file can be freed right under them?
> 
> Nope, 256 threads booking short term refs will result in f_count = 256
> (note the +1 in .F_COUNT_SHORTTERM).  Which can result in false
> negative returned by file_is_last_longterm() but no false freeing.

Point (sorry, should've grabbed some coffee to wake up properly before replying)

> >  Or a bit over
> > million of dup(), then forking 15 more children, for that matter...
> 
> Can give false positive for file_is_last_longterm() but no false freeing.
> 
> 255 short term refs + ~16M long term refs together can result in false
> freeing, true.

Yes.  No matter how you slice it, the main problem with f_count
overflows (and the reason for atomic_long_t for f_count) is that
we *can* have a lot of references to struct file, held just by
descriptor tables.  Those are almost pure arrays of pointers (well,
that and a couple of bitmaps), so "it would be impossible to fit
into RAM" is not that much of a limitation.  512M references to
the same struct file are theoretically doable; 256M *are* doable,
and the (32bit) hardware doesn't have to be all that beefy.

So you need to distinguish 2^28 possible states on the long-term
references alone.  Which leaves you 4 bits for anything else,
no matter how you encode that.  And that's obviously too little.
 
> > Seriously, it might be OK on 64bit (with something like "no more
> > than one reference held by a thread", otherwise you'll run
> > into overflows even there - 65536 of your shortterm references
> > aren't that much).  On 32bit it's a non-starter - too easy to
> > overflow.
> 
> No, 64bit would be impossible to overflow.  But if we have to special
> case 32bit then it's not worth it...

Agreed and agreed.
