Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CA6B1AA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 06:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCIFOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 00:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCIFOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:14:49 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2048.outbound.protection.outlook.com [40.107.114.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B46A04C;
        Wed,  8 Mar 2023 21:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6UGPcLJqwnJ6kxIEmE8pCA/Q/iMn26qylwuLkF3n3RwA3r/Ryh8ATaT3a0ioRLrJc1mOs+luHBNS28780bDbCJqgVjlte0hEL/lT66HETA9NMBQ/WuQLFrwtbgjPdknXQ3xTnafvW8hrGWkjkssKjV5n0dnqMZiQJa2hExEDi9tjK0yw2MjLZWzVPnlH3duQocYKo4F1HbTFcywMsXl7jn34Ao/VcDcFTHSVgBd6MMZTdgEJYMiFIy4yfUvfgZNbBnjkQoak5BsOLKM3r2Xqa2QuDPHflbpBfONhLeu/hAJ2dQHlM0gPxOKCzxMlGbkPdNl3El9K+ajy+Ns5EGvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6su3jZ+1X+FGzDvMp6PHsmhfeaUyVEd2aTCq6iQLzOU=;
 b=iIQbnJqLAaR9dOHqYx/N6/oFp2W2VDShLeHuSg/reVzb+7m9n+NeXNAdb8ZFozszoTZA3HqQxL703FPhVM0w/ZRyKgcN19lfTc+8JIRWN0b8jFq5FF/Po+YvlIDJX1C/OzbMTLWNwFYfEQguz35xugQAXLz7nU068rYWH30gzcrDqntZYRscLc5iQQLdH5YiqG+zBc049xnZUlxflMQlwQi0bLepx1tOVPeoSP3QhURJjNozRmpxyqT/CmcpBtqAmEDBecYdohyWo0ryOS0ClyRCsyu7BdgFKuqgEiea6XdEJ6GpRkr4oyuNXncckFUb73UqYw22Z1d78bZ++7r5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6su3jZ+1X+FGzDvMp6PHsmhfeaUyVEd2aTCq6iQLzOU=;
 b=aHcIS8xmTn31Q1KkMYzvlfOTvrMbILdpt5zB5YOx5HpV88r+RBjiyAlkDOaojFYbAGJuTFaqfAmQlzXyrNB4auqKoGtsR6LU77RjAYfDUkoeYmWPSZT2dyQ4ll9SVeLDebMQa9PC/rbj/6gEEk1Ss2zC/4DSagoa53ck2zU+TpY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB6276.jpnprd01.prod.outlook.com (2603:1096:604:f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 05:14:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%8]) with mapi id 15.20.6178.018; Thu, 9 Mar 2023
 05:14:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: memory-failure: Move memory failure sysctls to its
 own file
Thread-Topic: [PATCH] mm: memory-failure: Move memory failure sysctls to its
 own file
