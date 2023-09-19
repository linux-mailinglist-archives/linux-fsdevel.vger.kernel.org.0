Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1D7A64DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjISN1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjISN1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:27:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D833F5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:27:23 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230919132718euoutp0150b58b861e2b90c896408295436db8a8~GT8oE_PfZ0428604286euoutp01U
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:27:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230919132718euoutp0150b58b861e2b90c896408295436db8a8~GT8oE_PfZ0428604286euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695130038;
        bh=40z8z1Hk73M2hkRg1wiBJ5ltFVq3yIwwQsZN0SRdJQk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QkmWHV2y1/NWdbsR1xjb0RbzT2vhEW1YXTd+EhBxSND346K7KbjGvht2wliCwNhV0
         EoIJsTsCRGnqqPh0bn7/A1rB2jB2d9kEvA9E17/csS1rHDU4UQwzJ8XpVXoqZxY0MK
         dIYhLAPOaO5bYJzZyXGLGDpERAWzWhhjO0lWPghM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919132718eucas1p2690958eecaa6a552a57fee113946a99a~GT8nwyobo1210812108eucas1p2J;
        Tue, 19 Sep 2023 13:27:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.CA.42423.6B1A9056; Tue, 19
        Sep 2023 14:27:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919132717eucas1p14025d8b15de60bc47717f7109006a7df~GT8nIzafE0694306943eucas1p1w;
        Tue, 19 Sep 2023 13:27:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919132717eusmtrp1e2032a27255919decb261e686f7e95d6~GT8nHqlYu0971909719eusmtrp1O;
        Tue, 19 Sep 2023 13:27:17 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-fe-6509a1b66889
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.AF.14344.5B1A9056; Tue, 19
        Sep 2023 14:27:17 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230919132717eusmtip25883ef57b8ec7ed35d8b476c6b813de3~GT8m8TsEj1522015220eusmtip2S;
        Tue, 19 Sep 2023 13:27:17 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:27:17 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:27:17 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 6/6] shmem: add large folios support to the write path
