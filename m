Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4865A04CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiHXXmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 19:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHXXmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:42:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2065.outbound.protection.outlook.com [40.107.113.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A1140C5;
        Wed, 24 Aug 2022 16:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDBK5cJ0Yl6r4oLWM5ib/BwiWaXeTivmP6AMM+hrXf5KknwJicGw9Hx+lW+9wyerbYnIWzCSuWdvCiKfuWwTgXHr0b7WrowChdLlbxrIDNWN21cvK/ENy23B9/wVpHg4gUEiAVMnricN2KmwBfbETa6YOGz2Sksi8ZodrJw6FnfOoqu5LV7wr3APFZ5mB9dcKZPHJ8DEKZsEWybg/3C10FAAJupMct5t1AFxKj2Dok1QmLyQ4h5Ccbi1zRqRI5Gs8MuVFvusXilX2hpLBjtb7gkQQEuAWllkizvEsjo72rqHIBFAUbsvuehfGqHs7vRMDqv/Ik0Dc5b9fpcua43NQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it6kK2hr58oQ/fTvw7fs/d8nuIbQhfmDUvvie7gvSIc=;
 b=Bk0IQsSwNz+gOv6mhqiK546d0bqD1/FlVQUhr9B52LCkbFUQbZ4Q4V40QFeORtTL3FfehobXzjVwtVRJjPCU5srJEZLqq5kKhGBE7Xeyo+vDujlmXoHiYvuFjXCapBCzm9j4BEioUjTpaGC1rSXuMDy80y008DU90Sbq5ckvL4WbJnPNqiPEljX6PcYN+P6tWhmV8FvMvbAQNerCldswNUZU5C9yfgXHgfry5tVTmOLLg711okF94XP25V5mEFhN0pBDPyf1Ds6EMKdFFuRDrowj/jBB7k7ObO77++cEbtwQnCvSorK7rt8sEDeOcbLga3MZO7VEHnpiKdxoGsLT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it6kK2hr58oQ/fTvw7fs/d8nuIbQhfmDUvvie7gvSIc=;
 b=LSlSZ3UXZO/A0cnPSfv7h2zP5uF/JFrqNZvkZ3N4SjwJxqPYuzfFp2NL2DTNWxgoIWnkESsxiOgEsmzirCIs7Ql8emu9JFYjTe3shS+Q11KW8v/WfPsIcmGGpEzjUiVwuzPvmPgKgR9HMhBbL6n6NNS405XeXPUQ4KENlKOQeh4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2839.jpnprd01.prod.outlook.com (2603:1096:604:1a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 23:42:02 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%5]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 23:42:02 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/14] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Topic: [PATCH v2 05/14] mm: Introduce mf_dax_kill_procs() for fsdax
 case
Thread-Index: AQHYuAPmqsJmWdrmv0+Aqj/73d64e62+thgA
Date:   Wed, 24 Aug 2022 23:42:02 +0000
Message-ID: <20220824234142.GA850225@hori.linux.bs1.fc.nec.co.jp>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
 <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
 <63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9255d518-ec4b-4c09-a1e4-08da862a3ede
