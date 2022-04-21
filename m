Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6650973D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384726AbiDUGQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384722AbiDUGQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:16:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2080.outbound.protection.outlook.com [40.107.113.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60413DE6;
        Wed, 20 Apr 2022 23:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmDl/YVhAI9b/1tBmvn7Ot5uKkd+s81p3Z8qNltnUD0rFOUzBuoGtH8qpagRTOY4NYxQLBrBi2d5QjEg+Xce8Xn8mkHKlpJVCjo9+uDM81ipKWcy11jKUmUdeUekbYmtQjUChmJYr3mBYYu8RpJ40NR6RkxpazPtEa6p0A/Vi9sm+pvckeEj0qF4LAUjOepYJgUmYWXS0EdnHjKozt+q28XUAlTFDKuCbE9jZUKTanEQDHAAistZ0G0LXg3ka0K4AtD4gtLKpHsAn/5wIhZCnOJLdQjFGZJn4Peb8CsmzdDGJce70fb7D+e0LakU2BcLxQN2AZown6YhIY1g4RvoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UTjH+2qL6lyEo0LhgU4ylsBn2t8pwV1vnYBBoT+nZw=;
 b=lB+1XVP0/Wp+gFEq2auhZrg+OTlMAhRPPldKnDJYUqHC1i7nB2oO92k6f06ANXs/5Uv1Z4A7AUXUMxr6lJsPzL02dX0sZWhLZtg55jyimowhv65lMPg5uxOrO6qAq62JYAEnypPNgxTqNAxglxiYhAgh0EEzOp4g8OfzzPz1mDLa1No9qGry/C5OvHbNBfogo4nyLDbn+h1sgfW/imhsD3NPpOli2IXk3w3qL1iMubkd3TvUCAsa+fFn66jHlp9QRXmoXAj49x6eNvKNFlwJ0DaKk65ToHYCgh1nPZHij5okrcKw4mvhgENHI2McO/p9+lgfWtqDaKt1qJJApmvZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UTjH+2qL6lyEo0LhgU4ylsBn2t8pwV1vnYBBoT+nZw=;
 b=ZD1fS5hQ3O6rNItqh5nSUwc7aQZTK+ZRu3BUOUKqMzNTOpV3S+yaHL+aHn9EcZJPiq1BG5x2a0es/e9YLubHI8UZ48PQG2alVVq/yi9ONxY2CFm0+ivQWSL0/whpFggaL2Rx/Ta0uKKe5+EEBIrRz+eNT6mf4RUT+aN48Jyqghc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB3391.jpnprd01.prod.outlook.com (2603:1096:404:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:13:45 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 06:13:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 2/7] mm: factor helpers for memory_failure_dev_pagemap
Thread-Topic: [PATCH v13 2/7] mm: factor helpers for
 memory_failure_dev_pagemap
Thread-Index: AQHYVUNs0ZmoJtnEgU+x/qv5agxC/qz542EA
Date:   Thu, 21 Apr 2022 06:13:45 +0000
Message-ID: <20220421061344.GA3607858@hori.linux.bs1.fc.nec.co.jp>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-3-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220419045045.1664996-3-ruansy.fnst@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c68199a-3fe4-49f4-5477-08da235e179f
x-ms-traffictypediagnostic: TYAPR01MB3391:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3391A6793493A9085828CDCCE7F49@TYAPR01MB3391.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLfe43r8uY6fQpv6eULKibiJ/6Pvd6qqtq6y5X8k7b2rt5+t+92deZ/vhO8Qzp3LaQBkwPSVSBGI8Z5FVlemwW1zkF+/9ZaEATYiVgJVsGC7oFmWLroI/XIPfx90CcGEIIziKzkwIElrmLhfwEy4GDrmMmYYLxR0ReQ+woXMl6mObU4s2w/2APQ6cEi+i4FGlhG5xxp3ieY3tI7AUbJ+eSoe1DoJVmw2H3aS1Df7qE/B6XM1c6n5AqDYGHmXz23x5uroUGaCKjmqIIhkJ+S45z2aJfeEH2FPKygDHCscqu2Nzn0hGZoljny4VWLCeGeP6/W/msKR3LCBdwQUOwkjfohOCnLpaAMG9mKJLF7o72IO3hyG89KS2X+bUKzB/BRceDn2QZpc0x2dXChHHDBG63NTTVNeifVnUxDUcANLyAVE8udUCN6QIXJvVy22qPuqv3plNn1tcXfigb2Cqm+aJYz734YtIDoY6frKfRQXCdsyvhvx/YVrXk+cQ6YkHeMjmGUlATFZX5FmyFaYV4x7+FsFQbrpkn0PSYzNAAQW/RyNVxH7CDIDhtRX4wXc0w/0oThXUp5/DSffxmnFzGSkqP9TJbT8xODFb/nFsbgvs2oS4rooUQAdtBagXP6jdN+0YEFnRpot4AXhXoTDoUyk0+yhY/+TAaA0vv4POOVsIOPnXO7tZiRiWoOQCouDeIAkht6Xvy96hwvrVLyJr37nGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(76116006)(38100700002)(38070700005)(6916009)(5660300002)(7416002)(54906003)(316002)(2906002)(85182001)(86362001)(33656002)(8936002)(55236004)(82960400001)(6506007)(71200400001)(1076003)(186003)(508600001)(6486002)(122000001)(83380400001)(9686003)(6512007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjBORWpJdzJOb0ZMMkZFbm9ZblZPVFJ3eWZWUE5nc2ZsTXJ0RTNkN0RUMnho?=
 =?utf-8?B?V2hmaVJ3SktQYWZLejlodVVWM2NTZFdCYUNnTHVJdjZ1b2ZMMlBaQkJvaDBo?=
 =?utf-8?B?a2thazRvZ3Z4Zy9QekJqaGZWNGliVElyNmpuVmp4bllKRzIyZGFuRG5HMUw4?=
 =?utf-8?B?bXdjV0VDT3FpYUJ2Y3Y0K2U2ekxqSUNIVjRaVldTbmo4SEd3ODJrQ3J3TThs?=
 =?utf-8?B?MWxkblhOb2pFY2U1SmcvUWtiaS83K0VicHAzV2kzdmU0NFI5Q2ZYcmR5TjJj?=
 =?utf-8?B?WTgrSjhDNklYL1FqVERMQy9hM1hpYWVmNFNSa0lFMHhhWEZiQ2ZjbStPWHNS?=
 =?utf-8?B?dHEzb2grdm9LRjNPbW11a0pIK0hGTVAyR0NsQ1FJZVo0ZXdkWHI4UVN2c0M2?=
 =?utf-8?B?UGpscmFQZGFodVQ4WWlIVC9rWHM5a2lNdGlEM0FxZWFEclhJK3RBU012ZTlu?=
 =?utf-8?B?eURkTkpHMlBZNjA3a0lDWXBHZCtBc09ZdHVkcm9xb2JIU0lxOHZFenBCS0Zj?=
 =?utf-8?B?YzZiZlZKSFpiVElPaUhLYW1HWVdZaFVZMitGK0crQkNubi92d2tSWlFnNkEr?=
 =?utf-8?B?cWhXV3ROSVpEeTFwWm4vbk1SU0VwbC9RSmJaMHVKWWN0ZmtkdWFGd0VUT2FJ?=
 =?utf-8?B?TWorOHdXN0ErM3ZIbzlSTTdxaXJ3TmhkZnlDWCtkNEtpOUM3QXM5dlFHeXg1?=
 =?utf-8?B?V2R4czBNWGp4OStCQk5XWmdCUTJ2aXhubkwxU0Q2Ym9FVlhZY1dndjNjTWdG?=
 =?utf-8?B?a0ZPa0xNS3dyY2ZXUEZtZnczQzY4azJiaDRWVWFiMUtuTXgrSk54a1RXRFJP?=
 =?utf-8?B?bDNBRkRadkI0TEtSQWJNOER4QTRUVk9saTZESnBodlV4MWZPSklQT0dRSDd0?=
 =?utf-8?B?N1lQeFdFVzNZc1phbUV2UmRKSmlHWFY1K2x4VFBjcUkwRXZxNVdERW91VTZ1?=
 =?utf-8?B?M0FFelJhTGsyL1ZzVnZwTVR6Sk1ESHNzT0h1Y3Y4VTh5Nnhhbi9pNitFcjdq?=
 =?utf-8?B?WXpZN3NFelNtUXpHU0RNODNDbHVINkpGK25zeWtLaXQ0bzI2RlFQUHhEbmh6?=
 =?utf-8?B?RmVyb25GVUpUanNpTDlkdGxGbmZWbTR5cE4zZldCOTluSzFyU1poMUF3b1Fh?=
 =?utf-8?B?SDg0dVVyWW1nYllSUkU3M1pTTmZPcmhJN1NnYzdmeXBRWFF2aDkvWTBJU0hV?=
 =?utf-8?B?WFpPSllYUDhwaUl4Q2toeG1aWFVLMzY3anZMMVg5S0kyRFdQQjlBbzN0b0pC?=
 =?utf-8?B?bkMvM25aRTg0Y2YrWDNrR1pnMm9GVFhheWxnenZ4T21QdEpFZS9pNVEyaHZG?=
 =?utf-8?B?bU9NMXJvUW50Y2tBSE41WDlNU3pGOXZDcngzby9vZ3FRc253aXFyZzVqV1JV?=
 =?utf-8?B?QzN0QldsOFF3ZnNHRmN2eDc2aVpjeGl0RDdQajlieGZDTTJiWmNRbmd6L0Er?=
 =?utf-8?B?R3gwcEVvOVdhWDhuNXZMVkNTUUlPZ0ptTGdjUDRlaFVMd1hVZTVrSjBkRzJz?=
 =?utf-8?B?NnhqdmIzV0lSQ3ZFck1iT1FxTWhUNzdRWnhyR1hqeE5Gc2lmTm1mUUliWXU2?=
 =?utf-8?B?YXd5dXFzZFNFYWc3U3Zza1hLYVRsRUloclFKT2U0eHEzZnN1aC9Bd3FndUhY?=
 =?utf-8?B?YnFKVDNhcVBhbFNmdmJvRzVBK3cvQWRqRWZPaE5vbzJ2NzlSMW1sTDJXeldQ?=
 =?utf-8?B?ellWNDVtTE1Ha3VmbmRoQU1LRkNEVUVtVXZtQzFlRGJPNERBMG5EbUtWbEEv?=
 =?utf-8?B?UDM4WTdwMmpmZTFnYUVqR0JlK1NJUllXTy9GZGpnTThjWkwxY3ZEN3oxejF1?=
 =?utf-8?B?SEkzRmhJK1JLWjJNNXdHZ2RtVGQ2dHQ1c0JBL2NGYmNwekNXV2YrTHRYWDkz?=
 =?utf-8?B?cEJxQXhGc2hwRzFvWUIxV21SVjlJY3N1YnBsRHlFaW1GMm5LaXEvRU5VMjlD?=
 =?utf-8?B?ZlZsTmxxS1dwM1o5TVBSNDdvdEZqN3BIdE9FZUhObHNFcEo5ZjFKOFpoTC83?=
 =?utf-8?B?ckxmckxJdFpRdTB5RjhXdVo2T2Jqdm9EQk9TSENWMlN4MFJSZVoyVVlQT3k2?=
 =?utf-8?B?L0p6Y3NjdUUyZVFzMHcyRUJqZzA3UkZ2NW9HWll5UnIzd1dkbnI0RWxneU5a?=
 =?utf-8?B?bEExdDg1bmpnRjhDeE5KVkZGQ1hKVmFlcWtRUkpMN3V4bEt5OUNDQnNDMTdI?=
 =?utf-8?B?dTVzVWNsR3hVSDdtaVYwVUlxeXJKakxYZDMyNFB3YUM5S2Z1U3dXNHExKzF0?=
 =?utf-8?B?eUhPTnRZWUYwWEV0dU1DM2pCVUVMQTFRSUptTnBQUEVKYlgxRzMvaDc2dE1H?=
 =?utf-8?B?djhhVzBwYkJJUTVMNHk5bjl5dVJqWWFnVTBRaU9xaFRvaFpqVWtRMDA0R1B1?=
 =?utf-8?Q?Dyrs3I9YaEZiKX6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C18ED2C85B329D409AA9717364E6A117@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c68199a-3fe4-49f4-5477-08da235e179f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 06:13:45.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YM5qf6HDG6f2QSVRLoL6lVKp6PJqce4WeN427evQY/vorRqmKUUfWf8tpg23iDYZx9ycxm0OqpFbVSelxYdmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMTI6NTA6NDBQTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdy
b3RlOg0KPiBtZW1vcnlfZmFpbHVyZV9kZXZfcGFnZW1hcCBjb2RlIGlzIGEgYml0IGNvbXBsZXgg
YmVmb3JlIGludHJvZHVjZSBSTUFQDQo+IGZlYXR1cmUgZm9yIGZzZGF4LiAgU28gaXQgaXMgbmVl
ZGVkIHRvIGZhY3RvciBzb21lIGhlbHBlciBmdW5jdGlvbnMgdG8NCj4gc2ltcGxpZnkgdGhlc2Ug
Y29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVq
aXRzdS5jb20+DQo+IFJldmlld2VkLWJ5OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwu
b3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJl
dmlld2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0KVGhh
bmtzIGZvciB0aGUgcmVmYWN0b3JpbmcuICBBcyBJIGNvbW1lbnRlZCB0byAwLzcsIHRoZSBjb25m
bGljdCB3aXRoDQoibW0vaHdwb2lzb246IGZpeCByYWNlIGJldHdlZW4gaHVnZXRsYiBmcmVlL2Rl
bW90aW9uIGFuZCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkiDQpjYW4gYmUgdHJpdmlhbGx5IHJl
c29sdmVkLg0KDQpBbm90aGVyIGZldyBjb21tZW50IGJlbG93IC4uLg0KDQo+IC0tLQ0KPiAgbW0v
bWVtb3J5LWZhaWx1cmUuYyB8IDE1NyArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDcwIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+IGluZGV4IGUzZmJmZjViZDQ2Ny4uN2M4YzA0N2JmZGM4IDEwMDY0NA0K
PiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMN
Cj4gQEAgLTE0OTgsNiArMTQ5OCw5MCBAQCBzdGF0aWMgaW50IHRyeV90b19zcGxpdF90aHBfcGFn
ZShzdHJ1Y3QgcGFnZSAqcGFnZSwgY29uc3QgY2hhciAqbXNnKQ0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiANCj4gK3N0YXRpYyB2b2lkIHVubWFwX2FuZF9raWxsKHN0cnVjdCBsaXN0X2hlYWQgKnRv
X2tpbGwsIHVuc2lnbmVkIGxvbmcgcGZuLA0KPiArCQlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFw
cGluZywgcGdvZmZfdCBpbmRleCwgaW50IGZsYWdzKQ0KPiArew0KPiArCXN0cnVjdCB0b19raWxs
ICp0azsNCj4gKwl1bnNpZ25lZCBsb25nIHNpemUgPSAwOw0KPiArDQo+ICsJbGlzdF9mb3JfZWFj
aF9lbnRyeSh0aywgdG9fa2lsbCwgbmQpDQo+ICsJCWlmICh0ay0+c2l6ZV9zaGlmdCkNCj4gKwkJ
CXNpemUgPSBtYXgoc2l6ZSwgMVVMIDw8IHRrLT5zaXplX3NoaWZ0KTsNCj4gKw0KPiArCWlmIChz
aXplKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFVubWFwIHRoZSBsYXJnZXN0IG1hcHBpbmcgdG8gYXZv
aWQgYnJlYWtpbmcgdXAgZGV2aWNlLWRheA0KPiArCQkgKiBtYXBwaW5ncyB3aGljaCBhcmUgY29u
c3RhbnQgc2l6ZS4gVGhlIGFjdHVhbCBzaXplIG9mIHRoZQ0KPiArCQkgKiBtYXBwaW5nIGJlaW5n
IHRvcm4gZG93biBpcyBjb21tdW5pY2F0ZWQgaW4gc2lnaW5mbywgc2VlDQo+ICsJCSAqIGtpbGxf
cHJvYygpDQo+ICsJCSAqLw0KPiArCQlsb2ZmX3Qgc3RhcnQgPSAoaW5kZXggPDwgUEFHRV9TSElG
VCkgJiB+KHNpemUgLSAxKTsNCj4gKw0KPiArCQl1bm1hcF9tYXBwaW5nX3JhbmdlKG1hcHBpbmcs
IHN0YXJ0LCBzaXplLCAwKTsNCj4gKwl9DQo+ICsNCj4gKwlraWxsX3Byb2NzKHRvX2tpbGwsIGZs
YWdzICYgTUZfTVVTVF9LSUxMLCBmYWxzZSwgcGZuLCBmbGFncyk7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBpbnQgbWZfZ2VuZXJpY19raWxsX3Byb2NzKHVuc2lnbmVkIGxvbmcgbG9uZyBwZm4sIGlu
dCBmbGFncywNCj4gKwkJc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBmbik7DQo+ICsJTElTVF9IRUFEKHRvX2tpbGwp
Ow0KPiArCWRheF9lbnRyeV90IGNvb2tpZTsNCj4gKwlpbnQgcmMgPSAwOw0KPiArDQo+ICsJLyoN
Cj4gKwkgKiBQYWdlcyBpbnN0YW50aWF0ZWQgYnkgZGV2aWNlLWRheCAobm90IGZpbGVzeXN0ZW0t
ZGF4KQ0KPiArCSAqIG1heSBiZSBjb21wb3VuZCBwYWdlcy4NCj4gKwkgKi8NCj4gKwlwYWdlID0g
Y29tcG91bmRfaGVhZChwYWdlKTsNCj4gKw0KPiArCS8qDQo+ICsJICogUHJldmVudCB0aGUgaW5v
ZGUgZnJvbSBiZWluZyBmcmVlZCB3aGlsZSB3ZSBhcmUgaW50ZXJyb2dhdGluZw0KPiArCSAqIHRo
ZSBhZGRyZXNzX3NwYWNlLCB0eXBpY2FsbHkgdGhpcyB3b3VsZCBiZSBoYW5kbGVkIGJ5DQo+ICsJ
ICogbG9ja19wYWdlKCksIGJ1dCBkYXggcGFnZXMgZG8gbm90IHVzZSB0aGUgcGFnZSBsb2NrLiBU
aGlzDQo+ICsJICogYWxzbyBwcmV2ZW50cyBjaGFuZ2VzIHRvIHRoZSBtYXBwaW5nIG9mIHRoaXMg
cGZuIHVudGlsDQo+ICsJICogcG9pc29uIHNpZ25hbGluZyBpcyBjb21wbGV0ZS4NCj4gKwkgKi8N
Cj4gKwljb29raWUgPSBkYXhfbG9ja19wYWdlKHBhZ2UpOw0KPiArCWlmICghY29va2llKQ0KPiAr
CQlyZXR1cm4gLUVCVVNZOw0KPiArDQo+ICsJaWYgKGh3cG9pc29uX2ZpbHRlcihwYWdlKSkgew0K
PiArCQlyYyA9IC1FT1BOT1RTVVBQOw0KPiArCQlnb3RvIHVubG9jazsNCj4gKwl9DQo+ICsNCj4g
KwlpZiAocGdtYXAtPnR5cGUgPT0gTUVNT1JZX0RFVklDRV9QUklWQVRFKSB7DQo+ICsJCS8qDQo+
ICsJCSAqIFRPRE86IEhhbmRsZSBITU0gcGFnZXMgd2hpY2ggbWF5IG5lZWQgY29vcmRpbmF0aW9u
DQo+ICsJCSAqIHdpdGggZGV2aWNlLXNpZGUgbWVtb3J5Lg0KPiArCQkgKi8NCj4gKwkJcmV0dXJu
IC1FQlVTWTsNCg0KRG9uJ3Qgd2UgbmVlZCB0byBnbyB0byBkYXhfdW5sb2NrX3BhZ2UoKSBhcyB0
aGUgb3JpZ2luY2FsIGNvZGUgZG8/DQoNCj4gKwl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIFVzZSB0
aGlzIGZsYWcgYXMgYW4gaW5kaWNhdGlvbiB0aGF0IHRoZSBkYXggcGFnZSBoYXMgYmVlbg0KPiAr
CSAqIHJlbWFwcGVkIFVDIHRvIHByZXZlbnQgc3BlY3VsYXRpdmUgY29uc3VtcHRpb24gb2YgcG9p
c29uLg0KPiArCSAqLw0KPiArCVNldFBhZ2VIV1BvaXNvbihwYWdlKTsNCj4gKw0KPiArCS8qDQo+
ICsJICogVW5saWtlIFN5c3RlbS1SQU0gdGhlcmUgaXMgbm8gcG9zc2liaWxpdHkgdG8gc3dhcCBp
biBhDQo+ICsJICogZGlmZmVyZW50IHBoeXNpY2FsIHBhZ2UgYXQgYSBnaXZlbiB2aXJ0dWFsIGFk
ZHJlc3MsIHNvIGFsbA0KPiArCSAqIHVzZXJzcGFjZSBjb25zdW1wdGlvbiBvZiBaT05FX0RFVklD
RSBtZW1vcnkgbmVjZXNzaXRhdGVzDQo+ICsJICogU0lHQlVTIChpLmUuIE1GX01VU1RfS0lMTCkN
Cj4gKwkgKi8NCj4gKwlmbGFncyB8PSBNRl9BQ1RJT05fUkVRVUlSRUQgfCBNRl9NVVNUX0tJTEw7
DQo+ICsJY29sbGVjdF9wcm9jcyhwYWdlLCAmdG9fa2lsbCwgdHJ1ZSk7DQo+ICsNCj4gKwl1bm1h
cF9hbmRfa2lsbCgmdG9fa2lsbCwgcGZuLCBwYWdlLT5tYXBwaW5nLCBwYWdlLT5pbmRleCwgZmxh
Z3MpOw0KPiArdW5sb2NrOg0KPiArCWRheF91bmxvY2tfcGFnZShwYWdlLCBjb29raWUpOw0KPiAr
CXJldHVybiByYzsNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAqIENhbGxlZCBmcm9tIGh1Z2V0bGIg
Y29kZSB3aXRoIGh1Z2V0bGJfbG9jayBoZWxkLg0KPiAgICoNCj4gQEAgLTE2NDQsMTIgKzE3Mjgs
OCBAQCBzdGF0aWMgaW50IG1lbW9yeV9mYWlsdXJlX2Rldl9wYWdlbWFwKHVuc2lnbmVkIGxvbmcg
cGZuLCBpbnQgZmxhZ3MsDQo+ICAJCXN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXApDQo+ICB7DQo+
ICAJc3RydWN0IHBhZ2UgKnBhZ2UgPSBwZm5fdG9fcGFnZShwZm4pOw0KPiAtCXVuc2lnbmVkIGxv
bmcgc2l6ZSA9IDA7DQo+IC0Jc3RydWN0IHRvX2tpbGwgKnRrOw0KPiAgCUxJU1RfSEVBRCh0b2tp
bGwpOw0KDQpJcyB0aGlzIHZhcmlhYmxlIHVudXNlZCBpbiB0aGlzIGZ1bmN0aW9uPw0KDQpUaGFu
a3MsDQpOYW95YSBIb3JpZ3VjaGk=
