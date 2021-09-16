Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35B140E3AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhIPQvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 12:51:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244825AbhIPQrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:47:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18GFguZ6029267;
        Thu, 16 Sep 2021 09:46:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tOJsaCt6oiv1gYwFKDehwV2vxzSwFWTys89FsDmrd7U=;
 b=iCla00wUlIQ/sz18e2tarVJLvYsYsR0de4lT++7MCxQTUUXTYT4Jt6fCQPjqBYd/a8K4
 yyn/LCTdjOS1eT9MSoAWNSVf3kgQJVwdPJm+Saq/wisoP9NwWwUX8wnt4M4upLo23Dfv
 pFAKdO5lRvJXKkJKi3jrnjV2owGBv8ZYZJA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b3jkagwgw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 09:46:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHevwg2HfRm9GpI/1hU50SZ9VkrT8uVccugUdfI2LqNt/3UaKUvqq4KUFwwBlOE8riGRG4PT0iWUWU+CIvcluYmpir17Nb5aqCgEFcz8JdR0olPUGfBsR6VSiqqgtiYcne6tPBMA250ft7k9BZZ+mr/Exh6JmAo+Ow0Yy2kw7KO5RV4vfdzdBbx+naRzfDvdGXCTY9gHg7W0YywY/6nw7wGwExMYIe+UXG7kiJJ7Li1NXeesTyHvrC499A7I/L6SnETfRsBASK7kHWInargcvZGTrnbtJKMEKhJ1+VDiXCkuHdAdMIzorzS6Ti4n9VQshSZIa2RlYYRcWliNISk0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tOJsaCt6oiv1gYwFKDehwV2vxzSwFWTys89FsDmrd7U=;
 b=NqIpth2BcZxYQPaEBUpV4LL4h393axvMAC7ubpbeuRDtj0Q2TeLcF2yl4OGpq9VSPEpkZ5jSyNwod51x0RYr7T+r+dGwhHRNX4jZEkRpXEO/wG3ZOE0CLO/lqTcvaqBFzSfRIyvxwjDYQUiJ0j39DH5zOUvdRioLlC/6csBgVnzqyY3FnTlQy4Zf+VRgvI5tkqxSYehJciGuUO01sg6RsV0MaVAWJrloYLht6EybPp5PfVCffXuFg1kZHQO8oD4MYp2MMG/1UszKuG2xLkJEd2j3SKwHhYFkv011aoHWqrF7AzzRDNxtEzKrEMKJc70nYMc9slSAsYzxkMivqATORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4924.namprd15.prod.outlook.com (2603:10b6:303:e3::16)
 by MW4PR15MB4762.namprd15.prod.outlook.com (2603:10b6:303:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:46:26 +0000
Received: from CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb]) by CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:46:26 +0000
From:   Chris Mason <clm@fb.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Thread-Topic: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Thread-Index: AQHXqlkZYMl5M/taiEScAPg40L4dIqulY1sAgAAErQCAAAXjAIAACWeAgAFowYA=
Date:   Thu, 16 Sep 2021 16:46:25 +0000
Message-ID: <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
In-Reply-To: <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30368e0-a8c3-49ca-e0be-08d97931863a
x-ms-traffictypediagnostic: MW4PR15MB4762:
x-microsoft-antispam-prvs: <MW4PR15MB476249F59866D6130C2378E9D3DC9@MW4PR15MB4762.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUZbKpDHpsK/YxwVPyD5GC2ZKVud3Z3975reIKoEIrbASbLOpL9Aen5ykKlNUoltR0o9JaflnirvZVUbSwm69pO+2qQS2z7HTN2MaHUttqKwD9C9tbpmAX7Cc6gQxyJ3urrE99gqCMEeLCYpLFH3lQIukr80wu2jJavMrxEBeAD95eo65CIk+ZZPqg9k7v5loFRKE+4dfC5Kpwf+F5TDQGy3faGYvKOetThCqTT26TK+SixKDzc2G3AfREor2RYxLHghp9oM5PEV7uvhff/ffbw6RLsKvZGUpP29VEXeRunn2ZG4GLLpd2jwab2jz17bIce5fPCsGegeouXfvmF15kK8MfpdDbygiNM+vZDSDWBYB4Q3YQk8QSWZXPUgUjhC+mAqvEkZOvGPlLv72lJJ49UZo+B7KgDz9XqFqpK/nTZQAYOlJLiIJj15pic6b7a0KZBr2IHrOPvSwn3FUA+lEuSLea3lI8uY/0VL2XNP8c3UxX0BTheIcIqB5tKBSQxKNFm3aFd2n1WC3vG5/JXxwU2SFiBXoW7z9NFdLjoT64yHl9HrrS9RQQET9nfbewm8MmTbx0DKHlc0u8JMDrP1UxkFE9GrJ1+AwIVrmOhhvv++2PmphGjP3waos4jW4IOhpPkE9UWjZ3k9YCITs5lL1wm3LeLXphl05sCVgtGJyWkd8ZzfZPIUOh+Ct3nkpFDePeWl6ebR9++b9jgtiOnescqhRg/zmmxgXyXKb1GUckkCzjaEwMTVtRdXMD4s/c9W179n6+i0Cbjmtv8HciZqUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4924.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66446008)(54906003)(83380400001)(36756003)(91956017)(316002)(53546011)(66476007)(64756008)(66946007)(76116006)(66556008)(6916009)(6506007)(2616005)(86362001)(38100700002)(122000001)(2906002)(7416002)(71200400001)(186003)(478600001)(5660300002)(6486002)(6512007)(8936002)(33656002)(4326008)(38070700005)(8676002)(556444004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXE1eWFPTkViemRGaC9HSHp5eXB3dFM5UHhaaTdxSUQrZW1qbVpOTE0rcU03?=
 =?utf-8?B?anpuMC9paWx6NWFSbEVHUTZoMFA1MTZ0ZitQV04xS2NSOXBTOVVIQmhJVDFi?=
 =?utf-8?B?TU44MUJaVitFdXlkQk5Ga2Iyc2xIcmU5ZTRBK2lGS0ZwMXMvRk9PdktCVlRJ?=
 =?utf-8?B?Q2tnOW9SOTBIaEM4U3o4R1BTL1JTTUZTUmJaazNLL0ZDazFzUVFyUGhDazZq?=
 =?utf-8?B?NTU5ZXNOK2pDSmpPQUVHWEF2ZW43WnBqSHJIYUtCcDJjVHllU0JBTk43N3hm?=
 =?utf-8?B?UDkxb1NMc1o1N3RMaW9aVlZ3d2p2amt3akI2clRCTVIwbmx3ZGcrYWFnTmRl?=
 =?utf-8?B?QkhBLzlGNkJ1YVRyTUN4R0hLdjBTOTNBd2dsK2hUNS9EVExOa0QyZGtibSth?=
 =?utf-8?B?emluTkpaME5XNWJib0IydU00Qk0wR0VCbkYvVGtQUEtJb1k1SHZkblUwUVJO?=
 =?utf-8?B?dFpXblA5ZFd6ZnYwY3JHZjJvaVdzWG9odEhHZy9NdHdvZjduY2d0c1NZTm5C?=
 =?utf-8?B?aExEc3BSVzdFSEpxc1RXeU5XUzF0TXZkcHpCNDZYNG1DV3RUZWN2YWVpbFhR?=
 =?utf-8?B?QXJacmpjcjhMR0p4MTJBVXFpWS9jYzNXMUZ6cUpZMTdWVXZWSnZGbXVacUIx?=
 =?utf-8?B?MnlJY1JqVmlPOU9YR0lLQ2x2bVpLTk5rV3NjM2h3OEo3M3YxUE10YjR6cU9F?=
 =?utf-8?B?ck5FOXo2dGFRZ1F2TjBxNEUvbGhKamxqN2E1ZWRiVUc0cVVkajRoRkNKNElE?=
 =?utf-8?B?V1JVejRCQ2ZaVTBKM2NETGVoR0lIbTk3TzV6aTYrS3NPNTdKdjh2UjNiSnhi?=
 =?utf-8?B?eENKR2wwUkRXS2RyQ2Q1ZEpUMFY2RHV0RE9WcVZBWnlFNTdPcFMwWGEwNDFp?=
 =?utf-8?B?WkJpbkJidWFQS0VGQXJ2U2xhVjBGN3hnQVM2bGw4WVFDRDZBT255eU9LdCt5?=
 =?utf-8?B?Nk1PRS83RUNLMGRibDRVbnlqdE5vOXJVSE5SNG1qalFDbERkaE9VMTVlc1lY?=
 =?utf-8?B?ZVVTUzQ0T2Q2empBd1ZhQkk2c1JIbjRBZ0ZSSkVZTmIyYW1TR2pWQUphMUpX?=
 =?utf-8?B?T0tYUDV1NWRnN3FaMFltOGlaT2xESU9zbVZRdW1NMnJNYnBZOWoyRGZEUTVi?=
 =?utf-8?B?S2xjeVpIZmJNbVE4L0dDTHJaUjA5Q2xsanMwVHVnUWRrQURUWmJRU2VaUXBL?=
 =?utf-8?B?TDkrMFhXQ1E4MWxmeW1sQnljajhCMjJibjhoWlB4alJ6STRkYW5pMmtCbDlv?=
 =?utf-8?B?UHpQL3dERmdVcUxlYmdYbUtDM2hrSk9UbXZGOWhNanJVMFVvblhqQTV4MjNB?=
 =?utf-8?B?KzRxZHcwaytTWFFCRFQrMjI3WnpIelB5b1d0OXIyL0FYQWlCbCtCc29UdmIy?=
 =?utf-8?B?MVU5L0NnK2o0SkFidkg3VDRtd0VnYnBnMzhHWWptd3BOcURlNzBuWWI1TlFS?=
 =?utf-8?B?b3BYdmtQbFp4M2pEeVFEU2d1eTVCOWhuNlFOL1IyTVFZdXFpU09aUUIvREEx?=
 =?utf-8?B?K2dFdWNvaGFnem8zeEVnV0EvUitWS3AyWDJUaGZzZE9SMUV5T2ZkL2xGSmN1?=
 =?utf-8?B?N0pqU3JoZEczUExuVGljZ0d0c296elBEWWlJM2cxbWE5WmlHSDJQSzdVNjNL?=
 =?utf-8?B?NnozUjlOdlJOTHFXVWg0ZHJWWHQ1MzZobE9HcVgzVlpmTzlTdklIYS9JZnVZ?=
 =?utf-8?B?Rk4yRWxuS0RpSXEzbi9vMjBBWWNVMlJXZDUyUU5jMUZBMFNKLzk5aXlaTzRZ?=
 =?utf-8?B?TDIyRE5DQ1R5R3A3cml5Tm5DZEtEN0tOemQzbzNrWG5rZUc0Ukc2TWlkd1l6?=
 =?utf-8?Q?43jcsCbhS+QxIItNYUbLQkeoPyYXTf7XDGD/k=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54D27AC5DB089D44BB3FD5743C73D66E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4924.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30368e0-a8c3-49ca-e0be-08d97931863a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:46:25.9948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhzKvx8DIQjiGxg3Z18U0/QnBsDXCPOq5x72rl7Wq/DBtqbqsD1mjeZKvH6NqFgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4762
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ZVe5eAimMD3-9HsZkt-sbtrUF1J9HPoU
X-Proofpoint-ORIG-GUID: ZVe5eAimMD3-9HsZkt-sbtrUF1J9HPoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_05,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIFNlcCAxNSwgMjAyMSwgYXQgMzoxNSBQTSwgSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5C
b3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMjAy
MS0wOS0xNSBhdCAxODo0MSArMDAwMCwgQ2hyaXMgTWFzb24gd3JvdGU6DQo+Pj4gT24gU2VwIDE1
LCAyMDIxLCBhdCAyOjIwIFBNLCBUaGVvZG9yZSBUcydvIDx0eXRzb0BtaXQuZWR1PiB3cm90ZToN
Cj4+PiANCj4+PiBPbiBXZWQsIFNlcCAxNSwgMjAyMSBhdCAwMjowMzo0NlBNIC0wNDAwLCBKYW1l
cyBCb3R0b21sZXkgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgMjAyMS0wOS0xNSBhdCAxMzo0MiAtMDQw
MCwgVGhlb2RvcmUgVHMnbyB3cm90ZToNCj4+Pj4gWy4uLl0NCj4+Pj4+IFdvdWxkIHRoaXMgYmUg
aGVscGZ1bD8gIChPciBMaW51cyBjb3VsZCBwdWxsIGVpdGhlciB0aGUgZm9saW8NCj4+Pj4+IG9y
IHBhZ2VzZXQgYnJhbmNoLCBhbmQgbWFrZSB0aGlzIHByb3Bvc2FsIG9ic29sZXRlLCB3aGljaCB3
b3VsZA0KPj4+Pj4gYmUgZ3JlYXQuICA6LSkNCj4+Pj4gDQo+Pj4+IFRoaXMgaXMgYSB0ZWNobmlj
YWwgcmF0aGVyIHRoYW4gcHJvY2VzcyBpc3N1ZSBpc24ndCBpdD8gIFlvdQ0KPj4+PiBkb24ndCBo
YXZlIGVub3VnaCB0ZWNobmljYWwgcGVvcGxlIGF0IHRoZSBNYWludGFpbmVyIHN1bW1pdCB0bw0K
Pj4+PiBoZWxwIG1lYW5pbmdmdWxseS4gIFRoZSBpZGVhbCBsb2NhdGlvbiwgb2YgY291cnNlLCB3
YXMgTFNGL01NDQo+Pj4+IHdoaWNoIGlzIG5vdyBub3QgaGFwcGVuaW5nLg0KPj4+PiANCj4+Pj4g
SG93ZXZlciwgd2UgZGlkIG9mZmVyIHRoZSBQbHVtYmVycyBCQkIgaW5mcmFzdHJ1Y3R1cmUgdG8g
d2lsbHkNCj4+Pj4gZm9yIGEgTU0gZ2F0aGVyaW5nIHdoaWNoIGNvdWxkIGJlIGV4cGFuZGVkIHRv
IGluY2x1ZGUgdGhpcy4NCj4+PiANCj4+PiBXZWxsLCB0aGF0J3Mgd2h5IEkgd2FzIHN1Z2dlc3Rp
bmcgZG9pbmcgdGhpcyBhcyBhIExQQyBCT0YsIGFuZA0KPj4+IHVzaW5nIGFuIExQQyBCT0Ygc2Vz
c2lvbiBvbiBGcmlkYXkgLS0tIEknbSB2ZXJ5IG11Y2ggYXdhcmUgd2UgZG9uJ3QNCj4+PiBoYXZl
IHRoZSByaWdodCB0ZWhjbmljYWwgcGVvcGxlIGF0IHRoZSBNYWludGFpbmVyIFN1bW1pdC4NCj4+
PiANCj4+PiBJdCdzIG5vdCBjbGVhciB3ZSB3aWxsIGhhdmUgZW5vdWdoIE1NIGZvbGtzIGF0IHRo
ZSBMUEMsIGFuZCBJIGFncmVlDQo+Pj4gTFNGL01NIHdvdWxkIGJlIGEgYmV0dGVyIHZlbnVlIC0t
LSBidXQgYXMgeW91IHNheSwgaXQncyBub3QNCj4+PiBoYXBwZW5pbmcuIFdlIGNvdWxkIGFsc28g
dXNlIHRoZSBCQkIgaW5mcmFzdHJ1Y3R1cmUgYWZ0ZXIgdGhlIExQQw0KPj4+IGFzIHdlbGwsIGlm
IHdlIGNhbid0IGdldCBldmVyeW9uZSBsaW5lZCB1cCBhbmQgYXZhaWxhYmxlIG9uIHNob3J0DQo+
Pj4gbm90aWNlLiAgVGhlcmUgYXJlIGEgbG90IG9mIGRpZmZlcmVudCBwb3NzaWJpbGl0aWVzOyBJ
J20gZm9yDQo+Pj4gYW55dGhpbmcgd2hlcmUgYWxsIG9mIHRoZSBzdGFrZWhvbGRlcnMgYWdyZWUg
d2lsbCB3b3JrLCBzbyB3ZSBjYW4NCj4+PiBtYWtlIGZvcndhcmQgcHJvZ3Jlc3MuDQo+PiANCj4+
IEkgdGhpbmsgdGhlIHR3byBkaWZmZXJlbnQgcXVlc3Rpb25zIGFyZToNCj4+IA0KPj4gKiBXaGF0
IHdvcmsgaXMgbGVmdCBmb3IgbWVyZ2luZyBmb2xpb3M/DQo+IA0KPiBNeSByZWFkaW5nIG9mIHRo
ZSBlbWFpbCB0aHJlYWRzIGlzIHRoYXQgdGhleSdyZSBpdGVyYXRpbmcgdG8gYW4gYWN0dWFsDQo+
IGNvbmNsdXNpb24gKEkgYWRtaXQsIEknbSBzdXJwcmlzZWQpIC4uLiBvciBhdCBsZWFzdCB0aGUg
ZGlzYWdyZWVtZW50cw0KPiBhcmUgZ2V0dGluZyBsZXNzLiAgU2luY2UgdGhlIG1lcmdlIHdpbmRv
dyBjbG9zZWQgdGhpcyBpcyBub3cgYSA1LjE2DQo+IHRoaW5nLCBzbyB0aGVyZSdzIG5vIGh1Z2Ug
dXJnZW5jeSB0byBnZXR0aW5nIGl0IHJlc29sdmVkIG5leHQgd2Vlay4NCj4gDQoNCkkgdGhpbmsg
dGhlIHVyZ2VuY3kgaXMgbW9zdGx5IGFyb3VuZCBjbGFyaXR5IGZvciBvdGhlcnMgd2l0aCBvdXQg
b2YgdHJlZSB3b3JrLCBvciB3aG8gYXJlIGRlcGVuZGluZyBvbiBmb2xpb3MgaW4gc29tZSBvdGhl
ciB3YXkuICBTZXR0aW5nIHVwIGEgY2xlYXIgc2V0IG9mIGNvbmRpdGlvbnMgZm9yIHRoZSBwYXRo
IGZvcndhcmQgc2hvdWxkIGFsc28gYmUgcGFydCBvZiBzYXlpbmcgbm90LXlldCB0byBtZXJnaW5n
IHRoZW0uDQoNCj4+ICogV2hhdCBwcm9jZXNzIHNob3VsZCB3ZSB1c2UgdG8gbWFrZSB0aGUgb3Zl
cmFsbCBkZXZlbG9wbWVudCBvZiBmb2xpbw0KPj4gc2l6ZWQgY2hhbmdlcyBtb3JlIHByZWRpY3Rh
YmxlIGFuZCByZXdhcmRpbmcgZm9yIGV2ZXJ5b25lIGludm9sdmVkPw0KPiANCj4gV2VsbCwgdGhl
IGN1cnJlbnQgb25lIHNlZW1zIHRvIGJlIHdvcmtpbmcgKGFkbWl0dGVkbHkgZXZlbnR1YWxseSwg
c28NCj4gYWNoaWV2aW5nIGZhc3RlciByZXNvbHV0aW9uIG5leHQgdGltZSBtaWdodCBiZSBnb29k
KSAuLi4gYnV0IEknbSBzdXJlDQo+IHlvdSBjb3VsZCBwcm9wb3NlIGFsdGVybmF0aXZlcyAuLi4g
ZXNwZWNpYWxseSBpbiB0aGUgdGltZSB0byByZXNvbHV0aW9uDQo+IGRlcGFydG1lbnQuDQoNCkl0
IGZlZWxzIGxpa2UgdGhlc2UgcGF0Y2hlcyBhcmUgbW92aW5nIGZvcndhcmQsIGJ1dCB3aXRoIGEg
cHJldHR5IGhlYXZ5IGVtb3Rpb25hbCBjb3N0IGZvciB0aGUgcGVvcGxlIGludm9sdmVkLiAgSSds
bCBkZWZpbml0ZWx5IGFncmVlIHRoaXMgaGFzIGJlZW4gb3VyIHByb2Nlc3MgZm9yIGEgbG9uZyB0
aW1lLCBidXQgSSdtIHN0cnVnZ2xpbmcgdG8gdW5kZXJzdGFuZCB3aHkgd2UnZCBjYWxsIGl0IHdv
cmtpbmcuDQoNCkluIGdlbmVyYWwsIHdlJ3ZlIGFsbCBjb21lIHRvIHRlcm1zIHdpdGggaHVnZSBj
aGFuZ2VzIGJlaW5nIGEgc2xvZyB0aHJvdWdoICBjb25zZW5zdXMgYnVpbGRpbmcsIGRlc2lnbiBj
b21wcm9taXNlLCB0aGUgYWN0dWFsIHRlY2huaWNhbCB3b3JrLCBhbmQgdGhlIHJlYmFzZS90ZXN0
L2ZpeCBpdGVyYXRpb24gY3ljbGUuICBJdCdzIHN0cmVzc2Z1bCwgYm90aCBiZWNhdXNlIG9mIHRl
Y2huaWNhbCBkaWZmaWN1bHR5IGFuZCBiZWNhdXNlIHRoZSB3aG9sZSBwcm9jZXNzIGlzIGZpbGxl
ZCB3aXRoIHVuY2VydGFpbnR5Lg0KDQpXaXRoIGZvbGlvcywgd2UgZG9uJ3QgaGF2ZSBnZW5lcmFs
IGNvbnNlbnN1cyBvbjoNCg0KKiBXaGljaCBwcm9ibGVtcyBhcmUgYmVpbmcgc29sdmVkPyAgS2Vu
dCdzIHdyaXRldXAgbWFrZXMgaXQgcHJldHR5IGNsZWFyIGZpbGVzeXN0ZW1zIGFuZCBtZW1vcnkg
bWFuYWdlbWVudCBkZXZlbG9wZXJzIGhhdmUgZGl2ZXJnaW5nIG9waW5pb25zIG9uIHRoaXMuICBP
dXIgcHJvY2VzcyBpbiBnZW5lcmFsIGlzIHRvIHB1dCB0aGlzIGludG8gcGF0Y2ggMC4gIEl0IG1v
c3RseSB3b3JrcywgYnV0IHRoZXJlJ3MgYW4gaW50ZXJtZWRpYXRlIHN0ZXAgYmV0d2VlbiBwYXRj
aCAwIGFuZCB0aGUgZnVsbCBsd24gYXJ0aWNsZSB0aGF0IHdvdWxkIGJlIHJlYWxseSBuaWNlIHRv
IGhhdmUuDQoNCiogV2hvIGlzIHJlc3BvbnNpYmxlIGZvciBhY2NlcHRpbmcgdGhlIGRlc2lnbiwg
YW5kIHdoaWNoIGFja3MgbXVzdCBiZSBvYnRhaW5lZCBiZWZvcmUgaXQgZ29lcyB1cHN0cmVhbT8g
IE91ciBwcm9jZXNzIGhlcmUgaXMgcHJldHR5IHNpbWlsYXIgdG8gd2FpdGluZyBmb3IgYW5zd2Vy
cyB0byBtZXNzYWdlcyBpbiBib3R0bGVzLiAgV2UgY29uc2lzdGVudGx5IGxlYXZlIGl0IGltcGxp
Y2l0IGFuZCBwb29ybHkgZGVmaW5lZC4NCg0KKiBXaGF0IHdvcmsgaXMgbGVmdCBiZWZvcmUgaXQg
Y2FuIGdvIHVwc3RyZWFtPyAgT3VyIHByb2Nlc3MgY291bGQgYmUgZWZmZWN0aXZlbHkgbW9kZWxl
ZCBieSBwb3N0aXQgbm90ZXMgb24gb25lIHBlcnNvbidzIG1vbml0b3IsIHdoaWNoIHRoZXkgbWF5
IG9yIG1heSBub3Qgc2hhcmUgd2l0aCB0aGUgZ3JvdXAuICBBbHNvLCBzaW5jZSB3ZSBkb24ndCBo
YXZlIGFncmVlbWVudCBvbiB3aGljaCBhY2tzIGFyZSByZXF1aXJlZCwgdGhlcmUncyBubyB3YXkg
dG8gaGF2ZSBhbnkgY2VydGFpbnR5IGFib3V0IHdoYXQgd29yayBpcyBsZWZ0LiAgSXQgbGVhdmVz
IGF1dGhvcnMgZmVlbGluZyBkZXJhaWxlZCB3aGVuIGRpc2N1c3Npb24gc2hpZnRzIGFuZCByZXZp
ZXdlcnMgZmVlbGluZyBmcnVzdHJhdGVkIGFuZCBpZ25vcmVkLg0KDQoqIEhvdyBkbyB3ZSBkaXZp
ZGUgdXAgdGhlIGxvbmcgdGVybSBmdXR1cmUgZGlyZWN0aW9uIGludG8gaW5kaXZpZHVhbCBzdGVw
cyB0aGF0IHdlIGNhbiBtZXJnZT8gIFRoaXMgYWxzbyBnb2VzIGJhY2sgdG8gY29uc2Vuc3VzIG9u
IHRoZSBkZXNpZ24uICBXZSBjYW4ndCBkZWNpZGUgd2hpY2ggcGFydHMgYXJlIGdvaW5nIHRvIGdl
dCBsYXllcmVkIGluIGZ1dHVyZSBtZXJnZSB3aW5kb3dzIHVudGlsIHdlIGtub3cgaWYgd2UncmUg
YnVpbGRpbmcgYSBjYXIgb3IgYSBiYW5hbmEgc3RhbmQuDQoNCiogV2hhdCB0ZXN0cyB3aWxsIHdl
IHVzZSB0byB2YWxpZGF0ZSBpdCBhbGw/ICBXb3JrIHRoaXMgc3ByZWFkIG91dCBpcyB0b28gYmln
IGZvciBvbmUgZGV2ZWxvcGVyIHRvIHRlc3QgYWxvbmUuICBXZSBuZWVkIHdheXMgZm9yIHBlb3Bs
ZSBzaWduIHVwIGFuZCBhZ3JlZSBvbiB3aGljaCB0ZXN0cy9iZW5jaG1hcmtzIHByb3ZpZGUgbWVh
bmluZ2Z1bCByZXN1bHRzLg0KDQpUaGUgZW5kIHJlc3VsdCBvZiBhbGwgb2YgdGhpcyBpcyB0aGF0
IG1pc3NpbmcgYSBtZXJnZSB3aW5kb3cgaXNuJ3QganVzdCBhYm91dCBhIHRpbWUgZGVsYXkuICBZ
b3UgYWRkIE4gbW9udGhzIG9mIHRvdGFsIHVuY2VydGFpbnR5LCB3aGVyZSBldmVyeSBuZXcgZW1h
aWwgY291bGQgcmVzdWx0IGluIGhhdmluZyB0byBzdGFydCBvdmVyIGZyb20gc2NyYXRjaC4gIFdp
bGx5J3MgZG8td2hhdGV2ZXItdGhlLWZ1Y2steW91LXdhbnQtSSdtLWdvaW5nLW9uLXZhY2F0aW9u
IGVtYWlsIGlzIHByb2JhYmx5IHRoZSBsZWFzdCBzdXJwcmlzaW5nIHBhcnQgb2YgdGhlIHdob2xl
IHRocmVhZC4NCg0KSW50ZXJuYWxseSwgd2UgdGVuZCB0byB1c2UgYSBzaW1wbGUgc2hhcmVkIGRv
Y3VtZW50IHRvIG5haWwgYWxsIG9mIHRoaXMgZG93bi4gIEEgdHdvIHBhZ2UgZ29vZ2xlIGRvYyBm
b3IgZm9saW9zIGNvdWxkIHByb2JhYmx5IGhhdmUgYXZvaWRlZCBhIGxvdCBvZiBwYWluIGhlcmUs
IGVzcGVjaWFsbHkgaWYgd2XigJlyZSBhYmxlIHRvIGFncmVlIG9uIHN0YWtlaG9sZGVycy4NCg0K
LWNocmlz