x-ms-traffictypediagnostic: OSBPR01MB2839:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJ91w/FnII8RvrixamKbeCkJKqI0NfF1qntP0EdGCv0oOMb/pIkGsNjVdZ8PC/XRCK3wIb1YhGTRMXA1XfKdqqUOabSMItFt8mTT2YETDZ6D32zhrefii/Uf9zJsZRpVAJGu2vz0nJ0eSqvAr0KTpObTB/2l3V+ndxA5WhdY0cR0VKU//teOOsGfFe0Krdn70ty2UCev0oVvjegW0xVbAd3QsXEb5gSpDAUovArR3EkbTZKuKCVs3Sj77aJyUS7SHRhTjfSVLAkOUqWpFKigXmFS0HmlO7cvlnbdjD1///JMOuTPf2/QsbxVwcuFiEBcgHnHb0+t1ZScYZn019/KpoW4X03k4EY2AmxYHXvVA8O4Dqr1tY4hMEpTv7NiEpaO8S9lYsY15SWaefs53RJFZ3pf1BffdXLu9Cl7gor7g19j3ZokhiYjP3TzYRkaa17uURMR9NcX8P9khBFC7HmlQduud8tKPv1SBGQJDFHwFPQt9I6HNBMPNOr1BktZiDTlIxhLYvlH/LKt+OxiWpp2L6MGKYj4yXVg/U+x/sZAfszVStp04/BMdx87DdeD9YdtFiHZsj1mgBueH0CagSVXyDIZOOGYB87E2vAIwsP8eJZO/vS5QPzpdn4SF+nWGt8w+dPnniooE7FrABaY1Tegm2Xl7SkeugB4c0RCAl8TO9sziB5P8eba1pd8dtSopTWH5YsvwIDuVUEu6KYr8G+Ge+giGakVRHYCgqurYUxAsa6F2JittlaS+J9qeanI7zRw43OW9p6RG6oBQSvJaPwf6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(6916009)(6512007)(82960400001)(83380400001)(26005)(316002)(38070700005)(5660300002)(478600001)(1076003)(85182001)(2906002)(8936002)(186003)(6486002)(71200400001)(122000001)(4326008)(38100700002)(7416002)(54906003)(8676002)(66556008)(66476007)(9686003)(66946007)(66446008)(64756008)(76116006)(55236004)(33656002)(41300700001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nms0ZXN0V2NIVXlKTGNaMHpvUVRndDhMcGJBbTc2b0RvV3pRWTVXTnB1VXph?=
 =?utf-8?B?UEZVdXBPRVhBLzFHQkRVUU9Wa0pHRTFCbW9NUkZlblY1Z1JRVnJuK3FxdzNO?=
 =?utf-8?B?Q3VhcE1PbW5kMWlVS0x6UVNOMTFvbnVpYVRZVUtEOWNVTVdteHpXdkhZSGoy?=
 =?utf-8?B?ZXFhWHJvUHNJRkZKV1cxMUxNbEpXQnVRVlZkTDFtTkNJeUdaRE9Vc3pRYXI3?=
 =?utf-8?B?V2Q1OVlZOWV4eEVjU2VDNEtvbW5Ib2dwUmgrcDcyZ0tMQkxGNVVSK3F6Zmo1?=
 =?utf-8?B?d0NzaEdQRFRvUlcxb0JzeHdjVm85eHhQNWswKzlyNTdNcVFDWjdzU0VEc09r?=
 =?utf-8?B?T1hFdGxTWVhROTEvNzhKK3RtSmpBc01FNHB5QmhnQ0ZFdVRvWkQwQlRjVkVP?=
 =?utf-8?B?Y1lyalJqYzQ1K0FNbGRQbnZjMUtUeVV4TTZZWFN0LzBpOGNhVXhnUkN3bWVR?=
 =?utf-8?B?S0tSRFpiTTNCTnYvWjlCQ2k1M1VtS01LMUtLTXZNc0VjeHhtUnlUeUJYNUF1?=
 =?utf-8?B?NDlwbFFHR0h3RXBnMHlwMHVFREZPWmJVRWUrdUNpR0lOM0Z0b2wxRVJ3OHRu?=
 =?utf-8?B?OXJrSjFmT3NGNEluYVlaUUoxcGpRNC8wQWdodGlTYUh1TkpqS3NwZ3g5b2Vs?=
 =?utf-8?B?Z283TnRjbkl2eUVhYUE0WWN4MjBheCtpUkVic2JRNFBhYTgrcmgvSk1ldmR5?=
 =?utf-8?B?MVhHeEFiZ3NDM0dGQlZKbUFZUDBlZ25uYXV6RVBKUkVWZU9WQmtEeEJaWHRa?=
 =?utf-8?B?UE1FZnFlV3h1K21PVnp1OHNZQjdmMno1TGoxbm54VGFzSHdEb1VuWm1LVEVV?=
 =?utf-8?B?bGZNVVFueEtyU0ttMGRhWU1ZQk1KOGIvWTdYVm1TZlFHWXNCdnRvWnY1TVdV?=
 =?utf-8?B?UG5lV0JXUHY2MWV2dDBtMGtVK0pHMzd5bzB2MzhJMjRYaXpUZFYvSVVaQW0w?=
 =?utf-8?B?ckt5SDdKM05aeXdHYlE5OE80aUdSUkYvb3Q4aW9GYW92ams1NGV2NWtCb0xM?=
 =?utf-8?B?bmxSaW1WaGNYY05aVFU4K0JUM3JuVVFqYkpnWUFta1RGRnRSalAzejVrVTdX?=
 =?utf-8?B?VUZYakIwOFUxbTFPdmZBVEVBUk94SzdvOWN0ajJuZFhwcFRtZjBCMXdMQVVE?=
 =?utf-8?B?TDRLSnQwRjRMaXJLVjNqQjRPWkhmTzBsOXdFWkhIVGFMYktURHBRVGdQNXp3?=
 =?utf-8?B?T1VZWmlQSmk5ME1GbFhKdEZINGNObUE5TDFJRFNCdCtjRGx6cklrSGlXL044?=
 =?utf-8?B?Y0t0WjVHV3dJOWc3eXo4S2pISXpTNVp2dTNudGxLUHV3VjdhdWQwMnM0N1pm?=
 =?utf-8?B?OUxWNTV3dFdpNGZUeTlUM0EwcENFZC8raXJUUDFsdXdDZzZla1F1Q1ZtdzVS?=
 =?utf-8?B?VmR6ZHFWNVBad0hxU3dCakNyTmozb2orenVpZVNHTlhhaHNmMGxzWDJ3bkhJ?=
 =?utf-8?B?TlRCenBLTkJILzUyTTVnU0ZkU1ZGRFFhZGR1WjFHS0JrZXRoQld6aTd3L01K?=
 =?utf-8?B?Y0JTQmROc0s3dWt0Tmc2dXY5TVVUVnEvY0t6dUJEWmt0UnoxZnJibndWY2xi?=
 =?utf-8?B?U2MvaEx6b1FtQVhVd3pZYVpPaHBiTCsyd2VRSS9zaURVWkhGR1l4Y3FyMVov?=
 =?utf-8?B?QlhvL29TYTduOW1WWVZ1Y0M4WFI3MTBYMkpDMFNqc2NXem0rWXgvcnp1R01L?=
 =?utf-8?B?Y0RNUjh6eVE1ZHlMZGdoMHltT0NUZEg1Q2Q0ZGh5bUxkeTFFRVBmbTMvMHl1?=
 =?utf-8?B?K1YxZ2JUazhuMTBtVzJxa0pETG5hS01xcGVRZFRPYnBKcjduV25jclFsMERM?=
 =?utf-8?B?RnhWOXc4T0ZHYnBUZzM2QVdyS2Zuak9qZzF3TEdyVDliVnc2clAySzE5ZlRx?=
 =?utf-8?B?MXEzdmw3Wm56cS9xUlNLb21OMHU2NDIzR3UrZzZaVU5HaVA4cTVYRnBaYjBQ?=
 =?utf-8?B?azhub3AzdzF1Z2Z3Y1lvWVNvWUVWTS9LckowblJHN1NLSDZZOXBBcWkrQldu?=
 =?utf-8?B?Rk9GcHlhcUp1ODlCRjVUY01waVgrOFpQUC83SEFVNXRZMm0wR0owZEtaRy9C?=
 =?utf-8?B?MkJuczB6MXJaM3oxMlZ3NjFyTE0yelpkbld3Z1d5N2g4cFlibCtob25lRi9I?=
 =?utf-8?B?aWNTMGpNNk5oYkFtSVppN3RvMjFHaGhnak9wNGM4Ykt0TGJBN2ZDM3ArODZP?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <725FCC87CF9A81428FC72AF108A3FD8E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9255d518-ec4b-4c09-a1e4-08da862a3ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 23:42:02.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ViSKF1cFIFVuuNm9/0Yz+St31r/VHkEYMldCb3wkDJCRfJ6JI5KL4pf9Ihp2gcZGABgIsFkQ0gVFu6SSKyBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCBBdWcgMjQsIDIwMjIgYXQgMDI6NTI6NTFQTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+ID4gVGhpcyBuZXcgZnVuY3Rpb24gaXMgYSB2
