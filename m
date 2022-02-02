Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49F4A7A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 22:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347397AbiBBVVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 16:21:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11968 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347316AbiBBVVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:21:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwasE010090;
        Wed, 2 Feb 2022 21:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lK+MTrE7ZLhPhYRQV8Htnj0aE11/rlzcyw3EqGQ4XEg=;
 b=WSltyzaFrBo2BbQ5tNEyawcuUMVnwJ7AHU3tZ9Zp96VF/bsYw0uov3W8C1qU2vRN7Eaf
 73c4I8pZjn+VQM0S6HmeXtOaQV26rZIHZamlPyuBFJO+xeRiTte/9G6h2sfAAP0/mMhq
 Myq6hch3zBaFBW97WAAvSNafzmH2nai4S11CU3Dpc90ExL85nVf9xcrRPkgqt2VdKWii
 a9DUej2Ar2a+QRFmGv5Bbbzqy5H9rZbLcPoPfuja+1SK9lIfiDePHOkwshGXgFbjEMYE
 /DTLqvJUWvJtSvOYyUgrN4HZXAitrM8qji/ihFjVs2TXO6YWXskurwbmiUzsSvHHBpEp +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wf805-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:20:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212LBEFf056678;
        Wed, 2 Feb 2022 21:20:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3dvwd8yky8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBwu+NHNXTp9eCdLDgSZzkeKJDDjYMv2a3Ypf72xoKXwdpgg89UIWtCZN6bOrtl8zXv6XjBOLEvxbNAyxPui2ZoCUTVknTTtthvF+qgY5ZA+qEsfH8pWrqmjsF2iPGSINRgLPnzsNqUAfst30nxidoXGdERBwkhf8Deqi1h67WBpFQyUs8BaxDcklOQ+yWSAdhlRYsgkCOzmRxhBkaqe9/GvUQ4t83wp302Cx6OKUt0q/MhPussDlMzjDWjuUx6quwyEVot11kyzJaekzowcrG09XY5nnV+YxaRQBmulQAZwygPMu9oUgoNvQ+KriFdBr3VsyL6Pf4z+DQf/AypQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK+MTrE7ZLhPhYRQV8Htnj0aE11/rlzcyw3EqGQ4XEg=;
 b=dMvgFoTwJC7XPFDDfkVEc9iXN2sC4UI6Od9TVjWghkwcOtpRg/dAGHXbjvc4RRd9DX+gg4Dq7TU9S4ysZoxnC+Xwiw8Lsm5oiQAfnZDiMtvCEHuxqghDQUvkEa4ELP6iB6e+mCwVNnVuQthxZRsQGzJAM456nZR5wEFopUqOw9Qzy/ho7fE/sHFHssClhAOzjuEDwDLLZ4jWTAlY3dCX1FW+a/RHY8sBOL+PJtRO42PZd7tjrNJuXiLV1L+XN4UFnn4TH/fnzm0HGO7VaNSblwjCEM+aVK/54/NRYs1wdgIHcyqNPFLDQ5/QmM6Ty2ogYPxUatI70Je50sqOAtCHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK+MTrE7ZLhPhYRQV8Htnj0aE11/rlzcyw3EqGQ4XEg=;
 b=nXs93Pv+WnkB41SgR0GcE2i5mEoY1WWISEWay8XTt2Rx6YS7Ss7aRiaZAC6Cm2L36UY9ul+tQuqWCW1uZwtjju4RylCpeoaRI9DHW9VOuNuCvu7ovyz2x/9X0h7c37QBZXWg3yFJBul1oAGO7Uurx9H4gdwDmOfO7T5bu+pxbzM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB4069.namprd10.prod.outlook.com (2603:10b6:610:f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 21:20:36 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:20:36 +0000
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
Subject: Re: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYFI6GHFAsB7tXYk+ZNKUkZMvm/qyARncAgACF2oA=
Date:   Wed, 2 Feb 2022 21:20:36 +0000
Message-ID: <d0fecaaa-8613-92d2-716d-9d462dbd3888@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-2-jane.chu@oracle.com>
 <YfqFWjFcdJSwjRaU@infradead.org>
In-Reply-To: <YfqFWjFcdJSwjRaU@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e30a3f3-94ef-4a13-2ce1-08d9e691dac0
x-ms-traffictypediagnostic: CH2PR10MB4069:EE_
x-microsoft-antispam-prvs: <CH2PR10MB40699A5819058089A3A55A7AF3279@CH2PR10MB4069.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 374/tApiD9yJa8GfqghvmzKOEWSRDH1Q7TQUJcA96yIjbdvEya/41Vysp6kOxTJx0EFXgr8AD2ukSB5S6qn5pGJq+omZnYB3y/Eq8eAcPaYmgsBFDbTKOt9R+HNbdvaMlMDcZprDz7R4rLThScpQ1Rnb99uAXrITppP/kNaG3rAdB6EmytvSFsvF6NaiXSRLSK1q5dYiUp0ysh8BuDkbmkLiN1VNnt384bdAoC5IEv3jcnvyh4cC7toYFFUiJxgOK0sCiYIfGYiKxWHoHnNQ1MyQuQ2k+IRu7M3+pZ4r4W1/JlvwMZboa0uL5SnPz5vS6wTF1Wa5zmKsBDpkHcm8ChAklRBfE9i1/2YSG1qaba38MDNI0CPHhaFJ6H25cpCCJTHKdRMPqMYQp8QgXVCslHELFWwnkXb/XxqrMyBFNf8OQMV2WlwavqCbetnORiRbkVhJM7U4DBdrq52nhZAO+JNXbf54ojpUYvzBJ3UeW9BhXAmFVOu+suAoEmLzojhEQURTDlyG5nDly89U1g67ToeqXGC4BO2Rt5lCaIwTdKr2rsKwQB6FjZVtZ85edJ7MT+U/586VdscDHzbB9ZVMCb/4pkz3ANuEwDWXFDWM8IX2LYvMsH1MLvmB3JdNZ7h6P52QTkzp6DlKMMnWMb3eA2EYYkLtAnp9X73NP/1YvUMHWVW48FwnswbtdIjz7uYhGvwmmxtVuLsZcz6RolNGYNEQa1YhP+eiNJOKdPgOyBHFT8ZX3L4x8RC9mKXeT5MhB6YbosSPbzc8Th/uvANfLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(7416002)(6512007)(31686004)(54906003)(6916009)(122000001)(53546011)(316002)(6486002)(186003)(26005)(36756003)(5660300002)(8936002)(83380400001)(76116006)(66946007)(2906002)(66446008)(64756008)(91956017)(66556008)(66476007)(71200400001)(31696002)(86362001)(8676002)(4326008)(2616005)(38100700002)(6506007)(38070700005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFU2T1RLNXNUM2RCQ3oxOWhldnNTbjA3dzVwRzVNdXhQZk5RU3FXVWpERHhw?=
 =?utf-8?B?R2NjSDltaWlGNEdUUXloa3RKOEZnQ2FqVmlCQ0pPMUx2QlkxZWsrVml6aWZ6?=
 =?utf-8?B?ZmRna3o1VHNkUFZ4dzI5d3MybzhGQU0yZENxUFFoY1VZSXhubXBVcTRBK09y?=
 =?utf-8?B?emVmVjRubjJhOEVZcjdUNjY1Qzk3amJqdVI1OXgzSWxjRTZrS083Yys2MzlQ?=
 =?utf-8?B?cThVME0zczlXTCtTUFNHNjFUYUFYQzcxdHRoYk9Tc2FkeHZDTGY1UC9FaHRH?=
 =?utf-8?B?a3Q4TjZVdUk3aEZWOVEyRFlQNVlDN0hhSWticDFFY0tPQmZ2NXUwb09RdDJx?=
 =?utf-8?B?VmVBQTBEaUhRU3VobWZ1TDRFNG9iajZnZnFsM01KQm5SdUlGdGZYdjRyK0h5?=
 =?utf-8?B?b1lRNE1jUG1LZFhFMzlJOGNuYWUzeXNaSUc5YW1RWGtET1RJdHBHekRIQ1Yy?=
 =?utf-8?B?ZjFyTWhwQk1Hc2V1VG5FdnFmS2E0Mkt5WEcxaWFVRjhmeUZLRStPNnErOGdC?=
 =?utf-8?B?c1I0RGRQSEo0WGJUNXJGMnA5VTVsWnJ4ZWUxR2NzYnZzTEFmSWxmZGNpS0JV?=
 =?utf-8?B?c1hDWGkwejk3YndHZWFLeE1NcHh4N3JjRllhTDVzcGJQTnpZZ1Z3U2RzU085?=
 =?utf-8?B?b2F5bHNtV1R0U2xLaE84UFN0YmdsTHppN29vNW9oZ1lZRjRpbDI2bkpJakh2?=
 =?utf-8?B?SmV2UnM5Z0xLRFUvL1YrdVVWc241NlNyTUVNU2RpSk91aHhpZUpvWkJISFIr?=
 =?utf-8?B?aEtSZjhuWnMrQlF5UGlFN1BRV2NnZFY3NldRNm8yYUlVMHFRMzIzTUt1djZx?=
 =?utf-8?B?UFRCNUVCQjA4RVlKdVRtVzIxSDlXcVJPamcrSUFNTGNOWmpQYXJqWjV3VVA5?=
 =?utf-8?B?Vlo2c2t3dDNRVDZqbUtRL05SbWVvckFtaFZkbkJuWitqTVNnRjRsRklJQnhD?=
 =?utf-8?B?WHZUczlpaXh4NDVDOXFManNWeVpOVUh4Nms3SmxyVTRMN1lDRHo4VjBlSVhD?=
 =?utf-8?B?UERYcnRMU2FZMnVOd0FRL2t6cnNMMFdFUHVjMzJoY0NRakQwZjRsSFVDTFl0?=
 =?utf-8?B?bW9MR3FlWDlRN2RGWHhqUlRiSmlRTkk0VEVmSm03dGZjK1pQc3VOVFJhQmg3?=
 =?utf-8?B?S2NndFRnbC9GTGVEckNPOHduN2pVRHB4emlUYTRBVlIxU2FmaEJSQ09iUVBy?=
 =?utf-8?B?VEtIVWJqbFpDK0VPTFRXVFlVN05sU2RFTFNyenhBVkpzOTBvSmFHRVViVU0w?=
 =?utf-8?B?VTVPQ1cyRDg4NW4yWnpveElqWml6NzJCTmE0Wno2Y0QrNUp3Z1pXaVpMQ1Zr?=
 =?utf-8?B?Y1N1R0ZIVEVtR3VNTzg2cUpiYUVyNCt1a3lEa2FldzNyOFBFbFpPVnlNdXZj?=
 =?utf-8?B?OVFpbEF0RVBuZjQ5YVJ6THQzVDBKTnNHNVdLK3VVR3dGZEhIV0JNd21wSTky?=
 =?utf-8?B?L2x5Wmx2Y1R5cTNwd3ZtZHk1dFZwZW8vc1hjMEVtY1VZTWpnZ0hkL0xMVDJr?=
 =?utf-8?B?SlRYK2dUMmlUbWpOa0RuMXNIcnByUDltUHNLc0hieUdKcFhkQlJ2WGVqNUlv?=
 =?utf-8?B?SGZ1N2tDK2Y0emRBeUQ5YXJua2swZm1iTWZ4elEzQzZBY1g0WVBlY0FvUWo2?=
 =?utf-8?B?WkJQSEY2cW1ZUW10Y3RWRm1sY1Bsb1g1SXZlOVo1eURVN1IwK3lxcWxWam1k?=
 =?utf-8?B?NngzV1BrTlNXbTcvN3ZFYTF1ZW1QTDBEeGZaUEgwR1BzR00vR1FBZ25HTXo2?=
 =?utf-8?B?RUNRaHF0TzduN1Q1MVdQM1ZuUEt1Q2hUNWtmblpERk8rT0x4eTNxR2VER3NJ?=
 =?utf-8?B?blVyMzlDNEVVaVJpL3hpMk1VaUFoQUQrM0JNOXhKTWVOckRMTlpiUVV4TE5E?=
 =?utf-8?B?UHVnZVJRSE5KZ3laVlJtclFzVFVtdUEydFdWVTc0cWUzNm1IeWdINWpjZUpP?=
 =?utf-8?B?RXFTOTlSSHcyVnBNeE92Y3NqUE9DZkNVMFNEZWVrbHlRY2ZZUUk0QWJLSHJB?=
 =?utf-8?B?VXhRZkxFT2F1YUMyZ3h1a1kyOU54Wk4xdEVqbVcwdzBSdExsSk05VElLY2F5?=
 =?utf-8?B?c0l6SmZpOTBwTHBheXJNZ2FDc2ZvV3daazBjMXh5YWpwWFc3cEs4YStqMVpH?=
 =?utf-8?B?YzY0TTFvYlBtSzZQaTFYSG4yY1hNdkU3TzRoNU5VeEpEQndFdTlXZjVmcHJR?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56C7238B3E70A947AC40D5063A519DD5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30a3f3-94ef-4a13-2ce1-08d9e691dac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 21:20:36.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8n8EfiZTSrCBNWrYtqHne19HUufWCMCQ7QLZRmIR2GBlr+BcyYgBchwjSlRdorUROD/uHH/NAzw5mponlQbXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4069
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=777 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020116
X-Proofpoint-ORIG-GUID: aXYmKr04kIjfYE-jkRtoz2i4q_3pzTdU
X-Proofpoint-GUID: aXYmKr04kIjfYE-jkRtoz2i4q_3pzTdU
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgNToyMSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiArc3RhdGlj
IGlubGluZSBpbnQgc2V0X21jZV9ub3NwZWModW5zaWduZWQgbG9uZyBwZm4pDQo+PiAgIHsNCj4+
ICAgCXVuc2lnbmVkIGxvbmcgZGVjb3lfYWRkcjsNCj4+ICAgCWludCByYzsNCj4+IEBAIC0xMTcs
MTAgKzExMyw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNldF9tY2Vfbm9zcGVjKHVuc2lnbmVkIGxv
bmcgcGZuLCBib29sIHVubWFwKQ0KPj4gICAJICovDQo+PiAgIAlkZWNveV9hZGRyID0gKHBmbiA8
PCBQQUdFX1NISUZUKSArIChQQUdFX09GRlNFVCBeIEJJVCg2MykpOw0KPj4gICANCj4+IC0JaWYg
KHVubWFwKQ0KPj4gLQkJcmMgPSBzZXRfbWVtb3J5X25wKGRlY295X2FkZHIsIDEpOw0KPj4gLQll
bHNlDQo+PiAtCQlyYyA9IHNldF9tZW1vcnlfdWMoZGVjb3lfYWRkciwgMSk7DQo+PiArCXJjID0g
c2V0X21lbW9yeV9ucChkZWNveV9hZGRyLCAxKTsNCj4+ICAgCWlmIChyYykNCj4+ICAgCQlwcl93
YXJuKCJDb3VsZCBub3QgaW52YWxpZGF0ZSBwZm49MHglbHggZnJvbSAxOjEgbWFwXG4iLCBwZm4p
Ow0KPj4gICAJcmV0dXJuIHJjOw0KPj4gQEAgLTEzMCw3ICsxMjMsNyBAQCBzdGF0aWMgaW5saW5l
IGludCBzZXRfbWNlX25vc3BlYyh1bnNpZ25lZCBsb25nIHBmbiwgYm9vbCB1bm1hcCkNCj4+ICAg
LyogUmVzdG9yZSBmdWxsIHNwZWN1bGF0aXZlIG9wZXJhdGlvbiB0byB0aGUgcGZuLiAqLw0KPj4g
ICBzdGF0aWMgaW5saW5lIGludCBjbGVhcl9tY2Vfbm9zcGVjKHVuc2lnbmVkIGxvbmcgcGZuKQ0K
Pj4gICB7DQo+PiAtCXJldHVybiBzZXRfbWVtb3J5X3diKCh1bnNpZ25lZCBsb25nKSBwZm5fdG9f
a2FkZHIocGZuKSwgMSk7DQo+PiArCXJldHVybiBfc2V0X21lbW9yeV9wcmVzZW50KCh1bnNpZ25l
ZCBsb25nKSBwZm5fdG9fa2FkZHIocGZuKSwgMSk7DQo+PiAgIH0NCj4gDQo+IFdvdWxkbid0IGl0
IG1ha2UgbW9yZSBzZW5zZSB0byBtb3ZlIHRoZXNlIGhlbHBlcnMgb3V0IG9mIGxpbmUgcmF0aGVy
DQo+IHRoYW4gZXhwb3J0aW5nIF9zZXRfbWVtb3J5X3ByZXNlbnQ/DQoNCkRvIHlvdSBtZWFuIHRv
IG1vdmUNCiAgIHJldHVybiBjaGFuZ2VfcGFnZV9hdHRyX3NldCgmYWRkciwgbnVtcGFnZXMsIF9f
cGdwcm90KF9QQUdFX1BSRVNFTlQpLCAwKTsNCmludG8gY2xlYXJfbWNlX25vc3BlYygpIGZvciB0
aGUgeDg2IGFyY2ggYW5kIGdldCByaWQgb2YgX3NldF9tZW1vcnlfcHJlc2VudD8NCklmIHNvLCBz
dXJlIEknbGwgZG8gdGhhdC4NCg0KPiANCj4+ICAgLyoNCj4+IC0gKiBfc2V0X21lbW9yeV9wcm90
IGlzIGFuIGludGVybmFsIGhlbHBlciBmb3IgY2FsbGVycyB0aGF0IGhhdmUgYmVlbiBwYXNzZWQN
Cj4+ICsgKiBfX3NldF9tZW1vcnlfcHJvdCBpcyBhbiBpbnRlcm5hbCBoZWxwZXIgZm9yIGNhbGxl
cnMgdGhhdCBoYXZlIGJlZW4gcGFzc2VkDQo+IA0KPiBUaGlzIGxvb2tzIHVucmVsYXRlZCB0byB0
aGUgcGF0Y2guDQoNCk15IGJhZCwgd2lsbCByZW1vdmUgdGhlIHJlbW5hbnQuDQoNCnRoYW5rcyEN
Ci1qYW5lDQoNCg==
