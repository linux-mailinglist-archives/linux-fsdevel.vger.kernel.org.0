Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC212C8733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 15:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgK3Ox4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 09:53:56 -0500
Received: from mail-eopbgr750124.outbound.protection.outlook.com ([40.107.75.124]:30854
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbgK3Oxz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:53:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7Oa6AoWj4XkXWQWGZt4uuTPdQnxcFV4CiCrj6CC0nRZ3HAvvLNaJaRNNu5nsChYJ53HsjOqC5pQEkvouHBH1qmMMGdaggPhzsCMJwzpH+ZyGJRe0cG0bHBYA21bD2s0fRoiAhAEaUcN7isk0Zov+jZ0KkuWY4/mBvLEl8qcOS90HJVc16msQl9cISXUoQfXFCXhX1nm4S/R5GsvM3XOPkd6c/+WQQ3qq9JBtq8rBHul0fK2tMzY/l7/z9PUXLfDtxrFwxe4O9eAOuW+uaaswC2ubwVL5GX0yzAUyMuP93r/3ppwDe4r6wqjBLQ7omxqmDUnyX1+Aob2SLYHyfgk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eQX1ZVHpqcRb+yV6YPl+0H/sei1BzjTluSNfOtRIZk=;
 b=gl3vZuvrbikxQ8hr5/m6X9ub+qUco8Ye1ummpHuWAFuH4BvEln2fn9H8MUvTCtCzOsnELP/NemTIyd0dYdZvAaexVY3L2J6PSRoIIZoQHBaDJxN/sIPFUb4JU5Y7Qf4f9o1crNXXXxN2ffmNyo/fwhF2MhK1YONdmYS+pnFjHRpqvScTfxCroUXVj/hDp3Qg09UNTAamidVl9mqp9gSd/FK6ceTyFbi8sHe+PhauPbVB+QmpQXXwyQ3X5PXbI+V4WK+aRGe7u4MT23334N1cFLdbNb7mAicIDo6NMstrkq6p65lD+N1xiOS+YySDrNb52SgjybQANeMJJCHQ8UXeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eQX1ZVHpqcRb+yV6YPl+0H/sei1BzjTluSNfOtRIZk=;
 b=cSWDXHQOq3Jxw3kvY3tj72ai8oUysqVlPeD95uu0bERtY6WgMp1wzWQPYIInC6+/NcjYtv1F6J7hLgFeFxEf2CxRxzwKW7PbpkywTyESUt4AuU493qNckWjM2Bzxe40dN98UiY8LYZF7vWRA/kZ2XnrjI1U6UOpfgid7NjQ8Pmk=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1944.namprd22.prod.outlook.com (2603:10b6:610:5e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 14:53:12 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa%7]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 14:53:12 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [Race] data race between pip_lock_nested() and put_pipe_info()
Thread-Topic: [Race] data race between pip_lock_nested() and put_pipe_info()
Thread-Index: AQHWxyiGFxkK23BDEkWp8AusuouhXQ==
Date:   Mon, 30 Nov 2020 14:53:11 +0000
Message-ID: <21BEB53C-47C6-4FB3-A0E2-1E07154EC59E@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72b0ed63-c414-42b6-8399-08d8953fa8d8
x-ms-traffictypediagnostic: CH2PR22MB1944:
x-microsoft-antispam-prvs: <CH2PR22MB1944B1BA625450106C3E00E3DFF50@CH2PR22MB1944.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NprqJmFjixPBeGlr1mbOL+D8DmJt/kmq3Z3KiEiKRZPyGuj9LcPWM3JbQzxMGX/nN8IIkhJUMbHTKOiB5Ym9xXnT5zCoSzF613SkjSSDTmviMscq/v6nPKu9c1z2xxyv9fTasoq9Bo+IJkOikGkcN47ky/YPGu5wW6659vQHjGkIqx8PDbBdwlO7Ih3RK8FtLlXavRPPzDJRIvQt3T+jVOGYyzt7UQWNdP6eIQ8lKieR76Y+kBMwyuyq4iYCqNV8+yHyQWhDb0+eccaoCjfKDrP+WoqEgEc48kfpM7mDRyRqbrzjJEfkGndUcQ5PL18455jTHbIqpme7OecvKhzWWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(136003)(376002)(366004)(6512007)(6486002)(5660300002)(4326008)(6916009)(2616005)(26005)(6506007)(186003)(478600001)(8676002)(83380400001)(36756003)(66946007)(75432002)(2906002)(8936002)(66556008)(76116006)(86362001)(64756008)(316002)(786003)(33656002)(66446008)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QmxhV0RzQ01wcnd2RDc3UmY5bVBnelR1N2RuN3IyWDFPR3JPcTRIQzExRHRm?=
 =?utf-8?B?c1JDWmxHMFllZVpQWnlvcjZUeDk5S3RNY0VzRzlla01RL3ltcGN3cytWUFhR?=
 =?utf-8?B?aEdDVUVVVG5oendud0pkcFlBRWRsR1IvR1hpYzZpdzBUS2UwbnJCUVUwbDVx?=
 =?utf-8?B?RE1IYnBtdyt4UWVMNmdZUDFiNjNLUDJyVVNwVEloNnk0WXU0V3pua1J1Wjdx?=
 =?utf-8?B?K2xLZGRWOEtMVmRlbERYOTk2TFRWSWtmTkJ2bHBMMzlaN3FUSkdaNkczUnQy?=
 =?utf-8?B?VmtiTFVSUEhlR1RPRVNpWE85dVhkLzdKT1Y1Vm5EN1hTVTJqQWpyMHczRzlT?=
 =?utf-8?B?MzdBNGxOR2l3NFRNMzlsVVJ5b0drZzBoWXNkc1hxclI2Nkk5NHJGSk5IWFJI?=
 =?utf-8?B?N0lrL1lqUW9qY2lHT3c5L3ZldTJJWFNFTTlTVlZJUGRqNnBYYkpNOUhzSEdC?=
 =?utf-8?B?TEdTdkFVRWpYQk5veTdJRncrTkpKSVExaFJOMklhMUFzSzZ3ZkFXWGFEN1RK?=
 =?utf-8?B?WkNZSjBRNWpNQVMvalp5aE9Qb0I0MDM5Tm4rVnRTdzNsSjlaaDdvVXN1SjFz?=
 =?utf-8?B?WUxNdzY3ZThYekdNMGtyRkg2U0tLczV1S0lqNXl6ZEFMbEtaR3B0eDh3Yldz?=
 =?utf-8?B?OGJKdHZOQU9DUFl2d2swS250L3hhYlFLc2tMRmhXU0VyaTI3RGZEQUROOVVD?=
 =?utf-8?B?MkxiSXYxTjZFT3NYVzM0dkNSVlN4Y2pFWG1xZnI2eEFhTENkNGJSZ0pZN3Va?=
 =?utf-8?B?Z1FyaDQ3NmI5ZmFzM0VPZkVEREVlRng4RFYyM1NkQ1VDYThId0ZxcWl2UlRr?=
 =?utf-8?B?NmRSQ1Z4c0FXbGpUOVBab0h0aDhCRzdQSi9IRURJZGZEYlhxWU8wTzlYaWp6?=
 =?utf-8?B?cDI1WlNQMEZvc1FQdEg5aG5IWGFONnltNjk4cG1YSVZZYlNTUk9lVEpjeXha?=
 =?utf-8?B?NmpJbngySGlJenFkMi82VUR1ak90MUNOWFNIYndRQW9BVFIxUnJETDdFclBh?=
 =?utf-8?B?KzV2eEVDampiZVNWKzlqM3RqdWdxNmZES1VOcXplUVBWajB6UlVtSkN1eFhR?=
 =?utf-8?B?K0lJVVN6M0ZDRDBkYk1KKzRxaXVuWlI3MCtxS3doZzBxajNpYm8zWXZPclNq?=
 =?utf-8?B?SDF4UktjRW4vTjFoUWhoQXhsSkZ5WG9JRFVSS2ZlYU5NL2tDd0Z2ZHdmSDV1?=
 =?utf-8?B?bmVXVm9JZmZIdnpEVjJuWjg3VURYbHkvRVJiczd6NmloQmx6dDJ5eTY4Y3R5?=
 =?utf-8?B?K1hrandvSDFpU0c5YUk0ZEZMMzl4dS9ZbFh1a0lIN0M0L3JQWWI0UFhtbWNV?=
 =?utf-8?Q?rLhE7EHJJ92LrmlmKizi2Xs9Ee5u6Ztpzs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30F5DEF641C8CB4DA83D92FC2BC28852@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b0ed63-c414-42b6-8399-08d8953fa8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 14:53:12.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwg6YeRbGtwbJLJ49IjK0UMTw1Xi2nTJ4dolu4ennSIh1QNuxToGM79vfANjwK4f7qONlgnbgUAan1VpqRoDlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1944
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNCldlIGZvdW5kIGEgZGF0YSByYWNlIGluIGxpbnV4IGtlcm5lbCA1LjMuMTEgdGhhdCB3
ZSBhcmUgYWJsZSB0byByZXByb2R1Y2UgaW4geDg2IHVuZGVyIHNwZWNpZmljIGludGVybGVhdmlu
Z3MuIEN1cnJlbnRseSwgd2UgYXJlIG5vdCBzdXJlIGFib3V0IHRoZSBjb25zZXF1ZW5jZSBvZiB0
aGlzIHJhY2UgYnV0IHdlIG5vdGljZWQgdGhhdCB0aGUgcmVhZGVyIGlzIG5vdCBwcm90ZWN0ZWQg
d2hpbGUgdGhlIHdyaXRlciBpcy4gVGh1cywgd2Ugd291bGQgbGlrZSB0byBjb25maXJtIHdpdGgg
dGhlIGNvbW11bml0eSBpZiB0aGlzIGlzIGEgaGFybWZ1bCBidWcuIA0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCldyaXRlciBzaXRlDQoNCi90bXAvdG1wLkI3
emI3b2QyekUtNS4zLjExL2V4dHJhY3QvbGludXgtNS4zLjExL2ZzL3BpcGUuYzo1NzUNCiAgICAg
ICA1NzAgICAgICBzdGF0aWMgdm9pZCBwdXRfcGlwZV9pbmZvKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUpDQogICAgICAgNTcxICAgICAgew0KICAgICAg
IDU3MiAgICAgICAgICAgICAgaW50IGtpbGwgPSAwOw0KICAgICAgIDU3Mw0KICAgICAgIDU3NCAg
ICAgICAgICAgICAgc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2NrKTsNCj09PiAgICA1NzUgICAgICAg
ICAgICAgIGlmICghLS1waXBlLT5maWxlcykgew0KICAgICAgIDU3NiAgICAgICAgICAgICAgICAg
ICAgICBpbm9kZS0+aV9waXBlID0gTlVMTDsNCiAgICAgICA1NzcgICAgICAgICAgICAgICAgICAg
ICAga2lsbCA9IDE7DQogICAgICAgNTc4ICAgICAgICAgICAgICB9DQogICAgICAgNTc5ICAgICAg
ICAgICAgICBzcGluX3VubG9jaygmaW5vZGUtPmlfbG9jayk7DQogICAgICAgNTgwDQogICAgICAg
NTgxICAgICAgICAgICAgICBpZiAoa2lsbCkNCiAgICAgICA1ODIgICAgICAgICAgICAgICAgICAg
ICAgZnJlZV9waXBlX2luZm8ocGlwZSk7DQogICAgICAgNTgzICAgICAgfQ0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClJlYWRlciBzaXRlDQoNCi90bXAvdG1w
LkI3emI3b2QyekUtNS4zLjExL2V4dHJhY3QvbGludXgtNS4zLjExL2ZzL3BpcGUuYzo2Mg0KICAg
ICAgICA2MCAgICAgIHN0YXRpYyB2b2lkIHBpcGVfbG9ja19uZXN0ZWQoc3RydWN0IHBpcGVfaW5v
ZGVfaW5mbyAqcGlwZSwgaW50IHN1YmNsYXNzKQ0KICAgICAgICA2MSAgICAgIHsNCj09PiAgICAg
NjIgICAgICAgICAgICAgIGlmIChwaXBlLT5maWxlcykNCiAgICAgICAgNjMgICAgICAgICAgICAg
ICAgICAgICAgbXV0ZXhfbG9ja19uZXN0ZWQoJnBpcGUtPm11dGV4LCBzdWJjbGFzcyk7DQogICAg
ICAgIDY0ICAgICAgfQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCldyaXRlciBjYWxsaW5nIHRyYWNlDQoNCi0gZXhpdF90b191c2VybW9kZV9sb29wDQotLSB0
cmFjZWhvb2tfbm90aWZ5X3Jlc3VtZQ0KLS0tIHRhc2tfd29ya19ydW4NCi0tLS0gX19mcHV0KCkN
Ci0tLS0tIHBpcGVfcmVsZWFzZSgpDQotLS0tLS0gcHV0X3BpcGVfaW5mbw0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClJlYWRlciBjYWxsaW5nIHRyYWNlDQoN
Ci0gZG9fZXBvbGxfd2FpdA0KLS0gc2NoZWR1bGVfaHJ0aW1lb3V0X3JhbmdlDQotLS0gc2NoZWR1
bGVfaHJ0aW1lb3V0X3JhbmdlX2Nsb2NrDQotLS0tIHNjaGVkdWxlDQotLS0tLSBwaXBlX2xvY2sN
CuKAlOKAlOKAlCANCnBpcGVfbG9ja19uZXN0ZWQNCg0KDQoNCg0KVGhhbmtzLA0KU2lzaHVhaQ0K
DQo=
