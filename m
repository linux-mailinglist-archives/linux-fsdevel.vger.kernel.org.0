Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF5ECCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfD2Wdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:33:32 -0400
Received: from mail-eopbgr770099.outbound.protection.outlook.com ([40.107.77.99]:17378
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729550AbfD2Wdc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Dk4RrmCfm7Mu51DL0llDmLd0PZFecLyxgbDj+x8Hjr7+gZNT8S8tukxe+kprdx84lDQiqy+cClXwgr/KllvGVARlVlVINcKvJ6qHr1MEXj/jVZSuJFow6JQWSsp5M7XmkX6QU29I3cwhCcTjDz/XXrSZQuZZstMQDETdQsZ5iYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7uAJCeiZHJHzovuYIZ3PB6gAX1r39lpbAVY5u/nnDM=;
 b=J1Rarlts+ndQxd7k/BL+rmzGNtel6sACOTp9b/vliYLioY/tuFvpOeU6q4EJ7OjPQGEYLy9fVsOEGjmsh6fDjeUgyrUTDV2PxWWjOXe3SZjQWzBdzEIOK6lO3R+J9kh9vYMUuxcdZ5T04KVA+LRvz4JCAipJtPP5hQO+I10SJvY=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7uAJCeiZHJHzovuYIZ3PB6gAX1r39lpbAVY5u/nnDM=;
 b=OhfkZcJjjWWHJGxgRgnkz77R4WmQm4k0gaHAxkWhTZkMCLhtwshHQ9PUGoH0LtES/P3oVUNqqz++AL/UpE0MBHLuv7XbsP19Jtt3y8O/hdIlY/6lPIQSNoH1VlKm+7nkbAo6BUQOKy4tTVLXc1669O5NqRcf1Elb8JfDY6FHWEg=
Received: from BYAPR21MB1303.namprd21.prod.outlook.com (20.179.58.85) by
 BYAPR21MB1142.namprd21.prod.outlook.com (20.179.56.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.2; Mon, 29 Apr 2019 22:33:27 +0000
Received: from BYAPR21MB1303.namprd21.prod.outlook.com
 ([fe80::604c:22ba:9a59:ad26]) by BYAPR21MB1303.namprd21.prod.outlook.com
 ([fe80::604c:22ba:9a59:ad26%4]) with mapi id 15.20.1878.004; Mon, 29 Apr 2019
 22:33:27 +0000
From:   Pavel Shilovskiy <pshilov@microsoft.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Subject: RE: Better interop for NFS/SMB file share mode/reservation
Thread-Topic: Better interop for NFS/SMB file share mode/reservation
Thread-Index: AQHU/btKEFjfcFmPmE6by05GjmbTGqZRleoAgAAWdoCAAHPCAIAAAk6AgAAHAgCAACgwAIABR0kAgAAZBfA=
Date:   Mon, 29 Apr 2019 22:33:27 +0000
Message-ID: <BYAPR21MB1303596634461C7D46B0A773B6390@BYAPR21MB1303.namprd21.prod.outlook.com>
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
         <379106947f859bdf5db4c6f9c4ab8c44f7423c08.camel@kernel.org>
         <CAOQ4uxgewN=j3ju5MSowEvwhK1HqKG3n1hBRUQTi1W5asaO1dQ@mail.gmail.com>
         <930108f76b89c93b2f1847003d9e060f09ba1a17.camel@kernel.org>
         <CAOQ4uxgQsRaEOxz1aYzP1_1fzRpQbOm2-wuzG=ABAphPB=7Mxg@mail.gmail.com>
         <20190426140023.GB25827@fieldses.org>
         <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
         <20190426145006.GD25827@fieldses.org>
         <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
         <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
         <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
         <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
         <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
         <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
         <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
         <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
         <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
 <bc2f04c55ba9290fc48d5f2b909262171ca6a19f.camel@kernel.org>
In-Reply-To: <bc2f04c55ba9290fc48d5f2b909262171ca6a19f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=pshilov@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-04-29T22:33:25.7268159Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec928a02-dbb6-42ff-a45b-a388307470c5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pshilov@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:596f:2f40:4511:2a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5659feda-0664-4269-02cb-08d6ccf2b2ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1142;
x-ms-traffictypediagnostic: BYAPR21MB1142:
x-microsoft-antispam-prvs: <BYAPR21MB1142881922B7C4053E0B2BE1B6390@BYAPR21MB1142.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(561944003)(33656002)(97736004)(6436002)(305945005)(14444005)(7736002)(256004)(5660300002)(25786009)(6116002)(4326008)(52536014)(74316002)(93886005)(2501003)(53936002)(11346002)(110136005)(55016002)(71200400001)(229853002)(76176011)(9686003)(86362001)(86612001)(316002)(478600001)(102836004)(71190400001)(54906003)(8990500004)(46003)(53546011)(22452003)(66446008)(7696005)(66946007)(486006)(10290500003)(66476007)(66556008)(10090500001)(64756008)(81156014)(68736007)(8676002)(8936002)(73956011)(76116006)(81166006)(2906002)(6246003)(186003)(99286004)(446003)(14454004)(476003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1142;H:BYAPR21MB1303.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GEO/kxj6Yc1Rk5UHj+7d4LlyPPU+AKEKiAqkHcWU///YM+/URyp3Yz1S+RxtAtk+y2TD3Tc+q3707TLoxoPYShj41UFPTmWMfB/7mejTBfV/emscnwzuZsFY8bwntWrnUPWQr+UQFMwAF8VgczTYMNRz+KBpcioJ9RfCAxIN1mgr8VNqyR6BHRr/OOEJY9kUuBzG5NdzQt08cD1WpGSd33YdSR3vfu90F0VANUBJbOkJv0CO45oShMU91F/oMjDRkXZ51wJK6d814ooQeVQnBeMJ6j7cYcCRgDpPygFHfeyIIyMVQx5mMvh7ozYPUyz5K/5Jwi3yvOFbYTQsAemLcga3qoXNQV01R+nN+JQlOxXUHrqEiykt49/3tpgHPnNR3FzwCXd8MmuAb4DnPIo1hAwBaTD7WIUWYIl9WK+t2Vc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659feda-0664-4269-02cb-08d6ccf2b2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 22:33:27.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCtC/0L0sIDI5INCw0L/RgC4gMjAxOSDQsy4g0LIgMTM6MjksIEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+Og0KPg0KPiBPbiBNb24sIDIwMTktMDQtMjkgYXQgMDA6NTcgKzAwMDAs
IFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMTktMDQtMjggYXQgMTg6MzMg
LTA0MDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPiA+ID4gT24gU3VuLCBBcHIgMjgsIDIwMTkg
YXQgNjowOCBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5j
b20+IHdyb3RlOg0KPiA+ID4gPiBPbiBTdW4sIDIwMTktMDQtMjggYXQgMTg6MDAgLTA0MDAsIEFt
aXIgR29sZHN0ZWluIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFN1biwgQXByIDI4LCAyMDE5IGF0IDEx
OjA2IEFNIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNv
bT4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBTdW4sIDIwMTktMDQtMjggYXQgMDk6NDUgLTA0MDAs
IEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBTdW4sIEFwciAyOCwgMjAx
OSBhdCA4OjA5IEFNIEplZmYgTGF5dG9uIDwNCj4gPiA+ID4gPiA+ID4gamxheXRvbkBrZXJuZWwu
b3JnPg0KPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBPbiBTYXQsIDIwMTkt
MDQtMjcgYXQgMTY6MTYgLTA0MDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiA+ID4gW2FkZGluZyBiYWNrIHNhbWJhL25mcyBhbmQgZnNkZXZlbF0NCj4gPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBjYydpbmcgUGF2ZWwgdG9vIC0t
IGhlIGRpZCBhIGJ1bmNoIG9mIHdvcmsgaW4gdGhpcyBhcmVhIGENCj4gPiA+ID4gPiA+ID4gPiBm
ZXcNCj4gPiA+ID4gPiA+ID4gPiB5ZWFycw0KPiA+ID4gPiA+ID4gPiA+IGFnby4NCj4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMjYsIDIwMTkgYXQgNjoyMiBQ
TSBKZWZmIExheXRvbiA8DQo+ID4gPiA+ID4gPiA+ID4gPiBqbGF5dG9uQGtlcm5lbC5vcmc+DQo+
ID4gPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCAyMDE5
LTA0LTI2IGF0IDEwOjUwIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMjYsIDIwMTkgYXQg
MDQ6MTE6MDBQTSArMDIwMCwgQW1pcg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEdvbGRzdGVpbg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24g
RnJpLCBBcHIgMjYsIDIwMTksIDQ6MDAgUE0gSi4gQnJ1Y2UgRmllbGRzIDwNCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGJmaWVsZHNAZmllbGRzZXMub3JnPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoYXQgc2FpZCwgd2UgY291bGQgYWxzbyBs
b29rIGF0IGEgdmZzLWxldmVsIG1vdW50DQo+ID4gPiA+ID4gPiA+ID4gPiA+IG9wdGlvbg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdvdWxkDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IG1ha2UgdGhlIGtlcm5lbCBlbmZvcmNlIHRoZXNlIGZvciBhbnkgb3BlbmVy
LiBUaGF0DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGNvdWxkDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGFs
c28NCj4gPiA+ID4gPiA+ID4gPiA+ID4gYmUgdXNlZnVsLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBh
bmQgc2hvdWxkbid0IGJlIHRvbyBoYXJkIHRvIGltcGxlbWVudC4gTWF5YmUgZXZlbiBtYWtlDQo+
ID4gPiA+ID4gPiA+ID4gPiA+IGl0DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGENCj4gPiA+ID4gPiA+
ID4gPiA+ID4gdmZzbW91bnQtDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGxldmVsIG9wdGlvbiAobGlr
ZSAtbyBybyBpcykuDQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiA+ID4gWWVoLCBJIGFtIGh1bWJseSBnb2luZyB0byBsZWF2ZSB0aGlzIHN0cnVn
Z2xlIHRvIHNvbWVvbmUNCj4gPiA+ID4gPiA+ID4gPiA+IGVsc2UuDQo+ID4gPiA+ID4gPiA+ID4g
PiBOb3QgaW1wb3J0YW50IGVub3VnaCBJTU8gYW5kIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQNCj4g
PiA+ID4gPiA+ID4gPiA+IGVmZm9ydCB0bw0KPiA+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+
ID4gPiA+ID4gPiBhZHZpc29yeSBhdG9taWMgb3BlbiZsb2NrIEFQSS4NCj4gPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiA+IEhhdmluZyB0aGUga2VybmVsIGFsbG93IHNldHRpbmcgZGVueSBt
b2RlcyBvbiBhbnkgb3BlbiBjYWxsDQo+ID4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4g
PiBhDQo+ID4gPiA+ID4gPiA+ID4gbm9uLQ0KPiA+ID4gPiA+ID4gPiA+IHN0YXJ0ZXIsIGZvciB0
aGUgcmVhc29ucyBCcnVjZSBvdXRsaW5lZCBlYXJsaWVyLiBUaGlzDQo+ID4gPiA+ID4gPiA+ID4g
X211c3RfIGJlDQo+ID4gPiA+ID4gPiA+ID4gcmVzdHJpY3RlZCBpbiBzb21lIGZhc2hpb24gb3Ig
d2UnbGwgYmUgb3BlbmluZyB1cCBhDQo+ID4gPiA+ID4gPiA+ID4gZ2lub3Jtb3VzDQo+ID4gPiA+
ID4gPiA+ID4gRG9TDQo+ID4gPiA+ID4gPiA+ID4gbWVjaGFuaXNtLg0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gTXkgcHJvcG9zYWwgd2FzIHRvIG1ha2UgdGhpcyBvbmx5IGJlIGVu
Zm9yY2VkIGJ5DQo+ID4gPiA+ID4gPiA+ID4gYXBwbGljYXRpb25zDQo+ID4gPiA+ID4gPiA+ID4g
dGhhdA0KPiA+ID4gPiA+ID4gPiA+IGV4cGxpY2l0bHkgb3B0LWluIGJ5IHNldHRpbmcgT19TSCov
T19FWCogZmxhZ3MuIEl0IHdvdWxkbid0DQo+ID4gPiA+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiA+
ID4gPiB0b28NCj4gPiA+ID4gPiA+ID4gPiBkaWZmaWN1bHQgdG8gYWxzbyBhbGxvdyB0aGVtIHRv
IGJlIGVuZm9yY2VkIG9uIGEgcGVyLWZzDQo+ID4gPiA+ID4gPiA+ID4gYmFzaXMNCj4gPiA+ID4g
PiA+ID4gPiB2aWENCj4gPiA+ID4gPiA+ID4gPiBtb3VudA0KPiA+ID4gPiA+ID4gPiA+IG9wdGlv
biBvciBzb21ldGhpbmcuIE1heWJlIHdlIGNvdWxkIGV4cGFuZCB0aGUgbWVhbmluZyBvZg0KPiA+
ID4gPiA+ID4gPiA+ICctbw0KPiA+ID4gPiA+ID4gPiA+IG1hbmQnDQo+ID4gPiA+ID4gPiA+ID4g
Pw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gSG93IHdvdWxkIHlvdSBwcm9wb3Nl
IHRoYXQgd2UgcmVzdHJpY3QgdGhpcz8NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiBPdXIgY29tbXVuaWNhdGlvbiBjaGFubmVsIGlzIGJyb2tlbi4NCj4gPiA+
ID4gPiA+ID4gSSBkaWQgbm90IGludGVuZCB0byBwcm9wb3NlIGFueSBpbXBsaWNpdCBsb2NraW5n
Lg0KPiA+ID4gPiA+ID4gPiBJZiBzYW1iYSBhbmQgbmZzZCBjYW4gb3B0LWluIHdpdGggT19TSEFS
RSBmbGFncywgSSBkbyBub3QNCj4gPiA+ID4gPiA+ID4gdW5kZXJzdGFuZCB3aHkgYSBtb3VudCBv
cHRpb24gaXMgaGVscGZ1bCBmb3IgdGhlIGNhdXNlIG9mDQo+ID4gPiA+ID4gPiA+IHNhbWJhL25m
c2QgaW50ZXJvcC4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSWYgc29tZW9uZSBlbHNl
IGlzIGludGVyZXN0ZWQgaW4gc2FtYmEvbG9jYWwgaW50ZXJvcCB0aGFuDQo+ID4gPiA+ID4gPiA+
IHllcywgYSBtb3VudCBvcHRpb24gbGlrZSBzdWdnZXN0ZWQgYnkgUGF2ZWwgY291bGQgYmUgYSBn
b29kDQo+ID4gPiA+ID4gPiA+IG9wdGlvbiwNCj4gPiA+ID4gPiA+ID4gYnV0IGl0IGlzIGFuIG9y
dGhvZ29uYWwgZWZmb3J0IElNTy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJZiBhbiBORlMg
Y2xpZW50ICdvcHRzIGluJyB0byBzZXQgc2hhcmUgZGVueSwgdGhlbiB0aGF0IHN0aWxsDQo+ID4g
PiA+ID4gPiBtYWtlcw0KPiA+ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiA+IGEgbm9uLW9wdGlvbmFs
IGxvY2sgZm9yIHRoZSBvdGhlciBORlMgY2xpZW50cywgYmVjYXVzZSBhbGwNCj4gPiA+ID4gPiA+
IG9yZGluYXJ5DQo+ID4gPiA+ID4gPiBvcGVuKCkgY2FsbHMgd2lsbCBiZSBnYXRlZCBieSB0aGUg
c2VydmVyIHdoZXRoZXIgb3Igbm90IHRoZWlyDQo+ID4gPiA+ID4gPiBhcHBsaWNhdGlvbiBzcGVj
aWZpZXMgdGhlIE9fU0hBUkUgZmxhZy4gVGhlcmUgaXMgbm8gZmxhZyBpbiB0aGUNCj4gPiA+ID4g
PiA+IE5GUw0KPiA+ID4gPiA+ID4gcHJvdG9jb2wgdGhhdCBjb3VsZCB0ZWxsIHRoZSBzZXJ2ZXIg
dG8gaWdub3JlIGRlbnkgbW9kZXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSU9XOiBpdCB3
b3VsZCBzdWZmaWNlIGZvciAxIGNsaWVudCB0byB1c2UgT19TSEFSRXxPX0RFTlkqIHRvDQo+ID4g
PiA+ID4gPiBvcHQNCj4gPiA+ID4gPiA+IGFsbA0KPiA+ID4gPiA+ID4gdGhlIG90aGVyIGNsaWVu
dHMgaW4uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU29ycnkgZm9yIGJlaW5n
IHRoaWNrLCBJIGRvbid0IHVuZGVyc3RhbmQgaWYgd2UgYXJlIGluIGFncmVlbWVudA0KPiA+ID4g
PiA+IG9yDQo+ID4gPiA+ID4gbm90Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IHRoZSBuZXR3b3JrIGZpbGUgc2VydmVyIGltcGxlbWVudGF0aW9ucw0KPiA+
ID4gPiA+IChpLmUuIHNhbWJhLCBrbmZkcywgR2FuZXNoYSkgd2lsbCBhbHdheXMgdXNlIHNoYXJl
L2RlbnkgbW9kZXMuDQo+ID4gPiA+ID4gU28gZm9yIGV4YW1wbGUgbmZzIHYzIG9wZW5zIHdpbGwg
YWx3YXlzIHVzZSBPX0RFTllfTk9ORQ0KPiA+ID4gPiA+IGluIG9yZGVyIHRvIGhhdmUgY29ycmVj
dCBpbnRlcm9wIHdpdGggc2FtYmEgYW5kIG5mcyB2NC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElm
IEkgYW0gbWlzdW5kZXJzdGFuZGluZyBzb21ldGhpbmcsIHBsZWFzZSBlbmxpZ2h0ZW4gbWUuDQo+
ID4gPiA+ID4gSWYgdGhlcmUgaXMgYSByZWFzb24gd2h5IG1vdW50IG9wdGlvbiBpcyBuZWVkZWQg
Zm9yIHRoZSBzb2xlDQo+ID4gPiA+ID4gcHVycG9zZQ0KPiA+ID4gPiA+IG9mIGludGVyb3AgYmV0
d2VlbiBuZXR3b3JrIGZpbGVzeXN0ZW0gc2VydmVycywgcGxlYXNlIGVubGlnaHRlbg0KPiA+ID4g
PiA+IG1lLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gU2FtZSBkaWZm
ZXJlbmNlLiBBcyBsb25nIGFzIG5mc2QgYW5kL29yIEdhbmVzaGEgYXJlIHRyYW5zbGF0aW5nDQo+
ID4gPiA+IE9QRU40X1NIQVJFX0FDQ0VTU19SRUFEIGFuZCBPUEVONF9TSEFSRV9BQ0NFU1NfV1JJ
VEUgaW50byBzaGFyZQ0KPiA+ID4gPiBhY2Nlc3MNCj4gPiA+ID4gbG9ja3MsIHRoZW4gdGhvc2Ug
d2lsbCBjb25mbGljdCB3aXRoIGFueSBkZW55IGxvY2tzIHNldCBieSB3aGF0ZXZlcg0KPiA+ID4g
PiBhcHBsaWNhdGlvbiB0aGF0IHVzZXMgdGhlbS4NCj4gPiA+ID4NCj4gPiA+ID4gSU9XOiBhbnkg
b3BlbihPX1JET05MWSkgYW5kIG9wZW4oT19SRFdSKSB3aWxsIGNvbmZsaWN0IHdpdGggYW4NCj4g
PiA+ID4gT19ERU5ZX1JFQUQgdGhhdCBpcyBzZXQgb24gdGhlIHNlcnZlciwgYW5kIGFueSBvcGVu
KE9fV1JPTkxZKSBhbmQNCj4gPiA+ID4gb3BlbihPX1JEV1IpIHdpbGwgY29uZmxpY3Qgd2l0aCBh
biBPX0RFTllfV1JJVEUgdGhhdCBpcyBzZXQgb24gdGhlDQo+ID4gPiA+IHNlcnZlci4gVGhlcmUg
aXMgbm8gb3B0LW91dCBmb3IgTkZTIGNsaWVudHMgb24gdGhpcyBpc3N1ZSwgYmVjYXVzZQ0KPiA+
ID4gPiBzdGF0ZWZ1bCBORlN2NCBvcGVucyBNVVNUIHNldCBvbmUgb3IgbW9yZSBvZg0KPiA+ID4g
PiBPUEVONF9TSEFSRV9BQ0NFU1NfUkVBRA0KPiA+ID4gPiBhbmQgT1BFTjRfU0hBUkVfQUNDRVNT
X1dSSVRFLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFVyZ2ghIEkgKnRoaW5rKiBJIHVuZGVyc3Rh
bmQgdGhlIGNvbmZ1c2lvbi4NCj4gPiA+DQo+ID4gPiBJIGJlbGlldmUgSmVmZiB3YXMgdGFsa2lu
ZyBhYm91dCBpbXBsZW1lbnRpbmcgYSBtb3VudCBvcHRpb24NCj4gPiA+IHNpbWlsYXIgdG8gLW8g
bWFuZCBmb3IgbG9jYWwgZnMgb24gdGhlIHNlcnZlci4NCj4gPiA+IFdpdGggdGhhdCBtb3VudCBv
cHRpb24sICphbnkqIG9wZW4oKSBieSBhbnkgYXBwIG9mIGZpbGUgZnJvbQ0KPiA+ID4gdGhhdCBt
b3VudCB3aWxsIHVzZSBPX0RFTllfTk9ORSB0byBpbnRlcm9wIGNvcnJlY3RseSB3aXRoDQo+ID4g
PiBuZXR3b3JrIHNlcnZlcnMgdGhhdCBleHBsaWNpdGx5IG9wdC1pbiBmb3IgaW50ZXJvcCBvbiBz
aGFyZSBtb2Rlcy4NCj4gPiA+IEkgYWdyZWUgaXRzIGEgbmljZSBmZWF0dXJlIHRoYXQgaXMgZWFz
eSB0byBpbXBsZW1lbnQgLSBub3QgaW1wb3J0YW50DQo+ID4gPiBmb3IgZmlyc3QgdmVyc2lvbiBJ
TU8uDQo+ID4gPg0KPiA+ID4gSSAqdGhpbmsqIHlvdSBhcmUgdGFsa2luZyBvbiBuZnMgY2xpZW50
IG1vdW50IG9wdGlvbiBmb3INCj4gPiA+IG9wdC1pbi9vdXQgb2Ygc2hhcmUgbW9kZXM/IHRoZXJl
IHdhcyBubyBzdWNoIGludGVudGlvbi4NCj4gPiA+DQo+ID4NCj4gPiBOby4gSSdtIHNheWluZyB0
aGF0IHdoZXRoZXIgeW91IGludGVuZGVkIHRvIG9yIG5vdCwgeW91IF9hcmVfDQo+ID4gaW1wbGVt
ZW50aW5nIGEgbWFuZGF0b3J5IGxvY2sgb3ZlciBORlMuIE5vIHRhbGsgYWJvdXQgT19TSEFSRSBm
bGFncyBhbmQNCj4gPiBpdCBiZWluZyBhbiBvcHQtaW4gcHJvY2VzcyBmb3IgbG9jYWwgYXBwbGlj
YXRpb25zIGNoYW5nZXMgdGhlIGZhY3QgdGhhdA0KPiA+IG5vbi1sb2NhbCBhcHBsaWNhdGlvbnMg
KGkuZS4gdGhlIG9uZXMgdGhhdCBjb3VudCApIGFyZSBiZWluZyBzdWJqZWN0ZWQNCj4gPiB0byBh
IG1hbmRhdG9yeSBsb2NrIHdpdGggYWxsIHRoZSBwb3RlbnRpYWwgZm9yIGRlbmlhbCBvZiBzZXJ2
aWNlIHRoYXQNCj4gPiBpbXBsaWVzLg0KPiA+IFNvIHdlIG5lZWQgYSBtZWNoYW5pc20gYmV5b25k
IE9fU0hBUkUgaW4gb3JkZXIgdG8gZW5zdXJlIHRoaXMgc3lzdGVtDQo+ID4gY2Fubm90IGJlIHVz
ZWQgb24gc2Vuc2l0aXZlIGZpbGVzIHRoYXQgbmVlZCB0byBiZSBhY2Nlc3NpYmxlIHRvIGFsbC4g
SXQNCj4gPiBjb3VsZCBiZSBhbiBleHBvcnQgb3B0aW9uLCBvciBhIG1vdW50IG9wdGlvbiwgb3Ig
aXQgY291bGQgYmUgYSBtb3JlDQo+ID4gc3BlY2lmaWMgbWVjaGFuaXNtIChlLmcuIHRoZSBzZXRn
aWQgd2l0aCBubyBleGVjdXRlIG1vZGUgYml0IGFzIHVzaW5nDQo+ID4gaW4gUE9TSVggbWFuZGF0
b3J5IGxvY2tzKS4NCj4gPg0KPg0KPiBUaGF0J3MgYSBncmVhdCBwb2ludC4NCj4NCj4gSSB3YXMg
Zm9jdXNlZCBvbiB0aGUgbG9jYWwgZnMgcGllY2UgaW4gb3JkZXIgdG8gc3VwcG9ydCBORlMvU01C
IHNlcnZpbmcsDQo+IGJ1dCB3ZSBhbHNvIGhhdmUgdG8gY29uc2lkZXIgdGhhdCBwZW9wbGUgdXNp
bmcgbmZzIG9yIGNpZnMgZmlsZXN5c3RlbXMNCj4gd291bGQgd2FudCB0byB1c2UgdGhpcyBpbnRl
cmZhY2UgdG8gaGF2ZSB0aGVpciBjbGllbnRzIHNldCBkZW55IGJpdHMgYXMNCj4gd2VsbC4NCj4N
Cj4gU28sIEkgdGhpbmsgeW91J3JlIHJpZ2h0IHRoYXQgd2UgY2FuJ3QgcmVhbGx5IGRvIHRoaXMg
d2l0aG91dCBpbnZvbHZpbmcNCj4gbm9uLWNvb3BlcmF0aW5nIHByb2Nlc3NlcyBpbiBzb21lIHdh
eS4NCg0KSXQncyBiZWVuIDUrIHllYXJzIHNpbmNlIEkgdG91Y2hlZCB0aGF0IGNvZGUgYnV0IEkg
c3RpbGwgbGlrZSB0aGUgaWRlYSBvZiBoYXZpbmcgYSBzZXBhcmF0ZSBtb3VudCBvcHRpb24gZm9y
IG1vdW50cG9pbnRzIHVzZWQgYnkgU2FtYmEgYW5kIE5GUyBzZXJ2ZXJzIGFuZCBjbGllbnRzIHRv
IGF2b2lkIHNlY3VyaXR5IGF0dGFja3Mgb24gdGhlIHNlbnNpdGl2ZSBmaWxlcy4gRm9yIHNvbWUg
c2Vuc2l0aXZlIGZpbGVzIG9uIHN1Y2ggbW91bnRwb2ludHMgYSBtb3JlIHNlbGVjdGl2ZSBtZWNo
YW5pc20gbWF5IGJlIHVzZWQgdG8gcHJldmVudCBkZW55IGZsYWdzIHRvIGJlIHNldCAobGlrZSBt
ZW50aW9uZWQgYWJvdmUpLiBPciB3ZSBtYXkgdGhpbmsgYWJvdXQgYWRkaW5nIGFub3RoZXIgZmxh
ZyBlLmcuIE9fREVOWUZPUkNFIGF2YWlsYWJsZSB0byByb290IG9ubHkgdGhhdCB0ZWxscyB0aGUg
a2VybmVsIHRvIG5vdCB0YWtlIGludG8gYWNjb3VudCBkZW55IGZsYWdzIGFscmVhZHkgc2V0IG9u
IGEgZmlsZSAtIG1pZ2h0IGJlIHVzZWZ1bCBmb3IgcmVjb3ZlcnkgdG9vbHMuDQoNCkFib3V0IE9f
REVOWURFTEVURTogSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB3ZSBtYXkgcmVhY2ggYSBnb29kIGlu
dGVyb3Agc3Rvcnkgd2l0aG91dCBhIHByb3BlciBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGZsYWcu
IFdpbmRvd3MgYXBwcyBtYXkgc2V0IGl0IGFuZCBTYW1iYSBuZWVkcyB0byByZXNwZWN0IGl0LiBJ
ZiBhbiBORlMgY2xpZW50IHJlbW92ZXMgc3VjaCBhbiBvcGVuZWQgZmlsZSwgd2hhdCB3aWxsIFNh
bWJhIHRlbGwgdGhlIFdpbmRvd3MgY2xpZW50Pw0KDQo+DQo+IEEgbW91bnQgb3B0aW9uIHNvdW5k
cyBsaWtlIHRoZSBzaW1wbGVzdCB3YXkgdG8gZG8gdGhpcy4gV2UgaGF2ZQ0KPiBTQl9NQU5ETE9D
SyBub3csIHNvIHdlJ2QganVzdCBuZWVkIGEgU0JfREVOWUxPQ0sgb3Igc29tZXRoaW5nIHRoYXQg
d291bGQNCj4gZW5hYmxlIHRoZSB1c2Ugb2YgT19ERU5ZX1JFQUQvV1JJVEUgb24gYSBmaWxlLiBN
YXliZSAnLW8gZGVueW1vZGUnIG9yDQo+IHNvbWV0aGluZy4NCg0KSSByZW1lbWJlciBpdCB3YXMg
J3NoYXJlbG9jaycgaW4gbXkgcGF0Y2hzZXQgYnV0IG5hbWluZyBoZXJlIGlzIGEgbGVhc3QgaW1w
b3J0YW50IEkgZ3Vlc3MuDQoNCj4NCj4gWW91IG1pZ2h0IHN0aWxsIGdldCBiYWNrIEVCVVNZIG9u
IGEgbmZzIG9yIGNpZnMgZmlsZXN5c3RlbSBldmVuIHdpdGhvdXQNCj4gdGhhdCBvcHRpb24sIGJ1
dCB0aGVyZSdzIG5vdCBtdWNoIHdlIGNhbiBkbyBhYm91dCB0aGF0Lg0KDQpJIGVuZGVkIHVwIHdp
dGggYSBuZXcgRVNIQVJFREVOSUVEIGVycm9yIGNvZGUgd2hpY2ggSSBmb3VuZCBiZXR0ZXIgZm9y
IGRldGVjdGFiaWxpdHkgLSBtaWdodCBiZSB1c2VmdWwgdG8ga25vdyBhbiBleGFjdCByZWFzb24g
b2YgdGhlIG9wZW4gY2FsbCBiZWluZyBmYWlsZWQuIExldCdzIHNheSBhIERCIGluc3RhbmNlIHdh
bnRzIHRvIGJlIHN1cmUgdGhhdCBhIHBhcnRpdGlvbiBmaWxlIGlzIGFscmVhZHkgYmVpbmcgc2Vy
dmVkIGJ5IGFub3RoZXIgaW5zdGFuY2UgYmVmb3JlIGdpdmluZyB1cCBvbiB0cnlpbmcgdG8gb3Bl
biBpdC4NCg0KLS0NCkJlc3QgcmVnYXJkcywNClBhdmVsIFNoaWxvdnNreQ0K
