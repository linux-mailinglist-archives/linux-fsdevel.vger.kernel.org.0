Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDD28FF93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404883AbgJPH5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 03:57:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22842 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404837AbgJPH5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 03:57:10 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201016075706epoutp0205f2dcd8d4fb49f117dbba068cf4bcf2~_afcAKsDo2505925059epoutp02B
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 07:57:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201016075706epoutp0205f2dcd8d4fb49f117dbba068cf4bcf2~_afcAKsDo2505925059epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602835027;
        bh=AHDZsjQ1Pel0DEbKCXT7dBQAhD7i5lWKT6QFUbNHMB4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=N9Evvk1AaPQ6QZcpBEj3dnm9ujycUAPEJekjczUxlvZc9OB48P1W8n91ucYuzT8m9
         BBDWZV+ZjEY+fpnlsbHLyp8JDBZb/mjcX65ksn56YDsjx4Czjuk+c5cfAQkVva3or0
         OC4sxQ2M7Nw5VEciGDsQ8mYcj7dQYfYgbH6o01Q4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201016075706epcas1p499778fe5ffcd26a948de1aaf4e8fc295~_afbvS3DS2246422464epcas1p46;
        Fri, 16 Oct 2020 07:57:06 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CCJQT57GSzMqYlh; Fri, 16 Oct
        2020 07:57:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.1E.09543.152598F5; Fri, 16 Oct 2020 16:57:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201016075705epcas1p153f32bba72725478ab1f2715f0b5ac84~_afabrY_k2008320083epcas1p1K;
        Fri, 16 Oct 2020 07:57:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201016075705epsmtrp1dc1a036ad890002d58c7378202ccf760~_afaa62YJ0675906759epsmtrp1k;
        Fri, 16 Oct 2020 07:57:05 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-4f-5f895251f76d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.14.08745.152598F5; Fri, 16 Oct 2020 16:57:05 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201016075705epsmtip26be1c6eb37ca4650274f0f51a9478a69~_afaPZpbz2976129761epsmtip2M;
        Fri, 16 Oct 2020 07:57:05 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20201002060528.27519-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v3 2/2] exfat: aggregate dir-entry updates into
 __exfat_write_inode().
