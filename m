Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65B445B16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 21:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhKDUan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 16:30:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhKDUam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:30:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4KOA4x031595;
        Thu, 4 Nov 2021 20:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/rf85LAD8AfUvpv6n2IjAVhU4FG1lc52qUqvXt03bZc=;
 b=i9j8U1XqZDJdJeqI/vJ+ZBKjIOma6FdU2pkUqKQdM+M9geu8wmo9oogSTFTsGL/lBhvt
 qEVvR54ZRDDSYDKCVyqKSpNuuiBtB95WjRok47mmkVT6YOzt9aYNvxGlF9JhxLJdKmpJ
 Io7X2Y1S7tb1OBZmNITP9OsRkvHTj7naHxNB5Y9CpZX/veaSikV+uAs/t80ff5LgOZBD
 N6fgdg04z3kn9dGfu+JOtw4BvYOcISmIWVTQzIINAVd6hWgMbQJ20jXeI68s34inzUqS
 /ZY8pcDwfz/8zzqp0wyGGONtUUTjQk8BxAlllP5lqlUPFfGVSw5cLD6E0GwEvGEfgBfU dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n9xtyqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 20:27:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4KC0R6014475;
        Thu, 4 Nov 2021 20:27:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 3c3pg0r092-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 20:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdRdhOxjyrYUjaKipDvuil0GpsvbbsesRsKSbLH/sLdaCaRc5vNSUpj1uXtZMnEh3X550o2NVm3fccRRnoSdtDVE7lYyqZgJnnLhn/yQf7917CW8Ag3B8ih086ZJ0uXCqcuLTQTiZS1J8L59pbRp/L0zPk14oFaxPL5zcE7XOwtd/Jie6zR4D6GHZpt/g0wtN+EGkF4/Vc13BuaIZEL3g35lXN97mO518tCZBnQIQcMqSldjrMAfhfsBOft19dxL/oTThAZzQ2N81h/bfI3kzZ+gSaJpgKuX4s0J3C246so8PSCuzuSzf7R+k1MsX3/zaMJRZ2zZtTElTxA2iNLK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rf85LAD8AfUvpv6n2IjAVhU4FG1lc52qUqvXt03bZc=;
 b=ZDm4SYfdH3D5kYjuaUt4kvR793csq8wcp1orw52mTDpfCiwhM/xLC3CUtDWu885Bc33UXfn2CA+GiwvgT+h/IQYyjudaP7Ori/f1fAZpxhZ7kcxhIqhU2AJ7BI7jV62eTwilAEw55s83OMFDxdQ42GnI/NZDjVIGlp/oRXnviBux0dHcO6LPBnQE1Wc3BSJkyhMkeYvbg1hKAnLbT80VMWZyLt4WXodICNCVKvqpUbCkNGnP4inpbwAi3CqkEWNjhxL9bP38o0dmwiOZ3D88D1Qydz4sem7qnTEMlIx1hWQ8c/Ruq0psnhhqVXajlxGZqIe4nP0e0HNG6z9yXjiMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rf85LAD8AfUvpv6n2IjAVhU4FG1lc52qUqvXt03bZc=;
 b=AZejhZ1bqNnawUqcCR5c3nSEK76UuXbDoaAFebkeP7/JWiSxAUSRJY7j0loW87INIDMy09FessnXXu6rGlZpU0EwOnfwr3hhYBj/nmsmPMdyXBpNR3FzSo3oZH2omL6+3vIsWtJzOtLXWlsut+mTEXdX0diQJc3jFfD0JqPDKqs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3512.namprd10.prod.outlook.com (2603:10b6:a03:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 4 Nov
 2021 20:27:53 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 20:27:53 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/3] libnvdimm/pmem: Provide pmem_dax_clear_poison for dax
 operation
Thread-Topic: [PATCH 3/3] libnvdimm/pmem: Provide pmem_dax_clear_poison for
 dax operation