YXJpYW50IG9mIG1mX2dlbmVyaWNfa2lsbF9wcm9jcyB0aGF0IGFjY2VwdHMgYQ0KPiA+IGZpbGUs
IG9mZnNldCBwYWlyIGluc3RlYWQgb2YgYSBzdHJ1Y3QgdG8gc3VwcG9ydCBtdWx0aXBsZSBmaWxl
cyBzaGFyaW5nDQo+ID4gYSBEQVggbWFwcGluZy4gIEl0IGlzIGludGVuZGVkIHRvIGJlIGNhbGxl
ZCBieSB0aGUgZmlsZSBzeXN0ZW1zIGFzIHBhcnQNCj4gPiBvZiB0aGUgbWVtb3J5X2ZhaWx1cmUg
aGFuZGxlciBhZnRlciB0aGUgZmlsZSBzeXN0ZW0gcGVyZm9ybWVkIGEgcmV2ZXJzZQ0KPiA+IG1h
cHBpbmcgZnJvbSB0aGUgc3RvcmFnZSBhZGRyZXNzIHRvIHRoZSBmaWxlIGFuZCBmaWxlIG9mZnNl
dC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1
aml0c3UuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+DQo+ID4gUmV2aWV3ZWQtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+
DQo+ID4gUmV2aWV3ZWQtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiA+
IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21tLmggIHwgIDIgKw0KPiA+ICBtbS9tZW1vcnktZmFp
bHVyZS5jIHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
DQo+IA0KPiBVbmZvcnR1bmF0ZWx5IG15IHRlc3Qgc3VpdGUgd2FzIG9ubHkgcnVubmluZyB0aGUg
Im5vbi1kZXN0cnVjdGl2ZSIgc2V0DQo+IG9mICduZGN0bCcgdGVzdHMgd2hpY2ggc2tpcHBlZCBz
b21lIG9mIHRoZSBjb21wbGV4IG1lbW9yeS1mYWlsdXJlIGNhc2VzLg0KPiBVcG9uIGZpeGluZyB0
aGF0LCBiaXNlY3QgZmxhZ3MgdGhpcyBjb21taXQgYXMgdGhlIHNvdXJjZSBvZiB0aGUgZm9sbG93
aW5nDQo+IGNyYXNoIHJlZ3Jlc3Npb246DQoNClRoYW5rIHlvdSBmb3IgdGVzdGluZy9yZXBvcnRp
bmcuDQoNCj4gDQo+ICBrZXJuZWwgQlVHIGF0IG1tL21lbW9yeS1mYWlsdXJlLmM6MzEwIQ0KPiAg
aW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4gIENQVTogMjYgUElE
OiAxMjUyIENvbW06IGRheC1wbWQgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgIDUuMTkuMC1y
YzQrICM1OA0KPiAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwg
MjAwOSksIEJJT1MgMC4wLjAgMDIvMDYvMjAxNQ0KPiAgUklQOiAwMDEwOmFkZF90b19raWxsKzB4
MzA0LzB4NDAwDQo+IFsuLl0NCj4gIENhbGwgVHJhY2U6DQo+ICAgPFRBU0s+DQo+ICAgY29sbGVj
dF9wcm9jcy5wYXJ0LjArMHgyYzgvMHg0NzANCj4gICBtZW1vcnlfZmFpbHVyZSsweDk3OS8weGYz
MA0KPiAgIGRvX21hZHZpc2UucGFydC4wLmNvbGQrMHg5Yy8weGQzDQo+ICAgPyBsb2NrX2lzX2hl
bGRfdHlwZSsweGUzLzB4MTQwDQo+ICAgPyBmaW5kX2hlbGRfbG9jaysweDJiLzB4ODANCj4gICA/
IGxvY2tfcmVsZWFzZSsweDE0NS8weDJmMA0KPiAgID8gbG9ja19pc19oZWxkX3R5cGUrMHhlMy8w
eDE0MA0KPiAgID8gc3lzY2FsbF9lbnRlcl9mcm9tX3VzZXJfbW9kZSsweDIwLzB4NzANCj4gICBf
X3g2NF9zeXNfbWFkdmlzZSsweDU2LzB4NzANCj4gICBkb19zeXNjYWxsXzY0KzB4M2EvMHg4MA0K
PiAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ2LzB4YjANCg0KVGhpcyBzdGFj
a3RyYWNlIHNob3dzIHRoYXQgVk1fQlVHX09OX1ZNQSgpIGluIGRldl9wYWdlbWFwX21hcHBpbmdf
c2hpZnQoKQ0Kd2FzIHRyaWdnZXJlZC4gIEkgdGhpbmsgdGhhdCBCVUdfT04gaXMgdG9vIGhhcnNo
IGhlcmUgYmVjYXVzZSBhZGRyZXNzID09DQotRUZBVUxUIG1lYW5zIHRoYXQgdGhlcmUncyBubyBt
YXBwaW5nIGZvciB0aGUgYWRkcmVzcy4gIFRoZSBzdWJzZXF1ZW50DQpjb2RlIGNvbnNpZGVycyAi
dGstPnNpemVfc2hpZnQgPT0gMCIgYXMgIm5vIG1hcHBpbmciIGNhc2VzLCBzbw0KZGV2X3BhZ2Vt
YXBfbWFwcGluZ19zaGlmdCgpIGNhbiByZXR1cm4gMCBpbiBzdWNoIGEgY2FzZT8NCg0KQ291bGQg
dGhlIGZvbGxvd2luZyBkaWZmIHdvcmsgZm9yIHRoZSBpc3N1ZT8NCg0KZGlmZiAtLWdpdCBhL21t
L21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQotLS0gYS9tbS9tZW1vcnkt
ZmFpbHVyZS5jDQorKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQpAQCAtMzE2LDcgKzMxNiw4IEBA
IHN0YXRpYyB1bnNpZ25lZCBsb25nIGRldl9wYWdlbWFwX21hcHBpbmdfc2hpZnQoc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWEsDQogICAgICAgIHBtZF90ICpwbWQ7DQogICAgICAgIHB0ZV90ICpw
dGU7DQoNCi0gICAgICAgVk1fQlVHX09OX1ZNQShhZGRyZXNzID09IC1FRkFVTFQsIHZtYSk7DQor
ICAgICAgIGlmIChhZGRyZXNzID09IC1FRkFVTFQpDQorICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQogICAgICAgIHBnZCA9IHBnZF9vZmZzZXQodm1hLT52bV9tbSwgYWRkcmVzcyk7DQogICAgICAg
IGlmICghcGdkX3ByZXNlbnQoKnBnZCkpDQogICAgICAgICAgICAgICAgcmV0dXJuIDA7DQpAQCAt
MzkwLDcgKzM5MSw4IEBAIHN0YXRpYyB2b2lkIGFkZF90b19raWxsKHN0cnVjdCB0YXNrX3N0cnVj
dCAqdHNrLCBzdHJ1Y3QgcGFnZSAqcCwNCiAgICAgICAgaWYgKHRrLT5hZGRyID09IC1FRkFVTFQp
IHsNCiAgICAgICAgICAgICAgICBwcl9pbmZvKCJVbmFibGUgdG8gZmluZCB1c2VyIHNwYWNlIGFk
ZHJlc3MgJWx4IGluICVzXG4iLA0KICAgICAgICAgICAgICAgICAgICAgICAgcGFnZV90b19wZm4o
cCksIHRzay0+Y29tbSk7DQotICAgICAgIH0gZWxzZSBpZiAodGstPnNpemVfc2hpZnQgPT0gMCkg
ew0KKyAgICAgICB9DQorICAgICAgIGlmICh0ay0+c2l6ZV9zaGlmdCA9PSAwKSB7DQogICAgICAg
ICAgICAgICAga2ZyZWUodGspOw0KICAgICAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgfQ0K
DQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiANCj4gVGhpcyBpcyBmcm9tIHJ1bm5pbmc6
DQo+IA0KPiAgIG1lc29uIHRlc3QgLUMgYnVpbGQgZGF4LWV4dDQuc2gNCj4gDQo+IC4uLmZyb20g
dGhlIG5kY3RsIHJlcG8uDQo+IA0KPiBJIHdpbGwgdGFrZSBsb29rLCBhbmQgcG9zdGluZyBpdCBo
ZXJlIGluIGNhc2UgSSBkbyBub3QgZmluZCBpdCB0b25pZ2h0DQo+IGFuZCBSdWFuIGNhbiB0YWtl
IGEgbG9vay4NCg==
