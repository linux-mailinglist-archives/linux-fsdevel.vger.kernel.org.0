Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331386E943A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjDTM2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDTM2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:28:42 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACAE59F9
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 05:28:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230420122838euoutp02d7dad0267e47261e1186454915b2fa56~XpGAnYIp22501125011euoutp02G
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 12:28:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230420122838euoutp02d7dad0267e47261e1186454915b2fa56~XpGAnYIp22501125011euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681993718;
        bh=fWdLK1+pfwYP5I6D3pnWgyqrztBApQHaQBRzHhUipRQ=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=WmMY5j0tfhZghQrIJE5Yxq+XRoy02Uuc9HJ9Dog+YE3pJnAVUQajGHo1YHOMfVmu+
         tTf/2jYu3mgQ4cuYE8LXGdpu5OyYqLllca7/NH6QIVeSfgbRMejfYdQaayuVbY6WUM
         wHTTmP3W6WucAvx2F5M2dcNT1WwsuolO7RI8trbk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230420122838eucas1p2ed0bf58d169ddf6d3d0c55710266dd8d~XpGARjHOy0901509015eucas1p2_;
        Thu, 20 Apr 2023 12:28:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.56.10014.6FF21446; Thu, 20
        Apr 2023 13:28:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230420122838eucas1p136006a7a08dd5a46ce85922642f9f87d~XpF-_svuh1029210292eucas1p1X;
        Thu, 20 Apr 2023 12:28:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230420122838eusmtrp12f60cdf136dc7228e9d4aeb5bd62426c~XpF-_J7v13204632046eusmtrp1B;
        Thu, 20 Apr 2023 12:28:38 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-8e-64412ff6136b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.35.34412.5FF21446; Thu, 20
        Apr 2023 13:28:37 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230420122837eusmtip12e3a472e54303ebd13cb10b3242d8902~XpF-0eh1Y0953109531eusmtip1k;
        Thu, 20 Apr 2023 12:28:37 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 20 Apr 2023 13:28:37 +0100
