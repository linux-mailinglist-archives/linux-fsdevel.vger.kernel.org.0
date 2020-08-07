Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6423EA86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgHGJip convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 7 Aug 2020 05:38:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30485 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbgHGJin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:38:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-16-5qKKb2pWNfK428LdGWcIog-1; Fri, 07 Aug 2020 10:38:39 +0100
X-MC-Unique: 5qKKb2pWNfK428LdGWcIog-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 7 Aug 2020 10:38:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 7 Aug 2020 10:38:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>, "Jan Kara" <jack@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: RE: [PATCH 3/3] quota: simplify the quotactl compat handling
Thread-Topic: [PATCH 3/3] quota: simplify the quotactl compat handling
Thread-Index: AQHWZzVGHzqazLGYN0OsEvz6unAGWaksbb8Q
Date:   Fri, 7 Aug 2020 09:38:38 +0000
Message-ID: <f894de9f065f4bf9a451668dfbf35591@AcuMS.aculab.com>
References: <20200731122202.213333-1-hch@lst.de>
 <20200731122202.213333-4-hch@lst.de>
In-Reply-To: <20200731122202.213333-4-hch@lst.de>
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

From: Christoph Hellwig
> Sent: 31 July 2020 13:22
> 
> Fold the misaligned u64 workarounds into the main quotactl flow instead
> of implementing a separate compat syscall handler.
> 
...
> +static int compat_copy_fs_quota_stat(struct compat_fs_quota_stat __user *to,
> +		struct fs_quota_stat *from)
> +{
> +	if (put_user(from->qs_version, &to->qs_version) ||
> +	    put_user(from->qs_flags, &to->qs_flags) ||
> +	    put_user(from->qs_pad, &to->qs_pad) ||
> +	    compat_copy_fs_qfilestat(&to->qs_uquota, &from->qs_uquota) ||
> +	    compat_copy_fs_qfilestat(&to->qs_gquota, &from->qs_gquota) ||
> +	    put_user(from->qs_incoredqs, &to->qs_incoredqs) ||
> +	    put_user(from->qs_btimelimit, &to->qs_btimelimit) ||
> +	    put_user(from->qs_itimelimit, &to->qs_itimelimit) ||
> +	    put_user(from->qs_rtbtimelimit, &to->qs_rtbtimelimit) ||
> +	    put_user(from->qs_bwarnlimit, &to->qs_bwarnlimit) ||
> +	    put_user(from->qs_iwarnlimit, &to->qs_iwarnlimit))
> +		return -EFAULT;
> +	return 0;
> +}

That might look better as a 'noinline' function that copied
all the fields into an on-stack struct compat_fs_quota_stat
and then did a single copy_to_user().

(I do 'like' qs_pad - I wonder what the person who added
it was smoking.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