Thread-Index: AQHXqcDCsCz3V+aRDkS3vMhvnM0qfKvz9ryAgAAqpYA=
Date:   Thu, 4 Nov 2021 20:27:53 +0000
Message-ID: <171156dd-34fb-1c49-7c75-3b6bb5dc5717@oracle.com>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <20210914233132.3680546-5-jane.chu@oracle.com>
 <YYQegz3nPmbavQtK@infradead.org>
In-Reply-To: <YYQegz3nPmbavQtK@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d6a694f-3da0-4527-90be-08d99fd1948c
x-ms-traffictypediagnostic: BYAPR10MB3512:
x-microsoft-antispam-prvs: <BYAPR10MB351276F364138EB0F438398DF38D9@BYAPR10MB3512.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIFtc5LVQSYbm4ic0rokKsTDrptOjFLRwnGKYSW0O1gHYaEg+wGhpqhZXEvoS2ftx/EucpFrZc969Uz/1diqIBhQ/ulC170f0flo1HHlv7ZLvQQy+oT8BdVS1NbdWHxdGM/sZHXWGsY6JpZG6wHwBpoKCieLjYrR2DIRzKNZvgQ5kUDG992OzZQLZ1+5kUCPsxkkJfPcMRYpqcU0Vv4a1OrwmBr1wv+Tv9T+7ZI8I4OHbsGli1tCY596lfPWvItXFMb3qchK7A6P47QXJLCk3pRydopQwP4h9Ly5zuk3M9UfNyuJ/L0rPhjRJAs7/zLfcmL9xXcPoUlTuMX6ltFx+pF9DEkoIHF3BMlfkZGmaX+oK9B/rYf5AVf2di9ytPufd5pxcdYc3r9Lafdf1QxODu6j2VMjnwn2YSiIVN5IkTnj/I8YU7kKnH+tJMVlKv68Jhyhe89IQsUFMAlfnfnwOCUM6khpByEISxTnBJ61OLQtUdXboxEVkyfYnKXKLitvUWDcHVeTu4q7AwOsRuJfxb9T6akYNPXlnW96+D5uyE98vPoutpnlbPaaz/gDK1nmEwtuREpbQslfvcH/Hg4LVP7pWPp9/dup2726r1JW3iqE77081BTUYnmpzdDe5jojvQN0U4wK3aZ09V2rav0T8Vk9UlcjGpt1BBS2AMBQIT3ymo4wyESvgIJL9wNMJQlRZNqotF53pY/EaPSS02YYeHbF4ASNj+Dd2ZlNe+BYj/mH8gP3GeQBFiFBjPvRTRQo3Qmi+wKnZSJ7DZ3z4iOhpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(91956017)(76116006)(66556008)(4744005)(66946007)(6506007)(66476007)(186003)(316002)(2616005)(5660300002)(2906002)(31686004)(64756008)(66446008)(31696002)(7416002)(8936002)(6512007)(54906003)(71200400001)(26005)(44832011)(86362001)(4326008)(38070700005)(6916009)(8676002)(36756003)(6486002)(122000001)(508600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRaRFVmbmlFR1o3N2pLMDhWZTdabWVmU0ZZQnVEcUNCcmRGVDZLMGhVRkRG?=
 =?utf-8?B?MGdRaCs4YytrNDlOS2wvUXIvR2VMRDFMYzBRY0pSQzNxQnhvRnp0MVJCaVhp?=
 =?utf-8?B?ZmdyTEdsWWlZT015VGQvd09TeGczRkZYdG91K1MxNkpNYktGdVBMbkhkajlw?=
 =?utf-8?B?ZE5qaHhFK3ZucjdBQXZHWjBRdytBUm5LcmJ5UkNlQ2ZRNTVFeDBOVU9kekda?=
 =?utf-8?B?RnpJRU1UOXdUWXBiMzA2T1BFdFMwOXUwQ1JaeElUV05ReFFzS0d2TWR6c3d4?=
 =?utf-8?B?NU8vYy9xNGl3L2RLSUR2U3BhdDFmcGdMYVI0em8xZDdzWWxNbk51YjNvc00r?=
 =?utf-8?B?czcreCtKaW9DTnE0K0RHeVdLRGVmZU01eElyZW03cEo2dThpdy9qQXFFUGJx?=
 =?utf-8?B?SWlha1VMblZDNVFhYk9RbmtZNEJKU0x3RCsvUjZOdW9RUVJhbUl3bzZFVVl2?=
 =?utf-8?B?cVh4OFNDeHNkRldEbTRzV3ZjSThrMzM0UVRvQVdYT2xIV0JHcWlYbVZuREU1?=
 =?utf-8?B?cmZWcnlUZGl4Z1g4eW84ejhIT0VEYWQyRm9qRVdmaFluVmoyeGpiWHJKdWFo?=
 =?utf-8?B?OWpFUnltbVpiSnQ0SHE5ZVBtVzhLSHdxOERtcURueDVxKzQ2MEVsL0xUM2FL?=
 =?utf-8?B?RndwWXIwelZTZ1BQMFR6RlNjTTY3bzEyS210S1BLZEZ0N3RjMDRCQjVaRmpu?=
 =?utf-8?B?TUoxUSt2TzE3MlJ4d1NYa0dXSEpRRnZMcExOU05tUm13ZTZ3ZTVQTXRzL2N5?=
 =?utf-8?B?V1dDRkN4SUUxZU0wRElhNjRZQVRJc3oxSEg0dDYva0RCQ1RQdTJhT2twT1VL?=
 =?utf-8?B?YkRqRHpxaHZaaS9NSmhjZmc0SW5IbkpsVU1kQlN5dlhOeTZBdjd6TElaLzd5?=
 =?utf-8?B?M3lTaFF3cEQ0VkdvNmdWemJmdUl3UU9uL1RNelBBSi9QRjJJcURaRlR4Ujkx?=
 =?utf-8?B?QkxEVmNISnJMV2taTDIrNkpkYjQ0QVl6VkwwUHNneTJqYnNkZUwyYkxpdGJ6?=
 =?utf-8?B?QUlhVTNTUWg0OWZQU3Y5RDhtOWJJSjhROW9EVzd6Z1J0ejM4WjYvenlMZFpU?=
 =?utf-8?B?elFTRnFFNnVEVTlzMTNiZmdackhWdytpSVBmeWhVTnlEUW5DUFd6Ri9vNG0y?=
 =?utf-8?B?Qk5tQkxUcVp1ZHowYTdaNTFGN05CQUF4SFFXemIwY3N1czlHbkp1eWVCTDlU?=
 =?utf-8?B?NzAvM0twZ0hPV2lBemlxZWdEM0VnTFQrM2p3KzMzc3RIcUQyV1ZiNnNNVHc1?=
 =?utf-8?B?Yjk1WWxyaVNmRm9DenR5TjdVeEVhMnZCR3RBMXl1SUpYV1NYci8wT2lBWHhj?=
 =?utf-8?B?YTdHNGs0QTJBWWtlK1ZYb1JmeDVhQzNFR1ZVU0ZIcjZvc2t5QTl3Ym1JOHFu?=
 =?utf-8?B?eVdBV1FzZllsbDJnVHdXYVNoNHhYODk3bmhzWWVmNWY4ZVo5NTJPdFErRkVU?=
 =?utf-8?B?RFd2YjRUUG9FUm9LUTNTNmlYY1Q1ZUJJemdVT2xCTkNTYVh2NC9JdWZ4azA2?=
 =?utf-8?B?cFdGTGVJSE9mS1JjYUtGM0RycE9aVGpMUStyNmNleGxMdUVLN3VqZjBObk5o?=
 =?utf-8?B?a3hPNTNaZDFEYXh5dXczczB0Yi9vZUg5bE9LcDdUZTh2Ulg1d2cyeWUwTUZ3?=
 =?utf-8?B?RGlQUkJHZFozU1NKbWY5a0lISzVYWlk3eksvS0tYK1RnN0p0Z1k4cUpEQm5s?=
 =?utf-8?B?ejRHVXY5aXg4NlFlcTFsTVNtVkNTQTFGdWhxWVZod3J6YnluZHFGTGJhTmFu?=
 =?utf-8?B?WlgyTXp6eVdjV1o4cnpQeUN1c1dUcEVHaE1OV3JRcXF2STFtVXQ5RzRzVVd1?=
 =?utf-8?B?b2xocUVnUUNpYlk4K21RakIxK3pENFEwbGFrWGtwcVZReFFZWlZ6K3g3OGV3?=
 =?utf-8?B?S21rN0ZySTNMdnVkMXltQWk5NmJPREVaVExkakp0dEJ4UThGQjA3TSsvQW5V?=
 =?utf-8?B?MW83a3pFLzlBSmZYT0FlOEx4dm5IVFAzcytGdzlVL2dEbEVrNWg2N1VLZjJv?=
 =?utf-8?B?VjZhaTdqR2ZYS0xXSmZGSWxlV2xQSzJMTmsvd3BoSjBJaVRkWFpwNTAvMkV1?=
 =?utf-8?B?YWE1OGRwR2x0TDU5QVRsWnd0d3BhY1VjaFJKVXdKaHVGN01SUXJ5SHAwODNC?=
 =?utf-8?B?R3RjSURrbzUzb1JRNERJd3lTdDlDYUJ4T2J6RXRCb2o1YkIzWFdmc2RDNWl6?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C1AF43EDA1F0A48843F95ECD3E73E4A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a694f-3da0-4527-90be-08d99fd1948c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 20:27:53.8339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVY9Vn2t0/PowkBJYQXhATotUBqBs/84j3do4INTTKhbQaV47svsII7zufD4TCUPT5Qiy4xnnvMMn98rxDtCRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3512
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040079
X-Proofpoint-ORIG-GUID: -yIpDUarf9x6oBrMibM3_p1mQfHMLQnu
X-Proofpoint-GUID: -yIpDUarf9x6oBrMibM3_p1mQfHMLQnu
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNC8yMDIxIDEwOjU1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVl
LCBTZXAgMTQsIDIwMjEgYXQgMDU6MzE6MzJQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiAr
c3RhdGljIGludCBwbWVtX2RheF9jbGVhcl9wb2lzb24oc3RydWN0IGRheF9kZXZpY2UgKmRheF9k
ZXYsIHBnb2ZmX3QgcGdvZmYsDQo+PiArCQkJCQlzaXplX3QgbnJfcGFnZXMpDQo+PiArew0KPj4g
Kwl1bnNpZ25lZCBpbnQgbGVuID0gUEZOX1BIWVMobnJfcGFnZXMpOw0KPj4gKwlzZWN0b3JfdCBz
ZWN0b3IgPSBQRk5fUEhZUyhwZ29mZikgPj4gU0VDVE9SX1NISUZUOw0KPj4gKwlzdHJ1Y3QgcG1l
bV9kZXZpY2UgKnBtZW0gPSBkYXhfZ2V0X3ByaXZhdGUoZGF4X2Rldik7DQo+PiArCXBoeXNfYWRk
cl90IHBtZW1fb2ZmID0gc2VjdG9yICogNTEyICsgcG1lbS0+ZGF0YV9vZmZzZXQ7DQo+PiArCWJs
a19zdGF0dXNfdCByZXQ7DQo+PiArDQo+PiArCWlmICghaXNfYmFkX3BtZW0oJnBtZW0tPmJiLCBz
ZWN0b3IsIGxlbikpDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsNCj4+ICsJcmV0ID0gcG1lbV9jbGVh
cl9wb2lzb24ocG1lbSwgcG1lbV9vZmYsIGxlbik7DQo+PiArCXJldHVybiAocmV0ID09IEJMS19T
VFNfT0spID8gMCA6IC1FSU87DQo+IA0KPiBObyBuZWVkIGZvciB0aGUgYnJhY2VzIGhlcmUgKGFu
ZCBJJ2QgcHJlZmVyIGEgZ29vZCBvbGQgaWYgYW55d2F5KS4NCj4gDQo+IE90aGVyd2lzZSBsb29r
cyBnb29kOg0KPiANCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
Pg0KPiANCg0KVGhhbmtzIGEgbG90ISAgSSdsbCBrZWVwIGluIG1pbmQgeW91ciBjb21tZW50cy4N
Cg0KLWphbmUNCg==
