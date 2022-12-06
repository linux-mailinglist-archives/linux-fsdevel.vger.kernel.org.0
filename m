Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA1643E24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 09:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLFIM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 03:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFIMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:12:24 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2106.outbound.protection.outlook.com [40.92.103.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8110B5B;
        Tue,  6 Dec 2022 00:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9HiJ6s4DdXqvOaeszZZeqTARNQMMYL50cw2zxnVe+zPIegpE0XHGNEhu4UT6nvZyD1kOrqP5inrHi5Z9M12um2NPOcY1t8Oo8YYvDrpeYhrdrOgU26jk2ySsJQQGj5D2dOcQgYMmhhPDoZad2JGGxvVGJpqzoOZKQOGhIor6WlrpW6fmg1qyXBaCgjA/IbHzHoI2WPORB8HmvTAbZ1Hu67RyF5v0hl+tz7nzE+Kc4TiZIWKbbLkiwVmE2673pzVK6kbIM5qyCbP1JMjBoTM1W0vqe6dzpVtUUMfXfdWLSy90M4NjPl8DcXKp3vXLC3XWiLxSMxNCShwgSsXicyp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/qnc7mOWFU9Dw5pi9AdXRp12EjNpV4jVWLm4iEUyM8=;
 b=YhN3hbvGBAaNxAD2QB0nA+4VBXWCjNgfSPaX3ZKDVhfzGSB6FUVF82i8gusiseJdr6Q2R2LUO5UuIengDtmg6yQNClKHQ/JmhSuc3SYcLsY+YbIhO9ja2kAVdKAKRezH67Y4Qh68h7cfptNxtpet73NUujfgGQ7mowEJu4VOcxo74j4wvqtffbp9gbq21Wa70ZysYgq/yOLgwXIPVv9Y1hlZGvwhXXaaXNijqkXv8SsiSSjpQuh8gx7Mo3QCaven4eQM27yyHTI8OCeTuVJIthLaKvJcnrNSCs4rjziKYD31u//EBskddci+3D6bn20toAwQv33Ks2VlMwKc/ueWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/qnc7mOWFU9Dw5pi9AdXRp12EjNpV4jVWLm4iEUyM8=;
 b=CLwgSs7PlreZamIzZu+tfmXuAOcbwNFAM4/yhha9zWMiHGDdTe8werkRqMAIUjkt3mmR51uJH5wmE8xejlmBs3PmgHSHIse4+kNewfp2n4wGOeSJPvEXc8aMsFRr9Y33df71nqiuLEmqBQGE18Xzwxa8SM/uurwQA7wEn9JYizmPEbpmrVcCMrP+CufflUxTYjTmsl12HEQeKXG44T8R8Dj5I89ZuuknrVmucP94i0VNRyA5VvCXGhlQnas8tfCoV2BP1hVIA0xbaQYLMV8DVRYmBLoCUp8X4z/4+uFWeJ400ayxUu6CBaqlq20DQ6H2lPgWNFBzCW4n+3cu1YTtWQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB7254.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:92::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 08:12:16 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 08:12:16 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Topic: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Index: AQHZBmRIqZUco1oHfUewwcIrvr9k1a5bExaAgAC5qICABDvJAIAAf4aA
Date:   Tue, 6 Dec 2022 08:12:16 +0000
Message-ID: <FBF299DB-E235-4BD3-82BD-5A54EE9E26DA@live.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
 <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
 <1D7AAEE4-9603-43A4-B89D-6F791EDCB929@live.com>
 <A2B962C1-AD33-413D-B64A-CD179AFBEA8D@dubeyko.com>
In-Reply-To: <A2B962C1-AD33-413D-B64A-CD179AFBEA8D@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/bym8/SiL0w1QRN7feEX8ZB2/qwkDCFz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB7254:EE_
x-ms-office365-filtering-correlation-id: b85ce3b0-8977-4aa9-275b-08dad76196be
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRPLTNhQCTAkzSP4CSoJiZ16oHAwgfNnYNv3HY2VwmrBVeYrozbFkrq9IldYDNhs6VXYtnHaLal30FCb6FvZi3AG+GUyruqKyQnRMZ8qli/6uyh+c3o4+t41IQiKjz/Jod8Ecj1gfkyXBzp8e7EJzZF9JamJO85w3g1r/nGH219/5qoIY+lCGExbA5R8K71F343NlcFUDYEt0LodZ04j/IJi27Z2T7GLyWTWqsHzYmmKYdl8lrld57QdwpWtBgbMiqLvmlP851xcFWPtgYsDDgRB5uwSyZt3XgBmRMqMFN+IjujC96XuMhcjkuBHo5wixAMGGygU1HOGY5S60VAlYquU/1up3Ui6dqs0ux7L+rs+mx0kkwyXOFMYJtsr9QwP2dzKu9kPNg9+SMzvo2JD/CATxVoegj/raI23uiov+EgPKpCsk1a2HkOYbh6Fe0Kh57w3xcHljFCVVVtz7IGbWpxaxlkL/HhMd8vzpPzFTfJ/UAhr9/okQwm7SwGvXYgNQpeu9sxf7EloCo85pSMeIH8WRcV7J89zIn2VO66rYJYUfnAHue1TCaZkzfEdptFpntLrM76siadtyIeCp2HStJKxvmkbD9mrJkrIu1zmcAzz57RySa66eSGsGA+4KX7bqLRz+m2yN/mE//blsUDzWQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGtOQUk2a1FsM3FLNjBlTlVHSWZvZGhoSVI3b3NET0QyZU80cU5qQVVrOXpx?=
 =?utf-8?B?OS95ckM4cFUveTRsdnBXcTNabFhHcmkxMjhyYWg2RjM1Y0t3NW1QSjUzY2tD?=
 =?utf-8?B?cVByS0NubEtKWnBHNHhyQnJEM1N0SkNERFpTRU14amhCa2JkUE1jRzlnSzZ6?=
 =?utf-8?B?NTFyWFRjSHFQL2hqZ3VhTS9yZzlPNEJqbERIdEF2VmhFWFY0eEtRc0lNMm8w?=
 =?utf-8?B?U1M1UW1PeXNLQkdyZzNpbjBlNkxCbHVTc1NZZU9sK1Y4MmZHZE1ZdmdGd21l?=
 =?utf-8?B?MzZMRjFDSmZSWGI1Vk5FTjZHMUVaV21Rc1F3KzNpbm9XMEQ5NXdveWhBQUZz?=
 =?utf-8?B?REhYdkpEeS9SemVoOFFKTE5FenU0TmxVek5ERE9VVVVHbW1oK0Ivdi9ORnY2?=
 =?utf-8?B?MUxKT014VzZ2aEVhQXF6VXBmZUpiUFJ6Vk14MlZLUTdWOW1sVmpuRzdlZk9h?=
 =?utf-8?B?ZFF1NFA5TTJRNk5UZi9OdHA1TXJMWEpJSWZzK2dRS1FHTVo3S0hEaUtWSEJB?=
 =?utf-8?B?QzAxMWQrdEQxQlljclduRGg5WTZabVY1WGE1akg5VFhOTXI2TlBFSFBhSHJ1?=
 =?utf-8?B?bVdydFBUSmFQVG5kS3JEMS9vYXVyZktTSGhWRjNwSSt6eWMzUk1IM2FtZm9R?=
 =?utf-8?B?NHpSZnpIL0FwUGNpTWhZaHlFUjZyWm9WTGdaRUpjMmt3SkhtaHlzY0FIaEVz?=
 =?utf-8?B?WTBLVmljazVvdExuT3NmQ1pWSFV4V2pjWXNJUWVFbDhEVnBkRDBZZEVZYlZO?=
 =?utf-8?B?bTZGcStMejBWQ005V0h3aFlKYm5oVXVSQXoxdkoydnA1M3U0VlNoQnoxbEZD?=
 =?utf-8?B?M3l4MUlkK3hRQ00yWEI5NDJQS1NwbWNhODFnYlpvNzA2dUlvaTI3VzB0VGNm?=
 =?utf-8?B?RHQzaXZZd3lxbzZPV1poVE1obnhmQzhIakM5QzZsL2QzL2hGVytrN2ExWXVX?=
 =?utf-8?B?aU90c2JRVzlSMS95SklxVklsK1NsZ1FlalRoQ2xKT0xhMllaRmFseEh2RFd4?=
 =?utf-8?B?bllaL1I4OUJob0hKWXlkME5EenM4ako4VkE2Q0o3K1UxZWhPTE0zT1Z6MzVI?=
 =?utf-8?B?UnhDMW5LS2luWmxOSlh5b1pYemhZWTA5OFRHNDR5NERpZXVTYi9zWjBURUgz?=
 =?utf-8?B?c3NIUkZlMTRhSEVUSGFySFZxNzBTSUVPRDRhZ0R6c2VUVHM5ZDB3QS9Yc0x5?=
 =?utf-8?B?QWoyak52NnV4QlkzU0tJQU5OT0Jvb1BJMUtKZGQrR0dRTm9YR1dyYk9GY2tV?=
 =?utf-8?B?bFR1Y2lvY0Fqb3BsbGp1R3VLVmFDSlU2WVVzNFF6RkJINGNQWGtHUDNNdHY0?=
 =?utf-8?B?N3FEUU1valdPY1ZRR0hhQ0QwVjRlNlhRMWdwbktzd3JXOHZPd1M1NlY3bEhN?=
 =?utf-8?B?Q01yaC96L3E5M2gweGpmTnZ5WlJKalYwWE93Tmd5b3lTS0Z2TTdLdXZ0enBP?=
 =?utf-8?B?Ynd2NFBRMVJJY2IzV2k4R0VSczUyVmU3MEs0Mlg2UFBZZGtoY3BUak1DalRn?=
 =?utf-8?B?VXBpbVlZbjhYTG9mVnd6MTVjdEt4NEpRNUpQNFMzVWJoZ3h1ZFBxZjZIcCs1?=
 =?utf-8?B?ZzE3ZmRrZUJRQ1JjL2FHQjd0WFBwdC9aWnRkUURxeTRHWGpMUG1SbSt5Y3VO?=
 =?utf-8?B?d2pNeEZEcWNyZnBpSm9NUWtqNGtHQkUzU3U5SlliUzUzdGs2dFhrZ0JteHVZ?=
 =?utf-8?B?QmlJTUpsT2tmY05HNjEvNFhQV2xwRC9SY1JROEJRbktIMjJSbTUvbkF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FDCCC99CBF32847AF4A5E7C38F6B819@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b85ce3b0-8977-4aa9-275b-08dad76196be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 08:12:16.6877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7254
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IEJlZm9yZSB0aGlzIGNoYW5nZSwgbG9naWMgY2FsbGVkIGlfdWlkX3JlYWQoaW5vZGUpIGFu
ZCBjaGVja2VkIG1vZGUuDQo+IE5vdywgd2UgY2hlY2sgb25seSBIRlNQTFVTX1NCX1VJRC9IRlNQ
TFVTX1NCX0dJRCBmbGFncy4NCj4gU28sIGlmIHdlIG1vdW50IEhGUysgdm9sdW1lIGJ5IOKAnHN1
ZG8gbW91bnQgL2Rldi9zZGExIC9tbnTigJ0sIHRoZW4NCj4gSEZTUExVU19TQl9VSUQgYW5kIEhG
U1BMVVNfU0JfR0lEIGZsYWdzIHdpbGwgYmUgdW5zZXQuDQo+IEFuZCBjdXJyZW50IGxvZ2ljIHdp
bGwgZG8gbm90aGluZy4gSXMgaXQgY29ycmVjdCBsb2dpYz8gTWF5YmUsIHdlIG5lZWQNCj4gdG8g
dXNlIHNiaS0+dWlkL2dpZCBpZiBmbGFnKHMpSEZTUExVU19TQl9VSUQvSEZTUExVU19TQl9HSUQg
YXJlIHNldC4NCj4gQW5kIGlmIG5vdCwgdGhlbiB0byB1c2Ugb2xkIGxvZ2ljLiBBbSBJIGNvcnJl
Y3QgaGVyZT8gT3IgYW0gSSBzdGlsbCBtaXNzaW5nDQo+IHNvbWV0aGluZyBoZXJlPw0KDQpXZWxs
IGluaXRpYWxseSBJIHdoZW4gSSB0cmllZCB0byBpbnZlc3RpZ2F0ZSB3aGF04oCZcyB3cm9uZywg
YW5kIGZvdW5kIHRoYXQgdGhlIG9sZCBsb2dpYyB3YXMgdGhlIGN1bHByaXQsIEkgZGlkIHNvbWUg
bG9nZ2luZyB0byBzZWUgd2hhdCBleGFjdGx5IHdhcyB3cm9uZy4gVGhlIGxvZyBwYXRjaCBpcyBo
ZXJlIGJ0dyA6LSBodHRwczovL2dpdGh1Yi5jb20vQWRpdHlhR2FyZzgvbGludXgvY29tbWl0L2Y2
NjhmYjAxMmY1OTVkODMwNTMwMjBiODhiOTQzOWMyOTViNGRjMjENCg0KU28gSSBzYXcgdGhhdCB0
aGUgb2xkIGxvZ2ljIHdhcyBhbHdheXMgZmFsc2UsIG5vIG1hdHRlciB3aGV0aGVyIEkgbW91bnRl
ZCB3aXRoIHVpZCBvciBub3QuDQoNCkkgdHJpZWQgdG8gc2VlIHdoYXQgbWFrZXMgdGhpcyB0cnVl
LCBidXQgY291bGRuJ3Qgc3VjY2VlZC4gU28sIEkgdGhvdWdodCBvZiBhIHNpbXBsZXIgYXBwcm9h
Y2ggYW5kIGNoYW5nZWQgdGhlIGxvZ2ljIGl0c2VsZi4NCg0KVG8gYmUgaG9uZXN0LCBJIGR1bm5v
IHdoYXQgaXMgdGhlIG9sZCBsb2dpYyBmb3IuIE1heWJlIGluc3RlYWQgb2YgY29tcGxldGVseSBy
ZW1vdmluZyB0aGUgb2xkIGxvZ2ljLCBJIGNvdWxkIHVzZSBhbiBPUj8NCg0KSWYgeW91IHRoaW5r
IGl0cyBtb3JlIGxvZ2ljYWwsIEkgY2FuIG1ha2UgdGhpcyBjaGFuZ2UgOi0NCg0KLQlpZiAoIWlf
Z2lkX3JlYWQoaW5vZGUpICYmICFtb2RlKQ0KKwlpZiAoKHRlc3RfYml0KEhGU1BMVVNfU0JfVUlE
LCAmc2JpLT5mbGFncykpIHx8ICghaV91aWRfcmVhZChpbm9kZSkgJiYgIW1vZGUpKQ0KDQpUaGFu
a3MNCkFkaXR5YQ0KDQoNCg==
