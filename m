Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9034D5B07D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF3Pub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 11:50:31 -0400
Received: from mail-eopbgr820110.outbound.protection.outlook.com ([40.107.82.110]:1664
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfF3Pub (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 11:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+pbt2bhsqxj+8dMJyq6tghY7MDvofzFlXLCMldK+Wc=;
 b=bkWhVQ9aVctTu4MvawBTc055amVueILshtl1e5Tqhn2KeVT9NkB1Cz+DEiDhG4JXm2a9yAVeVgJ/m8Rc9y+eyAlymmE6r5cYAKBaRn1q/JYANjasjCywadMpRM3nIRWHLVseCKOOBxOAOnsaipyvxU5Lr6I0lD9pisoLe8OXaHo=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1865.namprd13.prod.outlook.com (10.171.157.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Sun, 30 Jun 2019 15:50:27 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::3064:e318:82d9:4887]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::3064:e318:82d9:4887%12]) with mapi id 15.20.2052.010; Sun, 30 Jun
 2019 15:50:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 02/16] locks: create a new notifier chain for lease
 attempts
Thread-Topic: [PATCH 02/16] locks: create a new notifier chain for lease
 attempts
Thread-Index: AQHVL0tm7oL7nl+in02KdZ7uIyUD1qa0Ug0AgAAGbIA=
Date:   Sun, 30 Jun 2019 15:50:27 +0000
Message-ID: <999d661d4761aea774cb27dca001d841f7a661c0.camel@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
         <20190630135240.7490-2-trond.myklebust@hammerspace.com>
         <20190630135240.7490-3-trond.myklebust@hammerspace.com>
         <20190630152726.GB15900@bombadil.infradead.org>
In-Reply-To: <20190630152726.GB15900@bombadil.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.245.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1e00a84-e106-4c9a-2450-08d6fd72abe6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1865;
x-ms-traffictypediagnostic: DM5PR13MB1865:
x-microsoft-antispam-prvs: <DM5PR13MB186511D1DE2BC7464BEF3E55B8FE0@DM5PR13MB1865.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 008421A8FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(136003)(396003)(366004)(376002)(199004)(189003)(6246003)(71200400001)(8936002)(99286004)(6506007)(316002)(6916009)(2351001)(14454004)(4326008)(54906003)(4744005)(81166006)(118296001)(25786009)(6436002)(2501003)(2906002)(1730700003)(81156014)(66066001)(8676002)(66946007)(2616005)(186003)(66556008)(3846002)(6116002)(53936002)(64756008)(6512007)(478600001)(102836004)(486006)(446003)(36756003)(7736002)(11346002)(73956011)(14444005)(26005)(5640700003)(66476007)(68736007)(476003)(5660300002)(256004)(229853002)(6486002)(71190400001)(76176011)(305945005)(86362001)(76116006)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1865;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UvVleULeo/pUmvu8inXXJbbxdNtfFA+tajjp11e/gVZZERQy0C9y+U64cms+0NmZSh8IENk1/FXjpW5d6VQAhn3dQ5/dGy36H5PvbLDpQ5EEREqfahttluUhNPOLs3SThWK4ToFmZXYceRsz5Suy6h+TRUdeASHw92ir+OncdvSjP05Q4YWw9DOJNpbBAHS+jQSVjk7L9FFockHcGkPGRwmgj9AKRU/Kv3mLFoH2gxb0zjCJ4DJQd7iRwaEoTfI9zsCeV0bhM1GAOreUcA8a1YNbrHxoYOKh9D+3YqLujxK6fJPCT60AGnw1mrZ5UCSYYCeKsFXOq6RHvvUORlKs55jZsGIr+ScQ5DjuppApoAebPlzj79cRPe+0hfhl9SOShRVk+V2gOEV0vosTBqpND39vcjHuOkHiP8bPkO7HhiA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57DA87C22A13ED4B9D0C4261BC220CB4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e00a84-e106-4c9a-2450-08d6fd72abe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2019 15:50:27.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1865
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU3VuLCAyMDE5LTA2LTMwIGF0IDA4OjI3IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gU3VuLCBKdW4gMzAsIDIwMTkgYXQgMDk6NTI6MjZBTSAtMDQwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ICsrKyBiL2ZzL2xvY2tzLmMNCj4gPiBAQCAtMjEyLDYgKzIxMiw3IEBA
IHN0cnVjdCBmaWxlX2xvY2tfbGlzdF9zdHJ1Y3Qgew0KPiA+ICBzdGF0aWMgREVGSU5FX1BFUl9D
UFUoc3RydWN0IGZpbGVfbG9ja19saXN0X3N0cnVjdCwNCj4gPiBmaWxlX2xvY2tfbGlzdCk7DQo+
ID4gIERFRklORV9TVEFUSUNfUEVSQ1BVX1JXU0VNKGZpbGVfcndzZW0pOw0KPiA+ICANCj4gPiAr
DQo+ID4gIC8qDQo+ID4gICAqIFRoZSBibG9ja2VkX2hhc2ggaXMgdXNlZCB0byBmaW5kIFBPU0lY
IGxvY2sgbG9vcHMgZm9yIGRlYWRsb2NrDQo+ID4gZGV0ZWN0aW9uLg0KPiA+ICAgKiBJdCBpcyBw
cm90ZWN0ZWQgYnkgYmxvY2tlZF9sb2NrX2xvY2suDQo+IA0KPiAqY291Z2gqDQo+IA0KDQpPb3Bz
LiBZZXMsIHRoYXQgaHVuayBpcyBwcm9iYWJseSBub24tY3JpdGljYWwuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
