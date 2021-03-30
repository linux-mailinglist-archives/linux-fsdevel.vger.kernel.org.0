Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8134E678
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhC3LoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 07:44:12 -0400
Received: from mail-bn8nam12on2098.outbound.protection.outlook.com ([40.107.237.98]:5729
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231742AbhC3Ln4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2/qWinXpmLL5iZ7moZ546pYK6lCirjCxBxiqNu3Qe5c15dqsTlkipttEtrwtpwehpWXPG1WPgXyb2lOxyEjhVIyMmNFYgbat5o9RsfBA37/+1vXPw3XjBN9fW14VipcP9k4QABy0+I5O0xODBN2PrrICfwMrkw1QlwfcC7Z32JaIc5pYFG0DbogETk6gB9P4D8DVLrvppC3nMcbIR352pAJO3smyazqjPnBHhCDJggrBHu0CQ9o6ZAxIYxtJ2GupGTdogTF5CG6d8JxjNal89ZXfUAWZdtXG2ioaOtgWTZLAylKBXT4Opfcen8piuf4E3i8By2gTGXQsUOHrAowfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU/khSy/xyf42f9+x/gTuGGLEr22IkjzZa+lolDAXbo=;
 b=YJC+6WJtVp4Ozx+rf5dlYLr2op47AgvlXpGYAIRjeoY2KIyJlkaDod+KzuLS4npggm5qLlyn4UJPCRCgAjksqtvuDDI0NT+8xpA+lL7qoxcbWv8Pa+Vb2zD2uv+zLjOurpmUBjFAgKYDy+CiDCbWDlwIoGwhny+ROfW/Wgw48ISUL/F/8x8O7Y4nMjJcRZ+/a3DtjE6bh681V510HAqwSIRUvsLt70aRSm33SMD4vRj5d6NxF7ihW/KHsUbXg4cef6921K6JeoMCPBM5LAflAY7a4ixtZvEwjt6l0N1UhcVZmIdI8fSXDXgMjeqiVhB7GdskHDJlLwjQUfyadBBwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU/khSy/xyf42f9+x/gTuGGLEr22IkjzZa+lolDAXbo=;
 b=ZpxlOMSJp6QwetxaH1wiFUov5Hh8693aRv+zUKXe6KPxm2Y93/9k/6gAj3jQTtvLFLinL4Slk8/Cac6hMbx6ExFP43p6r0JcRYEcuuFWVACG5BzmZFcI56ERNUfOO++xVxzZEwmWqJimadgRJfYptkqAT4zJgTn2Jp4LWltXZdE=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4762.namprd13.prod.outlook.com (2603:10b6:610:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16; Tue, 30 Mar
 2021 11:43:50 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74%7]) with mapi id 15.20.3999.016; Tue, 30 Mar 2021
 11:43:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: why is short-circuiting nfs_lookup() for mkdir(2) et.al.
 dependent upon v3 or later?
Thread-Topic: why is short-circuiting nfs_lookup() for mkdir(2) et.al.
 dependent upon v3 or later?
