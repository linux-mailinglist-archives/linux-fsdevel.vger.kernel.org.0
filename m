Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3363A3438CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCVFwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:52:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13343 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVFwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:52:25 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210322055223epoutp02bee9088eeab8804866fe9eb1bc9c780d~ulEWpTFCR1431414314epoutp02K
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210322055223epoutp02bee9088eeab8804866fe9eb1bc9c780d~ulEWpTFCR1431414314epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616392343;
        bh=PP2w29LcRm+fOI2DXfVTDKBWo6lLBIXZp2IdlOCtQp8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=peaoZHKj3z56PrPNMXmkjsLT1aIvN1+JaYRSrzR/pT9NgnOxHSady7KxFf4h+W4cH
         E+Op5oIAABC511FCqW7Fk9epbLwZKUSE6t9MMVu5LhcX1nJlV3l62yGYv1MnM07bYq
         rkjE00av0//jn6j694hHGbgSa18zD4RJL1A+gwP0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210322055222epcas1p1fd0422930a691742d6e2ca8c93cdcd4e~ulEWADich2865328653epcas1p1K;
        Mon, 22 Mar 2021 05:52:22 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F3kD468T0z4x9Py; Mon, 22 Mar
        2021 05:52:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.EC.02418.49038506; Mon, 22 Mar 2021 14:52:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210322055219epcas1p109b6c93281293e885a234e65a6376603~ulETQq3Rs3022830228epcas1p1y;
        Mon, 22 Mar 2021 05:52:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322055219epsmtrp101eeb2b97cf7fb3a385289352f2aca4c~ulETP-P1s0364703647epsmtrp1h;
        Mon, 22 Mar 2021 05:52:19 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-48-605830949b10
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.2A.08745.39038506; Mon, 22 Mar 2021 14:52:19 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210322055219epsmtip1927872865c5975443ce0d2516d3c47d7~ulETAxc5J0058800588epsmtip1H;
        Mon, 22 Mar 2021 05:52:19 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     <sj1557.seo@samsung.com>
In-Reply-To: <20210322035336.81050-1-hyeongseok@gmail.com>
Subject: RE: [PATCH v3] exfat: speed up iterate/lookup by fixing start point
 of traversing cluster chain
