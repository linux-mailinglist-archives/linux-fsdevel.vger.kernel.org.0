Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732E716060F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 20:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgBPTyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 14:54:40 -0500
Received: from mail-eopbgr1410127.outbound.protection.outlook.com ([40.107.141.127]:28800
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgBPTyj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 14:54:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ferxquqvt0UCp/B/uDEgBRQ+2hjLn/VhY838Yt4NGJi7gcE0uFA7M38ZUv1xpJFsCKr+JVDHiX/z8sEWv9gT1mb/YVbLCV3/bOZW+eJtYZ1ZjrI898zVILACB4Z2a/tVOUiy1e/CYXuXdQTJnv2p0swItPREfYecQ/azU10CISPzJ+Dbx7K3efJhD0xtlw6N6Rwt9BFOJo0z0h4wOEHUD0nye4ren5IuUcPGY1JljwI2vaLyTyHJLm31PxzvtfVkG9sSW1NQI84BRm+NOe8ZNK29ISUD8Tk8mkfs1ZIP287r4Kz2OB0/xaEN/CROe8+psKfnMbThcdHXe/tRG0j0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JWHHdjximhgCT4QAkEXrYqy68MStrBcmJ2e94W3ZRs=;
 b=Ga75TUHtJFfAIBQUmInjE5ZLLn4Y5urzfPDzClSyUFyQ6jsIobYjszAim5PpoFqmI5Jc6c6PW5OMKbGHGMMCZZU+QkI+UKjWUNfhpgNy+8wSE6+X7W5qll2O5xYfc1R7DcZdehCNt+bltEvugbtReXlMI1r7z4U+0IytSxcQ0U6vg6NXgqUkaEq4+oy4bWNGo2B/xAiLz4/XqKJPgfZUin7LfaWCjEgrDj9Pr5nNZIwt/RjHgqG66eDvbAV/TWfGoUApCe8XwixNE8KBXIbgW/dEUfePzOFD7YLRm+k+1cP3h7Q96yHQLo7bXFRd1yjZfYGqOf2R0zWteGn0LwDH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JWHHdjximhgCT4QAkEXrYqy68MStrBcmJ2e94W3ZRs=;
 b=ffzrYpUYEplTwgwRRnMQoA84WozMSqpIJJ8onkJr9PM7H2EId/MRdIpVYcJpZGMy5uop6kk4ID39OraaUGTnLO68qGuG3W59i9bgC9AlhiRxJcbZU0IfQFjOvnO3fCIIgSyGPORrOu/S/mDEoQQLusRtq5DV8IclVzreHYCJYbM=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB3712.jpnprd01.prod.outlook.com (20.178.137.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Sun, 16 Feb 2020 19:54:34 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70%7]) with mapi id 15.20.2729.028; Sun, 16 Feb 2020
 19:54:34 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Thread-Topic: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Thread-Index: AQHV4UBCokgUzaN+lUSpKIEPQqBkX6gXQFUAgAIZNoCAAsk4AIAAXS4AgAEY+wCAAKfGYA==
Date:   Sun, 16 Feb 2020 19:54:34 +0000
Message-ID: <TYAPR01MB228505DD9E7C85F9FA4AA785B7170@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com>
 <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
 <CAMuHMdVpTngVXUnLzpS3hZWuVg97GVTf2Y3X8md--41AtaD1Ug@mail.gmail.com>
