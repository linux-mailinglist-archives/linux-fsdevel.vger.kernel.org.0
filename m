Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ABD14AA28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 20:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0TBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 14:01:12 -0500
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:6048
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgA0TBM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:01:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO6DVAe3M84WeEAutqLZoE2sB9Bh+gctbH9ZvliO6T8cXf8PVjXMtnRqyEcWvg361Y78R2r3glmjzossHEHEov9qxDnhYyJGJ7gz2VOYwt+uLZeUF6fxsJLL5AS31xE/HtUjzYDR2Fan1CZ/7zfAMd8YxZIPEM9/2iaRuyyE82ISXIGrON/f3o8r0YBM0MV33d/h8vj2V79CEN2k5wdVBEquK/408OFXC3k8DRbr0KAb3dqxSEMoOMigI8XuM7aWOsoWWNlRXAUb22hIpvxWbD0m8ODXrp4p+EpMWrSGXpFViQ83oX38Zh2k8zwlAOx1zjMumnXWqqdj52dWwFkyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb1Rz5CZxRXG2/aBqJIumHO57dC+AaGzPKe/o2nKcX0=;
 b=UrJScjaNjRE8tmlUnpWgnA3iGlJdnYTKn1MQ6CrOkHGPyNWWDnib84m7WVfye0QRSwvB4N/oz+M6Mrj/xX91SAAZkf6Ff0cARFmN5C/YY9wy9qir62WyLwH2GnEMIbZQaTiEHPCziH09Q4WMEMxQCXsbHu8L/rybAYS/7ucxM7PGfZ7d8hEjcBuxdNpISNYdGnDoqZWfR9vWsIyulZLUzjwsgXD+brgWq9pPQvZ22jXtCbK4fadM4iXSiR0sd0hP9iWBt7tE12G80il+T4eNqS0pru0nxAnaufiJ6v1leZ4FR2lZH6iZE3IUSP6Ojh9w4yACNIvr/YVfQc55vKW75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb1Rz5CZxRXG2/aBqJIumHO57dC+AaGzPKe/o2nKcX0=;
 b=h4YrHvcq2kL5a/Z9XReRWzVGLhgUIHzjJXHQrcUF8aeNbtUzFeuFShOOqeRlo+ZliUkfsXLyiBxXj/tqNk/nalfIMwz2jOLtXLGhh0WDcItJjXEnzgH7nBOy7xNA0C/92N3Ps2sI9Tt5TmUpK2v1EMJeU3B1LqibPCq+STyGUyY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5053.eurprd05.prod.outlook.com (20.177.50.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.26; Mon, 27 Jan 2020 19:01:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.026; Mon, 27 Jan 2020
 19:01:07 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:91::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.18 via Frontend Transport; Mon, 27 Jan 2020 19:01:05 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iw9d6-0001Ut-Aw; Mon, 27 Jan 2020 15:01:00 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "jglisse@redhat.com" <jglisse@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Thread-Topic: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Thread-Index: AQHV1UQg6r68G5UmKUikPgSFBMJEjg==
Date:   Mon, 27 Jan 2020 19:01:07 +0000
Message-ID: <20200127190100.GA1823@ziepe.ca>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
In-Reply-To: <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39692c55-ec6a-4c32-556d-08d7a35b42c3
x-ms-traffictypediagnostic: VI1PR05MB5053:
x-microsoft-antispam-prvs: <VI1PR05MB5053EC3BB2D734666A280484CF0B0@VI1PR05MB5053.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(66446008)(66476007)(64756008)(66556008)(9786002)(81166006)(8936002)(71200400001)(54906003)(316002)(9746002)(52116002)(66946007)(81156014)(86362001)(8676002)(478600001)(33656002)(9686003)(66574012)(1076003)(5660300002)(186003)(26005)(4326008)(6916009)(53546011)(2906002)(36756003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5053;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJnYk4unhOC0cZ1KdbgKKNbVKAgwKnU8ALQnF4K9XJkdjppDSUdqsNhB6fUuKpwDj1G24tjYzKBKYTQA2AuDU6kuPUzvF5S62i5ibkPIGuLUkdp5Li4kM8r1C5SAJXhqqZiKptKB3gXaOHqgjTj1I1bPUgI6qk2RKjuE5ovdBorss4/PRVr8YL0YsS/7bIqGsGEXaPYy4Q/a6T60MBnSoEjrrXdyVfgdG5ApHWz0RvctVnNqNskhXBT1QPe5nQ7JnwPi5/6O3XJxfFtYL2cGbd0n/WJgPJ/KHQu3R58nFXYiA71C1/4BcGsvO+9WimeVkrVLhN2w4N7Oif7eVzQ+wH5yWgWzIEAe02ZTaeGrtNeTj0LAAbBIIPgJz9OvSOM6UYRAA8CWxPVAsqjqsRw9BjMVp80NW8rF7BW8WnpPbY9oPg9FUv2EgyeVjV/hbK4Q1sK20fyEW26480o52abvg9lodvN+z9a5IVIwpmifhpuedeS97CqFOQlCWHu7GVzE
x-ms-exchange-antispam-messagedata: AWuYYce9LYi9j4v9NWZ8mK0jKRIAUnfDnjRA3861srvvyB6k4Ncs5fIEMNqz+/zI6PtIgj+145y6rJ3VWmb11WMsY9oM3pB5O2eLkUdQTU4tOVnO9kE9Th08uqCRnZ0Ts/qFQh8E9iGRNmmqUWoYow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA07F24B8A370544A509950434FF112A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39692c55-ec6a-4c32-556d-08d7a35b42c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 19:01:07.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaHRCsWcNkYiUow9bgO7U/jS9NajaOuS7xew+Lt5+QZtxaZEEVBjAMYGnAjWcja5whbyTD/ikpkb2vLQw1IWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5053
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBKYW4gMjEsIDIwMjAgYXQgMDg6NTQ6MjJQTSAtMDcwMCwgSmVucyBBeGJvZSB3cm90
ZToNCj4gT24gMS8yMS8yMCA3OjMxIFBNLCBqZ2xpc3NlQHJlZGhhdC5jb20gd3JvdGU6DQo+ID4g
RnJvbTogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+DQo+ID4gDQo+ID4gRGly
ZWN0IEkvTyBkb2VzIHBpbiBtZW1vcnkgdGhyb3VnaCBHVVAgKGdldCB1c2VyIHBhZ2UpIHRoaXMg
ZG9lcw0KPiA+IGJsb2NrIHNldmVyYWwgbW0gYWN0aXZpdGllcyBsaWtlOg0KPiA+ICAgICAtIGNv
bXBhY3Rpb24NCj4gPiAgICAgLSBudW1hDQo+ID4gICAgIC0gbWlncmF0aW9uDQo+ID4gICAgIC4u
Lg0KPiA+IA0KPiA+IEl0IGlzIGFsc28gdHJvdWJsZXNvbWUgaWYgdGhlIHBpbm5lZCBwYWdlcyBh
cmUgYWN0dWFseSBmaWxlIGJhY2sNCj4gPiBwYWdlcyB0aGF0IG1pZ3RoIGdvIHVuZGVyIHdyaXRl
YmFjay4gSW4gd2hpY2ggY2FzZSB0aGUgcGFnZSBjYW4NCj4gPiBub3QgYmUgd3JpdGUgcHJvdGVj
dGVkIGZyb20gZGlyZWN0LWlvIHBvaW50IG9mIHZpZXcgKHNlZSB2YXJpb3VzDQo+ID4gZGlzY3Vz
c2lvbiBhYm91dCByZWNlbnQgd29yayBvbiBHVVAgWzFdKS4gVGhpcyBkb2VzIGhhcHBlbnMgZm9y
DQo+ID4gaW5zdGFuY2UgaWYgdGhlIHZpcnR1YWwgbWVtb3J5IGFkZHJlc3MgdXNlIGFzIGJ1ZmZl
ciBmb3IgcmVhZA0KPiA+IG9wZXJhdGlvbiBpcyB0aGUgb3V0Y29tZSBvZiBhbiBtbWFwIG9mIGEg
cmVndWxhciBmaWxlLg0KPiA+IA0KPiA+IA0KPiA+IFdpdGggZGlyZWN0LWlvIG9yIGFpbyAoYXN5
bmNocm9ub3VzIGlvKSBwYWdlcyBhcmUgcGlubmVkIHVudGlsDQo+ID4gc3lzY2FsbCBjb21wbGV0
aW9uICh3aGljaCBkZXBlbmRzIG9uIG1hbnkgZmFjdG9yczogaW8gc2l6ZSwNCj4gPiBibG9jayBk
ZXZpY2Ugc3BlZWQsIC4uLikuIEZvciBpby11cmluZyBwYWdlcyBjYW4gYmUgcGlubmVkIGFuDQo+
ID4gaW5kaWZpbml0ZSBhbW91bnQgb2YgdGltZS4NCj4gPiANCj4gPiANCj4gPiBTbyBpIHdvdWxk
IGxpa2UgdG8gY29udmVydCBkaXJlY3QgaW8gY29kZSAoZGlyZWN0LWlvLCBhaW8gYW5kDQo+ID4g
aW8tdXJpbmcpIHRvIG9iZXkgbW11IG5vdGlmaWVyIGFuZCB0aHVzIGFsbG93IG1lbW9yeSBtYW5h
Z2VtZW50DQo+ID4gYW5kIHdyaXRlYmFjayB0byB3b3JrIGFuZCBiZWhhdmUgbGlrZSBhbnkgb3Ro
ZXIgcHJvY2VzcyBtZW1vcnkuDQo+ID4gDQo+ID4gRm9yIGRpcmVjdC1pbyBhbmQgYWlvIHRoaXMg
bW9zdGx5IGdpdmVzIGEgd2F5IHRvIHdhaXQgb24gc3lzY2FsbA0KPiA+IGNvbXBsZXRpb24uIEZv
ciBpby11cmluZyB0aGlzIG1lYW5zIHRoYXQgYnVmZmVyIG1pZ2h0IG5lZWQgdG8gYmUNCj4gPiBy
ZS12YWxpZGF0ZWQgKGllIGxvb2tpbmcgdXAgcGFnZXMgYWdhaW4gdG8gZ2V0IHRoZSBuZXcgc2V0
IG9mDQo+ID4gcGFnZXMgZm9yIHRoZSBidWZmZXIpLiBJbXBhY3QgZm9yIGlvLXVyaW5nIGlzIHRo
ZSBkZWxheSBuZWVkZWQNCj4gPiB0byBsb29rdXAgbmV3IHBhZ2VzIG9yIHdhaXQgb24gd3JpdGVi
YWNrIChpZiBuZWNlc3NhcnkpLiBUaGlzDQo+ID4gd291bGQgb25seSBoYXBwZW5zIF9pZl8gYW4g
aW52YWxpZGF0aW9uIGV2ZW50IGhhcHBlbnMsIHdoaWNoIGl0LQ0KPiA+IHNlbGYgc2hvdWxkIG9u
bHkgaGFwcGVuIHVuZGVyIG1lbW9yeSBwcmVpc3N1cmUgb3IgZm9yIE5VTUENCj4gPiBhY3Rpdml0
aWVzLg0KPiA+IA0KPiA+IFRoZXkgYXJlIHdheXMgdG8gbWluaW1pemUgdGhlIGltcGFjdCAoZm9y
IGluc3RhbmNlIGJ5IHVzaW5nIHRoZQ0KPiA+IG1tdSBub3RpZmllciB0eXBlIHRvIGlnbm9yZSBz
b21lIGludmFsaWRhdGlvbiBjYXNlcykuDQo+ID4gDQo+ID4gDQo+ID4gU28gaSB3b3VsZCBsaWtl
IHRvIGRpc2N1c3MgYWxsIHRoaXMgZHVyaW5nIExTRiwgaXQgaXMgbW9zdGx5IGENCj4gPiBmaWxl
c3lzdGVtIGRpc2N1c3Npb24gd2l0aCBzdHJvbmcgdGllIHRvIG1tLg0KPiANCj4gSSdkIGJlIGlu
dGVyZXN0ZWQgaW4gdGhpcyB0b3BpYywgYXMgaXQgcGVydGFpbnMgdG8gaW9fdXJpbmcuIFRoZSB3
aG9sZQ0KPiBwb2ludCBvZiByZWdpc3RlcmVkIGJ1ZmZlcnMgaXMgdG8gYXZvaWQgbWFwcGluZyBv
dmVyaGVhZCwgYW5kIHBhZ2UNCj4gcmVmZXJlbmNlcy4gDQoNCkknZCBhbHNvIGJlIGludGVyZXN0
ZWQgYXMgaXQgcGVydGFpbnMgdG8gbW11IG5vdGlmaWVycyBhbmQgcmVsYXRlZA0Kd2hpY2ggSSd2
ZSBiZWVuIGludm9sdmVkIHdpdGggcmV3b3JraW5nIGxhdGVseS4gSSBmZWVsIG90aGVycyBhcmUN
Cmxvb2tpbmcgYXQgZG9pbmcgZGlmZmVyZW50IHRoaW5ncyB3aXRoIGJpby9za2JzIHRoYXQgYXJl
IGtpbmQgb2YNCnJlbGF0ZWQgdG8gdGhpcyBpZGVhIHNvIEkgZmVlbCBpdCBpcyB3b3J0aHdoaWxl
IHRvcGljLg0KDQpUaGlzIHByb3Bvc2FsIHNvdW5kcywgYXQgYSBoaWdoIGxldmVsLCBxdWl0ZSBz
aW1pbGFyIHRvIHdoYXQgdmhvc3QgaXMNCmRvaW5nIHRvZGF5LCB3aGVyZSB0aGV5IHdhbnQgdG8g
dXNlIGNvcHlfdG9fdXNlciB3aXRob3V0IHBheWluZyBpdCdzDQpjb3N0IGJ5IGRpcmVjdGx5IGFj
Y2Vzc2luZyBrZXJuZWwgcGFnZXMgYW5kIGtlZXBpbmcgZXZlcnl0aGluZyBpbiBzeW5jDQp3aXRo
IG5vdGlmaWVycy4NCg0KPiBJZiB3ZSBhZGQgZXh0cmEgb3ZlcmhlYWQgcGVyIG9wZXJhdGlvbiBm
b3IgdGhhdCwgd2VsbC4uLiBJJ20NCj4gYXNzdW1pbmcgdGhlIGFib3ZlIGlzIHN0cmljdGx5IGZv
ciBmaWxlIG1hcHBlZCBwYWdlcz8gT3IgYWxzbyBwYWdlDQo+IG1pZ3JhdGlvbj8NCg0KR2VuZXJh
bGx5IHRoZSBwZXJmb3JtYW5jZSBwcm9maWxlIHdlIHNlZSBpbiBvdGhlciBwbGFjZXMgaXMgdGhh
dA0KYXBwbGljYXRpb25zIHRoYXQgZG9uJ3QgdG91Y2ggdGhlaXIgbWVtb3J5IGhhdmUgbm8gaW1w
YWN0LCB3aGlsZQ0KdGhpbmdzIGdldCB3b25reSBkdXJpbmcgaW52YWxpZGF0aW9ucy4NCg0KSG93
ZXZlciwgdGhhdCBoYXMgYXNzdW1lZCBETUEgZGV2aWNlcyB3aGVyZSB0aGUgRE1BIGRldmljZSBo
YXMgc29tZQ0Kb3B0aW1pemVkIEhXIHdheSB0byBtYW5hZ2UgbG9ja2luZy4gICANCg0KSW4gdmhv
c3QgdGhlIHBlcmZvcm1hbmNlIGNvbmNlcm5lcyBzZWVtcyB0byByZXZvbHZlIGFyb3VuZCBsb2Nr
aW5nIHRoZQ0KQ1BVIGFjY2VzcyB0aHJlYWQgYWdhaW5zdCB0aGUgbW11IG5vdGlmaWVyIHRocmVh
ZC4NCg0KSSdtIGN1cmlvdXMgYWJvdXQgSsOpcsO0bWUncyB0aGlua2luZyBvbiB0aGlzLCBwYXJ0
aWN1bGFybHkgd2hlbiB5b3UgbWl4DQppbiBsb25nZXIgbGlmZXRpbWVzIG9mIHNrYnMgYW5kIGJp
b3MgYW5kIHdoYXRub3QuIEF0IHNvbWUgcG9pbnQgdGhlDQpwYWdlcyBtdXN0IGJlY29tZSBwaW5u
ZWQsIGZvciBpbnN0YW5jZSB3aGlsZSB0aGV5IGFyZSBzdWJtaXR0ZWQgdG8gYQ0KZGV2aWNlIGZv
ciBETUEuDQoNClRoYW5rcywNCkphc29uDQo=
