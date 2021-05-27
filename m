Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D0393972
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 01:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhE0XyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 19:54:07 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:7392
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233938AbhE0XyH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 19:54:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT08e5Lo46Zdr+jAoivUNjNpuba8BCi+vFbHAq1PQe09hK35WX4D70EKY6rWjq66KCt8xsZWucipq19jsYyaUPCWCplRsyHyMBMqZnhWc0XTyeK+wwgzZqIxC3Cd4UjkFSVnFn0BwI4410/aoVkE3LfEoyZMtFYlc5KJay1eAotegck0pJBn+DZ3Vre7JKM+dBTv8wmpQ9Cu2ZMJuGKoYbFaVFEFAEoemQFuD3j/4BwfmxuD1ALZCpDP4edAVVl4mJ1EtI6OHTJSHc20gPcqQsCLeAHjomFiI0pT7V8XGLV0ix/3jbHvVmDB4aDcuSNkiKejcn54e2Ffygasl6XOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zzZQWZM9LYl6MpyKqELYTI0nj6o/S7cn4qMcw9X6NY=;
 b=d+SqJNK115BK09TY5xSDLeXdukw15wnYEH+pl7+mn7MYxM+9fyk4hdHwE1elAcF2SLX61QK0glscdBAWn+tvtPeXTsLDVJs2B7U7KroJgCniUlHZPjKEGRbIAhTasm88wlmXYqTY9zP0Lp6Bv2S31j7asNpDYIBgWNXcZbestcrgUpIAhtFd2QamFW+pahxRd9o7P36c3JhS1tIgFd4rUGE384eOp5ILvQKmSJZTT86kyDvj/w15SkEika1SHcLvchg108c/HUUwrH6tQaHgxv0WJfJ/IeLjEb0X4r4bBfkIdypjAv1W1stBmQ+3KnuQBfvpdOUJGm2/m09+fFnZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zzZQWZM9LYl6MpyKqELYTI0nj6o/S7cn4qMcw9X6NY=;
 b=BsnVKW20/WyJ9JixiUSdh+4Ia9pvR/UhYA9Cf66BjYLuhQhvAynujj74aOXWAq8Y5orSMTarIi1kOYtR+0Z3kAuLISNJR708nQu1Qo/w6du/3EhybbZFLgFsCz4ge7aAz9GDKvDMpxoCYInXLUzKSY2s8ea/ok5mFzwwQEkVa/cTrurf3X7Ino1UlEWrwEAGSo9qQqV99+4a8iaNNWQrpgbayw6ZN3fbGc2+e/MD2z5hghAnMUNY5RZIwQo0GIZS1pM2gsGNPjiOh+JV3JpdZ9HF2khOLzlE1ASkIY5Si2TRufyVHLhgRoMzAvC4ENRdj2rao97ojTbgQ0I7lOFvFw==
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 23:52:31 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::e9aa:71fa:d0fd:1a7f]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::e9aa:71fa:d0fd:1a7f%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 23:52:31 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Charan Teja Kalla <charante@codeaurora.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
Thread-Topic: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
Thread-Index: AQHXS+sbP7JG2jAKA0uVYnCsOKlt46r0sTFQgAJsKQCAAO1GEA==
Date:   Thu, 27 May 2021 23:52:30 +0000
Message-ID: <BYAPR12MB34163A80AD9567746F7904CDD8239@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
 <BYAPR12MB3416727DB2BE2198C324124CD8259@BYAPR12MB3416.namprd12.prod.outlook.com>
 <2733c513-d9ca-9c33-42ee-38df0a057f8a@codeaurora.org>
