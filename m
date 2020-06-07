Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8843B1F0B60
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 15:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgFGNWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 7 Jun 2020 09:22:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:60811 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbgFGNWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:22:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-157-dqJ-C61mOWemWDc1herPnQ-1; Sun, 07 Jun 2020 14:22:49 +0100
X-MC-Unique: dqJ-C61mOWemWDc1herPnQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 7 Jun 2020 14:22:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 7 Jun 2020 14:22:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Szabolcs Nagy' <nsz@port70.net>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>
Subject: RE: [PATCH v5 1/3] open: add close_range()
Thread-Topic: [PATCH v5 1/3] open: add close_range()
Thread-Index: AQHWO0lrkRMjBAtF4kyptmA+TsanYKjNIo+Q
Date:   Sun, 7 Jun 2020 13:22:48 +0000
Message-ID: <46cd4282193641bf801fb150d482c624@AcuMS.aculab.com>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com>
 <20200605145549.GC673948@port70.net>
In-Reply-To: <20200605145549.GC673948@port70.net>
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

From: Szabolcs Nagy
> Sent: 05 June 2020 15:56
...
> currently there is no libc interface contract in place that
> says which calls may use libc internal fds e.g. i've seen
> 
>   openlog(...) // opens libc internal syslog fd
>   ...
>   fork()
>   closefrom(...) // close syslog fd
>   open(...) // something that reuses the closed fd
>   syslog(...) // unsafe: uses the wrong fd
>   execve(...)
> 
> syslog uses a libc internal fd that the user trampled on and
> this can go bad in many ways depending on what libc apis are
> used between closefrom (or equivalent) and exec.

It is, of course, traditional that daemons only call
close(0); close(1); close(2);
Took us ages to discover that a misspelt fprintf()
was adding data to the stdout buffer and eventually
flushing 10k of ascii text into an inter-process pipe
that had a 32bit field for 'message extension length'.

FWIW isn't syslog() going to go badly wrong after fork()
anyway?
Unless libc's fork() calls closelog().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

