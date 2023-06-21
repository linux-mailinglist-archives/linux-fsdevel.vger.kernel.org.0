Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A77381FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjFUK0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjFUKZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:25:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A01730
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 03:25:48 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621102547euoutp029bb87f652ef39553528c797d2c65cea0~qpacQWfZ32690026900euoutp02A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 10:25:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621102547euoutp029bb87f652ef39553528c797d2c65cea0~qpacQWfZ32690026900euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687343147;
        bh=fQhn+XbU5SeW4XS5TuU4PPvuoJyk0edn3EZ7CeTiW7g=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=UhPuaYaIHduGVDgJVVizkGJO+Vm6iu/GKM+R9xECNbN6TA7tJz5zekdganiLXrfaq
         hdPPFVMtCNjSri6v1GidKNj7g+t1Xg/HFFMLRnEKAW0aO5bxOLX8xvMwZgqmbnie0e
         z2iv8BJjtkFoSqr3ss9N6kvP7mkbvqrE2nB5ceUI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621102547eucas1p18afdd0fd548b43d5e25e335173f2dc94~qpab-lu2s2249422494eucas1p1c;
        Wed, 21 Jun 2023 10:25:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BF.1F.11320.A20D2946; Wed, 21
        Jun 2023 11:25:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621102546eucas1p14a476fd2f61d7d780d04b9ff213e23c3~qpabsBb9g1594915949eucas1p10;
        Wed, 21 Jun 2023 10:25:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621102546eusmtrp207bac3e5fc06829b09a00543f59ece79~qpabrcEXq0135001350eusmtrp2J;
        Wed, 21 Jun 2023 10:25:46 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-a1-6492d02a74be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AF.0F.14344.A20D2946; Wed, 21
        Jun 2023 11:25:46 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621102546eusmtip16ab9315cd56c971c18ab31f7519fc378~qpabf6i-O0499904999eusmtip1W;
        Wed, 21 Jun 2023 10:25:46 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 11:25:45 +0100
