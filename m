Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7E436F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 02:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhJVAwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 20:52:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232469AbhJVAwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:52:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LNianW020528;
        Fri, 22 Oct 2021 00:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4FrvQtn8GtQ/wLSbZy0SHr0ehhs9xqXA0y/x2JCUQtQ=;
 b=GIpkURow71PRrq/LIEDALL8Xp4XRGC+9iqKeU9LFk2JujPw4KTTiQREmJiu9PIxqHZaJ
 x0KpuZh+J6PBr+KaQvSeQd4LPQ1Xwa98r/NNqsEiEbnwC7Bjguewg21eABcSCXJ7yih+
 NtYKDgzVGdYYkqcnvMzqhKV9o/6EVTsvP9LxoDuj38HHiKqUTtkhTho5lUGPTbKJAi1u
 z+y99PclHD/R4IjxMGjswsKfJKiLwii4KRavP+Y7UmmvgiiaBprJ1EucQLc/bWhby/SR
 Pt1//h62PTRUaTP450O2aQU0daiXzsjopdsOaHZOAWcurPx1EIL6wfh/178Wrb6AYth8 fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw51bqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 00:49:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19M0exN0071304;
        Fri, 22 Oct 2021 00:49:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 3bqmsk3r22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 00:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3IKsMYYoE7Ja5rN8/avBSdFIT+BTXX9yclSJjjTdKCS3//JJbNZDqSbSMu8gGFFGkqnZcu/qrE0fJC+Pqxv8MrnMlBAi88c6YsjI6v8L2hjWhondGG9tDmdG9g0P+7wiNjwnPlMzk2we/RiJPDab2M8i7qVQglfDLlkoQ5+ZMhwqH1ZRdirS9tDOEa+IY8GhFP+8kGAgjlwIa3iBHAC5ADVOz1roHOhtaWmn4vX7kuPNPvIHYPtqNW41f2VVXjS+DPZxFme7KZ3xPpuNI5VfJJEk8BO2x+UvhqcGg2HQ+s5EaoRW2Rt44M5wfBB4G90+4sS4nfZAhBiqexj1+kOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FrvQtn8GtQ/wLSbZy0SHr0ehhs9xqXA0y/x2JCUQtQ=;
 b=QHaLxdRSGsUgRPpqBnYrP3vpOVOlxYzZyVgjEk12SCKpA2ZxiI9BYZRk7hIKQ8kMnaTI4j29cpcDGhcSB7N9SfpUZDipzb2O10axEvgm+kbSa2SsaZxUUShPrBK+eR5RfGNjY+WOciFcelFpRNxeWNxyrClXjwFY/GvQZ4mF1L9Wt0usLVp/cZjKCNG5B0JLoKuohzoq4z4l+CVPjKIOem703bAamyBdL3N1+FIdCg34rAouZHIR4Mx3F27kEYhvB4GJ1djtptI2WL+u5+l7TUpdbz140eGqJs6VP0f3bC8WhUnU5kfn8+TfKp60EhILJdZtlgPWtX4TIi+wqOs53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FrvQtn8GtQ/wLSbZy0SHr0ehhs9xqXA0y/x2JCUQtQ=;
 b=YYQRODGMEeyr5kVyuIg0gB2Mu/zsm0/o358iRlF9te6ecVgHZjpQIZvns4GX5r3xANV90Vtg/rct1nyd3ovlBePe4fi3XyvTXZjr3GpgfBEnDdAuR7V0UDn2WDAwAQ12XZubQLilEHYdi9KDZWIF/undnqyRk01J603KdtIV8Nc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5533.namprd10.prod.outlook.com (2603:10b6:a03:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 00:49:15 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 00:49:15 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 4/6] dm,dax,pmem: prepare dax_copy_to/from_iter() APIs
 with DAXDEV_F_RECOVERY
Thread-Topic: [PATCH 4/6] dm,dax,pmem: prepare dax_copy_to/from_iter() APIs
 with DAXDEV_F_RECOVERY
Thread-Index: AQHXxhA/migZDNV1a0+SBofbRrgPHKvdURMAgADgEIA=
Date:   Fri, 22 Oct 2021 00:49:15 +0000
Message-ID: <325baeaf-54f6-dea0-ed2b-6be5a2ec47db@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-5-jane.chu@oracle.com>
 <YXFOlKWUuwFUJxUZ@infradead.org>
