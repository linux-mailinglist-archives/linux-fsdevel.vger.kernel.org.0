Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0828571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfEWR55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 13:57:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14026 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbfEWR55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 13:57:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce6df1f0001>; Thu, 23 May 2019 10:57:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 10:57:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 10:57:56 -0700
Received: from [10.2.169.219] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 17:57:52 +0000
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
 <20190523153133.GB5104@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <708b9fc4-9afd-345e-83f7-2ceae673a4fd@nvidia.com>
Date:   Thu, 23 May 2019 10:56:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523153133.GB5104@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558634272; bh=L+NsLVitjlajK5Fndh2v4VhhHtFHNGHsvBcTolR7zkE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nsqB1IeZFCuxxH6mHCvcXZ7r8Pp4bj2szDVLBKtv72WLrTh+NFjrf0A9KJEyx6nYx
         xdOeSAheQUOMNx3oiM4T5lPXrconSMMy+s+NQQGNgYdc8sEtCh47sE/Vm2HaLAaAiM
         ZkDCNxXsOFRKAzoqGDNk4VwTtjSCvSWvNbEHPsRyJWAOhct4eHLdLrjBtMsYIdiBlt
         5oCBCOxrHcv0zQQw/jFLI9tSx2R80yUokM0UWuJfUGjOnoC4ZlmwXm8CgKnBSRfcj9
         tGwlXMkJwAUQcdbP4pb8SVB7v69N3DEB/BN9mMBxHFJfBkMi22AShiQE/7gH5lfnTw
         1abZmIUAVz0tA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/19 8:31 AM, Jerome Glisse wrote:
[...]
>=20
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20

Thanks for the review!

> Between i have a wishlist see below
[...]
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/um=
em.c
>> index e7ea819fcb11..673f0d240b3e 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -54,9 +54,10 @@ static void __ib_umem_release(struct ib_device *dev, =
struct ib_umem *umem, int d
>>  =20
>>   	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
>>   		page =3D sg_page_iter_page(&sg_iter);
>> -		if (!PageDirty(page) && umem->writable && dirty)
>> -			set_page_dirty_lock(page);
>> -		put_page(page);
>> +		if (umem->writable && dirty)
>> +			put_user_pages_dirty_lock(&page, 1);
>> +		else
>> +			put_user_page(page);
>=20
> Can we get a put_user_page_dirty(struct page 8*pages, bool dirty, npages)=
 ?
>=20
> It is a common pattern that we might have to conditionaly dirty the pages
> and i feel it would look cleaner if we could move the branch within the
> put_user_page*() function.
>=20

This sounds reasonable to me, do others have a preference on this? Last tim=
e
we discussed it, I recall there was interest in trying to handle the sg lis=
ts,
which was where a lot of focus was. I'm not sure if there was a preference =
one=20
way or the other, on adding more of these helpers.


thanks,
--=20
John Hubbard
NVIDIA
