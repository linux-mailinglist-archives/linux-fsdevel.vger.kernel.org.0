Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5641917E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhI0J2K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 05:28:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:44064 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233651AbhI0J2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:28:08 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-4-3AuGKXHNP3yOOjk_BFzmyA-1;
 Mon, 27 Sep 2021 10:26:28 +0100
X-MC-Unique: 3AuGKXHNP3yOOjk_BFzmyA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 27 Sep 2021 10:16:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 27 Sep 2021 10:16:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
CC:     Vito Caputo <vcaputo@pengaru.com>, Jann Horn <jannh@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        =?iso-8859-1?Q?Michael_Wei=DF?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, "Helge Deller" <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andrea Righi" <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] proc: Disable /proc/$pid/wchan
Thread-Topic: [PATCH] proc: Disable /proc/$pid/wchan
Thread-Index: AQHXsUu6q24nweQ620C+j1L7pwAX2Ku3nV0w
Date:   Mon, 27 Sep 2021 09:16:17 +0000
Message-ID: <19928a006302450a89b17e7f9b9e4848@AcuMS.aculab.com>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook> <20210924135424.GA33573@C02TD0UTHF1T.local>
In-Reply-To: <20210924135424.GA33573@C02TD0UTHF1T.local>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mark Rutland
> Sent: 24 September 2021 14:54
> 
> On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > entrypoint address in the current task struct for get_wchan() to
> > > access, whenever userspace enters the kernel?
> >
> > wchan is supposed to show where the kernel is at the instant the
> > get_wchan() happens. (i.e. recording it at syscall entry would just
> > always show syscall entry.)
> 
> It's supposed to show where a blocked task is blocked; the "wait
> channel".
> 
> I'd wanted to remove get_wchan since it requires cross-task stack
> walking, which is generally painful.
> 
> We could instead have the scheduler entrypoints snapshot their caller
> into a field in task_struct. If there are sufficiently few callers, that
> could be an inline wrapper that passes a __func__ string. Otherwise, we
> still need to symbolize.

It ought to be something stashed in the 'wait_queue_head'.
Perhaps defaulting to the address/name of the function that
initialised it.

That would be much nearer the original (pre Linux) semantics.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

