Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F771436A80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJUS0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 14:26:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38238 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhJUS0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:26:41 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LHxKV6030748;
        Thu, 21 Oct 2021 18:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=khdzdXAMma8OuK99/HbcNwldug/AgyUIwFVtM2i29hA=;
 b=MrLWTWzOSr+liFu2EvNG87Ucos36Hp2io/CVslNUUYtkFgjFRxfPm3flL+Pu+3DfJ0Pe
 xmVOcxrfoHdrY7ay6PVAPWpHB2aq18Bzg+Jt1ssq8dXT0d6bUSoYOMk8RgWIvn/icZLP
 I2kkuTUj0OWucwmHhYcMpC6x8A6qy5e1P+OUvBhFAoJnflKOm4P0DgKcSNlivAvBm4HM
 j9lE/3r85qdpapLIzV5cgulx9vtqqu6Y8iIKHWx7t40y45W/LltlltY5us1l9E+iUt3C
 w6ybg5Ycdd71bU9s15qeqByg0sdLZpvbamoIYqZrHwMKLffxEA76jCWAotdIhb+1Vzev fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkxa0kfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 18:24:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LIFfVd191933;
        Thu, 21 Oct 2021 18:24:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 3br8gwgxsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 18:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgfeXB0SETGWQQkjkUYnaxTpANVO/YIM3uTW14oRkQ7fXT8zTgmexKZwRy70NpCU5mmLsoq6nkQhT46OONY2mNn84Fk6Kb4+hzMdYHaheL2cx2mWwnNGOoIXC9DSM7x265/jFeH97WjqmEgIc7udNVmCZA9HPTVE6e+8rT8NNXGUILjGu+8OSPzWOZZjlNAo6FvNXWAthyY5SM2NnumUnLRi7YxEsH6KdA7AHCJZhbvN9QqLtK05rZfpAvFq1No06zLuLU2VG41FiqJjGohSwQZe1UMTwWqQ8RCOl3T2tuEllZ78JfTyBMrEDA31jsNcLMYiT0YA1/qGxG7DL74FUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khdzdXAMma8OuK99/HbcNwldug/AgyUIwFVtM2i29hA=;
 b=cK+eQCM0QN6YGrnnfrsdEMJsqFZ0Fxkgx+Ektu6SqzAXl7rNySIgLa0iTrMf3gKrG9Y4zm+Y/jwW4PXv+QykcRtHO2Z2QlqJRGbaN/16dd236KjrE9gVjFTH5O9ryivsRiA8G9AqoIBFyOUKMYYAWTCB+6DvrY2N285vejd/XL3smWRrDXQOw4pNCV883QvBELIYubIOeOS8v5aFd+SDvRgf9pb+pbrPHi6sTGRY3UlNI7KsUXOkd1UArhPWCMlkdKay4D+UaZa643LeEFZsoI6xroDqzJWHShBtLx53gcF22wsQg6ET0rj4HC3X1Vj/6pOTF1dHRb7HJdPpqbIECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khdzdXAMma8OuK99/HbcNwldug/AgyUIwFVtM2i29hA=;
 b=d0u63tILrVg/kfM1Sc5IV/p9h9oHzQpx17K9K5nDNh6L8zuSMtWRVsfXH8UDpYmvq30pQnqRb4urdijVQkNYmZFw6jGGLphlnWjg/IxMJQSl9eSXsjTKhd0qBUC6q73Rjm97K75AwNEcQ/BV1Ji9EH9ZkFl48sINVcUxCCvdw2I=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:9c::17)
 by MW4PR10MB5702.namprd10.prod.outlook.com (2603:10b6:303:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 18:24:03 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::f12e:1d7a:66a3:3b1b]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::f12e:1d7a:66a3:3b1b%5]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 18:24:03 +0000
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
Subject: Re: [PATCH 3/6] pmem: pmem_dax_direct_access() to honor the
 DAXDEV_F_RECOVERY flag
