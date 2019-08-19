Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0354694F84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfHSVBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 17:01:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6549 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSVBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:01:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5b0e150001>; Mon, 19 Aug 2019 14:01:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 14:01:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 19 Aug 2019 14:01:10 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 21:01:09 +0000
Received: from [10.2.161.11] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 21:01:09 +0000
Subject: Re: [RFC PATCH v2 2/3] mm/gup: introduce FOLL_PIN flag for
 get_user_pages()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Bharath Vedartham" <linux.bhar@gmail.com>
References: <20190817022419.23304-1-jhubbard@nvidia.com>
 <20190817022419.23304-3-jhubbard@nvidia.com>
 <5a95d15b-f54c-e663-7031-c2bf9b19899e@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <252677d2-9e98-d4c8-7fe4-26635c05334d@nvidia.com>
Date:   Mon, 19 Aug 2019 13:59:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5a95d15b-f54c-e663-7031-c2bf9b19899e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566248470; bh=vl1GVCNIrilyALRxb5n0ufm74IES1+XneLPl9dgh6lA=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mM94VwganRCZrt6v6UGZSTEpO6uOcs8kAY0ekNDgsUXL4dZeWkSB7CsGeCRWy6/fR
         OjEVn4ebUUA62eLB0+2XQSPDLNIAhoNem9MsNvJiq5usLc+e6nHIdIPhtYnw7qJZ03
         Q4hQ57f4C30ediziBOifrI3wUN9gFsQUtPvY0WdBgYZgo9kYMEq1C1/eHqyOKVL8CW
         FEg85YzjBn9AdL3FJPxeRBYUQP6RSPnALAT5yduufUXwM9pLEM6p8BT67OxwF8XGjh
         /6w4lBWLddHMgwcuNVgG6yjU/kLluTlsWO4f+BmWSa6KkgPUVr2rLEq/QdzzK/Ac4z
         5bg+buL4eKhfQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/19 7:36 PM, John Hubbard wrote:
> On 8/16/19 7:24 PM, jhubbard@nvidia.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>> DKIM-Signature: v=01 a a-sha256; c=0Elaxed/relaxed; d idia.com; s=01;
>> 	t=1566008674; bh=05Mai0va6k/z2enpQJ4Nfvbj5WByFxGAO1JwdIBbXio	h PGP-Univ=
ersal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
>> 	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
>> 	 Content-Transfer-Encoding:Content-Type;
>> 	b=C3=96UDSde9XF/IsNteBaYOBWeKiHhWmeU9ekUJNvCviHssBDCtw0T+M/2TlEPEzomIT
>> 	 fGXzIQNlGN6MXFbaBoyBmF/zjCu02TmTNExbVJ3/5N6PTyOuJFCx9ZN1/5gXsB11m1
>> 	 xAHIWE+VOZs4qqDeHDBqKZq+FaxQHNvGz0j6lyVBA70TfseNoZqZZrSil8uvaKJwKd
>> 	 TQ1ht+AGWbw9p610JmaPb4u6o/eV6Ns8Sl3EVnjWWu94T6ISNIaWCiC6wQQF6L1YCH
>> 	 G5Pjn+0rEjhk6XG4TyLudi5lWp3IVBHd8+WlWlnl+bvLCC55RUAjPJLn7LaVyVdh0F
>> 	 nLHwm3bN2Jotg
>=20
> I cannot readily explain the above email glitch, but I did just now switc=
h
> back to mailgw.nvidia.com for this patchset, in order to get the nice beh=
avior
> of having "From:" really be my native NVIDIA email address. That's very n=
ice,
> but if the glitches happen again, I'll switch back to using gmail for
> git-send-email.
>=20
> Sorry about the weirdness. It does still let you apply the patch, I
> just now checked on that.
>=20

Hi Ira, could you please let me know if you'd like me to repost this patch,=
 or
the entire patchset, or if you're able to deal with it as-is? As it stands,=
 the
DKIM-Signature cruft above needs to be manually removed, either from the pa=
tch, or
from the commit log after applying the patch.

Also, as noted in the email thread involving Bharath and sgi-gru [1], I'm
currently planning on branching from your tree, and continuing the misc
call site conversions from there. And then just adapting to whatever API
changes are made to vaddr_*() functions. And the biovec call site conversio=
ns should
be based on that as well.

[1] https://lore.kernel.org/r/0c2ad29b-934c-ec30-66c3-b153baf1fba5@nvidia.c=
om

thanks,
--=20
John Hubbard
NVIDIA

