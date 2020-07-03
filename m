Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21C213253
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 05:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGCDs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 23:48:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:15662 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCDs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:48:27 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200703034824epoutp040a67586895c4f66571382bf929bda0aa~eIXUAvI9J1053710537epoutp04U
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2020 03:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200703034824epoutp040a67586895c4f66571382bf929bda0aa~eIXUAvI9J1053710537epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593748104;
        bh=9M/jRjyxIXIkR1YB5wepBcKlizq7fz3fWUwETG8pLLQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LZOMf0rue4NRALRmaEvk18X4XT2z0GvPJWqJ2uFCp6K9zwC+H/0jFsgZkKGjdUtFF
         srzEGYXT36fT725OaF4Vg2/mcyllPXwht6YIj9aUGEX+zBZblfiKmUOYqyB7g9uCOf
         4uLK5M5Y2SDdkAf8iRztk0eHtpugJ5ZZX/EZPuAo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200703034824epcas1p15cfac27f72276e148bef37419348b1dd~eIXThD6U-2607726077epcas1p11;
        Fri,  3 Jul 2020 03:48:24 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49ygsy4yWRzMqYkk; Fri,  3 Jul
        2020 03:48:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.C3.28578.68AAEFE5; Fri,  3 Jul 2020 12:48:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200703034821epcas1p34be0eecdeb0fe1143cc21216504d276f~eIXRl7cCL1577515775epcas1p3_;
        Fri,  3 Jul 2020 03:48:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703034821epsmtrp26ef4b00445db63759e094d93f68b8ae2~eIXRk1myM1054010540epsmtrp2Z;
        Fri,  3 Jul 2020 03:48:21 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-bc-5efeaa861924
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.9E.08382.58AAEFE5; Fri,  3 Jul 2020 12:48:21 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200703034821epsmtip1cd2e670501a613b10a8a6f02d2c45dbf~eIXRZLDwV2880628806epsmtip1v;
        Fri,  3 Jul 2020 03:48:21 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <000001d65069$3a78c5f0$af6a51d0$@samsung.com>
Subject: RE: [PATCH v2] exfat: optimize exfat_zeroed_cluster()
Date:   Fri, 3 Jul 2020 12:48:21 +0900
Message-ID: <003b01d650ec$cbeab970$63c02c50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIesF+OtlZHZt+xlFHZAmUunjWjpQK9BQUgA5/FWZioMZJeQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmnm7bqn9xBo8aVC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEn48eiScwFi5kqZmwwbmB8z9jFyMkhIWAiceJOO2sXIxeHkMAORolPP5aygiSE
        BD4xSrSvcoJIfGOU+LrsMjNMx7trdxkhivYySqy8oAJR9JJR4vuZaywgCTYBXYl/f/azgdgi
        AtESx3acZwQpYha4wijx4NEsJpAEp4CVxM0zL8DWCQvYSdzufQTWzCKgInHn9x6wZl4BS4kV
        DftZIWxBiZMzn4DVMAvIS2x/OwfqIgWJn0+XAdVwAC1zkmh7Fg5RIiIxu7ONGWSvhMBMDolT
        e2eyQ9S7SOxbeY4NwhaWeHV8C1RcSuLzu71sIHMkBKolPu6HGt/BKPHiuy2EbSxxc/0GsFXM
        ApoS63fpQ4QVJXb+nssIsZZP4t3XHlaIKbwSHW1CECWqEn2XDjNB2NISXe0f2CcwKs1C8tcs
        JH/NQvLALIRlCxhZVjGKpRYU56anFhsWmCLH9CZGcCLVstzBOP3tB71DjEwcjIcYJTiYlUR4
        E1T/xQnxpiRWVqUW5ccXleakFh9iNAWG9ERmKdHkfGAqzyuJNzQ1MjY2tjAxMzczNVYS53Wy
        vhAnJJCeWJKanZpakFoE08fEwSnVwMT1skR7afnxW5Yfg9bwavrpZ29fVOz/Y0aywLvKMwp3
        dqk5H9kg4/WzesbTtzdUzsXEm2XWhG01+MC5crG2r3uPRtAD/3O94lPMb97b8sDq4JeZv7uS
        eJuWt76UPVeo+CFz7v8jF5/wPVnpumrrEgb3/TKbmpfWv1C8vz39s8ORytg94Xvt9bQVL2ps
        q87vuVC/a/VTsa3BDDL3z8s3C0veeflgxuVTVicTz0X19p7eu7r1044nbI9+mlwVXLJHWPkc
        d7zJ9tRJJ3Tmxe+ylXGobNU5sPaEUvDXbRH7a354zpoU0+ZtuKn0joQAa1VEFqtazyWziX9f
        t9+ZKdxqbDZDJVLtmeznNfeEJGdzVSorsRRnJBpqMRcVJwIAzf8+Sy0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTrd11b84g3VLTC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlfFj0STmgsVMFTM2GDcwvmfsYuTkkBAwkXh37S6QzcUh
        JLCbUWLz5fesEAlpiWMnzjB3MXIA2cIShw8XQ9Q8Z5Roa/kBVsMmoCvx789+NhBbRCBa4urf
        vywgNrPANUaJ79OzIRp2MEoc/QqxjVPASuLmmRdgzcICdhK3ex+BNbAIqEjc+b0HbBCvgKXE
        iob9rBC2oMTJmU+ghmpL9D5sZYSw5SW2v53DDHGogsTPp8tYQQ4VEXCSaHsWDlEiIjG7s415
        AqPwLCSTZiGZNAvJpFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOKi3N
        HYzbV33QO8TIxMF4iFGCg1lJhDdB9V+cEG9KYmVValF+fFFpTmrxIUZpDhYlcd4bhQvjhATS
        E0tSs1NTC1KLYLJMHJxSDUwu/3mnJfFM7d97Y+HuO4pmxzXzqptd3922UOHOuWrFeXpPqdSS
        yY4zDkzd9upS3hZr5RRnziamMOm7jYfVdhasrlhTlsC+4ZT0mR8q+6J6Wk2qcy/6fvf9qPBK
        a0XRw8P///GasKgo25wpv64Q5MbNOzH32YrZ8Q8uBS02f/U08Frw0Q1C2ZGat2ccqTl/qDL6
        kY6cq8quKZFWL8JV4ifv2jmVb/LXolP1CSuXsW2T+idVmNtvt3ZpzDULHanfklfmvFh8Y8Lp
        PW5dovxXXG8XzrrYaPIt6dQUC8WnqkcC2EJCP3SsCXzms1VpvuD3VtM+Y6Y3yfNqpy9zsT4+
        oy/h8OOUmjfp8zKamrdVVIcrsRRnJBpqMRcVJwIAxMpAExkDAAA=
X-CMS-MailID: 20200703034821epcas1p34be0eecdeb0fe1143cc21216504d276f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200624023050epcas1p1f794fee8957367322d27f828aead2ebc
References: <CGME20200624023050epcas1p1f794fee8957367322d27f828aead2ebc@epcas1p1.samsung.com>
        <20200624023041.30247-1-kohada.t2@gmail.com>
        <000001d65069$3a78c5f0$af6a51d0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Replace part of exfat_zeroed_cluster() with exfat_update_bhs().
> > And remove exfat_sync_bhs().
> >
> > Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> 
> Looks good. Thanks.
Pushed it into exfat #dev.
Thanks!

