Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98E83E1AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 19:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhHERni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 13:43:38 -0400
Received: from mail-dm6nam08on2102.outbound.protection.outlook.com ([40.107.102.102]:4001
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240397AbhHERna (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU+8Ez7inl2niJbVnyBqdlqez+pcDaVgVvaXyumm1jWaVXIzcRyDYtCaQFbVlZKvhuJUIUwr4bYL9gZizEMOO5v3tFbOpzsvHbt/EG2b9RZWxXNvUHT+YOusXx8yl+3tcy2uhuywQtFasgdbJ2liWiziGycpz0kJkehMN0XYLIScKs78134dGQkl4bF5Pu3BoDxgjnSoxg7qq575KdcxbFGu2b10CmBIXo3qGBeq1c4fsyiEZzJwEJNcgbqx0RZ5oDAETmoBEnGLW2Td04/DR0CfZL01mOy5Za9Ks6p85SfgurM2f/Sw4le7swWLhtRtPVdouhD7UqrfB+Y/tzxbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcvEYF+LFtaCxU+KgrO90klDZQsSutuClZu0qa9GA5E=;
 b=kv0PBpy+lywE26x+cAYzhKjwcJdwJmTFOxnP/yuab61hCflqEnTSzBij/U4upKLXzMRXAKpGt5QRvxMEflHMf119fyyo58wmD1jYECrtD/PLL5o0OAEIUStJaW7HZcQml8uVonN2PMQh+sWu8kmFIMg2xr9KtprDkz8bZa0iLTcKvJk9xI46gzrx/xK7KatNaVioHIfpYgy/CJUh89mE1a8DEgsWGvUQ6TetbKCMRl5LF33S3YMA8mHuozLCMCUFMrHh+0ied3TdNlstm3D7IkTdcwQnMydrp9ytPKrBM+aSgVzKj7vU+j4StQvSmq5XNlxHGVCKp/8cznTT0aD6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcvEYF+LFtaCxU+KgrO90klDZQsSutuClZu0qa9GA5E=;
 b=NyABwiXm074c3HJ3EwuEbzgQFR+0DyAvhWBtSsd0IabQoT/XINh2TV9//RrYSObH2yh8bs6XsVzbmejVD6p7o+mQfjx8hF6lVz19bKzw9CuSem3AcCUZD7EP3wXljWRPm5SDNuhzFVFFNQS4Al8NHrBdfVHab0HomAMY393YsdI=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 DM6PR13MB2587.namprd13.prod.outlook.com (2603:10b6:5:136::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.5; Thu, 5 Aug 2021 17:43:11 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9925:b22d:a3ca:1ff0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9925:b22d:a3ca:1ff0%8]) with mapi id 15.20.4415.007; Thu, 5 Aug 2021
 17:43:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "nspmangalore@gmail.com" <nspmangalore@gmail.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asmadeus@codewreck.org" <asmadeus@codewreck.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "devel@lists.orangefs.org" <devel@lists.orangefs.org>,
        "hubcap@omnibond.com" <hubcap@omnibond.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>
Subject: Re: Canvassing for network filesystem write size vs page size
Thread-Topic: Canvassing for network filesystem write size vs page size
Thread-Index: AQHXihf6hOJE9a6TVUqeuJkvzGR9DKtlKgiAgAAEfAA=
Date:   Thu, 5 Aug 2021 17:43:09 +0000
Message-ID: <0211d015a215b3d343bfbaad838179c41a1289c5.camel@hammerspace.com>
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
         <YQvpDP/tdkG4MMGs@casper.infradead.org>
         <YQvbiCubotHz6cN7@casper.infradead.org>
         <1017390.1628158757@warthog.procyon.org.uk>
         <1170464.1628168823@warthog.procyon.org.uk>
         <1186271.1628174281@warthog.procyon.org.uk>
         <1219713.1628181333@warthog.procyon.org.uk>
         <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com>
In-Reply-To: <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c059a2b4-935e-45d3-7d5c-08d958387d90
x-ms-traffictypediagnostic: DM6PR13MB2587:
x-microsoft-antispam-prvs: <DM6PR13MB2587E9A923097C370557D08BB8F29@DM6PR13MB2587.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhJLbU1LmvOD36x9I1N7c9qJlsLCO+4N6/DGtE/y2OmsuZx4w9W67a96VcfKC9x/uQfVUtavT0zqiljnnDE1ng52mn2KqhnS/m7vFo+td/q0+OoZgwnQXAmobQcbcJ3uEknniSc+3D2T7ZXnUkumCffMBNFolWRht7D6QgNCYvwvdn0MOkCNfoYViJz8HzJmtEj1JaUa6TlMu24ipr5agOPxL79lt9zAPDEAAU1g10gIxJc9KnxWdj2+A0Oc00yJYDjaLO7dX5Jm2yInaiZpmcsqxs7j9ZCxEPQi2cYdhLw9m7bDPo/WC8MEQk/6a3Q4M6H/s4HCGa1iNZRx8oxnyVJidZyxeInp/XhFbMqjTKPW4/AVQdXYwz0tjOqbSlXwgiuejT7nCsF2AFycZVGZcCQV7sjvLF6/GzLnMcCh+craoF7ymoqVJ04QoqLAaxCaZS4KVZ0UOiLjb66mJb//NDVPjqVM1AIZ2dv/f1Ghf2dp2OhoA+KzBsMeRcRUzveIrXArZnQ8XWSIv6sF6TU4H5+83Tw3eEImzC48NGvQvU0B08SxsAPtJ3fcpaFGfMbwIVXMgcaRMikKQ5zYAe8UAPrKBV2Wi160GqKsqKDoih2d/fz6AT9ZwMTWudOk9IUh0A+JfIXtXf7Zj9OY8qH3JVllg+zkeg7rCsu8TbQKsDuGMG+lJ0koL1KdPBsBIl1ZMMZd0Obqq7JUzl/shoJqcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39830400003)(366004)(83380400001)(26005)(2616005)(71200400001)(5660300002)(4326008)(122000001)(38100700002)(316002)(36756003)(86362001)(2906002)(186003)(7416002)(110136005)(66556008)(91956017)(76116006)(66946007)(8676002)(6506007)(6486002)(54906003)(8936002)(53546011)(64756008)(66446008)(66476007)(38070700005)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXl0WkdkTitFWktpNGlOSTJDRlV6Qm1YRUhBOVdsVWhhVUJBL1lnNlF0VHBO?=
 =?utf-8?B?NUpJdXFVYm1UcTR3cHpjUmg1elpWaVZNUDJjZmpmVVlqNUs0L3p3VGxwekhr?=
 =?utf-8?B?WmRQck1VQmtmSFVLTGhJTVh4enI0Q1k5ZEtScXBXTFdiUDRERlU2RGhDNjky?=
 =?utf-8?B?bEFkZDh3cldOalZIYzBuMDUvSzlsNUVGS3BvZy9tN1FBMWJtTkx5T2JMRExQ?=
 =?utf-8?B?WkFEYzBRUlBSZ1JaQjZpR3RLVmpzeW1XMkFEc1NPUWZPL0t1cjMrUXVvQkdr?=
 =?utf-8?B?ZEZ5N0lQY2lxRXBiWnZtRFBYWXBpMHVGTUdQSUZzOStXMEtYRXkwUnBWZGYr?=
 =?utf-8?B?aEVSOEYyWDBkTzdodmVSSWw4TVNrSVZQb0g2bFlxTGNTeHVUN1R5dkUwY1N1?=
 =?utf-8?B?Qk5vY0ZDQkg5UDQyWHJzK1NHcjBoalkvU2hTc3pkZjhlSWFlSy9tRVVFS3A3?=
 =?utf-8?B?OGxDcitMc3Q4MUhsVzVBdC84U2lYT3kwd0s5Ny8zck1KWWVEMUZ5K2dTeDRW?=
 =?utf-8?B?eWxqQXZFVG8rREFJakxNOTBOVUZKNGxlWWhzUXlNdmVtbkdZcTJOK01pc01w?=
 =?utf-8?B?dmZyMzZKeTc1RkN5ZklUTHR6dkY2Um1nSy9qSm9uaGF2cXc1UkRpYUp5ck14?=
 =?utf-8?B?KzRwYlRiSGpiWHArQzA2SisxMEM5d1BNVjMxMS9TYys3YUxvWDBaNWFTc21v?=
 =?utf-8?B?UXMrY0J3dzhPNllVK2Q4NHd4TVF6NlR5T1RTSVJRMGxVeFJpT28zdko3bXRB?=
 =?utf-8?B?Um14cE5IWDdPbTc0YmkweDhhLzNUNXNYSGZWRnBBK1MwNmJFN3ZaK2xmUHNJ?=
 =?utf-8?B?YmNHek1aMTZlRWdDTTYrSVNuMlZ2S3hkL0w1Unl0ZUJnYjJkeFNjaElPQkZ4?=
 =?utf-8?B?ZUU3OGpncTM5dXZJdzlkRDF4MENJZkdMV1RyVE0wZ3VhRGZtcHBubGM4aDMy?=
 =?utf-8?B?dzhqbDlPczNtak5JV1Nua3lZNXZGVkI1Y25PcjgwbXc5Y2FRdzV6Z0RsN3VT?=
 =?utf-8?B?aWV0RXh3YkhpZVJQSDFBcDVnVWNkWTZJMGZJK1pKRTExMU54Zm0rZ2lBVFRn?=
 =?utf-8?B?RHVjNFBIamxvQzFsczdVZmpHRzM3aWVmRW5xSDdmbW1iM2hYR2NXVGYvd3NX?=
 =?utf-8?B?OVBTRGxEZzNibUdCNG5OcmtOSVZXc2VLR0JHQzFYTHRWU3ZTQVhBbm5RU0p3?=
 =?utf-8?B?UnQxZC8xVnE0bjdOTVZiVmc4WSt0UUxHR3VSa2JHblU0TXEzM1gzN09aWCtI?=
 =?utf-8?B?RUxWRitvaFNpenlmR0Q4WjlyWDNtcDRvVTBjUFNOaW1zQ2JEQ1dTQzRDVHBW?=
 =?utf-8?B?SjZadE9OQnlvbkRRZmpTcXVOZjdsYzFKYXpSUktYa2NRMytKRHp1cnZ0TmJY?=
 =?utf-8?B?aldnLzNEOXdqT3liRWxTNnVNejFVdUN5dStpUGJpSURST3V3T0ZsekQybk4x?=
 =?utf-8?B?b0ZLY1BrR09LcWpPeTVLak1USHJqTEp3TjgraElBSVN5a0pIRCtSK0R2UW9U?=
 =?utf-8?B?SWtBcDVEeVp6b3VteUFHdVZxWmF4QzBaL2dyUmhObi94NDd0SkYwWmNtcGt4?=
 =?utf-8?B?NHVHWUhWdnVBQksvVUZBWWtPYVQxRGxMdEkwWnU4MUFWb3RDTUQzY2U5dlNY?=
 =?utf-8?B?WTZUQlFoVFpCdm9Ec3hjV3Z3MlJEc000NFJmaE9UQU9EbHcweG1kMkVFSnlD?=
 =?utf-8?B?NzhLSlkvWUNzemF0SGNjZ1JGL25Qc0x4QnlsZ1BKTmdKLzhUdG54R2QyWnVK?=
 =?utf-8?Q?CIwBaq0kgbHrgcxgTYl1ORKPo/bAfaLu2B3K2//?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A876B5C48B7204BA119B27766ED960F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c059a2b4-935e-45d3-7d5c-08d958387d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 17:43:09.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZrRqt1XZfI7KssT+eRIfBJ3XPC2DbGV37fMWHrcHvtTzKLc+9L7YS9dHWmyGsO+NT3m6S52NJq0gcK1etuPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2587
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTA1IGF0IDEwOjI3IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gVGh1LCBBdWcgNSwgMjAyMSBhdCA5OjM2IEFNIERhdmlkIEhvd2VsbHMgPGRob3dlbGxz
QHJlZGhhdC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IFNvbWUgbmV0d29yayBmaWxlc3lzdGVt
cywgaG93ZXZlciwgY3VycmVudGx5IGtlZXAgdHJhY2sgb2Ygd2hpY2gNCj4gPiBieXRlIHJhbmdl
cw0KPiA+IGFyZSBtb2RpZmllZCB3aXRoaW4gYSBkaXJ0eSBwYWdlIChBRlMgZG9lczsgTkZTIHNl
ZW1zIHRvIGFsc28pIGFuZA0KPiA+IG9ubHkgd3JpdGUNCj4gPiBvdXQgdGhlIG1vZGlmaWVkIGRh
dGEuDQo+IA0KPiBORlMgZGVmaW5pdGVseSBkb2VzLiBJIGhhdmVuJ3QgdXNlZCBORlMgaW4gdHdv
IGRlY2FkZXMsIGJ1dCBJIHdvcmtlZA0KPiBvbiBzb21lIG9mIHRoZSBjb2RlIChyZWFkOiBJIG1h
ZGUgbmZzIHVzZSB0aGUgcGFnZSBjYWNoZSBib3RoIGZvcg0KPiByZWFkaW5nIGFuZCB3cml0aW5n
KSBiYWNrIGluIG15IFRyYW5zbWV0YSBkYXlzLCBiZWNhdXNlIE5GU3YyIHdhcyB0aGUNCj4gZGVm
YXVsdCBmaWxlc3lzdGVtIHNldHVwIGJhY2sgdGhlbi4NCj4gDQo+IFNlZSBmcy9uZnMvd3JpdGUu
YywgYWx0aG91Z2ggSSBoYXZlIHRvIGFkbWl0IHRoYXQgSSBkb24ndCByZWNvZ25pemUNCj4gdGhh
dCBjb2RlIGFueSBtb3JlLg0KPiANCj4gSXQncyBmYWlybHkgaW1wb3J0YW50IHRvIGJlIGFibGUg
dG8gZG8gc3RyZWFtaW5nIHdyaXRlcyB3aXRob3V0DQo+IGhhdmluZw0KPiB0byByZWFkIHRoZSBv
bGQgY29udGVudHMgZm9yIHNvbWUgbG9hZHMuIEFuZCByZWFkLW1vZGlmeS13cml0ZSBjeWNsZXMN
Cj4gYXJlIGRlYXRoIGZvciBwZXJmb3JtYW5jZSwgc28geW91IHJlYWxseSB3YW50IHRvIGNvYWxl
c2NlIHdyaXRlcw0KPiB1bnRpbA0KPiB5b3UgaGF2ZSB0aGUgd2hvbGUgcGFnZS4NCj4gDQo+IFRo
YXQgc2FpZCwgSSBzdXNwZWN0IGl0J3MgYWxzbyAqdmVyeSogZmlsZXN5c3RlbS1zcGVjaWZpYywg
dG8gdGhlDQo+IHBvaW50IHdoZXJlIGl0IG1pZ2h0IG5vdCBiZSB3b3J0aCB0cnlpbmcgdG8gZG8g
aW4gc29tZSBnZW5lcmljDQo+IG1hbm5lci4NCj4gDQo+IEluIHBhcnRpY3VsYXIsIE5GUyBoYWQg
dGhpbmdzIGxpa2UgaW50ZXJlc3RpbmcgY3JlZGVudGlhbCBpc3N1ZXMsIHNvDQo+IGlmIHlvdSBo
YXZlIG11bHRpcGxlIGNvbmN1cnJlbnQgd3JpdGVycyB0aGF0IHVzZWQgZGlmZmVyZW50ICdzdHJ1
Y3QNCj4gZmlsZSAqJyB0byB3cml0ZSB0byB0aGUgZmlsZSwgeW91IGNhbid0IGp1c3QgbWl4IHRo
ZSB3cml0ZXMuIFlvdSBoYXZlDQo+IHRvIHN5bmMgdGhlIHdyaXRlcyBmcm9tIG9uZSB3cml0ZXIg
YmVmb3JlIHlvdSBzdGFydCB0aGUgd3JpdGVzIGZvcg0KPiB0aGUNCj4gbmV4dCBvbmUsIGJlY2F1
c2Ugb25lIG1pZ2h0IHN1Y2NlZWQgYW5kIHRoZSBvdGhlciBub3QuDQo+IA0KPiBTbyB5b3UgY2Fu
J3QganVzdCB0cmVhdCBpdCBhcyBzb21lIHJhbmRvbSAicGFnZSBjYWNoZSB3aXRoIGRpcnR5IGJ5
dGUNCj4gZXh0ZW50cyIuIFlvdSByZWFsbHkgaGF2ZSB0byBiZSBjYXJlZnVsIGFib3V0IGNyZWRl
bnRpYWxzLCB0aW1lb3V0cywNCj4gZXRjLCBhbmQgdGhlIHBlbmRpbmcgd3JpdGVzIGhhdmUgdG8g
a2VlcCBhIGZhaXIgYW1vdW50IG9mIHN0YXRlDQo+IGFyb3VuZC4NCj4gDQo+IEF0IGxlYXN0IHRo
YXQgd2FzIHRoZSBjYXNlIHR3byBkZWNhZGVzIGFnby4NCj4gDQo+IFsgZ29lcyBvZmYgYW5kIGxv
b2tzLiBTZWUgIm5mc193cml0ZV9iZWdpbigpIiBhbmQgZnJpZW5kcyBpbg0KPiBmcy9uZnMvZmls
ZS5jIGZvciBzb21lIG9mIHRoZSBleGFtcGxlcyBvZiB0aGVzZSB0aGluZ3MsIGFsdGhqb3VnaCBp
dA0KPiBsb29rcyBsaWtlIHRoZSBjb2RlIGlzIGxlc3MgYWdncmVzc2l2ZSBhYm91dCBhdm9kaW5n
IHRoZQ0KPiByZWFkLW1vZGlmeS13cml0ZSBjYXNlIHRoYW4gSSB0aG91Z2h0IEkgcmVtZW1iZXJl
ZCwgYW5kIG9ubHkgZG9lcyBpdA0KPiBmb3Igd3JpdGUtb25seSBvcGVucyBdDQo+IA0KDQpBbGwg
Y29ycmVjdCwgaG93ZXZlciB0aGVyZSBpcyBhbHNvIHRoZSBpc3N1ZSB0aGF0IGV2ZW4gaWYgd2Ug
aGF2ZSBkb25lDQphIHJlYWQtbW9kaWZ5LXdyaXRlLCB3ZSBjYW4ndCBhbHdheXMgZXh0ZW5kIHRo
ZSB3cml0ZSB0byBjb3ZlciB0aGUNCmVudGlyZSBwYWdlLg0KDQpJZiB5b3UgbG9vayBhdCBuZnNf
Y2FuX2V4dGVuZF93cml0ZSgpLCB5b3UnbGwgbm90ZSB0aGF0IHdlIGRvbid0IGV4dGVuZA0KdGhl
IHBhZ2UgZGF0YSBpZiB0aGUgZmlsZSBpcyByYW5nZSBsb2NrZWQsIGlmIHRoZSBhdHRyaWJ1dGVz
IGhhdmUgbm90DQpiZWVuIHJldmFsaWRhdGVkLCBvciBpZiB0aGUgcGFnZSBjYWNoZSBjb250ZW50
cyBhcmUgc3VzcGVjdGVkIHRvIGJlDQppbnZhbGlkIGZvciBzb21lIG90aGVyIHJlYXNvbi4NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
