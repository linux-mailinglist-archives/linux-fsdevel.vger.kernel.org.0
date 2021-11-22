Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C834587EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 03:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhKVCNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 21:13:24 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:46706 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhKVCNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 21:13:23 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211122021015epoutp0162b4984bcc63652d79d162731a20890e~5vFW7xOxQ0234902349epoutp01R
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 02:10:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211122021015epoutp0162b4984bcc63652d79d162731a20890e~5vFW7xOxQ0234902349epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637547015;
        bh=1YUV5xqy55zq2H+g0AKZ0yRsAtNBn8xWbSuvPua7zKk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ORAUtxxYRl1Qm7jQJ1EAr4iuJ/g4jFV5VpxKUPDhCGaoIHHhp4+R30jmZ5fL/XsKX
         MX08vd/IwZUPyqr7zgxdFJ4l2ARH7uByb5kGbpF7xNc337KIi/imJFWR/cyb88yzDj
         NW0TGuUVsUPPO8KWNkVH8MdA/5rrRoDd6Gy7i10w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211122021015epcas1p4ecddc3261bef6590fb65523b69b475a9~5vFWqpjoO2176021760epcas1p4B;
        Mon, 22 Nov 2021 02:10:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.243]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Hy9hj3vvvz4x9QM; Mon, 22 Nov
        2021 02:10:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.FD.09592.30CFA916; Mon, 22 Nov 2021 11:10:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211122021011epcas1p24bbf9a2324d316bd6140ff5c2ed338a3~5vFSmEAoP1484914849epcas1p2H;
        Mon, 22 Nov 2021 02:10:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211122021011epsmtrp2889be86972099fb6c15d12a9c3aaa30e~5vFSlH1cj2015020150epsmtrp2H;
        Mon, 22 Nov 2021 02:10:11 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-82-619afc03ea53
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.4D.29871.30CFA916; Mon, 22 Nov 2021 11:10:11 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211122021011epsmtip24581792c17a13d7a9be0151e9026f7b0~5vFSco4hN0076900769epsmtip2_;
        Mon, 22 Nov 2021 02:10:11 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Christophe Vu-Brugier'" <cvubrugier@fastmail.fm>,
        <linux-fsdevel@vger.kernel.org>
Cc:     "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'Matthew Wilcox'" <willy@infradead.org>,
        "'Christophe Vu-Brugier'" <christophe.vu-brugier@seagate.com>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20211119173734.2545-1-cvubrugier@fastmail.fm>
