Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE78598620
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbiHROiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbiHROiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:38:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20737676;
        Thu, 18 Aug 2022 07:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRNutJQHEqUlUYAHTgKUlMitN4XEAftliOajZq0R4Fd5o/fOuddaIvITqpfoZqM6CTlybHXBqEE3wYE7evS1c2k56XLhOh6yWvN4CsvqB9X8I9qoNuue+/+C6h0lrltsbde/x9JGqcW2OPNnGV8i8xCAqL16Xiz9rC22v4LVosVKZoYdk49DGdkk3k9hJnJwwwP/Z5FRtkok/S4gekqvFkZP/I60jLUy5ZV9QLzkVhg83BPxZ4Lwu6NLUHmuqAzzNmAu2kR7hp+MjXmS44T+Uf8aJX9bXcILDKqlttg1J/37vxmSNTFFWgG/n950VJpoVZij9NFFxxtU0dOa0RND/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ecCv1GA2IzRI1O1I3WQ4w026x7799GHk0IN8wgfn/o=;
 b=Aj2PpIVRQJyTdWqvcVdNarPMpxw1Rfhsb5IWYZa0p+JqxpHnqVYN4P2dDvzJ9G9kq7rsMmUFEbrhm6XZWQdIu92caSGVwYM5E06v9avSeXXvKBE6LaxxHL5v5p5wdiOUMU9Vv4zQPYLZUH8VDZjfi/aY1ZLktulaPLLHvE+kfbv/DQ70BxZ/ORXIwqDlcOKsWKo6yEWjaleoHCwaWslqWZZMJgdMafVUW+HW52PrShab3Rb94fevoXKmZktiiRM2lidtozwgp+b5BJOW7F/drmDrRjAs+F19zj42OzlM19hjJ96bmc8xikpqbIu4Po66WcOvhKXJ1fk1Bh7JhkOcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ecCv1GA2IzRI1O1I3WQ4w026x7799GHk0IN8wgfn/o=;
 b=Jo1cXs8f9JzitCy5qimGYhCMn12lp3p3aCSNBrLkn+irt0dHnDXNM7lkkvEikXN9rpOp2cLkKAiXE3x74ieMs5FeLWtUmvWaKfoXEmSqhRA3XbyATfq2BFZhoKZEBgydX10i7UhKUDo4SSnDM+A3TwyA77hIUgUAkF1P6tg0RPM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3442.namprd13.prod.outlook.com (2603:10b6:a03:1ab::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Thu, 18 Aug
 2022 14:38:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5566.004; Thu, 18 Aug 2022
 14:38:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Thread-Topic: [RFC] problems with alloc_file_pseudo() use in
 __nfs42_ssc_open()
Thread-Index: AQHYsoQbU7E1olekUEiP9OU0visUl62zrV6AgAAY6QCAAAMWgIAAVeYAgAAJBoCAAHtwgIAAF4UA
Date:   Thu, 18 Aug 2022 14:38:12 +0000
Message-ID: <8cf1896588e79a1ca077f54398f8f82ed176114a.camel@hammerspace.com>
References: <Yv1jwsHVWI+lguAT@ZenIV>
         <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
         <Yv2BVKuzZdMDY2Td@ZenIV>
         <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
         <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
         <Yv3Ti/niVd5ZVPP+@ZenIV>
         <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
In-Reply-To: <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bea0eeaa-de0a-4c45-cd0a-08da81274777
x-ms-traffictypediagnostic: BY5PR13MB3442:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhrhZf3BbKR7PPPqBGMYpeuiIb6rd/4QH5j3zPwlHmCsz4RMHy1w3V+mglK+UbwCEu82Li963Ax8frzB3ITI8LijbWz/ABzEp18f1frRIx5vM9sUC126VENOhYhTtZBqDoKB1ch+Y+nFBOpoIc9tVtLjN3gPxzulz1DUX4GUdLYvrBLW+WgZVQSUIz7LdheXCW5K/s7Wanpi8LADPC4Sl1ehfUdxghwWUkPd28cMeSmZdZskY5EoaYvhjtBph2vc/LKmit0ldsJ4bq1UX08Wz6ARCztBwu9fQQSaok6HMJ/EOBNYU/m7L50E2hpSK8tc8mIZ7WYanrDESMbaW1g1c9K+GN8m7r4taCEvshEuXnne0tb5ZjemkOXaTzbLLsBxKMu99JIn6l7UZndZtFXeN+6ElR303ltpypMHqccv/fzC8+T7lYQOI3O1AsmtaSLNAvjMW1bpjSX9N7IvcsQ4Mm0SI55IEKn+t9RrRHtJ6+apgneYhENWFBirnZuM+uuYXiJtuLVTCLDaFsIsm9N8ftfJsBh6x96MDZ09Uy3T8O83TQBE8VK+O9tddIwdkGfMxolddOmusfsLud9pT5cfd0DAhEhtlzzlw4zAy0dtOZsjAeiVdcoAk93JxdTpjRed2LJowAUpD/49zResd10LjAiTjpqQ2jhqGB/FejH1X6ynE5Izvlos51pqgVFTHrWma/paEQ/5FdNdcbQSoKzVVhpx7veiiQgZygjS3pdClhWOlyBXKWkm8+C4InDalNVzVY0e+9eCIeKI+C4UsTrIfOhXwxpOmSC2B9AEuHtZMiRE6oWRM4h6eNQ7zKG3RaZf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39840400004)(346002)(136003)(366004)(5660300002)(8676002)(36756003)(478600001)(71200400001)(316002)(6486002)(41300700001)(54906003)(66946007)(64756008)(66556008)(2906002)(66446008)(76116006)(4326008)(66476007)(8936002)(110136005)(86362001)(26005)(53546011)(38070700005)(38100700002)(6512007)(186003)(2616005)(6506007)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29peVF0cWdGOGlTMmpDeG1qWm9VZTFZUzJtZmdUcmYwTnBydEhtYWZXelVG?=
 =?utf-8?B?aTdxZ3M3WEwwRWJrWGlVM3RpdU4rdGdkamUzT2E2ZTViUk43ZDBRNXlBZEt6?=
 =?utf-8?B?NjFvUTVMdmVMcWhaVTBSMG1FTmt3aWkrWTN4ZDVWM0xiQ3lLajNpaE1aSmhP?=
 =?utf-8?B?NTlwNlJxRDRpWk5Za3ExMWpxUFk1elcxV1NQMUQvZkN3Qy9zc2IwZi9CSHR4?=
 =?utf-8?B?RVVsVGdPUWlHMTlHUitiWmlaRE1VbTA3SDNSZC9YZ1F1YTk2TEZueklLT3VK?=
 =?utf-8?B?TFZNeWt5NTZEYis2S1hIbFRjYmlCT1dGUVdudmJzYS80VUNvTFdkZDNxTHR3?=
 =?utf-8?B?U2xhSTNydFFNei9nT24va1Yyd3hhWnRzakVGRWordGxXNnJRZ2FDcVk2ZVBt?=
 =?utf-8?B?Nm5WaksvWU1BS1ArWHRtbFFiSm8reTYwTUlRcVdUWHJKbm9haDkwRXA5NnNF?=
 =?utf-8?B?TGdhL25RU1NkUTVYMjQ1S3VXNGdzTDBuMFhuS1cvRDZmK3pJaVJyWVBncWlj?=
 =?utf-8?B?RE0rVXdmcUxhZndwRjVvKzdCbEdHbElyYWJxY2lkbWM5cGlsVVNobDJ3L1hX?=
 =?utf-8?B?U1VYNDA5ek55RUZyTW9qc2dwSUhERG1pbzcrN3d4TVY3S0tpbzEvSFlVSjBp?=
 =?utf-8?B?cmhGMjZYQTNTc2JsVVA2M3NJeHRFMGk2cnVNZFNib3JqZEgyYi9hMnB6Vzlm?=
 =?utf-8?B?b0d4a0d4Mi9zT29SYVlvNXRQK0VKZnNUS0lVMG5IbFpHWVRJcVpRcUFzTWhq?=
 =?utf-8?B?VXJ5OStQbUo1Sk55djFiVjVmeFlRbFVpK01WY0dpS2V4WkxwWSt3Nng0cWVT?=
 =?utf-8?B?K1FZd2xSdnJLcFkwT3AxdUo5SHhVRnJIVThSa0VnQ1VmUlQ0TFVua04zcVRz?=
 =?utf-8?B?aW5vcU5JQkRqU0JRWVpoVDF5cnBHdk5MUUt1bTJCTGkwb1hZUE40ZXlybUpG?=
 =?utf-8?B?R1hiR1JmRGtaWkorbVIvVGFpS3Y2ZTVZd1ZyYzNTbzh0OW4ra2xyLzc5ZDhq?=
 =?utf-8?B?QWVLNkhnRElMbk40WDJXUnBTaVNGSnlwYUNkVnRaNlpMNDJac3Rxc1VHUnc0?=
 =?utf-8?B?TWZMQWtpSld2Y0p4ZzhkQkpXSnlIOGN1SGZYaXZ3RzRuTzdUbkNjSnk3RlRW?=
 =?utf-8?B?eU5MVzU1cWVKbUFLcGlqVWhqb3pHSVJqcytzVk1UQTBMQU1HYkNIdlRwNHJM?=
 =?utf-8?B?MkVzSGxTaXB5QWhtYUtGZnBmNFRkU0EvTG8rb1JqelVwK1pmcy8xbHoySHVP?=
 =?utf-8?B?SldCSGlDYkpvVzM0V21VSk96bnEva2FLMUtpM1EzcHBqeWNkZFhhcFF5N0hT?=
 =?utf-8?B?QmVyelQ5ampGS05IQUVvZ29RbjF2Wk5Ob1N5blBBRnBnYjdnT1R6K2FTZGVo?=
 =?utf-8?B?MDM1MFhiMm42dGpqZnc3SmVuZjFuVjllZDhkTG1RU3lsZXpUaVFucWVYdDFM?=
 =?utf-8?B?ZGdGV0NydjF4eU4zMmdRc24xczBjTTc3dHdRclJBcDNXQktNMm02aExpQmd4?=
 =?utf-8?B?Q2Nra0l0YkVtTHRaQ0ZiN2M2UDh1TzZCZHBFa1FWaTQyQUpHaTVmTTBLRVNJ?=
 =?utf-8?B?Vm1rOG5QanlROGJkMHVGVUFaUEdjNldnTkg1ak9sYlpNNVZTUmtrTG1GNUlO?=
 =?utf-8?B?bmdWVkkxUVJLckp5Vzk3UVdhUHcyNzZxeFhVd0pkUVQ0QW1qNElRbnF1Zzlv?=
 =?utf-8?B?SzFzekdXck92QWdBR09TQTZsR3FUcmtGREQ1UFcxYkhDVUcya2wxZVBld0R3?=
 =?utf-8?B?bll5T1RGc0lJZWdSaXVHekJ5UDczQlY0N0IzUVZGdXdhNnE0ZWVKT0hEZDNV?=
 =?utf-8?B?QzdCNjdoWm9haFg5a2VXbWIzVUwzMjIrdHpwdVBnNXo4L1dVNngxbjJHL1kv?=
 =?utf-8?B?d3J4aDBtNHl3Q3JEU3poVzdOM29uRkoxQzR5ZHIwZmVVcEhqdlVBNHdOL0Y0?=
 =?utf-8?B?ZW15NkQzNWYveWNNNm5uY1hSSk5xcEpkK2l0emdLdGI2WFF1UGIxTjc2Szhs?=
 =?utf-8?B?dkM2eFkyQk5saWI3Vm1JTEdNRFo0N01FOUEzazU5TDJ4cS8zR1V5YUNmKzZJ?=
 =?utf-8?B?Nis4THNPR3pBYVlEdDNpY1BrUllXd2cyc2JBOWRGZXBRQlRJRDRCNk9NaG9t?=
 =?utf-8?B?S1cwVU8yZW9aSzdZbkxmdU5HY0R5ZmUrd0dhUXRtUG5taGJUd1lkcHNrSzJ4?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C28D538896458B4F8984CC534CB41D92@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea0eeaa-de0a-4c45-cd0a-08da81274777
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 14:38:12.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: af56g/OHssAl5H99MtZQFHEP6ZnMfzmxH7G9RXb7Yh3q7PyL7OHflntt7nHlI/vA9jrXaF06u0dxP/eX/+1dAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTE4IGF0IDA5OjEzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMTo1MiBBTSBBbCBWaXJvIDx2aXJvQHplbml2
LmxpbnV4Lm9yZy51az4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCBBdWcgMTgsIDIwMjIg
YXQgMDg6MTk6NTRBTSArMDMwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+ID4gDQo+ID4gPiBO
RlMgc3BlYyBkb2VzIG5vdCBndWFyYW50ZWUgdGhlIHNhZmV0eSBvZiB0aGUgc2VydmVyLg0KPiA+
ID4gSXQncyBsaWtlIHNheWluZyB0aGF0IHRoZSBMYXcgbWFrZXMgQ3JpbWUgaW1wb3NzaWJsZS4N
Cj4gPiA+IFRoZSBsYXcgbmVlZHMgdG8gYmUgZW5mb3JjZWQsIHNvIGlmIHNlcnZlciBnZXRzIGEg
cmVxdWVzdA0KPiA+ID4gdG8gQ09QWSBmcm9tL3RvIGFuIGZoYW5kbGUgdGhhdCByZXNvbHZlcyBh
cyBhIG5vbi1yZWd1bGFyIGZpbGUNCj4gPiA+IChmcm9tIGEgcm9ndWUgb3IgYnVnZ3kgTkZTIGNs
aWVudCkgdGhlIHNlcnZlciBzaG91bGQgcmV0dXJuIGFuDQo+ID4gPiBlcnJvciBhbmQgbm90IGNv
bnRpbnVlIHRvIGFsbG9jX2ZpbGVfcHNldWRvKCkuDQo+ID4gDQo+ID4gRldJVywgbXkgcHJlZmVy
ZW5jZSB3b3VsZCBiZSB0byBoYXZlIGFsbG9jX2ZpbGVfcHNldWRvKCkgcmVqZWN0DQo+ID4gZGly
ZWN0b3J5IGlub2RlcyBpZiBpdCBldmVyIGdldHMgc3VjaC4NCj4gPiANCj4gPiBJJ20gc3RpbGwg
bm90IHN1cmUgdGhhdCBteSAoYW5kIHlvdXJzLCBhcHBhcmVudGx5KSBpbnRlcnByZXRhdGlvbg0K
PiA+IG9mIHdoYXQgT2xnYSBzYWlkIGlzIGNvcnJlY3QsIHRob3VnaC4NCj4gDQo+IFdvdWxkIGl0
IGJlIGFwcHJvcHJpYXRlIHRvIGRvIHRoZSBmb2xsb3dpbmcgdGhlbjoNCj4gDQo+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvbmZzNGZpbGUuYyBiL2ZzL25mcy9uZnM0ZmlsZS5jDQo+IGluZGV4IGU4OGY2
YjE4NDQ1ZS4uMTEyMTM0YjY0MzhkIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNGZpbGUuYw0K
PiArKysgYi9mcy9uZnMvbmZzNGZpbGUuYw0KPiBAQCAtMzQwLDYgKzM0MCwxMSBAQCBzdGF0aWMg
c3RydWN0IGZpbGUgKl9fbmZzNDJfc3NjX29wZW4oc3RydWN0DQo+IHZmc21vdW50ICpzc19tbnQs
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gwqDCoMKgwqDC
oMKgwqAgfQ0KPiANCj4gK8KgwqDCoMKgwqDCoCBpZiAoU19JU0RJUihmYXR0ci0+bW9kZSkpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzID0gRVJSX1BUUigtRUJBREYpOw0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gK8KgwqDCoMKgwqDC
oCB9DQoNCllvdSdyZSBiZXR0ZXIgb2ZmIGdvaW5nIHdpdGjCoCdpZiAoIVNfSVNSRUcoKSknIHNv
IHRoYXQgd2UgYWxzbyByZWplY3QNCnN5bWxpbmtzLCBwaXBlcywgZGV2aWNlcywgZXRjLiBUaGUg
cmVxdWlyZW1lbnQgZm9yIHRoZSBORlN2NC4yIGNvcHkNCm9mZmxvYWQgcHJvdG9jb2wgaXMgdGhh
dCBib3RoIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGJlIHJlZ3VsYXINCmZpbGVzLg0KDQo+
ICsNCj4gwqDCoMKgwqDCoMKgwqAgcmVzID0gRVJSX1BUUigtRU5PTUVNKTsNCj4gwqDCoMKgwqDC
oMKgwqAgbGVuID0gc3RybGVuKFNTQ19SRUFEX05BTUVfQk9EWSkgKyAxNjsNCj4gwqDCoMKgwqDC
oMKgwqAgcmVhZF9uYW1lID0ga3phbGxvYyhsZW4sIEdGUF9LRVJORUwpOw0KPiBAQCAtMzU3LDYg
KzM2Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgZmlsZSAqX19uZnM0Ml9zc2Nfb3BlbihzdHJ1Y3QNCj4g
dmZzbW91bnQgKnNzX21udCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJfaW5vLT5pX2ZvcCk7DQo+IMKg
wqDCoMKgwqDCoMKgIGlmIChJU19FUlIoZmlsZXApKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXMgPSBFUlJfQ0FTVChmaWxlcCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlwdXQocl9pbm8pOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z290byBvdXRfZnJlZV9uYW1lOw0KPiDCoMKgwqDCoMKgwqDCoCB9DQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