In-Reply-To: <2733c513-d9ca-9c33-42ee-38df0a057f8a@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b5a8436-9aad-4081-4506-08d9216a7de4
x-ms-traffictypediagnostic: BY5PR12MB4084:
x-microsoft-antispam-prvs: <BY5PR12MB40843FC28FF7A9C83532BC1AD8239@BY5PR12MB4084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RM35+Ub2f8R7cFZON+sMIoGYy5OXj1PFw9wQGl7VhK1lr68HKQm6+3eXyqsGw417fM/S40RjJvE1rpjdAKga4/fm3WAMhYtHdOdxgkgZ1vK1lZM1lLhXv0+4JMaIkxHenbx4wv/lwTE9IMVcmbsFmdUZ9qR4UQz34qmkavCbMInnMuC4NqyB7gtcQ66mbUO7G3Dn5xxkq154PiDcJM9j04v+A749ya6XgS1GVftN9Dj6AlDXNKMWFOegLFJfUUrMk5W6RgVIjWSQ2hgC0srilvw+8Ltvb5yTZGxWiddM8kafrbDENSunhYD/cCTado5zmOAP9Bd0gN7Negyb0HvabROzU1bAxyDpEQ03n0tsyKZSjlle29UVkgiy+zZ/RIBVMJ2TCVdplsB8Ppj6fbYQJScJhwhn3x5olQF07MNAngXfFkyiOuBgZSo7V1YA4uckjCnKIYV1OCdHjzAOmm7adIUJnv0YXRL8ScYDShT60jZmBH2tYKbpT3N00Ku8avavZTWtcBM6Wfc1snuWxKRLYEUTUPR2LIjZsljM+nliW9RunrlVugS7xSBOgMqwm3VtW+nM87yHgBIgkBTkPSkbwVwWMFq1lRymnNbqvVkcLaMSZtp80MGpjpGRArwEnKBPxD5uZRrA5dz0SfYPKhooxYdwu/WDoU9sS7htE8/Dkura2jUdenJv+FCeH0TU9UuuAccI1FfrAbPlN6CNvXr+gFjdQgUl6XqiV4QHbDJKaCOrxLfFjaNMSM92vKlq+zb9w8vABheEGXDNvB3QOTA2iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(122000001)(4326008)(83380400001)(2906002)(7416002)(38100700002)(53546011)(76116006)(6506007)(5660300002)(66476007)(66556008)(66446008)(64756008)(66946007)(52536014)(186003)(26005)(316002)(55016002)(110136005)(54906003)(8936002)(966005)(7696005)(86362001)(33656002)(8676002)(9686003)(478600001)(921005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NW1idm1jZDBHVjRpdSs3ZGxEK1pTWFpnaktnUmdpb0c5cFZ4Mzl2QU5LK09T?=
 =?utf-8?B?Z1I5Qkt0RGg1bE0yR1BCbGpTODJIWDRJcmRLZ2NOQmMvU3lobGlaTzRZOGlU?=
 =?utf-8?B?bkZNV2pOMzNxR0lsdXA5WklSREpDWVlIUk10K2dZdmlxeFNja2I1NUZXQ1JV?=
 =?utf-8?B?RytNMVVWM0FXV0thblliNkNFRjZ1bDBvUnp2UWJxN2hmWGVXa1F4MjlyU2Yz?=
 =?utf-8?B?ZVZ6eFZWV2lKM0t5SUovMmdaaERVc1FNQXUzckptQlVDQWFvdVdzYXNvOWJo?=
 =?utf-8?B?SGIxY2VOaXpidmp0Ri9iWU1rNjR0d2VVQjRTU2JHSUtWY3VZaC80YVJCdHd0?=
 =?utf-8?B?VG55cFcxTW9YN3NTZE5jclQxd0xvKzc0UFlTUnJQOUFCTlBXbVY3WWJEZUlG?=
 =?utf-8?B?aDVTdUJTclpKSzlvL1ZML0greEVhVWxQUlRsekZ0cHpGaDVWM2hUMlcwT3Jk?=
 =?utf-8?B?OEtZVGtVTnZucW5MNmZnVU9selNFLy9aeWpRbEdiSE9BSVFSR2QybklyRDl3?=
 =?utf-8?B?aS81OUpQeXVJczk2cGEzZ2swRWhWM3hodGtEQkxCUG5admU5OTBvNkt3UFda?=
 =?utf-8?B?eWh4MEZsWVdLTVM5dlNWTTlDOElVSlh1RDZNZ1hTNUszUmN2R29hRlJTcFVB?=
 =?utf-8?B?U3JWSndHTWVDMk1XUk5wT0krTkNXOU9FUFJKaVM0WDBhbkV0cnJIanBUU1NN?=
 =?utf-8?B?Ky9FYUVpckdhbkdFZ1BGeE1ENmtkK0pCMTk4dTJZNmVueVZZMGVHNVRBUlZC?=
 =?utf-8?B?Wk83UzhkMkJIczJJMFVXQmN6UzdXYzNxdGdjcTZ6cnFMOEVQLzVLNGJ4MUZT?=
 =?utf-8?B?alpENllWbGp5NjhPTVRKMG9wTnY3cXJXZ2dHMktNelFGa1phK1BOVUhOR2Q3?=
 =?utf-8?B?cEtuWnN1bEFSYmNNVnlOWGFzdTNCZFNaenhmQ1FJNUl4SGM1clVkam9yWUxH?=
 =?utf-8?B?Qk53WEV3NVhVS1QxZ29sdkFUNlJGcVRtbEVOR0NoeWtRelNXYmpjN1hUazRZ?=
 =?utf-8?B?Qmw3aW96V3htQ0VhMml1c0YyaGJFTUFreEpJNmtKTE9IbWRxdk5NWTlIY05r?=
 =?utf-8?B?WXQ5RFAySnUwRkRNWGVLYk9jZ3VHZlpZWXJMZEZ0Yi9HSzVqY25CVFpMZ2la?=
 =?utf-8?B?N1FVL2JGcGZ5Ny9BcWZhZmFuTnZtYlFXYzdJZ0o4bGt5U0xkWkN1M29nWlpO?=
 =?utf-8?B?OGNtcDRaNVI1NnpEVm9DL3cxN1g4S0g3VFRnTlNPT3hSbStTdnYzbTRjbmM5?=
 =?utf-8?B?SFdXT3JNcVFMQVAzQUtiYWc5bWQ0cUlYOGhuYVJyeHh1T1Y4dVl5RUh5WTVP?=
 =?utf-8?B?QXBkUHg4VjZDa3RoT2lEQ29teVc0N1ZCdEU0MFlGVUc1Yyt0TWVzVG9lVGFX?=
 =?utf-8?B?dU4xWEJtNDNIaXZZSG5qOCtDNnVWLzc3R3prVm9MVWxBeHYxWU9oMUxmL0kw?=
 =?utf-8?B?VVhTS0luOXVacmIxQzR2K3gvZHFjd3FZaFFuaXdkQ3NrWXJTYkE3RXJ1ejdj?=
 =?utf-8?B?aHl2QzJ2YjhCeTY5NXptelRYODJvLzZlc0tvT2g0R1RDdElIUUw2YkdjTTdC?=
 =?utf-8?B?L216MkgzWTFlSFlZQ1drVWg0Uk10elUyTDRobWdSK0c1dC9OSHpWTlNibzc4?=
 =?utf-8?B?YW4rNjZhTTBVeFN2Zmo0bzlqcUZvZHlWZXRWcSswcGZJNTVpTCsxTkwyVnhU?=
 =?utf-8?B?TldMVmdBU01SeHoxcDN0eVpaV0ZvQ1AwWmFoa3Y1Qkw2VU1NQlNkSEhRSkxn?=
 =?utf-8?Q?cC3M9iHe/OAd5HIOaI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5a8436-9aad-4081-4506-08d9216a7de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 23:52:31.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyBYTmSGlSRe+9dFj6yoyokWjnL3HCO6Bry+XOLQ7Ypb2iINkBW/hgISh1/5Ji7SSSfY8bqi+yrPTNoju+SMZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2hhcmFudGU9Y29kZWF1
cm9yYS5vcmdAbWcuY29kZWF1cm9yYS5vcmcNCj4gPGNoYXJhbnRlPWNvZGVhdXJvcmEub3JnQG1n
LmNvZGVhdXJvcmEub3JnPiBPbiBCZWhhbGYgT2YgQ2hhcmFuIFRlamENCj4gS2FsbGENCj4gU2Vu
dDogVGh1cnNkYXksIE1heSAyNywgMjAyMSAyOjI4IEFNDQo+IFRvOiBOaXRpbiBHdXB0YSA8bmln
dXB0YUBudmlkaWEuY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gbWNncm9mQGtl
cm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgeXphaWtpbkBnb29nbGUuY29tOw0KPiB2
YmFia2FAc3VzZS5jejsgYmhlQHJlZGhhdC5jb207IG1hdGV1c3pub3NlazBAZ21haWwuY29tOw0K
PiBzaF9kZWZAMTYzLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsgdmlubWVub25AY29kZWF1
cm9yYS5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2
YWNrLm9yZzsgbGludXgtDQo+IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjJdIG1tOiBjb21wYWN0aW9uOiBzdXBwb3J0IHRyaWdnZXJpbmcgb2YgcHJvYWN0
aXZlDQo+IGNvbXBhY3Rpb24gYnkgdXNlcg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBUaGFua3MgTml0aW4g
Zm9yIHlvdXIgaW5wdXRzISENCj4gDQo+IE9uIDUvMjYvMjAyMSAyOjA1IEFNLCBOaXRpbiBHdXB0
YSB3cm90ZToNCj4gPiBUaGUgcHJvYWN0aXZlIGNvbXBhY3Rpb25bMV0gZ2V0cyB0cmlnZ2VyZWQg
Zm9yIGV2ZXJ5IDUwMG1zZWMgYW5kIHJ1bg0KPiA+IGNvbXBhY3Rpb24gb24gdGhlIG5vZGUgZm9y
IENPTVBBQ1RJT05fSFBBR0VfT1JERVIgKHVzdWFsbHkgb3JkZXItDQo+IDkpDQo+ID4gcGFnZXMg
YmFzZWQgb24gdGhlIHZhbHVlIHNldCB0byBzeXNjdGwuY29tcGFjdGlvbl9wcm9hY3RpdmVuZXNz
Lg0KPiA+IFRyaWdnZXJpbmcgdGhlIGNvbXBhY3Rpb24gZm9yIGV2ZXJ5IDUwMG1zZWMgaW4gc2Vh
cmNoIG9mDQo+ID4NCj4gPiBDT01QQUNUSU9OX0hQQUdFX09SREVSIHBhZ2VzIGlzIG5vdCBuZWVk
ZWQgZm9yIGFsbCBhcHBsaWNhdGlvbnMsDQo+ID4+IGVzcGVjaWFsbHkgb24gdGhlIGVtYmVkZGVk
IHN5c3RlbSB1c2VjYXNlcyB3aGljaCBtYXkgaGF2ZSBmZXcgTUIncyBvZg0KPiA+PiBSQU0uIEVu
YWJsaW5nIHRoZSBwcm9hY3RpdmUgY29tcGFjdGlvbiBpbiBpdHMgc3RhdGUgd2lsbCBlbmR1cCBp
bg0KPiA+PiBydW5uaW5nIGFsbW9zdCBhbHdheXMgb24gc3VjaCBzeXN0ZW1zLg0KPiA+Pg0KPiA+
IFlvdSBjYW4gZGlzYWJsZSBwcm9hY3RpdmUgY29tcGFjdGlvbiBieSBzZXR0aW5nDQo+IHN5c2N0
bC5jb21wYWN0aW9uX3Byb2FjdGl2ZW5lc3MgdG8gMC4NCj4gDQo+IEFncmVlLiBCdXQgcHJvYWN0
aXZlIGNvbXBhY3Rpb24gZ290IGl0cyBvd24gdXNlcyB0b28gbGlrZSBpdCBrbm93cyB3aGVuIHRv
DQo+IHN0b3AgdGhlIGNvbXBhY3Rpb24sIGluc3RlYWQgb2Ygc2ltcGx5IGRvaW5nIHRoZSBmdWxs
IG5vZGUgY29tcGFjdGlvbiwgdGh1cw0KPiB3ZSBkb24ndCB3YW50IHRvIGRpc2FibGUgaXQgYWx3
YXlzLg0KPiANCj4gPg0KPiA+DQo+ID4+IEFzIGFuIGV4YW1wbGUsIHNheSBhcHANCj4gPj4gbGF1
bmNoZXIgZGVjaWRlIHRvIGxhdW5jaCB0aGUgbWVtb3J5IGhlYXZ5IGFwcGxpY2F0aW9uIHdoaWNo
IGNhbiBiZQ0KPiA+PiBsYXVuY2hlZCBmYXN0IGlmIGl0IGdldHMgbW9yZSBoaWdoZXIgb3JkZXIg
cGFnZXMgdGh1cyBsYXVuY2hlciBjYW4NCj4gPj4gcHJlcGFyZSB0aGUgc3lzdGVtIGluIGFkdmFu
Y2UgYnkgdHJpZ2dlcmluZyB0aGUgcHJvYWN0aXZlIGNvbXBhY3Rpb24NCj4gPj4gZnJvbSB1c2Vy
c3BhY2UuDQo+ID4+DQo+ID4gWW91IGNhbiBhbHdheXMgZG86IGVjaG8gMSA+IC9wcm9jL3N5cy92
bS9jb21wYWN0X21lbW9yeSBPbiBhIHNtYWxsDQo+ID4gc3lzdGVtLCB0aGlzIHNob3VsZCBub3Qg
dGFrZSBtdWNoIHRpbWUuDQo+IA0KPiBIbW0uLi4gV2l0aCAzR0IgU25hcGRyYWdvbiBzeXN0ZW0s
IHdlIGhhdmUgb2JzZXJ2ZWQgdGhhdCB3cml0ZSB0bw0KPiBjb21wYWN0X21lbW9yeSBpcyB0YWtp
bmcgcGVhayB0aW1lIG9mIDQwMCttc2VjLCBjb3VsZCBiZSB0aGF0DQo+IE1JR1JBVEVfU1lOQyBv
biBhIGZ1bGwgbm9kZSBpcyBjYXVzaW5nIHRoaXMgcGVhaywgd2hpY2ggaXMgbXVjaCB0aW1lLg0K
PiANCj4NCj4gPg0KPiA+IEhpamFja2luZyBwcm9hY3RpdmUgY29tcGFjdGlvbiBmb3Igb25lLW9m
ZiBjb21wYWN0aW9uIChzYXksIGJlZm9yZSBhDQo+ID4gbGFyZ2UgYXBwIGxhdW5jaCkgZG9lcyBu
b3Qgc291bmQgcmlnaHQgdG8gbWUuDQo+IA0KPiBBY3R1YWxseSB3ZSBhcmUgdXNpbmcgdGhlIHBy
b2FjdGl2ZSBjb21wYWN0aW9uIHRvICdqdXN0IHByZXBhcmUgdGhlIHN5c3RlbQ0KPiBiZWZvcmUg
YXNraW5nIGZvciBodWdlIG1lbW9yeScgYXMgY29tcGFjdF9tZW1vcnkgY2FuIHRha2UgbG9uZ2Vy
IGFuZCBpcw0KPiBub3QgY29udHJvbGxhYmxlIGxpa2UgcHJvYWN0aXZlIGNvbXBhY3Rpb24uDQo+
IA0KPiBJbiB0aGUgVjEgb2YgdGhpcyBwYXRjaCwgd2UgYWN0dWFsbHkgY3JlYXRlZCBhIC9wcm9j
IGludGVyZmFjZShzaW1pbGFyIHRvDQo+IGNvbXBhY3RfbWVtb3J5KSwgcHJvdmlkaW5nIGEgd2F5
IHRvIHRyaWdnZXIgdGhlIHByb2FjdGl2ZSBjb21wYWN0aW9uIGZyb20NCj4gdXNlciBzcGFjZS4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzE0MTcwNjQvLiBCdXQgc2lu
Y2UNCj4gdGhpcyBpbnZvbHZlZCBhIG5ldyAvcHJvYyBpbnRlcmZhY2UgYWRkaXRpb24sIGluIFYy
IHdlIGp1c3QgaW1wbGVtZW50ZWQgYW4NCj4gYWx0ZXJuYXRpdmUgd2F5IHRvIGl0Lg0KPiANCj4g
QW5vdGhlciBwcm9ibGVtLCBJIHRoaW5rLCB0aGlzIHBhdGNoIHRyaWVkIHRvIGFkZHJlc3MgaXMg
dGhhdCwgaW4gdGhlIGV4aXN0aW5nDQo+IGltcGxlbWVudGF0aW9uIGl0IGlzIG5vdCBndWFyYW50
ZWVkIHRoZSB1c2VyIHNldCB2YWx1ZSBvZg0KPiBjb21wYWN0aW9uX3Byb2FjdGl2ZW5lc3MgaXMg
ZWZmZWN0aXZlIHVubGVzcyBhdGxlYXN0DQo+IEhQQUdFX0ZSQUdfQ0hFQ0tfSU5URVJWQUxfTVNF
Qyg1MDBtc2VjKSBpcyBlbGFwc2VkLCBSaWdodD8gRG9lcyB0aGlzDQo+IHNlZW1zIGNvcnJlY3Qg
cHJvdmlkZWQgd2UgaGFkIGdpdmVuIHRoaXMgdXNlciBpbnRlcmZhY2UgYW5kIGNhbid0IHNwZWNp
ZmllZA0KPiBhbnkgd2hlcmUgd2hlbiB0aGlzIHZhbHVlIHdpbGwgYmUgZWZmZWN0aXZlKHdoZXJl
IGl0IGNvbWVzIGludG8gZWZmZWN0IGluIHRoZQ0KPiBuZXh0IGNvbXBhY3QgdGhyZWFkIHdha2Ug
dXAgZm9yIHByb2FjdGl2ZSBjb21wYWN0aW9uKS4NCj4gDQo+IENvbnNpZGVyIHRoZSBiZWxvdyB0
ZXN0Y2FzZSB3aGVyZSBhIHVzZXIgdGhpbmtzIHRoYXQgdGhlIGFwcGxpY2F0aW9uIGhlIGlzDQo+
IGdvaW5nIHRvIHJ1biBpcyBwZXJmb3JtYW5jZSBjcml0aWNhbCB0aHVzIGRlY2lkZXMgdG8gZG8g
dGhlIGJlbG93IHN0ZXBzOg0KPiAxKSBTYXZlIHRoZSBwcmVzZW50IHRoZSBjb21wYWN0aW9uX3By
b2FjdGl2ZW5lc3MgKFNheSBpdCBpcyB6ZXJvIHRodXMNCj4gZGlzYWJsZWQpDQo+IDIpIFNldCB0
aGUgY29tcGFjdGlvbl9wcm9hY3RpdmVuZXNzIHRvIDEwMC4NCj4gMykgQWxsb2NhdGUgbWVtb3J5
IGZvciB0aGUgYXBwbGljYXRpb24uDQo+IDQpIFJlc3RvcmUgdGhlIGNvbXBhY3Rpb25fcHJvYWN0
aXZlbmVzcy4oc2V0IHRvIGRpc2FibGVkIGFnYWluKQ0KPiA1KSBUaGVuIHByb2FjdGl2ZSBjb21w
YWN0aW9uIGlzIHRyaWVkIHRvIHJ1bi4NCj4gDQo+IEZpcnN0LCBEb2VzIHRoZSB1c2VyIGRvaW5n
IHRoZSBhYm92ZSBzdGVwcyBhcmUgdmFsaWQ/DQo+IElmIHllcywgdGhlbiB3ZSBzaG91bGQgZ3Vh
cmFudGVlIHRvIHRoZSB1c2VyIHRoYXQgcHJvYWN0aXZlIGNvbXBhY3Rpb24NCj4gYXRsZWFzdCB0
cmllZCB0byBydW4gd2hlbiB0aGUgdXNlciBjaGFuZ2VkIHRoZSBwcm9hY3RpdmVuZXNzLg0KPiBJ
ZiBub3QsIEkgZmVlbCwgd2Ugc2hvdWxkIGRvY3VtZW50IHRoYXQgJ29uY2UgdXNlciBjaGFuZ2Vk
IHRoZQ0KPiBjb21wYWN0aW9uX3Byb2FjdGl2ZW5lc3MsIGhlIG5lZWQgdG8gd2FpdCBhdGxlYXN0
DQo+IEhQQUdFX0ZSQUdfQ0hFQ0tfSU5URVJWQUxfTVNFQyBiZWZvcmUgY29uc2lkZXJpbmcgdGhh
dCB0aGUgdmFsdWUgaGUNCj4gdHJpZWQgdG8gc2V0IGlzIGVmZmVjdGl2ZSBhbmQgcHJvYWN0aXZl
IGNvbXBhY3Rpb24gdHJpZWQgdG8gcnVuIG9uIHRoYXQnLg0KPiBEb2Vzbid0IHRoaXMgc2VlbSBv
a2F5Pw0KDQpQcm9hY3RpdmUgY29tcGFjdGlvbiBkb2VzIG5vdCBndWFyYW50ZWUgaWYgdGhlIGtl
cm5lbCB3aWxsIGJlIGFibGUgdG8gYWNoaWV2ZQ0KZnJhZ21lbnRhdGlvbiB0YXJnZXRzIGltcGxp
ZWQgZnJvbSB0aGUgY29tcGFjdGlvbl9wcm9hY3RpdmVuZXNzIHN5c2N0bC4gSXQgYWxzbw0KZG9l
cyBub3QgZ3VhcmFudGVlIGhvdyBtdWNoIHRpbWUgaXQgd2lsbCB0YWtlIHRvIHJlYWNoIGRlc2ly
ZWQgZnJhZ21lbnRhdGlvbg0KbGV2ZWxzIChpZiBhdCBhbGwgcG9zc2libGUpLiBBbHNvLCBIUEFH
RV9GUkFHX0NIRUNLX0lOVEVSVkFMX01TRUMgaXMgdGhlDQptYXhpbXVtIHNsZWVwIHRpbWUsIGRl
cGVuZGluZyBvbiByZWxhdGl2ZSB0aW1pbmcgb2YgeW91ciBzeXNjdGwgaW5wdXQgYW5kDQp0aGUg
dGltZW91dC4NCg0KVGhlIGludGVudCBvZiBwcm9hY3RpdmUgY29tcGFjdGlvbiBpcyB0byBtYWlu
dGFpbiBkZXNpcmVkIGZyYWdtZW50YXRpb24gbGV2ZWxzDQp3cnQgdGhlIGRlZmF1bHQgaHVnZXBh
Z2Ugc2l6ZSBpbiB0aGUgYmFja2dyb3VuZCBzbyB3ZSBkb24ndCBoYXZlIHRvIHBheSBsYXRlbmN5
DQpjb3N0IGFzc29jaWF0ZWQgd2l0aCBvbi1kZW1hbmQgY29tcGFjdGlvbi4gSSBkb24ndCBsaWtl
IHRoZSBpZGVhIG9mIGZvcmNpbmcgYSByb3VuZA0Kb2YgY29tcGFjdGlvbiBvbiBzeXNjdGwgd3Jp
dGUuIE1heWJlIGFkZCBhIEtjb25maWcgcGFyYW1ldGVyIGZvciBzZXR0aW5nDQpIUEFHRV9GUkFH
X0NIRUNLX0lOVEVSVkFMX01TRUMgdG8gc2F5IDFtc2VjPw0KDQpUaGFua3MsDQpOaXRpbg0KDQo=
