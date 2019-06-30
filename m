Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494605B088
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF3QPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 12:15:06 -0400
Received: from mail-eopbgr810134.outbound.protection.outlook.com ([40.107.81.134]:42240
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfF3QPG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NbTInb3Q1h8ETP1q6lbwWfL655Jnsis58JQpi0Iwxc=;
 b=XE9abBnKktz0wawqdchFdMjB3fhKa/eoIZJ6C59AsjTSDWzOykjMd73P22xDUIn8/PXRB6MEfdez7/eOYxyCv2KbaSeiQFeh9V46gFXNPTWabxobbQZJUaUdO4PC8+yTK6Y8yhR8oR5FkTGM1newJLE1NVrrrxdf6u/9lNXtnXY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1148.namprd13.prod.outlook.com (10.168.120.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Sun, 30 Jun 2019 16:15:00 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::3064:e318:82d9:4887]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::3064:e318:82d9:4887%12]) with mapi id 15.20.2052.010; Sun, 30 Jun
 2019 16:15:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 05/16] nfsd: add a new struct file caching facility to
 nfsd
Thread-Topic: [PATCH 05/16] nfsd: add a new struct file caching facility to
 nfsd
Thread-Index: AQHVL0tq7yqCUIxETkmrUQ1GbWPANKa0WoWAgAAE0AA=
Date:   Sun, 30 Jun 2019 16:15:00 +0000
Message-ID: <61f965d747b74a1eb7406bcde4591f71d56305dc.camel@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
         <20190630135240.7490-2-trond.myklebust@hammerspace.com>
         <20190630135240.7490-3-trond.myklebust@hammerspace.com>
         <20190630135240.7490-4-trond.myklebust@hammerspace.com>
         <20190630135240.7490-5-trond.myklebust@hammerspace.com>
         <20190630135240.7490-6-trond.myklebust@hammerspace.com>
         <20190630155745.GC15900@bombadil.infradead.org>
In-Reply-To: <20190630155745.GC15900@bombadil.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.245.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd2956e-731f-4aa8-157a-08d6fd761a38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1148;
x-ms-traffictypediagnostic: DM5PR13MB1148:
x-microsoft-antispam-prvs: <DM5PR13MB114800FEAEF1D55C0A986776B8FE0@DM5PR13MB1148.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 008421A8FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39830400003)(346002)(366004)(376002)(199004)(189003)(102836004)(54906003)(186003)(53936002)(66946007)(64756008)(73956011)(2351001)(5640700003)(66476007)(66066001)(6512007)(4744005)(66556008)(2501003)(5660300002)(2906002)(229853002)(6116002)(8936002)(76116006)(25786009)(118296001)(6436002)(76176011)(6506007)(68736007)(478600001)(3846002)(86362001)(316002)(71190400001)(71200400001)(8676002)(6486002)(6246003)(1730700003)(6916009)(7736002)(36756003)(81166006)(66446008)(256004)(14454004)(486006)(446003)(305945005)(26005)(99286004)(11346002)(4326008)(2616005)(476003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1148;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A0IE21QJP5cKSrxusyRr4lNgNplcdQsl9uyGKxGmt4WPeU/Mlo0QptXTYyitvNhX/e/dMf2Vj56C4sXaB7Fm/kUddEUxLqJ51W65jUcRPbSAZhI75xNSXi73+IVU6hdB5nO/kZd8Qi4Js/b9qTvDYNsVS2v5IAaj+tiwgnol8oeo2c6RMC2Yex/0kpaEkn3MXxzSgYcMIq5h9hf5KhjL7Eclc98HN6ea28P7UKRjqp3I1YToujVyFf8BTtdBEDnR6aIP65euDQAXQZEtuW/3kQylZXyPkPl5WSE0Q4l5aTvzXA23hLr2R06OnZ/nVOSRyxuhYMxwUVqTY07FjbSo+Wro1XKYCTpydFS1LBkQNTKZq63UvOTryvgyYB031xAenPUV1vjFz3zudi4Unfne23akXWJJobP/7HJZigwdmxU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A21A8B6845EDCF45AE1BF9A400A9DBBB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd2956e-731f-4aa8-157a-08d6fd761a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2019 16:15:00.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU3VuLCAyMDE5LTA2LTMwIGF0IDA4OjU3IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gU3VuLCBKdW4gMzAsIDIwMTkgYXQgMDk6NTI6MjlBTSAtMDQwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ICsvKiBGSVhNRTogZHluYW1pY2FsbHkgc2l6ZSB0aGlzIGZvciB0aGUg
bWFjaGluZSBzb21laG93PyAqLw0KPiA+ICsjZGVmaW5lIE5GU0RfRklMRV9IQVNIX0JJVFMgICAg
ICAgICAgICAgICAgICAgMTINCj4gPiArI2RlZmluZSBORlNEX0ZJTEVfSEFTSF9TSVpFICAgICAg
ICAgICAgICAgICAgKDEgPDwNCj4gPiBORlNEX0ZJTEVfSEFTSF9CSVRTKQ0KPiA+ICsjZGVmaW5l
IE5GU0RfTEFVTkRSRVRURV9ERUxBWQkJICAgICAoMiAqIEhaKQ0KPiANCj4gSXNuJ3QgdGhpcyB3
aGF0IHJoYXNodGFibGUgaXMgZm9yPw0KDQpNYXliZS4gSSdtIGxlc3MgY29uY2VybmVkIHRoYW4g
SmVmZiB3YXMgb3ZlciB0aGUgc2l6ZSBvZiB0aGUgaGFzaA0KdGFibGUuDQoNCjQwOTYgYnVja2V0
cyBzaG91bGQgc2NhbGUgcXVpdGUgd2VsbCB1cCB0byB0aGUgbWlsbGlvbnMgb2YgZW50cmllcy4N
CldlJ3JlIGhpZ2hseSB1bmxpa2VseSB0byBoYXZlIHRoYXQgbWFueSBhY3RpdmUgZmlsZXMgYXQg
dGhlIHNhbWUgdGltZSwNCmFuZCBwYXJ0aWN1bGFybHkgbm90IGZvciBORlN2Mywgd2hpY2ggaXMg
dGhlIG1haW4gY3JpdGljYWwgdXNlciBvZiB0aGlzDQpsb29rdXAgdGFibGUuDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