Thread-Index: AQHZUkEPh11ZOS2V6EaLBiN5ERHmHK7x55aA
Date:   Thu, 9 Mar 2023 05:14:41 +0000
Message-ID: <20230309051439.GA4018963@hori.linux.bs1.fc.nec.co.jp>
References: <20230309045924.52395-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230309045924.52395-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS3PR01MB6276:EE_
x-ms-office365-filtering-correlation-id: e56de1ce-151b-403d-76b2-08db205d307f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5ahc2dTDPiFe1vTwKqQm+xKeQrFK0cMqUYDvyV0gbMHAinlzT5RgkPx/WDIcMaVKPhZo72hn4JzAl9wbFjdeQ9mYtbk/2j6uyiNuxLltTlc0sJxvv9B9T82Z3o9I6cBGOy+l2ofr8337cEyrIsnLDCvVcj/BhRDfuQcFyiBvFFD4uZ24jp1BgLzYSBXzdfsTNIvJjUqKhWxx52Z8CKAqsb0dTmGnzjPYFX0H9j08tFDcZrW5VSvAu4r3EdcP/6ajIzucr/VAo0sxC+Ik75InsrM99vR0qB7+Ir1PRhb61BLD4j0pWL/aKT1Fzu9TIh9LiaDfTyNzAZ+BVUiMNzVg6O6H8N3bC98cEXMk2abOuWlM0VGbGTznE9c6q23ujjobO5L+xg4SdLo+FelFvf4/ceq5bhaUyl9NNSw6xaqwV/qoMGZO5t6UOwRDIqyZ3de+7OLUR3HbIX+C+vft3HvTx8hOMoaGSQdtQ/jDmmdJQ+mpx799YyxHPZS1/YOm3/BQHcTw4efIxmbXPVvKV3RgdF4Qbanvr3XF+RLFgfMTfdimoKTme8PoXWRXBGBeKr+33hQqXrQ4dWM2zdUEYxIAQWW7vg3HjvPJEh0bzX9gjEpEOyvVgFbviciE4VWz8CqmYrI+XQ2lXwbYuEd867Hxj8eTkMSkA2hLLG9ex/HCv/zOVOeW/XTKO0BO6GPsM+2bLcwsy1/ad9ZrPX+EOdQkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(83380400001)(478600001)(85182001)(122000001)(186003)(71200400001)(54906003)(33656002)(38100700002)(82960400001)(66556008)(9686003)(76116006)(66446008)(66946007)(66476007)(8676002)(4326008)(64756008)(6916009)(26005)(6512007)(38070700005)(2906002)(55236004)(6506007)(1076003)(5660300002)(4744005)(316002)(6486002)(41300700001)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2Fnd09xUVpYVE5tZzI0Qjd6WUx5bVlzNDUveUZMSjVmTXlIT1lacnZ5V0dx?=
 =?utf-8?B?TjhFQ0JialFwSHV4bFhJQWRGU0ZFOHUwM2x3TlRCeUJTdHpLQnZYSUpxMXZm?=
 =?utf-8?B?REN5aTF3eG9VdE1rdlIrZ1FSSmVCZXhydmZuenNwYWErV0drNEtLMUNTSnor?=
 =?utf-8?B?MUtJUGRtTlpmTmljRTBPemxjbEdjNTlpM01QVmxqU1BZVEdHUlhucktNVnY1?=
 =?utf-8?B?azQ0ZnFHV0hZYy9WUzBVaTVIajViUGhJeDVGWTlBYUkwcWJXSUhMZHY5VHE0?=
 =?utf-8?B?dzRtY0d4ZFdUK20wN29MUkVBbmZlZ3BGeTgxWndhVG9ueTVQMEpVdnVmN3Rq?=
 =?utf-8?B?SEs3NGVPTzRoVC9RSzA2RlFGMm9vdHcvVmtHN3lWZ0FGS1ZPUzMxUTRNckRN?=
 =?utf-8?B?NmtKc2FHK3NZeVRkZTNZd1FWR1hNMHJLNGRtLzV6ZUVwTkpzNk04SDF4amRI?=
 =?utf-8?B?QXlLYjByUDBXVjV5ekRXN1BpQ29OVDN6QjVNUkxZd1l0cDNsdzExOTE4RGZa?=
 =?utf-8?B?MUJMV1d4dmFORG8rMkFmNmxnRG9remhndjk0YXYwVm5BTGEzTDVjcXhYcnA2?=
 =?utf-8?B?amh0czlvaEtPYjloMGVJMEVDc3I3clUybFdtQy9PQ0ovbWJCZmRRR29FKy9I?=
 =?utf-8?B?ekk3bnBxLzVmb2xTUUFUU2c2dzZKMnpuYzVpZ1BVcEhCajBEeWxXcmhabC82?=
 =?utf-8?B?enQ0Ym9aczdieXppM09wWk5FUFFyTVZ1YTJkUTBaRXFoNDVGTlc2Wmhzb0da?=
 =?utf-8?B?Q3Y1djRmR0dVMml5eTRCNlVuZG9kOUI2bkYxcDk0NGdTcHNvRk9HQ091cko3?=
 =?utf-8?B?ejBod2lteWJRaFl1VHNHaDZUaFEvcWRGWGIyZUpwaW80YTB6VjVpS1ZadFFI?=
 =?utf-8?B?QTlBaTBTTnlNWVE0dWo2aVp0SjBBUit1U1pHQ0FYRURGYUFzWjZqQkZycFVI?=
 =?utf-8?B?V0RzaTlpZmd1ZWFJcVo3ZnZCREdWRlNRQkladktPYk54bFZhR250MmxKZ1Vw?=
 =?utf-8?B?T0tJQ2NUTGs5YmlMYjZuWUNlRGdBWEJHYVNETDRaWUhNVy81OEhRUFprQlFE?=
 =?utf-8?B?WnRFRGZveWwvZWNla2lmK2lXN0VDa1BjTm9TcU1EdFhOdm53TUxqS0V4a21i?=
 =?utf-8?B?ejNic3BJQ1dvL3ZONUp6MCtHbG9FSzduNWw4MXN3Uk54RFZMUCtudzdFUFp1?=
 =?utf-8?B?cUR2bW96Y2xsZ04vQkZJMHBzNEVUQlczZXhPaUNvc0t0MDJDVGpZVURuZUtt?=
 =?utf-8?B?SXd6T0VEYkdSQ2Myenk4UloyQzBmb3JweDl2UFhab0Y2cHRlZHdtNTJCQ0VE?=
 =?utf-8?B?QURsV2haYVhKWmx4T0wwd2Z3dlAzNkkzczFkd0NzMENQYkZRbHBLTzR5QU54?=
 =?utf-8?B?SXpzQjljSThCNWQ2K2FwNlIrTnpKQ0tFV1l1S21kS3N3alRPZFJVUXMwQlNy?=
 =?utf-8?B?VXhja0ZVMlZ3N3g4ZEZ3MGg2TDdsSVVNNy9Ya1I3NGFvYnlFV0NRQy9sK2di?=
 =?utf-8?B?Zk4rbnRNY1ovM1NKR1Y3NTU0VmVaSFpzSlpUakJOODVINGV2cm5vcEFITHhF?=
 =?utf-8?B?d0h1MnhGemE2bWFKdUNUaCs2SkROMmY5K3dXdUlXWDhsYlZDeDR2MmJGRFJG?=
 =?utf-8?B?a1BLUXpxaytaS2RBTGovT3grREtNcFFOSnhJYnhyTWRYdncyd09ONUs5ZUpz?=
 =?utf-8?B?Nms1a0Y4VHRhOExLcGJuTEpYVDg1TEh0T0R1NXFRTkduNE5WNGNNeEkwb055?=
 =?utf-8?B?RjJWYjFPK0lNMGxPQVBGWFdKb0xBT0NvOGJhQlpodFFiSm5ibW8xcEZ5Tm0y?=
 =?utf-8?B?TEREYU1ZdE5xOHpHNmdOU3F5MmNBZGRndGY3dnRpRXBEblJWS0lRZUd0Tnhm?=
 =?utf-8?B?anhLK1JQbEJuVlAxVC9oTVk2TEloTnpvSzBJRzZ4VlUzbjlrWXRtMWErcTht?=
 =?utf-8?B?TEhiL2E4Z0dRSHRhRHNnUW9MMElwaUNMVFhCbGpibUZRNHIwZFJrUkR3THJh?=
 =?utf-8?B?MHVQNnFicjY5cHNoUkM4U0tMaFBiN1V5N0o5ODNoWkVpZHcrQUwzWkwwQ2Va?=
 =?utf-8?B?enprK092aUhXdlFlb2lHOUZieEN1SmcxWitObjA3SGticEZSaDlrbTZDMUJs?=
 =?utf-8?B?cS9KMjF3amhJb2hpOTZmRS8zcWpCSlh3cE9PaHV2UmNmSFpqcXpiOHR6R3pK?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5FCD9533A6B34EAC03F5CCA8D4D1B0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56de1ce-151b-403d-76b2-08db205d307f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 05:14:42.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuretg0lj40lbnaE5E+Pc7Ql/xwGAuOvQmqUgKYxxkyKzwTVaDs0zeZ9vPh5H294JDmKuyMRc3XnYsZxMo1fEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCBNYXIgMDksIDIwMjMgYXQgMTI6NTk6MjRQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFRoZSBzeXNjdGxfbWVtb3J5X2ZhaWx1cmVfZWFybHlfa2lsbCBhbmQgbWVtb3J5X2Zh
aWx1cmVfcmVjb3ZlcnkNCj4gYXJlIG9ubHkgdXNlZCBpbiBtZW1vcnktZmFpbHVyZS5jLCBtb3Zl
IHRoZW0gdG8gaXRzIG93biBmaWxlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCg0KQ291
bGQgeW91IGV4cGxhaW4gdGhlIGJlbmVmaXQgdG8gbW92ZSB0aGVtPw0KV2Ugc2VlbSB0byBoYXZl
IG1hbnkgb3RoZXIgcGFyYW1ldGVycyBpbiBrZXJuZWwvc3lzY3RsLmMgd2hpY2ggYXJlIHVzZWQN
Cm9ubHkgaW4gc2luZ2xlIHBsYWNlcywgc28gd2h5IGRvIHdlIGhhbmRsZSB0aGVzZSB0d28gZGlm
ZmVyZW50bHk/DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
