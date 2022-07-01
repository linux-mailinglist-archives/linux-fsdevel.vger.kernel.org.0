Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB51563599
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiGAOa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 10:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiGAOaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:30:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375FC3FBC7;
        Fri,  1 Jul 2022 07:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYF7hv4v9reeSLkttckWUcGzJY0GrrmctWNKLKMszd09rzEQgr3Kxu4cUYgjdp0+Dy2vQiLdOSBpqVMtcAiWj2ku64G6ms5CszFJ8H/2tWwkgDULy7bdx6Q6WoIYMj3BKmUKsfhAajHNr7SzAfDRGRPpThJssqlw5+q/FJNw6rfIdfYKHJfdpTgyn5E3qKJ+eNCpGC0sDwYdbkT+wA6HdSEsZ0WoKEtE9LCTBUg/Tur0BAfluYt74Gd52o7K8GKzbpigVBdAUhR/8TKPI3hE5pJL7EWq5ez/mejMjBl9fby4JDU0pRge09TiNlqYB2etYL+znTCaAHO83EyOE9+4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzzsT1KK5mkF7rda1swtKutOHxrPjEABN+ci2yWemJU=;
 b=UgZkdUjyp/b+W7lfAgLjmiL+YYv0JKlvGnbBekCHcZHJQgbJjWN0Qp2j8f/TkfV6WlHMz27yOXl0R4CzVhi/lLen+k69aeD6RJg4l/lUO1zpncCqvv2ZO5pheZNhdKAaj6mXGj6PeXkQrgExqon8ttF/hQxmTNyqRnZvEmbCLBphM3DHQaNCcED2CkoNUhOoKUAdMin7osJ8++OoqRtv3iNVmWm8jw+UBuFzyK1Nu7/2PdEySYVfvKDWrPNcXlI0S+TQdXSjT/gdWQ9KmOe0qu/aicVW9Lef/yqgbXA3Wf8aZ/X3JQBjXKIMKOxCOI7Snjsy8PCPJ5lEgNp4Pvj2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzzsT1KK5mkF7rda1swtKutOHxrPjEABN+ci2yWemJU=;
 b=OawT4STdoMWW4MpJ3dwyluFlJdfCI08/NU3FPnwrvvZhJEaMGJwovHUvJOwcTNNSaRO18XUgFEkymiE/IpNtYT/Fv94RL9CbsiSpPG2Z7CNHgxgRUXR3pZQiZOMPwAEYYGwYBu5xJm9IsSd3pVsYpALXMxW07KwUm4+ffCB95fA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4559.namprd13.prod.outlook.com (2603:10b6:5:20b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8; Fri, 1 Jul
 2022 14:25:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 14:25:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>,
        "raven@themaw.net" <raven@themaw.net>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [REPOST PATCH] nfs: fix port value parsing
Thread-Topic: [REPOST PATCH] nfs: fix port value parsing
Thread-Index: AQHYioWJZklspGquU0m3p/tguyzN061k40UAgACvlQCAAPNRAIAAhiQAgAAGpgCAAfqUgIAAijiA
Date:   Fri, 1 Jul 2022 14:25:25 +0000
Message-ID: <1231bc044db16b07972a3531dfc9ce7510125ec9.camel@hammerspace.com>
References: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
         <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
         <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
         <891563475afc32c49fab757b8b56ecdc45b30641.camel@hammerspace.com>
         <fd23da3f-e242-da15-ab1c-3e53490a8577@themaw.net>
         <c81b95d2b68480ead9f3bb88d6cf5a82a43c73b8.camel@hammerspace.com>
         <22f9fbb7-a557-f372-7ede-92f0af338bd1@themaw.net>
In-Reply-To: <22f9fbb7-a557-f372-7ede-92f0af338bd1@themaw.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c76f0131-5a32-4691-1390-08da5b6d8a2b
x-ms-traffictypediagnostic: DM6PR13MB4559:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZmMFzlDxRufKnHGJAX3cyypXFT/K1Wlvx9chJs2DGRaJI/nelU7ve96GLtm9259KYM8AtfGMSvteu8RNVsU8REKt9TpjheGcbYJ3wss7ptQQGtloAfqsc+w8HMWSWlW4abney5Pqrb6ug+ykwf/AqfDklgt585x8WI+RadwxS9xkzkyD3hL6IuxAzn+ozXSTlF/oOnzA2C+LEn5jBDXK3iHQBfokBIYbe4dDp+j2viWKBUW85lSkWDaQWMlka2FGt+nlE7bQ9auYRiJmIYkyfE9/W4/iJS2d0X684z3EByoqMqxNZFQI/YKryIBIReCpD9EmEO2vUslfdl6HzPX/s9yZ1S0h7+elZts+F6C2wqGgyfi65OhnwWWcZQA9gIYHefgVgpUjsh/9HkLwEWo6WPi/1iYoqc+VS9ng1tWwC01rBtkYabwssqHrbPKHZ7ZYu8K1QdbkCsBSM8jLYVKiUaQZ4YMxOO+6Ut1bgOLy+k4ACsY7ToiCydVd4vPTtm1+dHXIoyZXyoGog0SEMNZN3lP0m1gw/jE5H+L2XlBOhp+CNml7UmT2j1+scamhVKJba9evDVlJo5KZsZE7U0oudly1k71R4A+YrXvrNqzFGDHVPy1Z36HCFTXLmxeTSEw2FBomBdu6FDmNHVHwuSrbsbmoCj5bbxvaWEeUWEBfi4lVcvA7rOXglpQnm3hILKXpIv5c7I5S/1uoPaygMTPcs7/elB/dpW/J22il2lJwqoa8hdCKVQq7nCaNV4guV1BxPw6RJpE25XraLy5gqL1scolJbJIU76f0gEjFkMYJG1/AH1YDOqIsuknxW2C7nc13bwpOcW/D/K2l/4+20pc+CdKIbOvsU5fs2y9oFWfVzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(376002)(346002)(136003)(366004)(83380400001)(36756003)(38070700005)(122000001)(38100700002)(186003)(4326008)(8676002)(64756008)(66476007)(66446008)(66556008)(66946007)(76116006)(316002)(2906002)(8936002)(6506007)(5660300002)(53546011)(26005)(41300700001)(6512007)(2616005)(54906003)(110136005)(478600001)(71200400001)(6486002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVQ5dUhiWjVlaUpkb0l4cGM5T3p1bkEwTkVIS2J4US80ZEtmdFg1cExHRDln?=
 =?utf-8?B?L2p5alRuUHFNK25tc0dsaVFHS0xDKy9lR0l3ZlUyOURidHlZdU9yRERlZENu?=
 =?utf-8?B?OWFVRkJ1VWdYczFVUHhXeGlRbnlFVzA0M3g2U3FCTFB1SDBMbkp6T3pLMHJR?=
 =?utf-8?B?ZThoT1pTNisxNmR0TVpiUTMyamE2Yi9WaGlHc2pQMUsyZzdOK1pnN2U4cloz?=
 =?utf-8?B?NVJ2RUVSZm12TjBad0JpYkNkcGdDS3ZSUU54aVIySEpjdVp1a1JpQnloOHNj?=
 =?utf-8?B?bG1SN0dsSnRZR3ZOTWF3YUZNSGF3WEpVZWtTYU8zTVdpbVEvclN4R0hvbjBX?=
 =?utf-8?B?eW9rUmM5enJwTzlYdVBCVDkzejE4R3AzWjg3SHllR0V0cjhZc05OalF6NmUv?=
 =?utf-8?B?akRIcDhPaW05S1JCR1JpM2JBVGpVcXc0Q2RSK2gxN2pHcUxwK2RIKzBVb1kx?=
 =?utf-8?B?d3Y0Z1dXQkNHMU1uV0tMS0ZDamdNZCtNZ0Z0MUFpRjFCekZUQmw3VFl1K1R6?=
 =?utf-8?B?VHBWdWZLM3RxWFpZV3o0anQ4Nmp5cytZVzVRaklNOGQ2aG1UVGNCL28zRVk5?=
 =?utf-8?B?ODM1eFZaazJvWXVBZ1NUeiszMG9tV2lGYzdhK2xRSmJCcVBsVGkvUDd4N0cv?=
 =?utf-8?B?ZlAyWEhTM25yUVVtRklOZmptM3RFRVVFb1dRRVBUU1VRK0VpWmdxYzJFakdZ?=
 =?utf-8?B?ZHZzYVR2Q0pteWFhTVlleGpOUWZnOWZNU0JDOFh3VDhpZmNxSzI5eXp3WTV0?=
 =?utf-8?B?UGtCZGF3YzVFTjhrblI0cVRrZXBhamozcm5xeXpYb3FaTXY3b1V5WXhhY3FM?=
 =?utf-8?B?Y1N2cU9uWnZIY1liTW83SGVxVVFCMU5sMTRMcVgxaDUzN2J6RGpzaEZkK2I4?=
 =?utf-8?B?S2JUQWtNUjUvVGFBWUZucDFBTC9EY3FEQmlhbHlIWDcvblZaS0JORW9mV3NU?=
 =?utf-8?B?cndmMFlzK01mRVVRSVRPTkdoeHZIYkhxU05JV1hIYUJBRXB6WTRLQ2ZwUjFD?=
 =?utf-8?B?VmJXWGp3cDZDcVgydFlmcE5UYWNrT2NIbEt0TnF1RDFyYXpmemFFaGx0R2pZ?=
 =?utf-8?B?eXdzK2QwY2pvSTNYZjE0eFhsWHM0bkNiYi9CODQ4RGozS0d4UjZvenAxK1k4?=
 =?utf-8?B?d29ZUkk5L2o0RlEvbExaUktva1ROS1FKWkNFaFZDdVhYVkp2SW5JQkM3NFpp?=
 =?utf-8?B?T0ErUitoRytUT3R6YmNnS1p0MU05T0Q2SEo3MjU3NUZLZzhpRlFySzVYZ0cy?=
 =?utf-8?B?dU1hQTFWS1ZXSS9LNUpWTENpbG90MnVUSmZKMk1kbGpuVEsrODFFcytjczZR?=
 =?utf-8?B?NHhGL1RLRFdaQUo1YUU4RVIrSEhRbXM4dFNsalpQZ2RsRlo3bmJjeGFITnN5?=
 =?utf-8?B?WWJFd0x0TjZPZUQ4aHVKUThhd2tLbWh2VHIyZDBtampWQ3JWSEg4MmtmWlp2?=
 =?utf-8?B?N2twMnRsRVBaQkZxVGtDMEhBRUwzc21BdFFzNVA0QVJVa0xwUlBYTGFsVC9D?=
 =?utf-8?B?OWp3WWhPb3NxQUh1L3lXci9zcTh5ZjNvME1nMUQxS1BCOUd4NUxWQ3lBSDQw?=
 =?utf-8?B?cFh5bmUxUzJmTTB0UUF0aC93cXJSWkFjWFFVTHF4Zi9KUnFweHBMRjk4VkVU?=
 =?utf-8?B?ekFlNmc4RENzcTQxdW5MN0NvcklOZ1dTb1Naa0pIeGFLaTNUNGI1SU50cEhE?=
 =?utf-8?B?bG54eWowdGw3ZGUvdStmaXk2bWxVd0ZzZGNBU3pmaDIrZUg5VGZxZkgveUV6?=
 =?utf-8?B?NktFNFJlMkxGalBuRGhpODlXY09nSnFFUkdaNEZlZnY3SVdsM0pJM0FrUDhC?=
 =?utf-8?B?TEtrdVZtQkc3ZUx3OWVjelorOTFCWVpQNW5ucnZPMXZUSjk1ajl4VUdVOWRV?=
 =?utf-8?B?SFRVL1N4cTUvTXZxSS94alRrNnR0cTYzOGhURVpwVkEwaHRyRWhhZ1FaQkJ0?=
 =?utf-8?B?ZmxhS0xTVVBmT0FtT3JOQjE4NmtNelhncnlBcFZjZm5TYjVDOU1HS2tMZzNY?=
 =?utf-8?B?QTQraGdMRVlHamdZcVRUdVFsdjJqYUpWai9GY0ZwNmJLQW9NeDhrYlZTRmJO?=
 =?utf-8?B?UGd3dFZRdnpIKzZXbm9ZR2xGZ1BOVW5qTmRIYVV6bHVBZjJSUUt5UnYwTTNT?=
 =?utf-8?B?dGhobEl3bnZKa21BMEVPcjhRczljNW1Md2hldjNlMXVKSHlhaVZxeDNwSTZr?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <264C60ABCCB1854F8320E1EA99FF6A8E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76f0131-5a32-4691-1390-08da5b6d8a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 14:25:25.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: he1LwxW0LpyrRSVu66ZaJyxsbOT0RpI8YDzPzDRBJBnDYZVBrLEK/BxF7/bi6+x7LeFs6V9JbG15jYOyl5d2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgSWFuLA0KDQpPbiBGcmksIDIwMjItMDctMDEgYXQgMTQ6MTAgKzA4MDAsIElhbiBLZW50IHdy
b3RlOg0KPiANCj4gT24gMzAvNi8yMiAwNzo1NywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+
IE9uIFRodSwgMjAyMi0wNi0zMCBhdCAwNzozMyArMDgwMCwgSWFuIEtlbnQgd3JvdGU6DQo+ID4g
PiBPbiAyOS82LzIyIDIzOjMzLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IE9uIFdl
ZCwgMjAyMi0wNi0yOSBhdCAwOTowMiArMDgwMCwgSWFuIEtlbnQgd3JvdGU6DQo+ID4gPiA+ID4g
T24gMjgvNi8yMiAyMjozNCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24g
VHVlLCAyMDIyLTA2LTI4IGF0IDA4OjI1ICswODAwLCBJYW4gS2VudCB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gVGhlIHZhbGlkIHZhbHVlcyBvZiBuZnMgb3B0aW9ucyBwb3J0IGFuZCBtb3VudHBvcnQg
YXJlIDANCj4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gVVNIUlRfTUFYLg0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhlIGZzIHBhcnNlciB3aWxsIHJldHVybiBhIGZhaWwg
Zm9yIHBvcnQgdmFsdWVzIHRoYXQgYXJlDQo+ID4gPiA+ID4gPiA+IG5lZ2F0aXZlDQo+ID4gPiA+
ID4gPiA+IGFuZCB0aGUgc2xvcHB5IG9wdGlvbiBoYW5kbGluZyB0aGVuIHJldHVybnMgc3VjY2Vz
cy4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEJ1dCB0aGUgc2xvcHB5IG9wdGlvbiBo
YW5kbGluZyBpcyBtZWFudCB0byByZXR1cm4gc3VjY2Vzcw0KPiA+ID4gPiA+ID4gPiBmb3INCj4g
PiA+ID4gPiA+ID4gaW52YWxpZA0KPiA+ID4gPiA+ID4gPiBvcHRpb25zIG5vdCB2YWxpZCBvcHRp
b25zIHdpdGggaW52YWxpZCB2YWx1ZXMuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBQ
YXJzaW5nIHRoZXNlIHZhbHVlcyBhcyBzMzIgcmF0aGVyIHRoYW4gdTMyIHByZXZlbnRzIHRoZQ0K
PiA+ID4gPiA+ID4gPiBwYXJzZXINCj4gPiA+ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+ID4gPiBy
ZXR1cm5pbmcgYSBwYXJzZSBmYWlsIGFsbG93aW5nIHRoZSBsYXRlciBVU0hSVF9NQVgNCj4gPiA+
ID4gPiA+ID4gb3B0aW9uDQo+ID4gPiA+ID4gPiA+IGNoZWNrDQo+ID4gPiA+ID4gPiA+IHRvDQo+
ID4gPiA+ID4gPiA+IGNvcnJlY3RseSByZXR1cm4gYSBmYWlsIGluIHRoaXMgY2FzZS4gVGhlIHJl
c3VsdCBjaGVjaw0KPiA+ID4gPiA+ID4gPiBjb3VsZA0KPiA+ID4gPiA+ID4gPiBiZQ0KPiA+ID4g
PiA+ID4gPiBjaGFuZ2VkDQo+ID4gPiA+ID4gPiA+IHRvIHVzZSB0aGUgaW50XzMyIHVuaW9uIHZh
cmlhbnQgYXMgd2VsbCBidXQgbGVhdmluZyBpdCBhcw0KPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+
ID4gPiA+IHVpbnRfMzINCj4gPiA+ID4gPiA+ID4gY2hlY2sgYXZvaWRzIHVzaW5nIHR3byBsb2dp
Y2FsIGNvbXBhcmVzIGluc3RlYWQgb2Ygb25lLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogSWFuIEtlbnQgPHJhdmVuQHRoZW1hdy5uZXQ+DQo+ID4gPiA+ID4g
PiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoGZzL25mcy9mc19jb250ZXh0LmMgfMKgwqDC
oCA0ICsrLS0NCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2ZzL25mcy9mc19jb250ZXh0LmMgYi9mcy9uZnMvZnNfY29udGV4dC5jDQo+ID4g
PiA+ID4gPiA+IGluZGV4IDlhMTY4OTdlOGRjNi4uZjRkYTFkMmJlNjE2IDEwMDY0NA0KPiA+ID4g
PiA+ID4gPiAtLS0gYS9mcy9uZnMvZnNfY29udGV4dC5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2Zz
L25mcy9mc19jb250ZXh0LmMNCj4gPiA+ID4gPiA+ID4gQEAgLTE1NiwxNCArMTU2LDE0IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QNCj4gPiA+ID4gPiA+ID4gZnNfcGFyYW1ldGVyX3NwZWMNCj4gPiA+
ID4gPiA+ID4gbmZzX2ZzX3BhcmFtZXRlcnNbXSA9IHsNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoA0KPiA+ID4gPiA+ID4gPiAoIm1pbm9ydmVyc2lv
biIswqDCoE9wdF9taW5vcnZlcnNpb24pLA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZnNwYXJhbV9zdHJpbmcoIm1vdW50YWRkciIswqDCoMKgwqDCoE9wdF9tb3VudGFkZHIp
DQo+ID4gPiA+ID4gPiA+ICwNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZz
cGFyYW1fc3RyaW5nKCJtb3VudGhvc3QiLMKgwqDCoMKgwqBPcHRfbW91bnRob3N0KQ0KPiA+ID4g
PiA+ID4gPiAsDQo+ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAo
Im1vdW50cG9ydCIswqDCoMKgwqDCoE9wdF9tb3VudHBvcnQpLA0KPiA+ID4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqBmc3BhcmFtX3MzMsKgwqAgKCJtb3VudHBvcnQiLMKgwqDCoMKgwqBPcHRfbW91
bnRwb3J0KSwNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fc3Ry
aW5nKCJtb3VudHByb3RvIizCoMKgwqDCoE9wdF9tb3VudHByb3RvDQo+ID4gPiA+ID4gPiA+ICks
DQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3UzMsKgwqANCj4g
PiA+ID4gPiA+ID4gKCJtb3VudHZlcnMiLMKgwqDCoMKgwqBPcHRfbW91bnR2ZXJzKSwNCj4gPiA+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAoIm5hbWxlbiIs
wqDCoMKgwqDCoMKgwqDCoE9wdF9uYW1lbGVuKSwNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAoIm5jb25uZWN0IizCoMKgwqDCoMKgwqBPcHRfbmNv
bm5lY3QpLA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV91MzLC
oMKgDQo+ID4gPiA+ID4gPiA+ICgibWF4X2Nvbm5lY3QiLMKgwqDCoE9wdF9tYXhfY29ubmVjdCks
DQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3N0cmluZygibmZz
dmVycyIswqDCoMKgwqDCoMKgwqBPcHRfdmVycyksDQo+ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKg
wqDCoGZzcGFyYW1fdTMywqDCoCAoInBvcnQiLMKgwqDCoMKgwqDCoMKgwqDCoMKgT3B0X3BvcnQp
LA0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3MzMsKgwqAgKCJwb3J0IizC
oMKgwqDCoMKgwqDCoMKgwqDCoE9wdF9wb3J0KSwNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGZzcGFyYW1fZmxhZ19ubygicG9zaXgiLMKgwqDCoMKgwqDCoMKgwqBPcHRfcG9z
aXgpLA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9zdHJpbmco
InByb3RvIizCoMKgwqDCoMKgwqDCoMKgwqBPcHRfcHJvdG8pLA0KPiA+ID4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9mbGFnX25vKCJyZGlycGx1cyIswqDCoMKgwqDCoE9w
dF9yZGlycGx1cyksDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IFdoeSBkb24ndCB3ZSBqdXN0IGNoZWNrIGZvciB0aGUgRU5PUEFSQU0gcmV0dXJuIHZhbHVlIGZy
b20NCj4gPiA+ID4gPiA+IGZzX3BhcnNlKCk/DQo+ID4gPiA+ID4gSW4gdGhpcyBjYXNlIEkgdGhp
bmsgdGhlIHJldHVybiB3aWxsIGJlIEVJTlZBTC4NCj4gPiA+ID4gTXkgcG9pbnQgaXMgdGhhdCAn
c2xvcHB5JyBpcyBvbmx5IHN1cHBvc2VkIHRvIHdvcmsgdG8gc3VwcHJlc3MNCj4gPiA+ID4gdGhl
DQo+ID4gPiA+IGVycm9yIGluIHRoZSBjYXNlIHdoZXJlIGFuIG9wdGlvbiBpcyBub3QgZm91bmQg
YnkgdGhlIHBhcnNlci4NCj4gPiA+ID4gVGhhdA0KPiA+ID4gPiBjb3JyZXNwb25kcyB0byB0aGUg
ZXJyb3IgRU5PUEFSQU0uDQo+ID4gPiBXZWxsLCB5ZXMsIGFuZCB0aGF0J3Mgd2h5IEVOT1BBUkFN
IGlzbid0IHJldHVybmVkIGFuZCBzaG91bGRuJ3QNCj4gPiA+IGJlLg0KPiA+ID4gDQo+ID4gPiBB
bmQgaWYgdGhlIHNsb3BweSBvcHRpb24gaXMgZ2l2ZW4gaXQgZG9lc24ndCBnZXQgdG8gY2hlY2sg
dGhlDQo+ID4gPiB2YWx1ZQ0KPiA+ID4gDQo+ID4gPiBvZiB0aGUgb3B0aW9uLCBpdCBqdXN0IHJl
dHVybnMgc3VjY2VzcyB3aGljaCBpc24ndCByaWdodC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+
ID4gSSB0aGluayB0aGF0J3MgYSBiaXQgdG8gZ2VuZXJhbCBmb3IgdGhpcyBjYXNlLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFRoaXMgc2VlbWVkIGxpa2UgdGhlIG1vc3Qgc2Vuc2libGUgd2F5IHRv
IGZpeCBpdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gWW91ciBwYXRjaCB3b3JrcyBhcm91bmQganVz
dCBvbmUgc3ltcHRvbSBvZiB0aGUgcHJvYmxlbSBpbnN0ZWFkDQo+ID4gPiA+IG9mDQo+ID4gPiA+
IGFkZHJlc3NpbmcgdGhlIHJvb3QgY2F1c2UuDQo+ID4gPiA+IA0KPiA+ID4gT2ssIGhvdyBkbyB5
b3UgcmVjb21tZW5kIEkgZml4IHRoaXM/DQo+ID4gPiANCj4gPiBNYXliZSBJJ20gbWlzc2luZyBz
b21ldGhpbmcsIGJ1dCB3aHkgbm90IHRoaXM/DQo+ID4gDQo+ID4gODwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZnNfY29udGV4dC5jIGIv
ZnMvbmZzL2ZzX2NvbnRleHQuYw0KPiA+IGluZGV4IDlhMTY4OTdlOGRjNi4uOGYxZjliNGFmODlk
IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gPiArKysgYi9mcy9uZnMv
ZnNfY29udGV4dC5jDQo+ID4gQEAgLTQ4NCw3ICs0ODQsNyBAQCBzdGF0aWMgaW50IG5mc19mc19j
b250ZXh0X3BhcnNlX3BhcmFtKHN0cnVjdA0KPiA+IGZzX2NvbnRleHQgKmZjLA0KPiA+IMKgIA0K
PiA+IMKgwqDCoMKgwqDCoMKgwqBvcHQgPSBmc19wYXJzZShmYywgbmZzX2ZzX3BhcmFtZXRlcnMs
IHBhcmFtLCAmcmVzdWx0KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG9wdCA8IDApDQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBjdHgtPnNsb3BweSA/IDEgOiBv
cHQ7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAob3B0ID09IC1F
Tk9QQVJBTSAmJiBjdHgtPnNsb3BweSkgPyAxIDogb3B0Ow0KPiA+IMKgIA0KPiA+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoZmMtPnNlY3VyaXR5KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY3R4LT5oYXNfc2VjX21udF9vcHRzID0gMTsNCj4gPiANCj4gSSB0ZXN0ZWQgdGhpcyB3
aXRoIHRoZSBhdXRvZnMgY29ubmVjdGF0aG9uIHRlc3RzIEkgdXNlIHdoaWNoIGhhcyBsb3RzDQo+
IG9mDQo+IA0KPiBzdWNjZXNzIGFuZCBmYWlsIGNhc2VzLiBBcyBleHBlY3RlZCB0aGVyZSB3ZXJl
IG5vIHN1cnByaXNlcywgdGhlDQo+IHRlc3RzDQo+IA0KPiB3b3JrZWQgZmluZSBhbmQgZ2F2ZSB0
aGUgZXhwZWN0ZWQgcmVzdWx0cy4NCj4gDQo+IA0KPiBJJ2xsIHNlbmQgYW4gdXBkYXRlZCBwYXRj
aCwgaXMgYSAiU3VnZ2VzdGVkLWJ5IiBhdHRyaWJ1dGlvbg0KPiBzdWZmaWNpZW50DQo+IA0KPiBv
ciB3b3VsZCB5b3UgbGlrZSBzb21ldGhpbmcgZGlmZmVyZW50Pw0KPiANCg0KIlN1Z2dlc3RlZC1i
eToiIHdvdWxkIGJlIGZpbmUuDQoNCkNoZWVycw0KICBUcm9uZA0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