Subject: RE: [PATCH v2] exfat: fix i_blocks for files truncated over 4 GiB
Date:   Mon, 22 Nov 2021 11:10:11 +0900
Message-ID: <e9d301d7df46$1441f290$3cc5d7b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQELHwIOV8p/aLchBxXLVC4runYQgQHqAmmqAcEwrZitiu9ZoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmni7zn1mJBn2HtS3+rv7OZPH/Xiuj
        xcRpS5kt9uw9yWKx5d8RVovfP+awObB57Dx1gM1j8wotj02rOtk8+rasYvRoP/yNxePzJrkA
        tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkamQIUJ
        2RmTjrxgL2jkqHjb/pOtgXEfWxcjJ4eEgInE7KdbWLoYuTiEBHYwSvx4+ZcNwvnEKLH0/06o
        zDdGiZ9tV1hhWn78ucMOkdjLKLG7bxYThPOSUeLLy80sIFVsAroST278ZO5i5OAQEYiUWHcu
        EiTMLLCJUaJrpg6IzSlgLfGvax4jiC0s4CXR/f02E4jNIqAqcffjLXaQVl4BS4nlv01BwrwC
        ghInZz5hgRgjL7H97RxmiHsUJHZ/Ogp2m4iAk8S2HU/ZIWpEJGZ3tjGDnCYhMJNDYvK8CVA/
        u0i8nvubBcIWlnh1fAs7hC0l8fndXjaIhlWMEhvWX4ZyVjNK3Lx1nQXkIgkBe4n3lyxATGYB
        TYn1u/QhehUldv6eywixmE/i3dceVohqXomONiGIEhWJ7x92ssCsuvLjKtMERqVZSF6bheS1
        WUhemIWwbAEjyypGsdSC4tz01GLDAmN4ZCfn525iBCdQLfMdjNPeftA7xMjEwXiIUYKDWUmE
        l2PD9EQh3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA9M4Xkl8YYmlgYmZkYmFsaWxmZK4rwv
        /IGaBNITS1KzU1MLUotg+pg4OKUamLwXuXZqb/p/t93mxsItSo6Xbrw+zVKSv1B+mUW26JEd
        sssMJE9Nf39XeF7qZPu/Ge94eXS/39m0lckq1Ftdwf3MCqfZS6+aGEdeuvteZAnXtQBmF7OA
        /MlbfjzQ2PHnQFrKUuPC/9yJz4rfCh+W15CYPOO3zQv1Z97TU5wNDL3knEv+zd98zWfeA3vh
        pdOeH9xhd25Nu3Uhq8vU2TNPZnVYej+7ttu3f6H+VwHxO6L2IvOWrbJM29cafFZi7TmXxfdj
        l/VFXhC9E57XfLPxhJ+g0K/aI3xftjGfPiwyz9whJ2W5zFXDwrnRK8TXSl7cZ2D9ojtvwcH6
        73nhE3U/LV41eeZM40M7ehY5TldreV6nxFKckWioxVxUnAgApT0i1ykEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvC7zn1mJBvv+8Fn8Xf2dyeL/vVZG
        i4nTljJb7Nl7ksViy78jrBa/f8xhc2Dz2HnqAJvH5hVaHptWdbJ59G1ZxejRfvgbi8fnTXIB
        bFFcNimpOZllqUX6dglcGZOOvGAvaOSoeNv+k62BcR9bFyMnh4SAicSPP3fYuxi5OIQEdjNK
        XJi/jLGLkQMoISVxcJ8mhCkscfhwMUTJc0aJKXs3sYL0sgnoSjy58ZMZpEZEIFJi3blIkBpm
        gS2MEru39oPNFwJxNk6XALE5Bawl/nXNYwSxhQW8JLq/32YCsVkEVCXufrzFDjKHV8BSYvlv
        U5Awr4CgxMmZT1hAwswCehJtG8E6mQXkJba/ncMMcb2CxO5PR8GuERFwkti24yk7RI2IxOzO
        NuYJjMKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxD
        Wpo7GLev+qB3iJGJg/EQowQHs5IIL8eG6YlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
        EkhPLEnNTk0tSC2CyTJxcEo1MCn1hhsn/Vr/mC/TgHHhpTL9J5HfGqWnxM1OFz5lnCwYbLLu
        7YtmuYtX0n/sttvK+P4Y32ObhIP6F4+vmKvNF3GBg7XJxfaTKEvbga5ru3bZWuyxbdCdo9Wx
        rv+gq9DU7iTW/9YnHDqSVN/4hP4NMzAX5k3nYDf1PWHJJfe1aY7tO3HJGL1TjjU7JbazPboU
        aNV3hPfbGeOOJ+4/FTevEqtK93sXt6Dl96Xtm1a/2b5myrZDfk+2PZz2r6/7V77Js84EfQ+G
        XcJ2M3S/F5f31le8mt699NI81TCbf55C1Z84ItmYPydnBV/ncVqmw35xaYD28/h5LJ95kqUO
        FS//O/3/W7X5G0vPt6gn1PEZKLEUZyQaajEXFScCANMutIAQAwAA
X-CMS-MailID: 20211122021011epcas1p24bbf9a2324d316bd6140ff5c2ed338a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211119173750epcas1p4bb84dea1dae163e67caaa306be2c1dcf
References: <YZbKobiUUt6eG6zQ@casper.infradead.org>
        <CGME20211119173750epcas1p4bb84dea1dae163e67caaa306be2c1dcf@epcas1p4.samsung.com>
        <20211119173734.2545-1-cvubrugier@fastmail.fm>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
> 
> In exfat_truncate(), the computation of inode->i_blocks is wrong if the
> file is larger than 4 GiB because a 32-bit variable is used as a mask.
> This is fixed and simplified by using round_up().
> 
> Also fix the same buggy computation in exfat_read_root() and another
> (correct) one in exfat_fill_inode(). The latter was fixed another way last
> month but can be simplified by using round_up() as well. See:
> 
>   commit 0c336d6e33f4 ("exfat: fix incorrect loading of i_blocks for
>                         large files")
> 
> Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>

Thanks for your patch!
Please update your patch again with below tags.

Fixes: 719c1e1829166 ("exfat: add super block operations")
Fixes: 98d917047e8b7 ("exfat: add file operations")
Cc: stable@vger.kernel.org # v5.7+

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