Thread-Topic: [PATCH 6/6] shmem: add large folios support to the write path
Thread-Index: AQHZ57o0gOj42/h7V0WVSDdaHJaWqLAcJBuAgAQHWgCAALe7AIABNpkA
Date:   Tue, 19 Sep 2023 13:27:16 +0000
Message-ID: <20230919132633.v2mvuaxp2w76zoed@sarkhan>
In-Reply-To: <CAJD7tkZSST8Kc6duUWt6a9igrsn=ucUPSVPWWGDWEUxBs3b4bg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E24B553E1C01443868318873E7B686E@scsc.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djP87rbFnKmGqy8JW4xZ/0aNovVd/vZ
        LC4/4bN4+qmPxWLvLW2LPXtPslhc3jWHzeLemv+sFrv+7GC3uDHhKaPFsq/v2S12b1zEZvH7
        B1B2+65IBz6P2Q0XWTwWbCr12LxCy+Py2VKPTas62Tw2fZrE7nFixm8Wj8+b5AI4orhsUlJz
        MstSi/TtErgy3mzdzFpwxKmiZ/cFtgbGFw5djJwcEgImEq+u3WbvYuTiEBJYwSixbOEHKOcL
        o8THFTOYIJzPjBI3L/xihGmZ9eE3VNVyRoneg58Z4apuXFjLDlIlJHCGUWJypwNEYiWjxLNV
        G1lBEmwCmhL7Tm4CKxIRUJeYu2YT2FhmgS+sEl83BIHYwgJeEuvn3GGGqPGWeLFzCRuE7Sax
        +PIOsDiLgKrE5Y1TweK8AqYSU2ZuBItzCgRKdO7dBxZnFJCVeLTyFzvEfHGJW0/mM0G8ICix
        aPYeZghbTOLfrodsELaOxNnrT6DeNJDYunQfC4StJPGnYyFQnANojqbE+l36ECMtJc70vWGC
        sBUlpnQ/ZIc4R1Di5MwnLCC/SwhM5ZJ4/f4P1HwXiZaGg1A3CEu8Or6FfQKjziwk581CWDEL
        yYpZSFbMQrJiASPrKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDEd/rf8U87GOe++qh3
        iJGJg/EQowQHs5II70xDtlQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1ML
        UotgskwcnFINTPMezLH3kblaYTy58ti3We6npltKMcf2nd60b6fL1T9KdmurhMSXaPjnGLzK
        WPSN9XFrkmr47PLJE2w9Qy8fu7Ju+ZuLefM3ftdLvPhBq7X0TnCZCt97ZoO3+WnFvPc6q70D
        WT1szx5ZPNGklW294wEXkSOZ2gdY/y8oyZuWJfp9yopnVbZG7OnVPv8/7vA+ZGikmpJ+eft2
        vZ1hUeIyOSFd8c77bv9ZfeLTkov5rF2f/9VkTXnedzNqUcj3pS9Wx7yYyzujLDiFs1ZhPbMa
        57MZ16J81mYYWbg+TRBPvHPkxAMrp7O+L2Yf3+CsedJiAlMvZ9CqF7m8Rcl1gr7aZ5bIRn5h
        C2WN85ns9T01SomlOCPRUIu5qDgRAIHNMjvrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsVy+t/xe7pbF3KmGnT06FrMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        AZTdvivSgc9jdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzS
        klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MN1s3sxYccaro
        2X2BrYHxhUMXIyeHhICJxKwPv9m7GLk4hASWMkq8XX+eHSIhI7Hxy1VWCFtY4s+1LjaIoo+M
        EvNX7mUBSQgJnGGUuHDBFiKxklHi1ZwNYN1sApoS+05uArNFBNQl5q7ZxAhiMwt8YZX4uiEI
        xBYW8JJYP+cOM0SNt8SLnUvYIGw3icWXd4DFWQRUJS5vnAoW5xUwlZgycyMzxLLfTBIdW/rA
        EpwCgRKde/eB2YwCshKPVv5ih1gmLnHryXwmiBcEJJbsOc8MYYtKvHz8D+o1HYmz158wQtgG
        EluX7mOBsJUk/nQsBIpzAM3RlFi/Sx9ipKXEmb43TBC2osSU7ofsELcJSpyc+YRlAqPMLCSb
        ZyF0z0LSPQtJ9ywk3QsYWVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEJrVtx35u2cG48tVH
        vUOMTByMhxglOJiVRHhnGrKlCvGmJFZWpRblxxeV5qQWH2I0BQbdRGYp0eR8YFrNK4k3NDMw
        NTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgmnxTM+ad+c9DipNZWxPPsl6r
        rNBm8Kn+2H+xJk3RtGziT3GBGbf0rA32/MpW/r3qWUwEg3/azITEVw0n1p3Kr1zO7Jf1XLmj
        TCEx4s7nnWsvlNr6vHly96bCnOQC1gOv77YJ5ZuUZYhvfCG08JrNh3VrfDk3PDxuc/TOvT8B
        a4P/v4+sXOp2Qs92tUfYudXSHxcIq1hIVy+4eadiGq/eeQkZfQH+y9+Wypjo7I2a37467uU0
        hmBDUdfrr3JesrZkLovbt6Oo72Lp5k85Bru2GbGl/py4TrbDUvfSlaoaO/fPj32Wnk+yZPxv
        MWXRndxn/2Uf3GaMU/l06QGvnXut3iZ/kb5du36Uz4hqNHkbqMRSnJFoqMVcVJwIAJIjgobz
        AwAA
X-CMS-MailID: 20230919132717eucas1p14025d8b15de60bc47717f7109006a7df
X-Msg-Generator: CA
X-RootMTR: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
        <20230915095042.1320180-1-da.gomez@samsung.com>
        <20230915095042.1320180-7-da.gomez@samsung.com>
        <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
        <20230918075758.vlufrhq22es2dhuu@sarkhan>
        <CAJD7tkZSST8Kc6duUWt6a9igrsn=ucUPSVPWWGDWEUxBs3b4bg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCBTZXAgMTgsIDIwMjMgYXQgMTE6NTU6MzRBTSAtMDcwMCwgWW9zcnkgQWhtZWQgd3Jv
