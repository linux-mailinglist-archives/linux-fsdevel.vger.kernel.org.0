Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF91F1E45C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgE0OZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 10:25:35 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27140 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbgE0OZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 10:25:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200527142533epoutp01b6018ade8ef070148f952092fbd68823~S6MDIUY371833018330epoutp01t
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 14:25:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200527142533epoutp01b6018ade8ef070148f952092fbd68823~S6MDIUY371833018330epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590589533;
        bh=8AMzre57Rup3O+2yQwlsUsj50VyKkmZ2g+QwOJq+y7Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=W9kEaIQjNj5JhOT8uf0y1EDi7qscje+3NIJC9xkOY4DPrY9P/SMSS8n+GbP3vkuVi
         nnADxkuU+7XDAPxVlNF3DaGD22g7xCOLCePJB8LPRTAimk8j5013WEXsWoTq2ljqhK
         fGGMQsWn4sdCMBSeWaYxxtRHNrNxhhkVjRF5PQ/8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200527142532epcas1p259f002e2149e64a3fb8962df982d75eb~S6MCexqye2537825378epcas1p2F;
        Wed, 27 May 2020 14:25:32 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49XCmC3dgszMqYkY; Wed, 27 May
        2020 14:25:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.3B.04388.B587ECE5; Wed, 27 May 2020 23:25:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200527142531epcas1p152d74fcd78d072f6123ad550da7b6619~S6MBMPItD1754017540epcas1p1U;
        Wed, 27 May 2020 14:25:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200527142531epsmtrp23fc003863097bebb120da62b6ebb444f~S6MBLh8_B1203612036epsmtrp2b;
        Wed, 27 May 2020 14:25:31 +0000 (GMT)
X-AuditID: b6c32a35-793ff70000001124-13-5ece785b9420
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.91.08303.A587ECE5; Wed, 27 May 2020 23:25:30 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200527142530epsmtip11c0ad50e370ff13ed85241c5137d68bc~S6MA84F9u2634626346epsmtip1g;
        Wed, 27 May 2020 14:25:30 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp'" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     "'Mori.Takahiro@ab.MitsubishiElectric.co.jp'" 
        <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        "'Motai.Hirotaka@aj.MitsubishiElectric.co.jp'" 
        <Motai.Hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kohada.t2@gmail.com>
