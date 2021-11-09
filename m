Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4948144B317
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 20:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbhKITSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 14:18:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34094 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241978AbhKITSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:18:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9Ix7Ov015325;
        Tue, 9 Nov 2021 19:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pkVaN/JC1x0J16zhfhuS6HnVPbxLEIMG1hEFlxdeT2s=;
 b=S/1np614TfEWGNWvkcznQXBrrw7RQqtLbpVFqwnH6qO/akO7MnOw5XoJ9gyxpsx4teR/
 gP4MiWIpL74BTWGYnvJm7j3P8kK0b8ZL7Uzq5rqkEjSUfmoze8RspuY86vs5vOQbXmyc
 nQe4mEOBvZfIREclUAXsCFgyAd32Atf7kIKHO0x1NvnFM13NgkMr5CvMhVnLJmOHht3r
 0UqHSjW2/CjGhQSV5nGw5OuvJOZ87dAxhXkHIPzz4EtIaauhAbfpMQlpvLHP/sXzKQbW
 UH7G1UUz7UcoJaP+lK0giUz29WZxpJ52Z0pvtB8kcF3KtXO76tP0UlP01jESgynvow91 aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6usnnqgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 19:15:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9J6eZv006306;
        Tue, 9 Nov 2021 19:14:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 3c63ftf86k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 19:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMoVlj6HZ0iAZ42ereMNTxgD1kpb+NSA9Idyw742t3D5vgG3dFKpMJVEwMlhivt6dE5vHSDCyiOR8mYhiWE1LorJJUDGmx5R7oURoSWpq0UKg27omWT8WDHLEAloZwFCtO0w8vBzle1nHk+xY7eY5peVMg2U2QJL1kmaTCDJr61YvlDLM8fhz071mkDHsD0Js/J/fSrORugw5hlsHNANUpARYWmUwRkytmHaM6LPuGOq7iLkktLXSwhbtMr+4vupRjeowRyiMF/OqMv4qbEOsQ+S+/JgBeS1NjLnpJY9SKmcwnCVgx8e9jAqT1Fs3KGrLmZUiiRxtLgpp5XnOPP1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkVaN/JC1x0J16zhfhuS6HnVPbxLEIMG1hEFlxdeT2s=;
 b=SPOAjekGKIlurWHTGG1jf0fqxrmHgWlTbDHLI7WdYl2EXLaH4hTWtDhh6XqGOgPaYRNUAM6sWNNnu+OyOqaC5D9BiSnxnsIZq7y1Ini8+PC5hCr1lpUP+SJqzxx7Fp8snZAOeSxdeB6Wxy7ywtXpj9kR0AVikWJHWc/D/hJCOkNT6mnyBQiaUKPhhB+RZRHm8CZTOzNWaDX84k5CyTeVdfDiBALGW1r1gg3wPgvgToVxxcaPzGxOsSX5wQnJ4srKiaTYrSnWEYRj3Ca+AcOm4jqMaD5PFx0Qmljxr7E3l+u5cc06mWK6U4xRNHML4q+k/SpVoDJDQeMaUKRpSZrW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkVaN/JC1x0J16zhfhuS6HnVPbxLEIMG1hEFlxdeT2s=;
 b=wsxB7rSV3HWMZ0h7/HdVJu+hlwQdZHyBPd31Mze6PQntrzzO9BnD2j+alOX4RFTSs2tKj8hXbXH7HR2jdkyy6jbCnpojCczn9+OEK2XVVU6WWh/nX06yr1DRpFNLNjO3iT4TmdLkudDI9AIGoR8202oG13HWQsJmaFrzlYh6ky0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 19:14:52 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 19:14:52 +0000
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
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Topic: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Index: AQHX0qwHA1irfgJJPUKt0/SD8Ofb86v60R0AgADFroA=
Date:   Tue, 9 Nov 2021 19:14:52 +0000
Message-ID: <29d2c6ad-003b-8247-4852-00be191db297@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
 <YYoi2JiwTtmxONvB@infradead.org>
