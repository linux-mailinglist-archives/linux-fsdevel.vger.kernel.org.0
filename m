Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1B27B02C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1Oog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 10:44:36 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com ([40.107.237.125]:18272
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgI1Oog (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsIxFofhWHmGuFiFbMmVmC5Ns/JxuFGgSLSgFNNLkoHVcZQRy1qbTTrox5rioREyEokWYyejomL8HSPg0qRf+UrkZgO6yXTYRu4j4VjfxGQ/LVF7lImlnk4ULIMyTwsjJbGta3g8VK0SmItigfZCGi14aDCVOCON1fI3umP0tJJq8SJkd8+hfxm8qQCrxUGUpIJwjln9A/oHxM0/b2cr1pWp4w3sktQGnOgOdm8IsYyVPcT5Alz5N6AH+azUVGwELMUpsDeUATc3FfwHmRHStQq/jAelkH5bt+pHbKYmk+gnACfd7ZAPUxuqKKsEjDMDMc6j7NpcntMPq12lTIrJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qMjAPzOahxutdTEmEGXwsvWzQqritR6ZBs6o61LDL8=;
 b=NeUH065Rt4SqJ1HH/1BN7HWfyPZX7H/NA2UkcgQxblL5hIfD1QY0mAqljqjvYaEe5p2S4h55Nx5qWFIdqxelWcbZLLsTj8S4LF9N3EPYCO7mXb1kZ4mevbkNj72b189S47Qb4cL5bGOQDcrj3kqc5o3YQd/S7I2ELQ6Gfo1xPkW4fZ0I/E4W+ADVGo11VLLfKVUOhbSi+Esu7a28XSrjCvKwOJUnm2xcBSsiSCp0MIqcTlbqHCAuMV+QfeX4U0n0Frn99We4ZLmTyjGJtCffeStGaXeMTq2iZzOIBL+zmjigyQbs5MehUnmnZtvlvPmJzS0nbIr5rdk5APXuddU3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qMjAPzOahxutdTEmEGXwsvWzQqritR6ZBs6o61LDL8=;
 b=ga/ZeHYGLGYzbWTYJNHms9rWwhuaEFxsRg/K2m05vUAtDYpSnknTVndmeUPGIMkwVErxTM4xHYXwQl5yWT7PQMBTu/aBKTfGt7MyxqpENM5AsBcZoPMXXUm2WZEw7fDiIW3V/WDEssKzFnU/INIA+SCo6f87UgvKSOJ1YyHqeHQ=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1879.namprd22.prod.outlook.com (2603:10b6:610:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 14:44:30 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a6:b9c8:5c74:f348]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a6:b9c8:5c74:f348%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:44:30 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Thread-Topic: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Thread-Index: AQHWlaXftt1gygiUqkOrm82jtW+5Rw==
Date:   Mon, 28 Sep 2020 14:44:30 +0000
Message-ID: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=purdue.edu;
x-originating-ip: [66.253.158.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15cd8faf-d8d7-4f68-0ee3-08d863bd01d4
x-ms-traffictypediagnostic: CH2PR22MB1879:
x-microsoft-antispam-prvs: <CH2PR22MB1879F7F3343B958C3D86F303DF350@CH2PR22MB1879.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iptWhiJjLpr1lZLrmkHcspc104pWk8IBLTINVUAv/KBcwTmOC8uEdClOkK+1HSYD69ZrA9zodZGDqGVsthEEeSsLnDjK1/6H6k7AmYo8Q1VMAQWBzRDF0xovXhoF6ZXZyphcLYqNubpDkcKQkKwGVJB5S7qOXxPJgSPuGYVd3clOIoRt/SEYuVlT/yhsChZTAXYTRjX/w2m1Z86GjZi6JO8vuXaH2E+4TRMPywDUxSclIQTTVxvgHdWol2kTxKAxuPrm71Aqviv6kgmlzk22TC5yn7yhF+Yiw/p55VvnRgK2rQdiPCcbZoBkevrtNkIuy5xebAsU5xGL5UAcgUpjvuRsT5aWAxF10dXWE5M6SfQQDKjp6ATwI7pDebz2meVf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(33656002)(786003)(186003)(316002)(2616005)(75432002)(8936002)(6506007)(478600001)(76116006)(6486002)(66946007)(5660300002)(26005)(6512007)(4326008)(6916009)(8676002)(2906002)(83380400001)(71200400001)(86362001)(66476007)(66556008)(64756008)(66446008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BqrBuUKWMvvqzZOmKzAuK+5+nSo5tu2fxeeDyVBo2pRsjQtoXmcoVTi2BM1wNpKCA3oausW2jhGC+ZwgqWMqCliw0xJPtuugc13zMylSBLz01Dram0wSVOaYWsmmOV9xYX/YtHFDoumcqLdQA3e+FZg/qx/CErkQVWsTAKNFBMDP++SpYvhw7ZYvAwE1OI7K42nIzijThzt1k8SywfIL3a0DuB89Ich3rxPSkPHl8x/GMqa/bmiR9tc29ayjBVa+TYmDhOLjbtpXz40jc9nEMAAIVR/aF84RqdYPeyMlF6QLJldVXtaXnF3bTM69q0jbtTzpK6RuVm+mwe/X/1RhOZzPh11m2+4bNKueMthclYX3QVW3XSsLg5kNbQ5QCrtQX3MtlP4+nBgsHJwsjQ1+PwcNUTLhMh2BGNmtPgTH599sKOOTMlUIW63HCyHlBZJqmiuLxtFGpS6A2ON4DR4EVMLn9FknU9Ycd4UewLrMrE6XFjpPEyg1P0MFccPwB71rNf3DN47VTX8w+XPEiqWUrbGwKvSM6EmKbXas9ho3d2oaly5mrW8bNZcJfrQw4WwXSSx/tBrevY80lezRwxq9b8aNNV8y8L3CmjBj5/fCoRl7cLNtXNnlkX7x6KhLLMN80porxvoQ6P8Dixm6+9h4ZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE9871F62692F43AB7C339B42BA7B00@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cd8faf-d8d7-4f68-0ee3-08d863bd01d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:44:30.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQiKUXEllnRPZ7joFvs11xt/OYQJl7kII6vfS2EnALZkFOo6I5hntz2B4J6wKis/2GERfF/uOWbXkekAMS7OWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1879
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNCldlIGZvdW5kIGEgcG90ZW50aWFsIGNvbmN1cnJlbmN5IGJ1ZyBpbiBsaW51eCBrZXJu
ZWwgNS4zLjExLiBXZSBhcmUgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBidWcgaW4geDg2IHVuZGVy
IHNwZWNpZmljIHRocmVhZCBpbnRlcmxlYXZpbmdzLiBUaGlzIGJ1ZyBjYXVzZXMgYSBibGtfdXBk
YXRlX3JlcXVlc3QgSS9PIGVycm9yLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCktlcm5lbCBjb25zb2xlIG91dHB1dA0KYmxrX3VwZGF0ZV9yZXF1ZXN0OiBJ
L08gZXJyb3IsIGRldiBsb29wMCwgc2VjdG9yIDAgb3AgMHgwOihSRUFEKSBmbGFncyAweDgwNzAw
IHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KVGVzdCBpbnB1dA0KVGhpcyBidWcgb2NjdXJzIHdoZW4ga2VybmVsIGZ1
bmN0aW9ucyBkb192ZnNfaW9jdGwoKSBhbmQgZG9fcmVhZHYoKSBhcmUgZXhlY3V0ZWQgd2l0aCBj
ZXJ0YWluIHBhcmFtZXRlcnMgaW4gdHdvIHNlcGFyYXRlIHRocmVhZHMgYW5kIHJ1biBjb25jdXJy
ZW50bHkuDQoNClRoZSB0ZXN0IHByb2dyYW0gaXMgZ2VuZXJhdGVkIGluIFN5emthbGxlcuKAmXMg
Zm9ybWF0IGFzIGZvbGxvd3M6DQpUZXN0IDEgW3J1biBpbiB0aHJlYWQgMV0NCnN5el9yZWFkX3Bh
cnRfdGFibGUoMHgwLCAweDEsICYoMHg3ZjAwMDAwMDA2YzApPVt7MHgwLCAweDAsIDB4MTAwfV0p
DQpUZXN0IDIgW3J1biBpbiB0aHJlYWQgMl0NCnIwID0gc3l6X29wZW5fZGV2JGxvb3AoJigweDdm
MDAwMDAwMDAwMCk9Jy9kZXYvbG9vcCNceDAwJywgMHgwLCAweDApDQpyZWFkdihyMCwgJigweDdm
MDAwMDAwMDM0MCk9W3smKDB4N2YwMDAwMDAwNDQwKT0iIi80MDk2LCAweDEwMDB9XSwgMHgxKQ0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkludGVybGVhdmlu
Zw0KVGhyZWFkIDEJCQkJCQkJCQkJCQkJVGhyZWFkIDINCgkJCQkJCQkJCQkJCQkJZG9fcmVhZHYo
KQ0KCQkJCQkJCQkJCQkJCQktdmZzX3JlYWR2KCkNCgkJCQkJCQkJCQkJCQkJLS1kb19pdGVyX3Jl
YWQoKQ0KCQkJCQkJCQkJCQkJCQktLS1kb19pdGVyX3JlYWR2X3dyaXRldigpDQoJCQkJCQkJCQkJ
CQkJCS0tLS1ibGtkZXZfcmVhZF9pdGVyKCkNCmRvX3Zmc19pb2N0bCgpCQkJCQkJDQotLXZmc19p
b2N0bCgpCQ0KLS1ibGtkZXZfaW9jdGwoKQ0KLS0tYmxrZGV2X2RyaXZlcl9pb2N0bCgpCQkJCQ0K
LS0tLWxvb3Bfc2V0X2ZkKCkNCi0tLS0tYmRfc2V0X3NpemUoKQ0KCQkJCQkJCQkJCQkJCQkJKGZz
L2Jsa19kZXYuYzoxOTk5KQ0KCQkJCQkJCQkJCQkJCQkJbG9mZl90IHNpemUgPSBpX3NpemVfcmVh
ZChiZF9pbm9kZSk7DQoJCQkJCQkJCQkJCQkJCQlsb2ZmX3QgcG9zID0gaW9jYi0+a2lfcG9zOw0K
CQkJCQkJCQkJCQkJCQkJaWYgKHBvcyA+PSBzaXplKQ0KCQkJCQkJCQkJCQkJCQkJCXJldHVybiAw
Ow0KCQkJCQkJCQkJCQkJCQkJc2l6ZSAtPSBwb3M7DQoNCgkJCQkJCQkJCQkJCQkJLS0tLWdlbmVy
aWNfZmlsZV9yZWFkX2l0ZXIoKQ0KCQkJCQkJCQkJCQkJCQkJKG1tL2ZpbGVtYXAuYzoyMDY5KQkN
CgkJCQkJCQkJCQkJCQkJCXBhZ2UgPSBmaW5kX2dldF9wYWdlKG1hcHBpbmcsIGluZGV4KTsNCgkJ
CQkJCQkgIAkJCQkJCQkJaWYgKCFwYWdlKSB7DQoJCQkJCQkJCQkJCQkJCQkJaWYgKGlvY2ItPmtp
X2ZsYWdzICYgSU9DQl9OT1dBSVQpDQoJCQkJCQkJCQkJCQkJCQkJCWdvdG8gd291bGRfYmxvY2s7
DQoJCQkJCQkJCQkJCQkJCQlwYWdlX2NhY2hlX3N5bmNfcmVhZGFoZWFkKG1hcHBpbmcsDQoNCgkJ
CQkJCQkJCQkJCQkJCS0tLS0tcGFnZV9jYWNoZV9zeW5jX3JlYWRhaGVhZCgpDQoJCQkJCQkJCQkJ
CQkJCQktLS0tLS1vbmRlbWFuZF9yZWFkYWhlYWQoKQ0KCQkJCQkJCQkJCQkJCQkJ4oCmDQoJCQkJ
CQkJCQkJCQkJCQktLS0tLS0tLS0tLS4uLmJsa191cGRhdGVfcmVxdWVzdCgpDQoJCQkJCQkJCQkJ
CQkJCQkoZXJyb3IpDQotLS0tLWxvb3Bfc3lzZnNfaW5pdCgpDQrigKYNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpBbmFseXNpcw0KV2Ugb2JzZXJ2ZWQgdGhh
dCB3aGVuIHRocmVhZCAyIGlzIGV4ZWN1dGVkIGFsb25lIHdpdGhvdXQgdGhyZWFkIDEsIGlfc2l6
ZV9yZWFkKCkgYXQgZnMvYmxrX2Rldi5jOjE5OTkgcmV0dXJucyBhIHNpemUgb2YgMCwgdGh1cyBp
biBzZXF1ZW50aWFsIG1vZGUgYmxrZGV2X3JlYWRfaXRlcigpIHJldHVybnMgZGlyZWN0bHkgYXQg
4oCccmV0dXJuIDA74oCdIEhvd2V2ZXIsIHdoZW4gdHdvIHRocmVhZHMgYXJlIGV4ZWN1dGVkIGNv
bmN1cnJlbnRseSwgdGhyZWFkIDEgY2hhbmdlcyB0aGUgc2l6ZSBvZiB0aGUgc2FtZSBpbm9kZSB0
aGF0IHRocmVhZCAyIGlzIGNvbmN1cnJlbnRseSBhY2Nlc3NpbmcsIHRoZW4gdGhyZWFkIDIgZ29l
cyBpbnRvIGEgZGlmZmVyZW50IHBhdGgsIGV2ZW50dWFsbHkgY2F1c2luZyB0aGUgYmxrX3VwZGF0
ZV9yZXF1ZXN0IEkvTyBlcnJvci4NCg0KDQpUaGFua3MsDQpTaXNodWFpDQoNCg==
