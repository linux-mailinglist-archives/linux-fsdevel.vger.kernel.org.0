Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF32FD70A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKOHiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 02:38:05 -0500
Received: from mail-eopbgr30091.outbound.protection.outlook.com ([40.107.3.91]:18830
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfKOHiF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:38:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqV9Ch7vY78lQSTNZAJ7y4R/1nzpR7HQFgFmJ8HuywrFWQ3ppLmAUutGONm+ixbld7/5TQ6Ch8d5/JeMTAD86MH4mLt4vrKTMDw/XwFMapb0V6iQZtWjeNsa7ZHzZ4+LfBXCIEhSDhXkrmJdYY7GQ/s32x7yuI8/CFld2uTJ0FVwWGNJzXUW/Ne3lOU2Eu2Cr2zrWRxTrE18e6gvoxRSOCHMqRGXNSHFizHZ2R3Y4Oryo0btEM3MA7TCxmM8sy7ZiE+0ExYeZn9Rq/E93TM7DwTZZaLAJNOMEL5ZFwSetwPEVpvfJ1Xn+rsmrj/JoeWdWQ9I50T+HkaI6Vvh0IVq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrHtls4t9yOCl9GsSHCAhaIjmNxqov2YqOfTurXj4Vo=;
 b=G0I6zZl6YptLyPmEyPW8UAlb1C/oa3kHn1UQHou+nAIgytUEa6upOvvKy3nqnw7v0rI7AJrsunaU4FzYmMXQDN28J49BTMWH/CGlM4WdYw9JL8mWS2oHRXgqs2tFcDx/bq0uVHdLIFemZkSEiYVSItoTuhyZ9ncYk9N6sb03asSH41sevQDWDxE3PTzr4ZzMf+fE+nuxZZUU8d0NLO0R7puZ6hrSSVEqxrVq+l7d4b/4bHeOboiVjif6tjD5zatXrFly1l6j1VVr0F83hRctEeFkJl7zc3/I93KuOjnYI0fqfLvNd1L7WyYT8EJl7qFTp40pHoGnPuZaWUqPO9KdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrHtls4t9yOCl9GsSHCAhaIjmNxqov2YqOfTurXj4Vo=;
 b=VgtgZU6mxC19TPRSYbrvE1DZk38JSD1BWy8UaB0k/6m+z0HcZ6W4hkUwpd0r7DMM6KCn+QXX3DXgBNt0A+/g9odCeA6Uaf8yss4EU5Y4oHXsDKBiet4e0HtsfIKAIZHRchp5AQcX62ybasPKrWmokd8gllJbOmX8szRLeBgVZpY=
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com (52.132.212.72) by
 AM0PR08MB3012.eurprd08.prod.outlook.com (52.134.92.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 07:37:58 +0000
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::a55d:53b6:474e:68d5]) by AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::a55d:53b6:474e:68d5%3]) with mapi id 15.20.2430.028; Fri, 15 Nov 2019
 07:37:58 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Andrei Vagin (C)" <avagin@gmail.com>
Subject: Re: [PATCH v2] fs: add new O_MNT flag for opening mount root from
 mountpoint fd
Thread-Topic: [PATCH v2] fs: add new O_MNT flag for opening mount root from
 mountpoint fd
Thread-Index: AQHVmsqsFW/dz5a/YUCIFt85IYaocKeKtcAAgAEj3YA=
Date:   Fri, 15 Nov 2019 07:37:58 +0000
Message-ID: <1af96c9c-0e4c-5f18-a710-1db4b6a3cf87@virtuozzo.com>
References: <20191114090454.27903-1-ptikhomirov@virtuozzo.com>
 <20191114141320.GI26530@ZenIV.linux.org.uk>
