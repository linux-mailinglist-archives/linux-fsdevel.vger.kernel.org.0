Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1006C334E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCUNvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCUNvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:51:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3D497E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 06:51:18 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230321135115euoutp015ac4fec3b28b0a7e3d191ce37be57f2a~Oc3koRk1S2814128141euoutp01T
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 13:51:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230321135115euoutp015ac4fec3b28b0a7e3d191ce37be57f2a~Oc3koRk1S2814128141euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679406675;
        bh=GXvO1SsecXjjDHDwdPtRSbMeXGhDy7A8WdxlRFo4Nr0=;
        h=Date:Subject:From:To:CC:In-Reply-To:References:From;
        b=btqueFTYct3WTvXqNvUnZ5kK9w6L19fRvsRD+1MwxQ2sO35BIZHefZxtkAKKjy1LJ
         ebT4EI8ZQ3Vq/XQMNfQOyqPmCrJLLbgFRh1StSkLTCluvQDYXvMzDyoB8ncQ8NjbO2
         1DmH8XLKirWW0Wq55p1LYBVH/bCDnbeyi1PxsupA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230321135114eucas1p1421153d2c93b7964acf9dead67635270~Oc3kSR3x01567415674eucas1p1O;
        Tue, 21 Mar 2023 13:51:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.C1.09503.256B9146; Tue, 21
        Mar 2023 13:51:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230321135114eucas1p1a65af09247f837ebabfac32fb91d2d72~Oc3j0Ycp81905019050eucas1p16;
        Tue, 21 Mar 2023 13:51:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230321135114eusmtrp2f41f7a9a9136fc979dea94b9d55170dc~Oc3jzsLWj0369203692eusmtrp2r;
        Tue, 21 Mar 2023 13:51:14 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-0b-6419b6522e66
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.E1.08862.256B9146; Tue, 21
        Mar 2023 13:51:14 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230321135114eusmtip192c5cd30d3eac61e329f07f2ea2a3a25~Oc3jp4s5m0964409644eusmtip1G;
        Tue, 21 Mar 2023 13:51:14 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.172) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 21 Mar 2023 13:51:12 +0000
Message-ID: <ea4a45b8-837d-ec60-8320-126346e49a42@samsung.com>
Date:   Tue, 21 Mar 2023 14:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>, <hubcap@omnibond.com>,
        <senozhatsky@chromium.org>, <martin@omnibond.com>,
        <minchan@kernel.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <axboe@kernel.dk>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <gost.dev@samsung.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>
