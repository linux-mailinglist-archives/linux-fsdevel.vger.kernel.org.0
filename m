Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734B539409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbiEaPbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 11:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiEaPbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 11:31:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138B12D11;
        Tue, 31 May 2022 08:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8vjnLJASLrFYcaimYnLEhgKqfZcwKEGhwK5pI3Uws4eqwfa2rJpePHQ/ofd2dLK/lsFqwg4XXlN3SxodMQV33/qPwkcCBbRTrTYITYKUK2G0Zg4oDL4Y+4+YD/APuvPsLAug1vEwOcp6tSjfEeqkBLHshAZWPetkOKdRUHya6JJkZZhRqNLKdfCQGybdDBgTJ1LkBEtOGJu1ZKNOTX3zFFJlJNo0DftzsLBweldIzJIofIn4g2le8Ju1IjxzTGtmzVrRptFrNvr3knDndGZH1f5xxNVL9o/1UUSIK4aLl0KNQlfy5QroASaI/EX4q3k7i99fj4eEm6ceXdkzXfGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4XMpZsdn2lcs1H21PX8+Cb5IufquTIuQ3J5hW8FwH4=;
 b=YHqsclENCCK4HQxeyc/APacjfvLGXglK37E2Ph4KjZP0jI6yGsD01PCEjCRtNLX7M16iqNKF/lVxR/Kfl5vyoKGByKtVpoHSmtKPLjJjjxEmw7kw1S4EO4GFfBnJKGMFFtyNoL41fBih38AloQnIS4jUaJV3r6pneFCh6z8pWi3vIKAVgXpFG3eoBH+zRmHP7b9J689ZDwiVomh/Gmy8zR0k/dMhjhCQ4z7p3oDIQYAGIEDeTcSOnYqw/EFFjqMvYi8emPjiAVQVHDxiNxADZ3okfxuQ88oEXit2GagCeUom+Sb8m+Ns/SfaZ1G6ykKLuUzj/MJ2Ujc4qgktXqvTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XMpZsdn2lcs1H21PX8+Cb5IufquTIuQ3J5hW8FwH4=;
 b=GHmC1ogD9G5DP2JRbTWAVdn1hsZYMr96ZIO17GajnMeRaI9/qHyVm1n/1ztYbu8ghIojhpBinkq/JG8sJDPpWAJ9LCsAhqa/+KVr92I7B1iGlPPLrcld19K+vplmanHgGNLdpxMKjsDaHL5+JjGtxEQoyBop8EMKQG4eu40TeCc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR1301MB2200.namprd13.prod.outlook.com (2603:10b6:910:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 15:31:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 15:31:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH -next,v2] fuse: return the more nuanced writeback error on
 close()
Thread-Topic: [PATCH -next,v2] fuse: return the more nuanced writeback error
 on close()
Thread-Index: AQHYbkVcm3tGUbqBEEedIkMjiCfrCK03YL6AgAHJwwA=
Date:   Tue, 31 May 2022 15:31:41 +0000
Message-ID: <9dd14ee55bd023d59dc4d3621cb4042b502872ba.camel@hammerspace.com>
References: <20220523014838.1647498-1-chenxiaosong2@huawei.com>
         <CAJfpegt-+6oSCxx1-LHet4qm4s7p0jSoP9Vg8PJka3=1dqBXng@mail.gmail.com>
