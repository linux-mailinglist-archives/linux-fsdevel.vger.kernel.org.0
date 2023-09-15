Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857AA7A1B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjIOJxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOJw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:52:57 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2F44B8
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:51:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095123euoutp020b936287c7c3ec53c331ba838d56b568~FCa91QMix1141011410euoutp02S
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230915095123euoutp020b936287c7c3ec53c331ba838d56b568~FCa91QMix1141011410euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771484;
        bh=61KnDRJU/j6QIo81EkB+a0KV6D1jLBR/V3dxKwGeaXU=;
        h=From:To:CC:Subject:Date:References:From;
        b=XAt8KxOcepm9nH+PG81KQeEa/IFusoIoSdVDa3OqNQGR/bJCd3L4wKW7r7D231e/e
         bbjfJIBLda/sque+B36Jds9ADh8my6TBI+2MP9Gjb0IRfXxG7FQUlpkKo0PZ598eYK
         wwmXf74FvAGm3GVHlNDGO8OMIjyOrnNpcV/5iYb8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230915095123eucas1p28eae7088346eb545abab7f81291874c3~FCa9eGfcx2793727937eucas1p24;
        Fri, 15 Sep 2023 09:51:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 74.E7.11320.B1924056; Fri, 15
        Sep 2023 10:51:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a~FCa88M9fy1725217252eucas1p2x;
        Fri, 15 Sep 2023 09:51:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230915095122eusmtrp277016db842bf3caef7297f1208ae9efb~FCa87Yo4W1712217122eusmtrp2u;
        Fri, 15 Sep 2023 09:51:22 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-19-6504291bd619
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.2B.10549.A1924056; Fri, 15
        Sep 2023 10:51:22 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095122eusmtip287aab534de93e815592999a65d29fa78~FCa8w4py91112711127eusmtip2z;
        Fri, 15 Sep 2023 09:51:22 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:22 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:22 +0100
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
Subject: [PATCH 0/6] shmem: high order folios support in write path
Thread-Topic: [PATCH 0/6] shmem: high order folios support in write path
Thread-Index: AQHZ57ou5Qxd50H2CkCAi/G4rRLLzQ==
Date:   Fri, 15 Sep 2023 09:51:21 +0000
Message-ID: <20230915095042.1320180-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2175A30A7CB61244BB755A21411698ED@scsc.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87rSmiypBnsvSFnMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6M1+tWMRVcEK3o2X2BrYGxQ7SLkZNDQsBEYvfkxUxdjFwcQgIrGCV6lt5jg3C+MEp8
        2jkXyvnMKHH30gF2mJbbF9pZIBLLGSWeXdvPAle169dPdgjnDKPEgUmNzBDOSkaJmQc7WUH6
        2QQ0Jfad3ARWJSIwm1Xi8OIORpAEs0CdxJpns1hAbGEBZ4ljPXvBFooIeEgcnDiFFcLWk/h5
        4gcbiM0ioCrRu3E+WD2vgLXE/pt7weKMArISj1b+YoeYKS5x68l8JojDBSUWzd7DDGGLSfzb
        9ZANwtaROHv9CSOEbSCxdek+FghbSeJPx0KgOAfQHE2J9bv0IUZaSsy+uZMFwlaUmNL9kB3i
        BEGJkzOfgINCQuAXp8S5mcegdrlI3Fl6A2q+sMSr41ugASkj8X/nfKYJjNqzkJw6C2HdLCTr
        ZiFZNwvJugWMrKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECk97pf8e/7GBc/uqj3iFG
        Jg7GQ4wSHMxKIrxstkypQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQW
        wWSZODilGpgi0y4kcx381Xpge1a2yc+F006+071tzvFc923ZMa4TBRX16yzdK5p1dx48uvuP
        rpjP7HaJxC8VfK8tlTWn+aa9/Po6i69htt+Vvrv+jhlpZY/Oz1sjs0ecdeWZsAk5/zSrVzVw
        brFMv7dTan3rgR1lFW85Or1qlwUYJGiuzNB3WcMtmWTwIeifo2fUpMpT04P/1V+5Iq4uZyxT
        W7KnWGKn2yZbxTOfmDwrD5xc/f3T9I/vDGsObX8j/s6zekbi7UMf3tm6n1QrcJhR+eWgpZxS
        85m2F/sNvt0Nip1od0n9sdvJQFXR9A8LHh1zzG9sua/+KXnWvdJapwlvo4NZA2q8zU4y5Vlv
        Y2mW8l2+5KQSS3FGoqEWc1FxIgD/Ko+J6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xe7pSmiypBmffWljMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M1+tWMRVcEK3o2X2B
        rYGxQ7SLkZNDQsBE4vaFdpYuRi4OIYGljBLr76xkgUjISGz8cpUVwhaW+HOtiw2i6COjRNvU
        JYwQzhlGiad9a5khnJWMEvuWHWYDaWET0JTYd3ITO0hCRGA2q8ThxR2MIAlmgTqJNc9mge0Q
        FnCWONazlx3EFhHwkDg4cQorhK0n8fPED7BBLAKqEr0b54PV8wpYS+y/uRcsziggK/Fo5S92
        iJniEreezGeCuFVAYsme88wQtqjEy8f/oH7QkTh7/QkjhG0gsXXpPqg/lST+dCwEinMAzdGU
        WL9LH2KkpcTsmztZIGxFiSndD9khThCUODnzCcsERqlZSDbPQuiehaR7FpLuWUi6FzCyrmIU
        SS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMT9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8LLZMqUK
        8aYkVlalFuXHF5XmpBYfYjQFhtBEZinR5HxggswriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
        TyxJzU5NLUgtgulj4uCUamAKOxnHKukm475RyP7ZmsNbrjuJ7W/Y617xZmlodO7Mtne3fDvv
        rBV+dHvvhZMh7E+XzT1u271RLfOxSZGyW1Dp3skCD7/OeSqZ8uKIV9aEEr/zpgcnR/76NGvJ
        36Wx3vMSjN8I3r17Sun//K2yItLMJcGbQ4QnPxe9V8IdIJ95xqNFMd0y5YGm4+l85Umph3nq
        C89c4ffedmFCRkWLoK50IPfEz/sk/S5ff2DcKZn45NOswGzlrsfXd+vdnax+jktHJzH9w+oC
        lwofzV/m2Q94l3vM27RU/gDT19//pyjkZ2dd3dl8oebxdra9gkvTwxSe9x/Q2/vliM8c3b8i
        2suDcs9zSTgImF/P3ZTeZz1BiaU4I9FQi7moOBEAuIVg49gDAAA=
