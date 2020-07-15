Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D7221001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGOOz6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 10:55:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23111 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgGOOz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:55:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-aPZD-QdqNveEotIVVqmAdA-1; Wed, 15 Jul 2020 15:55:51 +0100
X-MC-Unique: aPZD-QdqNveEotIVVqmAdA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jul 2020 15:55:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jul 2020 15:55:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
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
Thread-Index: AQHWWnMrd4ih7YlzG0aqMJfp5omyT6kIuIaQ
Date:   Wed, 15 Jul 2020 14:55:50 +0000
Message-ID: <d6d204c4427b49f6b24ac24bf1082fa4@AcuMS.aculab.com>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org> <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
In-Reply-To: <20200715064248.GH32470@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig
> Sent: 15 July 2020 07:43
> Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
> 
> On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> > On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > > +static int count_strings_kernel(const char *const *argv)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!argv)
> > > +		return 0;
> > > +
> > > +	for (i = 0; argv[i]; ++i) {
> > > +		if (i >= MAX_ARG_STRINGS)
> > > +			return -E2BIG;
> > > +		if (fatal_signal_pending(current))
> > > +			return -ERESTARTNOHAND;
> > > +		cond_resched();
> > > +	}
> > > +	return i;
> > > +}
> >
> > I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> > refactor that too? (And maybe rename it to count_strings_user()?)

Thinks....
If you setup env[] and argv[] on the new user stack early in exec processing
then you may not need any limits at all - except the size of the user stack.
Even the get_user() loop will hit an invalid address before the counter
wraps (provided it is unsigned long).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