In-Reply-To: <CAJfpegt-+6oSCxx1-LHet4qm4s7p0jSoP9Vg8PJka3=1dqBXng@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ac0d03c-c13f-4992-3a8e-08da431aa951
x-ms-traffictypediagnostic: CY4PR1301MB2200:EE_
x-microsoft-antispam-prvs: <CY4PR1301MB22008A54BBEFD48CA74253D0B8DC9@CY4PR1301MB2200.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZle03uPNBT50AcEf9cpNEa893GqIAhZvfpiaZkIH+MgrlqKKPRA8Pa0U11BY5ZC9q1vByPZ1Vs+4S5ReC8wnHJahrizNdNCiNY1yfC4Ig1/ZwNOqh8n9aEvIBLWloILrwyyMkrJexBIN+AzbG0V3cwHKquqi7xDO/QEYsBYuTGdKWqhoNYGmPknQLM/CR5hM51xDL9wM7iJ533iH/vyOl7nUWxXGxgjKVGj76CYW1hEM0TXdTgs5jChCArqcDT1BsPEqyc6GQeW05hiij9znHjyxNuAZ4hXblWl3ojfv87PngxSWwwJSdogMuyRcb70hM8f8wW8ZgwU6qtmK2EwGyRjeeFpKIJCkjGcm0f4kJm3v6ymvJMVT9Srdsn5EF3v7CTForSk3UrK04/TBjdTXR8mvtTxVFp15SYDvHAR8vtGhfSYbMrbVETubzVer8kzYIkQRBkWxkQ+RirSmpdpkdsRY0ARQh9Kg3gkMd+Iao/PVrKxXDCNelPRwrFEsVSJA8Als8BkqJMy0bV1Yb019pM3/qR4RI/aj1s9pNLJRtcajEQiEXn+ahAKumhhnNVl3Owuhk6cDzfvX5Mj92bkFK5M5s26AJRY7GWadMpUko/ZStWQ/vCCLJyFIpbxQHH+4VCk7pgSkAmkCGJwKB1fKqVQHW626Bz5OQRxDBMGO4775OVXwoL5pmb6VH8Bybq8R9FloMu1jy25aCEwxTvMNCUda3GUEHwDncGvcowyqPpJMrVQjHyc+fJcmzV+by8V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(346002)(366004)(39830400003)(136003)(26005)(186003)(316002)(36756003)(38070700005)(508600001)(38100700002)(41300700001)(2616005)(83380400001)(86362001)(122000001)(6486002)(2906002)(5660300002)(71200400001)(8936002)(54906003)(110136005)(6512007)(66476007)(64756008)(66946007)(66446008)(66556008)(8676002)(4326008)(6506007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJKbkNUbjVKZGVqS3NmMEVOZ3RBbHl4YTJ6S0tBQU5WU3RIU3p3UXN5Q0xU?=
 =?utf-8?B?ZkxLSFY3ZlRlTmJKTUFNT1FRRkFoTTAzeWtVWEVZWW9ObVJNdW1XdS92MHJW?=
 =?utf-8?B?d0R6aGt5WFE5WW1YSzl0VjFNYnVQQnRaUnEwMitpN2diOEN0T0lDdDhwTFFJ?=
 =?utf-8?B?RVkyU2NsUnFvQWJWU3FNdHRnWVVXeTlZQThHRFB4WUxBSFdEYmNOUGhsc2N4?=
 =?utf-8?B?eklpdWo3WWtQOVRRUDFtWUpIK3dZenFrZVBTUjBPTUNEUzdjejA5M1J1WnBq?=
 =?utf-8?B?Y0tucWYycjlBRDNjd3cxSGQ2Qmlvb1hZbExWQTh4WFoyMDJiS2dwdnBvZTRJ?=
 =?utf-8?B?QUtMVURWWm9WS3VocVZnYTBOd3o4M0RXUkVCc3pJaG1pMTRzM0I5VHI4T3Fz?=
 =?utf-8?B?emc4OEpRemJpeGdscW1rUHIzd0NBOHJSQXlsSDVJREVsZVROL2NsZnJkcjU2?=
 =?utf-8?B?ckk1bDJUQ2s1NktyTHE0NHB5YlZLQTByWEMrRzFySUF5MGNVNkhpTnpsR3ZG?=
 =?utf-8?B?VTN1YzdmOEpqYU5uQjZWTXdQWng4Zkpteit0OTdBZkZITzB3aUszT1JVM0Y2?=
 =?utf-8?B?aWgrc1ZBMVg3MXZDRTZEaVZ4MlhQdlIwR0F1WlNpcFVHZEo5UTNaQklialpI?=
 =?utf-8?B?NkhSL1BYNGdqbmlYOXZyZFNrU1Z0cDVGNjVwSzF6d1ZXcnJ6S2tSeG8wZUtF?=
 =?utf-8?B?ZGtQZjhvYW9uWXcydU50YmtDTkFhVWVwaWJaQ2pJb2tXRFJHbzZmVnkzMStx?=
 =?utf-8?B?MmdmWlhLS3BkUERvUjh1b3Ezd2J6SmVhSE5zWXh3eHNXSURiUnBIbnZJSU1B?=
 =?utf-8?B?dHY1dmU0Y3hDV0hScUZtU2laVWo5RXRMM0M1b1drVEJMOTJyRVB2VXBGYmcv?=
 =?utf-8?B?djdPV0VyU0VhTTFyYWMrNUxTbWk3aStLVTJEUC9RUWlOcVZqZ2RBaDB6aHFk?=
 =?utf-8?B?SnU5dHBzOWpnK3pRbkhrMEhodkFhandJZFM2dm9RZmZGOXhKZkU4eEQvNzJo?=
 =?utf-8?B?bmRBYWhqUjk4WjhBWUlxNysvV0dJbFZJZURjNnFSNGdmakVVM1IyRGNKNDZr?=
 =?utf-8?B?ZXJSaHRUYlJnSVRweG5zOVcxcUxDQ0FsSzVqb1F5Q3NWTExjRTBLdnhKYUNI?=
 =?utf-8?B?TTZOU0Vud0ZZdXA2REczUFVsQUs4R2tVTFl4K3lmSVVES3FCTXlFRnhLU3l5?=
 =?utf-8?B?d3VaVDNKck9XSVZNMVNLWUp4S29IeXp6dWRqQ0grVkUvUEtmc04rblgvZnFj?=
 =?utf-8?B?WVpjbTJCZGI4WVgwSGh4YjV0akluZWkxRFNNdEZNaXlkMU83aGxLRnJhWm9U?=
 =?utf-8?B?cHhPdDVRUVlKSzdPZjJIL3dKM0lRT05hRkdvWWk3blJIWkVYZWRnRkNwOXFj?=
 =?utf-8?B?MkxLVnpPRWpPVWFDSzZ4dktHQzA1NGVFWmJJeVEwZmZpYjN5djdjQlVmeTVG?=
 =?utf-8?B?U09vcTBrcHI0a2FqdmJzRzIxNkI4NTRSV0VoVjZVa0tKMmlRQ3dITzFrc2VZ?=
 =?utf-8?B?VVpLU1MzWXVnN3diblZ3dEFqR0FMR0pmVGF3RUtuaDFIU2t0eXFIcDI0ajBR?=
 =?utf-8?B?NWtreVVFNldDR01zODJpWGo4S3pMWmt1UU8vbFNDQXpodzhrUXIxSXZDd0Mr?=
 =?utf-8?B?UURUWCs3SlRGa1FxRHhPNEV4TXBUam93cHlSZjhaQ0VLMGFxOW9kenFyTWFP?=
 =?utf-8?B?RlE5NnVUb3F0Q1daYVhjRnRaYUF6VkJ6eWhSeWVLdERhZGdxK1A4ZXppUmEv?=
 =?utf-8?B?QXp6Y1Avcm1wL3BEQ2hWQWJ3aG40Mk5iZFZad0JVQTJ6K1NEVjJNLzgyMml0?=
 =?utf-8?B?RjM0OEdPV0FQbEVHZlFKenlZYkViNXAvSDBONVl1OFowb1BUTWdmbm50N0I2?=
 =?utf-8?B?akYxaHUxWUhQTkc2WUFQN3dBSjlzMUxWWEozbFVxS2p0WFVGcFFscVBXQzBa?=
 =?utf-8?B?enB0T09uT1hrUWR4NjJCVStqM1FOVVJWdmpaQXVEOEZROXVOdDFGT0NXSEta?=
 =?utf-8?B?QWI1NzJ6TDl0cys3Tk16cHFIaldtemI4U2h1dGU4M3VnY2xPa3RNS2lhUHBk?=
 =?utf-8?B?V0lxRHJFQmgrSWlnVS9VbnM2VGVsU3ZVT0VEdXE0ZkdNYnhXa2c0VTdFdEpY?=
 =?utf-8?B?QndOeDBTNzN2K0JIdWtJdlhwRXRoVldROURtcWcxNUFUVC9zQzRaWisxTW96?=
 =?utf-8?B?bXVtQlJGSXQwelV6NGRNV0R4Nzk0NUx1VUdtM0VWMWoxU05PaTlTLzJsNmJn?=
 =?utf-8?B?TkVHc1FObVozK2hLRG1lL2hNZXRsNEx0VGQxc2wxMXlYUzBVb2prZjVkQVdi?=
 =?utf-8?B?WUp2dFhXVFIwOXZtNDE0MlNaaFpLTkgySHZxcDdHNGdkRGdndjd4bHZ2RjhV?=
 =?utf-8?Q?3Qjun6ElY+mhYNzw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <626FA261A88A41409265BD3CD8102D42@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac0d03c-c13f-4992-3a8e-08da431aa951
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 15:31:41.5073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qYFJtW9gLt/n5lBwUBD8s6lrVMI0WD83akEgfSK2aoBe1CK2EpiMR68ybA7F/gY53XTIVyrhwUQcndiqR8d3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTMwIGF0IDE0OjEzICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gT24gTW9uLCAyMyBNYXkgMjAyMiBhdCAwMzozNSwgQ2hlblhpYW9Tb25nIDxjaGVueGlhb3Nv
bmcyQGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEFzIGZpbGVtYXBfY2hlY2tfZXJy
b3JzKCkgb25seSByZXBvcnQgLUVJTyBvciAtRU5PU1BDLCB3ZSByZXR1cm4NCj4gPiBtb3JlIG51
YW5jZWQNCj4gPiB3cml0ZWJhY2sgZXJyb3IgLShmaWxlLT5mX21hcHBpbmctPndiX2VyciAmIE1B
WF9FUlJOTykuDQo+ID4gDQo+ID4gwqAgZmlsZW1hcF93cml0ZV9hbmRfd2FpdA0KPiA+IMKgwqDC
oCBmaWxlbWFwX3dyaXRlX2FuZF93YWl0X3JhbmdlDQo+ID4gwqDCoMKgwqDCoCBmaWxlbWFwX2No
ZWNrX2Vycm9ycw0KPiA+IMKgwqDCoMKgwqDCoMKgIC1FTk9TUEMgb3IgLUVJTw0KPiA+IMKgIGZp
bGVtYXBfY2hlY2tfd2JfZXJyDQo+ID4gwqDCoMKgIGVycnNlcV9jaGVjaw0KPiA+IMKgwqDCoMKg
wqAgcmV0dXJuIC0oZmlsZS0+Zl9tYXBwaW5nLT53Yl9lcnIgJiBNQVhfRVJSTk8pDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogQ2hlblhpYW9Tb25nIDxjaGVueGlhb3NvbmcyQGh1YXdlaS5jb20+
DQo+ID4gLS0tDQo+ID4gwqBmcy9mdXNlL2ZpbGUuYyB8IDQgKystLQ0KPiA+IMKgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZnMvZnVzZS9maWxlLmMgYi9mcy9mdXNlL2ZpbGUuYw0KPiA+IGluZGV4IGYxOGQxNGQ1
ZmVhMS4uOTkxN2JjMjc5NWU2IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2Z1c2UvZmlsZS5jDQo+ID4g
KysrIGIvZnMvZnVzZS9maWxlLmMNCj4gPiBAQCAtNDg4LDEwICs0ODgsMTAgQEAgc3RhdGljIGlu
dCBmdXNlX2ZsdXNoKHN0cnVjdCBmaWxlICpmaWxlLA0KPiA+IGZsX293bmVyX3QgaWQpDQo+ID4g
wqDCoMKgwqDCoMKgwqAgaW5vZGVfdW5sb2NrKGlub2RlKTsNCj4gPiANCj4gPiDCoMKgwqDCoMKg
wqDCoCBlcnIgPSBmaWxlbWFwX2NoZWNrX2Vycm9ycyhmaWxlLT5mX21hcHBpbmcpOw0KPiA+ICvC
oMKgwqDCoMKgwqAgLyogcmV0dXJuIG1vcmUgbnVhbmNlZCB3cml0ZWJhY2sgZXJyb3JzICovDQo+
ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGVycikNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gZXJyOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBmaWxlbWFwX2NoZWNrX3diX2VycihmaWxlLT5mX21hcHBpbmcsIDApOw0KPiANCj4gSSdtIHdv
bmRlcmluZyBpZiB0aGlzIHNob3VsZCBiZSBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2Vycigp
DQo+IGluc3RlYWQuDQo+IA0KPiBJcyB0aGVyZSBhIGRpZmZlcmVuY2UgYmV0d2VlbiAtPmZsdXNo
KCkgYW5kIC0+ZnN5bmMoKT8NCj4gDQo+IEplZmYsIGNhbiB5b3UgcGxlYXNlIGhlbHA/DQo+IA0K
DQpIaSBNaWtsb3MsDQoNCldlIGp1c3Qgd2VudCB0aHJvdWdoIHRoaXMgZGlzY3Vzc2lvbiBmb3Ig
dGhlIGNhc2Ugb2YgTkZTLg0KDQpUaGUgcG9pbnQgaXMgdGhhdCAtPmZsdXNoKCkgaXMgb25seSBj
YWxsZWQgb24gY2xvc2UoKS4gV2hpbGUgeW91IGNhbg0KcmVwb3J0IGVycm9ycyBpbiBjbG9zZSgp
LCB0aGUgJ21hbiAyIGZzeW5jJyBtYW5wYWdlIGRvY3VtZW50cyB0aGF0DQpwb3N0LUxpbnV4IDQu
MTMsIHRoZSB3cml0ZWJhY2sgZXJyb3JzIGFyZSByZXF1aXJlZCB0byBiZSByZXR1cm5lZCBvbiAt
DQo+ZnN5bmMoKS4gWW91IHNob3VsZCB0aGVyZWZvcmUgbm90IGJlIGNhbGxpbmcNCmZpbGVfY2hl
Y2tfYW5kX2FkdmFuY2Vfd2JfZXJyKCkgaW4gYW55dGhpbmcgdGhhdCBpcyBiZWluZyBjYWxsZWQg
YXMNCnBhcnQgb2YgY2xvc2UoKSBzaW5jZSB0aGF0IHdpbGwgY2xlYXIgdGhlIGVycm9yIGZyb20g
dGhlIGVycnNlcV90IGFuZA0KcHJldmVudCBpdCBmcm9tIGJlaW5nIHJlcG9ydGVkIGluIGEgZnV0
dXJlIGZzeW5jKCkgY2FsbCBmcm9tIGEgZHVwKCllZA0KZmlsZSBkZXNjcmlwdG9yLCBldGMuDQoN
Ck5GUyBhbHNvIHdhbnRzIHRvIG1ha2UgYSBzcGVjaWFsIGNhc2Ugb3V0IG9mIHdyaXRlKCkgd2hl
biB3ZSBrbm93IHRoYXQNCnRoZSBlcnJvciBpcyBvbmUgb2YgRURRVU9ULCBFRkJJRyBvciBFTk9T
UEMsIGluIHdoaWNoIGNhc2Ugd2Ugd2lsbCBhbHNvDQp1c2UgIGZpbGVfY2hlY2tfYW5kX2FkdmFu
Y2Vfd2JfZXJyKCkgdG8gcmV0dXJuIHRoZSBlcnJvciBpbW1lZGlhdGVseSwNCmFuZCBjbGVhciBp
dCBmcm9tIHRoZSBlcnJzZXFfdC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=
