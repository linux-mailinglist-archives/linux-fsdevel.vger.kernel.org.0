Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0B6EFF60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 04:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbjD0CbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 22:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242957AbjD0CbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:31:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2084.outbound.protection.outlook.com [40.107.113.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38BE3C2F;
        Wed, 26 Apr 2023 19:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBN3y4naFXFi9BosV4KJPd7Oye/5fOrC1Cve0byjzUVmkkcBjxK47LVAQJp5ZR4QEQiKmMDXBAb4BB7z+lWEyZFQcFG91kJxxcL2xEHnYm/6VQ2ZaQdVvbepfCX/D2LGeuvgTMzerFsTnmUDOHWlEA9hc4KUtkQ+bALZjMF3Z2s+LZMOUFkdZc4sjNzq2vdBI69Fl5ozgEei+EGxpMoCXIULjrwEQNMM74NIKr0OVCbfUoxqM9xze2A3hcVdmpUvDrthLUmZgYq2zbfPGnNXOr8M2L+8UK35FwcQXFzeZDaNUB/1O0ppDk7hsQy5gwx6F6IN6ncGMOp101392qQFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2phE5lNSifL5zOrFDb3Gcs7TgR98rV2RUsrIsU8CKk=;
 b=lTJ6lzZPWAbhZ87Mo7TMLykomFTWiM7hMUA8ySvcT7y8b5thtccOyp1nibL9jnk1cfzYonqcfHHkEE08cGSJODwx+t0ZYdkT9df7Lj/eWr7vg5U2WlS25p17vsMLnd4fiQJGpmDQ8NrULztxHsGJWZ1/xU34+Q9WDyJ421JBMupOWkCRzFaJSTbWdBpN+Q5yVtC31ghJOswRnUeKhnYuAZM21H22iPOQVpNglDC8Ycg5JpsOlxQSiqI94rYeBfUwfviHdgevN+qpitvw0WWiTpZUKtsTUc+DjmMxVcj/eBci5tRK9ho/Xuc+h6ak7yA2PGU7K3Ud4eqmE/Z2bTJXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2phE5lNSifL5zOrFDb3Gcs7TgR98rV2RUsrIsU8CKk=;
 b=Tdz1E7bt1bx0NE86fpSLLtWGzyDBMBukXGOKL81mg5qNZXvBCdb9O9jnOPH9/p7+I+Ks/7BziL+cEda9duhCvYBEvrJiiHp4kDzRtrMaNNsajenD0XRfOClXydOnQY/YcXdeNITCpGPSfgiPpt+7mOpFP445mF06sH+zG6d8bAg=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB11750.jpnprd01.prod.outlook.com (2603:1096:400:3fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 02:31:09 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 02:31:09 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "chu, jane" <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Topic: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Index: AQHZcaO0la0PeSJsOESJfU1UoYMpbK86CEYAgACeJYCAAKEtAIABAwhQgACIswCAAOwL8IAApm0AgAAXd4A=
Date:   Thu, 27 Apr 2023 02:31:08 +0000
Message-ID: <20230427023045.GA3499768@hori.linux.bs1.fc.nec.co.jp>
References: <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
 <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
 <SJ1PR11MB6083452F5EB3F1812C0D2DFEFC649@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6b350187-a9a5-fb37-79b1-bf69068f0182@huawei.com>
 <SJ1PR11MB60833517FCAA19AC5F20FC3CFC659@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f345b2b4-73e5-a88d-6cff-767827ab57d0@huawei.com>
In-Reply-To: <f345b2b4-73e5-a88d-6cff-767827ab57d0@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYWPR01MB11750:EE_
x-ms-office365-filtering-correlation-id: 9f00093b-3a91-413b-94bc-08db46c775bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /D09X757DUm4HRj3BSDUapeAhjRQFQX+0UI+rDixggK/niwJF2wFriOpf4ybK/2PRDXkgnAd8P2tD/1ULkyn3siDjVGoPTelSjG+voND5968EAMmOVQfOQrz34srYgObMGGUBD6yTJgteC7dRY2JP9ECeVRKh8Y4rJXTX3CnvqPZfJQsOZCUUF90vqQliESNHUmZMvXzqPmEEPyf5lHmIdT+yF91HMNnC8spZg2D1Nm/c8axEBrL+MLPi/8/szmA/jNjNg14HDu3Fayju7kejcr48XP+EDIU5PJvvcaPmsZ3MwruK+A+zXTxws/MlOKGzyoGyuu+8awgqhxbWCPSW1heK7bvfJsV4wlDUVFYViXqKbhsMPqXi5GHvkTUvT0tsjJuNxH7vOGMm9x19L7yqEQU17Ftgm8XXJyjCAWR+Z57G+GeXv4WpUMmsEeO9zrRsll6m7Qm8aAeqQLQcyARcGBpaDWqPemZZU2TRL9JJTuWUZ7bSjPmPVmF4AIW3AQGMMojo9DnpigIwUYC4DAop5zYIDvhHbkT25FXTRqhj2LkkM8T9m+2bgJsNKM+nDAgxhmsrRb0ax9A8UnwRHQITB9rYKpuB0ogpfLjHerWDuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(38070700005)(86362001)(33656002)(85182001)(2906002)(71200400001)(6486002)(186003)(83380400001)(53546011)(26005)(1076003)(6512007)(966005)(9686003)(6506007)(66446008)(66476007)(4326008)(76116006)(66556008)(66946007)(478600001)(64756008)(6916009)(7416002)(316002)(41300700001)(82960400001)(38100700002)(122000001)(5660300002)(54906003)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZySVowM0R2QkdRSk9RNFh4K1gzUEg4TlM3SUVYckRVUlpRZFdGRVNZdjNq?=
 =?utf-8?B?RWdoUnhPWTlpZjJERmJNWXk3NVBnZkhOZDk3NUZWU0IzelZxaDFNVTR1Q0xi?=
 =?utf-8?B?MTRqTVlob3JUTXpsTExIWGRRWmZJbVNsWUNNQWwxaHAyZVhOL2IrQk04c05Q?=
 =?utf-8?B?cGdvQ0hZZ25JendNWUlzSFpTM0liSXVLaDVOMjFUeEc5Tk9OMCt2ZXk1SUIz?=
 =?utf-8?B?Y3dMTnNzejBtb3h5WDkwY05aZlp0OVFCc013NWZRMUhleDZxMVlnSHlXRUxP?=
 =?utf-8?B?alg2TGhiYmJwdGxxR3hrV3M0emN6WldQNEFqWWtYMjZZUXNUN0xtK1Fwd3NX?=
 =?utf-8?B?dHZNcUlIVjZCRWlGd09kWENuUno2ZkxySnFzZ2UzN1Z2RG5Uby8weEx2dDM4?=
 =?utf-8?B?Y0lMZktVaHlLaElpQTg0WWI4Vjl1OWJ2TmpUYytNM3dzS2xTcCtDWTBGZ1Nq?=
 =?utf-8?B?VVE3ajFoQnZPTytkRmVEMytaeHFPaGFiMzRhaktwRlBBSEZqQ2tjcUdRR1Nx?=
 =?utf-8?B?L21BR3MwQUo4clJPTXYwWFREZmVJYWFlS3lGbE9iWUlJcTBIdFZSOTlhZGpK?=
 =?utf-8?B?ZWMzQlBiOGl5YndEUmVqRXZNcmMrb2V2QlRQOW0vY05vVFI0elplRmxqSzQ5?=
 =?utf-8?B?alFZbS9UbU92M1NkSm15L01ZWkxFQ21kckFDaU9pZ1czRWZ0QW5nM2NCZnp6?=
 =?utf-8?B?cmRGeDlGYUhhNHh1RHJnLytlYjMvbkZmd29rRWZybEg2ZEw0Mk5KQmttS1Vj?=
 =?utf-8?B?S3k3bXA4OVd1QmRmYXFGTVNUbjQrQmtVWmhtVHJIV25wYXgzSVh4Mkc4NUQy?=
 =?utf-8?B?eHRuUFNCOHFRelA2bnJMOWI3ZHFYb1d4Zkxha3NFQVVlc0VpQUxtVVhyekdO?=
 =?utf-8?B?ZEtJTVMrKzNSRFRhd1E3ZzJEa01JbjBpRE1JbThLRkhDWEVrRUtqcWJFeFNI?=
 =?utf-8?B?U05Wc044aW5UUGxEVHRlSExzMGo5ZHhpZ1FVSFAxUWE5Y2R1NUpXbVhwMDJ0?=
 =?utf-8?B?NVFtdzE4Q0xkMndGTUtmMjNhNzB2L3FDVGMwa0U2QXhHYXVzNXM2SWRralJ3?=
 =?utf-8?B?ZDA4OG5ueWhJWGNhb0dtdklnaHVhaGxNa3FwNVFDZjBna0wyZXNJUUpwOTdO?=
 =?utf-8?B?VC8yTnIwcTZyTnpEZ0RuZTljcCtuaE9rbnZOaFBxblhzZ094ejdXclFzNWdZ?=
 =?utf-8?B?VllqTXpSSnZFMnd1TnFhTFhZY0VxTmFjTzkxUkhWYkwxMi9FaTdHTTBWQWdO?=
 =?utf-8?B?MkpPSHJxUC9YellWMlhRaURMNkhiMkxST2J1YTRwT1hMeHpydW1KcjBuMWl3?=
 =?utf-8?B?OXpFSU1LdGt6ZGNPdnhXWld5Y1o0YVlpa2JLOXFlWkdMT0FUWHZMZ1NsdDdw?=
 =?utf-8?B?QnF4NlU3bE51d3F4R3JpcHNkTjY5TkV6VnJnLytiVWxZd1dPSkxBN0VjNFBj?=
 =?utf-8?B?N08wNVpGaVozN3BaYndKZHUxdUF5b3JnNmE3MS9wQlVGQXdVSWU5Mm80WFRK?=
 =?utf-8?B?ZmhuWXZnMlQ1S2pESEl5U1hDTVdrOTBUdnNVV2owUUluaVpDQkdjcmZFQVIx?=
 =?utf-8?B?bk94MXAwWVVXZWtlTWRPZU81UG8wdk5kc0FQbnplbTF0RXYzTnkxZ0pTR0hE?=
 =?utf-8?B?bjRHcktYd1djc1p6eEg3c29jc1N3UkQwdHRSUWdZUjBYbHQ0U0JPQ0FybG1P?=
 =?utf-8?B?NDRqTUlnYmNmb3pMMVVpWklWcFA3RHM1T002OUQrcEhYRllkNnJlSll3RjBi?=
 =?utf-8?B?VHZYL1RxSlJXTWk3Sis3cVAzekxNRUd2dzBSRzM2aTZnQXpNbnZMUEpCdjZi?=
 =?utf-8?B?R0hvSzRUWnJPYmE1UDdDQVpVUFJKMVlwK3A1cjdRQmRmdUtJaUR4RnFiRURD?=
 =?utf-8?B?aHJrNUNyeEVGaDdhZnV6VHRYTXVHcnliWmpGU0h1V3h6UklLd2xxMU1BSU5t?=
 =?utf-8?B?R3FsVEJUcUxoeUJSS0duc1AvWndZYWYxZjFXN1FYR2lRdHI4Zm83SzNPdVR0?=
 =?utf-8?B?NmRVeE9mLytHRk1DSlVnU0hFWjN0NXdEV3NMa2ZlMkRoSnFaUGxVd0tLS2xJ?=
 =?utf-8?B?VHE3YW5VVCtFRnNiZnB4SnQ0V3BuNnF6b2MycXNTSktjaWg0WVpzQmloS2Y5?=
 =?utf-8?B?blVpbmxMZzFXQTV1aEdWUTI4N3JERjJURjdLdjN1SS81OW95LzNnaU9VODMx?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F84287A1AFA7F48937265725D556C5E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f00093b-3a91-413b-94bc-08db46c775bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 02:31:09.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2o5Rcqi1KDLPXQS5g/xXvWwSS5hy1DwibD+i0Dy6SbBUHUF9KG5BQ2gwTNlJSHa8xMdMies9lUohjy1Zz0CPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCBBcHIgMjcsIDIwMjMgYXQgMDk6MDY6NDZBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IA0KPiANCj4gT24gMjAyMy80LzI2IDIzOjQ1LCBMdWNrLCBUb255IHdyb3RlOg0KPiA+
ID4gPiA+IFRoYW5rcyBmb3IgeW91ciBjb25maXJtLCBhbmQgd2hhdCB5b3VyIG9wdGlvbiBhYm91
dCBhZGQNCj4gPiA+ID4gPiBNQ0VfSU5fS0VSTkVMX0NPUFlJTiB0byBFWF9UWVBFX0RFRkFVTFRf
TUNFX1NBRkUvRkFVTFRfTUNFX1NBRkUgdHlwZQ0KPiA+ID4gPiA+IHRvIGxldCBkb19tYWNoaW5l
X2NoZWNrIGNhbGwgcXVldWVfdGFza193b3JrKCZtLCBtc2csIGtpbGxfbWVfbmV2ZXIpLA0KPiA+
ID4gPiA+IHdoaWNoIGtpbGwgZXZlcnkgY2FsbCBtZW1vcnlfZmFpbHVyZV9xdWV1ZSgpIGFmdGVy
IG1jIHNhZmUgY29weSByZXR1cm4/DQo+ID4gPiA+IA0KPiA+ID4gPiBJIGhhdmVuJ3QgYmVlbiBm
b2xsb3dpbmcgdGhpcyB0aHJlYWQgY2xvc2VseS4gQ2FuIHlvdSBnaXZlIGEgbGluayB0byB0aGUg
ZS1tYWlsDQo+ID4gPiA+IHdoZXJlIHlvdSBwb3N0ZWQgYSBwYXRjaCB0aGF0IGRvZXMgdGhpcz8g
T3IganVzdCByZXBvc3QgdGhhdCBwYXRjaCBpZiBlYXNpZXIuDQo+ID4gPiANCj4gPiA+IFRoZSBt
YWpvciBkaWZmIGNoYW5nZXMgaXMgWzFdLCBJIHdpbGwgcG9zdCBhIGZvcm1hbCBwYXRjaCB3aGVu
IC1yYzEgb3V0LA0KPiA+ID4gdGhhbmtzLg0KPiA+ID4gDQo+ID4gPiBbMV0NCj4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzZkYzFiMTE3LTAyMGUtYmU5ZS03ZTVlLWEzNDlm
ZmI3ZDAwYUBodWF3ZWkuY29tLw0KPiA+IA0KPiA+IFRoZXJlIHNlZW0gdG8gYmUgYSBmZXcgbWlz
Y29uY2VwdGlvbnMgaW4gdGhhdCBtZXNzYWdlLiBOb3Qgc3VyZSBpZiBhbGwgb2YgdGhlbQ0KPiA+
IHdlcmUgcmVzb2x2ZWQuICBIZXJlIGFyZSBzb21lIHBlcnRpbmVudCBwb2ludHM6DQo+ID4gDQo+
ID4gPiA+ID4gSW4gbXkgdW5kZXJzdGFuZGluZywgYW4gTUNFIHNob3VsZCBub3QgYmUgdHJpZ2dl
cmVkIHdoZW4gTUMtc2FmZSBjb3B5DQo+ID4gPiA+ID4gdHJpZXMNCj4gPiA+ID4gPiB0byBhY2Nl
c3MgdG8gYSBtZW1vcnkgZXJyb3IuICBTbyBJIGZlZWwgdGhhdCB3ZSBtaWdodCBiZSB0YWxraW5n
IGFib3V0DQo+ID4gPiA+ID4gZGlmZmVyZW50IHNjZW5hcmlvcy4NCj4gPiANCj4gPiBUaGlzIGlz
IHdyb25nLiBUaGVyZSBpcyBzdGlsbCBhIG1hY2hpbmUgY2hlY2sgd2hlbiBhIE1DLXNhZmUgY29w
eSBkb2VzIGEgcmVhZA0KPiA+IGZyb20gYSBsb2NhdGlvbiB0aGF0IGhhcyBhIG1lbW9yeSBlcnJv
ci4NCg0KWWVzLCB0aGUgYWJvdmUgd2FzIG15IGZpcnN0IGltcHJlc3Npb24gdG8gYmUgcHJvdmVu
IHdyb25nIDspDQoNCj4gPiANCj4gPiBUaGUgcmVjb3ZlcnkgZmxvdyBpbiB0aGlzIGNhc2UgZG9l
cyBub3QgaW52b2x2ZSBxdWV1ZV90YXNrX3dvcmsoKS4gVGhhdCBpcyBvbmx5DQo+ID4gdXNlZnVs
IGZvciBtYWNoaW5lIGNoZWNrIGV4Y2VwdGlvbnMgdGFrZW4gaW4gdXNlciBjb250ZXh0LiBUaGUg
cXVldWVkIHdvcmsgd2lsbA0KPiA+IGJlIGV4ZWN1dGVkIHRvIGNhbGwgbWVtb3J5X2ZhaWx1cmUo
KSBmcm9tIHRoZSBrZXJuZWwsIGJ1dCBpbiBwcm9jZXNzIGNvbnRleHQgKG5vdA0KPiA+IGZyb20g
dGhlIG1hY2hpbmUgY2hlY2sgZXhjZXB0aW9uIHN0YWNrKSB0byBoYW5kbGUgdGhlIGVycm9yLg0K
PiA+IA0KPiA+IEZvciBtYWNoaW5lIGNoZWNrcyB0YWtlbiBieSBrZXJuZWwgY29kZSAoTUMtc2Fm
ZSBjb3B5IGZ1bmN0aW9ucykgdGhlIHJlY292ZXJ5DQo+ID4gcGF0aCBpcyBoZXJlOg0KPiA+IA0K
PiA+ICAgICAgICAgICAgICAgICAgaWYgKG0ua2ZsYWdzICYgTUNFX0lOX0tFUk5FTF9SRUNPVikg
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWZpeHVwX2V4Y2VwdGlvbihyZWdz
LCBYODZfVFJBUF9NQywgMCwgMCkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbWNlX3BhbmljKCJGYWlsZWQga2VybmVsIG1vZGUgcmVjb3ZlcnkiLCAmbSwgbXNnKTsNCj4g
PiAgICAgICAgICAgICAgICAgIH0NCj4gPiANCj4gPiAgICAgICAgICAgICAgICAgIGlmIChtLmtm
bGFncyAmIE1DRV9JTl9LRVJORUxfQ09QWUlOKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBxdWV1ZV90YXNrX3dvcmsoJm0sIG1zZywga2lsbF9tZV9uZXZlcik7DQo+ID4gDQo+ID4gVGhl
ICJmaXh1cF9leGNlcHRpb24oKSIgZW5zdXJlcyB0aGF0IG9uIHJldHVybiBmcm9tIHRoZSBtYWNo
aW5lIGNoZWNrIGhhbmRsZXINCj4gPiBjb2RlIHJldHVybnMgdG8gdGhlIGV4dGFibGVbXSBmaXh1
cCBsb2NhdGlvbiBpbnN0ZWFkIG9mIHRoZSBpbnN0cnVjdGlvbiB0aGF0IHdhcw0KPiA+IGxvYWRp
bmcgZnJvbSB0aGUgbWVtb3J5IGVycm9yIGxvY2F0aW9uLg0KPiA+IA0KPiA+IFdoZW4gdGhlIGV4
Y2VwdGlvbiB3YXMgZnJvbSBvbmUgb2YgdGhlIGNvcHlfZnJvbV91c2VyKCkgdmFyaWFudHMgaXQg
bWFrZXMNCj4gPiBzZW5zZSB0byBhbHNvIGRvIHRoZSBxdWV1ZV90YXNrX3dvcmsoKSBiZWNhdXNl
IHRoZSBrZXJuZWwgaXMgZ29pbmcgdG8gcmV0dXJuDQo+ID4gdG8gdGhlIHVzZXIgY29udGV4dCAo
d2l0aCBhbiBFRkFVTFQgZXJyb3IgY29kZSBmcm9tIHdoYXRldmVyIHN5c3RlbSBjYWxsIHdhcw0K
PiA+IGF0dGVtcHRpbmcgdGhlIGNvcHlfZnJvbV91c2VyKCkpLg0KPiA+IA0KPiA+IEJ1dCBpbiB0
aGUgY29yZSBkdW1wIGNhc2UgdGhlcmUgaXMgbm8gcmV0dXJuIHRvIHVzZXIuIFRoZSBwcm9jZXNz
IGlzIGJlaW5nDQo+ID4gdGVybWluYXRlZCBieSB0aGUgc2lnbmFsIHRoYXQgbGVhZHMgdG8gdGhp
cyBjb3JlIGR1bXAuIFNvIGV2ZW4gdGhvdWdoIHlvdQ0KPiA+IG1heSBjb25zaWRlciB0aGUgcGFn
ZSBiZWluZyBhY2Nlc3NlZCB0byBiZSBhICJ1c2VyIiBwYWdlLCB5b3UgY2FuJ3QgZml4DQo+ID4g
aXQgYnkgcXVldWVpbmcgd29yayB0byBydW4gb24gcmV0dXJuIHRvIHVzZXIuDQo+IA0KPiBGb3Ig
Y29yZWR1bXDvvIx0aGUgdGFzayB3b3JrIHdpbGwgYmUgY2FsbGVkIHRvbywgc2VlIGZvbGxvd2lu
ZyBjb2RlLA0KPiANCj4gZ2V0X3NpZ25hbA0KPiAJc2lnX2tlcm5lbF9jb3JlZHVtcA0KPiAJCWVs
Zl9jb3JlX2R1bXANCj4gCQkJZHVtcF91c2VyX3JhbmdlDQo+IAkJCQlfY29weV9mcm9tX2l0ZXIg
Ly8gd2l0aCBNQy1zYWZlIGNvcHksIHJldHVybiB3aXRob3V0IHBhbmljDQo+IAlkb19ncm91cF9l
eGl0KGtzaWctPmluZm8uc2lfc2lnbm8pOw0KPiAJCWRvX2V4aXQNCj4gCQkJZXhpdF90YXNrX3dv
cmsNCj4gCQkJCXRhc2tfd29ya19ydW4NCj4gCQkJCQlraWxsX21lX25ldmVyDQo+IAkJCQkJCW1l
bW9yeV9mYWlsdXJlDQo+IA0KPiBJIGFsc28gYWRkIGRlYnVnIHByaW50IHRvIGNoZWNrIHRoZSBt
ZW1vcnlfZmFpbHVyZSgpIHByb2Nlc3NpbmcgYWZ0ZXINCj4gYWRkIE1DRV9JTl9LRVJORUxfQ09Q
WUlOIHRvIE1DRV9TQUZFIGV4Y2VwdGlvbiB0eXBlLCBhbHNvIHRlc3RlZCBDb1cgb2YNCj4gbm9y
bWFsIHBhZ2UgYW5kIGh1Z2UgcGFnZSwgaXQgd29ya3MgdG9vLg0KDQpTb3VuZHMgbmljZSB0byBt
ZS4NCk1heWJlIHRoaXMgaW5mb3JtYXRpb24gaXMgd29ydGggZG9jdW1lbnRpbmcgaW4gdGhlIHBh
dGNoIGRlc2NyaXB0aW9uLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
