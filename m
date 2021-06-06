Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78A239D24B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 01:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFFXzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 19:55:51 -0400
Received: from mail-eopbgr1410089.outbound.protection.outlook.com ([40.107.141.89]:8948
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229772AbhFFXzu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:55:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHdU6cygKkJE4LjOFWNTk3z5ttLwbOgJ9ms2y5z3wgTpckzemKQNhmYjdYeOEKGwi2IWQbTcWTdLWwtZChtgWTI2jMeHXHQJuUMvAKY+xfKucWXa/OCq30Fozcn0MTywUDDGl8HOiZP28ICioZ02RLy1fsAm/Fvf5F9absQ+9lcmVuoSmCOLB1AqLv5zUKeCXvj1ZH9mBxVTT0JCEindbaaf2KH5i45FOcmJfE8PvF1zHNZtRoALB1gMDnnjrvi50vqNWXInvl7bCVenxA58AA4F3XzFPt29agNErVqs9VCD64vPmawBy9hWqUGe/UTU8q0LKk21NnHbk4u4Ll3T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dllQD+D1xzhqaPXTpyHTVbc1ABCHaPQnWBAPzonKGjk=;
 b=bmk7akhemXs6Jsii4nJ9QSO11GJKlzK78kyPaMAQD72P6qUuNnH7OjbfxZSf50Cu5XBygq8OURAeaGx/TSSiYEXQoVFuRzrOQJujrqLYJ61DUMgC4Gmh6ZKoaLWtBeOvEfIhJ/Izqs72+pgUfugG7rsn7QXtt5/XPIKr3kaxZfsY94gXicuiGh/HR913i9/lBFt8m4inn2kvzH4Z5Cq76+PmH4zo2CB/g5HyvWSxfhZRscYpoKLJpvKej8BQpmwzowpqyymX0VrGmY4RAnCVi1oubfGMNOCvKQwdZBe4DPb4FE+EMSyl8Dlp4d2J9LsANckpbcYn8z7q5lJdVDsYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dllQD+D1xzhqaPXTpyHTVbc1ABCHaPQnWBAPzonKGjk=;
 b=Mrxlmvg6jd9jngfl89TWFKQgHHg2QcJZdb2POQTbzLe+gmk99fFtyv5p6ka/lXektiF96yEe0EY7SGIBc2fUJtjuRYh6gxK9Xeq/jttWVr2kEREtDC/CLAeLVr7CoWQeeCZdG9NsVe93wilgQnwHw4M2vetUk7fBVnBCOaKYPi8=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Sun, 6 Jun
 2021 23:53:58 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4195.030; Sun, 6 Jun 2021
 23:53:58 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     yangerkun <yangerkun@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jack@suse.cz" <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH v2] mm/memory-failure: make sure wait for page writeback
 in memory_failure
Thread-Topic: [PATCH v2] mm/memory-failure: make sure wait for page writeback
 in memory_failure
Thread-Index: AQHXWRztSAGDZolZykyy10uXbpTE+KsHrDOA
Date:   Sun, 6 Jun 2021 23:53:58 +0000
Message-ID: <20210606235357.GB760852@hori.linux.bs1.fc.nec.co.jp>
References: <20210604084705.3729204-1-yangerkun@huawei.com>
In-Reply-To: <20210604084705.3729204-1-yangerkun@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de1105e3-21f3-4928-f131-08d929465a27
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB593674DDC64A1A6898C1578EE7399@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRRvOuy14767LsqzpowcHg/3I32Z5LxPdek3xxH/yYPm6bhnhVD1Jpc/mFAKN78Gjif/ecglFR9Yht0ODnD4msm7IG4H+oQxgJjqSY9w/eoIwvLpN7jclk9lY+sp3dIW54GO8y4lsyqN0kDOgrRLGNLY7dyXsIEI9sHhm4+N+Ave8kvGZFZTCHjx3Gr98kvRFd+HIoO5QZayuzn2HicNb5kwaLr/LST6E98QX/lgE1pvR50Ic4NyCSRx1xcgl6B0TjamkGnZw81paDoYQazkVmM05jzEyvY00dZ3FiWSPQEDFqgjA7FnbyOEOSByQ4mIO9cQaq/uJUn19IfqhaDp87QLpAZKTBAil3fk/f7FdibwwVqGzDCyQ6qfS0JIVJbvs31Reo5mALNmHLjSmNJEyyv5tWQ8sfMAggK8vdMVkllf2Zwoe+iDAu2ijslMf8BS4x1y4RyAyvwd2l/3HYHY+2aE0dFLN4OSOLXNGuvMJEm8Ai1giOOHHU9bXlka0RxBMrTNYPT1YEeTikt7J7lzEi6/o62RjALpnbkbJFEvuF8C8iT0uZ3lZspxpGnVviQa/osRDsYbq3HCoEDkrhUDWjrZ4fl+riw3e/EFWCbEy7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(66476007)(66556008)(66946007)(64756008)(66446008)(8676002)(6916009)(54906003)(5660300002)(26005)(6506007)(33656002)(1076003)(83380400001)(8936002)(86362001)(55236004)(6486002)(186003)(122000001)(316002)(4326008)(6512007)(478600001)(45080400002)(9686003)(76116006)(2906002)(38100700002)(71200400001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aDJOMTh3WkJ3K2h2Mm0rS2kvSXFOUExOS3VsZDdzVWVrRWxtNXhWMHBFQmps?=
 =?utf-8?B?Q2R6YWRROUJrOEtBUlU1KzBNZm5aeGd3SHlUMzlTZkxyOFBhVTh2b3YxNW5w?=
 =?utf-8?B?cDI0bCt2RWFFTysxdUdEVWpkbm5KQmVQYXFzdGVNcElTc0NGRlkzbEpKQkMz?=
 =?utf-8?B?emVkLzNpTWNoUURUZkJHc1k2OS9xcmJkaWN2RjZqM2hQQzBxK09CK3hjSW40?=
 =?utf-8?B?ZXpxTkpnYTNtSUhqOERBdmZiYzFJd2Z3dURxQU9mZHhKbi9XZXpZRjJHdWxr?=
 =?utf-8?B?Z2xRM0JrSWlDRkdwdkFGOFVWS3hKS2VqNUVDVFVXdXcrbEh2V0xTbysyWGh4?=
 =?utf-8?B?U0preTVsblFJWEJYRE9WK0lSY0s2OEZFR0Q4NlF1M0lDV3I0MVJqb1VlOHAv?=
 =?utf-8?B?c29GdGpLYjYxZHVTTERRajQxN1YvWm1yRU9sQnpoS3NYaUF5YjJQWVdqVFY1?=
 =?utf-8?B?U1l4bWg3ZThaNzc3Zm5LeHdNdmE5MEw1bWVqVGFreFFncjNSQjJ2dHBVbDRO?=
 =?utf-8?B?MEFGYXRSMEdVTnBodWZ4MjY5djlOOGJLYmUxWVVLV2JKK3JKWm5hcVZzYVdS?=
 =?utf-8?B?RkVyRHZreG5KbDhNQU1sa1RKY0ZhbXpqNGJnbHNaMmJIMGVHS0VqTjk2OTBU?=
 =?utf-8?B?VTNTZnFNNHJ4czJRWG5DaVlRcDgyN1BSTnRTWFFJemNCcDRBQndZbGhZSi9D?=
 =?utf-8?B?cm9KZUI3eUJMTHFpa1d5dHM3Y1VyZkF1T28vRlVHK0E4NUowZnJEK3haREYw?=
 =?utf-8?B?dEl5VkVYekxYcU03SnlzTnVFMTl5Qm85bGZiazFacFAxN2Z2Q1pvWS8yMU1C?=
 =?utf-8?B?RkZPc1dYR3lybHYrRjNkZkpacHZuZHNJZXYyOW1NNnlnRzNqQWVHVVRtQ09Q?=
 =?utf-8?B?c0hmUENVbTR4c3E1ckxEd3RYVGh2V1FKV004YkR1dGd5L1ptbVVHTlBCMXkr?=
 =?utf-8?B?YmZSUmp0MkNtMmJBTGkyVHdMdkZ5MTl6UEREOGladC9BbTF1QWtDekxoWXZT?=
 =?utf-8?B?blpCb1E2K3lFR0xDM0Z4SmRyNytuVUVZSzN5Z1d3Z3NNWkplSHMvUDFBVjZS?=
 =?utf-8?B?NEcyMHdnaDZvQ1F1TkpJZEQ0M3U1OHFwSFFpT1dmRlBpZ29PT1Rsd2dSR1pp?=
 =?utf-8?B?MDc3cG0zcTBKL005ZG5DUzJZczRDMGN5WDl3bGFlOTB3Y0c0SkNhcC9iMnBP?=
 =?utf-8?B?Y3paa1UrcytZSmkvM0Q2Z0pPWGp0RlVwbi8veHZNQ1pwbG0vbU9ubVJyeFVD?=
 =?utf-8?B?SjdudktUb0RRWXNJL1lPdzRVQlh0ZUZXRndMZnZKd3hYallKclJGNDVORTZs?=
 =?utf-8?B?VDJJOVpGYWt5dW5TdUVVWlRhTkR0dnVSOVdRWW8rQ005dlpIOWlBWlBDL21H?=
 =?utf-8?B?cGJOVjRMMUpkQ3A2QitRRlVFRnZtNmkzRUNaK2p6eXc1R0N6YUs0cFUzNElV?=
 =?utf-8?B?OVFSdUFLU1lnR29BZkt0VVdtZVdpNWVoV1BCTThpaTFGNVI2YURIZ1VvS0R2?=
 =?utf-8?B?c1oreExDMG8wUVBrbGJRdVhNeDJGUnl5bDU3a3pKaU1zdTJWSDJkQitnNFpW?=
 =?utf-8?B?TFYxUGlTQW1SYkFKcDhiOU1VdUtEakN6MUE5M1gzYWFKSkdBZit2S1BVaWt4?=
 =?utf-8?B?UCtyZERteHRNU0MyazlOYkkzUm1ldE1PdCtsQUpXQ2h0ZWhsaGtiZFlTeE5N?=
 =?utf-8?B?eHhkYmx5WFY1ek9Td0Q0NFc2aTQwd0VTclR5MnZCTUhjeXFsSlBIZ0lEbkdq?=
 =?utf-8?Q?o9i9bAP+8OFxgNAwio6rQrihvtKNZMOye9apyho?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <290962C6A411DF438CCAA826B6A74A5A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1105e3-21f3-4928-f131-08d929465a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2021 23:53:58.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVP23qRX931sycUNbUYoXjMsckQZ2SklM1P1/SzGmTjazLGPRr9fk/2eI3KFVD3PqXpOBfjDVpM4/hS6RLeubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDQ6NDc6MDVQTSArMDgwMCwgeWFuZ2Vya3VuIHdyb3Rl
Og0KPiBPdXIgc3l6a2FsbGVyIHRyaWdnZXIgdGhlICJCVUdfT04oIWxpc3RfZW1wdHkoJmlub2Rl
LT5pX3diX2xpc3QpKSIgaW4NCj4gY2xlYXJfaW5vZGU6DQo+IA0KPiBbICAyOTIuMDE2MTU2XSAt
LS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgMjkyLjAxNzE0NF0ga2Vy
bmVsIEJVRyBhdCBmcy9pbm9kZS5jOjUxOSENCj4gWyAgMjkyLjAxNzg2MF0gSW50ZXJuYWwgZXJy
b3I6IE9vcHMgLSBCVUc6IDAgWyMxXSBTTVANCj4gWyAgMjkyLjAxODc0MV0gRHVtcGluZyBmdHJh
Y2UgYnVmZmVyOg0KPiBbICAyOTIuMDE5NTc3XSAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCj4g
WyAgMjkyLjAyMDQzMF0gTW9kdWxlcyBsaW5rZWQgaW46DQo+IFsgIDI5Mi4wMjE3NDhdIFByb2Nl
c3Mgc3l6LWV4ZWN1dG9yLjAgKHBpZDogMjQ5LCBzdGFjayBsaW1pdCA9DQo+IDB4MDAwMDAwMDBh
MTI0MDlkNykNCj4gWyAgMjkyLjAyMzcxOV0gQ1BVOiAxIFBJRDogMjQ5IENvbW06IHN5ei1leGVj
dXRvci4wIE5vdCB0YWludGVkIDQuMTkuOTUNCj4gWyAgMjkyLjAyNTIwNl0gSGFyZHdhcmUgbmFt
ZTogbGludXgsZHVtbXktdmlydCAoRFQpDQo+IFsgIDI5Mi4wMjYxNzZdIHBzdGF0ZTogODAwMDAw
MDUgKE56Y3YgZGFpZiAtUEFOIC1VQU8pDQo+IFsgIDI5Mi4wMjcyNDRdIHBjIDogY2xlYXJfaW5v
ZGUrMHgyODAvMHgyYTgNCj4gWyAgMjkyLjAyODA0NV0gbHIgOiBjbGVhcl9pbm9kZSsweDI4MC8w
eDJhOA0KPiBbICAyOTIuMDI4ODc3XSBzcCA6IGZmZmY4MDAzMzY2Yzc5NTANCj4gWyAgMjkyLjAy
OTU4Ml0geDI5OiBmZmZmODAwMzM2NmM3OTUwIHgyODogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAy
OTIuMDMwNTcwXSB4Mjc6IGZmZmY4MDAzMmI1ZjQ3MDggeDI2OiBmZmZmODAwMzJiNWY0Njc4DQo+
IFsgIDI5Mi4wMzE4NjNdIHgyNTogZmZmZjgwMDM2YWU2YjMwMCB4MjQ6IGZmZmY4MDAzNjg5MjU0
ZDANCj4gWyAgMjkyLjAzMjkwMl0geDIzOiBmZmZmODAwMzZhZTY5ZDgwIHgyMjogMDAwMDAwMDAw
MDAzM2NjOA0KPiBbICAyOTIuMDMzOTI4XSB4MjE6IDAwMDAwMDAwMDAwMDAwMDAgeDIwOiBmZmZm
ODAwMzJiNWY0N2EwDQo+IFsgIDI5Mi4wMzQ5NDFdIHgxOTogZmZmZjgwMDMyYjVmNDY3OCB4MTg6
IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgMjkyLjAzNTk1OF0geDE3OiAwMDAwMDAwMDAwMDAwMDAw
IHgxNjogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAyOTIuMDM3MTAyXSB4MTU6IDAwMDAwMDAwMDAw
MDAwMDAgeDE0OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDI5Mi4wMzgxMDNdIHgxMzogMDAwMDAw
MDAwMDAwMDAwNCB4MTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgMjkyLjAzOTEzN10geDExOiAx
ZmZmZjAwMDY2Y2Q4ZjUyIHgxMDogMWZmZmYwMDA2NmNkOGVjOA0KPiBbICAyOTIuMDQwMjE2XSB4
OSA6IGRmZmYyMDAwMDAwMDAwMDAgeDggOiBmZmZmMTAwMDZhYzFlODZhDQo+IFsgIDI5Mi4wNDE0
MzJdIHg3IDogZGZmZjIwMDAwMDAwMDAwMCB4NiA6IGZmZmYxMDAwNjZjZDhmMWUNCj4gWyAgMjky
LjA0MjUxNl0geDUgOiBkZmZmMjAwMDAwMDAwMDAwIHg0IDogZmZmZjgwMDMyYjVmNDdhMA0KPiBb
ICAyOTIuMDQzNTI1XSB4MyA6IGZmZmYyMDAwMDgwMDAwMDAgeDIgOiBmZmZmMjAwMDA5ODY3MDAw
DQo+IFsgIDI5Mi4wNDQ1NjBdIHgxIDogZmZmZjgwMDMzNjZiYjAwMCB4MCA6IDAwMDAwMDAwMDAw
MDAwMDANCj4gWyAgMjkyLjA0NTU2OV0gQ2FsbCB0cmFjZToNCj4gWyAgMjkyLjA0NjA4M10gIGNs
ZWFyX2lub2RlKzB4MjgwLzB4MmE4DQo+IFsgIDI5Mi4wNDY4MjhdICBleHQ0X2NsZWFyX2lub2Rl
KzB4MzgvMHhlOA0KPiBbICAyOTIuMDQ3NTkzXSAgZXh0NF9mcmVlX2lub2RlKzB4MTMwLzB4YzY4
DQo+IFsgIDI5Mi4wNDgzODNdICBleHQ0X2V2aWN0X2lub2RlKzB4YjIwLzB4Y2I4DQo+IFsgIDI5
Mi4wNDkxNjJdICBldmljdCsweDFhOC8weDNjMA0KPiBbICAyOTIuMDQ5NzYxXSAgaXB1dCsweDM0
NC8weDQ2MA0KPiBbICAyOTIuMDUwMzUwXSAgZG9fdW5saW5rYXQrMHgyNjAvMHg0MTANCj4gWyAg
MjkyLjA1MTA0Ml0gIF9fYXJtNjRfc3lzX3VubGlua2F0KzB4NmMvMHhjMA0KPiBbICAyOTIuMDUx
ODQ2XSAgZWwwX3N2Y19jb21tb24rMHhkYy8weDNiMA0KPiBbICAyOTIuMDUyNTcwXSAgZWwwX3N2
Y19oYW5kbGVyKzB4ZjgvMHgxNjANCj4gWyAgMjkyLjA1MzMwM10gIGVsMF9zdmMrMHgxMC8weDIx
OA0KPiBbICAyOTIuMDUzOTA4XSBDb2RlOiA5NDEzZjRhOSBkNTAzMjAxZiBmOTAwMTdiNiA5N2Y0
ZDViMSAoZDQyMTAwMDApDQo+IFsgIDI5Mi4wNTU0NzFdIC0tLVsgZW5kIHRyYWNlIDAxYjMzOWRk
MDc3OTVmOGQgXS0tLQ0KPiBbICAyOTIuMDU2NDQzXSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2lu
ZzogRmF0YWwgZXhjZXB0aW9uDQo+IFsgIDI5Mi4wNTc0ODhdIFNNUDogc3RvcHBpbmcgc2Vjb25k
YXJ5IENQVXMNCj4gWyAgMjkyLjA1ODQxOV0gRHVtcGluZyBmdHJhY2UgYnVmZmVyOg0KPiBbICAy
OTIuMDU5MDc4XSAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCj4gWyAgMjkyLjA1OTc1Nl0gS2Vy
bmVsIE9mZnNldDogZGlzYWJsZWQNCj4gWyAgMjkyLjA2MDQ0M10gQ1BVIGZlYXR1cmVzOiAweDEw
LGExMDA2MDAwDQo+IFsgIDI5Mi4wNjExOTVdIE1lbW9yeSBMaW1pdDogbm9uZQ0KPiBbICAyOTIu
MDYxNzk0XSBSZWJvb3RpbmcgaW4gODY0MDAgc2Vjb25kcy4uDQo+IA0KPiBDcmFzaCBvZiB0aGlz
IHByb2JsZW0gc2hvdyB0aGF0IHNvbWVvbmUgY2FsbCBfX211bmxvY2tfcGFnZXZlYyB0byBjbGVh
cg0KPiBwYWdlIExSVSB3aXRob3V0IGxvY2tfcGFnZS4NCj4gDQo+ICAjMCBbZmZmZjgwMDM1ZjAy
ZjRjMF0gX19zd2l0Y2hfdG8gYXQgZmZmZjIwMDAwODA4ZDAyMA0KPiAgIzEgW2ZmZmY4MDAzNWYw
MmY0ZjBdIF9fc2NoZWR1bGUgYXQgZmZmZjIwMDAwOTg1MTAyYw0KPiAgIzIgW2ZmZmY4MDAzNWYw
MmY1ZTBdIHNjaGVkdWxlIGF0IGZmZmYyMDAwMDk4NTFkMWMNCj4gICMzIFtmZmZmODAwMzVmMDJm
NjAwXSBpb19zY2hlZHVsZSBhdCBmZmZmMjAwMDA5ODUyNWMwDQo+ICAjNCBbZmZmZjgwMDM1ZjAy
ZjYyMF0gX19sb2NrX3BhZ2UgYXQgZmZmZjIwMDAwODQyZDJkNA0KPiAgIzUgW2ZmZmY4MDAzNWYw
MmY3MTBdIF9fbXVubG9ja19wYWdldmVjIGF0IGZmZmYyMDAwMDg0YzQ2MDANCj4gICM2IFtmZmZm
ODAwMzVmMDJmODcwXSBtdW5sb2NrX3ZtYV9wYWdlc19yYW5nZSBhdCBmZmZmMjAwMDA4NGM1OTI4
DQo+ICAjNyBbZmZmZjgwMDM1ZjAyZmE2MF0gZG9fbXVubWFwIGF0IGZmZmYyMDAwMDg0Y2JkZjQN
Cj4gICM4IFtmZmZmODAwMzVmMDJmYWYwXSBtbWFwX3JlZ2lvbiBhdCBmZmZmMjAwMDA4NGNlMjBj
DQo+ICAjOSBbZmZmZjgwMDM1ZjAyZmI5MF0gZG9fbW1hcCBhdCBmZmZmMjAwMDA4NGNmMDE4DQo+
IA0KPiBTbyBtZW1vcnlfZmFpbHVyZSB3aWxsIGNhbGwgaWRlbnRpZnlfcGFnZV9zdGF0ZSB3aXRo
b3V0DQo+IHdhaXRfb25fcGFnZV93cml0ZWJhY2suIEFuZCBhZnRlciB0cnVuY2F0ZV9lcnJvcl9w
YWdlIGNsZWFyIHRoZQ0KPiBtYXBwaW5nIG9mIHRoaXMgcGFnZS4gZW5kX3BhZ2Vfd3JpdGViYWNr
IHdvbid0IGNhbGwNCj4gc2JfY2xlYXJfaW5vZGVfd3JpdGViYWNrIHRvIGNsZWFyIGlub2RlLT5p
X3diX2xpc3QuIFRoYXQgd2lsbCB0cmlnZ2VyDQo+IEJVR19PTiBpbiBjbGVhcl9pbm9kZSENCj4g
DQo+IEZpeCBpdCBieSBjaGVjayBQYWdlV3JpdGViYWNrIHRvbyB0byBoZWxwIGRldGVybWluZSBz
aG91bGQgd2UgY2FuIHNraXANCj4gd2FpdF9vbl9wYWdlX3dyaXRlYmFjay4NCj4gDQo+IEZpeGVz
OiAwYmMxZjhiMDY4MmMgKCJod3BvaXNvbjogZml4IHRoZSBoYW5kbGluZyBwYXRoIG9mIHRoZSB2
aWN0aW1pemVkIHBhZ2UgZnJhbWUgdGhhdCBiZWxvbmcgdG8gbm9uLUxSVSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IHlhbmdlcmt1biA8eWFuZ2Vya3VuQGh1YXdlaS5jb20+DQoNCkxvb2tzIGdvb2QgdG8g
bWUsIHRoYW5rIHlvdS4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1
Y2hpQG5lYy5jb20+DQoNCj4gLS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgNyArKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMN
Cj4gaW5kZXggODVhZDk4YzAwZmQ5Li42MTM2OGI0NmJkNjcgMTAwNjQ0DQo+IC0tLSBhL21tL21l
bW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTUyNyw3
ICsxNTI3LDEyIEBAIGludCBtZW1vcnlfZmFpbHVyZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZs
YWdzKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIAl9DQo+ICANCj4gLQlpZiAoIVBhZ2VUcmFuc1RhaWwo
cCkgJiYgIVBhZ2VMUlUocCkpDQo+ICsJLyoNCj4gKwkgKiBfX211bmxvY2tfcGFnZXZlYyBtYXkg
Y2xlYXIgYSB3cml0ZWJhY2sgcGFnZSdzIExSVSBmbGFnIHdpdGhvdXQNCj4gKwkgKiBwYWdlX2xv
Y2suIFdlIG5lZWQgd2FpdCB3cml0ZWJhY2sgY29tcGxldGlvbiBmb3IgdGhpcyBwYWdlIG9yIGl0
DQo+ICsJICogbWF5IHRyaWdnZXIgdmZzIEJVRyB3aGlsZSBldmljdCBpbm9kZS4NCj4gKwkgKi8N
Cj4gKwlpZiAoIVBhZ2VUcmFuc1RhaWwocCkgJiYgIVBhZ2VMUlUocCkgJiYgIVBhZ2VXcml0ZWJh
Y2socCkpDQo+ICAJCWdvdG8gaWRlbnRpZnlfcGFnZV9zdGF0ZTsNCj4gIA0KPiAgCS8qDQo+IC0t
IA0KPiAyLjMxLjENCj4g
