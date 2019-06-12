Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DE34289B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439611AbfFLOSd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 10:18:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:29128 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbfFLOSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:18:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-67-6FlXZ1SPP5GXeJczNtEwpw-1; Wed, 12 Jun 2019 15:18:29 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 12 Jun 2019 15:18:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 12 Jun 2019 15:18:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oleg Nesterov' <oleg@redhat.com>
CC:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "e@80x24.org" <e@80x24.org>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "omar.kilani@gmail.com" <omar.kilani@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Thread-Topic: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Thread-Index: AQHVH9JWknGdQ9+D0UeylJNmvFzQKKaWJ31QgAHScICAABPkMA==
Date:   Wed, 12 Jun 2019 14:18:28 +0000
Message-ID: <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <20190612134558.GB3276@redhat.com>
In-Reply-To: <20190612134558.GB3276@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 6FlXZ1SPP5GXeJczNtEwpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Oleg Nesterov
> Sent: 12 June 2019 14:46
> On 06/11, David Laight wrote:
> >
> > If I have an application that has a loop with a pselect call that
> > enables SIGINT (without a handler) and, for whatever reason,
> > one of the fd is always 'ready' then I'd expect a SIGINT
> > (from ^C) to terminate the program.
> 
> This was never true.
> 
> Before Eric's patches SIGINT can kill a process or not, depending on timing.
> In particular, if SIGINT was already pending before pselect() and it finds
> an already ready fd, the program won't terminate.

Which matches what I see on a very old Linux system.

> After the Eric's patches SIGINT will only kill the program if pselect() does
> not find a ready fd.
> 
> And this is much more consistent. Now we can simply say that the signal will
> be delivered only if pselect() fails and returns -EINTR. If it doesn't have
> a handler the process will be killed, otherwise the handler will be called.

But is it what the standards mandate?
Can anyone check how Solaris and any of the BSDs behave?
I don't have access to any solaris systems (I doubt I'll get the disk to
spin on the one in my garage).
I can check NetBSD when I get home.

The ToG page for pselect() http://pubs.opengroup.org/onlinepubs/9699919799/functions/pselect.html says:
    "If sigmask is not a null pointer, then the pselect() function shall replace
    the signal mask of the caller by the set of signals pointed to by sigmask
    before examining the descriptors, and shall restore the signal mask of the
    calling thread before returning."
Note that it says 'before examining the descriptors' not 'before blocking'.
Under the general description about signals it also says that the signal handler
will be called (or other action happen) when a pending signal is unblocked.
So unblocking SIGINT (set to SIG_DFL) prior to examining the descriptors
should be enough to cause the process to exit.
The fact that signal handlers are not called until 'return to user'
is really an implementation choice - but (IMHO) it should appear as if they
were called at the time they became unmasked.

If nothing else the man pages need a note about the standards and portability.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

