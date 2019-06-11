Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50054192C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 01:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405638AbfFKX4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 19:56:11 -0400
Received: from mail-eopbgr670097.outbound.protection.outlook.com ([40.107.67.97]:63909
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404808AbfFKX4L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLgT1++JPQi0Nu33GWU22HzN/RiC/hSZKCNg3J2n85c=;
 b=VsLjOkbAV58pz5Ss65s2n9vGMg5+1/jAJN/UYsz2tGA3NreKD76Z398E2Q1I2AycWXmN01pIxrNIWkXvOhxox28Yox10Snu2IpZfUZ8iTHVEqCxNZ0hxqNv06Q5CSRs9vnR54wnzhZPXm+soQBVPwQuR304G4jWfdLbMpYHeom8=
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM (52.132.44.17) by
 YTOPR0101MB2250.CANPRD01.PROD.OUTLOOK.COM (52.132.50.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 23:56:06 +0000
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516]) by YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516%7]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 23:56:06 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: [PATCH] io_uring: fix SQPOLL cpu check
Thread-Topic: [PATCH] io_uring: fix SQPOLL cpu check
Thread-Index: AQHVILE8MKvlFSwx2kqc/AjEamoMkQ==
Date:   Tue, 11 Jun 2019 23:56:06 +0000
Message-ID: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [2001:bb6:a2c:ed58:2ca3:41e6:9240:e71d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2759eb70-7fcd-4e28-87ee-08d6eec85eb9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YTOPR0101MB2250;
x-ms-traffictypediagnostic: YTOPR0101MB2250:
x-microsoft-antispam-prvs: <YTOPR0101MB22502C6E370F41EDC4E503BDAAED0@YTOPR0101MB2250.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39830400003)(366004)(136003)(396003)(199004)(189003)(68736007)(76116006)(58126008)(486006)(54906003)(6506007)(476003)(6486002)(33656002)(256004)(99286004)(2616005)(2201001)(36756003)(110136005)(2501003)(316002)(102836004)(2906002)(71190400001)(305945005)(86362001)(6512007)(81166006)(81156014)(8676002)(71200400001)(8936002)(14454004)(508600001)(66476007)(66946007)(66556008)(64756008)(91956017)(4744005)(186003)(66446008)(73956011)(25786009)(5660300002)(4326008)(7736002)(53936002)(6116002)(6436002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB2250;H:YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FUytEI66HLW7guPRGv0aVzJAUnXoyumZ84/l5JRlU5cPVraiBZGOoXnVzVnSePGt/oMTAfYOaFaE6rHFOvpn8pRzKXgrCgvj1a2NhmR4XgkeMME8npqI66Eq2gUIDZUBMM0hnPUBBBQydD/xwRpQEuoYM014Milf88wY+OWYWce5kuMpnEqt08sk+OSizTW/Yt5SZLzkAkvUppfUnRAJiAmYX6ZvvASmnGNiRoida/S5GdfQM94wJ9Fsy9m/NOFtL/Nzp78SsLshzb+dN0kUC2s7XZb++QJuJvLCT1Oh11CyFW6Aw0ifQ0yG/UHVnI06U0EYSfBrcFrj1cKnqh8hC/Atgf8Et50ytdGwEkvDiBIK1SUnFWRAJOvcyyZHg6e1QSyZpcoDOYpQjf47ZN/Q9pzK0E/PoH0BCkeBKf8eyqU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3BF8340A20CD74B8B1EC0C365ADD759@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2759eb70-7fcd-4e28-87ee-08d6eec85eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 23:56:06.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB2250
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhlIGFycmF5X2luZGV4X25vc3BlYygpIGNoZWNrIGluIGlvX3NxX29mZmxvYWRfc3RhcnQoKSBp
cyBwZXJmb3JtZWQNCmJlZm9yZSBhbnkgY2hlY2tzIG9uIHAtPnNxX3RocmVhZF9jcHUgYXJlIGRv
bmUuIFRoaXMgbWVhbnMgY3B1IGlzDQpjbGFtcGVkIGFuZCB0aGVyZWZvcmUgbm8gZXJyb3Igb2Nj
dXJzIHdoZW4gb3V0LW9mLXJhbmdlIHZhbHVlcyBhcmUNCnBhc3NlZCBpbiBmcm9tIHVzZXJzcGFj
ZS4gVGhpcyBpcyBpbiB2aW9sYXRpb24gb2YgdGhlIHNwZWNpZmljYXRpb24NCmZvciBpb19yaW5n
X3NldHVwKCkgYW5kIGNhdXNlcyB0aGUgaW9fcmluZ19zZXR1cCB1bml0IHRlc3QgaW4gbGlidXJp
bmcNCnRvIHJlZ3Jlc3MuDQoNCkFkZCBhIG5ldyBib3VuZHMgY2hlY2sgb24gc3FfdGhyZWFkX2Nw
dSBhdCB0aGUgc3RhcnQgb2YNCmlvX3NxX29mZmxvYWRfc3RhcnQoKSBzbyB3ZSBjYW4gZXhpdCB0
aGUgZnVuY3Rpb24gZWFybHkgd2hlbiBiYWQNCnZhbHVlcyBhcmUgcGFzc2VkIGluLg0KDQpGaXhl
czogOTc1NTU0YjAzZWRkICgiaW9fdXJpbmc6IGZpeCBTUVBPTEwgY3B1IHZhbGlkYXRpb24iKQ0K
U2lnbmVkLW9mZi1ieTogU3RlcGhlbiBCYXRlcyA8c2JhdGVzQHJhaXRobGluLmNvbT4NCi0tLQ0K
IGZzL2lvX3VyaW5nLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2ZzL2lvX3VyaW5nLmMgYi9mcy9pb191cmluZy5jDQppbmRleCAzMGE1
Njg3Li5lNDU4NDcwIDEwMDY0NA0KLS0tIGEvZnMvaW9fdXJpbmcuYw0KKysrIGIvZnMvaW9fdXJp
bmcuYw0KQEAgLTIzMTYsNiArMjMxNiw5IEBAIHN0YXRpYyBpbnQgaW9fc3Ffb2ZmbG9hZF9zdGFy
dChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwNCiB7DQogCWludCByZXQ7DQogDQorCWlmIChwLT5z
cV90aHJlYWRfY3B1ID49IG5yX2NwdV9pZHMpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisNCiAJaW5p
dF93YWl0cXVldWVfaGVhZCgmY3R4LT5zcW9fd2FpdCk7DQogCW1tZ3JhYihjdXJyZW50LT5tbSk7
DQogCWN0eC0+c3FvX21tID0gY3VycmVudC0+bW07DQotLSANCjIuNy40DQoNCg==