In-Reply-To: <YXFOlKWUuwFUJxUZ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e3c56ff-f8e1-4445-5f5a-08d994f5c5a5
x-ms-traffictypediagnostic: SJ0PR10MB5533:
x-microsoft-antispam-prvs: <SJ0PR10MB5533B445904ED1BDA91A88BCF3809@SJ0PR10MB5533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQu4WxADlt8ZEsBF4C+BzSLiSpcRVOvMSfzfnzGDQXkICjijIFNS5vxpB0Esc6a8GwiT2M0ilBvsfVRoxyaU/FwN4BDUhqOPWoIN8FGUARkdbCfO2lcXjKpWvGtAGMmzXn+03+mHfbud7U+ObqCPMLY6nAdVJHw+GOdbBF7T2NN82/lnBglGa0tfmRqmpPXmx5iboRmNOl/WLfDUilV6nnf1Xp9QhrT3E56WPKSUOyK7tYGZeqeG0crOZPFXD1NW+K6HCiaExZPrIpQkxv/vkyIkYYEnjCIq0EEVG1ebjjMwgIvq7+hMnthn1tCCrMoocpJZF/IvORE0kYzcaBY0mNnSUOFzpRguDpNmPfXFZp8NMhAX4+CLz444rvOJQvD92vYU5XzFTrIKw6BCSKlTNmlnump5ImOrb9wimGHreyoOACiSrfbdIinXPfhjZ7hejuDU9yWKlJZDzacEtH5QASlppQTybuo05WwbLwaiMQn39xvtoMAvMpLUJMniptPc+0rmzhPqTFatq7t7+8UC6PbaQ9htvxgy69KRYkJq1jALEjKTz2XLkjnFBEXWhdciyAI5q1vOXCnOlnUa7WQPqNYcHZhpKaDpU2R2c1IaqtnTwVogiPylTBzzh285OXyTwTQ8vn6elQ1zTTzQXyAeOtH/x0Sak2AmDbGjOgutKpKZ9/dnnUGf/fmxxIzxy6JcvWjjpw93tLKTHTzZRcEej6JcQ5M0aG+1Wg/dcKu9+KW0ivH6Cfak1vgYbC8W+LaClG6sDknGUsyBk0oV1HPSKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(6506007)(4326008)(66446008)(66946007)(66476007)(53546011)(66556008)(71200400001)(186003)(6512007)(2616005)(26005)(122000001)(44832011)(508600001)(38100700002)(54906003)(6486002)(5660300002)(38070700005)(86362001)(83380400001)(316002)(2906002)(31696002)(8936002)(7416002)(31686004)(76116006)(6916009)(8676002)(36756003)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHUvNDVOMDd2WTcvR2lhNlJYdlJhT3dtdDg0YVZlU2hBK29MNXFmY0RJNGho?=
 =?utf-8?B?ZzN0bE1KTWFwcDZsQ2dSVDJBM2NXeUZmeGFJaFJNekR0THVTU05JcS9OU3dE?=
 =?utf-8?B?L0xpZWFrVHo4YW5SYUpCbld2cDhMdlBhcUVxU3pSbHRISDJTMFUrRERBZ0pl?=
 =?utf-8?B?aU5vNUdMYytBM1lUMEl5ay9IeklyOGRDWGZRTlhrL0dnN09FNThVbEtybkdl?=
 =?utf-8?B?NU5laFk3K0xla205L1NtWUc1alR2U3BjWkhrMlU3b0lRdkFIQjdGS0lSV1R5?=
 =?utf-8?B?OXJZa1RLQjBwZ2gySytLanNIN0hJYU9yVTVwaERoOXFsdTJvZDZmdnNGemtu?=
 =?utf-8?B?MmRHVzRqNzdacG1kN3hwa25VRDhaOHRtNCtVR25Camdoc0s1Nk00QlhYS1Jm?=
 =?utf-8?B?akRSdDVRVmhTV3NlbFFRNVNjUk93M0tpSHovbHFOby81ZHhWK0tIQ0I3Wkta?=
 =?utf-8?B?UWJ4UTR2L3BpVEpzWFRHdEloRHpUdVBvTG9tMWRjN2lQUU9yb1duVlZjeElo?=
 =?utf-8?B?RUIwS0JkL3RuWkkrNWxERU9Qc0xSWUc3M1FnSWRxR2lldExVTjVYWU5aRUln?=
 =?utf-8?B?SmtGU1NJSFNXMkFSWC9vdERObTBwSXdXMzR6b2pLTWJVa0NPTThLTW04dHNn?=
 =?utf-8?B?bHk3Q0J6ZTRWOE5DZ0tWSHZGWmRBVTN0UGliZHNRMWlSdzYzRGs1WCszOGRn?=
 =?utf-8?B?OHRaanRVeEY2cG9lYnlhZU1RajJ4di9LeDFydFk3S1hQSjRsQVFRVm01b1FJ?=
 =?utf-8?B?SlNPbGdRQ2hMQWNNWWUrZHo0YXNzWHdrbzVnWmM4MFhwVldkb2tmaXl2YjUx?=
 =?utf-8?B?YjNyM1JRcEp2cnJOR3R2YUJVQlpmbzRmS0xjdDJCRjJSb2Z6K29oNHBtSFdX?=
 =?utf-8?B?em9qbTdLQzgwUXg2SUNTS0dJOUVqWWIvcGlyZ1lCb1ZRSVFIclNTNDNaSzVM?=
 =?utf-8?B?L2pMQmEreUlzbmdRbGk5RlEvdy9rQlVYdjdUcUhML2NjZjdIMmIrK2NWTDNl?=
 =?utf-8?B?YlF6cnR2SUUvVXJCSStzTVZXbS9NSUFnZzdiemRxNzNLMnVRUEs1RndmckVk?=
 =?utf-8?B?d2RYYlcrSkxoWkhFRmFjaWJ2Rjd3QkxOczVESHJLM1BuSkNINU11aVdOc0lq?=
 =?utf-8?B?RHZoVEhERkFHQmhEb25semVUZlk4Nm5FU21DVTRob1dNRmovOTJmUzNpSjJT?=
 =?utf-8?B?bTNLRXV2RHZOQk5YS2htOXl5aVBubkhlQml1ODBHb0ZpcVY2NWswT04weDV1?=
 =?utf-8?B?QTV0QjUySGlhWFVmVEE3VVRveVoreUVGUjFUanAxYWNJYUUrQlVrZGZUTEFz?=
 =?utf-8?B?RXpLRlNLZ1NvV1lCbTQ5d2taTTYzYllSTmZ3a2NmK2NkS0I2dElWZHNaVFUy?=
 =?utf-8?B?eTFtQnFLYlRuY1pHWGFGS2lWd2RjRjdVODNTK3oyV0UySzBTbEk0Q1pocThC?=
 =?utf-8?B?SGtteitJZm5NcTRHWnBrZ2ZzSm1hS2twOHBUMzBzQjMzV0Z6cE1VYlgvQkdM?=
 =?utf-8?B?ZXAzMmhTNTMvN3UwWDh5UlMyUnNnaEdkNi9EZGtCcmIwQnhpdTI0VGlWMEIz?=
 =?utf-8?B?K1FpMzlzQkRDaGV6REIzajFlNVBjazh4WUpxSitUNC90Y3BKcHBkVnpmcDR0?=
 =?utf-8?B?VE9HYzhUSVR3UU80VnB2YkIwcE11T3FVYWp4UTlVTko0R29aTFk1d0Mrdnha?=
 =?utf-8?B?TDh3NGUyYXZObElBU2pMZklRMUxsNWY4bGwweUFmWUhUUXYybElIVVdSUVBO?=
 =?utf-8?B?M3hyZXpYdzNQQWxoQ05HQ0FRMXpzTVJZTHZaWjlMbWJFVHBXWVlHU1hicUhQ?=
 =?utf-8?B?UHlVUEpjV0NxQkQ0ZllQT1Z2RitGM25XYWh0ZFQwQ3BmdVRFVVh0MTN1MThp?=
 =?utf-8?B?VjcrY2NoaStyYzRPQTYxZXZQZXIzZWVoUm91UnpaMFVjcFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBB4DAE3B1312540A6CC5D9ED2B3A9D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c56ff-f8e1-4445-5f5a-08d994f5c5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 00:49:15.2318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5533
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220001
X-Proofpoint-GUID: WNg8BHml_komDAw90HNBEtKfjrAL9SxU
X-Proofpoint-ORIG-GUID: WNg8BHml_komDAw90HNBEtKfjrAL9SxU
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSA0OjI3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gV2Vk
LCBPY3QgMjAsIDIwMjEgYXQgMDY6MTA6NTdQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBQ
cmVwYXJlIGRheF9jb3B5X3RvL2Zyb21faXRlcigpIEFQSXMgd2l0aCBEQVhERVZfRl9SRUNPVkVS
WSBmbGFnDQo+PiBzdWNoIHRoYXQgd2hlbiB0aGUgZmxhZyBpcyBzZXQsIHRoZSB1bmRlcmx5aW5n
IGRyaXZlciBpbXBsZW1lbnRhdGlvbg0KPj4gb2YgdGhlIEFQSXMgbWF5IGRlYWwgd2l0aCBwb3Rl
bnRpYWwgcG9pc29uIGluIGEgZ2l2ZW4gYWRkcmVzcw0KPj4gcmFuZ2UgYW5kIHJlYWQgcGFydGlh
bCBkYXRhIG9yIHdyaXRlIGFmdGVyIGNsZWFyaW5nIHBvaXNvbi4NCj4gDQo+IEZZSSwgSSd2ZSBi
ZWVuIHdvbmRlcmluZyBmb3IgYSB3aGlsZSBpZiB3ZSBjb3VsZCBqdXN0IGtpbGwgb2ZmIHRoZXNl
DQo+IG1ldGhvZHMgZW50aXJlbHkuICBCYXNpY2FsbHkgdGhlIGRyaXZlciBpbnRlcmFjdGlvbiBj
b25zaXN0cyBvZiB0d28NCj4gcGFydHM6DQo+IA0KPiAgIGEpIHdldGhlciB0byB1c2UgdGhlIGZs
dXNoY2FjaGUvbWNzYWZlIHZhcmlhbnRzIG9mIHRoZSBnZW5lcmljIGhlbHBlcnMNCj4gICBiKSBh
Y3R1YWxseSBkb2luZyByZW1hcHBpbmcgZm9yIGRldmljZSBtYXBwZXINCj4gDQo+IHRvIG1lIGl0
IHNlZW1zIGxpa2Ugd2Ugc2hvdWxkIGhhbmRsZSBhKSB3aXRoIGZsYWdzIGluIGRheF9vcGVyYXRp
b25zLA0KPiBhbmQgb25seSBoYXZlIGEgcmVtYXAgY2FsbGJhY2sgZm9yIGRldmljZSBtYXBwZXIu
ICBUaGF0IHdheSB3ZSdkIGF2b2lkDQo+IHRoZSBpbmRpcmVjdCBjYWxscyBmb3IgdGhlIG5hdGl2
ZSBjYXNlLCBhbmQgYWxzbyBhdm9pZCB0b25zIG9mDQo+IGJvaWxlcnBsYXRlIGNvZGUuICAiZnV0
aGVyIGRlY291cGxlIERBWCBmcm9tIGJsb2NrIGRldmljZXMiIHNlcmllcw0KPiBhbHJlYWR5IG1h
c3NhZ2VzIHRoZSBkZXZpY2UgbWFwcGVyIGludG8gYSBmb3JtIHN1aXRhYmxlIGZvciBzdWNoDQo+
IGNhbGxiYWNrcy4NCj4gDQoNCkkndmUgbG9va2VkIHRocm91Z2ggeW91ciAiZnV0aGVyIGRlY291
cGxlIERBWCBmcm9tIGJsb2NrIGRldmljZXMiIHNlcmllcyANCmFuZCBsaWtlcyB0aGUgdXNlIG9m
IHhhcnJheSBpbiBwbGFjZSBvZiB0aGUgaG9zdCBoYXNoIGxpc3QuDQpXaGljaCB1cHN0cmVhbSB2
ZXJzaW9uIGlzIHRoZSBzZXJpZXMgYmFzZWQgdXBvbj8NCklmIGl0J3MgYmFzZWQgb24geW91ciBk
ZXZlbG9wbWVudCByZXBvLCBJJ2QgYmUgaGFwcHkgdG8gdGFrZSBhIGNsb25lDQphbmQgcmViYXNl
IG15IHBhdGNoZXMgb24geW91cnMgaWYgeW91IHByb3ZpZGUgYSBsaW5rLiBQbGVhc2UgbGV0IG1l
DQprbm93IHRoZSBiZXN0IHdheSB0byBjb29wZXJhdGUuDQoNClRoYXQgc2FpZCwgSSdtIHVuY2xl
YXIgYXQgd2hhdCB5b3UncmUgdHJ5aW5nIHRvIHN1Z2dlc3Qgd2l0aCByZXNwZWN0DQp0byB0aGUg
J0RBWERFVl9GX1JFQ09WRVJZJyBmbGFnLiAgVGhlIGZsYWcgY2FtZSBmcm9tIHVwcGVyIGRheC1m
cw0KY2FsbCBzdGFjayB0byB0aGUgZG0gdGFyZ2V0IGxheWVyLCBhbmQgdGhlIGRtIHRhcmdldHMg
YXJlIGVxdWlwcGVkDQp3aXRoIGhhbmRsaW5nIHBtZW0gZHJpdmVyIHNwZWNpZmljIHRhc2ssIHNv
IGl0IGFwcGVhcnMgdGhhdCB0aGUgZmxhZyANCndvdWxkIG5lZWQgdG8gYmUgcGFzc2VkIGRvd24g
dG8gdGhlIG5hdGl2ZSBwbWVtIGxheWVyLCByaWdodD8NCkFtIEkgdG90YWxseSBtaXNzaW5nIHlv
dXIgcG9pbnQ/DQoNCnRoYW5rcywNCi1qYW5lDQo=
