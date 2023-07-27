Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83A765391
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjG0MWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjG0MWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:22:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1A73A9C;
        Thu, 27 Jul 2023 05:22:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230727122204euoutp01c1300deceb0647d29e9f84fa39a09ce3~1uOP6PDUE0931709317euoutp01R;
        Thu, 27 Jul 2023 12:22:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230727122204euoutp01c1300deceb0647d29e9f84fa39a09ce3~1uOP6PDUE0931709317euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690460524;
        bh=UNpV9Xfy6rp5fo9PV60OHzWHjUdlfdxrbzjpXgfrMzE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=J6gXorgabGEge6zNvEh5HCvYIAXt+h44UjgRfdyRmGIcen/8tve5J8MNYg0AJ7mmv
         sXN+b6zRCzTdalmNd0Aa2J+1Jf04UiYIXGXv6mrewSZQayMhOJkiLqcdwtn3vYh/nL
         uTuVZeVf7kEL1+9EhCJ61bAh1Mz5znOWmnARoQtw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230727122204eucas1p1cab21b16ee35e3c5ec2c7b5e885da187~1uOPs5hFJ0682006820eucas1p1s;
        Thu, 27 Jul 2023 12:22:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.EC.42423.B6162C46; Thu, 27
        Jul 2023 13:22:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230727122203eucas1p2853f35c6361a8ff038a9c18f029426c3~1uOPIozYY0928709287eucas1p2k;
        Thu, 27 Jul 2023 12:22:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230727122203eusmtrp1bc81063491283ffdfd5d2cc34cb2a542~1uOPHcLuJ2541825418eusmtrp1u;
        Thu, 27 Jul 2023 12:22:03 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-a7-64c2616b8f92
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 93.C9.14344.B6162C46; Thu, 27
        Jul 2023 13:22:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230727122203eusmtip1272296c5a534d5b122bea29b4cbc9ca3~1uOOxtg841066510665eusmtip1g;
        Thu, 27 Jul 2023 12:22:03 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 13:22:02 +0100
