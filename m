Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAA40EBC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhIPUji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 16:39:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbhIPUjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:39:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFgv59028973;
        Thu, 16 Sep 2021 13:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EBC6Q39vf8SvuaWi+s2fE6hVQTHQaJQeUd+8z7xLG6E=;
 b=HLbAFPCowu6ml/TtbqzPCAqLgJBkBjKusOJV/rfux8XaSU0i5htdrq3iFN2himKmPj+y
 ++fKeF7FBjwXNxVpUDr/RPIgUX4apblymy48XOLupTjdg8dzrWJ/zF4nr97UFTjSxhyI
 /KngEMPz1ane325L62gBAeLiNLa0/ELNzuw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3qg181sq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 13:38:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 13:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsUd+Hu5FUq14FtENorko4ybLQjfvuSSaLQL7FLdNrrXjANEhSVqvWvIg1UZ7UBfbfiyHS2cnXurPLYq8Sszc7WxM985nEKUvlfOIKAStHY2OcCy62j9uM+lwuHH7TkEQkBsGUF6Fy8tcEdmrtG+IAsmKoJFezeeBkuNDat2Yspq/j7fN11u8+h4RpIKgtKjQSkSkgtSiCH+lH96IqYEMbOIlZXtYucMe3zfCmnEyCcr1trAYsnpijvP/qK/PgDk4DEBt+E0ArM2714jUSaeEZLDUAuieoE4x3AchsTVK4OI/RRYBY0tV+ngaRBpZfNCKd/yYDlQMacZV2bX9dqrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EBC6Q39vf8SvuaWi+s2fE6hVQTHQaJQeUd+8z7xLG6E=;
 b=T4kibdg5LE8AGiwstncDxoKLwtepJROL/5owRE8yW3ybV391mrWEMXXl5+bCAueZGxeMfm3c8Cp0wlrLaSA92q9fvs8oF/eKWfKEmY1KXOI3bkkS4KMgPdWK2Y1k3xvDsidzcepdgQTp+b81JuJyZ+JLabuUz1mkJZjeQRWVOYW6OOcKc9JPiJQU16qo4Hg0sFUa57sGPOca329VYninbHlf4cxaw7Z12kWQanJuUkSXOfJKwx+VRQqIgKdCEKLDWMjIQrsiPh2gsrkGWH6PFOnDjgtI4kl/eW94Mcc7mefyHLtYHlXT5fjhck7krdQmbMNS0cr2UuuRfuMlTxjvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4924.namprd15.prod.outlook.com (2603:10b6:303:e3::16)
 by MW3PR15MB3820.namprd15.prod.outlook.com (2603:10b6:303:4c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 20:38:13 +0000
Received: from CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb]) by CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 20:38:13 +0000
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
Thread-Index: AQHXqlkZYMl5M/taiEScAPg40L4dIqulY1sAgAAErQCAAAXjAIAACWeAgAFowYCAAAb4gIAAOcsA
Date:   Thu, 16 Sep 2021 20:38:13 +0000
Message-ID: <261D65D8-7273-4884-BD01-2BF8331F4034@fb.com>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
In-Reply-To: <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 466a6c36-7d26-42b3-e200-08d97951e798
x-ms-traffictypediagnostic: MW3PR15MB3820:
x-microsoft-antispam-prvs: <MW3PR15MB3820652C1633C9E521D753EED3DC9@MW3PR15MB3820.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:170;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b05VdWeGUqfBivvFZZ/s0gL9ySjHubI2OibGnjVW3T7m8cuWu/VEJ3fvlW2KgOfqIH/wZesISoaYomDCVvg2PVs31XKl2QCMwH2VN0q7jJjmYlfDfAR82Wekj2YvauDJ3NRpaqk6mt9mhxVTi41Y5NYT/nokOde4QDj/3Tdfkcw9kOB3biKa8pP61IWzuwhuRV0AfjSeuV2kBzRuN7KaWnJZNKHi+grdcu33RJn+6Rdg4Rq3xgc8TqphLed5rmYSQu+O8buea28LrhUIXLS8VWX0gz/LncqHp1GvrVNDu9u5RqRLprr2qGlVFk0XjoKwg1M96Z10U1xyuXmJjxcepd9xWzKoL4M1PrsgI8URmMlopPIPfeZZD2hBYyK0PlOpIZOZY1IUYeEe7ca4wLwYTimP7RxW9e9j5tArPzDCoCI+dk9CJqwRxI6dFE7MKKrWYC1+dEezWMdLdYN9ekfJMfl7DM0eh7EPBXGPVp1/of1Vt3z+jn499wlXK4TgBM0BvE8XpSrkk6RPMH8uGTSHTsIJvL7Bas9dJUAXS5p79h4E/4ixW1TNIOhKNxhguA1yXHqkxpMIBNSwUWnCR6kLp+/nrE4qte4xED8xmigKMLBnAii+GHY5X4dz9sczPRe462eBXudhlUIb2dsf/kZ+yUFnShj5RUOnNg3MhGpmnFi1cyV71lgXR2w0+2C1kj9HhN1Brpc7KIBJpnnVZKqANPf60+IfMgv4X1MZq3CjpgAQ0MMIHovsMNa+lzhYrZzS9ep/KCv78o11ksCbR1JMRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4924.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(8936002)(71200400001)(8676002)(478600001)(6512007)(6486002)(91956017)(76116006)(4326008)(7416002)(2906002)(38070700005)(33656002)(64756008)(66476007)(66946007)(186003)(6506007)(5660300002)(53546011)(83380400001)(54906003)(2616005)(316002)(38100700002)(6916009)(122000001)(36756003)(86362001)(66556008)(66446008)(556444004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dng3Z0xUVHFYNTJmbXJSWGhuSDlVdzdJakxoY0hMcGM5d1kyU0ZveEpJTXRl?=
 =?utf-8?B?TUJKNmIzSXpqbUl5TXlSbkpvSVFKV2l1MHBYU1B3VW9pUFBybm5OZmdsTENv?=
 =?utf-8?B?N0lXckxNdTFyc1VmQXg5NEc5bERsQTR4NjBPbDJIK05NTVdlQzJCRkk1WDVm?=
 =?utf-8?B?NlJ6R1lhNFRpV0twUEtjdWZjaEUrMmRYQ3BaRXdGcCt4cTR1cEpKM21GMFJB?=
 =?utf-8?B?MmNVTXN0WTIwb245Nm5IYlgwYVd5S04zaTdLT0RlV0RraHN0U05lUGJaWW9l?=
 =?utf-8?B?SlBjT1JIQVd5ZFJURk1BQmZQVjEzdGF5SGV3VUVMZThaNHcwbnhoWENrRExi?=
 =?utf-8?B?U0R6eXh5TWFGQkJzMEhwTEMvQVRwNlpRUzBwQmNXTUFmTFptYlVOSVVHcFl1?=
 =?utf-8?B?dG9DK2gyWW5WNWM2aHJFYXlDbnNqZmRBVm84YWFiVUtBUyt1K2VBYmdqM0xL?=
 =?utf-8?B?Z2phTEhSaDhiOTAvQTZxZ29nb2xOZkN6T29kUUMrMWJ5NmcwbHBacktlVkJJ?=
 =?utf-8?B?ckR0d3JpSEl2WnRrR2NNOWZweHg1ang1a2JKSWVYVVhFL1hlVXpFQi92clUz?=
 =?utf-8?B?SUt2cENEL05yTXpqM1hXdmRCVGd4VDhadjJiZVIrelBtM3VPYXdQMndEYkdl?=
 =?utf-8?B?MnhtYlFHTDNoNVJDelMrREdZQjFMUG5sd1htS2V1MHoycU9CSHJtcWdtQkx2?=
 =?utf-8?B?Zm40QlhNZXJ4ODUzV0k0WUVqZEpza29IYVlpRS9Zd1J3bWhFelpjMnRYVHo3?=
 =?utf-8?B?bURBWDNsSE1idU9YU00xK3hMamlYUWZWbmxnZ2tLLzZZeE9BTlRZeWYrb2pk?=
 =?utf-8?B?a3c3aTlxMUtKOCtvZnF3Y2N2amlDWVBJN3FEOHB3UExmYnQyUDFFc2hEdGRa?=
 =?utf-8?B?RmhOZTdHNElsQ0RMNTg3bFBFTFJRRkI1Tm4zZVVhdTNveDVtdXM0STd6eDZX?=
 =?utf-8?B?SmVnZ1JXbll1NSs4a213WWltWnd6VGRhK1hXUHVrNWtJc2xoaWFOQ2RtT0g1?=
 =?utf-8?B?endnai9FczBaRDFWNFZSQWlDVlFRb3FEelRBb2lvcUZjMGJnSXlTUmVUTHpl?=
 =?utf-8?B?WkFhYXhVZy9hWStPRzBmdkJIS3NuTmpiOFNxaDlVNE40VGhMKzdaWFY4Q1Vo?=
 =?utf-8?B?UldydEkzeHhiZnhwaTZyWFJkR2tFaGZqc0tOOE9HaHJlME5TcmtMdVFuTkFI?=
 =?utf-8?B?aDZNVjNsZjlKNkVUdVpJUk03Q3dRdzVRdXpkaWJ2VUl1TFFmNDV4bm1YSzRz?=
 =?utf-8?B?cGU2SklLZytTUktDZGxRRDdHdmJXaktnMlJVUFhaMVAwWmQ2YzhscUhFdEVl?=
 =?utf-8?B?aTZFTnJtNnY5MHRudG90MEs1WWpleG5vWDZ6QTdYYnFGZnVha3dCc3ZyZ2Zv?=
 =?utf-8?B?RW5hRjJrcVRieERjamtiZDV0U3piSXdHT05vdVZ1ZkU2RFZ2V1NndFdPSnRa?=
 =?utf-8?B?Nm5HT3l5YWVpeVoyWERhSmhCSXZuNkRQSWRpdkJnQ0hGRHJDdjNURitqSTdY?=
 =?utf-8?B?bDBOdDVoV2kwRmJoWlRyOEFkSEQwaVgwYzZlNi9LYjZSVDBvSzB5ZUtmMVRS?=
 =?utf-8?B?TWtIbkNER2FCek5XL1diUHh5aHVYaEVlTTdVdFVIVC9td0FyOHBGUVRuSlJO?=
 =?utf-8?B?WEZLTjVsdTg2cnJjU0tPbDFqUnYvaDgyTDIxZUo3MGtBaUgzRE9OdWNKWDlX?=
 =?utf-8?B?dUsxc01qcDM3QTlsdEtHM0hZeVJ0NFBDWXVQaE5SUmhHeUY4Q2NyMWZvdllK?=
 =?utf-8?B?c3NJYjZYbDNOUEpCOEF3UWZFTkJZNk9idlBoQlZRSlpuNGtyaWNDem5KaHN3?=
 =?utf-8?Q?zAiMoJkl8akCptF3Trd6Ie0xC1r0le0iKZbTc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A374CBEA37F349AA39E2C871D6C99A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4924.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466a6c36-7d26-42b3-e200-08d97951e798
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 20:38:13.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxjUK2f2OyQ9Jy7TC95yS/f2dEV3gAFS5uBS1SEdqbEKMZgpm/5UCmfw6z6PR/kQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3820
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: rDEzB3E1XIbmzFQcvNOtWbuGCKtRgX-P
X-Proofpoint-GUID: rDEzB3E1XIbmzFQcvNOtWbuGCKtRgX-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_06,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gU2VwIDE2LCAyMDIxLCBhdCAxOjExIFBNLCBKYW1lcyBCb3R0b21sZXkgPEphbWVz
LkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAy
MDIxLTA5LTE2IGF0IDE2OjQ2ICswMDAwLCBDaHJpcyBNYXNvbiB3cm90ZToNCj4+IA0KPj4gV2l0
aCBmb2xpb3MsIHdlIGRvbid0IGhhdmUgZ2VuZXJhbCBjb25zZW5zdXMgb246DQo+PiANCj4+ICog
V2hpY2ggcHJvYmxlbXMgYXJlIGJlaW5nIHNvbHZlZD8gIEtlbnQncyB3cml0ZXVwIG1ha2VzIGl0
IHByZXR0eQ0KPj4gY2xlYXIgZmlsZXN5c3RlbXMgYW5kIG1lbW9yeSBtYW5hZ2VtZW50IGRldmVs
b3BlcnMgaGF2ZSBkaXZlcmdpbmcNCj4+IG9waW5pb25zIG9uIHRoaXMuICBPdXIgcHJvY2VzcyBp
biBnZW5lcmFsIGlzIHRvIHB1dCB0aGlzIGludG8gcGF0Y2gNCj4+IDAuICBJdCBtb3N0bHkgd29y
a3MsIGJ1dCB0aGVyZSdzIGFuIGludGVybWVkaWF0ZSBzdGVwIGJldHdlZW4gcGF0Y2ggMA0KPj4g
YW5kIHRoZSBmdWxsIGx3biBhcnRpY2xlIHRoYXQgd291bGQgYmUgcmVhbGx5IG5pY2UgdG8gaGF2
ZS4NCj4gDQo+IEkgYWdyZWUgaGVyZSAuLi4gYnV0IHByb2JsZW0gZGVmaW5pdGlvbiBpcyBzdXBw
b3NlZCB0byBiZSB0aGUgam9iIG9mDQo+IHRoZSBzdWJtaXR0ZXIgYW5kIGZ1bGx5IGxhaWQgb3V0
IGluIHRoZSBjb3ZlciBsZXR0ZXIuDQo+IA0KPj4gKiBXaG8gaXMgcmVzcG9uc2libGUgZm9yIGFj
Y2VwdGluZyB0aGUgZGVzaWduLCBhbmQgd2hpY2ggYWNrcyBtdXN0IGJlDQo+PiBvYnRhaW5lZCBi
ZWZvcmUgaXQgZ29lcyB1cHN0cmVhbT8gIE91ciBwcm9jZXNzIGhlcmUgaXMgcHJldHR5IHNpbWls
YXINCj4+IHRvIHdhaXRpbmcgZm9yIGFuc3dlcnMgdG8gbWVzc2FnZXMgaW4gYm90dGxlcy4gIFdl
IGNvbnNpc3RlbnRseSBsZWF2ZQ0KPj4gaXQgaW1wbGljaXQgYW5kIHBvb3JseSBkZWZpbmVkLg0K
PiANCj4gTXkgYW5zd2VyIHRvIHRoaXMgd291bGQgYmUgdGhlIHNhbWUgbGlzdCBvZiBwZW9wbGUg
d2hvJ2QgYmUgcmVzcG9uc2libGUNCj4gZm9yIGFjaydpbmcgdGhlIHBhdGNoZXMuICBIb3dldmVy
LCB3ZSdyZSBhbHdheXMgdmVyeSByZWx1Y3RhbnQgdG8gYWNrDQo+IGRlc2lnbnMgaW4gY2FzZSBw
ZW9wbGUgZG9uJ3QgbGlrZSB0aGUgbG9vayBvZiB0aGUgY29kZSB3aGVuIGl0IGFwcGVhcnMNCj4g
YW5kIGRvbid0IHdhbnQgdG8gYmUgYm91bmQgYnkgdGhlIGFjayBvbiB0aGUgZGVzaWduLiAgSSB0
aGluayB3ZSBjYW4NCj4gZ2V0IGFyb3VuZCB0aGlzIGJ5IG1ha2luZyBpdCBjbGVhciB0aGF0IGRl
c2lnbiBhY2tzIGFyZSBlcXVpdmFsZW50IHRvDQo+ICJUaGlzIHNvdW5kcyBPSyBidXQgSSB3b24n
dCBrbm93IGZvciBkZWZpbml0ZSB1bnRpbCBJIHNlZSB0aGUgY29kZSINCj4gDQo+PiAqIFdoYXQg
d29yayBpcyBsZWZ0IGJlZm9yZSBpdCBjYW4gZ28gdXBzdHJlYW0/ICBPdXIgcHJvY2VzcyBjb3Vs
ZCBiZQ0KPj4gZWZmZWN0aXZlbHkgbW9kZWxlZCBieSBwb3N0aXQgbm90ZXMgb24gb25lIHBlcnNv
bidzIG1vbml0b3IsIHdoaWNoDQo+PiB0aGV5IG1heSBvciBtYXkgbm90IHNoYXJlIHdpdGggdGhl
IGdyb3VwLiAgQWxzbywgc2luY2Ugd2UgZG9uJ3QgaGF2ZQ0KPj4gYWdyZWVtZW50IG9uIHdoaWNo
IGFja3MgYXJlIHJlcXVpcmVkLCB0aGVyZSdzIG5vIHdheSB0byBoYXZlIGFueQ0KPj4gY2VydGFp
bnR5IGFib3V0IHdoYXQgd29yayBpcyBsZWZ0LiAgSXQgbGVhdmVzIGF1dGhvcnMgZmVlbGluZw0K
Pj4gZGVyYWlsZWQgd2hlbiBkaXNjdXNzaW9uIHNoaWZ0cyBhbmQgcmV2aWV3ZXJzIGZlZWxpbmcg
ZnJ1c3RyYXRlZCBhbmQNCj4+IGlnbm9yZWQuDQo+IA0KPiBBY3R1YWxseSwgSSBkb24ndCBzZWUg
d2hvIHNob3VsZCBhY2sgYmVpbmcgYW4gdW5rbm93bi4gIFRoZSBNQUlOVEFJTkVSUw0KPiBmaWxl
IGNvdmVycyBtb3N0IG9mIHRoZSBrZXJuZWwgYW5kIGEgc2V0IG9mIHNjcmlwdHMgd2lsbCB0ZWxs
IHlvdSBiYXNlZA0KPiBvbiB5b3VyIGNvZGUgd2hvIHRoZSBtYWludGFpbmVycyBhcmUgLi4uIHRo
YXQgd291bGQgc2VlbSB0byBiZSB0aGUNCj4gZGVmaW5pdGl2ZSBhY2sgbGlzdC4NCg0KT25lIHJp
c2sgd2l0aCB0aGlzIHRocmVhZCBpcyBvdmVyLXBpdm90aW5nIG9uIGZvbGlvcy4gIEl04oCZcyBh
IGdyZWF0IGV4YW1wbGUgZXhhY3RseSBiZWNhdXNlIFdpbGx5IGlzIHNvIHdlbGwgZXN0YWJsaXNo
ZWQuICBJZiB0aGUgZGVmaW5pdGl2ZSBhY2sgbGlzdCBpcyBlYXN5LCBob3cgZG8gd2UgY29uc2lz
dGVudGx5IHNlZW0gdG8gbWVzcyBpdCB1cD8NCg0KUGFydCBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0
IHdlIGp1c3QgbGVhdmUgaXQgdW5zYWlkLiAgQW5kcmV3IGhhcyBhIGxpc3QgaW4gaGlzIGhlYWQg
b2YgYWNrcyBoZeKAmXMgd2FpdGluZyBmb3IsIGFuZCBXaWxseSBoYXMgYSBzbGlnaHRseSBkaWZm
ZXJlbnQgbGlzdCwgYW5kIExpbnVzIGFnYWluIGhhcyBhIHNsaWdodGx5IGRpZmZlcmVudCBsaXN0
LiAgDQoNCj4gDQo+IEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgdGhlIGFjayBsaXN0IGZvciBmZWF0
dXJlcyBjb3ZlcmluZyBsYXJnZSBhcmVhcw0KPiBpcyBsYXJnZSBhbmQgdGhlIHByb2JsZW1zIGNv
bWUgd2hlbiB0aGUgYWNrZXIncyBkb24ndCBhZ3JlZSAuLi4gc29tZQ0KPiBsaWtlIGl0LCBzb21l
IGRvbid0LiAgVGhlIG9ubHkgZGVhZGxvY2sgYnJlYWtpbmcgbWVjaGFuaXNtIHdlIGhhdmUgZm9y
DQo+IHRoaXMgaXMgZWl0aGVyIExpbnVzIHllbGxpbmcgYXQgZXZlcnlvbmUgb3Igc29tZXRoaW5n
IGhhcHBlbmluZyB0byBnZXQNCj4gZXZlcnlvbmUgaW50byBhbGlnbm1lbnQgKGxpa2UgYW4gTU0g
c3VtbWl0IG1lZXRpbmcpLiAgT3VyIGN1cnJlbnQgbW9kZWwNCj4gc2VlbXMgdG8gYmUgZXZlcnkg
YWNrZXIgaGFzIGEgZm9vdCBvbiB0aGUgYnJha2UsIHdoaWNoIG1lYW5zIGEgc2luZ2xlDQo+IG5h
Y2sgY2FuIGRlcmFpbCB0aGUgcHJvY2Vzcy4gIEl0IGdldHMgZXZlbiB3b3JzZSBpZiB5b3UgZ2V0
IGEgY291cGxlIG9mDQo+IG5hY2tzIGVhY2ggcmVxdWVzdGluZyBtdXR1YWxseSBjb25mbGljdGlu
ZyB0aGluZ3MuDQoNCkFncmVlIGhlcmUuICBNYWlsaW5nIGxpc3RzIG1ha2UgaXQgcmVhbGx5IGhh
cmQgdG8gZmlndXJlIG91dCB3aGVuIHRoZXNlIGNvbmZsaWN0cyBhcmUgcmVzb2x2ZWQsIHdoaWNo
IGlzIHdoeSBJIGxvdmUgdXNpbmcgZ29vZ2xlIGRvY3MgZm9yIHRoYXQgcGFydC4NCg0KPiANCj4g
V2UgYWxzbyBoYXZlIHRoaXMgb3RoZXIgcHJvYmxlbSBvZiBzdWJzeXN0ZW1zIG5vdCBiZWluZyBl
bnRpcmVseQ0KPiBjb2xsYWJvcmF0aXZlLiAgSWYgb25lIHN1YnN5c3RlbSByZWFsbHkgbGlrZXMg
aXQgYW5kIGFub3RoZXIgZG9lc24ndCwNCj4gdGhlcmUncyBhIGZlYXIgaW4gdGhlIG1haW50YWlu
ZXJzIG9mIHNpbXBseSBiZWluZyBvdmVycmlkZGVuIGJ5IHRoZQ0KPiBwdWxsIHJlcXVlc3QgZ29p
bmcgdGhyb3VnaCB0aGUgbGlraW5nIHN1YnN5c3RlbSdzIHRyZWUuICBUaGlzIGNvdWxkIGJlDQo+
IHNlZW4gYXMgYSBkZWFkbG9jayBicmVha2luZyBtZWNoYW5pc20sIGJ1dCBmZWFyIG9mIHRoaXMg
aGFwcGVuaW5nDQo+IGRyaXZlcyBvdmVycmVhY3Rpb25zLg0KDQpJIGRvIGFncmVlLCBidXQgSSB0
aGluayB0aGlzIHBhcnQgd2UgYWN0dWFsbHkgZ2V0IHJpZ2h0IG1vcmUgb2Z0ZW4gdGhhbiBub3Qu
ICBJdOKAmXMgb25lIG9mIHRob3NlIHBsYWNlcyB3aGVyZSB5b3UgdXN1YWxseSBzZWUgTGludXMg
dXNpbmcgaGlzIHBvd2VycyBmb3IgZ29vZC4NCg0KPiANCj4gV2UgY291bGQgZGVmaW5pdGVseSBk
byBhIGNsZWFyIGRlZmluaXRpb24gb2Ygd2hvIGlzIGFsbG93ZWQgdG8gbmFjayBhbmQNCj4gd2hl
biBjYW4gdGhhdCBiZSBvdmVycmlkZGVuLg0KPiANCj4+ICogSG93IGRvIHdlIGRpdmlkZSB1cCB0
aGUgbG9uZyB0ZXJtIGZ1dHVyZSBkaXJlY3Rpb24gaW50byBpbmRpdmlkdWFsDQo+PiBzdGVwcyB0
aGF0IHdlIGNhbiBtZXJnZT8gIFRoaXMgYWxzbyBnb2VzIGJhY2sgdG8gY29uc2Vuc3VzIG9uIHRo
ZQ0KPj4gZGVzaWduLiAgV2UgY2FuJ3QgZGVjaWRlIHdoaWNoIHBhcnRzIGFyZSBnb2luZyB0byBn
ZXQgbGF5ZXJlZCBpbg0KPj4gZnV0dXJlIG1lcmdlIHdpbmRvd3MgdW50aWwgd2Uga25vdyBpZiB3
ZSdyZSBidWlsZGluZyBhIGNhciBvciBhDQo+PiBiYW5hbmEgc3RhbmQuDQo+IA0KPiBUaGlzIGlz
IHVzdWFsIGZvciBhbGwgbGFyZ2UgcGF0Y2hlcywgdGhvdWdoLCBhbmQgdGhlIGF1dGhvciBnZXRz
IHRvDQo+IGRlc2lnbiB0aGlzLg0KDQpFeDogcGF0Y2hlcyB0cmlwcGluZyBvdmVyIHVucmVsYXRl
ZCBidXQgdXNlZnVsIGNsZWFudXBzIHRoYXQgZG9u4oCZdCBhY3R1YWxseSBoYXZlIHRvIGhhcHBl
biBmaXJzdCBidXQgZW5kIHVwIHJlcXVpcmVtZW50cyBmb3IgaW5jbHVzaW9uLiAgVGhlIGV4YW1w
bGVzIG1hdHRlciBsZXNzIHRoYW4gYSB3YXkgdG8gZG9jdW1lbnQgYWdyZWVtZW50IG9uIHJlcXVp
cmVtZW50cyBmb3IgaW5jbHVzaW9uLg0KDQo+IA0KPj4gKiBXaGF0IHRlc3RzIHdpbGwgd2UgdXNl
IHRvIHZhbGlkYXRlIGl0IGFsbD8gIFdvcmsgdGhpcyBzcHJlYWQgb3V0IGlzDQo+PiB0b28gYmln
IGZvciBvbmUgZGV2ZWxvcGVyIHRvIHRlc3QgYWxvbmUuICBXZSBuZWVkIHdheXMgZm9yIHBlb3Bs
ZQ0KPj4gc2lnbiB1cCBhbmQgYWdyZWUgb24gd2hpY2ggdGVzdHMvYmVuY2htYXJrcyBwcm92aWRl
IG1lYW5pbmdmdWwNCj4+IHJlc3VsdHMuDQo+IA0KPiBJbiBtb3N0IGxhcmdlIHBhdGNoZXMgSSd2
ZSB3b3JrZWQgb24sIHRoZSBtYWludGFpbmVycyByYWlzZSB3b3JyeSBhYm91dA0KPiB2YXJpb3Vz
IGFyZWFzICh1c3VhbGx5IHBlcmZvcm1hbmNlKSBhbmQgdGhlIGF1dGhvciBnZXRzIHRvIGRlc2ln
biB0ZXN0cw0KPiB0byB2YWxpZGF0ZSBvciBpbnZhbGlkYXRlIHRoZSBjb25jZXJuIC4uLiB3aGlj
aCBjYW4gYmVjb21lIHZlcnkgb3Blbg0KPiBlbmRlZCBpZiB0aGUgY29uY2VybiBpcyB2YWd1ZS4N
Cj4gDQo+PiBUaGUgZW5kIHJlc3VsdCBvZiBhbGwgb2YgdGhpcyBpcyB0aGF0IG1pc3NpbmcgYSBt
ZXJnZSB3aW5kb3cgaXNuJ3QNCj4+IGp1c3QgYWJvdXQgYSB0aW1lIGRlbGF5LiAgWW91IGFkZCBO
IG1vbnRocyBvZiB0b3RhbCB1bmNlcnRhaW50eSwNCj4+IHdoZXJlIGV2ZXJ5IG5ldyBlbWFpbCBj
b3VsZCByZXN1bHQgaW4gaGF2aW5nIHRvIHN0YXJ0IG92ZXIgZnJvbQ0KPj4gc2NyYXRjaC4gIFdp
bGx5J3MgZG8td2hhdGV2ZXItdGhlLWZ1Y2steW91LXdhbnQtSSdtLWdvaW5nLW9uLXZhY2F0aW9u
IA0KPj4gZW1haWwgaXMgcHJvYmFibHkgdGhlIGxlYXN0IHN1cnByaXNpbmcgcGFydCBvZiB0aGUg
d2hvbGUgdGhyZWFkLg0KPj4gDQo+PiBJbnRlcm5hbGx5LCB3ZSB0ZW5kIHRvIHVzZSBhIHNpbXBs
ZSBzaGFyZWQgZG9jdW1lbnQgdG8gbmFpbCBhbGwgb2YNCj4+IHRoaXMgZG93bi4gIEEgdHdvIHBh
Z2UgZ29vZ2xlIGRvYyBmb3IgZm9saW9zIGNvdWxkIHByb2JhYmx5IGhhdmUNCj4+IGF2b2lkZWQg
YSBsb3Qgb2YgcGFpbiBoZXJlLCBlc3BlY2lhbGx5IGlmIHdl4oCZcmUgYWJsZSB0byBhZ3JlZSBv
bg0KPj4gc3Rha2Vob2xkZXJzLg0KPiANCj4gWW91IG1lYW4gbGlrZSBhIGNvdmVyIGxldHRlcj8g
IE9yIGRvIHlvdSBtZWFuIGEgbGl2aW5nIGRvY3VtZW50IHRoYXQNCj4gdGhlIGFja2VyJ3MgY291
bGQgY29tbWVudCBvbiBhbmQgYW1lbmQ/DQoNCkEgbGl2aW5nIGRvY3VtZW50IHdpdGggYSBzaW5n
bGUgc291cmNlIG9mIHRydXRoIG9uIGtleSBkZXNpZ24gcG9pbnRzLCB3b3JrIHJlbWFpbmluZywg
YW5kIHN0YWtlaG9sZGVycyB3aG8gYXJlIHJlc3BvbnNpYmxlIGZvciBhY2svbmFjayBkZWNpc2lv
bnMuICBCYXNpY2FsbHkgaWYgeW91IGRvbuKAmXQgaGF2ZSBlZGl0IHBlcm1pc3Npb25zIG9uIHRo
ZSBkb2N1bWVudCwgeW914oCZcmUgbm90IG9uZSBvZiB0aGUgcGVvcGxlIHRoYXQgY2FuIHNheSBu
by4NCg0KSWYgeW91IGRvIGhhdmUgZWRpdCBwZXJtaXNzaW9ucywgeW914oCZcmUgZXhwZWN0ZWQg
dG8gYmUgb24gYm9hcmQgd2l0aCB0aGUgb3ZlcmFsbCBnb2FsIGFuZCBoZWxwIHdvcmsgdGhyb3Vn
aCB0aGUgZGVzaWduL3ZhbGlkYXRpb24vY29kZS9ldGMgdW50aWwgeW914oCZcmUgcmVhZHkgdG8g
YWNrIGl0LCBvciB1bnRpbCBpdOKAmXMgY2xlYXIgdGhlIHdob2xlIHRoaW5nIGlzbuKAmXQgZ29p
bmcgdG8gd29yay4gIElmIHlvdSBmZWVsIHlvdSBuZWVkIHRvIGhhdmUgZWRpdCBwZXJtaXNzaW9u
cywgeW914oCZdmUgZ290IGEgZGVmaW5lZCBzZXQgb2YgcGVvcGxlIHRvIHRhbGsgd2l0aCBhYm91
dCBpdC4NCg0KSXQgY2Fu4oCZdCBjb21wbGV0ZWx5IHJlcGxhY2UgdGhlIG1haWxpbmcgbGlzdHMs
IGJ1dCBpdCBjYW4gdGFrZSBhIGxvdCBvZiB0aGUgYXJjaGVvbG9neSBvdXQgb2YgdW5kZXJzdGFu
ZGluZyBhIGdpdmVuIHBhdGNoIHNlcmllcyBhbmQgZmlndXJpbmcgb3V0IGlmIGl04oCZcyBhY3R1
YWxseSByZWFkeSB0byBnby4NCg0KLWNocmlzDQoNCg0KDQo=
