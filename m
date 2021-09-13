Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B94409750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhIMPbI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 11:31:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35897 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245009AbhIMPap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:30:45 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-59-s7kT8NiFNp-vigLzY9tt5Q-1; Mon, 13 Sep 2021 16:29:28 +0100
X-MC-Unique: s7kT8NiFNp-vigLzY9tt5Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 13 Sep 2021 16:29:25 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 13 Sep 2021 16:29:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [git pull] iov_iter fixes
Thread-Topic: [git pull] iov_iter fixes
Thread-Index: AQHXpe6WnyOXE2m/lE6WyXaZJtHW8KuiGVDA
Date:   Mon, 13 Sep 2021 15:29:25 +0000
Message-ID: <e898f440ee01490cb2c4503241a1f7aa@AcuMS.aculab.com>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
 <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
 <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
 <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
 <YTrHYYEQslQzvnWW@zeniv-ca.linux.org.uk>
In-Reply-To: <YTrHYYEQslQzvnWW@zeniv-ca.linux.org.uk>
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

From: Al Viro <viro@ftp.linux.org.uk>
> Sent: 10 September 2021 03:48
> 
> On Thu, Sep 09, 2021 at 07:35:13PM -0600, Jens Axboe wrote:
> 
> > Yep ok I follow you now. And yes, if we get a partial one but one that
> > has more consumed than what was returned, that would not work well. I'm
> > guessing that a) we've never seen that, or b) we always end up with
> > either correctly advanced OR fully advanced, and the fully advanced case
> > would then just return 0 next time and we'd just get a short IO back to
> > userspace.
> >
> > The safer way here would likely be to import the iovec again. We're
> > still in the context of the original submission, and the sqe hasn't been
> > consumed in the ring yet, so that can be done safely.
> 
> ... until you end up with something assuming that you've got the same
> iovec from userland the second time around.
> 
> IOW, generally it's a bad idea to do that kind of re-imports.


IIRC the canonical 'import' code is something like:

	struct iov iov[8], *cache = iov;
	struct iter;

	iov_iter_import(&iter, ... , &cache, 8);

	result = ....

	if (cache != iov)
		kfree(cache);

	return result;

The iov[] and 'cache' are always allocated on stack with 'iter'.

Now processing the 'iter' advances iter->iov.
So to reset you need the start point - which is either 'cache' or 'iov[]'.
The outer caller (typically) has this information.
But the inner functions don't.

Move both 'iov[]' and 'cache' into struct iter and they become
available to all the code.
It would also simplify the currently horrid boilerplate code
that is replicated for every user.

You might need a 'offset in current iter->iov[]' but nothing else.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