Thread-Index: AQHXJP5knEiHWg0oK02mbPpLhXEOO6qcaegA
Date:   Tue, 30 Mar 2021 11:43:49 +0000
Message-ID: <f106b42668f23ccd7d1627248f2aeaba64cde765.camel@hammerspace.com>
References: <YGJ1UyTYumVZCa8v@zeniv-ca.linux.org.uk>
In-Reply-To: <YGJ1UyTYumVZCa8v@zeniv-ca.linux.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7fc2ae2-9773-49f5-75b3-08d8f3711668
x-ms-traffictypediagnostic: CH0PR13MB4762:
x-microsoft-antispam-prvs: <CH0PR13MB47626E8DF33C0D4327466A73B87D9@CH0PR13MB4762.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yIHh89PVZ/uAQ3triQ3rYjcd0je1pyK7Gw5g4VZywlkZBJRu1/oTY/idtMWgt3YF2kc3wxXJPjsHOjsJJJRFmf4HRNdbCTGfkyfedzS737msE9BwP9gF1zFtN/nfaSCJPyeo7R2GcpFUp9HH+tiNpWkzXu1ht5SOHH0F1cPSLEb/+izIpjeqTXRiHKwcDptCH2D04SGEloPtgw5fLE4kgSYZt/47MpEXKDfDS/6teMz7qXjvKbqSQTlnd1B3R8EUXvVOHOaDIcN1DGD9J5J35qVYuZphWbGlBuoH3pqyKWWmux/Qxj+3N956dP7FfxLAjC1pju0LYfHJCJPeL84dYr/k4xyaSTszqtCcjYmJOKwKEK97MhH+pJwFGfhBuLF+UCt4kqcV/q690kEQ0STgKb+sykuBJM+nyeqEAq28/dqzqwyJLk7e3aB+IjPrymCInDlbJrD4KQYmcgdTpov7nX4iVa10KbS8hKXVSvi71u2Qln16vvyEfy8QpY2TkQ/7sqB22/pkKp2TR9H4jf+B7Hi/I6ifzSpLoHzWkQfr3bbIfIUKH9qGonKQ8Do4J1V0iPx7BaK9nUxl8DAv/50sSNl1fkWs3XhBAFfE7HtohQyTAjZPqcDKkSfHu8hrmou1lLgqttWIsVyAEG81dy+XjRpUnen3INz8DPYZ6nfiYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39840400004)(396003)(478600001)(2616005)(64756008)(54906003)(4326008)(5660300002)(6506007)(316002)(2906002)(36756003)(38100700001)(6916009)(186003)(66556008)(26005)(8676002)(6512007)(86362001)(66476007)(8936002)(66446008)(6486002)(66946007)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzR6TVJNa0dPdVh3aFBONWJMalo2STlFbEZ1SW12SmRieDBNdkxQTjVvSUxE?=
 =?utf-8?B?QXJRQ0pDd1JxWDExL1EvQyt2aXExam9YdjdmYnF6WDg5Z0YyaFZBaWJZQTJJ?=
 =?utf-8?B?aUZvUzhKNk43cGdRdTRoZTFtaGh1T0VyUlBwd3Rpb0c5M2lYWjE0bWF1YXg5?=
 =?utf-8?B?cy9iQWxha3JzeG9ON2FHd2FaYzJIZWM1RnYxUzdrVUFKY3VLbjltNTZQYnZh?=
 =?utf-8?B?UUpmc2QyZlY3MUJlV0lDaVV0R3BvNWFrWWY4TkxwYjBmUkNVdWdKcVVQWlZl?=
 =?utf-8?B?QWdvcW5VMmd0TFZLcDhjeTdhNysxWjlXYjNjOUNwMyt1MDNCVjNsaysramFR?=
 =?utf-8?B?bmhXSmlmQktHalhzQjFCK2RJVk45bnh0RFhqd08zY3Vsa2VOSXBXdXZpYWdJ?=
 =?utf-8?B?SUl3eUpRaEhEUDdjdnFyQ3I0elAwcHdiVE5Ud2k0MTl1SWJPTy90RHBRU1Yz?=
 =?utf-8?B?ZDdyU0RnS0I0YmtjRW9WUlMrci95cVU5eXVqVHNZMStxaU01VTBvd2x1Q2tN?=
 =?utf-8?B?NmRsUGdnODhaUC9uZWpmWDlqSGlaSzRVdXNEaEx6emRueURPTmJIZTE2Ukhn?=
 =?utf-8?B?d09yaXR4K21rUGRPakhDWFJvNzJpYVVHSmlUYmxqSmhkSnFZdFRHcTAwU0lJ?=
 =?utf-8?B?WW1UcW51SW9HRTNCaUZzRk1HTTJZd1ZHdXhqZFNHY1BhMStuN0dsN2ZSeDM1?=
 =?utf-8?B?U3htc2JnVk9MWGRFWERBMFhmaTNvOFQ5ejJ2OTl1ZCtJd3FMY2dBZjhudWlw?=
 =?utf-8?B?dmVsa1NtYUJBd0FZVHFMWFo1MEZ0Si9nWEdCeU5WTVRnNUh5aEN0NS9QaHlr?=
 =?utf-8?B?Z1VSUVlMTWhhdTNJZTVlWUpSbVBjalVVVUhHUHk1Tk9PWmVYY240R25kTkI4?=
 =?utf-8?B?TDVvMTVHUktiMWZmVDdqU2hIU3YzUDVhZ3NKeXZYd0hudVlvL0JUNFVnd2Ux?=
 =?utf-8?B?Unk0TmVRcmVTVEh4MEJOWm9DM2hZSGJzbGFKbVJJZ3FhdlZxa2hRSUd4UUZH?=
 =?utf-8?B?VHJRcVdPanYzUHdJbmFrZzE3K2NOeGNCL21aSGJRUmtRVHEzL2piTnpRdml5?=
 =?utf-8?B?TVBrczVITjVYT3daNVcxeWxjbGtKdExoVUxjLzY2VXppeVRSZGUwWmE3TmR5?=
 =?utf-8?B?V01weVpjRkZYV2hDMmFmVm9yeE02WXRVVUh5azdOMXZ6eGVHUjZRdXNXeXRn?=
 =?utf-8?B?Wmc2YjhZeVhMdnBrWWp6TVZZeUs0VERabmRVT3Q5ekgreXlyNFF4TUY0KzBm?=
 =?utf-8?B?MzZHRm1oRnVVMDFtelVOUlNHcWxzTStJb1A0ODI2V0Z0aFN5M2lMWHFlUTRY?=
 =?utf-8?B?YUlaR3B2NW56eDkxQzd4YkU5QkdsRGtKQmlIR0UvMXdkdCtZVCtJdkkxekk1?=
 =?utf-8?B?enVOVnlXVGxFN2xFYVZkUnIvU1VXK0hUR0Q3WUphRDYyTDNlYnlTdzhaZnJD?=
 =?utf-8?B?b3dGaTh3RTdsRWpNcTMvcTVKZ3VhODF5VTY2SUduK2tBT3FsZnJPaElueVBU?=
 =?utf-8?B?VlRzSzlucEhaMWl4Mm1YOHBiZUhDZWRENWVCWDZRM2pMckVvVGVEUVJGUldW?=
 =?utf-8?B?d2hzd3BOUUNKRmF4aTFuamJnSitTVWxFY254UzJydGM1aGpYNFBCbUExUy9W?=
 =?utf-8?B?aXJVSXZFc2JObjhZa1lrSElrNncvM1JtY21Ba0JtL2VxVnEzL2RPTTk4V2pt?=
 =?utf-8?B?c240TEp5NGp3a1ZpSmRRTS81c0VtOUk4bVRqOWRtanpJZ0pxSkNLVEEvVmFn?=
 =?utf-8?Q?kEOdkkT/at7HbHrVyaQCkSWLj2RXorFoCu/yMYe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A8689368FB6D47BC91F4F0CADABD6A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fc2ae2-9773-49f5-75b3-08d8f3711668
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 11:43:49.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLjWqIME8cAAiNghzgH01MwxNN7NVYQgAQ45qLj5MxmZ/x8xsMe5NUDwVpM1ayXXl/6MNmJ+n+fMkcBuoA9JdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4762
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTMwIGF0IDAwOjQ4ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiDCoMKg
wqDCoMKgwqDCoCBJbiBuZnNfbG9va3VwKCkgd2UgaGF2ZQ0KPiDCoMKgwqDCoMKgwqDCoCAvKg0K
PiDCoMKgwqDCoMKgwqDCoMKgICogSWYgd2UncmUgZG9pbmcgYW4gZXhjbHVzaXZlIGNyZWF0ZSwg
b3B0aW1pemUgYXdheSB0aGUNCj4gbG9va3VwDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBidXQgZG9u
J3QgaGFzaCB0aGUgZGVudHJ5Lg0KPiDCoMKgwqDCoMKgwqDCoMKgICovDQo+IMKgwqDCoMKgwqDC
oMKgIGlmIChuZnNfaXNfZXhjbHVzaXZlX2NyZWF0ZShkaXIsIGZsYWdzKSB8fCBmbGFncyAmDQo+
IExPT0tVUF9SRU5BTUVfVEFSR0VUKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIE5VTEw7DQo+IE9LLCBmYWlyIGVub3VnaCAtIHdlIGRvbid0IG5lZWQgdG8gZmluZCBv
dXQgd2hldGhlciBpdCdzIG5lZ2F0aXZlIG9yDQo+IG5vdCBmb3INCj4gbWtkaXIoKSBldC5hbC47
IGlmIGl0IGlzbid0LCBzZXJ2ZXIgd2lsbCB0ZWxsIHVzIHRvIHNvZCBvZmYgYW5kIHdlDQo+IGNh
biBsaXZlDQo+IHdpdGggbm90IGhhdmluZyBpdCBpbiBjYWNoZSAtIGluIHRoZSB3b3JzdCBjYXNl
LCB3ZSdsbCBoYXZlIHRvIGRvIHRoZQ0KPiBzYW1lDQo+IGxvb2t1cCB3ZSdkIHNraXBwZWQgaGVy
ZSBhdCBzb21lIGxhdGVyIHBvaW50LsKgIFNhbWUgZm9yIHJlbmFtZSgyKQ0KPiBkZXN0aW5hdGlv
biAtDQo+IGlmIGl0IHdhc24ndCBpbiBkY2FjaGUsIHdlIGFyZSBub3QgZ29pbmcgdG8gYm90aGVy
IHdpdGggc2lsbHlyZW5hbWUNCj4gYW55d2F5LCBhbmQNCj4gdGhhdCdzIHRoZSBvbmx5IHRoaW5n
IHdoZXJlIHdlIG1pZ2h0IGNhcmUgYWJvdXQgdGhlIGRlc3RpbmF0aW9uLsKgIElmDQo+IHJlbmFt
ZSgyKQ0KPiBzdWNjZWVkcywgd2Ugd29uJ3Qgc2VlIHdoYXRldmVyIGhhZCBiZWVuIHRoZXJlIGFu
eXdheSwgYW5kIGlmIGl0DQo+IGZhaWxzLCB3ZSB3b24ndA0KPiBsb3NlIGFueXRoaW5nIGZyb20g
aGF2aW5nIGxvb2t1cCBkb25lIGxhdGVyLg0KPiANCj4gwqDCoMKgwqDCoMKgwqAgV2hhdCBJIGRv
bid0IGdldCBpcyB3aHksIHVubGlrZSByZW5hbWUoMikgdGFyZ2V0LCBta2RpcigyKQ0KPiBhcmd1
bWVudCBpcw0KPiBoYW5kbGVkIHRoYXQgd2F5IG9ubHkgZm9yIHYzIGFuZCBsYXRlci7CoCBJdCdz
IGJlZW4gYSBsb25nIHRpbWUgc2luY2UNCj4gSSBsb29rZWQNCj4gYXQgTkZTdjIgc2VydmVycywg
YnV0IHNob3VsZG4ndCB3ZSBnZXQgTkZTRVJSX0VYSVNUIGlmIHRoZSBzdWNrZXINCj4gdHVybnMg
b3V0IHRvDQo+IGhhdmUgYWxyZWFkeSBiZWVuIHRoZXJlPw0KPiANCj4gwqDCoMKgwqDCoMKgwqAg
V2hhdCBhbSBJIG1pc3Npbmc/DQoNClRoZSBjaGVjayBmb3IgTkZTIHZlcnNpb24gPiAyIGlzIG1h
aW5seSB0aGVyZSBmb3IgdGhlIGNhc2Ugb2YgQ1JFQVRFLA0Kd2hpY2ggZG9lcyBub3QgaGF2ZSBh
biBleGNsdXNpdmUgY3JlYXRlIG1vZGUgaW4gTkZTdjIuDQpJT1c6IEkgYmVsaWV2ZSB3ZSBjYW4g
aW5kZWVkIHJlbHkgb24gTElOSywgTUtESVIsIGFuZCBSRU5BTUUgcmV0dXJuaW5nDQpORlNFUlJf
RVhJU1QsIGJ1dCBub3QgdGhlIG1vcmUgY29tbW9uIGNhc2Ugb2YgQ1JFQVRFLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