In-Reply-To: <CAMuHMdVpTngVXUnLzpS3hZWuVg97GVTf2Y3X8md--41AtaD1Ug@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [176.27.142.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a184311-dcf4-4352-d7db-08d7b31a0c02
x-ms-traffictypediagnostic: TYAPR01MB3712:
x-microsoft-antispam-prvs: <TYAPR01MB371261E645276A94CEBBDBE6B7170@TYAPR01MB3712.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03152A99FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(346002)(39850400004)(199004)(189003)(4326008)(33656002)(81156014)(8936002)(81166006)(86362001)(8676002)(7416002)(71200400001)(478600001)(55016002)(9686003)(5660300002)(7696005)(76116006)(2906002)(53546011)(66946007)(6506007)(316002)(54906003)(110136005)(186003)(26005)(66476007)(66556008)(66446008)(52536014)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3712;H:TYAPR01MB2285.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3zKmvziL4Tsvl8IkfZo1A8khxZlxiW38F+8fRUxjK1lLm8BltTitRB3BET0b+CiTpzKKpDiLObNdJqZxNYmiqAs8g56JcR3Lrjj978pW1G4kIAGLmhF8n09w3aJkoqgnIgCaNaZ5S0yZECWb16wO4CsxJbFyDnulsOdxBOe1yk+9egDgA2TjpiUr/n5gIIdUBR0G0nNhTUXukb/b8Ot+PGO3cleMnrHjRHpTFxv4D2Odfs2ishbXDW3B5gikGT1OfErRHzpjJ9CWBqnsVQVGTLjKfzkzFZh1rk4rrPea0QYYVV3rf5mke/bRpq3LkLL4IMxPt3HCTOrDlY62WXomWlRfk00bFMknPOaRxiBEOEiT2Md9OU9rkCv7paYfsn4x61OMyU8AUYs5bEfDQN+3JpLgQwmN0QPSiyC2aJ8NbHe0V4PIuz3498tr1d/dHsHi
x-ms-exchange-antispam-messagedata: Zr4Dz1d7bB/W52KB4vH2WwEm7Oi3eCITMTQXP6o1Dv79YGCsj8JboLRuAN6b0giuw73HKxlMIW1ybRx8rbJRzfIdbcjIhiq4osprr2X/8kqZYRqDSXkuoZMkKFykCNZO5KFvyXw3hSLLVJWRWfGvcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a184311-dcf4-4352-d7db-08d7b31a0c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2020 19:54:34.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5IeZBppSCXHAIcaU4f0oJIU7OcbJefultakuQC9+zbn1JifeG5c/EBWiKMxgRQJ7dkcNtl2PJWezG/2RZuP+imBTZ1iIA+vrh5Hf3IKJLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3712
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGVsbG8gQXJuZCwgR2VlcnQsDQoNCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBs
aW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTYgRmVicnVhcnkgMjAyMCAwOTo0NQ0KPiBUbzogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IEhpIEFybmQsDQo+IA0KPiBPbiBTYXQs
IEZlYiAxNSwgMjAyMCBhdCA1OjU5IFBNIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdy
b3RlOg0KPiA+IE9uIFNhdCwgRmViIDE1LCAyMDIwIGF0IDEyOjI1IFBNIEdlZXJ0IFV5dHRlcmhv
ZXZlbg0KPiA+IDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEZl
YiAxMywgMjAyMCBhdCA1OjU0IFBNIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IHdy
b3RlOg0KPiA+ID4gPiBPbiBXZWQsIEZlYiAxMiwgMjAyMCBhdCA5OjUwIEFNIFJ1c3NlbGwgS2lu
ZyAtIEFSTSBMaW51eCBhZG1pbg0KPiA+ID4gPiA8bGludXhAYXJtbGludXgub3JnLnVrPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiBUaGUgQ0lQLXN1cHBvcnRlZCBSWi9HMSBTb0NzIGNhbiBoYXZlIHVw
IHRvIDQgR2lCLCB0eXBpY2FsbHkgc3BsaXQgKGV2ZW4NCj4gPiA+IGZvciAxIEdpQiBvciAyIEdp
QiBjb25maWd1cmF0aW9ucykgaW4gdHdvIHBhcnRzLCBvbmUgYmVsb3cgYW5kIG9uZSBhYm92ZQ0K
PiA+ID4gdGhlIDMyLWJpdCBwaHlzaWNhbCBsaW1pdC4NCg0KWWVwLiBPbmUgZXhhbXBsZSBpcyBy
OGE3NzQzLWl3ZzIwbS5kdHNpLg0KDQo+ID4NCj4gPiBHb29kIHRvIGtub3cuIEkgdGhpbmsgdGhl
cmUgYXJlIHNldmVyYWwgb3RoZXIgY2hpcHMgdGhhdCBoYXZlIGR1YWwtY2hhbm5lbA0KPiA+IERE
UjMgYW5kIHRodXMgL2Nhbi8gc3VwcG9ydCB0aGlzIGNvbmZpZ3VyYXRpb24sIGJ1dCB0aGlzIHJh
cmVseSBoYXBwZW5zLg0KPiA+IEFyZSB5b3UgYXdhcmUgb2YgY29tbWVyY2lhbCBwcm9kdWN0cyB0
aGF0IHVzZSBhIDRHQiBjb25maWd1cmF0aW9uLCBhc2lkZQ0KPiBmcm9tDQo+ID4gdGhlIHJlZmVy
ZW5jZSBib2FyZD8NCg0KaVdhdmUgU3lzdGVtcyBtYWtlIGEgcmFuZ2Ugb2YgU09NIG1vZHVsZXMg
dXNpbmcgdGhlIFJaL0cxIFNvQ3MuDQpJIGJlbGlldmUgdGhlcmUgYXJlIG9wdGlvbnMgZm9yIHNv
bWUgb2YgdGhlc2UgdG8gdXNlIDQgR0IsIGFsdGhvdWdoIDEgb3IgMiBHQiBpcyB1c2VkIGluIHRo
ZSBib2FyZHMgd2UndmUgdXBzdHJlYW1lZCBzdXBwb3J0IGZvci4NCg0KVGhlcmUgYXJlIGFsc28g
b3RoZXIgU09NIHZlbmRvcnMgKGUuZy4gRW10cmlvbikgYW5kIGVuZCB1c2VycyBvZiBSWi9HMSwg
YnV0IEknbSBub3Qgc3VyZSBvZiB0aGUgZGV0YWlscy4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0K
DQo+IA0KPiBVbmZvcnR1bmF0ZWx5IEkgZG9uJ3Qga25vdy4NCj4gQ2hyaXMgUGF0ZXJzb24gbWln
aHQga25vdy4NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdz
IGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+
IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBj
YWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlz
dHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