Message-ID: <1c76a3fe-5b7a-6f22-78e1-da4a54497ecd@samsung.com>
Date:   Thu, 20 Apr 2023 14:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mcgrof@kernel.org>, SSDR Gost Dev <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <a826abe1-332f-22db-982c-ecec67a40585@suse.de>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd1v+o4pBg+vClrsWTSJyWLP3pMs
        Fpd3zWGzuDHhKaPF7x9z2BxYPTav0PLYtKqTzWPz6WqPz5vkAliiuGxSUnMyy1KL9O0SuDJ+
        TfzPWnCYveLUtG3sDYwdbF2MnBwSAiYSD1fPB7K5OIQEVjBK7F05lRnC+cIocefYXyYI5zOj
        xK3OSUwwLesf3oVKLGeUWLT9Cwtc1cPXJ5hBqoQEdjJKvDyUAmLzCthJzLoynx3EZhFQlWj+
        8YAJIi4ocXLmExYQW1QgWmLxvilgtrCAt8Sh/b2MIDazgLjErSfzwepFBJQkPrYfYgdZxgxy
        7NOOfUAOBwebgJZEYyfYfE4Ba4mOSx/YIXrlJba/ncMMcbWixKSb71kh7FqJU1tugX0gIfCC
        Q+Lp0W9QRS4Sd5+1QENGWOLV8S3sELaMxOnJPSwQdrXE0xu/mSGaWxgl+neuZwM5QgJoc9+Z
        HBCTWUBTYv0ufYioo8SRH0oQJp/EjbeCEJfxSUzaNp15AqPqLKSAmIXk4VlIHpiFMHMBI8sq
        RvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwARz+t/xrzsYV7z6qHeIkYmD8RCjBAezkgjv
        GVerFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MEz0b
        FRYGGpux29wNTQ65KtUYOvFyjPCmWyGVnQG2mrdPBOp99+UV7P70lKfs3dTElLeXFLSb794t
        ituSdPHys7LXD/neJvpvLJhS9rJqmmmn4NmaanM2/9KqjSuvrK5n83ddnsY/03n7XKl7NQYv
        Zn15+OKJ09vZWSsY3h8/3T2XI/b688M5/wJN4ian/Vvxr/ycjZYq2weG93N3qv5hu6Xq/laH
        M6eCOaY7O+TJuwUSXmJ9TnUS/swL408wLJ94/Ili+RUm1cmlFoZezpwpq5x3FIgYt65Mfp2j
        ILHEPWm9lvHkT9M/nf2kImq/bYvQ3XsrX83lSZ3xaPOrEz96ZKvYj1+x6sni+1Ow5YW+Ektx
        RqKhFnNRcSIAOxWC1J8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7pf9R1TDGbctLbYs2gSk8WevSdZ
        LC7vmsNmcWPCU0aL3z/msDmwemxeoeWxaVUnm8fm09UenzfJBbBE6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8mvifteAwe8WpadvYGxg72LoY
        OTkkBEwk1j+8y9TFyMUhJLCUUWLtvJlQCRmJjV+uskLYwhJ/rnWxQRR9ZJTYff4wlLOTUaJ1
        D0g7JwevgJ3ErCvz2UFsFgFVieYfD6DighInZz5hAbFFBaIlbiz/BhYXFvCWOLS/lxHEZhYQ
        l7j1ZD5YXERASeJj+yF2kAXMAisYJZ527AMbKiTwhlHi0PTqLkYODjYBLYnGTrAwp4C1RMel
        D+wQczQlWrf/hrLlJba/ncMM8YGixKSb76G+qZX4/PcZ4wRG0VlIzpuF5IxZSEbNQjJqASPL
        KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDo3Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmE94yr
        VYoQb0piZVVqUX58UWlOavEhRlNgGE1klhJNzgemh7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5E
        IYH0xJLU7NTUgtQimD4mDk6pBiY9hw3v84Ucl0+9bHRrzZYlTpz3/eYIiBQ3dc91OrJ7yZK0
        P1aadX+WSKpZ2RYs/Lai77cbT65epMrtzU+LX7ZeqyrrydVzkvtztDn/Q9s2hXcndRVFmtXv
        OERs3+N/eVNgQUr+Yw2LGwd+ij+env5k5ukJzOn26bt57v5/6m0T5hE0XzTXbUnDWe/0TZfE
        mIx4874b5DF/vPMt54yar7imrHrl3aAbur3KM9NNV9aLfz6fwvdn/skZ685b6jyZ83xlOUPq
        ioDG38caIoqu614oX+jloZOV2bs0VOD2+Y5mB0/b1vIV62qnTNzoxvtRtY596THNbzeMtf72
        H//wOu9YUsmuBS/r3v7+laJetlCJpTgj0VCLuag4EQCHO1YIVwMAAA==
X-CMS-MailID: 20230420122838eucas1p136006a7a08dd5a46ce85922642f9f87d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601
References: <CGME20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601@eucas1p1.samsung.com>
        <20230414134908.103932-1-hare@suse.de>
        <2466fa23-a817-1dee-b89f-fcbeaca94a9e@samsung.com>
        <a826abe1-332f-22db-982c-ecec67a40585@suse.de>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-04-20 14:19, Hannes Reinecke wrote:
>>
>> **Questions on the future work**:
>>
>> As willy pointed out, we have to do this `order = mapping->host->i_blkbits - PAGE_SHIFT` in
>> many places. Should we pursue something that willy suggested: encapsulating order in the
>> mapping->flags as a next step?[1]
>>
>>
>> [1] https://lore.kernel.org/lkml/ZDty+PQfHkrGBojn@casper.infradead.org/
> 
> Well ... really, not sure.
> Yes, continue updating buffer_heads would be a logical thing as it could be done incrementally.
>
> But really, the end-goal should be to move away from buffer_heads for fs and mm usage. So I wonder
> if we shouldn't rather look in that direction..
>
Yeah, I understand that part. Hopefully, this will be discussed as a part of LSFMM.

But the changes that are done in filemap and readahead needs to be done anyway irrespective of the
underlying aops right? Or Am I missing something.

> Cheers,
> 
> Hannes
> 
