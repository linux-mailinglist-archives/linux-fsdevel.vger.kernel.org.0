Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90547A9F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjIUUQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjIUUPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:15:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FDC311FE
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:26:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230921090646euoutp0280937a59d8e306158af1a1c26b69a7b5~G3rtphHVI2626426264euoutp02s
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 09:06:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230921090646euoutp0280937a59d8e306158af1a1c26b69a7b5~G3rtphHVI2626426264euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695287206;
        bh=VJyK93S9BajgIit7kJZov0GU3bP0adUs2nvx8LTOB+U=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=HppaSRVbMp/7Hdw60Z41M7J6x2BqM5oDnSJi1hjcJqm+8cTq4IeawsyKZsnSXwMVQ
         SHxisxZsS6AeIFx+3wte1FEILTPQeElwczCUJxfsnGWQH5/vDEi53Dls3vLQ+BM/+p
         ADvNbfAtFyT1ysIE0NP/MYFiWZjdDIpLqBJnmY24=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230921090645eucas1p2c20c7ee8d6daff36e6546114fa251eb7~G3rtR6CCg1463314633eucas1p2I;
        Thu, 21 Sep 2023 09:06:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.95.42423.5A70C056; Thu, 21
        Sep 2023 10:06:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230921090645eucas1p1e41c50ab38a5bce603007ad8368db9c8~G3rs1q-Vy0227002270eucas1p1L;
        Thu, 21 Sep 2023 09:06:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230921090645eusmtrp27533f3139fb68e37db277c846ef4c99c~G3rs0YK-O3103331033eusmtrp2Z;
        Thu, 21 Sep 2023 09:06:45 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-34-650c07a5324e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.B9.10549.5A70C056; Thu, 21
        Sep 2023 10:06:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921090645eusmtip27ec0508925f070f921bde80479651e37~G3rsky4303010830108eusmtip2L;
        Thu, 21 Sep 2023 09:06:45 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 21 Sep 2023 10:06:44 +0100
Message-ID: <83500780-f7e6-9b9b-c4ae-a5daae442289@samsung.com>
Date:   Thu, 21 Sep 2023 11:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [PATCH 01/18] mm/readahead: rework loop in
 page_cache_ra_unbounded()