In-Reply-To: <YYoi2JiwTtmxONvB@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a30664-82b5-458d-d7e6-08d9a3b5351f
x-ms-traffictypediagnostic: SJ0PR10MB4525:
x-microsoft-antispam-prvs: <SJ0PR10MB45257B55DDAE63EBA32E8F69F3929@SJ0PR10MB4525.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8hGQz4GNSKv34zm31KpAlxyGoN/TXzt88o4KhwTXWDB87ql5aL+zc0pgxEHNXg8xaIVNQGQWPDI0UocX+eU8NbZwtrOwRQUVLM3W/Zhb8bKAzrVkf/kQnzvFfhtzW6y6HLO20VYQk2WXgVcAwvAOAxtBS1487pwcRse/IDUndhqiSV5ZNBs4Na5REyGl9mSkc5JBmv/doffNFhndSnWgdNZhjcwpoaCwdJXsaH3g6MV8hBawJ0mJ5N0jEgDNrlP2vnLRB88khBbj43sHJNoZV51hzG8JcJ9S1N9MtdK426REbOWXT5lgTt0hXGhlhX785o4I12FNk3ofvqDzx0IC6RlE44lQNU6z28KcrpVpFrbq/0qRxajDtdEIZdi+99mL2FBxl+YEpfIpzNYnuO4gZsg0mtzT6hx2vOYPUKPKIj3yuRwA9XLkSlaeAg55b036pkrSUI/QpwjHmC+xRXjWry6Djt8qnEPd3pZe9MixRmS8AImyAelybzy+Hd+nDaUvtkWfqWN7GgvFeQXbBRqaNVrgetW+HwW9uP+nR6ci2tBiq+kxpHpvglYqDo5Z0vjaqXjxJPnsrk/pVlZnHkDAwdpbAKX4hIFzhteXnve6hiyK7wJg8GA16oQ6lB4tSocGpBdXe38yg68cpzDwk8Tt4ZO80WUydz8CPLbblHa2sWE5NBFDbstSDfcjtKkSqW4+6S/9HZu3/t4TjRzC14UXsqwekyQlYw/96BGnVMQzVUI9Mv8b8AfXVeUhNpMNa2fjgeRZeVe1RIa+eUFWvEPzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6916009)(2616005)(66476007)(6486002)(71200400001)(122000001)(54906003)(2906002)(508600001)(64756008)(66446008)(44832011)(66556008)(53546011)(36756003)(6512007)(186003)(76116006)(31686004)(31696002)(26005)(316002)(38100700002)(8936002)(38070700005)(7416002)(83380400001)(86362001)(8676002)(66946007)(4326008)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3BYaHBWQXhFb2t6RVF1WDlSK1dUL2dFdFM1bUx5MlNpUkJveXZrbk9oMVJF?=
 =?utf-8?B?blhSM1dhNVlZMkJwRGl1bzBxQTAwb1ltQ2J4UDE2YmNmZGRFc2lMdmxycWxK?=
 =?utf-8?B?cGxUK3ZOTG9GWlZKdjROYVNyQW1vaGM0d2IxN1NzWjJVWGRWZlNCMjJMM2dG?=
 =?utf-8?B?T3VxQnl5NkxSNnZ3VmttVmpQVno3Rk0wMDUrYVVCWW1OeGFlSEdqMHduSExD?=
 =?utf-8?B?UXBzS2UrVHVpU3h0OW9rNGpEWmMxY0UrZUVJUmxiRld6Q0ExSWgxOG9HL1Rk?=
 =?utf-8?B?TzZZbmVEOUkwRE0wWTdzUzI2ZE1pQVdJYnVhellSbzlNUE14ekxtUlNLOUFy?=
 =?utf-8?B?ZlNUSUFDUDZ1bTg1YWNUTisxK2FxaVp1czlNdzFhaGxDeHlIb3VQL0xaT2lD?=
 =?utf-8?B?MXdOUmhLMkRtdHhmS0I4emZueUtuRHY5ZHYxbzhoYUlzNmdlYy9QWW81WWtG?=
 =?utf-8?B?MW1ZMmpxMXNZZDMxWnhkU2pzMW41ZW1wUEJ2NGk5R3VVTkJqM0lTektrenU1?=
 =?utf-8?B?TTh0NkFLaUZsbllTV1VJSFNHNHRVTDgrcVM2aXJaOHJYMTczRkh0VS9lems1?=
 =?utf-8?B?MkloSzRlcm5kNzFLWnVRbDZ0cnBWTEUyVTBpd0lPblIranduMWcwaHJlcHVJ?=
 =?utf-8?B?SnJqZ0duYTkvazE0eWg5dUI5UGhjMXBPRE56Tk01YTRZbmM2N2FYSFdtSHd4?=
 =?utf-8?B?NTUzNEF5c0VNOUMvZE54MjJObVVhbzh5K2lJUnNvQ3o1S3g5LzhOU1Jnd1Ra?=
 =?utf-8?B?OWJoSGl6SlJxZEVHeWk4T291UThETFNuY0QzZ2dmRVByaWdINFBkbWpWbXBz?=
 =?utf-8?B?UkZ5VDg3YVNIYkJqNmFpQ0VNOHJEN0Q2UVRWazJWSS9NUkFsWTRkSlgrMUV6?=
 =?utf-8?B?b1Y0anJmc1F6aVVxdWgrQ3BsMUlUZzhWTyt2ZllINUZ2aHAzZnl6T3lEMzY4?=
 =?utf-8?B?ZkQ4ek9iR1dEWU5RemJuT25NVTBJSkNLeFlDT0FvUU1rb2QydGlmcWs4S1lL?=
 =?utf-8?B?OGlwN0l5SUl2SzdwYjlGVXY3SCsvREtVQmdKVjhqUG1rUDFQdXVOS2hiUVBl?=
 =?utf-8?B?ZDJTWHBpVVM3U2diTWF4MFpqdnhJVmlnNnFGcGFTcnZSUDQ3dm1JM0lZc1J3?=
 =?utf-8?B?TExqQ3h1YmhuUnk5K2x5bEJNZlBJRmhNQ0tvMWt1YXJzMHY2WWYwTzRSZHpT?=
 =?utf-8?B?N3JHbGV5ZU1QblJMNjJRQUhhNjlsVFhhT0Q2Zk9hU05HNTdNQk95d2FFeldW?=
 =?utf-8?B?Zmx1MUxSYUtjNDAydGVUdk5QaVBSR2Mzd2F3LzBobi9mQ3dqNU8yQUJMcFd6?=
 =?utf-8?B?NHhHU3RNOGl6OEx6UUJXRHYwb2FpdmxqNzBsRnNpWnFiWXdwU0ZHT013SEI0?=
 =?utf-8?B?bS9MM1JKb08vT0xKYkQyN3Y4SFJ3ZUt5Q29MZGR0dWtjdTVucDhDRm5mZTNY?=
 =?utf-8?B?NVZ3UVJnSkIwSSs5Q0JzMDhQdHczcjF1NWJ2Z3VuSVZzTkJ1MkovdU50MURG?=
 =?utf-8?B?OUJKNXRmbXhSWlFtaitTVHVzNStKRGRqWG9yUEFOVklDaWpubEg5bmFGbElh?=
 =?utf-8?B?eGNUR2JFS0RkMytYRTZGdXQrRCtoTU93dGM4KzRHSy9NSVp2b2J5aGUvLzEv?=
 =?utf-8?B?aWV4WVAyMzQwMGlNbXI5RGl0Y2RVWTJLMGJnckw5em4rSmUxVWJBazRyUXVa?=
 =?utf-8?B?SENzSjAvcmxtQ3E5RXFCSlVaTWZSNyszNjFDMlI5MUlsTlY4VkdnMHpDT2NK?=
 =?utf-8?B?ZXBIRnFMV2xTV05HdTlZeVpyTlFaQVpQOEorN0JFc0hKWG91M3JoUGhWOVVW?=
 =?utf-8?B?ZlUrZVNEL0UxVlE4T3RxOWhyRXh6WkNyb2hlOHJPNkRxelJzOUYxUVpUNEIx?=
 =?utf-8?B?b0U0Q2VWekpQWEpLRzBHVUMzREh2dmUrclliYnBremYrKzVxTkRWWTFUMlZU?=
 =?utf-8?B?d0F5T05mZXVwMHZrd0loZGViTFdZc0tHekdVazZDUnhhOGxMT0JTQm5ENjRY?=
 =?utf-8?B?cE92N2tHR3ppaTBFcGZJb0ZZOVFsQnVGcFRvRUhwaXRkTHpWakYyVDJBVmRn?=
 =?utf-8?B?L0pwVm1Fek4wdnZTS0kza0NZRC9mRGFlODdlblZOQ2RPeW9WWlVicjVyZUw2?=
 =?utf-8?B?YUdUR0RubWE2K1h5REYyUnZCSFM4ZHNhNk5kR1VCeWR1R21rM3ZWQ1Zvd2pN?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A11647C57E43FE43AC8BEAF54524A2A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a30664-82b5-458d-d7e6-08d9a3b5351f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 19:14:52.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sP0cAxBWHImFarr1Kypn+udx0rhst0b5wOvN6VN9htbt810CVb+pDoGCin+Hd0AcyKASBXFRvvE/r0ev/r5Usg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111090108