Date:   Mon, 22 Mar 2021 14:52:19 +0900
Message-ID: <016101d71edf$8542b240$8fc816c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFCCaC8jPi/61EWNQoXs0UvpNzAUAIaXSUoq6jXuSA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTV3eKQUSCwcv5rBZ/J35istiz9ySL
        xeVdc9gsfkyvt9jy7wirA6vHzll32T36tqxi9Pi8SS6AOSrHJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQwMDIFKgyISejZ/cFtoLJHBUf9q5hb2DczNbF
        yMkhIWAisXDhG9YuRi4OIYEdjBK/Ni1mg3A+MUp0zl/FAuF8ZpS4u6ODFablYssPRhBbSGAX
        o8SF9ykQRS8ZJXZsmw02l01AV+LJjZ/MIAkRgW5GiRUvprKDJJgFZCQmtR8Bm8QpYCWxdNFc
        JhBbWCBLYv1OiA0sAqoStzp+gsV5BSwlJkx/yQxhC0qcnPmEBWKOvMT2t3OYIS5SkNj96ShY
        rwjQzMMP2qFqRCRmd7ZB1fxkl1gwTQ/CdpHY290GDQBhiVfHt7BD2FISL/vboOx6if/z17KD
        PCAh0MIo8fDTNqCDOIAce4n3lyxATGYBTYn1u/QhyhUldv6eywixlk/i3dceVohqXomONiGI
        EhWJ7x92ssBsuvLjKtMERqVZSB6bheSxWUgemIWwbAEjyypGsdSC4tz01GLDAkPkyN7ECE6N
        WqY7GCe+/aB3iJGJg/EQowQHs5II74nkkAQh3pTEyqrUovz4otKc1OJDjKbAoJ7ILCWanA9M
        znkl8YamRsbGxhYmZuZmpsZK4rxJBg/ihQTSE0tSs1NTC1KLYPqYODilGpik5fZf1Hsrppr+
        u+UtI4tb4nze7dbpxpke7mGSsx+tsKjylryd1FZ6/ZOUzZET2uesdFtFvab5Ht3968bOgnU9
        a2wCfh98LdfDqZn9MOzyUXuuOY8uaZsuaLNMa+Qv0P6wevPqhqIlL7laFt6coHv+j4yw5N2H
        bp7fdq3VOzztWdGX4rApbyK+BSyYxiS34++r7B/cVVt1pqh2mx1fNXfFiunc03f573in/ms+
        55N5iqZq/qHm8+WFd9R8YDKMaVV5E7bn2ZtqtXi7G63hb3Zry/5tP1lpcVskd+r1Z5o/t6Zs
        U9hwjPGmadrCWBnlYvcgveryD4sfvZ8oVqSzwneN6wV+e031lQYV2sslLl5SYinOSDTUYi4q
        TgQAHXde7BYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO5kg4gEg08zxC3+TvzEZLFn70kW
        i8u75rBZ/Jheb7Hl3xFWB1aPnbPusnv0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXRs/uC2wF
        kzkqPuxdw97AuJmti5GTQ0LAROJiyw/GLkYuDiGBHYwSvz/eA0pwACWkJA7u04QwhSUOHy6G
        KHnOKHHjXDtYL5uArsSTGz+ZQRIiAv2MErOmTWQCSTALyEhMaj/CCtHRzSixbvlFRpAEp4CV
        xNJFc8GKhAUyJO5sf8sKYrMIqErc6vgJFucVsJSYMP0lM4QtKHFy5hMWkCuYBfQk2jYyQsyX
        l9j+dg4zxAMKErs/HQUbIwI0/vCDdhaIGhGJ2Z1tzBMYhWchmTQLYdIsJJNmIelYwMiyilEy
        taA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOEK0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeE8kh
        CUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwpRRq2Ft5
        /Jn9YdLL3yJzfj+W3eDaZJrHsMTdpG1hcZifi+U6CdnVr+7+yt/XMmXDopsut55rnP1d6N8g
        f4Xn0T/tYp5o3i/iJ8yPrgraYuffmnvmEGf0qSv33/EeTDu7tb7sxOE3/9O0T7Vf+H/lb/SV
        dwd/dQoVtjZmM3pOmsh7q6yhPHhOyhydlMuf33tPvczb5mgnJz3zahQzy9W6uD2u3Ft3Cm3y
        OsaxbO2mq4/qFlp6Tf77pXzd1OW3LDOsoz9Nz9L+oCQR9XzXtf8beQo0Bf2S+3KPyKyYuyWL
        rdmdeYPUmgPxbzr62V0X5/xvWnGVydo793SzWU7qxQivPcoTvDNtmd/NWTfv9n/hcCWW4oxE
        Qy3mouJEAMzrx+H/AgAA
X-CMS-MailID: 20210322055219epcas1p109b6c93281293e885a234e65a6376603
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322035356epcas1p35cf4d476030f5ebaf6357c5761355605
References: <CGME20210322035356epcas1p35cf4d476030f5ebaf6357c5761355605@epcas1p3.samsung.com>
        <20210322035336.81050-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> When directory iterate and lookup is called, there's a buggy rewinding of
> start point for traversing cluster chain to the parent directory entry's
> first cluster. This caused repeated cluster chain traversing from the
> first entry of the parent directory that would show worse performance if
> huge amounts of files exist under the parent directory.
> Fix not to rewind, make continue from currently referenced cluster and dir
> entry.
> 
> Tested with 50,000 files under single directory / 256GB sdcard, with
> command "time ls -l > /dev/null",
> Before :     0m08.69s real     0m00.27s user     0m05.91s system
> After  :     0m07.01s real     0m00.25s user     0m04.34s system
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>

Looks good.
Thanks for your contribution.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c      | 19 +++++++++++++------
>  fs/exfat/exfat_fs.h |  2 +-
>  fs/exfat/namei.c    |  9 ++++++++-
>  3 files changed, 22 insertions(+), 8 deletions(-)

