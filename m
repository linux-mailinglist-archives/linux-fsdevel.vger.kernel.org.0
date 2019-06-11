Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF13C7A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405110AbfFKJwa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 05:52:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51653 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404366AbfFKJwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:52:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-196-OKKF5U8lNxCJ1snZU1YqkA-1; Tue, 11 Jun 2019 10:52:27 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 11 Jun 2019 10:52:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Jun 2019 10:52:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
Thread-Index: AQHVH9JWknGdQ9+D0UeylJNmvFzQKKaWJ31Q
Date:   Tue, 11 Jun 2019 09:52:25 +0000
Message-ID: <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>     <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
In-Reply-To: <87lfy96sta.fsf@xmission.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: OKKF5U8lNxCJ1snZU1YqkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric W. Biederman
> Sent: 10 June 2019 22:21
...
> >
> > As for "remove saved_sigmask" I have some concerns... At least this
> > means a user-visible change iiuc. Say, pselect unblocks a fatal signal.
> > Say, SIGINT without a handler. Suppose SIGINT comes after set_sigmask().
> >
> > Before this change the process will be killed.
> >
> > After this change it will be killed or not. It won't be killed if
> > do_select() finds an already ready fd without blocking, or it finds a
> > ready fd right after SIGINT interrupts poll_schedule_timeout().
> 
> Yes.  Because having the signal set in real_blocked disables the
> immediate kill optimization, and the signal has to be delivered before
> we decide to kill the process.  Which matters because as you say if
> nothing checks signal_pending() when the signals are unblocked we might
> not attempt to deliver the signal.
> 
> So it is a matter of timing.
> 
> If we have both a signal and a file descriptor become ready
> at the same time I would call that a race.  Either could
> wake up the process and depending on the exact time we could
> return either one.
> 
> So it is possible that today if the signal came just after the file
> descriptor ,the code might have made it to restore_saved_sigmask_unless,
> before __send_signal runs.
> 
> I see the concern.  I think in a matter like this we try it.  Make
> the patches clean so people can bisect the problem.  Then if someone
> runs into this problem we revert the offending patches.

If I have an application that has a loop with a pselect call that
enables SIGINT (without a handler) and, for whatever reason,
one of the fd is always 'ready' then I'd expect a SIGINT
(from ^C) to terminate the program.

A quick test program:

#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include <sys/select.h>
#include <signal.h>

int main(int argc, char **argv)
{
        fd_set readfds;
        sigset_t sig_int;
        struct timespec delay = {1, 0};

        sigfillset(&sig_int);
        sigdelset(&sig_int, SIGINT);

        sighold(SIGINT);

        for (;;) {
                FD_ZERO(&readfds);
                FD_SET(0, &readfds);
                pselect(1, &readfds, NULL, NULL, &delay, &sig_int);

                poll(0,0,1000);
        }
}

Run under strace to see what is happening and send SIGINT from a different terminal.
The program sleeps for a second in each of the pselect() and poll() calls.
Send a SIGINT and in terminates after pselect() returns ERESTARTNOHAND.

Run again, this time press enter - making fd 0 readable.
pselect() returns 1, but the program still exits.
(Tested on a 5.1.0-rc5 kernel.)

If a signal handler were defined it should be called instead.

FWIW is ERESTARTNOHAND actually sane here?
If I've used setitimer() to get SIGALARM generated every second I'd
expect select() to return EINTR every second even if I don't
have a SIGALARM handler?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

