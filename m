Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3E31BFDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 17:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhBOQ4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 11:56:04 -0500
Received: from mail-dm6nam12on2129.outbound.protection.outlook.com ([40.107.243.129]:30601
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231261AbhBOQyR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:54:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsgK0ITjp9ZZqf99ZLvQpOUrFtLd9Dy44p6GjdH+jIaRffwTKSc0pnRO0x2Az7K++zZIkQf/sOINAXXeRqXc3pv9HEPj1gwJa3Gu5LemxjOXrBcYWESX3tabGemp9hZCF9ijXi/jtAd1r5r7rrzTnY4+GzasCzKQ925SG/FT9+DAmUA/9oa7JCDm1P5i5Xdf7jTE95CIK+qBGVQe7o8ox5CjuEBQZ7Rj+06xO4kSNZSSayyb3gGHZuWSfZkS5gFxPS4EYDZy3NJ36U87nDdXmmh6zaHHTQbN+G4AW48EJNhKjFnIB0dtqV5GI6nxnIYbP0dN/f0CdATH/F+9/99tKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuczTj+iSkYzTyVG5BD/eugM0RaJolUdI+vdJnwJD+w=;
 b=YHJRgFZ23AY15VIXa4qpgeuu5o/D9uLkNLhUbNw8DwrGFrpxNEGSgZVC8rmwthXJMdA+RQ0PiA6pYxXAYOYE0jjqn+vHi7lYUSVr8d2rJxF+aKMLnLJ2FrnVk/bw9ViXUoGkOEvBAmKx7MrCxsvwEMHQImrADn/5k5mzcbfHj4pgpiU1wGmWKFgW8ft+nPmCBWI+hG9rF+ppQ/ROUNPpNyWf5pl+fIMgTwDTddoTi0D772qtOfMQwu9Xw5xkXjIbywJyhEJgBo6ze1mi1+wMntj7i2Ruy78dlESWfBVqd68nGftXNUFC4etcj7M7P+qlf3LVdW2ngGorx1ISP40wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuczTj+iSkYzTyVG5BD/eugM0RaJolUdI+vdJnwJD+w=;
 b=ckB5GjW9HBLzYPKzEJhCFD0u3S0fzxZFrimMEOPvQmwOtZqJXB7zgAyS49lkMu0TYzaMCuK/orTn120yTlHTzfKkgOfTuoj+88KLPAJ+41liolgThjPdN4swHwEruM+YqCgQAX/A5cnQ3StG8TI7XJHSro9SXmvh+IiPVqxuc/Y=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3334.namprd13.prod.outlook.com (2603:10b6:610:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Mon, 15 Feb
 2021 16:53:23 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.025; Mon, 15 Feb 2021
 16:53:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "lhenriques@suse.de" <lhenriques@suse.de>,
        "amir73il@gmail.com" <amir73il@gmail.com>
CC:     "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Thread-Topic: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Thread-Index: AQHXA7EmiAMwHAQV80CDyBR44E7wi6pZaZuAgAAFIQA=
Date:   Mon, 15 Feb 2021 16:53:22 +0000
Message-ID: <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
         <20210215154317.8590-1-lhenriques@suse.de>
         <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11c97e1b-184f-4f5d-aa11-08d8d1d234b5
x-ms-traffictypediagnostic: CH2PR13MB3334:
x-microsoft-antispam-prvs: <CH2PR13MB33349D90AC14F3A59BB1A604B8889@CH2PR13MB3334.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:166;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSIzz5URS6AoJOXpXjhOiZpa22R/USQS1JnCuDL+L7gKrVxHtAdC4FTPMqvnneKrT6mw71EcCNAXNo0TDb3+EbE0NcLlDzw92HmbrpjemsugObQPf7f/AZ597M1q2i7J1p6Xeq09tpap5xtETQQvy29GcH4kkVfNj/coW0lZCCZbfs5BBkN4kq+OkHZb51IgganNT88HVXhhNhezaZO7KTJyeJ2K17PI1fuG+ifH/gNDJGAYQnBlNY5io+5NHyxiTAkYapS0TkwWieOhh9WKPBefE1MholTb8D5kHvwGGveA2j5S8cTgj4eWO0FB0dLfh/XVQfDBjRVljMsTaLMQwKo3YBzUbBCr66GN7ri1LawhELdYapHi3qPPMraK7w1wUmpmgy27i5WWT5TgBhJkObdE6BLpyyk0A0cN/D5EmwlE3v9Zqhv9HW3Pv4xHsqzeubl/TvFumtytug4g2Y8xwkJXcxhzvS2v+U1nqtFBhcch2tCwFy1JM+SrZ0hmUMmYUVUK0yN23rhdVXAnflfK3Rxfahoexxqi733fV5zWNb0TvoXcmvYU/JT5/SyQfjiVbvFW1CTWRjbwxcpUcGus9hsiKfRYcF+WJYYjG6Wn9tk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(366004)(376002)(346002)(66556008)(86362001)(66946007)(66476007)(2906002)(110136005)(76116006)(36756003)(966005)(5660300002)(316002)(7416002)(64756008)(71200400001)(66446008)(8936002)(6512007)(6486002)(4326008)(478600001)(54906003)(26005)(186003)(2616005)(8676002)(83380400001)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dGxOaEhzdnYxRzI1em5qNk9lRUFlSmxxbUVjTVltV0UrUVlVa2szb2pWb3U4?=
 =?utf-8?B?OFpTOHdSeFB1dU1CblAvWlR3anVxdWhyVFZnYUI2T2kvenJvRVY4TytOZzBB?=
 =?utf-8?B?RGh5M2U4Q1ZKSWRzbGQvMUIvL2dvQ3F4MmdNREpNbHpSZnhLRWhHT0lEV3Ru?=
 =?utf-8?B?ckRBM3BDYmhVZFh2T3RsakdDZmZSbm4vRGNVL3pwTXdkc0p5Yzlhblk4Sk9r?=
 =?utf-8?B?WDdHNmtPblZTS1lLeUk0UUtxOVZPUGg4NEcrVlpPRVlDWG1IREhWRjdwTHVF?=
 =?utf-8?B?Y0dpV2RUR0xzR210akVIZGE2dWc1WFVONjJEcmR2N3VMRkxvd05WYXNZU2FZ?=
 =?utf-8?B?NWhtWTFvcGZXZzlaOGRRY2YrVjdmUldOSGcvSytaQ3UvYVVxcWN4ZlhzdHYz?=
 =?utf-8?B?MFdKMHhHSU9FS25nRnhFTHIyRUV4b1M1alZyME5tYXpJajF3Z0hVYWl0NjM2?=
 =?utf-8?B?WUZ6TTBMOERZM0NibnFybG44akpSa295cHZrV3ZYb0JUcGJXWWI5eU9iczJJ?=
 =?utf-8?B?bHc0eHhFV2tpdjlxVDN0VmFPRXdhNU9xc2ZmY1ZyNDlXeUgvczZDWnM3dXZa?=
 =?utf-8?B?Mk1tRmE1UmdhSXlWeVZVcGFGYm45c2ordUxkRGwyZmFta2tJb3Z2UTErZ3ZT?=
 =?utf-8?B?aFJmT2RGN1ZieCtLWm1rM1gvL1JZRi82d3hvV25rZXpUSFZ5Ulo2T0ZMbEV0?=
 =?utf-8?B?V3Y3MDNxL3dKaWNRaC8xUk9iY1o2OWNWMXhKMHBmWmRtWDRJVUliRjZuWC9S?=
 =?utf-8?B?R1BOV0FmVHplemt0NUh6R3ZXOU5EVFZkdlVDU1FjeU9lZk1sd2pkazJ0Q3VJ?=
 =?utf-8?B?ZlhxZkhLWXNES1FJUVFjVXlSWXhiWllUcVNkUEtOMC9YUWFnVDVRdmxtRzMz?=
 =?utf-8?B?Vkh0V28yeXg2UVpCeVdYdDBJc0U1THgvaHZ1U1laUGo2SEEvZThRMUJBcTBU?=
 =?utf-8?B?U1BNakV2NHBWaENYWDdyamdBcTUyWFc4S3Q5c1RtTTdKVjJVQlM1Z01JcDdG?=
 =?utf-8?B?ajRFNkc0NFJtQ2w3cFhrV2t2a1hlbUFhYUlxVGZxZ25ZMHdBYit4TUo3MHZq?=
 =?utf-8?B?a3k5aFV6V2dWVEM4cGdYUGhsSEo0YWNNYU9LK1BRb3lRNmorbTdJOUtqbE5V?=
 =?utf-8?B?S2VPYTg4SGVTWnN1TUJYMHAzTHRWOWlnd3EyYlpEenhqNzdia0lrM3RyaTNT?=
 =?utf-8?B?bXkwM3hJakpNOWZmeXhtdFpDMDJrdzgxaVQxM1VvYWxJLzN0enoxT3RaL2Z1?=
 =?utf-8?B?S2MwSXdaeEVVdHpIbWVtaWNTdlhKOTJQK2ZJNXBEL2ZsOFBpNmNPcW9uS3Ax?=
 =?utf-8?B?NElPTS8rRUpYVW1RMnBEYUdBa1lWcTh0MjFwWUxpbU5yaHE2UjJjSDFxZVVM?=
 =?utf-8?B?bExoSHlIRTdib09uYVBsRHI3aVdKNmlEeHRFeVJ0UTVsRU9tTnpuazVUd3Np?=
 =?utf-8?B?QWxlNG5rRVVxNjJnd00yUlY5MHdRVHBpZXVqSHAwZFhrZ2RsbnpiaGxIWHh5?=
 =?utf-8?B?M0FLaXdMdllsbXdZZDdxMWRYM3FNSmRoNE0vSjJQbmd1QjVBZDk1bDgrTlNH?=
 =?utf-8?B?cFZ0VDRoMDNwbTNkVCt0R3cyMEZKdTdzVTBrMVJjVEZTcWprVU9Tem4xU0Nq?=
 =?utf-8?B?R01hTFJzdnQ4YjlLcjFaVXl0bWsyamErckFCN1dZMk5aR1lsNFhEeGFUT1pR?=
 =?utf-8?B?TlJvV0ZhS2F4WTVWa0w2a2ZaWk1wNFA3TlBvQjd2dW5OeUFyMjF0Rkc5YnA3?=
 =?utf-8?Q?YLddZwM4BqS+jlsSWeOzG+q3FwapPgjxj8oLUyi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <78851346D1F2BA46982AD97EBBEB9FE0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c97e1b-184f-4f5d-aa11-08d8d1d234b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 16:53:22.9813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpvjZ9aQfiXCZ32ReVttM190EDQrHmZDfuwhMPFfuiHu9q0djZ4PTcBth+XtM3/oiTYsmIZze1MHdjzRFx1+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3334
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTE1IGF0IDE4OjM0ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gTW9uLCBGZWIgMTUsIDIwMjEgYXQgNTo0MiBQTSBMdWlzIEhlbnJpcXVlcyA8bGhlbnJp
cXVlc0BzdXNlLmRlPg0KPiB3cm90ZToNCj4gPiANCj4gPiBOaWNvbGFzIEJvaWNoYXQgcmVwb3J0
ZWQgYW4gaXNzdWUgd2hlbiB0cnlpbmcgdG8gdXNlIHRoZQ0KPiA+IGNvcHlfZmlsZV9yYW5nZQ0K
PiA+IHN5c2NhbGwgb24gYSB0cmFjZWZzIGZpbGUuwqAgSXQgZmFpbGVkIHNpbGVudGx5IGJlY2F1
c2UgdGhlIGZpbGUNCj4gPiBjb250ZW50IGlzDQo+ID4gZ2VuZXJhdGVkIG9uLXRoZS1mbHkgKHJl
cG9ydGluZyBhIHNpemUgb2YgemVybykgYW5kIGNvcHlfZmlsZV9yYW5nZQ0KPiA+IG5lZWRzDQo+
ID4gdG8ga25vdyBpbiBhZHZhbmNlIGhvdyBtdWNoIGRhdGEgaXMgcHJlc2VudC4NCj4gPiANCj4g
PiBUaGlzIGNvbW1pdCByZXN0b3JlcyB0aGUgY3Jvc3MtZnMgcmVzdHJpY3Rpb25zIHRoYXQgZXhp
c3RlZCBwcmlvcg0KPiA+IHRvDQo+ID4gNWRhZTIyMmE1ZmYwICgidmZzOiBhbGxvdyBjb3B5X2Zp
bGVfcmFuZ2UgdG8gY29weSBhY3Jvc3MgZGV2aWNlcyIpDQo+ID4gYW5kDQo+ID4gcmVtb3ZlcyBn
ZW5lcmljX2NvcHlfZmlsZV9yYW5nZSgpIGNhbGxzIGZyb20gY2VwaCwgY2lmcywgZnVzZSwgYW5k
DQo+ID4gbmZzLg0KPiA+IA0KPiA+IEZpeGVzOiA1ZGFlMjIyYTVmZjAgKCJ2ZnM6IGFsbG93IGNv
cHlfZmlsZV9yYW5nZSB0byBjb3B5IGFjcm9zcw0KPiA+IGRldmljZXMiKQ0KPiA+IExpbms6IA0K
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvMjAyMTAyMTIwNDQ0MDUu
NDEyMDYxOS0xLWRyaW5rY2F0QGNocm9taXVtLm9yZy8NCj4gPiBDYzogTmljb2xhcyBCb2ljaGF0
IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVpcyBIZW5yaXF1
ZXMgPGxoZW5yaXF1ZXNAc3VzZS5kZT4NCj4gDQo+IENvZGUgbG9va3Mgb2suDQo+IFlvdSBtYXkg
YWRkOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+DQo+IA0KPiBJIGFncmVlIHdpdGggVHJvbmQgdGhhdCB0aGUgZmlyc3QgcGFyYWdyYXBoIG9m
IHRoZSBjb21taXQgbWVzc2FnZQ0KPiBjb3VsZA0KPiBiZSBpbXByb3ZlZC4NCj4gVGhlIHB1cnBv
c2Ugb2YgdGhpcyBjaGFuZ2UgaXMgdG8gZml4IHRoZSBjaGFuZ2Ugb2YgYmVoYXZpb3IgdGhhdA0K
PiBjYXVzZWQgdGhlIHJlZ3Jlc3Npb24uDQo+IA0KPiBCZWZvcmUgdjUuMywgYmVoYXZpb3Igd2Fz
IC1FWERFViBhbmQgdXNlcnNwYWNlIGNvdWxkIGZhbGxiYWNrIHRvDQo+IHJlYWQuDQo+IEFmdGVy
IHY1LjMsIGJlaGF2aW9yIGlzIHplcm8gc2l6ZSBjb3B5Lg0KPiANCj4gSXQgZG9lcyBub3QgbWF0
dGVyIHNvIG11Y2ggd2hhdCBtYWtlcyBzZW5zZSBmb3IgQ0ZSIHRvIGRvIGluIHRoaXMNCj4gY2Fz
ZSAoZ2VuZXJpYyBjcm9zcy1mcyBjb3B5KS7CoCBXaGF0IG1hdHRlcnMgaXMgdGhhdCBub2JvZHkg
YXNrZWQgZm9yDQo+IHRoaXMgY2hhbmdlIGFuZCB0aGF0IGl0IGNhdXNlZCBwcm9ibGVtcy4NCj4g
DQoNCk5vLiBJJ20gc2F5aW5nIHRoYXQgdGhpcyBwYXRjaCBzaG91bGQgYmUgTkFDS2VkIHVubGVz
cyB0aGVyZSBpcyBhIHJlYWwNCmV4cGxhbmF0aW9uIGZvciB3aHkgd2UgZ2l2ZSBjcmFwIGFib3V0
IHRoaXMgdHJhY2VmcyBjb3JuZXIgY2FzZSBhbmQgd2h5DQppdCBjYW4ndCBiZSBmaXhlZC4NCg0K
VGhlcmUgYXJlIHBsZW50eSBvZiByZWFzb25zIHdoeSBjb3B5IG9mZmxvYWQgYWNyb3NzIGZpbGVz
eXN0ZW1zIG1ha2VzDQpzZW5zZSwgYW5kIHBhcnRpY3VsYXJseSB3aGVuIHlvdSdyZSBkb2luZyBO
QVMuIENsb25lIGp1c3QgZG9lc24ndCBjdXQNCml0IHdoZW4gaXQgY29tZXMgdG8gZGlzYXN0ZXIg
cmVjb3ZlcnkgKHdoZXJlYXMgYmFja3VwIHRvIGEgZGlmZmVyZW50DQpzdG9yYWdlIHVuaXQgZG9l
cykuIElmIHRoZSBjbGllbnQgaGFzIHRvIGRvIHRoZSBjb3B5LCB0aGVuIHlvdSdyZQ0KZWZmZWN0
aXZlbHkgZG91YmxpbmcgdGhlIGxvYWQgb24gdGhlIHNlcnZlciwgYW5kIHlvdSdyZSBhZGRpbmcN
CnBvdGVudGlhbGx5IHVubmVjZXNzYXJ5IG5ldHdvcmsgdHJhZmZpYyAob3IgYXQgdGhlIHZlcnkg
bGVhc3QgeW91IGFyZQ0KZG91YmxpbmcgdGhhdCB0cmFmZmljKS4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
