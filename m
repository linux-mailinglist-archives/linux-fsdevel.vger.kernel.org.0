Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886797A65D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjISN4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjISN4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:00 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40249F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:49 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135547euoutp01e6cf122666a9d610dec69512b5fbafb9~GUVfcfq-T3234632346euoutp01k
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230919135547euoutp01e6cf122666a9d610dec69512b5fbafb9~GUVfcfq-T3234632346euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131747;
        bh=9v/OznAy5MmB2I5X2K/60mpRUFXshyVhJcFQaJCZyNc=;
        h=From:To:CC:Subject:Date:References:From;
        b=IHIb+moZpaIaiVWh7/iDxg7NXKT9cC2T0hVOu8+ROcw8m5A4e+FhWkLUxi473YjNb
         P+bBDYbuoPlE5fh/frUyVMC+dMM45vEWfwMhpw8EzFXt6V1361FD89LJw5IsAruhWZ
         tZX/qvICpNYmEF8usbBwzwwc3Ml/RBD6qCjWYSbI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919135547eucas1p2471ffd018646e18cbfad7a2bfb288601~GUVfGZAK-2317523175eucas1p29;
        Tue, 19 Sep 2023 13:55:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.62.37758.268A9056; Tue, 19
        Sep 2023 14:55:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135546eucas1p1181b8914fb5eceda5f08068802941358~GUVeiqixj3130331303eucas1p1D;
        Tue, 19 Sep 2023 13:55:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919135546eusmtrp1e7f6f9d682d56461110c3554862a7a53~GUVeh_PHK2614026140eusmtrp18;
        Tue, 19 Sep 2023 13:55:46 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-ae-6509a86209e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.C9.10549.268A9056; Tue, 19
        Sep 2023 14:55:46 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230919135546eusmtip27a87e2a32ef039a9ba314ae6b8e9a02e~GUVeOjS683046630466eusmtip2H;
        Tue, 19 Sep 2023 13:55:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (106.1.227.72) by
        CAMSVWEXC02.scsc.local (106.1.227.72) with Microsoft SMTP Server (TLS) id
        15.0.1497.2; Tue, 19 Sep 2023 14:55:45 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:45 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "minchan@kernel.org" <minchan@kernel.org>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH v2 0/6] shmem: high order folios support in write path
