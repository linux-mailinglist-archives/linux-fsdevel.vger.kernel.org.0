Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908D84A7ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 23:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347736AbiBBWNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 17:13:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42148 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240709AbiBBWNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:13:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhWZ023474;
        Wed, 2 Feb 2022 22:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WWg5nsYjGLPE/M74XI9m/6ZMYlXPouqvkizDWAtOmUM=;
 b=Xc5pc0mRM4oUfxnys9VlXqwG2nOhEUpgJ2lHOc5r8fQcVoAhwYcg18F/SBzg6CL/Ya2d
 ZT7b6FXojDOj8xJ6zos39anFV/pBImiH2bbJaF6+9p/4iUNio9UkDfY8p9TRRkbD4plP
 KAzIMM6XKvGExpnKqN4STjTuscuvwXp0LvTJ147uz01RCZcqC647ug8ICBrLMKy8IGVA
 vAMQcPaVfJhvEVqxiCAaUoxJ+dQEnZcfZvg11vjsPN2LAHhT9VlB6EZJckcMiEunM3Iw
 YWhx/xCZFAymeyeVrstnRf+663BHmeXDf0R3rwqBXLaGtytRmpoHRBnXSSfcvkfcGR8l Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2q386-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 22:13:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212MBSEd137607;
        Wed, 2 Feb 2022 22:13:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3dvtq3mvmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 22:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyqBJlJmK7Do3gstasb52t6dFRwKlifvutVegnwCbfaEgUqujsTaTNkH9Vr94fLu3hw5HtHX2fLusmLZ06rrF752h+hM+bBhLVgHgRw0tEwPsmUwRmAjgg+BFd+3kv7WZWEiCu4rUAgeNXqCuy2lo84MK9c3pJSPxIi9ojQn2BJHMKOuvqtiNwClqynTXFH3wMZCTNODGiw9w2kN6+38abpygI6QcdkXl/Z12CHKxIvtSVhM+g49iP3wXF1/LqRydjAIX5fgJ7p8u5n1Wq6Bwh+3Z92s7QLpAL8Sxj0bqZip/RCt+gUGqWZMUVCl3rz5gytrREP3P1AVIByEyarxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWg5nsYjGLPE/M74XI9m/6ZMYlXPouqvkizDWAtOmUM=;
 b=kdbjmN9FUaqqCElDxU1j4jglqMpZGLvopvk3DRSKZWCTmjcmNIRI65z6UvXiZE/9Yfu5fuzsRDqe3PNiwMSYPwcpltmJc3i/6YHHuyVXdvdCHMghk6VLEKxXXOpYliBzHOoWim80h1OQpmaspFhFuXx72AIyWA1CwBuVR+AtSu3Kf1twsu6MJsHzy/G1xeO0jj05Bs+C8lpzLu9UARyB7gnWrmW52JTVWRcLkmh9A4ov7uDxcrMyfTd9WIyv6HpBGsM6iG148wZzZjt9MQJkSb5xBSf9e1qJFZz9QcUmdIgn3ePMc1XtQzQcldEEQ6K7cpa3bW6WpCOQsik4RK1xnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWg5nsYjGLPE/M74XI9m/6ZMYlXPouqvkizDWAtOmUM=;
 b=nFPEcSAzj6OSHbNqnumdPuZUxKG5UvByZkiwjFc2R9rbDvn+8fFA1psEVWJX0xg4/NHPLFA7zHJ2g70mFmsS7DyBwEpK65ETjlNMjGXAmguJYh6Kxbx9hH7d21adrFhdYo1Qlr1um2JH+wnZ0iU8kK5LpSTiR3ZpCDKb4zrH0Aw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB2827.namprd10.prod.outlook.com (2603:10b6:5:6e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 22:13:26 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 22:13:26 +0000
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
Subject: Re: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
Thread-Topic: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
Thread-Index: AQHYFI6Ncz9/iVrSZU2vUZQLJAd6lqyATK0AgACOaAA=
Date:   Wed, 2 Feb 2022 22:13:26 +0000
Message-ID: <da884fa0-1cf8-b8d4-ba4b-4a4ebda70355@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-6-jane.chu@oracle.com>
 <YfqKkEB3gBsiuMZt@infradead.org>
In-Reply-To: <YfqKkEB3gBsiuMZt@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 468767e2-15d6-40b4-02c3-08d9e6993c57
x-ms-traffictypediagnostic: DM6PR10MB2827:EE_
x-microsoft-antispam-prvs: <DM6PR10MB2827D964FF28340A599BD5EBF3279@DM6PR10MB2827.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XR3XNRu+uguPyZf7P9P6Ky6dqZ5t5zjp8JimUk+iI5Ukmj0BWf/Otap8q6floYFqpe/BhojVXvjsodKh3VuQxWeEA0PXclBpTiQWVv6BT04ZEbM3ms7k51HySSinalzEmCQrxEsjnVTnqWkfNzcqjBHXii2pCPGIe6yPbYfYD6r2Is2QhxbIex5wsxv9xEs2jC1uLfT1TIkpgxh8kjmgg7ulsFOexRCJJDXV6ijlil9zYkNEI0f8On3QlBDAFIlaO3FNcZApYEsJhYZrPvKnjaxIDMpIjxwcSJ6gYtJtifLVM89INygQbBnGOgQqdtD6BXIpyroC01Xq0G6LD5LJCtEMBDb1iOD+Llz3TpDvDJH1V5JcYrDMZpGPS9siA1kWnB5Hckl/mnN6BGQ4flPdkjtyo2Q9cUgo7cOYuv+Y3UMPL02Fvq+HU+b4/8vec3lllnjYJn6EEpwa1QRvEsQyiJ472/DytG+z1FeICZIzwbqZnKrHBxoNJ2reAWxPxpZ8NSQs5rBajvlcQBhoBpMdfCq8MOcWVxtuBLrJj5JNm8bNzdasb2dB4z2g/8IXjsMIDjB73xqCuYqN2R/gnTaOR4o3DkXWDLViOPsQPtipN6G8ZCQFdBEVbhchOAPO99sd85VGLaYWv4KAuz4XG0GNc1DaQKvN29iS+F1WVKmoKJsol62PrZo2aABVx6eMLJCuCKIRLvVaC7e6O3XpQ3ySmrZ9z/LIwORb+HgYp6dEmCD/3dgyd9sdV4iaq8PN8XHvQDhsZ4XlbvicVuaUYa70bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(83380400001)(6486002)(36756003)(26005)(316002)(38070700005)(122000001)(38100700002)(186003)(6916009)(54906003)(76116006)(66556008)(6506007)(53546011)(2906002)(7416002)(64756008)(86362001)(6512007)(66446008)(31696002)(66476007)(44832011)(5660300002)(4326008)(8676002)(8936002)(66946007)(508600001)(2616005)(71200400001)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTdyKy9ubS81dVN6cm52Rmk0UU51bWd2ZzNlNU52YmxnMWt2ajNXR1diMXVp?=
 =?utf-8?B?cENjWVNaWVRTYnZsMytqR0dRdXYwQUN0S0J2eHFxTjUyYi81VU9DaUlpVkhz?=
 =?utf-8?B?NXRIUzFkVklQYXhJQVREUXM3YmhPczRDZkwwVmlkTU11TmF2enUvRUp2Z0p4?=
 =?utf-8?B?ck15VlhtTFlEdXR2cVNPWXBJL0dzcVdBNmFhVWxmTi82aStjWmlWenJMUXVU?=
 =?utf-8?B?dUl6S2tGRktZYklRNFc2MXl4UlBHUVp2UkxueEl4QTNUUWlLK2lNUW8wY1Nu?=
 =?utf-8?B?aThGeTgyVDgwK0VRazAwZzVqL1ZoMWFES0YyRWxRZHBTQzQ0MU45RURxQlpS?=
 =?utf-8?B?MDliUzc4Q0ZFeUxDc1pFOW96Y2Z5T3hWOWx3TGRFTEdGbzBXM0RlZ2txM0R6?=
 =?utf-8?B?dmdONU01N1RSR3FveTB5RjhETy8rak9VYjZsZVJoTklpMHFCSE45N09Wc3NQ?=
 =?utf-8?B?SGN6cEY2d1NnOGFKMnJYdTl0bFByWUQ0K3JLenBienhwdmt4Sll1NG81THFo?=
 =?utf-8?B?U3B3Y08rSHd0NVJlOTFNenFRMWxyODcyRm0zaVIxODhHOXRmVVlHU2g5K0U0?=
 =?utf-8?B?VGxkOHpwTkp5dVRRd2w5SEI4NzBIMzZHamNWdDZqbUpIZnFQdURGUi9iQTI2?=
 =?utf-8?B?OTdWV0FkdytMTGNaa2tsRk9uNGY4Y3lZSGZMMG41YW40eHRPRkU4V2lPcWhi?=
 =?utf-8?B?WXR0T0JJNldOTjJaVTVjaGpReldKcTRLU2NBMnpiOGIyQnFsQXRmS0N0aXBW?=
 =?utf-8?B?ZWtFYXFWSnZYdzgzbWpuNG50eElqSmJZRmsxTzRCR2hzOGVWbGxpUnZiZlIx?=
 =?utf-8?B?VnJyaVRyUGUxYkxKOEJMRDNyeGJXOVJSWW1meTNybGc1bE9YUkJnV2YzREFy?=
 =?utf-8?B?OFpOTXVtQnh2MllXK1ZrZWZuYmxJajFCOVY0V3oweGlaNmE0ZndTYitoNEJR?=
 =?utf-8?B?cmlwaG5aZmFiRldIZndnSTlFVDF1cnRzM0ZKQWw0dWhDNUZnSHVwYzkvckxL?=
 =?utf-8?B?NkZOVUcvanBkdjh2Vy9TQ256Tk81WVZkdHB3bFZJNG5rVGt4MXZsOUl6UnZs?=
 =?utf-8?B?V0k2czRTOWxQbU5TOW43VXpvemQ3Y2VkL2xmNnhkNGE1K2tMRjBRWmZrQ0M4?=
 =?utf-8?B?S2xYdXhNR1NIdDNMWHFVYW5TQXBLMVMyZ2lQNVBMTkVuRm0xdWZheDFJWS90?=
 =?utf-8?B?Y24yVlhvNnUza2lxdGJ1N2s0NVdGTnVsaWdVSEY0VHZZT1M3S3g4S0RVV0hR?=
 =?utf-8?B?bk1KUzdBemJqMnlGdHBvZktncmIvSVg0allnR2JCakVvWWkrQjFIZXVldWQ1?=
 =?utf-8?B?OUxFcTdRcFJ0ZnlLcmUrQWxaWFhldEQvQnhXa0pxVDlPbHRsaW1GZFVScjVU?=
 =?utf-8?B?enFoU2cwQjkwR2tNL3BpM1hhWk9FY3NwU05zanYrV2hudEtGZzRLemRmVk5a?=
 =?utf-8?B?NjYxOFlQVHlMUTYzNTFqNXFjdE5rK1U2RG4yQm5CYVdDbUw4YXVTQmdkSDJT?=
 =?utf-8?B?b0J6M0ZCMmhrU1lYMmM1OVA0dVpwQ2IxMmJYeGpBemdUM3JXQzQyQnphV2Ni?=
 =?utf-8?B?N1Y1MFpETU9sd1dKNXgrRlFNcDN6c1Z2bHhUVXBrS0NJV3JQdVpvWURaVVhD?=
 =?utf-8?B?RllXcm13MEcreUUzdk83SFR0UEMyUlRvdXRUMEt4dFA2bzRoNmxub0ljM1VX?=
 =?utf-8?B?QytHTGtEbWxhZzV3SGQ3cXFQTFEyd2RXVy9Ob2FDTjdpK0Vrc0NFVlR1dXAz?=
 =?utf-8?B?bEZnYnZYb05vdmZkdDF4ZFpaVjNIc2tBM3M4T3NDQmR0VDZzamVWWWM2c1ps?=
 =?utf-8?B?TzREaktFUGc4NUN2RFBkenNPbzRkY0RyWGVLNkZ6MnAzeFljcUNjQ3RtWnZs?=
 =?utf-8?B?ZzBFS3d1em9tbVRzWmw0WkFqaEh1VmthMjVrWloxOHhQM0pNTWx5RXVlSTJu?=
 =?utf-8?B?NW5NdEp4MWFwSkc4eUFEWWxrb2pRRks0Qlg0VGJEbFl1WGc2RjNwdFFsTWk0?=
 =?utf-8?B?NytWUnhISmttaTVHWFNYcG1tbjJxbFNWOWVwRk5welJrRFVYbUZRNDd2bnhq?=
 =?utf-8?B?Y0hOTDFqVEEzaElQaHhVNS84elpiMDNucVFxbjE2bmpDTW9yUzRpUEhpaDY3?=
 =?utf-8?B?QldzYUVKTWVIVFZxUnR2TnBNZW1Sc0dTWlZGejFLT1laWVJFNWFSS3JiTUFv?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD5F84E228DDE4489FFA6E0A4346BDA2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468767e2-15d6-40b4-02c3-08d9e6993c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 22:13:26.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjMKnlg0zNpY6JxkEXi6MUentDir/u8rxygzn/HXvmYE+8bvBrtXBs7B6VqL79sY3ki2+gfyqo1jmWKddu17rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2827
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020120
X-Proofpoint-GUID: M4NsJd-zr0cg1sk-Zh-okqnNlC-UjksB
X-Proofpoint-ORIG-GUID: M4NsJd-zr0cg1sk-Zh-okqnNlC-UjksB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgNTo0MyBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBAQCAtMjU3
LDEwICsyNjMsMTUgQEAgc3RhdGljIGludCBwbWVtX3J3X3BhZ2Uoc3RydWN0IGJsb2NrX2Rldmlj
ZSAqYmRldiwgc2VjdG9yX3Qgc2VjdG9yLA0KPj4gICBfX3dlYWsgbG9uZyBfX3BtZW1fZGlyZWN0
X2FjY2VzcyhzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHBnb2ZmX3QgcGdvZmYsDQo+PiAgIAkJ
bG9uZyBucl9wYWdlcywgdm9pZCAqKmthZGRyLCBwZm5fdCAqcGZuKQ0KPj4gICB7DQo+PiArCWJv
b2wgYmFkX3BtZW07DQo+PiArCWJvb2wgZG9fcmVjb3ZlcnkgPSBmYWxzZTsNCj4+ICAgCXJlc291
cmNlX3NpemVfdCBvZmZzZXQgPSBQRk5fUEhZUyhwZ29mZikgKyBwbWVtLT5kYXRhX29mZnNldDsN
Cj4+ICAgDQo+PiAtCWlmICh1bmxpa2VseShpc19iYWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlT
KHBnb2ZmKSAvIDUxMiwNCj4+IC0JCQkJCVBGTl9QSFlTKG5yX3BhZ2VzKSkpKQ0KPj4gKwliYWRf
cG1lbSA9IGlzX2JhZF9wbWVtKCZwbWVtLT5iYiwgUEZOX1BIWVMocGdvZmYpIC8gNTEyLA0KPj4g
KwkJCQlQRk5fUEhZUyhucl9wYWdlcykpOw0KPj4gKwlpZiAoYmFkX3BtZW0gJiYga2FkZHIpDQo+
PiArCQlkb19yZWNvdmVyeSA9IGRheF9yZWNvdmVyeV9zdGFydGVkKHBtZW0tPmRheF9kZXYsIGth
ZGRyKTsNCj4+ICsJaWYgKGJhZF9wbWVtICYmICFkb19yZWNvdmVyeSkNCj4+ICAgCQlyZXR1cm4g
LUVJTzsNCj4gDQo+IEkgZmluZCB0aGUgcGFzc2luZyBvZiB0aGUgcmVjb3ZlcnkgZmxhZyB0aHJv
dWdoIHRoZSBhZGRyZXNzIHZlcnkNCj4gY3VtYmVyc29tZS4gIEkgcmVtZW1iZXIgdGhlcmUgd2Fz
IHNvbWUga2luZCBvZiBkaXNjdXNzaW9uLCBidXQgdGhpcyBsb29rcw0KPiBwcmV0dHkgdWdseS4N
Cj4gDQo+IEFsc28gbm8gbmVlZCBmb3IgdGhlIGJhZF9wbWVtIHZhcmlhYmxlOg0KPiANCj4gCWlm
IChpc19iYWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwgUEZOX1BIWVMo
bnJfcGFnZXMpKSAmJg0KPiAJICAgICgha2FkZHIgfCAhZGF4X3JlY292ZXJ5X3N0YXJ0ZWQocG1l
bS0+ZGF4X2Rldiwga2FkZHIpKSkNCj4gCQlyZXR1cm4gLUVJTzsNCg0KT2theS4NCg0KPg0KPiBB
bHNvOiAgdGhlICFrYWRkciBjaGVjayBjb3VsZCBnbyBpbnRvIGRheF9yZWNvdmVyeV9zdGFydGVk
LiAgVGhhdCB3YXkNCj4gZXZlbiBpZiB3ZSBzdGljayB3aXRoIHRoZSBvdmVybG9hZGluZyBrYWRk
ciBjb3VsZCBhbHNvIGJlIHVzZWQganVzdCBmb3INCj4gdGhlIGZsYWcgaWYgbmVlZGVkLg0KDQpU
aGUgIWthZGRyIGNoZWNrIGlzIGluIGRheF9yZWNvdmVyeV9zdGFydGVkKCksIGFuZCB0aGF0IHJl
bWluZGVkIG1lIHRoZQ0KY2hlY2sgc2hvdWxkIGJlIGluIGRheF9wcmVwX3JlY292ZXJ5KCkgdG9v
Lg0KDQpUaGFua3MhDQotamFuZQ0KDQo=
