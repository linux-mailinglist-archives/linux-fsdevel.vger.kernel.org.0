Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84789250EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgHYC1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 22:27:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2593 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHYC1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:27:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4476e40000>; Mon, 24 Aug 2020 19:26:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 19:27:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 19:27:46 -0700
Received: from [10.2.53.36] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 02:27:46 +0000
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
 <3072d5a0-43c7-3396-c57f-6af83621b71c@nvidia.com>
 <20200825022219.GW1236603@ZenIV.linux.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <69d09a5f-27f2-dd50-d25e-926302b10443@nvidia.com>
Date:   Mon, 24 Aug 2020 19:27:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825022219.GW1236603@ZenIV.linux.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598322404; bh=pXMapS4KmKmBUkx1+DJBiB0+8TtxpALADIKIHQCPLGo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VQyjqIlA9sgJzaRLlsQtP5G3AjYtNzNUJXvj8TyYk3QW4xnkdhInsxCNj8+gWYE1F
         +RBCIm/1AD1/fv1clhKhZK8OIpQo1BRrFp4+EtIXh4DHTJznQAPWAXu48vtPoWEyhQ
         tT5LufttrAQqIiuGRpADDRDQF0ukmJF+HNOj/dCaHFTzWNSqGreGOSuJy9clE/7SFf
         AETqPKFmRRH8ZZz8sxDb3OwSsLb8POODZc9QipjnotHccNQpKJGWRNeSsbhGvfmoQ7
         VtxGWvrTbNWWYDuJeOgnpxEbCOLnuidat3tmFOx03t4JjcLO3DCxeSL9JegWsDs4Qm
         HuUEoMSI4rRjg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 7:22 PM, Al Viro wrote:
> On Mon, Aug 24, 2020 at 07:07:02PM -0700, John Hubbard wrote:
>> On 8/24/20 6:54 PM, Al Viro wrote:
>>> On Fri, Aug 21, 2020 at 09:20:54PM -0700, John Hubbard wrote:
>>>
>>>> Direct IO behavior:
>>>>
>>>>       ITER_IOVEC:
>>>>           pin_user_pages_fast();
>>>>           break;
>>>>
>>>>       ITER_KVEC:    // already elevated page refcount, leave alone
>>>>       ITER_BVEC:    // already elevated page refcount, leave alone
>>>>       ITER_PIPE:    // just, no :)
>>>
>>> Why?  What's wrong with splice to O_DIRECT file?
>>>
>>
>> Oh! I'll take a look. Is this the fs/splice.c stuff?  I ruled this out e=
arly
>> mainly based on Christoph's comment in [1] ("ITER_PIPE is rejected =D1=
=96n the
>> direct I/O path"), but if it's supportable then I'll hook it up.
>=20
> ; cat >a.c <<'EOF'
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
>=20
> int main()
> {
>          int fd =3D open("./a.out", O_DIRECT);
>          splice(fd, NULL, 1, NULL, 4096, 0);
> 	return 0;
> }
> EOF
> ; cc a.c
> ; ./a.out | wc -c
> 4096
>=20
> and you just had ->read_iter() called with ITER_PIPE destination.
>=20

That example saves me a lot of time!  Much appreciated.

thanks,
--=20
John Hubbard
NVIDIA