Thread-Topic: [PATCH v2 0/6] shmem: high order folios support in write path
Thread-Index: AQHZ6wD7vvOcEXEs80eufkhxE90CMQ==
Date:   Tue, 19 Sep 2023 13:55:44 +0000
Message-ID: <20230919135536.2165715-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="utf-8"
Content-ID: <05AD81B6E53FB643B157C066403B7126@scsc.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djPc7rJKzhTDXqmMlvMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6MV4dnsRScUazYd+0gUwPjHYUuRk4OCQETid4nE1m7GLk4hARWMErsn7ecEcL5wiix
        ffV6KOczo8T54xOYYFrm774K1bKcUeLNtivscFVnVzWzgFQJCWxilFh8UREisZJR4vG6Bawg
        CTYBTYl9JzeBdYgIzGaVOLy4gxEkwSxQJ7Hm2SywbmEBN4k3S+Ywg9giAt4SPc3zGCFsPYnv
        jdvA4iwCqhIXNu1mA7F5Bawltp1YB7aAUUBW4tHKX+wQM8Ulbj2ZD3W3oMSi2XuYIWwxiX+7
        HrJB2DoSZ68/YYSwDSS2Lt3HAmErSfzpWAgU5wCaoymxfpc+xEhLiY0XTjJB2IoSU7ofskOc
        IChxcuYTFpC/JAR+cUrsuvuUHWKOi8TK/VOhZgpLvDq+BSouI3F6cg/LBEbtWUhOnYWwbhaS
        dbOQrJuFZN0CRtZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgSnv9L/jX3cwrnj1Ue8Q
        IxMH4yFGCQ5mJRHemYZsqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphak
        FsFkmTg4pRqYcjcs6Kjm7ny4RffqtXo76+oFofmfrRdO+BOz12/K+oiNGeb28ZHaAfvmRN3/
        b1gYPW3lFK49E2JnXDX4Ib2FNyuNfbXK1gUK+qkFFjtPcKRxN6x4ff9T2eOrsza0fvkQzx/3
        nS9NuXTnri1VwU52pzWcMzU7OFWTjFfPMJ6U0pOQuH3xCr2ujbuD1yisFuy/kfhc5qvO7rkq
        f4IrFys47r5pw/fh+a6krOw3GcUZe4ruKvdPireZ9mdjn1jknEdHV/b8+cgmX2ndv6Wibtau
        98mBi+ZzSK7LFb93yU5AuyzI1OLUoaXWqdfUJ748ejMk7dzqP1mO9X3GV7Y8178yQypx0u7i
        lc8jDBv+Ky0WVGIpzkg01GIuKk4EAPF7SPLoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xe7pJKzhTDR49kbGYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZrw7PYik4o1ix79pB
        pgbGOwpdjJwcEgImEvN3X2XtYuTiEBJYyigx4/ojVoiEjMTGL1ehbGGJP9e62CCKPgIVLbrG
        COFsYpT4df0jlLOSUeLCsUtMIC1sApoS+05uYgdJiAjMZpU4vLiDESTBLFAnsebZLBYQW1jA
        TeLNkjnMILaIgLdET/M8RghbT+J74zawOIuAqsSFTbvZQGxeAWuJbSfWgd3EKCAr8WjlL3aI
        meISt57MZ4K4VUBiyZ7zzBC2qMTLx/+gftCROHv9CSOEbSCxdek+FghbSeJPx0KgOAfQHE2J
        9bv0IUZaSmy8cJIJwlaUmNL9kB3iBEGJkzOfsExglJqFZPMshO5ZSLpnIemehaR7ASPrKkaR
        1NLi3PTcYkO94sTc4tK8dL3k/NxNjMD0tO3Yz807GOe9+qh3iJGJg/EQowQHs5II70xDtlQh
        3pTEyqrUovz4otKc1OJDjKbAEJrILCWanA9MkHkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLp
        iSWp2ampBalFMH1MHJxSDUxxMdeMvk6r6jU9x+k5MUckUeHWvCy1T04lLjMnJT4oC4gub/jk
        OW1Z/2fHk2cf7WUtk8t7Z+LE7DL7wa+dyoJhXh+8z20wXebRHaO09POFJ3IaWS+EDW6fuvj5
        T1Sb9cWtmTn5hvW95bKlL5qmcj5lkE+S7Gv2Xdlx/n217vuMzRLLzrL4L+D/eJnljWTfjTmH
        zmk7zyzg8L7MWRATxLbnx9dc+2qDW73iIqzM80XFjwSsZI26XHJpbeEaJfv7/Q/k7l99bDDJ
        aMettys8P78PP7nASnym6rTw33dCTuW18ui0vNm4nP/KinYFPg+Dzhm80bv03yp8saibmdl4
        88C6Izd/qhucbexRavrPcF6JpTgj0VCLuag4EQD68OTM2AMAAA==
X-CMS-MailID: 20230919135546eucas1p1181b8914fb5eceda5f08068802941358
X-Msg-Generator: CA
X-RootMTR: 20230919135546eucas1p1181b8914fb5eceda5f08068802941358
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135546eucas1p1181b8914fb5eceda5f08068802941358
References: <CGME20230919135546eucas1p1181b8914fb5eceda5f08068802941358@eucas1p1.samsung.com>
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

