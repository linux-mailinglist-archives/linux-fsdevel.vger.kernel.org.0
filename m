Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122D523E9C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHGJHN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 7 Aug 2020 05:07:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58015 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbgHGJHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:07:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-14-hYsxTjzNMdCVWgdtGXWhDw-1; Fri, 07 Aug 2020 10:07:07 +0100
X-MC-Unique: hYsxTjzNMdCVWgdtGXWhDw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 7 Aug 2020 10:07:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 7 Aug 2020 10:07:06 +0100
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
Thread-Index: AQHWZzVGHzqazLGYN0OsEvz6unAGWaksY9+A
Date:   Fri, 7 Aug 2020 09:07:06 +0000
Message-ID: <97285a880c434a4ea9072ff1b9c238e7@AcuMS.aculab.com>
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
> diff --git a/fs/quota/compat.h b/fs/quota/compat.h
> new file mode 100644
> index 00000000000000..ef7d1e12d650b3
> --- /dev/null
> +++ b/fs/quota/compat.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compat.h>
> +
> +struct compat_if_dqblk {
> +	compat_u64			dqb_bhardlimit;
> +	compat_u64			dqb_bsoftlimit;
> +	compat_u64			dqb_curspace;
> +	compat_u64			dqb_ihardlimit;
> +	compat_u64			dqb_isoftlimit;
> +	compat_u64			dqb_curinodes;
> +	compat_u64			dqb_btime;
> +	compat_u64			dqb_itime;
> +	compat_uint_t			dqb_valid;
> +};
> +
> +struct compat_fs_qfilestat {
> +	compat_u64			dqb_bhardlimit;
> +	compat_u64			qfs_nblks;
> +	compat_uint_t			qfs_nextents;
> +};
> +
> +struct compat_fs_quota_stat {
> +	__s8				qs_version;
> +	__u16				qs_flags;
> +	__s8				qs_pad;
> +	struct compat_fs_qfilestat	qs_uquota;
> +	struct compat_fs_qfilestat	qs_gquota;
> +	compat_uint_t			qs_incoredqs;
> +	compat_int_t			qs_btimelimit;
> +	compat_int_t			qs_itimelimit;
> +	compat_int_t			qs_rtbtimelimit;
> +	__u16				qs_bwarnlimit;
> +	__u16				qs_iwarnlimit;
> +};
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 5444d3c4d93f37..e1e9d05a14c3e4 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>  #include <linux/writeback.h>
>  #include <linux/nospec.h>
> +#include "compat.h"
> 
>  static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
>  				     qid_t id)
> @@ -211,8 +212,18 @@ static int quota_getquota(struct super_block *sb, int type, qid_t id,
>  	if (ret)
>  		return ret;
>  	copy_to_if_dqblk(&idq, &fdq);
> -	if (copy_to_user(addr, &idq, sizeof(idq)))
> -		return -EFAULT;
> +
> +	if (compat_need_64bit_alignment_fixup()) {
> +		struct compat_if_dqblk __user *compat_dqblk = addr;
> +
> +		if (copy_to_user(compat_dqblk, &idq, sizeof(*compat_dqblk)))
> +			return -EFAULT;
> +		if (put_user(idq.dqb_valid, &compat_dqblk->dqb_valid))
> +			return -EFAULT;

Isn't this always copying the same value again?
I don't think Linux has any 64 bit systems with a 32bit compat
layer that have 64bit 'int'.
Since the only difference in the structures is the 'end padding'
isn't it enough to just copy the size of the 'compat' structure
in a compat system call?
It might even be that gcc will optimise the condition away
when the structure sizes match.

The same is true for a lot of the rest of this file.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