X-CMS-MailID: 20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a
X-Msg-Generator: CA
X-RootMTR: 20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkIHN1cHBvcnQgZm9yIGhpZ2ggb3JkZXIgZm9saW9zIGluIHNobWVtIHdy
aXRlDQpwYXRoLg0KDQpUaGlzIGlzIGEgY29udGludWF0aW9uIG9mIHRoZSBzaG1lbSB3b3JrIGZy
b20gTHVpcyBoZXJlIFsxXQ0KZm9sbG93aW5nIE1hdHRoZXcgV2lsY294J3Mgc3VnZ2VzdGlvbiBb
Ml0gcmVnYXJkaW5nIHRoZSBwYXRoIHRvIHRha2UNCmZvciB0aGUgZm9saW8gYWxsb2NhdGlvbiBv
cmRlciBjYWxjdWxhdGlvbi4NCg0KWzFdIFJGQyB2MiBhZGQgc3VwcG9ydCBmb3IgYmxvY2tzaXpl
ID4gUEFHRV9TSVpFDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWkhCb3dNRURmeXJBQU9X
SEBib21iYWRpbC5pbmZyYWRlYWQub3JnL1QvI21kM2U5M2FiNDZjZTJhZDkyNTRlMWViNTRmZmU3
MTIxMTk4OGI1NjMyDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pIRDl6bUllTlhJ
Q0RhUkpAY2FzcGVyLmluZnJhZGVhZC5vcmcvDQoNClBhdGNoZXMgaGF2ZSBiZWVuIHRlc3RlZCBh
bmQgc2VudCBmcm9tIG5leHQtMjMwOTExLiBUaGV5IGRvIGFwcGx5DQpjbGVhbmx5IHRvIHRoZSBs
YXRlc3QgbmV4dC0yMzA5MTQuDQoNCmZzeCBhbmQgZnN0ZXN0cyBoYXMgYmVlbiBwZXJmb3JtZWQg
b24gdG1wZnMgd2l0aCBub3N3YXAgd2l0aCB0aGUNCmZvbGxvd2luZyByZXN1bHRzOg0KLSBmc3g6
IDJkIHRlc3QsIDIxLDVCDQotIGZzdGVzdHM6IFNhbWUgcmVzdWx0IGFzIGJhc2VsaW5lIGZvciBu
ZXh0LTIzMDkxMSBbM11bNF1bNV0NCg0KWzNdIEJhc2VsaW5lIG5leHQtMjMwOTExIGZhaWx1cmVz
IGFyZTogZ2VuZXJpYy8wODAgZ2VuZXJpYy8xMjYNCmdlbmVyaWMvMTkzIGdlbmVyaWMvNjMzIGdl
bmVyaWMvNjg5DQpbNF0gZnN0ZXN0cyBsb2dzIGJhc2VsaW5lOiBodHRwczovL2dpdGxhYi5jb20v
LS9zbmlwcGV0cy8zNTk4NjIxDQpbNV0gZnN0ZXN0cyBsb2dzIHBhdGNoZXM6IGh0dHBzOi8vZ2l0
bGFiLmNvbS8tL3NuaXBwZXRzLzM1OTg2MjgNCg0KVGhlcmUgYXJlIGF0IGxlYXN0IDIgY2FzZXMv
dG9waWNzIHRvIGhhbmRsZSB0aGF0IEknZCBhcHByZWNpYXRlDQpmZWVkYmFjay4NCjEuIFdpdGgg
dGhlIG5ldyBzdHJhdGVneSwgeW91IG1pZ2h0IGVuZCB1cCB3aXRoIGEgZm9saW8gb3JkZXIgbWF0
Y2hpbmcNCkhQQUdFX1BNRF9PUkRFUi4gSG93ZXZlciwgd2Ugd29uJ3QgcmVzcGVjdCB0aGUgJ2h1
Z2UnIGZsYWcgYW55bW9yZSBpZg0KVEhQIGlzIGVuYWJsZWQuDQoyLiBXaGVuIHRoZSBhYm92ZSAo
MS4pIG9jY3VycywgdGhlIGNvZGUgc2tpcHMgdGhlIGh1Z2UgcGF0aCwgc28NCnhhX2ZpbmQgd2l0
aCBoaW5kZXggaXMgc2tpcHBlZC4NCg0KRGFuaWVsDQoNCkRhbmllbCBHb21leiAoNSk6DQogIGZp
bGVtYXA6IG1ha2UgdGhlIGZvbGlvIG9yZGVyIGNhbGN1bGF0aW9uIHNoYXJlYWJsZQ0KICBzaG1l
bTogZHJvcCBCTE9DS1NfUEVSX1BBR0UgbWFjcm8NCiAgc2htZW06IGFkZCBvcmRlciBwYXJhbWV0
ZXIgc3VwcG9ydCB0byBzaG1lbV9hbGxvY19mb2xpbw0KICBzaG1lbTogYWRkIGZpbGUgbGVuZ3Ro
IGluIHNobWVtX2dldF9mb2xpbyBwYXRoDQogIHNobWVtOiBhZGQgbGFyZ2UgZm9saW9zIHN1cHBv
cnQgdG8gdGhlIHdyaXRlIHBhdGgNCg0KTHVpcyBDaGFtYmVybGFpbiAoMSk6DQogIHNobWVtOiBh
Y2NvdW50IGZvciBsYXJnZSBvcmRlciBmb2xpb3MNCg0KIGZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMg
ICB8ICA2ICsrLQ0KIGluY2x1ZGUvbGludXgvcGFnZW1hcC5oICB8IDQyICsrKysrKysrKysrKysr
KystLS0NCiBpbmNsdWRlL2xpbnV4L3NobWVtX2ZzLmggfCAgMiArLQ0KIG1tL2ZpbGVtYXAuYyAg
ICAgICAgICAgICB8ICA4IC0tLS0NCiBtbS9raHVnZXBhZ2VkLmMgICAgICAgICAgfCAgMiArLQ0K
IG1tL3NobWVtLmMgICAgICAgICAgICAgICB8IDkxICsrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0NCiA2IGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA1MSBk
ZWxldGlvbnMoLSkNCg0KLS0NCjIuMzkuMg0K