Date:   Thu, 27 Jul 2023 14:22:00 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 06/14] sysctl: Add size to register_sysctl
Message-ID: <20230727122200.r5o2mj5qgah5yfwm@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="eyp7i2qlh4lxb2ih"
Content-Disposition: inline
In-Reply-To: <ZMFexmOcfyORkRRs@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTVxjGd3pvbwuz5FoaOQPmlgL7UISZMHYWhI25hOuyGWLiEliG6+gN
        MmjL+qGAWcCVbq4CqUOZVMBWtCjUMkphUzeQRltpF4oOFzTUiMgyKF8WZHwMHOWyzWT//d7n
        fZ6857m5XIzfRoRzc6VKWi4V5QuJYLzDsdC7LV9kF792ZhJDre5RAg0v2wk0ZSoHqNZThqMR
        xwMO6tPPsZG6oYVAvvomgJ4YZOiXoxLU11HJRtbh39jop597cPTr5VoC6YxqDA3oRgByGDah
        Ofc4QKaWixxUNvg6WppfNZgu7X57E2WuNwPqVOlNnLJduMOiDFYV1XZ+C3XXl0xZm74hKN2Z
        q4DqqjNzqLazJdRU522CmrFuTt+QGbxDTOfnHqDl8SmfBO/3ac6xC34IK7RdKcVLgSNUC4K4
        kEyAF0pdmBYEc/nkeQD1R7Q4M8wCODLpXN/MAGh1tLK0gLsW0U4/y+iNAC5qfKx/Td5RD4cZ
        2gGcufQ1K3AEJ2Pg8Nh1IsAEGQs944NYgAXkK7BTV7GWxkg1AfX3eonAiVAyBfo9WQEPj3wD
        dk60AYY3wp6ah3iAMbIQ2jQDnIAdIyNg4wo3IAeRidB8/C/AdIuC3WeXOAx/AV22u2unIHkx
        GNa4y9cX78IOr3udQ+GY07bOkdBdVY4zgSoAu1amOczQDKDp8GMW40qCZf0P1xOp0LxQQzDf
        KAQOTGxkHhoCv+34DmNkHjzyFZ9xvwSb743jOhClf6qa/qlq+v+qMXIsNFzxE/+Tt0KT0Ycx
        nAwtlincADhNIIxWKSQ5tGK7lD4YpxBJFCppTly2TGIFq/+ye8Xp/xHUjT2KswMWF9hB9Gr4
        wffNfSAcl8qktFDAc6XbxXyeWFRUTMtl++SqfFphBxFcXBjG25rck80nc0RKOo+mC2j5P1sW
        Nyi8lCVZUl2PnC//uGGDKkteffWxoN3x2cG3LD33Lb6bKbPvHf8wYZeW542c7z5UO5hxgowQ
        VLa3fvT7fG+1P+m+87JMU2W8o7mxL4l964Awa0/I+yXHEq5FSkKNkx3m1GMtmbM5yzdO5tXF
        vLl3llR+IHYdffTMyZUK3uJpr77Bn4lXDBYdKhk+lTi9cC2+hMqWD6UtZcdK+tMs8frUrNt5
        glue7pFPX+7uby6OTSuae1Gd4XjOXa2uLMgAQ67l9E7vq0P1o30ROxYnDEoyupVvYxXadu5+
        slO8+fPo/sPOmBeUrr1N4UF2Gd174p36P7vinlc0fpm4Laruj5qhc8ZdZZG5xfFCXLFftH0L
        JleI/gZGqk93RgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xu7rZiYdSDKbeFbfYePolm8Xjv4fY
        LN4v62G0mHO+hcXi6bFH7BYXZn1jtWhevJ7N4vW8VYwW/xfkW5zpzrW4sK2P1WLT42usFnv2
        nmSxuLxrDpvFhIXNzBY3JjxltDi2QMzi2+k3jBbL1q9lt2i5Y2rx+wdQwbKdfg5iHmvmrWH0
        mN1wkcVjy8qbTB4LNpV6bF6h5XHrta3HplWdbB4TFh1g9Ng/dw27x+Yl9R7v911l8/i8SS6A
        J0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo//F
        SbaCreIVe94uZm1gPCLcxcjBISFgItH1gbuLkYtDSGApo8SqeTcZuxg5geIyEhu/XGWFsIUl
        /lzrYoMo+sgoMfv4ZmYIZyujxLkNK8E6WARUJR6/OsoGYrMJ6Eicf3OHGcQWEdCQ2Dehlwmk
        gVmgmU1i1r1zbCCrhQXsJD6djwOp4RUwl9j3djMj3Iap2z+yQCQEJU7OfAJmMwuUSXy6eYkV
        pJdZQFpi+T8OkDCngJnEmil/oK5Wlji45Dc7hF0r8fnvM8YJjMKzkEyahWTSLIRJEGEtiRv/
        XjJhCGtLLFv4mhnCtpVYt+49ywJG9lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBqWnbsZ9b
        djCufPVR7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4T0VcChFiDclsbIqtSg/vqg0J7X4EKMp
        MBQnMkuJJucDk2ZeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT
        nMbRahHFNTc0OO+l352SzvB/VjCn0DaJ0vr/Gb8K3tyrDxO3l3vjv8XU31Li57a+Vof4mwtf
        sv6ab5sY+/CFw7XQLQ9jd5qn13Bk/Dx2r6xc9l1Y2qHbEwV4FnobL84J3H3ne57az+n/mSbt
        KpZcH+yzVHm1YMbuaekLbjmzri5eMsvlrU5OwN/1Ub4qa9fKrkrY+GjPOvkp64+6+u1IUP5x
        T+jrqf/CIcJxFvuThL27alYLfHvyfubbBR9/BrPJxipu+ViySIPv5AuptnWfW8zUXjUczX/X
        /LKBTfvQktSX/8y+sy7UcUxfcI/psu7pE099TXIepdiqH+I4zJRrsmLDzJffpDbl9ZTl+W/+
        psRSnJFoqMVcVJwIAIjZKqXiAwAA
