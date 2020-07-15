Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65502212E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGOQqv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:46:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44532 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgGOQqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:46:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-52-I5MfYmGMN8WVVlleqrOfeQ-1; Wed, 15 Jul 2020 17:46:45 +0100
X-MC-Unique: I5MfYmGMN8WVVlleqrOfeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jul 2020 17:46:44 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jul 2020 17:46:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     'Christoph Hellwig' <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "John Johansen" <john.johansen@canonical.com>
Subject: RE: [PATCH 7/7] exec: Implement kernel_execve
Thread-Topic: [PATCH 7/7] exec: Implement kernel_execve
Thread-Index: AQHWWnMrd4ih7YlzG0aqMJfp5omyT6kIuIaQ///1mACAACJpAA==
Date:   Wed, 15 Jul 2020 16:46:44 +0000
Message-ID: <dc8371b7e05d4aa49eefcfd402b3fa1e@AcuMS.aculab.com>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org> <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
 <d6d204c4427b49f6b24ac24bf1082fa4@AcuMS.aculab.com>
 <202007150801.27B6690@keescook>
In-Reply-To: <202007150801.27B6690@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
> Sent: 15 July 2020 16:09
> 
> On Wed, Jul 15, 2020 at 02:55:50PM +0000, David Laight wrote:
> > From: Christoph Hellwig
> > > Sent: 15 July 2020 07:43
> > > Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
> > >
> > > On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> > > > On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > > > > +static int count_strings_kernel(const char *const *argv)
> > > > > +{
> > > > > +	int i;
> > > > > +
> > > > > +	if (!argv)
> > > > > +		return 0;
> > > > > +
> > > > > +	for (i = 0; argv[i]; ++i) {
> > > > > +		if (i >= MAX_ARG_STRINGS)
> > > > > +			return -E2BIG;
> > > > > +		if (fatal_signal_pending(current))
> > > > > +			return -ERESTARTNOHAND;
> > > > > +		cond_resched();
> > > > > +	}
> > > > > +	return i;
> > > > > +}
> > > >
> > > > I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> > > > refactor that too? (And maybe rename it to count_strings_user()?)
> >
> > Thinks....
> > If you setup env[] and argv[] on the new user stack early in exec processing
> > then you may not need any limits at all - except the size of the user stack.
> > Even the get_user() loop will hit an invalid address before the counter
> > wraps (provided it is unsigned long).
> 
> *grumpy noises* Yes, but not in practice (if I'm understanding what you
> mean). The expectations of a number of execution environments can be
> really odd-ball. I've tried to collect the notes from over the years in
> prepare_arg_pages()'s comments, and it mostly boils down to "there has
> to be enough room for the exec to start" otherwise the exec ends up in a
> hard-to-debug failure state (i.e. past the "point of no return", where you
> get no useful information about the cause of the SEGV). So the point has
> been to move as many of the setup checks as early as possible and report
> about them if they fail. The argv processing is already very early, but
> it needs to do the limit checks otherwise it'll just break after the exec
> is underway and the process will just SEGV. (And ... some environments
> will attempt to dynamically check the size of the argv space by growing
> until it sees E2BIG, so we can't just remove it and let those hit SEGV.)

Yes - I bet the code is horrid.
I guess the real problem is that you'd need access to the old process's
user addresses and the new process's stack area at the same time.
Unless there is a suitable hole in the old process's address map
any attempted trick will fall foul of cache aliasing on some
architectures - like anything else that does page-loaning.

I'm sure there are hair-brained schemes that might work.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

