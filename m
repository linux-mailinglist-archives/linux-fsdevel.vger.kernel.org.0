Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30056B32B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 01:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjCJAVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 19:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCJAUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:20:55 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2052.outbound.protection.outlook.com [40.107.113.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12251F5A83;
        Thu,  9 Mar 2023 16:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8b2TTNSGprxhVlSf4rukIQsDH17jUAb+PqAcl7e5yW3K53u5WKsqMkXLzc42g3YWOoTIawnHdlqCVfbiFXJcixi6BJ5JEQ0udR6nHYI3N9t83bNDjk2eBp5PXl1g2CMcXqR4O8QpGA5KWH0FWgj8my3nNRn4ifZNZiFpXUCFtXVWLj0LN4UVokZn0lnj49N7fugwhvm7YSZDB4mQrzcPlpWp1sWezfNrP0D5p0pzSponj/IhL621PclqjIUWlvuma+h5DKdgENEyJIg+5hInCsHvtfgJMo2LgCpXp3CvwCtPgS87UnAizqiTjJVF6unJ17yoBZPgqPmRX3P2YrtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCndgZ2nbymVtmK6D8jLkJBq+S/iaiwQYmnI1EMNSp4=;
 b=VNFfaf/DQ0uWOqNQmt+B4Fp0HNTRxVWwE+vaZ6lLB8V51h6OGwajupGQ9KoXp94CcddZoQAn7DIo/FJqWkkekod2YDc4IuphXD26uU5YMipqLP6fBgrxuGaFqZPxLsR8U1A7QdziOkxn9lx3ZtR8pQkEYb4Vqm+H89kUYtf9Iel2LpmmkaXcdDa19tnnvDBY8w3FXAphQEaa8/3TRjNa5JOfzIHmugxZw25kJgoQ2w5mSLAQoj/KT8xFuneuUywfwz6SIk3nPm7PDpjdKHcTXambd3IU0l8343aoDUR2WUpA3rGrpZ7hVnHkIOH5zUqWRcRl2BRcSTEJ49xY1QtG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCndgZ2nbymVtmK6D8jLkJBq+S/iaiwQYmnI1EMNSp4=;
 b=Xtx+tASMD/1Bop33aFrkIoJkeRIODJgAw87OdySSlQrvK40AldOaR2kLKkwMb/hsLDIFhLH9BBxyWSwurq/x2o07cgS4hLPlbqfZKx4oECcd8v31YyGryX3fwIIB31lD26X/oVuIXbv4xJ8AGdhE5Qps1ykcKynht4dAF2hILCE=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB9521.jpnprd01.prod.outlook.com (2603:1096:400:191::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 00:20:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 00:20:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: memory-failure: Move memory failure sysctls to its
 own file
Thread-Topic: [PATCH] mm: memory-failure: Move memory failure sysctls to its
 own file
Thread-Index: AQHZUkEPh11ZOS2V6EaLBiN5ERHmHK7x55aAgAANsYCAATJ+AA==
Date:   Fri, 10 Mar 2023 00:20:41 +0000
Message-ID: <20230310002038.GA4076019@hori.linux.bs1.fc.nec.co.jp>
References: <20230309045924.52395-1-wangkefeng.wang@huawei.com>
 <20230309051439.GA4018963@hori.linux.bs1.fc.nec.co.jp>
 <49f2c8df-0578-b99e-8687-d77047bd5a33@huawei.com>
In-Reply-To: <49f2c8df-0578-b99e-8687-d77047bd5a33@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB9521:EE_
x-ms-office365-filtering-correlation-id: e353220e-64d5-456d-592a-08db20fd48a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qkv/DExkeZfUOkkX6L/yccGHDrIQOAcvzZxB5EVCIp06kxdMw7JUERjJn9Ep+jKTwlZwD6w8/Gujm0GiJGWKhqFX2WSkqRyl3NYb1nT7CoycvzACy4Jx24kkxoekmBl/4Qgk434eqMSh0MZUiRkmNHYggP9qPMUY2+id6SsZj4ID8qttIU95x1jpC21SMrpJ4w1vEo2iTdJ93r3QWZSZZ8K6Cc7LxMan+33JjDg8xed3TgKgvRRJt1ZNi80gLGxsqk2ZcRTkYd0RXkGe5i6tqZnT08uRP0RAKbcnl2yoslHZ+T25iLPWeZfyBxNr89dSWOySpaD6jWTdHMsObR53x+d5u+32W88WaW0oh0ccSxksuPfSCJpzvvUYH44eg1k21iZZvLg8CmDEX9P9shqjetX6pa1/xjgvlY0PzoFTi+QuWG4GsIRTZM1g4Oxgg3g0ZrrtoUDpKCWbclI0MVRkx+ijj9g4HW0lm8UH6okRTrKZFAxLuMB9j504Ctt8QWXCkChi6dDjdHwDRoE60lMGrQas/4XOsWggRDGy3vJ32xS8z1SZel8xipKJ2Eps0BZjrjIWAycTri5eWu7BQejNl6NsILHuJsFokjfa0CXXqoQLJUILnqsdw0G6Koo3OwdbTpPNE3X5LceAntsOIYVL2KoI0e4cEijhjU4YvPOhq25zncic2j3TfydSl355Mq7t8ebvQGmJeIplNh+91xpaZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(76116006)(66946007)(66556008)(8676002)(6916009)(4326008)(41300700001)(64756008)(83380400001)(66476007)(66446008)(316002)(82960400001)(54906003)(85182001)(38070700005)(122000001)(38100700002)(8936002)(2906002)(33656002)(186003)(5660300002)(478600001)(86362001)(71200400001)(6486002)(9686003)(6512007)(6506007)(1076003)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW9LbTQ0aFRnMGRDYTRZdXJ2b0MyM2t1akhZUm1UT2gzUUpaYzN2bkxmd1V3?=
 =?utf-8?B?OC9TMHZWeG1uUEltS2JsU3BUTURYZGQwdXNSTXJZYlN5SE5GeWFXNzQ1VFhp?=
 =?utf-8?B?QzBOMUtRZWNBVnFCeTAvRVlsdHoyYnlTUi9kSXc5Ym1DY0YwM1I4eDl1QjNC?=
 =?utf-8?B?RHFiczlHOGU0Z3hDbUlwMVNDUEhkQmUzWjdJWnphYXVTUy9FZU1jc2x2ejZT?=
 =?utf-8?B?VGpPengzbFRxdmRoRGIyV3ZiZkVKdHRWMmExVlVHQ0tSUDA1TlRjOTdEK1cr?=
 =?utf-8?B?UWRrREdXNVpuYWpEM25JMUpIR1IxS1RvcmR6Tnh1a29hSSs1SUhaNHVrNWl3?=
 =?utf-8?B?MzBIWTcxeXRlbStvUU9QM04xdFNwRXU2ZDAvT3liOGhZSVVnN2lzRDVBQnhQ?=
 =?utf-8?B?aWkwMFZ6Smg4THRITXM5UzRtVThUR0NtSi9XY2QybVFsemlocGhaamR0SFZs?=
 =?utf-8?B?MlZYT0FjaVhpUHM4OHJiMFBmMDB5dUZCNkJ1QVZPUVk2Q3pyRjhGRGl6TWhQ?=
 =?utf-8?B?WW5BcHp2aGRQVGJyV29CaVZuQkRXWjVTL2Q1QThHNG03b1prQTlNcDNlMnZH?=
 =?utf-8?B?STVjZlN1eEpGVy8ybTFNbHJ4UGs5Qm9GaFkzUmwxWGpCTGNmZXYwL1NrcGJW?=
 =?utf-8?B?b3F5c0J1MGgxTXdOSC9nR1NKSkI5ZGxVcFk0TnhDYjFIamJCTlFiSjRQWXlK?=
 =?utf-8?B?ZkIvWm9vQ2Q4WktiNEk4OE1CZXA4QTBkcWVvSkVac2dGbE9XUWx4NnNzZVRI?=
 =?utf-8?B?NEtZQi8zejZ5L3VUSXJITGNEdkhkY0NEWk1DMXpxbEhRYmJ6cXJzVHh6Wk82?=
 =?utf-8?B?aTB1K3FWQU5rbUlBa2txSGoxKzlhM2xoWWliSVczN3F6ZFNSRzZUWC90Qkdj?=
 =?utf-8?B?cVZ4aDBmSlhNSzNRdU1nNTkrYlFMSE8wNTJzZk1tTXhkNVBwYStXUWorRW1z?=
 =?utf-8?B?WkVQQ3kwZUhMWFo0UnhBRE8vazhDZVJJRWhxUGljUndzRklEUURaK0NuSzhB?=
 =?utf-8?B?UlFkdVVucGhFWUw0WWdNYSt0MWRXT2ZJcnQwUUVyVEhUeFVDSWZkSjc4eFRV?=
 =?utf-8?B?dTVGRHIwSFZxRjZDaTJwTHVteFJMR2YxQzgzYWhWR2lENEw5VWl6Ujc0WkNv?=
 =?utf-8?B?eTc5MVc0WlJ0VEJqSkk4cWRlOGRHSUhxbDlaYTU0bytJUHF6d2R4ZVM5RGZh?=
 =?utf-8?B?ZHNzLzFrZlBvazR2cTQ4Wld1cGkxSHRrWXBxZEFHb284WjE3VlFPNHEyOW04?=
 =?utf-8?B?aGFRM2dUa3MwR2hlTmFkRlJ6Y0V4Q1Y5dkEwejZWVUplUFpvVXJKaXREOXRT?=
 =?utf-8?B?bE5tb0IwSGVJTUZoSHJyQk0xdHd3MTVKUlR3SWtlZjFneHo3WEd4VkZwQytW?=
 =?utf-8?B?MjVZMUYyUGxlYS9KemlDS1FhTlVUWkNrKzFZY25FbXYvMnRPUkhxTm1SdWtI?=
 =?utf-8?B?bFp0MTVUODk4NWZNTXc4UkJUR2VTWW1NK2VKZU5OQkpKUVkyUGdkSDI4NUF4?=
 =?utf-8?B?UGFrRXJuMUZWb3IrVzRqUU5xc09OV1ZPbUIwYXorNThpNXlIZmdOZFd5blNU?=
 =?utf-8?B?b3RMYlkrUUp2S3hwUVhNc1pyK0YvR0hYU09wTU90bkNycnFrTDhLUTVqaEY5?=
 =?utf-8?B?L01SUlFFSkUzQnRha00xUU1vQThPNVAxN29CeG1hRlgvdnQ0bEhRbGh1VFBT?=
 =?utf-8?B?SkVXWm8vY3lUUzFRUURabjNPbDk2d3k2K1MwSnRrNnllb1dGSGVpTTFUOFBU?=
 =?utf-8?B?Z2pvTUdVQXVUV3pTNmd5MzZaZDFYUEwwUkYwZ3crK0w5dkNFdkIvb1lCSHQx?=
 =?utf-8?B?T01mWWR4WktzbURLM0lDY2VRZUd4bVdoYmplczIyMWNVaFlraWRlekljT2NL?=
 =?utf-8?B?VnBiaUZvV3RJUDNYSzBqUFRUNjgxeFlNSlBSUlNubUdvQ1RRY2huQTY5aFNE?=
 =?utf-8?B?VVp1WFlCVDF1bHlwNTB5WUVrbzZCT1YrM1ZhQVJoc2RNUTZuT2VSRWVKT1U4?=
 =?utf-8?B?SEZHaENrQ0FUZ2JCT1ZqNXFxRnorUmNSMmRQaEJpb3MyQlZSeEJxM3lSNEZs?=
 =?utf-8?B?Rkw1YUhubEltalhHbE5PYkZHbVFTWHRDRG43QTVxZHB4bzNCL293ZzY3YUNW?=
 =?utf-8?B?TDU0WE9GSFVWQ1ZxUDhPdS9MMTUzcnYzamJlcWVvWWZMZmZBTUl5QWczK25V?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6A224C090305540B565F563F0260664@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e353220e-64d5-456d-592a-08db20fd48a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 00:20:42.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyfsrgHrQGp4YOgh9WZZsATAWvG2QEyn9e7jU6HPlEtCMrZMaSF4nZbXGl9Cc/nK57Ep7dva6zEpmU0C70vnfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCBNYXIgMDksIDIwMjMgYXQgMDI6MDM6MzlQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IA0KPiANCj4gT24gMjAyMy8zLzkgMTM6MTQsIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg
55u05LmfKSB3cm90ZToNCj4gPiBPbiBUaHUsIE1hciAwOSwgMjAyMyBhdCAxMjo1OToyNFBNICsw
ODAwLCBLZWZlbmcgV2FuZyB3cm90ZToNCj4gPiA+IFRoZSBzeXNjdGxfbWVtb3J5X2ZhaWx1cmVf
ZWFybHlfa2lsbCBhbmQgbWVtb3J5X2ZhaWx1cmVfcmVjb3ZlcnkNCj4gPiA+IGFyZSBvbmx5IHVz
ZWQgaW4gbWVtb3J5LWZhaWx1cmUuYywgbW92ZSB0aGVtIHRvIGl0cyBvd24gZmlsZS4NCj4gPiAN
Cj4gPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gPiANCj4gPiBDb3VsZCB5b3UgZXhwbGFp
biB0aGUgYmVuZWZpdCB0byBtb3ZlIHRoZW0/DQo+ID4gV2Ugc2VlbSB0byBoYXZlIG1hbnkgb3Ro
ZXIgcGFyYW1ldGVycyBpbiBrZXJuZWwvc3lzY3RsLmMgd2hpY2ggYXJlIHVzZWQNCj4gPiBvbmx5
IGluIHNpbmdsZSBwbGFjZXMsIHNvIHdoeSBkbyB3ZSBoYW5kbGUgdGhlc2UgdHdvIGRpZmZlcmVu
dGx5Pw0KPiA+IA0KPiANCj4gQWN0dWFsbHksIGFsbCBvZiB0aGVtIG5lZWQgdG8gYmUgbW92ZWQg
aW50byB0aGVpcnMgb3duIGZpbGUgYXMgcmVxdWlyZWQNCj4gYnkgcHJvYyBzeXNjdGwgbWFpbnRh
aW5lciwgc2VlIFsxXQ0KDQpUaGFuayB5b3UgZm9yIGNsYXJpZmljYXRpb24sIHNvIG5vdyBJIGFn
cmVlIHdpdGggdGhlIGNoYW5nZS4NCkl0IHNlZW1zIHRoYXQgY2hlY2twYXRjaC5wbCBzaG93cyB0
aGUgZm9sbG93aW5nIGVycm9yLCBzbyBjb3VsZA0KeW91IHJlc29sdmUgdGhpcz8NCg0KICBFUlJP
UjogZG8gbm90IGluaXRpYWxpc2Ugc3RhdGljcyB0byAwDQogICMzMDA6IEZJTEU6IG1tL21lbW9y
eS1mYWlsdXJlLmM6NzA6DQogICtzdGF0aWMgaW50IHN5c2N0bF9tZW1vcnlfZmFpbHVyZV9lYXJs
eV9raWxsIF9fcmVhZF9tb3N0bHkgPSAwOw0KDQpXaXRoIHRoaXMgY2hhbmdlLCAuLi4NCg0KQWNr
ZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNClRoYW5r
IHlvdSB2ZXJ5IG11Y2gu
