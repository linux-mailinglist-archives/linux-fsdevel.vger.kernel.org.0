Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFB45B440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhKXGV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:21:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:43327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhKXGV2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637734686;
        bh=TUZFvBsMw1AsvORHoT7iSE7LY1SgcnSYgHu/zaSlMsw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AqAAuKWthH1u32A++CSLY6ojp8tMC3jMydfHxoJwFoYWD5isB+axsOx3YbqMIOSsN
         +9tzlVo0LH1swZWFDjb5vvhdNX41m1J4ADZ2aoUsW2U/h2fcWZqdi43vEVSis67uqR
         XwepjWjgSuYlkk79bvJCMkmK1EkEnaTfRSWH67ac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1n9mX02bb1-00XrAu; Wed, 24
 Nov 2021 07:18:06 +0100
Message-ID: <e3fce9af-429c-a1e3-3f0b-4d90fa061d94@gmx.com>
Date:   Wed, 24 Nov 2021 14:18:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Content-Language: en-US
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YZz6jAVXun8yC/6k@infradead.org>
 <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
 <YZ3XH2PWwrIl/XMy@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YZ3XH2PWwrIl/XMy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZxeW4fJ7S5g/EUK+d5QXEFC182bf1PlurcjtsWZRReag8gJgaTQ
 WTvu1uZm/uhZXTkXL/puyXAqIJpf2YyYP4o5qQrxRjeVeK8i6LT1VF449mq/tQBJ0ThUiKH
 fEtg2oRg51Tvg08PS6L4Gm9uRvu7K+Zt1DqmlnlcQia5Y+geaQSAMD/jvUsghoxaPmox1tF
 bzEg5YJtOhpbxWsPfcVlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAzBGslp/jM=:kkpMcgLlLndXSNdeIchiCx
 pIR6pFjsyX1M4YrTNq63w5Mgv1GOUf7bBllfDTYhM5jx8FIIVLoHJuPYsFSa6FAbKgTNN0EVt
 QMVpUH8ppvcGBtgcu+8pXfhz/n1XOCMJezr8M8ChRSTnA4O+QgL4YTnpevVeEWWeYt6NegRIV
 NrtfTg21n5m/NIj+SzRU/BfTWAJ839qVLzDfwxGPXM392U52+Y2G8OM4I0SUA2m+3NPQVpaUt
 UGpDL1edhXtaAYJLAKuuBQ9JfRyyJ0byR0Sy/eoxgcj38ZRuQjnnXOyBfAy5bhrzhAm6ok4Ul
 GAot0c3NLL7dWSYjeN6G6WhRFOXMVf4GPkkEiEdGl2kvk8MuWaA25TeFnEaK4qN5xYzuozCWo
 d3z7GNufCJKUSDUlzwFIQWjj3yv1ys6yC+bpOdR6E4KZg0QpEyjWYNecy1ufAT6Au4yOvkDdi
 oS125Wl2PwxnbTpFUm6MfeTxK2hatGZ0UCppAHKcT3BTVldfanL2ubbX5CcNZ3pYNuI97t4Ke
 8h62Iix1Zs+9/qrDYW05O4PCDFecwiNgFRDRWT6N3PelYJLQER+iIc6WgwEfUbuuM3MN9lRSz
 k1BqejtqFDhQLlAUemXXkC8vPmNU8k951f5jH2CAxz1YUfTY7W+nFGZEojyrb/wg+mKNNG2hC
 dZULNm5MjwW+bCscpAbAmHJUzAP3I/XZ0EVxgAWmP4oWa71ikH28sxbOInQzuQdDGDzu69csc
 YqYKtO5T5y7RqVb1++uJZEU3tcGKy9/UnzrMyqYM8G0I+NLkEi+Sy0WwoGg7jE3525nhVNV+F
 OA06h5mYi9b4bWn/RgBmli65bu9PpsZrYgG+kbVB+sOzitqiOErZkCjnEJ5SKXI+HIqcE9a7R
 c7W9fvxSPbluB05bJSww+ZGwhccrB46V0cI1Xi1VFkzYK6bebX2G0rCotMyW73TNZ6TrvNCDC
 bOYldivwFoAtwutXQl1bDdnUtbkiZgi42DeeraTGxlJ3cBs2LowrY06UK/b5IKD2jyc4S8WW6
 3LuJyN6y0abbH/o7YdqclJE3gA/o39lKL5ywLpABTITwzXYPXns7Z0lkG2o8a/kn0lNuxdj7s
 oHOM4f1JMXULaU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/24 14:09, hch@infradead.org wrote:
> On Wed, Nov 24, 2021 at 07:07:18AM +0800, Qu Wenruo wrote:
>> In that case, the missing piece seems to be a way to convert a splitted
>> plain bio into a REQ_OP_ZONE_APPEND bio.
>>
>> Can this be done without slow bvec copying?
>
> Yes.  I have a WIP stacking driver that converts writes to zone appends
> and it does just that:
>
> 	sector_t orig_sector =3D bio->bi_iter.bi_sector;
> 	unsigned int bio_flags =3D bio->bi_opf & ~REQ_OP_MASK;
>
> 	...
>
> 	clone =3D bio_clone_fast(bio, GFP_NOIO, &bdev->write_bio_set);
>
> 	...
>
> 	clone->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_NOMERGE | bio_flags;

Just so simple? Then that's super awesome.

But I'm a little concerned about the bio_add_hw_page() call in
bio_add_zoned_append().

It's not exactly the same as bio_add_page().

Does it mean as long as our splitted bio doesn't exceed zone limit, we
can do the convert without any further problem?

Thanks,
Qu
> 	bio_set_dev(clone, dev->lower_bdev);
> 	clone->bi_iter.bi_sector =3D zone_sector;
> 	trace_block_bio_remap(clone, disk_devt(disk), orig_sector);
>
>>
>> Thanks,
>> Qu
> ---end quoted text---
>
