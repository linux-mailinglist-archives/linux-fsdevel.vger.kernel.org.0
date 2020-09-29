Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC627BED7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgI2IGi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 04:06:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:26381 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgI2IGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:06:37 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-217-WEwbKJjdNOOsWYNVPyIehQ-1; Tue, 29 Sep 2020 09:06:33 +0100
X-MC-Unique: WEwbKJjdNOOsWYNVPyIehQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 29 Sep 2020 09:06:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 29 Sep 2020 09:06:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "syzbot+51177e4144d764827c45@syzkaller.appspotmail.com" 
        <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: WARNING in __kernel_read (2)
Thread-Topic: WARNING in __kernel_read (2)
Thread-Index: AQHWk7DmAtv55MEfq0C+fzgffzQfPql6xRLQgAAhQ/CABE1+YYAAEyYg
Date:   Tue, 29 Sep 2020 08:06:32 +0000
Message-ID: <e81e2721e8ce4612b0fc6098d311d378@AcuMS.aculab.com>
References: <000000000000da992305b02e9a51@google.com>
 <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com>
 <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com>
 <20200928221441.GF1340@sol.localdomain> <20200929063815.GB1839@lst.de>
 <20200929064648.GA238449@sol.localdomain> <20200929065601.GA2095@lst.de>
In-Reply-To: <20200929065601.GA2095@lst.de>
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

From: Christoph Hellwig
> Sent: 29 September 2020 07:56
> 
> On Mon, Sep 28, 2020 at 11:46:48PM -0700, Eric Biggers wrote:
> > > Linus asked for it.  What is the call chain that we hit it with?
> >
> > Call Trace:
> >  kernel_read+0x52/0x70 fs/read_write.c:471
> >  kernel_read_file fs/exec.c:989 [inline]
> >  kernel_read_file+0x2e5/0x620 fs/exec.c:952
> >  kernel_read_file_from_fd+0x56/0xa0 fs/exec.c:1076
> >  __do_sys_finit_module+0xe6/0x190 kernel/module.c:4066
> >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > See the email from syzbot for the full details:
> > https://lkml.kernel.org/linux-fsdevel/000000000000da992305b02e9a51@google.com
> 
> Passing a fs without read permissions definitively looks bogus for
> the finit_module syscall.  So I think all we need is an extra check
> to validate the fd.

The sysbot test looked like it didn't even have a regular file.
I thought I saw a test for that - but it might be in a different path.

You do need to ensure that 'exec' doesn't need read access.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