X-Proofpoint-ORIG-GUID: zMIcUQO9KmfTu9U42XsxB5h7WJss7R4E
X-Proofpoint-GUID: zMIcUQO9KmfTu9U42XsxB5h7WJss7R4E
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvOC8yMDIxIDExOjI3IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gRnJp
LCBOb3YgMDUsIDIwMjEgYXQgMDc6MTY6MzhQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiAg
IHN0YXRpYyBzaXplX3QgcG1lbV9jb3B5X2Zyb21faXRlcihzdHJ1Y3QgZGF4X2RldmljZSAqZGF4
X2RldiwgcGdvZmZfdCBwZ29mZiwNCj4+ICAgCQl2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0
cnVjdCBpb3ZfaXRlciAqaSwgaW50IG1vZGUpDQo+PiAgIHsNCj4+ICsJcGh5c19hZGRyX3QgcG1l
bV9vZmY7DQo+PiArCXNpemVfdCBsZW4sIGxlYWRfb2ZmOw0KPj4gKwlzdHJ1Y3QgcG1lbV9kZXZp
Y2UgKnBtZW0gPSBkYXhfZ2V0X3ByaXZhdGUoZGF4X2Rldik7DQo+PiArCXN0cnVjdCBkZXZpY2Ug
KmRldiA9IHBtZW0tPmJiLmRldjsNCj4+ICsNCj4+ICsJaWYgKHVubGlrZWx5KG1vZGUgPT0gREFY
X09QX1JFQ09WRVJZKSkgew0KPj4gKwkJbGVhZF9vZmYgPSAodW5zaWduZWQgbG9uZylhZGRyICYg
flBBR0VfTUFTSzsNCj4+ICsJCWxlbiA9IFBGTl9QSFlTKFBGTl9VUChsZWFkX29mZiArIGJ5dGVz
KSk7DQo+PiArCQlpZiAoaXNfYmFkX3BtZW0oJnBtZW0tPmJiLCBQRk5fUEhZUyhwZ29mZikgLyA1
MTIsIGxlbikpIHsNCj4+ICsJCQlpZiAobGVhZF9vZmYgfHwgIShQQUdFX0FMSUdORUQoYnl0ZXMp
KSkgew0KPj4gKwkJCQlkZXZfd2FybihkZXYsICJGb3VuZCBwb2lzb24sIGJ1dCBhZGRyKCVwKSBh
bmQvb3IgYnl0ZXMoJSNseCkgbm90IHBhZ2UgYWxpZ25lZFxuIiwNCj4+ICsJCQkJCWFkZHIsIGJ5
dGVzKTsNCj4+ICsJCQkJcmV0dXJuIChzaXplX3QpIC1FSU87DQo+PiArCQkJfQ0KPj4gKwkJCXBt
ZW1fb2ZmID0gUEZOX1BIWVMocGdvZmYpICsgcG1lbS0+ZGF0YV9vZmZzZXQ7DQo+PiArCQkJaWYg
KHBtZW1fY2xlYXJfcG9pc29uKHBtZW0sIHBtZW1fb2ZmLCBieXRlcykgIT0NCj4+ICsJCQkJCQlC
TEtfU1RTX09LKQ0KPj4gKwkJCQlyZXR1cm4gKHNpemVfdCkgLUVJTzsNCj4+ICsJCX0NCj4+ICsJ
fQ0KPiANCj4gVGhpcyBpcyBpbiB0aGUgd3Jvbmcgc3BvdC4gIEFzIHNlZW4gaW4gbXkgV0lQIHNl
cmllcyBpbmRpdmlkdWFsIGRyaXZlcnMNCj4gcmVhbGx5IHNob3VsZCBub3QgaG9vayBpbnRvIGNv
cHlpbmcgdG8gYW5kIGZyb20gdGhlIGl0ZXIsIGJlY2F1c2UgaXQNCj4gcmVhbGx5IGlzIGp1c3Qg
b25lIHdheSB0byB3cml0ZSB0byBhIG52ZGltbS4gIEhvdyB3b3VsZCBkbS13cml0ZWNhY2hlDQo+
IGNsZWFyIHRoZSBlcnJvcnMgd2l0aCB0aGlzIHNjaGVtZT8NCg0KSG93IGRvZXMgZG0td3JpdGVj
YWNoZSBkZXRlY3QgYW5kIGNsZWFyIGVycm9ycyB0b2RheT8NCg0KPiANCj4gU28gSU1ITyBnb2lu
ZyBiYWNrIHRvIHRoZSBzZXBhcmF0ZSByZWNvdmVyeSBtZXRob2QgYXMgaW4geW91ciBwcmV2aW91
cw0KPiBwYXRjaCByZWFsbHkgaXMgdGhlIHdheSB0byBnby4gIElmL3doZW4gdGhlIDY0LWJpdCBz
dG9yZSBoYXBwZW5zIHdlDQo+IG5lZWQgdG8gZmlndXJlIG91dCBhIGdvb2Qgd2F5IHRvIGNsZWFy
IHRoZSBiYWQgYmxvY2sgbGlzdCBmb3IgdGhhdC4NCj4gDQpZZWFoLCB0aGUgc2VwYXJhdGUgLmRh
eF9jbGVhcl9wb2lzb24gQVBJIG1heSBub3QgYmUgYXJiaXRyYXJpbHkgY2FsbGVkDQp0aG91Z2gu
IEl0IG11c3QgYmUgZm9sbG93ZWQgYnkgYSAnd3JpdGUnIG9wZXJhdGlvbiwgYW5kIHNvLCB1bmxl
c3Mgd2UNCmJpbmQgdGhlIHR3byBvcGVyYXRpb25zIHRvZ2V0aGVyLCBob3cgZG8gd2UgZW5mb3Jj
ZSB0aGF0IHRvIGF2b2lkDQpzaWxlbnQgZGF0YSBjb3JydXB0aW9uPw0KDQp0aGFua3MhDQotamFu
ZQ0KDQoNCg0K
