Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8AA165FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBTOfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 09:35:18 -0500
Received: from mail-eopbgr1410130.outbound.protection.outlook.com ([40.107.141.130]:12795
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728105AbgBTOfR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:35:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx44jm/ld+gjQ3IEgdaJtKd2/nwT0wfPCoT/njGZIWYDq9g8HBNqyCQEe1p5s/CSw1ZFmBMen5F8Mfant3WAnhuTnCj8lk2Hzb59hjr4tC4uo6Wh8dMuO7zD98DIGDo2ItWkl0oF6rZeuL5S5nKXYkqQ5pZxxmot88OkEwMLu0RPhm+HPwIh7Ls8LYDbnoldzrJIHk9jZIK/d4VcyxwYxBiOkMRH3wEvk66PcFTvGWOMcRarrFT6u1lO1XXFUWBAOlKLazb91flKC7+n90e2Wd24VJgudxoAoCbXQx2prdCUkaY0/HLDsPKTmLzERMezUEJaOGmp3l/cc5jGHfPxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5gustrJHK0PmVK8CB2wjZz7pF88vKbQ1TQ3kjIEY20=;
 b=bc4Fmq+X6zYbC6V8vMkbDGRljztN/MYpvPVKrzeTxEP3XtMgarsWM4IkxynltZxvlsLPeqLT5RvjtPk263D56aa7FH65ZqzpOk9btDaamIm6SGj8FP7tXI3FDCYg2R9IgAApHW4ph9DtEOq8ByRn22sWlm4p1cet10slItfY4X5Mt3LGS+g9OW12W8JOUJ13lsks5Pno/gT4lG8CVfwDvf30Un3hVUXeQH6KekyBL0pd+5hQ9hQTMkLH280RcGlCOf4srfHFNki2fkA29J/6ANwtCp9YnAieLH6Ue1Ka4wMc1/kY5iem3E+B+Zg1idDjjMVcAkiHMlwx4Kw82f274w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5gustrJHK0PmVK8CB2wjZz7pF88vKbQ1TQ3kjIEY20=;
 b=OVHO0MZad0Tg53+RFcgTg2AEUIdsDAP2lkPonGhMhzjbbby6A+AVogwNeVZBEvRbsvRMaGPCZOr7ALj8LD+JCbJFxHhbDyizeSgPg4Wx37OnYzOIvw3e03Gu9GwASl7EX9fj4onnuk4N1ZCSJW7qfBVaIIfmKQzqrv5mPcLszqw=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB2672.jpnprd01.prod.outlook.com (20.177.105.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 14:35:13 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 14:35:13 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Thread-Index: AQHV4UBCokgUzaN+lUSpKIEPQqBkX6gXQFUAgAIZNoCAAsk4AIAAXS4AgAEY+wCAAKfGYIAADuKAgAXhllA=
Date:   Thu, 20 Feb 2020 14:35:13 +0000
Message-ID: <TYAPR01MB2285608AFEB9D1FC7AB10E41B7130@TYAPR01MB2285.jpnprd01.prod.outlook.com>
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
 <TYAPR01MB228505DD9E7C85F9FA4AA785B7170@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <CAK8P3a3Za8dthPE7czQs+rK+xUq+ZZC4Sbj8QF5YjXvtfzop4Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3Za8dthPE7czQs+rK+xUq+ZZC4Sbj8QF5YjXvtfzop4Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5572f0db-fbac-4cce-9d49-08d7b61218b9
x-ms-traffictypediagnostic: TYAPR01MB2672:
x-microsoft-antispam-prvs: <TYAPR01MB2672AE2904BB87B5BC1A7CA4B7130@TYAPR01MB2672.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(55016002)(186003)(6916009)(81166006)(478600001)(53546011)(86362001)(6506007)(26005)(66574012)(8676002)(81156014)(5660300002)(4326008)(66476007)(316002)(7696005)(66946007)(8936002)(33656002)(7416002)(9686003)(2906002)(76116006)(52536014)(64756008)(66556008)(66446008)(71200400001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2672;H:TYAPR01MB2285.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEaAQQ4/icaRd/CDB1DsipiDZDY87KukAjCu3vDNg31R9QPqG01dcHukSPdewaX18fpv7LD8lTkgvKTMM2Jt78eOn6/+n1pI5vJ1Nra9oA8uDQdWYP5v7D283mbs6WKJkZXO0y3bVCrbtir76/BoNy9+JaTMBVOYM0XEbpoE2DJVqLxVDnfTApNplRjitPsjnsMLX8sXMVUIvfVB1kav2IaSrKXSpm/4eXlqVSBDrRrIpwxdy5hT8KH+ge1sB1Lr09EVgVFUbuEsCvd/03dMmr73G/v1/fhM3BuauxemCPi88tNQD2+wyYYGd9cgiaVZla6XvNopWYfBNO1B1/QdWmjtq723hDsTT/LRsu7BU0r5TW/H4h7RmlhxSuUY1svTTqQfvXJcfJGWFDPGWZv9WTxoIJ5BDlUKJ3Qgv9EF5Hapg34Xv1AXXgyHtiYNUrNT
x-ms-exchange-antispam-messagedata: 6MIK1qWhOmF+Ln6kOTcQJFvllu69B3/KU85GXLdPG89dEycTH2e128HlMK7dfUIW9WFS111NWDLNJJ+gMqNC/GRiBmlYQbHZejoe8SaCYwUM9QgV7PDnV73n/95ASewnbn3Rewk+v/oJR2PKAUuUcA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572f0db-fbac-4cce-9d49-08d7b61218b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 14:35:13.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vakimPMFgPGhkIr39hpIZPf3EY0HkW9DjLIJZLFsNen1xT+wFekEdP8+99aKAtv4w49tv32JeKUhPp2FMneRt3bCKgvRCHEOM+hgAOzJkOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2672
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGVsbG8sDQoNCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gU2VudDog
MTYgRmVicnVhcnkgMjAyMCAyMDozOA0KPiANCj4gT24gU3VuLCBGZWIgMTYsIDIwMjAgYXQgODo1
NCBQTSBDaHJpcyBQYXRlcnNvbg0KPiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEhlbGxvIEFybmQsIEdlZXJ0LA0KPiA+DQo+ID4gPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+ID4gU2VudDogMTYgRmVicnVh
cnkgMjAyMCAwOTo0NQ0KPiA+ID4gVG86IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+
ID4gPg0KPiA+ID4gSGkgQXJuZCwNCj4gPiA+DQo+ID4gPiBPbiBTYXQsIEZlYiAxNSwgMjAyMCBh
dCA1OjU5IFBNIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdyb3RlOg0KPiA+ID4gPiBP
biBTYXQsIEZlYiAxNSwgMjAyMCBhdCAxMjoyNSBQTSBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPiA+
ID4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIEZlYiAx
MywgMjAyMCBhdCA1OjU0IFBNIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4gPiB3
cm90ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwgRmViIDEyLCAyMDIwIGF0IDk6NTAgQU0gUnVzc2Vs
bCBLaW5nIC0gQVJNIExpbnV4IGFkbWluDQo+ID4gPiA+ID4gPiA8bGludXhAYXJtbGludXgub3Jn
LnVrPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBDSVAtc3VwcG9ydGVkIFJaL0cx
IFNvQ3MgY2FuIGhhdmUgdXAgdG8gNCBHaUIsIHR5cGljYWxseSBzcGxpdA0KPiAoZXZlbg0KPiA+
ID4gPiA+IGZvciAxIEdpQiBvciAyIEdpQiBjb25maWd1cmF0aW9ucykgaW4gdHdvIHBhcnRzLCBv
bmUgYmVsb3cgYW5kIG9uZQ0KPiBhYm92ZQ0KPiA+ID4gPiA+IHRoZSAzMi1iaXQgcGh5c2ljYWwg
bGltaXQuDQo+ID4NCj4gPiBZZXAuIE9uZSBleGFtcGxlIGlzIHI4YTc3NDMtaXdnMjBtLmR0c2ku
DQo+IA0KPiBUaGlzIG9uZSBoYXMgMng1MTJNQiwgd2l0aCBoYWxmIGFib3ZlIHRoZSA0R2lCIGxp
bWl0LiBUaGlzIG1lYW5zIGl0IG5lZWRzDQo+IExQQUUgdG8gYWRkcmVzcyBoaWdoIHBoeXNpY2Fs
IGFkZHJlc3NlcyAod2hpY2ggaXMgZmluZSksIGJ1dCBpdCBkb2VzIG5vdCBuZWVkDQo+IGhpZ2ht
ZW0gaWYgb25lIHVzZXMgYW4gYXBwcm9wcmlhdGUgQ09ORklHX1ZNU1BMSVRfKiBvcHRpb24uDQo+
IA0KPiA+ID4gPiBHb29kIHRvIGtub3cuIEkgdGhpbmsgdGhlcmUgYXJlIHNldmVyYWwgb3RoZXIg
Y2hpcHMgdGhhdCBoYXZlIGR1YWwtDQo+IGNoYW5uZWwNCj4gPiA+ID4gRERSMyBhbmQgdGh1cyAv
Y2FuLyBzdXBwb3J0IHRoaXMgY29uZmlndXJhdGlvbiwgYnV0IHRoaXMgcmFyZWx5IGhhcHBlbnMu
DQo+ID4gPiA+IEFyZSB5b3UgYXdhcmUgb2YgY29tbWVyY2lhbCBwcm9kdWN0cyB0aGF0IHVzZSBh
IDRHQiBjb25maWd1cmF0aW9uLA0KPiBhc2lkZQ0KPiA+ID4gZnJvbQ0KPiA+ID4gPiB0aGUgcmVm
ZXJlbmNlIGJvYXJkPw0KPiA+DQo+ID4gaVdhdmUgU3lzdGVtcyBtYWtlIGEgcmFuZ2Ugb2YgU09N
IG1vZHVsZXMgdXNpbmcgdGhlIFJaL0cxIFNvQ3MuDQo+ID4gSSBiZWxpZXZlIHRoZXJlIGFyZSBv
cHRpb25zIGZvciBzb21lIG9mIHRoZXNlIHRvIHVzZSA0IEdCLCBhbHRob3VnaCAxIG9yIDINCj4g
R0IgaXMNCj4gPiB1c2VkIGluIHRoZSBib2FyZHMgd2UndmUgdXBzdHJlYW1lZCBzdXBwb3J0IGZv
ci4NCj4gPg0KPiA+IFRoZXJlIGFyZSBhbHNvIG90aGVyIFNPTSB2ZW5kb3JzIChlLmcuIEVtdHJp
b24pIGFuZCBlbmQgdXNlcnMgb2YgUlovRzEsDQo+ID4gYnV0IEknbSBub3Qgc3VyZSBvZiB0aGUg
ZGV0YWlscy4NCj4gDQo+IEJvdGggaVdhdmUgYW5kIEVtdHJpb24gb25seSBzZWVtIHRvIGxpc3Qg
Ym9hcmRzIHdpdGggMkdCIG9yIGxlc3Mgb24gdGhlaXINCj4gd2Vic2l0ZXMgdG9kYXkgKHdpdGgg
dXAgdG8gMTUgeWVhciBhdmFpbGFiaWxpdHkpLiBNeSBndWVzcyBpcyB0aGF0IHRoZXkgaGFkDQo+
IHRoZSBzYW1lIHByb2JsZW0gYXMgZXZlcnlvbmUgZWxzZSBpbiBmaW5kaW5nIHRoZSByaWdodCBt
ZW1vcnkgY2hpcHMgaW4NCj4gdGhlIHJlcXVpcmVkIHF1YW50aXRpZXMgYW5kL29yIGxvbmctdGVy
bSBhdmFpbGFiaWxpdHkuIGlXYXZlIGxpc3RzICJCeSBkZWZhdWx0DQo+IDFHQiBERFIzIGFuZCA0
R0IgZU1NQyBvbmx5IHN1cHBvcnRlZC4gQ29udGFjdCBpV2F2ZSBmb3IgbWVtb3J5DQo+IGV4cGFu
c2lvbiBzdXBwb3J0LiIgb24gc29tZSBib2FyZHMsIGJ1dCB0aGF0IGRvZXNuJ3QgbWVhbiB0aGV5
IGV2ZXINCj4gc2hpcHBlZCBhIDRHQiBjb25maWd1cmF0aW9uLg0KDQpJIHByb2JhYmx5IHNob3Vs
ZCBoYXZlIGJlZW4gY2xlYXJlciBiZWZvcmUgLSBJIGFjdHVhbGx5IGhhdmUgYSBjb3VwbGUgb2Yg
aVdhdmUgUlovRzFNIFNPTSBtb2R1bGVzIHdpdGggNEdCIEREUiBvbiB0aGVtLg0KSG93ZXZlciBJ
J3ZlIG5ldmVyIGJvb3RlZCB0aGVtIG5vciBkbyBJIGtub3cgd2hhdCB0aGUgbWVtb3J5IG1hcHBp
bmcgaXMuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gICAgICAgIEFybmQNCg==