In-Reply-To: <20191114141320.GI26530@ZenIV.linux.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:208:122::21) To AM0PR08MB5332.eurprd08.prod.outlook.com
 (2603:10a6:208:17e::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [46.39.231.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d67ee7bf-6892-425e-2679-08d7699ebc82
x-ms-traffictypediagnostic: AM0PR08MB3012:
x-ld-processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
x-microsoft-antispam-prvs: <AM0PR08MB30124FA9B9BA31F8935CD1E0B7700@AM0PR08MB3012.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(39850400004)(346002)(366004)(189003)(199004)(14444005)(229853002)(5660300002)(256004)(305945005)(7736002)(2616005)(6486002)(11346002)(446003)(52116002)(8936002)(14454004)(316002)(76176011)(102836004)(6436002)(25786009)(7416002)(478600001)(486006)(54906003)(386003)(6506007)(86362001)(26005)(6916009)(66066001)(8676002)(81166006)(31686004)(81156014)(71200400001)(3846002)(6512007)(6116002)(36756003)(71190400001)(53546011)(186003)(476003)(31696002)(2906002)(66946007)(66446008)(4326008)(99286004)(6246003)(64756008)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3012;H:AM0PR08MB5332.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtRSmfYYL1zkcNEzoqVMc5z23EUPVgOCFZyXudqysQM1zuxLbPusgqcMAxEMdpEXVVYcDELvXSjLeWgwS2cX+LXJ9JuOLCo8ozCAf1f5vGiPol7EwPkO3xOkHTGiMNg/JYSQic8OSKt4tDoEYGbCUC4ixal2lstw8Jf01J/8hXgQO+JqstiPbi7ZRqksUa2l5AKGqkSc2mIF0iWLzlfmYi18JRiX40/VoYt8x6nd7bIQWXhPzLWtHxrckLIekrHq+53XfnL1Jf/cczTLBGZ9DIjm0fVBVMPIHtCrHsBHxHLCImffgY2W4LxPmlhcPU9yBdyTQBKLxru5qW232o12XJDcsisyHGxSLWMm8wVEzkFbsBmP96XJRYg2N28aG48DXIhDXZuDwNT5Z2V/V7yVdpqyO/Ht3feoJsl0WlcN2Gkb/dzvPXERIzrqA2fYxYVQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C32DEDA78AC6494A9DD557DA3785FC4F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67ee7bf-6892-425e-2679-08d7699ebc82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 07:37:58.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ja6zg01rPBa/m6zwzHWnjWK2RzbPJ9hmKiVxG6mE0FkwOhb2vlJP6DuawIsZW5oy7HaUaXMyWR/3Gxa51pnj4tmTk8hi/8B/IVBgrIxbiMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3012
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCk9uIDExLzE0LzE5IDU6MTMgUE0sIEFsIFZpcm8gd3JvdGU6DQo+IE9uIFRodSwgTm92IDE0
LCAyMDE5IGF0IDEyOjA0OjU0UE0gKzAzMDAsIFBhdmVsIFRpa2hvbWlyb3Ygd3JvdGU6DQo+IA0K
Pj4gTW9yZSBwcmVjaXNlbHkgdGhlIGFsZ29yaXRobSBpczoNCj4+IGEpIG9wZW5hdCBtcGZkIHRv
IGEgbmV3IG1vdW50cG9pbnQgdGhyb3VnaCBwYXJlbnQgbW91bnQncyByb290IC0NCj4+IHBfcm9v
dGZkICh3aGljaCB3ZSBhbHJlYWR5IGhhdmUpIG9yIG1vdW50cG9pbnQgZmQgdW5kZXIgYSBzaWJs
aW5nIG1vdW50DQo+PiAtIHNfbXBmZCBpZiBvdXIgbW91bnRwb2ludCBpcyBhbHJlYWR5IG92ZXJt
b3VudGVkLg0KPj4gYikgY3JlYXRlIGEgbmV3IG1vdW50IG9uIG1wZmQgdmlhIC9wcm9jLzxwaWQ+
L2ZkLzxOPiBpbnRlcmZhY2UNCj4+IGMpIG9wZW5hdCBpdCdzIHJvb3RmZCB2aWEgT19NTlQgZnJv
bSBtcGZkDQo+Pg0KPj4gSWYgd2UgaGF2ZSBtcGZkIGFuZCByb290ZmQgZm9yIGVhY2ggbW91bnQg
dGhyb3VnaCAvcHJvYy88cGlkPi9mZC88Tj4NCj4+IGludGVyZmFjZSB3ZSB3aWxsIGJlIGFibGUg
dG8gYmluZG1vdW50IGFueSBwYXJ0IG9mIGVhY2ggb2YgYWxyZWFkeQ0KPj4gY3JlYXRlZCBtb3Vu
dHMgdG8gcmVzdG9yZSBvdGhlciBtb3VudHMgIGFuZCB3ZSB3aWxsIGJlIGFibGUgdG8gY29uZmln
dXJlDQo+PiBtb3VudHMsIGUuZy4gY2hhbmdlIHNoYXJpbmcgb3Igb3RoZXIgb3B0aW9ucyBldmVu
IGlmIG1vdW50cyBhcmUNCj4+IGludmlzaWJsZSBmcm9tIGZzLXJvb3QuDQo+IA0KPiBFdmVyeXRo
aW5nIGVsc2UgYXNpZGUgKGFuZCBJJ20gbm90IHRocmlsbGVkIGFib3V0IHRoZSBpZGVhIGluIGdl
bmVyYWwpLA0KPiB5b3UgYXJlIG5vdCBoYW5kbGluZyB0aGUgc2l0dWF0aW9uIHdoZW4gdGhhdCBv
dmVybW91bnQgaXMsIGluIHR1cm4sDQo+IG92ZXJtb3VudGVkLg0KDQpTb3JyeSBidXQgSSBkb24n
dCB1bmRlcnN0YW5kIHdoeSBvdmVybW91bnRlZCBvdmVybW91bnQgaXMgYSBzcGVjaWFsIA0KY2Fz
ZS4uLiBMZXQgbWUgZXhwbGFpbiBpbiBvdGhlciB3b3Jkcy4gSSB1c2UgbWF0aGVtYXRpY2FsIGlu
ZHVjdGlvbiBhcyBhIA0KcHJvb2YgdGVjaG5pcXVlLiBCYXNlIG9mIGluZHVjdGlvbiBpcyB3aGVu
IHdlIGhhdmUgbm8gbW91bnRzIChleGVwdCANCnJvb3QpLCBpdCBpcyBvYnZpb3VzIHRoYXQgd2Ug
Y2FuIGFjY2VzcyBhbGwgZGlyZWN0b3JpZXMgaW4gdGhlIHN5c3RlbS4gDQpTdGVwIG9mIGluZHVj
dGlvbiBpcyB3aGVuIHdlIGFkZCBvbmUgbW9yZSBtb3VudCBhbmQgYmVmb3JlIHRoYXQgc3RlcCAN
CndlJ3ZlIGhhZCBhbiBhY2Nlc3MgdG8gYWxsIGRpcmVjdG9yaWVzIGluIHRoZSBzeXN0ZW0gKGhh
dmUgbXBmZHMgYW5kIA0Kcm9vdGZkcyBmb3IgYWxsIG1vdW50cykuDQoNCklmIHN0ZXAgYWRkcyBh
IG1vdW50IG1udCB3ZSBuZWVkIHRvIG9ubHkgY29uc2lkZXIgaXQncyBwYXJlbnQsIHNpYmxpbmdz
IA0KYW5kIGNoaWxkcmVuIHdoaWNoIHdpbGwgYmUgdGhlcmUgYWZ0ZXIgdGhlIHN0ZXAsIGFsbCBv
dGhlciBtb3VudHMgZG9lcyANCm5vdCBjaGFuZ2UgYW55dGhpbmcuDQoNClByb3BhZ2F0aW9ucyBv
ZiBtbnQgY2FuJ3QgYmVjb21lIG1udCdzIGNoaWxkcmVuIG9yIHNpYmxpbmdzIG9yIHBhcmVudCwg
DQpsdWNraWx5IGZvciB1cy4gU28gd2UgY2FuIGFjdHVhbGx5IGNvbnNpZGVyIG9uZSBtb3VudCBm
cm9tIHByb3BhZ2F0aW9uIA0KZ3JvdXAgYXQgYSB0aW1lLg0KDQpOb3cgaWYgbXAgaXMganVzdCB2
aXNpYmxlIGZyb20gcGFyZW50J3MgcF9yb290ZmQgd2Ugb3BlbiBtcGZkLiBFbHNlIHdlIA0KaGF2
ZSBzb21lIHNpYmxpbmcgZnJvbSB3aGljaCBzX21wZmQgdGhlIG1wIGlzIHZpc2libGUgYW5kIHdl
IG9wZW4gbXBmZCANCmZyb20gaXQuIEFuZCB0aGUgbGFzdCBjYXNlIGlmIHdlJ3JlIGNyYXdsaW5n
IHVuZGVyIHNvbWUgbW91bnQgKGNoaWxkKSB3ZSANCmNhbiBvcGVuIG1wZmQgdGhyb3VnaCBjX21w
ZmQuDQoNCk5vdyBvdXIgbXBmZCBpcyBvcGVuIHNvIHdlIHVzZSBPX01OVCB0byBvcGVuIG91ciBy
b290ZmQuIChBbmQgaGVyZSB3ZSANCmNoYW5nZSBjX21wZmQgdG8gb3VyIHJvb3RmZCBhcyBvdXIg
bmV3IGNoaWxkIHN3aXRjaGVkIHBhcmVudCkNCg0KPiAgT3Igd2hlbiB0aGVyZSdzIGFuIGF1dG9t
b3VudCBzZXQgb24gdG9wIG9mIGl0LCBldGMuDQoNCkknbSBub3QgY29tbW9uIHdpdGggYXV0b21v
dW50cyBhY3R1YWxseSwgc28gSSBtaWdodCBtaXNzIHNvbWV0aGluZyBoZXJlLiANCkNhbiB5b3Ug
cGxlYXNlIHNob3cgYWN0dWFsIG1vdW50IHRyZWUgd2hlcmUgdGhpcyBwcm9ibGVtIGNhbiBoYXBw
ZW4/DQoNCj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLCBUaWtob21pcm92IFBhdmVsDQpTb2Z0d2Fy
ZSBEZXZlbG9wZXIsIFZpcnR1b3p6by4NCg==
