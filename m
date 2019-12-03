Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CAC10F8E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 08:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfLCHge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 02:36:34 -0500
Received: from mail-eopbgr800123.outbound.protection.outlook.com ([40.107.80.123]:16543
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727429AbfLCHge (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:36:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP5xOIUdhpAlyC5oaMaP9knMXIHCgvabBBZIw6pqAX6H3lRA8O8VAqoZt7StGOryPiPw6PHr+DnS/amsECIAaU0y1lQg4zEynkJhFGsKAUiwE+mguBe3DfQXURLDY6w4R8kvfw9XNRXMRsg46tNTaXxboC6o1K11Aleb2voYNrP9ogrFRcUsGKi08eBDXCBmraXy1dnFFJajzVeWU03aCq/gdrn71eypjfG9vyl6dhn6+TNdjK8DmH51cwaknk6r3VtwQ2HYpT35lLeFaD57LTEFkISUtHJqnBtHqnU8UDHnny+wxktEPV6vYWcLA6eVmeg+gKk9kXKtN9IB0rVUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tqgasao2bCK2+9caG+7xuXBXBJBk7YD7kcoe+EmrF4=;
 b=jGhEBFGFd2bXU3YFSGM5sgFYGgQ3Ld++Gw9229NDFlzG3ysc6ry8wgYMGk4GIEnOEH0nxnHCs2hOi5+By9sdMOs4mPxykuRtgrFVWTSqIsq5mPYOZQfAMkBS+H6QLDeURY7MXwU+5cXyia9REu/IgtnTVgCuRIypNlhTuD+bqL31Kisou6QPVGJflJTd5MCmmhAErJJDfhqr/n+HpZMJt9ctvwEsSnclBY+yQ5VC/bI3ajeBZa5HFgb/00F9+bJNwGfuZbliOwM4T3psXW+ho9xo//5zsZ/5SnsD2ERpo7v0hC27bxZuUqKy1qE0gCEFkSChypLZf/UMWIpyiJO0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tqgasao2bCK2+9caG+7xuXBXBJBk7YD7kcoe+EmrF4=;
 b=bSBhIs+63P5D/047NEPYgIq5rwmsvOncmwnvYy2IdmXJYs7uASWysVwUz9ZXqVVm/88BloRHwRgFqcioB56rVewrcLcHHU2pCCh9ofe5euorsrcstLUG+4kXXCX/9JxOUr/a1TcfCpoTRwzdyyx8t7q0YXBHJATAgJCPq0MEeGY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2124.namprd13.prod.outlook.com (10.174.185.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.5; Tue, 3 Dec 2019 07:36:29 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 07:36:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Thread-Topic: Question about clone_range() metadata stability
Thread-Index: AQHVpVHnjYPZ0FhJIUe2yp+YUANojKefdeQAgAZVi4CAAkKrgA==
Date:   Tue, 3 Dec 2019 07:36:29 +0000
Message-ID: <52f1afb6e0a2026840da6f4b98a5e01a247447e5.camel@hammerspace.com>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
         <20191127202136.GV6211@magnolia>
         <20191201210519.GB2418@dread.disaster.area>
In-Reply-To: <20191201210519.GB2418@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [88.95.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b2ded4c-4030-413b-f1c3-08d777c38303
x-ms-traffictypediagnostic: DM5PR1301MB2124:
x-microsoft-antispam-prvs: <DM5PR1301MB2124515881A83D942E82872CB8420@DM5PR1301MB2124.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39840400004)(366004)(53754006)(199004)(189003)(446003)(186003)(99286004)(2616005)(316002)(76176011)(118296001)(6436002)(2501003)(26005)(229853002)(11346002)(6486002)(3846002)(6116002)(66066001)(2906002)(86362001)(5660300002)(54906003)(102836004)(110136005)(6506007)(64756008)(66446008)(36756003)(305945005)(66946007)(25786009)(81166006)(8936002)(14444005)(14454004)(66556008)(66476007)(81156014)(76116006)(71200400001)(91956017)(71190400001)(7736002)(6246003)(6512007)(508600001)(4326008)(256004)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2124;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AmBhyMlad4jtOa1HTOUwuSgn4CsKvvU2sGgZv5htEPKheHqPNzamf56d88qghWyI0y0Hc1gso+Gh8QMfG5fX4N7nDrXITGsOEw7/wtwJc7d+6xhYzt99+ewNDP4XN30sWWxzIt0xO16vTxf5j9+FC4szmKwpuLSLd6AdiyAFp6KW9CA/zQ4HtsXdbBwPBslXQfqQfWKZjYEICvD7vL8YQbardVTUBZTD6pKB86t0qbeGm1ruUndGUXRjgjU45e+4Lt/QVXoBOAjLoUAomtxZPP4K5yHexqVLFbrOw0ea7adZO/PzYSKT19h3iWjdqDcdstCxbxw5s2SEUUD1Zr6QkToAqkl7a7o3nMGd8NohLC7MZrH05ggr5HoyfbZ+ZcuAIYmQoLLGptxieDrZ5cKN7Nieq4y+OyXbkHgx1nb6lax24SadM0TfhAP8XPuYpgg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CABD97CF5C91B74C94163AF67F45E24C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2ded4c-4030-413b-f1c3-08d777c38303
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 07:36:29.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnZVs93QQ8uBLlzwbK04EgyUJ6oWyLr5btVnsCbOAH6G0ZnRktMl25oEpRZHV3D5dvM+DIYcn142Oz0Qr/BY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDA4OjA1ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFdlZCwgTm92IDI3LCAyMDE5IGF0IDEyOjIxOjM2UE0gLTA4MDAsIERhcnJpY2sgSi4gV29u
ZyB3cm90ZToNCj4gPiBPbiBXZWQsIE5vdiAyNywgMjAxOSBhdCAwNjozODo0NlBNICswMDAwLCBU
cm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiBIaSBhbGwNCj4gPiA+IA0KPiA+ID4gQSBxdWlj
ayBxdWVzdGlvbiBhYm91dCBjbG9uZV9yYW5nZSgpIGFuZCBndWFyYW50ZWVzIGFyb3VuZA0KPiA+
ID4gbWV0YWRhdGENCj4gPiA+IHN0YWJpbGl0eS4NCj4gPiA+IA0KPiA+ID4gQXJlIHVzZXJzIHJl
cXVpcmVkIHRvIGNhbGwgZnN5bmMvZnN5bmNfcmFuZ2UoKSBhZnRlciBjYWxsaW5nDQo+ID4gPiBj
bG9uZV9yYW5nZSgpIGluIG9yZGVyIHRvIGd1YXJhbnRlZSB0aGF0IHRoZSBjbG9uZWQgcmFuZ2UN
Cj4gPiA+IG1ldGFkYXRhIGlzDQo+ID4gPiBwZXJzaXN0ZWQ/DQo+ID4gDQo+ID4gWWVzLg0KPiA+
IA0KPiA+ID4gSSdtIGFzc3VtaW5nIHRoYXQgaXQgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gZ3Vh
cmFudGVlIHRoYXQNCj4gPiA+IGRhdGEgaXMgcGVyc2lzdGVkLg0KPiA+IA0KPiA+IERhdGEgYW5k
IG1ldGFkYXRhLiAgWEZTIGFuZCBvY2ZzMidzIHJlZmxpbmsgaW1wbGVtZW50YXRpb25zIHdpbGwN
Cj4gPiBmbHVzaA0KPiA+IHRoZSBwYWdlIGNhY2hlIGJlZm9yZSBzdGFydGluZyB0aGUgcmVtYXAs
IGJ1dCB0aGV5IGJvdGggcmVxdWlyZQ0KPiA+IGZzeW5jIHRvDQo+ID4gZm9yY2UgdGhlIGxvZy9q
b3VybmFsIHRvIGRpc2suDQo+IA0KPiBTbyB3ZSBuZWVkIHRvIGNhbGwgeGZzX2ZzX25mc19jb21t
aXRfbWV0YWRhdGEoKSB0byBnZXQgdGhhdCBkb25lDQo+IHBvc3QgdmZzX2Nsb25lX2ZpbGVfcmFu
Z2UoKSBjb21wbGV0aW9uIG9uIHRoZSBzZXJ2ZXIgc2lkZSwgeWVzPw0KPiANCg0KSSBjaG9zZSB0
byBpbXBsZW1lbnQgdGhpcyB1c2luZyBhIGZ1bGwgY2FsbCB0byB2ZnNfZnN5bmNfcmFuZ2UoKSwg
c2luY2UNCndlIHJlYWxseSBkbyB3YW50IHRvIGVuc3VyZSBkYXRhIHN0YWJpbGl0eSBhcyB3ZWxs
LiBDb25zaWRlciwgZm9yDQppbnN0YW5jZSwgdGhlIGNhc2Ugd2hlcmUgY2xpZW50IEEgaXMgcnVu
bmluZyBhbiBhcHBsaWNhdGlvbiwgYW5kIGNsaWVudA0KQiBydW5zIHZmc19jbG9uZV9maWxlX3Jh
bmdlKCkgaW4gb3JkZXIgdG8gY3JlYXRlIGEgcG9pbnQgaW4gdGltZQ0Kc25hcHNob3Qgb2YgdGhl
IGZpbGUgZm9yIGRpc2FzdGVyIHJlY292ZXJ5IHB1cnBvc2VzLi4uDQoNCj4gPiAoQUZBSUNUIHRo
ZSBzYW1lIHJlYXNvbmluZyBhcHBsaWVzIHRvIGJ0cmZzLCBidXQgZG9uJ3QgdHJ1c3QgbXkNCj4g
PiB3b3JkIGZvcg0KPiA+IGl0LikNCj4gPiANCj4gPiA+IEknbSBhc2tpbmcgYmVjYXVzZSBrbmZz
ZCBjdXJyZW50bHkganVzdCBkb2VzIGEgY2FsbCB0bw0KPiA+ID4gdmZzX2Nsb25lX2ZpbGVfcmFu
Z2UoKSB3aGVuIHBhcnNpbmcgYSBORlN2NC4yIENMT05FIG9wZXJhdGlvbi4gSXQNCj4gPiA+IGRv
ZXMNCj4gPiA+IG5vdCBjYWxsIGZzeW5jKCkvZnN5bmNfcmFuZ2UoKSBvbiB0aGUgZGVzdGluYXRp
b24gZmlsZSwgYW5kIHNpbmNlDQo+ID4gPiB0aGUNCj4gPiA+IE5GU3Y0LjIgcHJvdG9jb2wgZG9l
cyBub3QgcmVxdWlyZSB5b3UgdG8gcGVyZm9ybSBhbnkgb3RoZXINCj4gPiA+IG9wZXJhdGlvbiBp
bg0KPiA+ID4gb3JkZXIgdG8gcGVyc2lzdCBkYXRhL21ldGFkYXRhLCBJJ20gd29ycmllZCB0aGF0
IHdlIG1heSBiZQ0KPiA+ID4gY29ycnVwdGluZw0KPiA+ID4gdGhlIGNsb25lZCBmaWxlIGlmIHRo
ZSBORlMgc2VydmVyIGNyYXNoZXMgYXQgdGhlIHdyb25nIG1vbWVudA0KPiA+ID4gYWZ0ZXIgdGhl
DQo+ID4gPiBjbGllbnQgaGFzIGJlZW4gdG9sZCB0aGUgY2xvbmUgY29tcGxldGVkLg0KPiANCj4g
WXVwLCB0aGF0J3MgZXhhY3RseSB3aGF0IHNlcnZlciBzaWRlIGNhbGxzIHRvIGNvbW1pdF9tZXRh
ZGF0YSgpIGFyZQ0KPiBzdXBwb3NlZCB0byBhZGRyZXNzLg0KPiANCj4gSSBzdXNwZWN0IHRvIGJl
IGNvcnJlY3QsIHRoaXMgbWlnaHQgcmVxdWlyZSBjb21taXRfbWV0YWRhdGEoKSB0byBiZQ0KPiBj
YWxsZWQgb24gYm90aCB0aGUgc291cmNlIGFuZCBkZXN0aW5hdGlvbiBpbm9kZXMsIGFzIGJvdGgg
b2YgdGhlbQ0KPiBtYXkgaGF2ZSBtb2RpZmllZCBtZXRhZGF0YSBhcyBhIHJlc3VsdCBvZiB0aGUg
Y2xvbmUgb3BlcmF0aW9uLiBGb3INCj4gWEZTIG9uZSBvZiB0aGVtIHdpbGwgYmUgYSBuby1vcCwg
YnV0IGZvciBvdGhlciBmaWxlc3lzdGVtcyB0aGF0DQo+IGRvbid0IGltcGxlbWVudCAtPmNvbW1p
dF9tZXRhZGF0YSwgd2UnbGwgbmVlZCB0byBjYWxsDQo+IHN5bmNfaW5vZGVfbWV0YWRhdGEoKSBv
biBib3RoIGlub2Rlcy4uLg0KPiANCg0KVGhhdCdzIGludGVyZXN0aW5nLiBJIGhhZG4ndCBjb25z
aWRlcmVkIHRoYXQgYSBjbG9uZSBtaWdodCBjYXVzZSB0aGUNCnNvdXJjZSBtZXRhZGF0YSB0byBj
aGFuZ2UgYXMgd2VsbC4gV2hhdCBraW5kIG9mIGNoYW5nZSBzcGVjaWZpY2FsbHkgYXJlDQp3ZSB0
YWxraW5nIGFib3V0PyBJcyBpdCBqdXN0IGRlbGF5ZWQgYmxvY2sgYWxsb2NhdGlvbiwgb3IgaXMg
dGhlcmUNCm1vcmU/DQoNClRoYW5rcw0KICBUcm9uZA0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
