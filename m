Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C92BAB1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 14:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKTN3T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 08:29:19 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22428 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgKTN3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:29:18 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-264-OD_kpoYPO02kqUFppqEYAg-1; Fri, 20 Nov 2020 13:29:14 +0000
X-MC-Unique: OD_kpoYPO02kqUFppqEYAg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 13:29:14 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 13:29:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Begunkov' <asml.silence@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Thread-Topic: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Thread-Index: AQHWvsvDuqyPv2EDYECI7EFyRCltYanRAzeA
Date:   Fri, 20 Nov 2020 13:29:14 +0000
Message-ID: <e8067cc132b449b9b0e910622b5210ad@AcuMS.aculab.com>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
In-Reply-To: <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
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

From: Pavel Begunkov
> Sent: 19 November 2020 23:25
>
> The block layer spends quite a while in iov_iter_npages(), but for the
> bvec case the number of pages is already known and stored in
> iter->nr_segs, so it can be returned immediately as an optimisation
> 
> Perf for an io_uring benchmark with registered buffers (i.e. bvec) shows
> ~1.5-2.0% total cycle count spent in iov_iter_npages(), that's dropped
> by this patch to ~0.2%.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  lib/iov_iter.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1635111c5bd2..0fa7ac330acf 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1594,6 +1594,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
>  		return 0;
>  	if (unlikely(iov_iter_is_discard(i)))
>  		return 0;
> +	if (unlikely(iov_iter_is_bvec(i)))
> +		return min_t(int, i->nr_segs, maxpages);
> 
>  	if (unlikely(iov_iter_is_pipe(i))) {

Is it worth putting an extra condition around these three 'unlikely' cases.
ie:
	if (unlikely((iov_iter_type(i) & (ITER_DISCARD | ITER_BVEC | ITER_PIPE)) {
		if (iov_iter_is_discard(i))
			return 0;
		if (iov_iter_is_bvec(i))
			return min_t(int, i->nr_segs, maxpages);
		/* Must be ITER_PIPE */

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