In-Reply-To: <CAKYAXd_oG6dc7CNiHszKmhabHd2zrN_VOaNYaWRPES=7hRu+pA@mail.gmail.com>
Subject: RE: [PATCH] exfat: optimize dir-cache
Date:   Wed, 27 May 2020 23:25:30 +0900
Message-ID: <000701d63432$ace24f10$06a6ed30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKbEd8GOCYeHYQBe/Vm0kX/gmqw5wMD/7F2AWi7CpYCLmCEuwJD5ds7putEalA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2znbzsrVaVq9rah1MkxjuuOaniSz0mKRqBV0MdIOenLW2YWd
        LSqIbrKadNOyaNmFIi1DC5PUmUV2MUulK5QhQUnQPbfKWVBtO0X+e97vfZ7veZ/vewlMdVmm
        JootDs5uYXlKNgy/cjNWp121sTtP5/GOZwLHX+DMh44KnCk7fBZjrrZ24Mxjb6WMefzbhzNV
        Xw/iTODI1jmE8Wtlu9zoOvhLbtx557zM2OzplRvra9wy476GGmT010/Mkefys0wcW8jZNZyl
        wFpYbClKpRYtzU/PNyTpaC09k0mmNBbWzKVSGZk52gXFfHAoSrOB5Z3BoxxWEKiE2bPsVqeD
        05isgiOV4myFvI3W2eIF1iw4LUXxBVZzCq3TJRqCzDW8aXfJU5mtOmLjo1sebBs6oyhFBAHk
        DLjVailFwwgV2YSg48hLiVj4ELjfD+Bi4UfwuXa7rBQpwor6jz/wEFaRXgQnXo0USW8RlH8v
        D5NkpBb6ng1ioUYUeQDBsR33wvdiZLsEnl+7IQ2ZK8jF0LhrekgQScZD//e3khDGyanwOtAZ
        xkpyJjReqMBFPAo6jvaFMUZOgsaPlZg4kQZafLelIRxFZkF/f5dU5ETBMbcrPASQDQT0eRsx
        MXQGdA6MELWR8K69QS5iNfg/tf5NuRPBvt6ForYEQU3Tjr8NPfj8fhS6ByNj4aI3QTyeDM0/
        jyPRdwR8+rZHKlopYbdLJVKiYeBLM/7P6kngqeQAojxDknmGJPMMSeD5b3YK4TVoDGcTzEWc
        QNvooZ9dj8ILG2doQoe6M9sQSSAqQqkzdueppOwGYZO5DQGBUVHKeV3381TKQnbTZs5uzbc7
        eU5oQ4bgw5dh6tEF1uD6Wxz5tCFRr9czM5KSkwx6aqzyZKAzT0UWsQ5uPcfZOPs/nYRQqLeh
        eaezswZ68GVb5uZejST264pTBhO1PvvNdDp6zJy9rTHzW9Kqf51Mzd414dLguVElzoq64asb
        0h6eWdBvfRZROr4ukCk4stJX9rjG3V0+Wl8W05eyzpXRQ40sn+A2+XM1BdJaX4Wh93p6chr/
        5K7iQQn9oWqt+o2UX+GessTlmGamcMHE0nGYXWD/AI7snwLGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnG5Uxbk4g/lNphY/5t5msXhzciqL
        xcRpS5kt9uw9yWJxedccNovL/z+xWCz7MpnF4sf0egcOjy9zjrN7tE3+x+7RfGwlm8fOWXfZ
        PTat6mTz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroyOlqtsBct5Ki4dmcXcwLiYs4uRk0NC
        wERi09tfLF2MXBxCAjsYJf682AbkcAAlpCQO7tOEMIUlDh8uhih5ziixb9ofZpBeNgFdiSc3
        fjKDJEQE+hgl7h1bzgjiMAscZ5JYsf4qI1QLk8TXGTsYQUZxCgRKbG/XBukWFtCT+PjtJROI
        zSKgKvH4xxkwm1fAUmL76qksELagxMmZT8BsZgFtid6HrYwQtrzE9rdzmCE+UJDY/ekoK4gt
        IuAn8fHjWVaIGhGJ2Z1tzBMYhWchGTULyahZSEbNQtKygJFlFaNkakFxbnpusWGBUV5quV5x
        Ym5xaV66XnJ+7iZGcKxpae1g3LPqg94hRiYOxkOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleak
        Fh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFMlomDU6qByYdj/rKnl4Q5FlyJ6Eic5xGyQTvb
        pUS20sF48h01rvMHPq8+eax7rlNqzvvOhjfLq9hPnoi7zs2fkXbqP/fNudqbt204tWL6VM+Q
        S3l/tui2XA8JVaz/MOHVjFNcs6pfBVoXzFur6z/p1bYPv1T3rlsiLSlzUVfx1KkgyZv7chf6
        X1VJW21ZPXVh9dtiofvML1+t7WYLe5YuP+N2cM7suy2zvdbabVdgzGS1XXv1vuuusolt+jI2
        sw/58cgKBcz2nvfk4c/sNw6mZ6TUnM82TpGfG/i0wOY869QED2/vErb4lfxHJU1EaoyUbpeu
        Ldr/u+H9Z8Xo2+w8Hybmnuk/Fd84ffK1/Uwf7RtsTnSveKzEUpyRaKjFXFScCAA+aJ8aJAMA
        AA==
X-CMS-MailID: 20200527142531epcas1p152d74fcd78d072f6123ad550da7b6619
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
        <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
        <055a01d63306$82b13440$88139cc0$@samsung.com>
        <TY1PR01MB15784E70CEACDA05F688AE6790B10@TY1PR01MB1578.jpnprd01.prod.outlook.com>
        <CAKYAXd_oG6dc7CNiHszKmhabHd2zrN_VOaNYaWRPES=7hRu+pA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 2020-05-27 17:00 GMT+09:00,
> Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
> <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>:
> > Thank you for your comment.
> >
> >  >> +    for (i = 0; i < es->num_bh; i++) {
> >  >> +            if (es->modified)
> >  >> +                    exfat_update_bh(es->sb, es->bh[i], sync);
> >  >
> >  > Overall, it looks good to me.
> >  > However, if "sync" is set, it looks better to return the result of
> > exfat_update_bh().
> >  > Of course, a tiny modification for exfat_update_bh() is also required.
> >
> >  I thought the same, while creating this patch.
> >  However this patch has changed a lot and I didn't add any new error
> > checking.
> >  (So, the same behavior will occur even if an error occurs)
> >
> >  >> +struct exfat_dentry *exfat_get_dentry_cached(
> >  >> +    struct exfat_entry_set_cache *es, int num) {
> >  >> +    int off = es->start_off + num * DENTRY_SIZE;
> >  >> +    struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> >  >> +    char *p = bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);
> >  >
> >  > In order to prevent illegal accesses to bh and dentries, it would
> > be better to check validation for num and bh.
> >
> >  There is no new error checking for same reason as above.
> >
> >  I'll try to add error checking to this v2 patch.
> >  Or is it better to add error checking in another patch?
> The latter:)
> Thanks!

Yes, the latter looks better.
Thanks!

> >
> > BR
> > ---
> > Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