In-Reply-To: <04047489-e528-4451-4af2-c19bd3635e7e@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7pB2yRTDPZNMrKYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPF6QmLmCza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XujYvYLM7/Pc5q8fvHHDYHAY/ZDRdZPDav0PK4fLbUY9OqTjaPTZ8msXucmPGbxaNh
        6i02j1+377B6fN4k57HpyVumAK4oLpuU1JzMstQifbsErox5P7tYCrr4K/rmP2JpYLzL1cXI
        ySEhYCLReqCNqYuRi0NIYAWjxI19a6GcL4wSb++9Y4NwPjNKzLi2jAWm5cuq6awQieWMEvPm
        /2aCq/p/ZDY7hLObUWL7g92sIC28AnYSTxd/YgSxWQRUJToubIKKC0qcnPkEaCwHh6hAlMSL
        12UgprCAu8THXXkgFcwC4hK3nsxnAgmzCWhJNHayg5giAhoSb7YYgSxiFtjKLHGk4xXYcE4B
        e4kPq9pZIFo1JVq3/2aHsOUltr+dwwxxv7LEnNc7oOxaibXHzoBdLCHwilNiyYIvbBAJF4lz
        p+5BPSws8er4FnYIW0bi/06Qe0DsaomnN34zQzS3MEr071zPBnKdhIC1RN+ZHAjTUeLobA0I
        k0/ixltBiHP4JCZtm848gVF1FlIwzELy8CwkH8xC8sECRpZVjOKppcW56anFhnmp5XrFibnF
        pXnpesn5uZsYgYnw9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRFeN2aJFCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MLSrRXpEG/90Pbr7QHOrJnbDx88VW
        DtkX9vvkT72PXyD2IkDcc57rp1JWVW+3Wtk9n5SfvuYWCrN6mai5p2fO1KUqYe6nr990zhBo
        8D5y/Y6I7fcHpda+OT/OPb3vrMJ2JbD3vaDwVKY1UTsVkr+E7pFoe5e2XbwmbO/XOV3Onw1/
        rVo3TWhqqMqBk/O5vk14ONfJSi46Y3/wnsQVCslStV63GTdFH9BlWr+pUvBr8K2Q/RrXr5TN
        kpY6MjOkYeZxs+Yby7c9cRf8uDZl/yoGRqVD6Y6fOu5khgVrd9RsK+hNSUwv8lJWcXnR+0VG
        MFTjZs1WqwrJBg/u9TWfek7m5tfW3DbqVV0UGbpgg5USS3FGoqEWc1FxIgBwnAg38wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xu7pB2yRTDD7dE7aYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPF6QmLmCza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XujYvYLM7/Pc5q8fvHHDYHAY/ZDRdZPDav0PK4fLbUY9OqTjaPTZ8msXucmPGbxaNh
        6i02j1+377B6fN4k57HpyVumAK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsj
        UyV9O5uU1JzMstQifbsEvYx5P7tYCrr4K/rmP2JpYLzL1cXIySEhYCLxZdV01i5GLg4hgaWM
        EvuWXGaCSMhIfLrykR3CFpb4c62LDaLoI6PE9T2bWSCc3YwSR39/ZAWp4hWwk3i6+BMjiM0i
        oCrRcWETVFxQ4uTMJywgtqhAlMTTO4eYuxg5OIQF3CU+7soDCTMLiEvcejKfCSTMJqAl0djJ
        DmKKCGhIvNliBLKJWWArs8SRjleMEGu/MUlcer8RbDyngL3Eh1XtLBBzNCVat/9mh7DlJba/
        ncMM8YCyxJzXO6DsWolX93czTmAUnYXkullIzpiFZNQsJKMWMLKsYhRJLS3OTc8tNtQrTswt
        Ls1L10vOz93ECEwh24793LyDcd6rj3qHGJk4GA8xSnAwK4nwujFLpAjxpiRWVqUW5ccXleak
        Fh9iNAUG0URmKdHkfGASyyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi
        4JRqYGKc8Xp6w52UCRuXfM4wClmRvG7PJNlX51/r/dyU99vpx+t/kYskEr9Znk96PWHeXeNr
        Du/szmpm/HMIDdnhkfOCcfG8l5xdaqtLdgVe/hg/qfOlP5PzzTdla/euVN9uIHXC+4DWrg+u
        VYpN/qqlCRaRS4yuzFwcEVba9sFiHlfacaa+7dYikgeOFRZy3V63YXVtU/63Ob4X1H7rcFjI
        X3PYvzGS3yjvw62Fb6U/sRcuFv6rp3t6gv8kjUqLpjXrm4J2JhpfPH1j57vdPw13yt674rVW
        JOJC1dnY6MUSdpt/5otl/9CPa+F6s+bw0/JPK3/t3dthJ6S2vNHws9B2ubSNzSfMQ9+Uvi2Z
        UPvyA8c6JZbijERDLeai4kQAcFQi6aoDAAA=
X-CMS-MailID: 20230321135114eucas1p1a65af09247f837ebabfac32fb91d2d72
X-Msg-Generator: CA
X-RootMTR: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
        <20230315123233.121593-2-p.raghav@samsung.com>
        <ZBHcl8Pz2ULb4RGD@infradead.org>
        <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
        <ZBSH6Uq6IIXON/rh@casper.infradead.org>
        <04047489-e528-4451-4af2-c19bd3635e7e@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

On 2023-03-17 17:14, Pankaj Raghav wrote:
> On 2023-03-17 16:31, Matthew Wilcox wrote:
>>> +
>>> +       while ((folio = readahead_folio(rac))) {
>>> +               folio_mark_uptodate(folio);
>>> +               folio_unlock(folio);
>>>         }
>>
>> readahead_folio() is a bit too heavy-weight for that, IMO.  I'd do this
>> as;
>>
>> 	while ((folio = readahead_folio(rac))) {
>> 		if (!ret)
>> 			folio_mark_uptodate(folio);
>> 		folio_unlock(folio);
>> 	}
>>
> 
> This looks good.
> 
>> (there's no need to call folio_set_error(), nor folio_clear_uptodate())
> 
> I am trying to understand why these calls are not needed for the error case.
> I see similar pattern, for e.g. in iomap_finish_folio_read() where we call these
> functions for the error case.
> 

I am planning to send the next version. It would be great if I can get a rationale for your
statement regarding not needing to call folio_set_error() or folio_clear_uptodate().

> If we don't need to call these anymore, can the mpage code also be shortened like this:
> 
> -static void mpage_end_io(struct bio *bio)
> +static void mpage_read_end_io(struct bio *bio)
>  {
> -       struct bio_vec *bv;
> -       struct bvec_iter_all iter_all;
> +       struct folio_iter fi;
> +       int err = blk_status_to_errno(bio->bi_status);
> 
> -       bio_for_each_segment_all(bv, bio, iter_all) {
> -               struct page *page = bv->bv_page;
> -               page_endio(page, bio_op(bio),
> -                          blk_status_to_errno(bio->bi_status));
> +       bio_for_each_folio_all(fi, bio) {
> +               struct folio *folio = fi.folio;
> +
> +               if (!err)
> +                       folio_mark_uptodate(folio);
> +               folio_unlock(folio);
> +       }
> +
> +       bio_put(bio);
> +}
> +
> +static void mpage_write_end_io(struct bio *bio)
> +{
> ....
> +