dGU6DQo+IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDE6MDDigK9BTSBEYW5pZWwgR29tZXogPGRh
LmdvbWV6QHNhbXN1bmcuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgU2VwIDE1LCAyMDIz
IGF0IDExOjI2OjM3QU0gLTA3MDAsIFlvc3J5IEFobWVkIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBT
ZXAgMTUsIDIwMjMgYXQgMjo1MeKAr0FNIERhbmllbCBHb21leiA8ZGEuZ29tZXpAc2Ftc3VuZy5j
b20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgbGFyZ2UgZm9saW8gc3VwcG9ydCBmb3Ig
c2htZW0gd3JpdGUgcGF0aCBtYXRjaGluZyB0aGUgc2FtZSBoaWdoDQo+ID4gPiA+IG9yZGVyIHBy
ZWZlcmVuY2UgbWVjaGFuaXNtIHVzZWQgZm9yIGlvbWFwIGJ1ZmZlcmVkIElPIHBhdGggYXMgdXNl
ZCBpbg0KPiA+ID4gPiBfX2ZpbGVtYXBfZ2V0X2ZvbGlvKCkuDQo+ID4gPiA+DQo+ID4gPiA+IFVz
ZSB0aGUgX19mb2xpb19nZXRfbWF4X29yZGVyIHRvIGdldCBhIGhpbnQgZm9yIHRoZSBvcmRlciBv
ZiB0aGUgZm9saW8NCj4gPiA+ID4gYmFzZWQgb24gZmlsZSBzaXplIHdoaWNoIHRha2VzIGNhcmUg
b2YgdGhlIG1hcHBpbmcgcmVxdWlyZW1lbnRzLg0KPiA+ID4gPg0KPiA+ID4gPiBTd2FwIGRvZXMg
bm90IHN1cHBvcnQgaGlnaCBvcmRlciBmb2xpb3MgZm9yIG5vdywgc28gbWFrZSBpdCBvcmRlciAw
IGluDQo+ID4gPiA+IGNhc2Ugc3dhcCBpcyBlbmFibGVkLg0KPiA+ID4NCj4gPiA+IEkgZGlkbid0
IHRha2UgYSBjbG9zZSBsb29rIGF0IHRoZSBzZXJpZXMsIGJ1dCBJIGFtIG5vdCBzdXJlIEkNCj4g
PiA+IHVuZGVyc3RhbmQgdGhlIHJhdGlvbmFsZSBoZXJlLiBSZWNsYWltIHdpbGwgc3BsaXQgaGln
aCBvcmRlciBzaG1lbQ0KPiA+ID4gZm9saW9zIGFueXdheSwgcmlnaHQ/DQo+ID4NCj4gPiBGb3Ig
Y29udGV4dCwgdGhpcyBpcyBwYXJ0IG9mIHRoZSBlbmFibGVtZW50IG9mIGxhcmdlIGJsb2NrIHNp
emVzIChMQlMpDQo+ID4gZWZmb3J0IFsxXVsyXVszXSwgc28gdGhlIGFzc3VtcHRpb24gaGVyZSBp
cyB0aGF0IHRoZSBrZXJuZWwgd2lsbA0KPiA+IHJlY2xhaW0gbWVtb3J5IHdpdGggdGhlIHNhbWUg
KGxhcmdlKSBibG9jayBzaXplcyB0aGF0IHdlcmUgd3JpdHRlbiB0bw0KPiA+IHRoZSBkZXZpY2Uu
DQo+ID4NCj4gPiBJJ2xsIGFkZCBtb3JlIGNvbnRleHQgaW4gdGhlIFYyLg0KPiA+DQo+ID4gWzFd
IGh0dHBzOi8vcHJvdGVjdDIuZmlyZWV5ZS5jb20vdjEvdXJsP2s9YTgwYWFiMzMtYzk4MWJlMDUt
YTgwYjIwN2MtMDAwYmFiZmY5YjVkLWI2NTZkODg2MGIwNDU2MmYmcT0xJmU9NDY2NjZhY2YtZDcw
ZC00ZThkLThkMDAtYjAyNzgwOGFlNDAwJnU9aHR0cHMlM0ElMkYlMkZrZXJuZWxuZXdiaWVzLm9y
ZyUyRktlcm5lbFByb2plY3RzJTJGbGFyZ2UtYmxvY2stc2l6ZQ0KPiA+IFsyXSBodHRwczovL3By
b3RlY3QyLmZpcmVleWUuY29tL3YxL3VybD9rPTNmNzUzY2EyLTVlZmUyOTk0LTNmNzRiN2VkLTAw
MGJhYmZmOWI1ZC1lNjc4Zjg4NTQ3MTU1NWUzJnE9MSZlPTQ2NjY2YWNmLWQ3MGQtNGU4ZC04ZDAw
LWIwMjc4MDhhZTQwMCZ1PWh0dHBzJTNBJTJGJTJGZG9jcy5nb29nbGUuY29tJTJGc3ByZWFkc2hl
ZXRzJTJGZCUyRmUlMkYyUEFDWC0xdlM3c1FmdzkwUzAwbDJyZk9LbTgzSmxnMHB4OEt4TVFFNEhI
cF9ES1JHYkFHY0FWLXh1NkxJVEhCRWM0eHpWaDl3TEg2V00ybFIwY1pTOCUyRnB1Ymh0bWwlMjMN
Cj4gPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pRZmJIbG9CVXBEaCt6Q2dAZHJl
YWQuZGlzYXN0ZXIuYXJlYS8NCj4gPiA+DQo+ID4gPiBJdCBzZWVtcyBsaWtlIHdlIG9ubHkgZW5h
YmxlIGhpZ2ggb3JkZXIgZm9saW9zIGlmIHRoZSAibm9zd2FwIiBtb3VudA0KPiA+ID4gb3B0aW9u
IGlzIHVzZWQsIHdoaWNoIGlzIGZhaXJseSByZWNlbnQuIEkgZG91YnQgaXQgaXMgd2lkZWx5IHVz
ZWQuDQo+ID4NCj4gPiBGb3Igbm93LCBJIHNraXBwZWQgdGhlIHN3YXAgcGF0aCBhcyBpdCBjdXJy
ZW50bHkgbGFja3Mgc3VwcG9ydCBmb3INCj4gPiBoaWdoIG9yZGVyIGZvbGlvcy4gQnV0IEknbSBj
dXJyZW50bHkgbG9va2luZyBpbnRvIGl0IGFzIHBhcnQgb2YgdGhlIExCUw0KPiA+IGVmZm9ydCAo
cGxlYXNlIGNoZWNrIHNwcmVhZHNoZWV0IGF0IFsyXSBmb3IgdGhhdCkuDQo+DQo+IFRoYW5rcyBm
b3IgdGhlIGNvbnRleHQsIGJ1dCBJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4NCj4NCj4gSUlV
QyB3ZSBhcmUgc2tpcHBpbmcgYWxsb2NhdGluZyBsYXJnZSBmb2xpb3MgaW4gc2htZW0gaWYgc3dh
cCBpcw0KPiBlbmFibGVkIGluIHRoaXMgcGF0Y2guIFN3YXAgZG9lcyBub3Qgc3VwcG9ydCBzd2Fw
cGluZyBvdXQgbGFyZ2UgZm9saW9zDQo+IGFzIGEgd2hvbGUgKGV4Y2VwdCBUSFBzKSwgYnV0IHBh
Z2UgcmVjbGFpbSB3aWxsIHNwbGl0IHRob3NlIGxhcmdlDQo+IGZvbGlvcyBhbmQgc3dhcCB0aGVt
IG91dCBhcyBvcmRlci0wIHBhZ2VzIGFueXdheS4gU28gSSBhbSBub3Qgc3VyZSBJDQo+IHVuZGVy
c3RhbmQgd2h5IHdlIG5lZWQgdG8gc2tpcCBhbGxvY2F0aW5nIGxhcmdlIGZvbGlvcyBpZiBzd2Fw
IGlzDQo+IGVuYWJsZWQuDQoNCkkgbGlmdGVkIG5vc3dhcCBjb25kaXRpb24gYW5kIHJldGVzdGVk
IGl0IGFnYWluIG9uIHRvcCBvZiAyMzA5MTggYW5kDQp0aGVyZSBpcyBzb21lIHJlZ3Jlc3Npb24u
IFNvLCBiYXNlZCBvbiB0aGUgcmVzdWx0cyBJIGd1ZXNzIHRoZSBpbml0aWFsDQpyZXF1aXJlbWVu
dCBtYXkgYmUgdGhlIHdheSB0byBnby4gQnV0IHdoYXQgZG8geW91IHRoaW5rPw0KDQpIZXJlIHRo
ZSBsb2dzOg0KKiBzaG1lbS1sYXJnZS1mb2xpb3Mtc3dhcDogaHR0cHM6Ly9naXRsYWIuY29tLy0v
c25pcHBldHMvMzYwMDM2MA0KKiBzaG1lbS1iYXNlbGluZS1zd2FwIDogaHR0cHM6Ly9naXRsYWIu
Y29tLy0vc25pcHBldHMvMzYwMDM2Mg0KDQotRmFpbHVyZXM6IGdlbmVyaWMvMDgwIGdlbmVyaWMv
MTI2IGdlbmVyaWMvMTkzIGdlbmVyaWMvNjMzIGdlbmVyaWMvNjg5DQotRmFpbGVkIDUgb2YgNzMw
IHRlc3RzDQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUNCitGYWlsdXJlczogZ2VuZXJpYy8w
ODAgZ2VuZXJpYy8xMDMgZ2VuZXJpYy8xMjYgZ2VuZXJpYy8xOTMgZ2VuZXJpYy8yODUgZ2VuZXJp
Yy80MzYgZ2VuZXJpYy82MTkgZ2VuZXJpYy82MzMgZ2VuZXJpYy82ODkNCitGYWlsZWQgOSBvZiA3
MzAgdGVzdHMNClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPg0KPg0KPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdvbWV6IDxkYS5nb21lekBzYW1zdW5n
LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBtbS9zaG1lbS5jIHwgMTYgKysrKysrKysrKysr
Ky0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9tbS9zaG1lbS5jIGIvbW0vc2ht
ZW0uYw0KPiA+ID4gPiBpbmRleCBhZGZmNzQ3NTEwNjUuLjI2Y2E1NTViMTY2OSAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvbW0vc2htZW0uYw0KPiA+ID4gPiArKysgYi9tbS9zaG1lbS5jDQo+ID4gPiA+
IEBAIC0xNjgzLDEzICsxNjgzLDE5IEBAIHN0YXRpYyBzdHJ1Y3QgZm9saW8gKnNobWVtX2FsbG9j
X2ZvbGlvKGdmcF90IGdmcCwNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBz
dHJ1Y3QgZm9saW8gKnNobWVtX2FsbG9jX2FuZF9hY2N0X2ZvbGlvKGdmcF90IGdmcCwgc3RydWN0
IGlub2RlICppbm9kZSwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIHBnb2ZmX3QgaW5kZXgsIGJv
b2wgaHVnZSwgdW5zaWduZWQgaW50ICpvcmRlcikNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHBn
b2ZmX3QgaW5kZXgsIGJvb2wgaHVnZSwgdW5zaWduZWQgaW50ICpvcmRlciwNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHN0cnVjdCBzaG1lbV9zYl9pbmZvICpzYmluZm8pDQo+ID4gPiA+ICB7DQo+
ID4gPiA+ICAgICAgICAgc3RydWN0IHNobWVtX2lub2RlX2luZm8gKmluZm8gPSBTSE1FTV9JKGlu
b2RlKTsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgZm9saW8gKmZvbGlvOw0KPiA+ID4gPiAgICAg
ICAgIGludCBucjsNCj4gPiA+ID4gICAgICAgICBpbnQgZXJyOw0KPiA+ID4gPg0KPiA+ID4gPiAr
ICAgICAgIGlmICghc2JpbmZvLT5ub3N3YXApDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAqb3Jk
ZXIgPSAwOw0KPiA+ID4gPiArICAgICAgIGVsc2UNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICpv
cmRlciA9ICgqb3JkZXIgPT0gMSkgPyAwIDogKm9yZGVyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAg
ICAgICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRSkpDQo+ID4g
PiA+ICAgICAgICAgICAgICAgICBodWdlID0gZmFsc2U7DQo+ID4gPiA+ICAgICAgICAgbnIgPSBo
dWdlID8gSFBBR0VfUE1EX05SIDogMVUgPDwgKm9yZGVyOw0KPiA+ID4gPiBAQCAtMjAzMiw2ICsy
MDM4LDggQEAgc3RhdGljIGludCBzaG1lbV9nZXRfZm9saW9fZ2ZwKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHBnb2ZmX3QgaW5kZXgsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
PiA+ID4gICAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgb3JkZXIgPSBtYXBwaW5n
X3NpemVfb3JkZXIoaW5vZGUtPmlfbWFwcGluZywgaW5kZXgsIGxlbik7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gICAgICAgICBpZiAoIXNobWVtX2lzX2h1Z2UoaW5vZGUsIGluZGV4LCBmYWxzZSwNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdm1hID8gdm1hLT52bV9tbSA6IE5VTEws
IHZtYSA/IHZtYS0+dm1fZmxhZ3MgOiAwKSkNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8g
YWxsb2Nfbm9odWdlOw0KPiA+ID4gPiBAQCAtMjAzOSwxMSArMjA0NywxMSBAQCBzdGF0aWMgaW50
IHNobWVtX2dldF9mb2xpb19nZnAoc3RydWN0IGlub2RlICppbm9kZSwgcGdvZmZfdCBpbmRleCwN
Cj4gPiA+ID4gICAgICAgICBodWdlX2dmcCA9IHZtYV90aHBfZ2ZwX21hc2sodm1hKTsNCj4gPiA+
ID4gICAgICAgICBodWdlX2dmcCA9IGxpbWl0X2dmcF9tYXNrKGh1Z2VfZ2ZwLCBnZnApOw0KPiA+
ID4gPiAgICAgICAgIGZvbGlvID0gc2htZW1fYWxsb2NfYW5kX2FjY3RfZm9saW8oaHVnZV9nZnAs
IGlub2RlLCBpbmRleCwgdHJ1ZSwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZvcmRlcik7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmb3JkZXIsIHNiaW5mbyk7DQo+ID4gPiA+ICAgICAgICAgaWYg
KElTX0VSUihmb2xpbykpIHsNCj4gPiA+ID4gIGFsbG9jX25vaHVnZToNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIGZvbGlvID0gc2htZW1fYWxsb2NfYW5kX2FjY3RfZm9saW8oZ2ZwLCBpbm9kZSwg
aW5kZXgsIGZhbHNlLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmb3JkZXIpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmb3JkZXIsIHNiaW5mbyk7DQo+ID4gPiA+ICAg
ICAgICAgfQ0KPiA+ID4gPiAgICAgICAgIGlmIChJU19FUlIoZm9saW8pKSB7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICBpbnQgcmV0cnkgPSA1Ow0KPiA+ID4gPiBAQCAtMjE0Nyw2ICsyMTU1LDgg
QEAgc3RhdGljIGludCBzaG1lbV9nZXRfZm9saW9fZ2ZwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHBn
b2ZmX3QgaW5kZXgsDQo+ID4gPiA+ICAgICAgICAgaWYgKGZvbGlvX3Rlc3RfbGFyZ2UoZm9saW8p
KSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBmb2xpb191bmxvY2soZm9saW8pOw0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgZm9saW9fcHV0KGZvbGlvKTsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGlmIChvcmRlciA+IDApDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG9yZGVy
LS07DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBnb3RvIGFsbG9jX25vaHVnZTsNCj4gPiA+ID4g
ICAgICAgICB9DQo+ID4gPiA+ICB1bmxvY2s6DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzkuMg0K
PiA+ID4gPg==