Date:   Fri, 16 Oct 2020 16:57:05 +0900
Message-ID: <018b01d6a391$f06fc310$d14f4930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGsrAc6GOeBBrRdXvsz9tvKpNvsaQJgHYnqqdrHtUA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmnm5gUGe8wctd6hY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFost/46wOrB5fJlznN2j+dhKNo+ds+6ye/RtWcXo8XmTXABrVI5N
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIwf
        s1+yFfxgqbh3YQdbA+ML5i5GTg4JAROJSyfmsXQxcnEICexglFgypYkZwvnEKLFl21mozGdG
        iQ9bTrDCtHy9tpERIrGLUeJA0002COclo8T9h0fABrMJ6Er8+7OfDcQWEdCTOHnyOlgRs8BF
        RomXJ9exgyQ4BSwlfhxcxQJiCwvESFxfOJEJxGYRUJXYeuEy2CBeoJr5pyazQdiCEidnPgGr
        ZxaQl9j+dg7UFwoSP58uY4VYZiXx7l8XVI2IxOzONrCHJAR6OSRW7OligmhwkZi8/BYLhC0s
        8er4FnYIW0riZX8bkM0BZFdLfNwPNb+DUeLFd1sI21ji5voNrCAlzAKaEut36UOEFSV2/p7L
        CLGWT+Ld1x5WiCm8Eh1tQhAlqhJ9lw5DHSAt0dX+gX0Co9IsJI/NQvLYLCQPzEJYtoCRZRWj
        WGpBcW56arFhgSFybG9iBCdPLdMdjBPfftA7xMjEwXiIUYKDWUmE95V0W7wQb0piZVVqUX58
        UWlOavEhRlNgUE9klhJNzgem77ySeENTI2NjYwsTM3MzU2Mlcd4/2h3xQgLpiSWp2ampBalF
        MH1MHJxSDUw9ex6+qD9YuP3Nzj83NSYmHpJPuVC+3HZVgNN39Z3PDstn31pWf03Z9i1b9QO5
        +Y3i1xntVxwrO+nB+W/a066QWf2vk1n/LewzrTXYv6CBU4z10wyHI7sviysKVG9eeU//lprp
        ZIulftbfBQ3bmgvk6pm2rJ7ftiXJIvcZb0IU04J9oZE3klrLk2fsijhodmud/WOjxTGVj/bH
        Xed6MNk5+2mJ8LWp085dvMh78MHb/yFtkU+5BS9nblUNZ5UX/vDQYnbwl1rHmTr+x8/Y5jRs
        TJrk11Wm7bDz5/p7Aa86CzK/bYuPjLmQwly43aY9eMnV6sSy6N5+d7H8ZW+MFqdOE5r3Rpfp
        evH29FaJLe5KLMUZiYZazEXFiQDgBR9BJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvG5gUGe8wbzp3BY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFost/46wOrB5fJlznN2j+dhKNo+ds+6ye/RtWcXo8XmTXABrFJdN
        SmpOZllqkb5dAlfGj9kv2Qp+sFTcu7CDrYHxBXMXIyeHhICJxNdrGxlBbCGBHYwSrRPcIOLS
        EsdOnAGq4QCyhSUOHy7uYuQCKnnOKNE18RxYL5uArsS/P/vZQGwRAT2Jkyevs4EUMQtcZpTo
        bZvIAtHRxSix+MxOsCpOAUuJHwdXsYDYwgJREis2/ADbzCKgKrH1wmWwqbxANfNPTWaDsAUl
        Ts58wgJyBTPQhjaIQ5kF5CW2v50D9YCCxM+ny1ghjrCSePeviwWiRkRidmcb8wRG4VlIJs1C
        mDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjiAtrR2Me1Z90DvE
        yMTBeIhRgoNZSYT3lXRbvBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHer7MWxgkJpCeWpGanphak
        FsFkmTg4pRqY5FQZ3ob9e7x9/T2p5F5bB80G1sJGm80CD3+w9v0sOpCdrlhvx2u/4tZPzp9f
        bk7YlrZBwDf4XY+a+toDHjXcv4XOnVIJWcSQcXyalr2c+sc7MhLVO486FPmJsK3QL9pxefnz
        C7xP9QOev9q0a6K36Hwboa97WHKeVau4SaeffFSXea3+OEPdBLczjEdeLLE0ObU8oLKC88jl
        cBaxnp8/dO52z/XYapXa3fBcR35NbNdh3kTpzlBG/2N+4ru4d5fUbUs0l580K9x4cpr4Nk63
        vMhTfUd2W4TmX94eYNDO+eBM1K7zdxpv+97tPnf8aGJHq8oPs/ftDU945MwmX/Zv858b1sYk
        aqa12oNB4JwSS3FGoqEWc1FxIgCCKYwRDwMAAA==
X-CMS-MailID: 20201016075705epcas1p153f32bba72725478ab1f2715f0b5ac84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201002060539epcas1p4efa16130724ad15a3f105f62dd78d018
References: <CGME20201002060539epcas1p4efa16130724ad15a3f105f62dd78d018@epcas1p4.samsung.com>
        <20201002060528.27519-1-kohada.t2@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> *inode)  static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  		unsigned int *clu, int create)
>  {
> -	int ret, modified = false;
> +	int ret;
>  	unsigned int last_clu;
>  	struct exfat_chain new_clu;
>  	struct super_block *sb = inode->i_sb;
> @@ -184,6 +185,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  			return -EIO;
>  		}
> 
> +		exfat_warn(sb, "alloc[%lu]@map: %lld (%d - %08x)",
> +			   inode->i_ino, i_size_read(inode),
> +			   (clu_offset << sbi->sect_per_clus_bits) * 512,
> +			   last_clu);
Is this leftover print from debugging?

