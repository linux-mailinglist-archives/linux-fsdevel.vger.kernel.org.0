Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82843250EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 04:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHYCHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 22:07:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19949 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYCHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:07:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4472090000>; Mon, 24 Aug 2020 19:06:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 19:07:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 19:07:02 -0700
Received: from [10.2.53.36] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 02:07:02 +0000
Subject: Re: [PATCH 0/5] bio: Direct IO: convert to pin_user_pages_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200825015428.GU1236603@ZenIV.linux.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3072d5a0-43c7-3396-c57f-6af83621b71c@nvidia.com>
Date:   Mon, 24 Aug 2020 19:07:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825015428.GU1236603@ZenIV.linux.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598321161; bh=ZcHTDdlQwnmvisGnEHrOUys0m6Em61G2G45Wkp1xa+Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mdh8z5wVjPjjZG/Qd901xbUylV66hUTuhC/mmJizUuB3/wXCvErWnYXXGHx752ILn
         9+B+sTaebyJsi4SIejtp2bODRqvR+7RWhoWQKPjy0/Xk1gPrc/LmIJHdgdkwT3TZ4Y
         Fk/zImUHa4mn3V1Ft5+fd5Nvy0ubeYnI8qFt+iSOHYg1Wy/8dADqtMYqVYluSHB+1q
         mBg+WEOxM/3khAkFM5rRSzk9JdhnXH43GgU0IWm9TFqvJN+54tUvrJvYijAPyu0ol5
         5WX57bf2/aui+PnN69IJrg27/PcHZUUS/2sNzQ9aHTCK4OOE8fX9e7jvUMjaoxFfNX
         xUO7HzHVFxbPw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 6:54 PM, Al Viro wrote:
> On Fri, Aug 21, 2020 at 09:20:54PM -0700, John Hubbard wrote:
>=20
>> Direct IO behavior:
>>
>>      ITER_IOVEC:
>>          pin_user_pages_fast();
>>          break;
>>
>>      ITER_KVEC:    // already elevated page refcount, leave alone
>>      ITER_BVEC:    // already elevated page refcount, leave alone
>>      ITER_PIPE:    // just, no :)
>=20
> Why?  What's wrong with splice to O_DIRECT file?
>=20

Oh! I'll take a look. Is this the fs/splice.c stuff?  I ruled this out earl=
y
mainly based on Christoph's comment in [1] ("ITER_PIPE is rejected =D1=96n =
the
direct I/O path"), but if it's supportable then I'll hook it up.

(As you can see, I'm still very much coming up to speed on the various thin=
gs
that invoke iov_iter_get_pages*().)

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

thanks,
--=20
John Hubbard
NVIDIA