Message-ID: <b57c76b8-aaf5-d245-6c0e-a3afdfd96643@samsung.com>
Date:   Wed, 21 Jun 2023 12:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [RFC 2/4] filemap: use minimum order while allocating folios
To:     Hannes Reinecke <hare@suse.de>, <willy@infradead.org>,
        <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <d0b77326-e93f-c1dc-c46c-1213bfafd7ee@suse.de>
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7paFyalGDTdsLDYcuweo8WeRZOY
        LFauPspkce1MD5PFnr0nWSwu75rDZnFjwlNGi98/5rA5cHicWiThsXmFlsemVZ1sHrtvNrB5
        bD5d7fF5k1wAWxSXTUpqTmZZapG+XQJXxuUX+gVr+Cp61qc1MLbydDFycEgImEjc/ZTbxcjF
        ISSwglFi0cl5zBDOF0aJqwcWskM4nxklpr9YAuRwgnUsaT0ElVjOKNE4dzETXFXv7UtQzk5G
        ic1/DjCDtPAK2Ek8/P2TFcRmEVCVOD7tDRNEXFDi5MwnLCC2qEC0ROuy+2wgtrCAp8SKr+1g
        vSICQRJHO0+BrWMWmMYosfziFUaQBLOAuMStJ/OZQL5gE9CSaOwEO49TwFpid+8EVogSeYnm
        rbOZIc5WlJh08z0rhF0rcWrLLSYIu5tTYsf3DAjbRaKt4xcLhC0s8er4FqiXZST+75wPVV8t
        8fTGb3AgSQi0MEr071zPBglJa4m+MzkgJrOApsT6XfoQUUeJp1eiIEw+iRtvBSEO45OYtG06
        8wRG1VlI4TALyVuzkNw/C2HmAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGp6PS/
        4192MC5/9VHvECMTB+MhRgkOZiURXtlNk1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwW
        EkhPLEnNTk0tSC2CyTJxcEo1MM2aktaUxPP105K+ieKrvFQ/Lf6nJj31xaYZJ5WmKblWyPj8
        XmCYOUn36+zHId+/JafN5Ti42+1M71yThVE1ffbXF/If9z5lsTh00zWGu2GWyziXfm2/Iu8g
        o3s6tv38GpfPm39v7cp+xaDu9OCcu9PshyKvpfVl78hdvJdpJHbgdaFRRYLCWdeI2wvDTUpr
        GupmZSe0fBB+21wuwzjN7g1Loq6qxfLET2aLT+5jj3ed9mWdyTauq+sTRBoSHv0Us485xPPZ
        2eP++dLemm8/toTMmRWacXxhen3844IkqY3H7+Qx2Ydecsj9GqvA1nKUTfGRgqlN0Mxw5zbe
        vz+PF5QwS37xfl3770FW2B+9D0osxRmJhlrMRcWJAOvnQYW0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7paFyalGMw/rW6x5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jMsv9AvW8FX0rE9rYGzl6WLk5JAQMJFY0nqIvYuRi0NIYCmjxL/NL1khEjISG79c
        hbKFJf5c62KDKPrIKNE77TFYQkhgJ6PEt6nmIDavgJ3Ew98/weIsAqoSx6e9YYKIC0qcnPmE
        BcQWFYiWWP35AliNsICnxIqv7cwgtohAkMTRzlNgVzALTGOUWH7xCiPEtk+MEjMbdoBVMQuI
        S9x6Mh9oKgcHm4CWRGMnO0iYU8BaYnfvBFaIEk2J1u2/2SFseYnmrbOZIT5QlJh08z3UN7US
        n/8+Y5zAKDoLyX2zkGyYhWTULCSjFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM5G3H
        fm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeGU3TUoR4k1JrKxKLcqPLyrNSS0+xGgKDKSJzFKiyfnA
        VJJXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cAkFpoQcz7aJ2tb
        3i0Bg9MGzcHB19eufSjS2CfAJBb+vsyj64lDYVgW4yVnyTfXyifd3SWjyXDy8IHyf7XTH1ln
        lD/euJE7y8TV59mXBXx1537IJGjViBvuOPqJ1Txw5a5rKf1X+qKXmFeWh75YtmZjQ6Hw7O2r
        V8kdCV71j09uwdQTa5zebHFUWr9AxvaG3YarvS9jrdJPd8yO2yYTULDsuvyJ5BLjRl62L085
        noq032pQELLZduH7TJv2bUeCP6dVf9y6J2/TS48I+7k98UGCP160VC9IO7zjJ2/gyo7rPkKB
        /p/O/l3nvqVrg4Xcy669Z3/3lxxm+xuzXMpCVGKmqzdTrqvqyc/X3bJE5ispsRRnJBpqMRcV
        JwIAbtfl0G0DAAA=
X-CMS-MailID: 20230621102546eucas1p14a476fd2f61d7d780d04b9ff213e23c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230621083827eucas1p2948b4efaf55064c3761c924b5b049219
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083827eucas1p2948b4efaf55064c3761c924b5b049219
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083827eucas1p2948b4efaf55064c3761c924b5b049219@eucas1p2.samsung.com>
        <20230621083823.1724337-3-p.raghav@samsung.com>
        <d0b77326-e93f-c1dc-c46c-1213bfafd7ee@suse.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> index 47afbca1d122..090b810ddeed 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -245,7 +245,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>               continue;
>>           }
>>   -        folio = filemap_alloc_folio(gfp_mask, 0);
>> +        folio = filemap_alloc_folio(gfp_mask,
>> +                        mapping_min_folio_order(mapping));
>>           if (!folio)
>>               break;
>>           if (filemap_add_folio(mapping, folio, index + i,
>> @@ -259,7 +260,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>           if (i == nr_to_read - lookahead_size)
>>               folio_set_readahead(folio);
>>           ractl->_workingset |= folio_test_workingset(folio);
>> -        ractl->_nr_pages++;
>> +        ractl->_nr_pages += folio_nr_pages(folio);
>> +        i += folio_nr_pages(folio) - 1;
>>       }
>>         /*
> This is incomplete, as the loop above has some exit statements which blindly step backwards by one
> page.
> 
> I found it better to rework the 'for' into a 'while' loop; please check the attached patch.
> 
Taken from your patch:

@@ -240,8 +240,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;

IIUC, we don't need to update the _index after read_pages() as it already modifies it. We just need
to move ractl->_index by 1 to move to the next index.


> Cheers,
> 
> Hannes
