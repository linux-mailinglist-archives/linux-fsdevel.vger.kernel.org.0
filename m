Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283C0A640F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfICIey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 04:34:54 -0400
Received: from mail-eopbgr1400132.outbound.protection.outlook.com ([40.107.140.132]:64504
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfICIex (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFCgWPFBd7Y3p9/HJBDrnpgw6iC5YVyzOeRYh/ALxVu6AUdW814sHM2ccIQn/PzAfh+ke8tTcWfhHrRjWhMsL5eOxxtXKiT+Xud9MOERwogYLjZaCtJafFaW7um8S+L7qE8H5eUfkPAMktRmea4cPZlbXIQ+r0Qcq45+hzZUDKOiOmiG/051B7hBxSv/XSsYUfoCG1HrlDeXLE3QskfF5I7jbY+CkYjwm9ea/vGsotsWCVVKQ1DRY0jMQXQtZj+YkK6SUEhnGL6wVGyXDrqvEQFCas+T9Qr+uy9l/sEfF72n1n+mk9VTBD7wwwE3oeefQleKRtEiK9RGrTTgk5p6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owoIMTIFHxts4zI2/22TtbBDvKTq3nKCuyJyvTVoFP0=;
 b=IsrxI0vxTV0PzRCeKCSodTRv+PP5x40F0nv/qMFkb5VkNlcwvpIZg+s47g6r1SS79Z9f0uSIGDqNf5OMMHePilma/S+4h1eXjWf5B3+fge2bYzm2prpOE0qcFq1kZ7dKza0/PWmvzBZWRhHQr7z7QI/7SEL3g92xiscYklQQ1GecbB7w0CpQ9UJ4S/aniswCGobChvNp8KMe8RSLVdOyh54JEkjLKnEwdwhNoR/0OgFTWiWz//6tTnd1rgDDJiWMa9V8TNbmosXwKxtA3CbU9/xYdlARYabIBfzNcamfBDwOcqK2FvLMQ5FszO8KKgG+j7xyArNjEjxlvy1n3lOeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owoIMTIFHxts4zI2/22TtbBDvKTq3nKCuyJyvTVoFP0=;
 b=NHzssr3lLtgfy4kSYZqDSvou3nFfQtgngDHM4cVe4gnFa2age8PyI84D9K/49zxeLcADuyU/cd0ehPsgyeO0RASWOgo7WBt5nRotAXUyWOn00wvfbA7Gcr3SU9z4suZwIjfypY2flxMcQtOzt451PO+x4PwZs1Oh2ejUmmYDZjE=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4686.jpnprd01.prod.outlook.com (20.179.175.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 08:34:49 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 08:34:49 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     David Howells <dhowells@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "raven@themaw.net" <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/11] Add a general, global device notification watch
 list [ver #7]
Thread-Topic: [PATCH 06/11] Add a general, global device notification watch
 list [ver #7]
Thread-Index: AQHVXzsE5XB2C9EKnU2KIIXOsRrw8KcZpUEg
Date:   Tue, 3 Sep 2019 08:34:49 +0000
Message-ID: <TYAPR01MB454492E48362BED351E797B2D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717348608.2204.16592073177201775472.stgit@warthog.procyon.org.uk>
In-Reply-To: <156717348608.2204.16592073177201775472.stgit@warthog.procyon.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13e28461-db53-4aa3-5778-08d730499596
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB4686;
x-ms-traffictypediagnostic: TYAPR01MB4686:
x-microsoft-antispam-prvs: <TYAPR01MB4686EB2F5B40A5593EF2E314D8B90@TYAPR01MB4686.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(71200400001)(74316002)(316002)(71190400001)(33656002)(6246003)(6436002)(7696005)(76176011)(26005)(25786009)(102836004)(66476007)(66946007)(66556008)(66446008)(64756008)(9686003)(86362001)(76116006)(110136005)(2906002)(6506007)(54906003)(4326008)(53936002)(3846002)(6116002)(99286004)(186003)(476003)(8936002)(7416002)(55016002)(52536014)(2501003)(305945005)(66066001)(7736002)(486006)(8676002)(81156014)(5660300002)(446003)(478600001)(81166006)(229853002)(11346002)(14454004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4686;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L3uLThTX1oWOXUg6fELZlDk2XI+1XVhKCa2ShZAg+4RRTfbaCjplxe//ZBjaBJ4ioqQOYwRuJhxZ6pxTcsNLH5Z28m5XMpBMDzqJj6akNWROtJbM+apRCUkQ6uURL5NV3I92QcUwuKG7xB/Ed8sfsdXXXsoI6N9Io1LQIhcw/KN2ktQpurBtm2smW6Gg7RDTsJorIEPgR7sZO+3YEJiwZH5LUrbhQdAyAXFmILPiGUl0Pis66cg4owp4zRVRu7XYMOX9XbpO/pHQjMy4qMXHOIFd34jWDdHtXQvH9n+o6lo9X2CJ91hl8/YXtx1rKlVbbYCzEUbmcnCnZVYluI60HL1L9/49PTwske1m25ixUkZykCXUeoRBHe7CnbCz4Lv4dSEh9KAfRUCjRgtCLBPYkmk1QJxnSwc+KHKDA5O49J4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e28461-db53-4aa3-5778-08d730499596
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 08:34:49.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCVQdtTboqLHNrezB5NrAiNvGJRZnSmFnlFo3rtiyhsh4PDUVxeikfgB831UPsp+KZPrbXlY+xFT+EsEJ7M1Pxtd8b9SyTEv8xJ2UP9DGaNl8nLNVciVPoeexWhF7x0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4686
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNCj4gRnJvbTogRGF2aWQgSG93ZWxscywgU2VudDogRnJpZGF5LCBBdWd1c3QgMzAsIDIw
MTkgMTA6NTggUE0NCjxzbmlwPg0KPiAtLS0NCj4gDQo+ICBEb2N1bWVudGF0aW9uL3dhdGNoX3F1
ZXVlLnJzdCAgICAgICAgICAgICAgIHwgICAyMiArKysrKystDQo+ICBhcmNoL2FscGhhL2tlcm5l
bC9zeXNjYWxscy9zeXNjYWxsLnRibCAgICAgIHwgICAgMQ0KPiAgYXJjaC9hcm0vdG9vbHMvc3lz
Y2FsbC50YmwgICAgICAgICAgICAgICAgICB8ICAgIDENCj4gIGFyY2gvaWE2NC9rZXJuZWwvc3lz
Y2FsbHMvc3lzY2FsbC50YmwgICAgICAgfCAgICAxDQoNCkl0IHNlZW1zIHRvIGxhY2sgbW9kaWZp
Y2F0aW9uIGZvciBhcmNoL2FybTY0Lg0KDQpJJ20gbm90IHN1cmUgd2hldGhlciB0aGlzIGlzIHJl
bGF0ZWQsIGJ1dCBteSBlbnZpcm9ubWVudCAoUi1DYXIgSDMgLyByOGE3Nzk1KQ0KY2Fubm90IGJv
b3Qgb24gbmV4dC0yMDE5MDkwMiB3aGljaCBjb250YWlucyB0aGlzIHBhdGNoLiBJIGZvdW5kIGFu
IGlzc3VlDQpvbiB0aGUgcGF0Y2ggMDgvMTEsIHNvIEknbGwgcmVwb3J0IG9uIHRoZSBlbWFpbCB0
aHJlYWQgbGF0ZXIuDQoNCj4gIGFyY2gvbTY4ay9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50Ymwg
ICAgICAgfCAgICAxDQo+ICBhcmNoL21pY3JvYmxhemUva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwu
dGJsIHwgICAgMQ0KPiAgYXJjaC9taXBzL2tlcm5lbC9zeXNjYWxscy9zeXNjYWxsX24zMi50Ymwg
ICB8ICAgIDENCj4gIGFyY2gvbWlwcy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbF9uNjQudGJsICAg
fCAgICAxDQo+ICBhcmNoL21pcHMva2VybmVsL3N5c2NhbGxzL3N5c2NhbGxfbzMyLnRibCAgIHwg
ICAgMQ0KPiAgYXJjaC9wYXJpc2Mva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsICAgICB8ICAg
IDENCj4gIGFyY2gvcG93ZXJwYy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50YmwgICAgfCAgICAx
DQo+ICBhcmNoL3MzOTAva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsICAgICAgIHwgICAgMQ0K
PiAgYXJjaC9zaC9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50YmwgICAgICAgICB8ICAgIDENCj4g
IGFyY2gvc3BhcmMva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsICAgICAgfCAgICAxDQo+ICBh
cmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzMyLnRibCAgICAgIHwgICAgMQ0KPiAgYXJj
aC94ODYvZW50cnkvc3lzY2FsbHMvc3lzY2FsbF82NC50YmwgICAgICB8ICAgIDENCj4gIGFyY2gv
eHRlbnNhL2tlcm5lbC9zeXNjYWxscy9zeXNjYWxsLnRibCAgICAgfCAgICAxDQo+ICBkcml2ZXJz
L2Jhc2UvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgOSArKysNCj4gIGRyaXZl
cnMvYmFzZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxDQo+ICBkcml2ZXJz
L2Jhc2Uvd2F0Y2guYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5MCArKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAgICAgICAg
ICAgICAgfCAgICA3ICsrDQo+ICBpbmNsdWRlL2xpbnV4L3N5c2NhbGxzLmggICAgICAgICAgICAg
ICAgICAgIHwgICAgMQ0KPiAgaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL3VuaXN0ZC5oICAgICAg
ICAgICB8ICAgIDQgKw0KPiAga2VybmVsL3N5c19uaS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDENCj4gIDI0IGZpbGVzIGNoYW5nZWQsIDE0OSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYmFzZS93YXRjaC5jDQoN
CkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCg==
