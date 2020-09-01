Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C214F258B8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIAJ3S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 1 Sep 2020 05:29:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47177 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgIAJ3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:29:18 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-67-waiQy7scMTWHtZ1SLW3FRA-1; Tue, 01 Sep 2020 10:29:14 +0100
X-MC-Unique: waiQy7scMTWHtZ1SLW3FRA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 1 Sep 2020 10:29:13 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 1 Sep 2020 10:29:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuqi Jin <jinyuqi@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [NAK] Re: [PATCH] fs: Optimized fget to improve performance
Thread-Topic: [NAK] Re: [PATCH] fs: Optimized fget to improve performance
Thread-Index: AQHWf0XaPFsGRwWaJkSlxP9k8oAd3qlThXHg
Date:   Tue, 1 Sep 2020 09:29:13 +0000
Message-ID: <a12ae69f87e44c7f94cc5283ff55643a@AcuMS.aculab.com>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200827142848.GZ1236603@ZenIV.linux.org.uk>
 <dfa0ec1a-87fc-b17b-4d4a-c2d5c44e6dde@hisilicon.com>
 <20200831032127.GW1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200831032127.GW1236603@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro
> Sent: 31 August 2020 04:21
> 
> On Mon, Aug 31, 2020 at 09:43:31AM +0800, Shaokun Zhang wrote:
> 
> > How about this? We try to replace atomic_cmpxchg with atomic_add to improve
> > performance. The atomic_add does not check the current f_count value.
> > Therefore, the number of online CPUs is reserved to prevent multi-core
> > competition.
> 
> No.  Really, really - no.  Not unless you can guarantee that process on another
> CPU won't lose its timeslice, ending up with more than one increment happening on
> the same CPU - done by different processes scheduled there, one after another.
> 
> If you have some change of atomic_long_add_unless(), do it there.  And get it
> past the arm64 folks.  get_file_rcu() is nothing special in that respect *AND*
> it has to cope with any architecture out there.
> 
> BTW, keep in mind that there's such thing as a KVM - race windows are much
> wider there, since a thread representing a guest CPU might lose its timeslice
> whenever the host feels like that.  At which point you get a single instruction
> on a guest CPU taking longer than many thousands of instructions on another
> CPU of the same guest.

The same thing can happen if a hardware interrupt occurs.
Not only the delays for the interrupt itself, but all the softint
processing that happens as well.
That can take a long time - even milliseconds.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