Thread-Topic: [PATCH 3/6] pmem: pmem_dax_direct_access() to honor the
 DAXDEV_F_RECOVERY flag
Thread-Index: AQHXxhA9jtGrb5nkUU6g/kyAPNS1eqvdT/kAgAB1ioA=
Date:   Thu, 21 Oct 2021 18:24:03 +0000
Message-ID: <d5419b70-97fd-b760-5343-066e9b5cb9f9@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-4-jane.chu@oracle.com>
 <YXFNqI/+nbdVEoif@infradead.org>
In-Reply-To: <YXFNqI/+nbdVEoif@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c9e0640-0866-4d39-b490-08d994bff5dd
x-ms-traffictypediagnostic: MW4PR10MB5702:
x-microsoft-antispam-prvs: <MW4PR10MB57025A684F140A9B4FDAE5E8F3BF9@MW4PR10MB5702.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRY/pfvmx8A5wQ1TSm3HrHGQWm+K+hFYKwEX8OXSpRad7WrL+bLPY97CkySk22mu/ZRCbZShV2vcsFUaxM+GcLkp5y3B0PX34r2IicozZEVOdalsa+qexMHaX1RKmXFz5+4BZ/ByYQP3ZjZAr5Dy/Neuau2J9uN97IfGoPrbTHQpzQaqACZ2N6p7STHQYNUAB+RdI4TKv7HKt1uqrinwxQIcHXHSPLXtXqGzUGfTUaFA2DW/RwQGoheUpGkrvmqzYn+Zu9DKVldsr3oXWRfpDYaxq8uWo0PfP+/S5/a7ToQJ3tXHDY6IZ4Thb06UdCrLNDOsHeh1XJZGXk4hPcuWuNshtBqyjHBCBgqWtByCtW/s4MoW7XJORal0kBHXUNMggqSvycGuOQqUPA4qAxbm5Kt6Ye/6mR2xE/mrES2OjZOSzidpisfYc/pZ3+WrFy3MBVqj3lHoDKxyanYqaARQsLAQt6ugzicS9NfTXBUV2fqo5G9lxGJpH2ccSYBqalCyucopM3XjGH7Pv5N0vqbFbK8pnfjwOBQ4kTVPCAKzuKcWcyKv/41oUWxDPYhVIHDYBNBg8mYHur81XvpzC/xbXlLm5PVx8V3C3v4QwvD1r0XnU1Z6kulPVWCrjkeKOyKwlvdkcLkKNjbKs0wDOzfzngTCkOW3ZS1MR7DyeLhbhf8fFvDPCxwJd9nOcTAjOHlY9/DNC2OMbNhOTZsp7kj6hdhYNrETZvzw6a56M7ChY0WXPinPmk4XCcvqbVqfbgt2fflnsS2/sVpKlnPL5B9LUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(31686004)(8936002)(5660300002)(38100700002)(4744005)(71200400001)(86362001)(66946007)(6916009)(66476007)(2616005)(4326008)(2906002)(8676002)(64756008)(66556008)(53546011)(36756003)(6512007)(122000001)(44832011)(508600001)(7416002)(38070700005)(31696002)(6486002)(54906003)(26005)(66446008)(76116006)(186003)(6506007)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnY2Uk5uTzJzQmpyMDJYWnFvTzYwVlE1bDFEcjhHRzVvM1V6RVYrS2JRNXVS?=
 =?utf-8?B?VEwvcWd6MHBPekxmWjVtWk9RcW1BeEJiSDNqVCtYdWlMQWNCQ1p2Z2lSblUy?=
 =?utf-8?B?S0VKTGxZSGU5VlltdkZKa2dtRGlJSmROTWtmNHhhRGhQNE55eXUraVVNYVdh?=
 =?utf-8?B?QkNWSlZGbXVYZGxLbWE1WXdiVmVtVTVSbFBsWVZZT0c5ZlVXQVNGejZ3dWNs?=
 =?utf-8?B?ZkpFMUhVWDhaM0FjSGZyb1ptbkU0enpuaTg2a2VLNVAybHRTYi8wajlyOUxp?=
 =?utf-8?B?NUN3c3pmQTdtdzNyR1haekJDa2s3d3JDZG51V0RKVSt5bis4UFJTOE1aQVYy?=
 =?utf-8?B?OXF0NWVhOFRMbXRWdHMvRkNmemkzSVJySEhqdll3bWdXRTE5U0F2Mk55NGRU?=
 =?utf-8?B?dHhocUNKeGllYVpGVzZZdW50MGxXbWl2S3ZzSnAwVGNnZlNrcmNjVVh3V1Z0?=
 =?utf-8?B?TS9GWHU1VU9rQ2gydnRyMHFuWUVBS1Q4VHplY1RkWmJHOUtKQnAzaHVvWm9k?=
 =?utf-8?B?V2Z4d3lheEFUclVkRHljUjZ3cnBzOUlkajJCbDRrb1p6bVhHQ3gyZDJhZHQv?=
 =?utf-8?B?RVdUV3ZaSGd2dlJTaTd4RGRSdHRzZTY3cElTQkw0NGdBazlFTmJSOXR5anlS?=
 =?utf-8?B?dzJvUmVNVCtuYUdFOHlhUUx2RnpzT1JaaFFjeloxN1llZXVNNkRMVXlLd3Ni?=
 =?utf-8?B?aTFDY0lYNTZTVEtLbCtWay9DTnp6R1gxMUh2bkNrUzJUZHJSb0k0WXk1eWgx?=
 =?utf-8?B?d1NrL0dxWVB2YzR4dDFHd1BIcG5pSVdGS3hIcDVmOE1odC81K25lSWVISmFh?=
 =?utf-8?B?aE1rY2d4YmpzeloyaW9HOW1RMzI3YkxjODY1cWl3VkJLaEM5WXJlU2lhaEVP?=
 =?utf-8?B?QytCTHJkQi9OS1NGNW9jZ3k3M2ZqWEd4UlVKWm5qUUF5U0pYYmJPeEF4Umpx?=
 =?utf-8?B?MDVwbEZjOVdSMUwzTXpJOXgwSlFjYm9BdnRlQ29mTU5xK05kaU9LWHlqK2Fq?=
 =?utf-8?B?V3MzbmJvanF4d3plb1V5d20wV3JJZTRUUGx2VklrTXVmZUREaE9valFHckJK?=
 =?utf-8?B?V1dRM3JVT2xDYmtaeGhRb1BqVjhZSjZXeEVXMHdmRmYvSUNPYmFpMUQxSlh4?=
 =?utf-8?B?NEJyZ25xYlg4NmcrN0pIWUlWSzluTEw2NDdFYXlCakt0Vy9QcXdXTVVOVkRY?=
 =?utf-8?B?QlpjVGZJMEk5cFJpMFp4Z1EzVlNncTdPRTBacEpUR0dwUStqc2NjYVNGRzV3?=
 =?utf-8?B?clhTa1ZBNHNrbnU0YUU4ZVFRZWtJZ0szalJ6K1Y3aHdGK2syUEE4bkF0SFVs?=
 =?utf-8?B?aGhhT0kwRjRGb2JwSFZrL3A2RVVqS0taR1JQYnpTZXhUeUtHWmFlTExHdE52?=
 =?utf-8?B?SzV3YU9SRzNHQVhieFlqeEtYWEIySkJPSGpwbUpDdDFBTlprMkg2ZzNVQTBj?=
 =?utf-8?B?Yk5rUEdsZ1F4SFp1QWFwWUpwQ3hsMkFDeTNra0RJODFkQVpBV3VQUXppUnl0?=
 =?utf-8?B?WXloa3ZpWTR1dHpOaVNOZ2hqMUNLcHpyTkFNRU1teDlzRm9RM0ZFY3pXWVFH?=
 =?utf-8?B?d0NNUlJwZU1nYU04azEzV1I4NHo4RTh4UXl5aDJCMlRtcVB0bU8wN2VHbnFL?=
 =?utf-8?B?WkV3MGc3SzVIREIxNFAwbEoyNmt2WnlwVDJ1VktRSlU2ZzZ0MEZXZTB5WS9Q?=
 =?utf-8?B?b0R1U0NWTDhTdWFINy9EQzZuT1Jva00xUVpoRW9uWE9GWWl0M2RoUzEvb0Nu?=
 =?utf-8?Q?OLIcVbMokdl8CcuAmk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC7C9ED1EA8C443B466CAD299DA151B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9e0640-0866-4d39-b490-08d994bff5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 18:24:03.3102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5702
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210092
X-Proofpoint-ORIG-GUID: m-TZsuuz-qwO8FeJQbsDnSvC5OSiLnw-
X-Proofpoint-GUID: m-TZsuuz-qwO8FeJQbsDnSvC5OSiLnw-
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSA0OjIzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gV2Vk
LCBPY3QgMjAsIDIwMjEgYXQgMDY6MTA6NTZQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiAt
CWlmICh1bmxpa2VseShpc19iYWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUx
MiwNCj4+IC0JCQkJCVBGTl9QSFlTKG5yX3BhZ2VzKSkpKQ0KPj4gKwlpZiAodW5saWtlbHkoIShm
bGFncyAmIERBWERFVl9GX1JFQ09WRVJZKSAmJg0KPj4gKwkJaXNfYmFkX3BtZW0oJnBtZW0tPmJi
LCBQRk5fUEhZUyhwZ29mZikgLyA1MTIsDQo+PiArCQkJCVBGTl9QSFlTKG5yX3BhZ2VzKSkpKQ0K
PiANCj4gVGhlIGluZGVudGF0aW9uIGhlcmUgaXMgcHJldHR5IG1lc3NlZCB1cC4gU29tZXRoaW5n
IGxpa2UgdGhpcyB3b3VsZA0KPiBiZSBtb3ZlIG5vcm1hbDoNCj4gDQo+IAlpZiAodW5saWtlbHko
IShmbGFncyAmIERBWERFVl9GX1JFQ09WRVJZKSAmJg0KPiAJCQlpc19iYWRfcG1lbSgmcG1lbS0+
YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwNCj4gCQkJCSAgICBQRk5fUEhZUyhucl9wYWdlcykp
KSkgew0KPiANCg0KV2lsbCBkby4NCg0KPiBidXQgaWYgd2UgZG9uJ3QgcmVhbGx5IG5lZWQgdGhl
IHVubGlrZWx5IHdlIGNvdWxkIGRvIGFuIGFjdHVhbGx5DQo+IHJlYWRhYmxlIHZhcmlhbnQ6DQo+
IA0KPiAJaWYgKCEoZmxhZ3MgJiBEQVhERVZfRl9SRUNPVkVSWSkgJiYNCj4gCSAgICBpc19iYWRf
cG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwgUEZOX1BIWVMobnJfcGFnZXMp
KSkNCj4gDQoNCid1bmxpa2VseScgaXMgbmVlZGVkIGJlY2F1c2UgJ1JXRl9SRUNPVkVSWV9EQVRB
JyBmbGFnIGlzIG5vdA0KcmVjb21tZW5kZWQgZm9yIG5vcm1hbCBwcmVhZHYyL3B3cml0ZXYyIHVz
YWdlLCBpdCdzIHJlY29tbWVuZGVkDQpvbmx5IGlmIHVzZXIgaXMgYXdhcmUgb2Ygb3Igc3VzcGVj
dCBwb2lzb24gaW4gdGhlIHJhbmdlLg0KDQp0aGFua3MsDQotamFuZQ0K