To:     Hannes Reinecke <hare@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ed7fd7b8-3271-4dee-b5bb-84bdd4c3db49@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87pL2XlSDe4d1bdYfbefzWLPoklM
        FitXH2Wy2HtL22LP3pMsFjcmPGW0+P1jDpsDu8fmFVoel8+Wemxa1cnmsftmA5vH5tPVHp83
        yQWwRXHZpKTmZJalFunbJXBl7Lr7kbngO3/FlkfdzA2MLbxdjJwcEgImEn971zGB2EICKxgl
        Lt4p72LkArK/MEp8WnyHGSLxmVFixU1xmIa1fXfYIYqWM0qs3vacBcIBKrr46jMrhLOTUeJq
        bx8LSAuvgJ3E5wenGUFsFgFViQNrlzBDxAUlTs58AlYjKhAtMXPaQqAaDg5hgWCJDatsQMIi
        AkoSH9sPsYPYzAKXGCX2P1KCsMUlbj2ZzwRSziagJdHYCVbCKWAt8fHID1aIEk2J1u2/oVrl
        JZq3zmaGeEBRYtLN96wQdq3EqS23mEBOlhBo5pS4+/QeI0TCRWLvk8tsELawxKvjW9ghbBmJ
        /zvnM0HY1RJPb/xmhmhuYZTo37meDeQgCaAr+s7kQJiOEg/2x0KYfBI33gpCnMMnMWnbdOYJ
        jKqzkMJhFpLHZiH5YBaSDxYwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITEGn/x3/
        tINx7quPeocYmTgYDzFKcDArifAmf+JKFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rbXsyWUgg
        PbEkNTs1tSC1CCbLxMEp1cC0IHHSsfNaLRnPv5V+is+IeF8pYHwzRuzQoagFm766ud2dN8Wx
        VanZ0X/Zc/Gw5D3ZW+yvu2sfYN125eDWZTJ5526f+uqg1jN3nq/t/9U7/S1PmPku+3bXcUZJ
        HHupgX56gcfrr4X8+T3hOWl8NjkMLy0O/bi1ym77hGurj5QY/FCZXbV59rp78svzxaa+fcL9
        dV//tfsxK3fNMbx3WKePNffPogIXLttLf5kl4ycu4g+KZRZ7rGggE7ftZfTsPhs9ZbnpzgIL
        QnNLIm9FidZ1WQoocJxx+aT/auJD/pSnceIM69hOLvocYio6naWwt/rg7Q0lk33eZ3bYRcmk
        V4id3CjXPbfyQ9fhwybVy/yVWIozEg21mIuKEwFZLLDHsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7pL2XlSDR5v5LNYfbefzWLPoklM
        FitXH2Wy2HtL22LP3pMsFjcmPGW0+P1jDpsDu8fmFVoel8+Wemxa1cnmsftmA5vH5tPVHp83
        yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        7Lr7kbngO3/FlkfdzA2MLbxdjJwcEgImEmv77rB3MXJxCAksZZTY/vUKO0RCRmLjl6usELaw
        xJ9rXWwgtpDAR0aJE191IeydjBLTOsEG8QrYSXx+cJoRxGYRUJU4sHYJM0RcUOLkzCcsXYwc
        HKIC0RJdL41BTGGBYIkNq2xAKkQElCQ+th8C28oscIlRYv8jJYhzepgk1l55AJUQl7j1ZD4T
        SC+bgJZEYydYmFPAWuLjkR+sECWaEq3bf0OVy0s0b53NDHG9osSkm++hPqmV+Pz3GeMERtFZ
        SI6bhWTDLCSjZiEZtYCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg5G479nPzDsZ5rz7q
        HWJk4mA8xCjBwawkwpv8iStViDclsbIqtSg/vqg0J7X4EKMpMIQmMkuJJucDU0deSbyhmYGp
        oYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPT9g1N00/N5xCwCd/59ajApx9+
        AutSzYpP3Jewsz6c17eCm1O8svLbgoeWaxUEFwludXp2aLWx5oX4mbZKnpGd4V3zz6Y1HTwe
        e2nP5eTDIXYTv23O8sie1bdD9vDnicIP1C4qG+xcu1MrUDR9eoOl/Kvt7jZzHsa0fli184eu
        Tsm/84v377n9OpI1Jn719/vX7qw/e2P3w/WCSZ/ubdvsy7lT9n7FO/5iNe7vB5zW3Hl44gTz
        nkUzdpv6FJpNW1CsxCWqc/W6y4kFjLKzfj7Q235qxc7H+UYdQRfman1p++a7faf6i4VneG0y
        FvDySC+O5q3YdP9MU63G8vkf/2jOC725707isy3pOoqm0jNuBfIrsRRnJBpqMRcVJwIAtoeB
        B2UDAAA=
X-CMS-MailID: 20230921090645eucas1p1e41c50ab38a5bce603007ad8368db9c8
X-Msg-Generator: CA
X-RootMTR: 20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b
References: <20230918110510.66470-1-hare@suse.de>
        <20230918110510.66470-2-hare@suse.de>
        <CGME20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b@eucas1p1.samsung.com>
        <20230920115643.ohzza3x3cpgbo54s@localhost>
        <ed7fd7b8-3271-4dee-b5bb-84bdd4c3db49@suse.de>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-20 16:13, Hannes Reinecke wrote:
> On 9/20/23 13:56, Pankaj Raghav wrote:
>> On Mon, Sep 18, 2023 at 01:04:53PM +0200, Hannes Reinecke wrote:
>>>           if (folio && !xa_is_value(folio)) {
>>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>                * not worth getting one just for that.
>>>                */
>>>               read_pages(ractl);
>>> -            ractl->_index++;
>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>> +            ractl->_index += folio_nr_pages(folio);
>>> +            i = ractl->_index + ractl->_nr_pages - index;
>> I am not entirely sure if this is correct.
>>
>> The above if condition only verifies if a folio is in the page cache but
>> doesn't tell if it is uptodate. But we are advancing the ractl->index
>> past this folio irrespective of that.
>>
>> Am I missing something?
> 
> Confused. Which condition?
> I'm not changing the condition at all, just changing the way how the 'i' index is calculated during
> the loop (ie getting rid of the weird decrement and increment on 'i' during the loop).
> Please clarify.
> 

I made a mistake of pointing out the wrong line in my reply. I was concerned about the increment to
the ractl->_index:

if (folio && !xa_is_value(folio)) {
....
  read_pages(ractl);
  ractl->_index += folio_nr_pages(folio); // This increment to the ractl->_index
...
}

But I think I was missing this point, as willy explained in his reply:

If there's a !uptodate folio in the page cache, <snip>. If that happened, we
should not try reading it **again in readahead**; we should let the thread
retry the read when it actually tries to access the folio.

Plus your changes optimizes the code path for a large folio where we increment the index by 1 each
time instead of moving the index directly to the next folio in the page cache.

Please ignore the noise!