VGhpcyBzZXJpZXMgYWRkIHN1cHBvcnQgZm9yIGhpZ2ggb3JkZXIgZm9saW9zIGluIHNobWVtIHdy
aXRlDQpwYXRoIHdoZW4gc3dhcCBpcyBkaXNhYmxlZCAobm9zd2FwIG9wdGlvbikuIFRoaXMgaXMg
cGFydCBvZiB0aGUgTGFyZ2UNCkJsb2NrIFNpemUgKExCUykgZWZmb3J0IFsxXVsyXSBhbmQgYSBj
b250aW51YXRpb24gb2YgdGhlIHNobWVtIHdvcmsNCmZyb20gTHVpcyBoZXJlIFszXSBmb2xsb3dp
bmcgTWF0dGhldyBXaWxjb3gncyBzdWdnZXN0aW9uIFs0XSByZWdhcmRpbmcNCnRoZSBwYXRoIHRv
IHRha2UgZm9yIHRoZSBmb2xpbyBhbGxvY2F0aW9uIG9yZGVyIGNhbGN1bGF0aW9uLg0KDQpbMV0g
aHR0cHM6Ly9rZXJuZWxuZXdiaWVzLm9yZy9LZXJuZWxQcm9qZWN0cy9sYXJnZS1ibG9jay1zaXpl
DQpbMl0gaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vc3ByZWFkc2hlZXRzL2QvZS8yUEFDWC0xdlM3
c1FmdzkwUzAwbDJyZk9LbTgzSmxnMHB4OEt4TVFFNEhIcF9ES1JHYkFHY0FWLXh1NkxJVEhCRWM0
eHpWaDl3TEg2V00ybFIwY1pTOC9wdWJodG1sIw0KWzNdIFJGQyB2MiBhZGQgc3VwcG9ydCBmb3Ig
YmxvY2tzaXplID4gUEFHRV9TSVpFDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWkhCb3dN
RURmeXJBQU9XSEBib21iYWRpbC5pbmZyYWRlYWQub3JnL1QvI21kM2U5M2FiNDZjZTJhZDkyNTRl
MWViNTRmZmU3MTIxMTk4OGI1NjMyDQpbNF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pI
RDl6bUllTlhJQ0RhUkpAY2FzcGVyLmluZnJhZGVhZC5vcmcvDQoNCmZzeCBhbmQgZnN0ZXN0cyBo
YXMgYmVlbiBwZXJmb3JtZWQgb24gdG1wZnMgd2l0aCBub3N3YXAgd2l0aCB0aGUNCmZvbGxvd2lu
ZyByZXN1bHRzOg0KVjI6DQotIGZzeDogNCw5Qg0KLSBmc3Rlc3RzOiBTYW1lIHJlc3VsdCBhcyBi
YXNlbGluZSBmb3IgbmV4dC0yMzA5MTguDQpWMToNCi0gZnN4OiAyZCB0ZXN0LCAyMSw1Qg0KLSBm
c3Rlc3RzOiBTYW1lIHJlc3VsdCBhcyBiYXNlbGluZSBmb3IgbmV4dC0yMzA5MTEgWzNdWzRdWzVd
DQoNClBhdGNoZXMgaGF2ZSBiZWVuIHRlc3RlZCBhbmQgc2VudCBmcm9tIG5leHQtMjMwOTE4Lg0K
DQpbM10gQmFzZWxpbmUgbmV4dC0yMzA5MTEgZmFpbHVyZXMgYXJlOiBnZW5lcmljLzA4MCBnZW5l
cmljLzEyNg0KZ2VuZXJpYy8xOTMgZ2VuZXJpYy82MzMgZ2VuZXJpYy82ODkNCls0XSBmc3Rlc3Rz
IGxvZ3MgYmFzZWxpbmU6IGh0dHBzOi8vZ2l0bGFiLmNvbS8tL3NuaXBwZXRzLzM1OTg2MjENCls1
XSBmc3Rlc3RzIGxvZ3MgcGF0Y2hlczogaHR0cHM6Ly9naXRsYWIuY29tLy0vc25pcHBldHMvMzU5
ODYyOA0KDQpOb3RlOiBiZWNhdXNlIG9mIG5leHQtMjMwOTE4IHJlZ3Jlc3Npb24gaW4gcm1hcCwg
cGF0Y2ggWzhdIGFwcGxpZWQuDQoNCls4XSAyMDIzMDkxODE1MTcyOS41QTFGNEMzMjc5NkBzbXRw
Lmtlcm5lbC5vcmcNCg0KRGFuaWVsDQoNCkNoYW5nZXMgc2luY2UgdjENCiogT3JkZXIgaGFuZGxp
bmcgY29kZSBzaW1wbGlmaWVkIGluIHNobWVtX2dldF9mb2xpb19nZnAgYWZ0ZXIgTWF0dGhldyBX
aWxsY294J3MNCnJldmlldy4NCiogRHJvcCBwYXRjaCAxLzYgWzZdIGFuZCBtZXJnZSBtYXBwaW5n
X3NpemVfb3JkZXIgY29kZSBkaXJlY3RseSBpbiBzaG1lbS4NCiogQWRkZWQgTUFYX1NITUVNX09S
REVSIHRvIG1ha2UgaXQgZXhwbGljaXQgd2UgZG9uJ3QgaGF2ZSB0aGUgc2FtZSBtYXggb3JkZXIg
YXMNCmluIHBhZ2VjYWNoZSAoTUFYX1BBR0VDQUNIRV9PUkRFUikuDQoqIFVzZSBIUEFHRV9QTURf
T1JERVItMSBhcyBNQVhfU0hNRU1fT1JERVIgdG8gcmVzcGVjdCBodWdlIG1vdW50IG9wdGlvbi4N
CiogVXBkYXRlIGNvdmVyIGxldHRlcjogZHJvcCBodWdlIHN0cmF0ZWd5IHF1ZXN0aW9uIGFuZCBh
ZGQgbW9yZSBjb250ZXh0IHJlZ2FyZGluZw0KTEJTIHByb2plY3QuIEFkZCBmc3ggYW5kIGZzdGVz
dHMgc3VtbWFyeSB3aXRoIG5ldyBiYXNlbGluZS4NCiogQWRkIGZpeGVzIGZvdW5kIGJ5IE1hdHRo
ZXcgaW4gcGF0Y2ggMy82IFs3XS4NCiogRml4IGxlbmd0aCAoaV9zaXplX3JlYWQgLT4gUEFHRV9T
SVpFKSB0aGF0IGlzIHBhc3NlZCB0byBzaG1lbV9nZXRfZm9saW9fZ2ZwIGluDQpzaG1lbV9mYXVs
dCBhbmQgc2htZW1fcmVhZF9mb2xpb19nZnAgdG8gUEFHRV9TSVpFLg0KKiBBZGQgcGF0Y2ggYXMg
c3VnZ2VzdGVkIGJ5IE1hdHRoZXcgdG8gcmV0dXJuIHRoZSBudW1iZXIgb2YgcGFnZXMgZnJlZWQg
aW4NCnNobWVtX2ZyZWVfc3dhcCAoaW5zdGVhZCBvZiBlcnJubykuIFdoZW4gbm8gcGFnZXMgYXJl
IGZyZWVkLCByZXR1cm4gMCAocGFnZXMpLg0KTm90ZTogQXMgYW4gYWx0ZXJuYXRpdmUsIHdlIGNh
biBlbWJlZCAtRU5PRU5UIGFuZCBtYWtlIHVzZSBvZiBJU19FUlJfVkFMVUUuDQpBcHByb2FjaCBk
aXNjYXJkZWQgYmVjYXVzZSBsaXR0bGUgdmFsdWUgd2FzIGFkZGVkLiBJZiB0aGlzIG1ldGhvZCBp
cyBwcmVmZXJyZWQsDQpwbGVhc2UgbGV0IGRpc2N1c3MgaXQuDQoNCls2XSBmaWxlbWFwOiBtYWtl
IHRoZSBmb2xpbyBvcmRlciBjYWxjdWxhdGlvbiBzaGFyZWFibGUNCls3XSBzaG1lbTogYWNjb3Vu
dCBmb3IgbGFyZ2Ugb3JkZXIgZm9saW9zDQoNCkRhbmllbCBHb21leiAoNSk6DQogIHNobWVtOiBk
cm9wIEJMT0NLU19QRVJfUEFHRSBtYWNybw0KICBzaG1lbTogcmV0dXJuIGZyZWVkIHBhZ2VzIGlu
IHNobWVtX2ZyZWVfc3dhcA0KICBzaG1lbTogYWRkIG9yZGVyIHBhcmFtZXRlciBzdXBwb3J0IHRv
IHNobWVtX2FsbG9jX2ZvbGlvDQogIHNobWVtOiBhZGQgZmlsZSBsZW5ndGggaW4gc2htZW1fZ2V0
X2ZvbGlvIHBhdGgNCiAgc2htZW06IGFkZCBsYXJnZSBmb2xpb3Mgc3VwcG9ydCB0byB0aGUgd3Jp
dGUgcGF0aA0KDQpMdWlzIENoYW1iZXJsYWluICgxKToNCiAgc2htZW06IGFjY291bnQgZm9yIGxh
cmdlIG9yZGVyIGZvbGlvcw0KDQogaW5jbHVkZS9saW51eC9zaG1lbV9mcy5oIHwgICAyICstDQog
bW0va2h1Z2VwYWdlZC5jICAgICAgICAgIHwgICAyICstDQogbW0vc2htZW0uYyAgICAgICAgICAg
ICAgIHwgMTQxICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIDMgZmls
ZXMgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pDQoNCi0tDQoyLjM5
LjINCg==
