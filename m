Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24C26E57BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 05:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDRDNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 23:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDRDNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:13:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2069.outbound.protection.outlook.com [40.107.113.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B163595;
        Mon, 17 Apr 2023 20:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw22XDPvCaxljH9Cmb7/c8NZqziaFFjDa2goBZ8q/cxLAg1j7jTntb3BMlQXiSm4GDu18otFDj9p05rszXiLz/obBuWi1isoy46V7mh5Rsrj4snD/vSwLvgFxzuaIbfcxoU1WD6d/860k8CwHREzbzkltq2g7EgVUI1AL77fO4AxV/lHGMsPiB2gD+vjbcrgmERV7Jtf3e4somfiHONJ92YyPh8WVBskryXafgn9O2tKVCrY+OwVqCbfFeldqMrA5mJS6bYDIs3ENJyZye1YkfQP6OMEOH7E2KDDaOROSNuvjwfAAcTyNv6ZMgbDZ5t0q83g1N8bwA/pqa57AmTPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q7cU4B1tMDYkJWqm40q8PY5Op4S2XqTEMtpFoYiAls=;
 b=NJq0uffZDI2pihvZxNApI29myi/lglMm+PcGXRqPT0kEyo6aygmFVVDHMla3o/mnSvsH20C4tXtrQ1WiPvjhoU5ib8AdcdAIp/DhUkiWDImB/SRO0Uq7dbKk+AYqdnLw15YqZpWxO+aB1EFuJGJj0tAZJ7B6c0DwA0wK5rJ1s6NOhCBumzGQg7lIhmKBhsUqguOvuP1/0zm2/UVaC5TPHrVSsEy4QtQrC/smWd49/aJow8cFblkevcf5P2KwjuWHqBe4Sr4RmbDHW1Fue+4LxO2TxXmaCGgwPx9IycAezisY7l2gwAKgjtd0437PlVIV3qE+bwALgXMpwBulJrDZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q7cU4B1tMDYkJWqm40q8PY5Op4S2XqTEMtpFoYiAls=;
 b=RBXFjyA3C8W03N6z8v+hK5kJjnWiHkk6CpxP/YuQcgwC9zq/eVPQ36wesM+DaBXP+1pMUBtRlYPWm5Q1F/TC7byCaMxKY8Lkx39Q9Uv4wG9AkI1y9+Bzbz96Esl8oA68BueJ4YUXMXDxBujYcMmvRfRymo91UYIN4pX2Gffq2w8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10384.jpnprd01.prod.outlook.com (2603:1096:400:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 03:13:10 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 03:13:10 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Thread-Index: AQHZcaO0la0PeSJsOESJfU1UoYMpbA==
Date:   Tue, 18 Apr 2023 03:13:10 +0000
Message-ID: <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB10384:EE_
x-ms-office365-filtering-correlation-id: a8c100a1-2604-4bad-20ff-08db3fbad6b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5alKqzi1o7J2g2CUhNvcPdunFN47IFLDq0ZN450kS0MMt9DnmRoh7OnOWCJf2RX4SSu7Oll6r3ysZsjOdxhfce6DBY6uE4UEW8wVccelVhqU3XCFKsdE3ScO0pzXrXaxAbpMrmtbcJfONMutJa9wxB2tePiYsgu7qKTtboKiTqN0d+thfiy6y0zehy3L+MlTDqwM2XfWKiONHBuWC39ss5/8aGlDGGvYPnsus0TktxYJHqlrABrxjBAo565nPQUHhQJ56nXTg/YLcVGoXlsMMiKQClAujnwxpOSE2QQa1/uK+2dHvZ7Ti7oSqr8ST2nqb1t3ODgQVdlb0j/jAKaSx9rH1/b99+F1sjJALaxjxZNZG/7I6GL9KVanLNkeRephfGPj7M+1HA3+IQAHGpk8dquqQHHJavITE9s9Y5zxnMF4SbCNsiqYXeL8zxiGz9Rh7TNfY3gSj5Abq+QNUOXsyPKLXZoF98LennJ6/ylG+E6bm4yxBnz144MspwLq+l1SLlXJ/IRIUIXCAWubbrTZPg/8FomFRfOT62u52WtdKhCdKTWeflP2yBIDYf7/M67KYIy5x0SQIrilFy9qsfYMw1hJrGiF++jR+QRj1eXnNNSbd6ltudHFO5rpkuSyOR9P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(38100700002)(8936002)(8676002)(122000001)(38070700005)(5660300002)(7416002)(2906002)(85182001)(33656002)(86362001)(478600001)(6486002)(71200400001)(54906003)(186003)(9686003)(6512007)(1076003)(66946007)(6506007)(76116006)(66476007)(66446008)(26005)(41300700001)(82960400001)(316002)(83380400001)(6916009)(4326008)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHhpaVUvN0JiUmhCM3cyU3BBWDVScVV0eFVYdy9iVURxZ1M5aWlpQ0JUSUd4?=
 =?utf-8?B?VnNFUms2TW8yVUJ5K1J3VGNWUmVlRlRIYXhIR1FyMFFUMWFZZG9aR1l2UHB1?=
 =?utf-8?B?WW81N2dMWXlmUGJJSitjZnBza0FueVllTGFVUWNXaUJwRzZ0YTdNbTloRlFj?=
 =?utf-8?B?dVJLcUw5a0s4L011VUlHMWdGeDhteldGcWNmOCtKSzE4OU1hcXRpNGZvU1Fy?=
 =?utf-8?B?K1gyZmZybSttUTRlQVdIZHNiZTFXL3hWR2x0ZjNqVDFsalZDZjh4OXU5dFhE?=
 =?utf-8?B?SlZ4SWt0NlZCdmdqSnRMQmFXcGttSzZtWmRXVTRRbnMwTjhCSHVhWU4rSnY5?=
 =?utf-8?B?cENmaFNVU0YyRHRXU1FJd0lEWFN3cjhuL3JMd2dXaGkvVEYzdDh0RWtKYVo2?=
 =?utf-8?B?NjBVVkVodURaNDJMTXhORzl6RVVnL0k3YVltd3JPekJnUnAyS2NTdml6M2Nz?=
 =?utf-8?B?WnZrV3QrdGY1RzBsa2FCN1FlR2ZhQi9PNFhpNFZvU3c2Qnc1Qmlkblg0YXBD?=
 =?utf-8?B?TnhYVWEvdUUvMUVnc2xrcEF1Y1lwbHlMWEVidkM0OFBoemRCaFNBcGZyM2FC?=
 =?utf-8?B?akpjVDYxdDhrcnljSWxJbzVjWURzbVo5UWJXNnQ1dFFONVM1YzRKbzhNWWo3?=
 =?utf-8?B?OXhhdGRYSitVcEh4NDFlQVdxZElZbWFrckx0YUpWazJCYVlkYjY2MmprdDI5?=
 =?utf-8?B?RzRVTXFtUEVJeHdnOVZBRk5pUDVLajkzYjFQbVNXRnRnRlUrNVo5dmNKanBS?=
 =?utf-8?B?K1BMMy9Ub0VHV214dWVqTERmOUhaWHA4bGdLMlEwK21zOXJlRnRpYWZaZlVJ?=
 =?utf-8?B?eFQ1Z2JobVRhb09zeWlTaXZhUERwVEhza3Q5YVBxRkRpSE15dVhYY0JUMURM?=
 =?utf-8?B?SDVWSS85ZW1kRWFDVkNzZzdJMEdCa2c4OXBnNkhsd2dIU2ZIb0tCZGRqUmd4?=
 =?utf-8?B?RUpEc1VtZzR1RlFaNWtvS1NCY1kwamdOS1J3KzJqUjhQaklHU2cwaW5kOCtV?=
 =?utf-8?B?Q2VYN1NQMEozUEdxSytFZGwzdU9nVU15bFdZb2FEZStvUjZqWFpwaGxzV0ZY?=
 =?utf-8?B?ZElQc2NPMml0c1A2VDRxQ0FlSERNR3IzVlB1aEZvUE5vTzFidTJGMXdTZnk0?=
 =?utf-8?B?N05ySzlQQWdzQW1Bamo3WWJjMm5VRmswQklnVHBWc0hLQUthdDRmN0JuaU9l?=
 =?utf-8?B?WlRLR0M0bmR6blBzYWdkRWNrc0hGNjJRNDdpcDc5MlVENnlvNkFnU1JEbTFn?=
 =?utf-8?B?Z3dRT2dKYWp6TFU3WW43Y1ZVQkRzM3RsNHlvVWxlQ2paWFdIYXFZbDdGTmds?=
 =?utf-8?B?cE5pejVBaUdkdFZrMHorREN6SHpCQnVweWJBQWJwa0VNU2hkN3BqWVZwa2sr?=
 =?utf-8?B?cmZHTlRYU1gyRkNmTHFQSC9oQzA0T1c4L3V1OFVqN0tUQlVDeDg5K2NaMnNo?=
 =?utf-8?B?ZGpTM3JlYkdkUERHTng2djZRUE9hTEs2WGhyM000WkIwaFNrNy9BNHFuRnlZ?=
 =?utf-8?B?ZHZpamEzSWh6ckFJZjNvMEVGeVpyOXpmNE1WU083L0s2TTdtZStRcDQxdzB2?=
 =?utf-8?B?bEpPM2pZTEd3dDFhbHdzdUZ0ekhCd1BsS3JXY2RSZU10ODVxNXoyc2dCa2pu?=
 =?utf-8?B?RytyU3o5K0FxMXB1OWt4a2I0bStrdGtYSEdLODd5V2JEMFhiR2s3TUxhcEZz?=
 =?utf-8?B?MTFwd3Q1akVXa2lOdUZLQ2RxcHNZb0NpbHhlUncwNWJvVzArRFNGQWtXTFYz?=
 =?utf-8?B?R3J5TjhVWXJrdWc2T3o5NkFTNWJvZWZBSGttMytuRFRKZWFub3pKdGpyd1pz?=
 =?utf-8?B?anc3RVRnUkpmL2gvdzNZMWpGem80UWUzdzJ4OUcyeUpJK0JuWlROYUhZU2l6?=
 =?utf-8?B?YVBqQVIvVHdiNzlyUk4vc0Nad2FpUFFPQTlib0FYVVg3OGJDNGNpdmhnbVhn?=
 =?utf-8?B?YjducGJBQjFteXBGYTRHMnl0TWswS2g4NFhDd29USVFQRmlHQ0g5Qm1FV3dM?=
 =?utf-8?B?ZGlCWEpFcWtlbUVUN2tZcnBVUHhwV3JPMnhUYkNzZ0lobU5qMmhPNUZ1ZzhX?=
 =?utf-8?B?eWZUaWpZVHpBZlNDajh2WDdxUEJncm45cThsZ3VZeUQ3N3M0UHU5cDNWZjdR?=
 =?utf-8?B?eitHR2RZQVZmMWxVVWpwczQyQWhhUmhOWmZ1RksrbWtVUWFGYzBpN2R2ZVpu?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A01079343871419B8B0DF6B1A7FC89@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c100a1-2604-4bad-20ff-08db3fbad6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 03:13:10.1528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEZx7SuTHOg3W9BsQJILgk92mXHVF43xCoEZfR75349nBfa/KVIdasqf7/mBnB9Cuj096wccSeyHSUGqkilYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTI6NTM6MjNQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFRoZSBkdW1wX3VzZXJfcmFuZ2UoKSBpcyB1c2VkIHRvIGNvcHkgdGhlIHVzZXIgcGFn
ZSB0byBhIGNvcmVkdW1wIGZpbGUsDQo+IGJ1dCBpZiBhIGhhcmR3YXJlIG1lbW9yeSBlcnJvciBv
Y2N1cnJlZCBkdXJpbmcgY29weSwgd2hpY2ggY2FsbGVkIGZyb20NCj4gX19rZXJuZWxfd3JpdGVf
aXRlcigpIGluIGR1bXBfdXNlcl9yYW5nZSgpLCBpdCBjcmFzaGVzLA0KPiANCj4gICBDUFU6IDEx
MiBQSUQ6IDcwMTQgQ29tbTogbWNhLXJlY292ZXIgTm90IHRhaW50ZWQgNi4zLjAtcmMyICM0MjUN
Cj4gIA0KPiAgIHBjIDogX19tZW1jcHkrMHgxMTAvMHgyNjANCj4gICBsciA6IF9jb3B5X2Zyb21f
aXRlcisweDNiYy8weDRjOA0KPiAgIC4uLg0KPiAgIENhbGwgdHJhY2U6DQo+ICAgIF9fbWVtY3B5
KzB4MTEwLzB4MjYwDQo+ICAgIGNvcHlfcGFnZV9mcm9tX2l0ZXIrMHhjYy8weDEzMA0KPiAgICBw
aXBlX3dyaXRlKzB4MTY0LzB4NmQ4DQo+ICAgIF9fa2VybmVsX3dyaXRlX2l0ZXIrMHg5Yy8weDIx
MA0KPiAgICBkdW1wX3VzZXJfcmFuZ2UrMHhjOC8weDFkOA0KPiAgICBlbGZfY29yZV9kdW1wKzB4
MzA4LzB4MzY4DQo+ICAgIGRvX2NvcmVkdW1wKzB4MmU4LzB4YTQwDQo+ICAgIGdldF9zaWduYWwr
MHg1OWMvMHg3ODgNCj4gICAgZG9fc2lnbmFsKzB4MTE4LzB4MWY4DQo+ICAgIGRvX25vdGlmeV9y
ZXN1bWUrMHhmMC8weDI4MA0KPiAgICBlbDBfZGErMHgxMzAvMHgxMzgNCj4gICAgZWwwdF82NF9z
eW5jX2hhbmRsZXIrMHg2OC8weGMwDQo+ICAgIGVsMHRfNjRfc3luYysweDE4OC8weDE5MA0KPiAN
Cj4gR2VuZXJhbGx5LCB0aGUgJy0+d3JpdGVfaXRlcicgb2YgZmlsZSBvcHMgd2lsbCB1c2UgY29w
eV9wYWdlX2Zyb21faXRlcigpDQo+IGFuZCBjb3B5X3BhZ2VfZnJvbV9pdGVyX2F0b21pYygpLCBj
aGFuZ2UgbWVtY3B5KCkgdG8gY29weV9tY190b19rZXJuZWwoKQ0KPiBpbiBib3RoIG9mIHRoZW0g
dG8gaGFuZGxlICNNQyBkdXJpbmcgc291cmNlIHJlYWQsIHdoaWNoIHN0b3AgY29yZWR1bXANCj4g
cHJvY2Vzc2luZyBhbmQga2lsbCB0aGUgdGFzayBpbnN0ZWFkIG9mIGtlcm5lbCBwYW5pYywgYnV0
IHRoZSBzb3VyY2UNCj4gYWRkcmVzcyBtYXkgbm90IGFsd2F5cyBhIHVzZXIgYWRkcmVzcywgc28g
aW50cm9kdWNlIGEgbmV3IGNvcHlfbWMgZmxhZyBpbg0KPiBzdHJ1Y3QgaW92X2l0ZXJ7fSB0byBp
bmRpY2F0ZSB0aGF0IHRoZSBpdGVyIGNvdWxkIGRvIGEgc2FmZSBtZW1vcnkgY29weSwNCj4gYWxz
byBpbnRyb2R1Y2UgdGhlIGhlbHBlcnMgdG8gc2V0L2NsZWNrIHRoZSBmbGFnLCBmb3Igbm93LCBp
dCdzIG9ubHkNCj4gdXNlZCBpbiBjb3JlZHVtcCdzIGR1bXBfdXNlcl9yYW5nZSgpLCBidXQgaXQg
Y291bGQgZXhwYW5kIHRvIGFueSBvdGhlcg0KPiBzY2VuYXJpb3MgdG8gZml4IHRoZSBzaW1pbGFy
IGlzc3VlLg0KPiANCj4gQ2M6IEFsZXhhbmRlciBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51
az4NCj4gQ2M6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+DQo+IENjOiBN
aWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gQ2M6IE5hb3lhIEhvcmlndWNoaSA8
bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+IENjOiBUb25nIFRpYW5nZW4gPHRvbmd0aWFuZ2Vu
QGh1YXdlaS5jb20+DQo+IENjOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IFNpZ25l
ZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT4NCj4gLS0t
DQo+IHYyOg0KPiAtIG1vdmUgdGhlIGhlbHBlciBmdW5jdGlvbnMgdW5kZXIgcHJlLWV4aXN0aW5n
IENPTkZJR19BUkNIX0hBU19DT1BZX01DDQo+IC0gcmVwb3NpdGlvbiB0aGUgY29weV9tYyBpbiBz
dHJ1Y3QgaW92X2l0ZXIgZm9yIGVhc3kgbWVyZ2UsIHN1Z2dlc3RlZA0KPiAgIGJ5IEFuZHJldyBN
b3J0b24NCj4gLSBkcm9wIHVubmVjZXNzYXJ5IGNsZWFyIGZsYWcgaGVscGVyDQo+IC0gZml4IGNo
ZWNrcGF0Y2ggd2FybmluZw0KPiAgZnMvY29yZWR1bXAuYyAgICAgICB8ICAxICsNCj4gIGluY2x1
ZGUvbGludXgvdWlvLmggfCAxNiArKysrKysrKysrKysrKysrDQo+ICBsaWIvaW92X2l0ZXIuYyAg
ICAgIHwgMTcgKysrKysrKysrKysrKysrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQouLi4NCj4gQEAgLTM3MSw2ICszNzIsMTQgQEAg
c2l6ZV90IF9jb3B5X21jX3RvX2l0ZXIoY29uc3Qgdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBz
dHJ1Y3QgaW92X2l0ZXIgKmkpDQo+ICBFWFBPUlRfU1lNQk9MX0dQTChfY29weV9tY190b19pdGVy
KTsNCj4gICNlbmRpZiAvKiBDT05GSUdfQVJDSF9IQVNfQ09QWV9NQyAqLw0KPiAgDQo+ICtzdGF0
aWMgdm9pZCAqbWVtY3B5X2Zyb21faXRlcihzdHJ1Y3QgaW92X2l0ZXIgKmksIHZvaWQgKnRvLCBj
b25zdCB2b2lkICpmcm9tLA0KPiArCQkJCSBzaXplX3Qgc2l6ZSkNCj4gK3sNCj4gKwlpZiAoaW92
X2l0ZXJfaXNfY29weV9tYyhpKSkNCj4gKwkJcmV0dXJuICh2b2lkICopY29weV9tY190b19rZXJu
ZWwodG8sIGZyb20sIHNpemUpOw0KDQpJcyBpdCBoZWxwZnVsIHRvIGNhbGwgbWVtb3J5X2ZhaWx1
cmVfcXVldWUoKSBpZiBjb3B5X21jX3RvX2tlcm5lbCgpIGZhaWxzDQpkdWUgdG8gYSBtZW1vcnkg
ZXJyb3I/DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+ICsJcmV0dXJuIG1lbWNweSh0
bywgZnJvbSwgc2l6ZSk7DQo+ICt9DQo+ICsNCj4gIHNpemVfdCBfY29weV9mcm9tX2l0ZXIodm9p
ZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKmkpDQo+ICB7DQo+ICAJaWYg
KFdBUk5fT05fT05DRSghaS0+ZGF0YV9zb3VyY2UpKQ==