X-CMS-MailID: 20230727122203eucas1p2853f35c6361a8ff038a9c18f029426c3
X-Msg-Generator: CA
X-RootMTR: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72@eucas1p2.samsung.com>
        <20230726140635.2059334-7-j.granados@samsung.com>
        <ZMFexmOcfyORkRRs@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--eyp7i2qlh4lxb2ih
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 10:58:30AM -0700, Luis Chamberlain wrote:
> On Wed, Jul 26, 2023 at 04:06:26PM +0200, Joel Granados wrote:
> > In order to remove the end element from the ctl_table struct arrays, we
> > replace the register_syctl function with a macro that will add the
> > ARRAY_SIZE to the new register_sysctl_sz function. In this way the
> > callers that are already using an array of ctl_table structs do not have
> > to change. We *do* change the callers that pass the ctl_table array as a
> > pointer.
>=20
> Thanks for doing this and this series!
>=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > index 0495c858989f..b1168ae281c9 100644
> > --- a/include/linux/sysctl.h
> > +++ b/include/linux/sysctl.h
> > @@ -215,6 +215,9 @@ struct ctl_path {
> >  	const char *procname;
> >  };
> > =20
> > +#define register_sysctl(path, table)	\
> > +	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> > +
> >  #ifdef CONFIG_SYSCTL
>=20
> Wasn't it Greg who had suggested this? Maybe add Suggested-by with him
> on it.
Yes. I mentioned him in the cover letter and did not add the tag because
I had not asked for permission to use it. I'll drop him a mail and
include the suggested-by if he agrees.

>=20
> Also, your cover letter and first few patches are not CC'd to the netdev
> list or others. What you want to do is collect all the email addresses
> for this small patch series and add them to who you email for your
> entire series, otherwise at times they won't be able to properly review
> or understand the exact context of the changes. You want folks to do less
> work to review, not more.
Here I wanted to avoid very big e-mail headers as I have received
rejections from lists in the past. But I for this set, the number of
e-mails is ok to just include everyone.

I'll do that for V2.
thx for your feedback

best

>=20
> So please resend and add others to the other patches.
>=20
>   Luis

--=20

Joel Granados

--eyp7i2qlh4lxb2ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTCYWMACgkQupfNUreW
QU8CPgwAkr6P3axpBPzX0iTBJ2K6Cnt/H3xegrsFZtH2oCi5BcL3GjmmatTKqded
N1XCtc6Cch2GBr3e9GXx2jz4884QGHZWiVta+8sxBtE4Jme+mRk0j14Z9jl9v1Zf
9aYK2G2xPzhvaQcnRXh8n1dJOoJcLZLT8hb8JypNJ4R63yyiHSFZkqv8vNpriRDm
4dL1P8z24wQKNiD5RlKJ1zq7BfCLg7JbwMmacKCxjQ8INWMP+1NAtmazejQbh7Ui
VPXWkXWT2xyVrd18l4LhEYCCqckk7mJjuyzHUE5F3IXb1bdjuyNWZSJDuREBaA6Y
FCpirpaUH7agFN6SzrZkDJ9ZTA4ZVTKvXUrHBza3mUBAojd34rFvZxLXFDdAhLM0
8qdyB7DVLJs7q7NY8LVOyDnL/mhWQPU9pBdSPPDKb4qf9uRedOEhJtcD/7ez1jSg
1xdxVoMk7YSI+NMQa/fMHGtNixyCydeZgp6A7Bjh5iRHH79cB6nQqVhBIABASO2l
Exrcwht1
=hAeI
-----END PGP SIGNATURE-----

--eyp7i2qlh4lxb2ih--
