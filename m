Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940B7A43C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjIRICN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 04:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbjIRIBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:01:44 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0608129
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 01:00:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230918080015euoutp021f35d1aafcd6b1bf0750fa92dc1c115b~F71xsje2w2403524035euoutp02i
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:00:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230918080015euoutp021f35d1aafcd6b1bf0750fa92dc1c115b~F71xsje2w2403524035euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695024015;
        bh=ST7WfRxIJRj9DBrOFg+G9mJVDRWPXAjPfoEoFxX93/Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UIsoI9ysNX/MTGxLeJ0MHNeBYbm1Tsayazxc470TbDjEWceR5P5i5LwWuiiHHmKHo
         aVAbDztVR35F966FfPrsOi/TmYHIcOXAWO0BxVW6fB7NZMzSTMic83iIiSfsanp95X
         1cSdXXkIGhI2yvpbwbA+vRu0NYKPmiwr+J/1d+Fs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230918080013eucas1p10b3b7fb702ca09bfd1b6156d8dcd0c0b~F71wuVorQ2746627466eucas1p1z;
        Mon, 18 Sep 2023 08:00:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.C7.37758.D8308056; Mon, 18
        Sep 2023 09:00:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230918080013eucas1p22a216a10e484b35cf3a9a08a2184907c~F71wRjBVq2676826768eucas1p2K;
        Mon, 18 Sep 2023 08:00:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230918080013eusmtrp26948539755a9dc02b75c39dd4042fdd9~F71wQImsk1585615856eusmtrp2n;
        Mon, 18 Sep 2023 08:00:13 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-1b-6508038d95a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.BD.14344.D8308056; Mon, 18
        Sep 2023 09:00:13 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230918080013eusmtip2d26e89ae27c0e0f3e00c1342d0d922ea~F71wBjwws0119701197eusmtip2G;
        Mon, 18 Sep 2023 08:00:13 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Mon, 18 Sep 2023 09:00:12 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 18 Sep
        2023 09:00:12 +0100
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
Thread-Index: AQHZ57o0gOj42/h7V0WVSDdaHJaWqLAcJBuAgAQHWgA=
Date:   Mon, 18 Sep 2023 08:00:12 +0000
Message-ID: <20230918075758.vlufrhq22es2dhuu@sarkhan>
In-Reply-To: <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9701CA5454931F4A96B7D3DA91723B0D@scsc.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87q9zBypBq2PzSzmrF/DZrH6bj+b
        xeUnfBZPP/WxWOy9pW2xZ+9JFovLu+awWdxb85/VYtefHewWNyY8ZbRY9vU9u8XujYvYLH7/
        AMpu3xXpwOcxu+Eii8eCTaUem1doeVw+W+qxaVUnm8emT5PYPU7M+M3i8XmTXABHFJdNSmpO
        Zllqkb5dAlfGr5UH2Aue6FbM7W1maWA8o9PFyMkhIWAi8fTVD+YuRi4OIYEVjBJvmteyQzhf
        GCX6Wv+yQTifGSU+PpsJ5HCAtRw7bQ4RX84oMW/eWhaQUWBFP1cqQSTOMEr86Z3DCuGsZJR4
        0LoZrIpNQFNi38lN7CC2iIC6xNw1mxhBbGaBL6wSXzcEgdjCAl4S6+fcYYao8ZZ4sXMJG4Rt
        JXF3/QMwm0VAVWLtzq9gM3kFTCXWf7jDCmJzCgRK7N5zCCzOKCAr8WjlL3aI+eISt57MZ4J4
        WlBi0ew9zBC2mMS/XQ/ZIGwdibPXnzBC2AYSW5fuY4GwlST+dCxkBPmeGej+9bv0IUZaSrxt
        2Qs1XlFiSvdDdohzBCVOznzCAvK7hMBMLoneZQuh5rtIXOw7DDVTWOLV8S3sExh1ZiE5bxbC
        illIVsxCsmIWkhULGFlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKa90/+Of93BuOLV
        R71DjEwcjIcYJTiYlUR4ZxqypQrxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5Ykpqd
        mlqQWgSTZeLglGpgMuHx+6Ow3/42d0iIcWXLrLBzRfe+cmxguD2t4674m5+X8oIqt7zT1Tvj
        sO365g6jHxq6Ej4+wUs4vx/edV1u1SHRz1185/5eW17HfSlT/8SEeqULEX2CXxdpC06cwOBw
        8uKljsoLaqF51yxlOqZOV138j4fnfsPUt1L/DletqdW47Hpt/3e3tod7r3flVx939T5pOKO+
        ukW9dW6liZ7blOUW7v4KZRLLjFcePdp7SP2gQ79WYeii1585bSqa1ukKqbIfOMB2TvxtDov+
        kgKGZ7fSr+1Z2rTFNtvk/Mu4h1GLY70uVvw0PDPX7K5C9aMW8/1uJty7ZBJuzla/ePNmbU5k
        XEHbWUfBTIeSk1o8SizFGYmGWsxFxYkAAz4yIeoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsVy+t/xe7q9zBypBv++i1nMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        AZTdvivSgc9jdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzS
        klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MXysPsBc80a2Y
        29vM0sB4RqeLkYNDQsBE4thp8y5GLg4hgaWMEr1ndzB1MXICxWUkNn65ygphC0v8udbFBlH0
        kVHi7b/bzBDOGUaJ96cesEA4KxklnvdtYQNpYRPQlNh3chM7iC0ioC4xd80mRhCbWeALq8TX
        DUEgtrCAl8T6OXeYIWq8JV7sXMIGYVtJ3F3/AMxmEVCVWLvzKwuIzStgKrH+wx2wk4QEOpgk
        dr0Hm8kpECixe88hsBpGAVmJRyt/sUPsEpe49WQ+1DsCEkv2nGeGsEUlXj7+B/WajsTZ608Y
        IWwDia1L97FA2EoSfzoWMoKCiBnol/W79CFGWkq8bdkLNV5RYkr3Q3aI0wQlTs58wjKBUWYW
        ks2zELpnIemehaR7FpLuBYysqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJT2rZjP7fsYFz5
        6qPeIUYmDsZDjBIczEoivDMN2VKFeFMSK6tSi/Lji0pzUosPMZoCQ24is5Rocj4wqeaVxBua
        GZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTDpa3c0K0y17BMO/+4tffrc
        ZIPi6e0q+ddnK026wt8lOfnpz16/L2Gb+dsKnd6L7zLNDCw94DG3tWG63qsAhnrt0l35l2yP
        9Zuas5v01jT0zsrdrpl3cMq+bI/0B8bampu47e6cFPCLfu9ULuPKUbuo+lDOabHC9v9pp5nm
        5unlfTm+rGDJWoZTM3teT3Lpu9U11WDV187Vh/fW/wvLPX055FhHTv30w9K++5Sn8yp0Fl7P
        Etqs2p3l0vL7caOa48uQPYfV3wVmXLpsH+j99v6vo3LZ98w//WtgMd1/TfG3KJdG47bqm+o7
        59nWlzGJ7PQ+MuF/YFut9eanG1VWlB+K/iS360nk3b8/OLp8zyqxFGckGmoxFxUnAgBkVr0H
        8gMAAA==
X-CMS-MailID: 20230918080013eucas1p22a216a10e484b35cf3a9a08a2184907c
X-Msg-Generator: CA
X-RootMTR: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
        <20230915095042.1320180-1-da.gomez@samsung.com>
        <20230915095042.1320180-7-da.gomez@samsung.com>
        <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCBTZXAgMTUsIDIwMjMgYXQgMTE6MjY6MzdBTSAtMDcwMCwgWW9zcnkgQWhtZWQgd3Jv
dGU6DQo+IE9uIEZyaSwgU2VwIDE1LCAyMDIzIGF0IDI6NTHigK9BTSBEYW5pZWwgR29tZXogPGRh
LmdvbWV6QHNhbXN1bmcuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBsYXJnZSBmb2xpbyBzdXBw
b3J0IGZvciBzaG1lbSB3cml0ZSBwYXRoIG1hdGNoaW5nIHRoZSBzYW1lIGhpZ2gNCj4gPiBvcmRl
ciBwcmVmZXJlbmNlIG1lY2hhbmlzbSB1c2VkIGZvciBpb21hcCBidWZmZXJlZCBJTyBwYXRoIGFz
IHVzZWQgaW4NCj4gPiBfX2ZpbGVtYXBfZ2V0X2ZvbGlvKCkuDQo+ID4NCj4gPiBVc2UgdGhlIF9f
Zm9saW9fZ2V0X21heF9vcmRlciB0byBnZXQgYSBoaW50IGZvciB0aGUgb3JkZXIgb2YgdGhlIGZv
bGlvDQo+ID4gYmFzZWQgb24gZmlsZSBzaXplIHdoaWNoIHRha2VzIGNhcmUgb2YgdGhlIG1hcHBp
bmcgcmVxdWlyZW1lbnRzLg0KPiA+DQo+ID4gU3dhcCBkb2VzIG5vdCBzdXBwb3J0IGhpZ2ggb3Jk
ZXIgZm9saW9zIGZvciBub3csIHNvIG1ha2UgaXQgb3JkZXIgMCBpbg0KPiA+IGNhc2Ugc3dhcCBp
cyBlbmFibGVkLg0KPg0KPiBJIGRpZG4ndCB0YWtlIGEgY2xvc2UgbG9vayBhdCB0aGUgc2VyaWVz
LCBidXQgSSBhbSBub3Qgc3VyZSBJDQo+IHVuZGVyc3RhbmQgdGhlIHJhdGlvbmFsZSBoZXJlLiBS
ZWNsYWltIHdpbGwgc3BsaXQgaGlnaCBvcmRlciBzaG1lbQ0KPiBmb2xpb3MgYW55d2F5LCByaWdo
dD8NCg0KRm9yIGNvbnRleHQsIHRoaXMgaXMgcGFydCBvZiB0aGUgZW5hYmxlbWVudCBvZiBsYXJn
ZSBibG9jayBzaXplcyAoTEJTKQ0KZWZmb3J0IFsxXVsyXVszXSwgc28gdGhlIGFzc3VtcHRpb24g
aGVyZSBpcyB0aGF0IHRoZSBrZXJuZWwgd2lsbA0KcmVjbGFpbSBtZW1vcnkgd2l0aCB0aGUgc2Ft
ZSAobGFyZ2UpIGJsb2NrIHNpemVzIHRoYXQgd2VyZSB3cml0dGVuIHRvDQp0aGUgZGV2aWNlLg0K
DQpJJ2xsIGFkZCBtb3JlIGNvbnRleHQgaW4gdGhlIFYyLg0KDQpbMV0gaHR0cHM6Ly9rZXJuZWxu
ZXdiaWVzLm9yZy9LZXJuZWxQcm9qZWN0cy9sYXJnZS1ibG9jay1zaXplDQpbMl0gaHR0cHM6Ly9k
b2NzLmdvb2dsZS5jb20vc3ByZWFkc2hlZXRzL2QvZS8yUEFDWC0xdlM3c1FmdzkwUzAwbDJyZk9L
bTgzSmxnMHB4OEt4TVFFNEhIcF9ES1JHYkFHY0FWLXh1NkxJVEhCRWM0eHpWaDl3TEg2V00ybFIw
Y1pTOC9wdWJodG1sIw0KWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9aUWZiSGxvQlVw
RGgrekNnQGRyZWFkLmRpc2FzdGVyLmFyZWEvDQo+DQo+IEl0IHNlZW1zIGxpa2Ugd2Ugb25seSBl
bmFibGUgaGlnaCBvcmRlciBmb2xpb3MgaWYgdGhlICJub3N3YXAiIG1vdW50DQo+IG9wdGlvbiBp
cyB1c2VkLCB3aGljaCBpcyBmYWlybHkgcmVjZW50LiBJIGRvdWJ0IGl0IGlzIHdpZGVseSB1c2Vk
Lg0KDQpGb3Igbm93LCBJIHNraXBwZWQgdGhlIHN3YXAgcGF0aCBhcyBpdCBjdXJyZW50bHkgbGFj
a3Mgc3VwcG9ydCBmb3INCmhpZ2ggb3JkZXIgZm9saW9zLiBCdXQgSSdtIGN1cnJlbnRseSBsb29r
aW5nIGludG8gaXQgYXMgcGFydCBvZiB0aGUgTEJTDQplZmZvcnQgKHBsZWFzZSBjaGVjayBzcHJl
YWRzaGVldCBhdCBbMl0gZm9yIHRoYXQpLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIEdvbWV6IDxkYS5nb21lekBzYW1zdW5nLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vc2htZW0u
YyB8IDE2ICsrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vc2htZW0uYyBi
L21tL3NobWVtLmMNCj4gPiBpbmRleCBhZGZmNzQ3NTEwNjUuLjI2Y2E1NTViMTY2OSAxMDA2NDQN
Cj4gPiAtLS0gYS9tbS9zaG1lbS5jDQo+ID4gKysrIGIvbW0vc2htZW0uYw0KPiA+IEBAIC0xNjgz
LDEzICsxNjgzLDE5IEBAIHN0YXRpYyBzdHJ1Y3QgZm9saW8gKnNobWVtX2FsbG9jX2ZvbGlvKGdm
cF90IGdmcCwNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgZm9saW8gKnNobWVtX2Fs
bG9jX2FuZF9hY2N0X2ZvbGlvKGdmcF90IGdmcCwgc3RydWN0IGlub2RlICppbm9kZSwNCj4gPiAt
ICAgICAgICAgICAgICAgcGdvZmZfdCBpbmRleCwgYm9vbCBodWdlLCB1bnNpZ25lZCBpbnQgKm9y
ZGVyKQ0KPiA+ICsgICAgICAgICAgICAgICBwZ29mZl90IGluZGV4LCBib29sIGh1Z2UsIHVuc2ln
bmVkIGludCAqb3JkZXIsDQo+ID4gKyAgICAgICAgICAgICAgIHN0cnVjdCBzaG1lbV9zYl9pbmZv
ICpzYmluZm8pDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBzaG1lbV9pbm9kZV9pbmZvICpp
bmZvID0gU0hNRU1fSShpbm9kZSk7DQo+ID4gICAgICAgICBzdHJ1Y3QgZm9saW8gKmZvbGlvOw0K
PiA+ICAgICAgICAgaW50IG5yOw0KPiA+ICAgICAgICAgaW50IGVycjsNCj4gPg0KPiA+ICsgICAg
ICAgaWYgKCFzYmluZm8tPm5vc3dhcCkNCj4gPiArICAgICAgICAgICAgICAgKm9yZGVyID0gMDsN
Cj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgKm9yZGVyID0gKCpvcmRlciA9
PSAxKSA/IDAgOiAqb3JkZXI7DQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKCFJU19FTkFCTEVEKENP
TkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRSkpDQo+ID4gICAgICAgICAgICAgICAgIGh1Z2UgPSBm
YWxzZTsNCj4gPiAgICAgICAgIG5yID0gaHVnZSA/IEhQQUdFX1BNRF9OUiA6IDFVIDw8ICpvcmRl
cjsNCj4gPiBAQCAtMjAzMiw2ICsyMDM4LDggQEAgc3RhdGljIGludCBzaG1lbV9nZXRfZm9saW9f
Z2ZwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHBnb2ZmX3QgaW5kZXgsDQo+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBvcmRlciA9IG1h
cHBpbmdfc2l6ZV9vcmRlcihpbm9kZS0+aV9tYXBwaW5nLCBpbmRleCwgbGVuKTsNCj4gPiArDQo+
ID4gICAgICAgICBpZiAoIXNobWVtX2lzX2h1Z2UoaW5vZGUsIGluZGV4LCBmYWxzZSwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2bWEgPyB2bWEtPnZtX21tIDogTlVMTCwgdm1hID8g
dm1hLT52bV9mbGFncyA6IDApKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGFsbG9jX25vaHVn
ZTsNCj4gPiBAQCAtMjAzOSwxMSArMjA0NywxMSBAQCBzdGF0aWMgaW50IHNobWVtX2dldF9mb2xp
b19nZnAoc3RydWN0IGlub2RlICppbm9kZSwgcGdvZmZfdCBpbmRleCwNCj4gPiAgICAgICAgIGh1
Z2VfZ2ZwID0gdm1hX3RocF9nZnBfbWFzayh2bWEpOw0KPiA+ICAgICAgICAgaHVnZV9nZnAgPSBs
aW1pdF9nZnBfbWFzayhodWdlX2dmcCwgZ2ZwKTsNCj4gPiAgICAgICAgIGZvbGlvID0gc2htZW1f
YWxsb2NfYW5kX2FjY3RfZm9saW8oaHVnZV9nZnAsIGlub2RlLCBpbmRleCwgdHJ1ZSwNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm9yZGVyKTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm9yZGVyLCBzYmluZm8p
Ow0KPiA+ICAgICAgICAgaWYgKElTX0VSUihmb2xpbykpIHsNCj4gPiAgYWxsb2Nfbm9odWdlOg0K
PiA+ICAgICAgICAgICAgICAgICBmb2xpbyA9IHNobWVtX2FsbG9jX2FuZF9hY2N0X2ZvbGlvKGdm
cCwgaW5vZGUsIGluZGV4LCBmYWxzZSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmb3JkZXIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZvcmRlciwgc2JpbmZvKTsNCj4gPiAgICAg
ICAgIH0NCj4gPiAgICAgICAgIGlmIChJU19FUlIoZm9saW8pKSB7DQo+ID4gICAgICAgICAgICAg
ICAgIGludCByZXRyeSA9IDU7DQo+ID4gQEAgLTIxNDcsNiArMjE1NSw4IEBAIHN0YXRpYyBpbnQg
c2htZW1fZ2V0X2ZvbGlvX2dmcChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBwZ29mZl90IGluZGV4LA0K
PiA+ICAgICAgICAgaWYgKGZvbGlvX3Rlc3RfbGFyZ2UoZm9saW8pKSB7DQo+ID4gICAgICAgICAg
ICAgICAgIGZvbGlvX3VubG9jayhmb2xpbyk7DQo+ID4gICAgICAgICAgICAgICAgIGZvbGlvX3B1
dChmb2xpbyk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChvcmRlciA+IDApDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgb3JkZXItLTsNCj4gPiAgICAgICAgICAgICAgICAgZ290byBhbGxv
Y19ub2h1Z2U7DQo+ID4gICAgICAgICB9DQo+ID4gIHVubG9jazoNCj4gPiAtLQ0KPiA+IDIuMzku
Mg0KPiA+
