Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAF437F55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhJVUdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:33:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18276 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232411AbhJVUc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:32:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MJ9Wwh026091;
        Fri, 22 Oct 2021 20:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ggxet7YO3UcD+U3gg3tBn4SjGurKhHPkFn7lcxw0sd8=;
 b=sfJuo87SuBWLMO2JkkcAP7vEhA1btI7vtO73WnAwiM9+mToZQVeN/3ie+Qp7vm3hkf6H
 dkeCBTBAxpkkQ30RA5gcYJfzeSJk+B+rbQ08vNdHCz3GqXpx4WgZobrWhB9cUuUT/7Pb
 leVQAkdUgUOUtoIdHDuzkkvUUVRO/RtKykw2GYJhBQAp/9p0R5E++CV4aHk87KrZA/x/
 Hj5B+jKUZsGdioYoWeJTeIgrZRiHrJxgjHJZ0JMQTX6F93k7C6Mrw41c2u/OHOguJSjy
 GuURN5dodHzRecA2Z2UcVT2vLQMAjbrtR934Dgg1MUJtx4XhNbtad/yzxBUY3al6h5kz Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bundfmffv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:30:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MKLJ0L161436;
        Fri, 22 Oct 2021 20:30:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3bqpjb59t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj0ymE2kRxnyI4SHqY4KYsv8zYRKT08TwSN99+78UZPxQ1Ni9j6wwoAQSvuEQ9ef3t6lJi5dBi5kqLpvEoAnyhd/51mznCKCpwjJzCkoTf33vxuv4R/BkF4afzKsPQHokKV5bU0An7IPUUBH828HVuTXP6pYSa/qDBb6wHMGUoWkBxtExkbankxjYvd+SBOJcKEd780qkU0jxQEmZkHWoNwQm52udvpD98UWSVg6C/ZfYw1eW0igPRpXzj7mHHf8abP6JlZe7+JfK7/vKeUPwA462Z7M7JHcSxW/ZK2BJzdVsosjR/Di9VfV2HeF3QR9nVjtNihqZs0dewZuOrEvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggxet7YO3UcD+U3gg3tBn4SjGurKhHPkFn7lcxw0sd8=;
 b=YUxZmCmq6e9kYBfGWHCy587qRWtZakCYxQvqXeR4BzQFYaFCDiOa3w7b2JCtHJGyAQwWVyjMYZLiOi00TCm10D5ajOjx7HDxNW9NswRpbZ5DucPHnrTt2Vodjt4Va6KC0DuG2FSWIgVjbbBnN6FMlV57FyU8tkxK+2DvpLpYIAu8VbQdmiqTrTCqAo9VL2nj4kN0ORbPvsz0EBd07Hvo7ap4dUd80vPSo42OzUo4coWviM9xl0p0Ptg9ZY596UJimIVW0nzslY9dRVU/r+lunJZWZqsKAUw2dJYbJw5neojXxI7Bsgnd3544mWMrjgV+Jd0dNFpFby9iAMAADgtN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggxet7YO3UcD+U3gg3tBn4SjGurKhHPkFn7lcxw0sd8=;
 b=qmSD0C8njfskATZwfjPiQ5GILyiTq46jLDi7d0PG3Jrzi4sOyq7wkTNZ+45N6+/WUHagMKi+9qwph6ytUuTy659Vu9EGTfT/cMbX2PwN0X5Zo/CyJeLQKp+ONQVHIHhegQ04rjusZl4XBg9Fv1GpKVRh89OZkGLCjzYLsRK5BO8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2919.namprd10.prod.outlook.com (2603:10b6:a03:89::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 20:30:29 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 20:30:29 +0000
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
Thread-Index: AQHXxhA/migZDNV1a0+SBofbRrgPHKvdURMAgADgEICAAE9xgIAA+peA
Date:   Fri, 22 Oct 2021 20:30:28 +0000
Message-ID: <600a0bb0-06a8-ea7d-47ad-c0e26b1c6668@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-5-jane.chu@oracle.com>
 <YXFOlKWUuwFUJxUZ@infradead.org>
 <325baeaf-54f6-dea0-ed2b-6be5a2ec47db@oracle.com>
 <YXJNLTmcPaShrLoT@infradead.org>
In-Reply-To: <YXJNLTmcPaShrLoT@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f43cb01e-36dd-4be1-6a76-08d9959ac9a6
x-ms-traffictypediagnostic: BYAPR10MB2919:
x-microsoft-antispam-prvs: <BYAPR10MB2919F68B9A1C363E818FCF52F3809@BYAPR10MB2919.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 673TY0/KY78NKVEskN9jdnBeZYZ3yINOUhU6jy7qhy9g1exHcZQEV0Kx9PYKojXM6q+9TYsrK5IQdeLGhTIItla805FOSl7QWeqIk2rwNBWKojsY3XM2gzsNi6A4BoJdhcHVYpw99fKdEpZ5jM5QYlL2IT+gFATQVPU2nCzRlKU9fXANGzrbBnc4X2Ymi4WEOBtjdsgcTYB/qCoTpsZTrpSyS42BV5rlp4oBsJQiOfBEWFRAkmKGgSXqZH54JoM8etjB3FOSQqf3Gpi6AYSnXudK4DC9ceA4ofzQ9NoEHsOsjoprKMIxiLKYthntobaHY2vi4pTtoRLSAvpfo7VvL9MQegOPMWp81vcXeclQYdVj1U3R/fDvm/es/FmjTfQhMrZvFyxR47iDRsbrbD8HxAjSH2jxtZV5Y7qLCT1CV6/PuAvyQkc+kLMedEDoC45YuXm/MVI0pXhbcBW7C/pjmytbgj4I11LosobV8rVvgV6MHpod997X6u7FGh5uL5YHWtg4CIgeJ46+tAJW50CiG5cwn52WywJo1CODddkpJzOxhrME5KpClQ1CPmrRX/68i/jkrJ2qqzEl2IPQ3XIfnEihcvry97jldwm642BfuoHP+q/KGzqMQr4KM3w0BuigN8SnMZet9M6ZnTJSlZFAY2MS6PwbxqJRZuy80Ub+H0QxLZDk+MoxchcpbWoTFqYa3/dW2DhQdgWDv59pizqpIa3PwaErimkdA8pD8Q1BJ2Jl3jc6gNVL+fW9RK78lHddjziFaw7Ap9QlveA+Y/ey7BH/2F4oSi0HbU9RzuN3/left9DUfGzRJTzssDVKo+c8zP379CBk4/jPVcIIyPnh0iG875FThC6liJRpO9SHE10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(26005)(71200400001)(186003)(966005)(36756003)(66556008)(2616005)(31696002)(316002)(8676002)(5660300002)(6486002)(38070700005)(6512007)(83380400001)(4326008)(38100700002)(8936002)(76116006)(44832011)(2906002)(31686004)(6506007)(53546011)(508600001)(7416002)(66446008)(64756008)(66476007)(6916009)(86362001)(122000001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnNPYmFsOFdMUHhSSmtLZTl6bmhNVCthR3BlSEZ1TGZtdVN2c2xPUnZKcE1Q?=
 =?utf-8?B?QjFTTUdjTTJic3BGN09vSTlBR3R6KzhjYTBoMkxqRkJ4Vko1aGREOVlXaVM1?=
 =?utf-8?B?VnFuMGg2VGdpREZLUEJVMjJDLy9HMENuK29aYWZ1THlHV3pzUnJCRE0zY1hr?=
 =?utf-8?B?TjVFczlBUW5lcDVWaFRuMW9ldTlvYVI4b2xLNnpUZ0swNThJMWkyMEg1MEtp?=
 =?utf-8?B?ay80R0dhelFUbkVrMmtwVnIvVVdEWUsvZnBkQThUZEZlVUxwWXY5U3ZLOFlO?=
 =?utf-8?B?L1hCTGpJWFMrWE5GclFab1g5Y2ZaSnNUOHpQSFVQU3BxUTRvRGZ4bFhxZXps?=
 =?utf-8?B?YWZ6N2grSkk4Y2NJb2d0ZVAxS3JNQk5yc0JHd204UWhzZHJXRVAzVE9xUUNU?=
 =?utf-8?B?RG9TU1RiRHluRXZqOUc3OFRFeXhybTN6NWVFaGZhcXI5dVBnUEpQcC82R2lF?=
 =?utf-8?B?Y001VDBReE9qMC9RVzZQMnhldWFHSEJCT0M1NjNSWVhzWVo1SXhYTzhOclNB?=
 =?utf-8?B?dUpzUnB5SWtHaE56LzVSOUJXTXNrLzFRaUVZZXBybWJMdURZMHdUeTQwS3JI?=
 =?utf-8?B?NjROeHI0TC9SaENaNnpDMGFmV0ZiMkJhYktFUzFVOWRiTi9XZWI0WnBqK0Zj?=
 =?utf-8?B?RnRlMlVmRVJhclFodFlzbERxQ3AwZ3dQcmszVG9kRnpEaTJLUXEwdExWM0x5?=
 =?utf-8?B?MGc5SUNMcVFVaFJCYm5wMTBFdlJIWFpORHl0M21rZUd3SkVaTm5xc1huNHZy?=
 =?utf-8?B?VllSSmV2TVF5MThkcFpQZzNhVTFNR3hOUUFreE9mWGNsbGNKMmNTbUYzSUta?=
 =?utf-8?B?TjNxOVJxTFYzSHRTQmN5RFRrU2xKQlVBa1Z4TnY1ZlRNYzBkVGNMNlpvdGZj?=
 =?utf-8?B?WVBZV2ptSDZNdlNmUDl2Sk1zMVVXQXh5bE1NRFpkeTNCQ01vQVFsYlZIakpZ?=
 =?utf-8?B?L09iR2pySDhCNUlWc3BoWnFnNEh4bzRFQk9LU2dXY0RkVHhiNThiVDMwNGlM?=
 =?utf-8?B?MFAvbEZRV1Q4cytybEVNTi9NS2dSZ1dybjBTb3MrRlVBdkxucFdCcml3WXFU?=
 =?utf-8?B?eHhoY0w3Wm5tR0docjRCNWYzcDdaakxFaURldzV6Q3M2a3gyK0c1bnhWNkJO?=
 =?utf-8?B?amtiQ0dPRkJxRUduMkxwemN6dDFpRS94OVJGQ2ZZVmxaWWhUZ1MxQXp5Szdm?=
 =?utf-8?B?S2IwVG5DZ0hFOE16blBnQzNYL3pRN3NwSDgyVlZ3eUxLdVIwVjFveVAzNTZi?=
 =?utf-8?B?OHFhKzR5WDgxTzlQWlNobjZPL1EvMVpQL2FlYlMrMUtheHdnV1V4MTgyZENG?=
 =?utf-8?B?WFZuaElKZFRJeVgyNldzNGJkUGt5ck1NYjRCTTVBQm5HblEwMmZQNnBVL0VD?=
 =?utf-8?B?TFJObThVbFB1OHdNblAzOXlGSTFuV3BqNVJLT3RBeWViUkliNnEzbEYvTmha?=
 =?utf-8?B?elNOWGhUeTJKSTI4NG5pM1ZWK1FRVXFsTEFFdklyc2lQb0tVMnp2ZFFWUUty?=
 =?utf-8?B?SEFmdGdzV0hldzU4SXZkWnlCRDhQTU0zTW1kN1J6TkFOVFlPcHZtcFpmN3du?=
 =?utf-8?B?WktNbXI5aUw4bFhGRGlpWlVYK1V2bnZHRFNybVNWSnVRcFpCaW04Y3NoYkpt?=
 =?utf-8?B?TmduNVYzSUp0QXdUZWRFT3piU0hyV0VDZk8rK2F5dEdiT0FaaDBFM2V4MDBz?=
 =?utf-8?B?T2NBSEVlVGt3WDFtNXFpNUJBZ0tKRDArV3ZiWWdTZEpvUVNtS1poQXo4VnE3?=
 =?utf-8?Q?CZ2AKJR4vkSRmrjDWw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FE03E6769CEC14DA622BC8B5CFF31F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43cb01e-36dd-4be1-6a76-08d9959ac9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 20:30:28.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2919
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220114
X-Proofpoint-ORIG-GUID: 2oiQaB9DpzfbKOXJCJM56BWOaK6LxeLT
X-Proofpoint-GUID: 2oiQaB9DpzfbKOXJCJM56BWOaK6LxeLT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSAxMDozMyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZy
aSwgT2N0IDIyLCAyMDIxIGF0IDEyOjQ5OjE1QU0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4g
SSd2ZSBsb29rZWQgdGhyb3VnaCB5b3VyICJmdXRoZXIgZGVjb3VwbGUgREFYIGZyb20gYmxvY2sg
ZGV2aWNlcyIgc2VyaWVzDQo+PiBhbmQgbGlrZXMgdGhlIHVzZSBvZiB4YXJyYXkgaW4gcGxhY2Ug
b2YgdGhlIGhvc3QgaGFzaCBsaXN0Lg0KPj4gV2hpY2ggdXBzdHJlYW0gdmVyc2lvbiBpcyB0aGUg
c2VyaWVzIGJhc2VkIHVwb24/DQo+PiBJZiBpdCdzIGJhc2VkIG9uIHlvdXIgZGV2ZWxvcG1lbnQg
cmVwbywgSSdkIGJlIGhhcHB5IHRvIHRha2UgYSBjbG9uZQ0KPj4gYW5kIHJlYmFzZSBteSBwYXRj
aGVzIG9uIHlvdXJzIGlmIHlvdSBwcm92aWRlIGEgbGluay4gUGxlYXNlIGxldCBtZQ0KPj4ga25v
dyB0aGUgYmVzdCB3YXkgdG8gY29vcGVyYXRlLg0KPiANCj4gSXQgaXMgYmFzZWQgb24gbGludXgt
bmV4dCBmcm9tIHdoZW4gaXQgd2FzIHBvc3RlZC4gIEEgZ2l0IHRyZWUgaXMgaGVyZToNCj4gDQo+
IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQvc2hvcnRsb2cvcmVm
cy9oZWFkcy9kYXgtYmxvY2stY2xlYW51cA0KPiANCj4+IFRoYXQgc2FpZCwgSSdtIHVuY2xlYXIg
YXQgd2hhdCB5b3UncmUgdHJ5aW5nIHRvIHN1Z2dlc3Qgd2l0aCByZXNwZWN0DQo+PiB0byB0aGUg
J0RBWERFVl9GX1JFQ09WRVJZJyBmbGFnLiAgVGhlIGZsYWcgY2FtZSBmcm9tIHVwcGVyIGRheC1m
cw0KPj4gY2FsbCBzdGFjayB0byB0aGUgZG0gdGFyZ2V0IGxheWVyLCBhbmQgdGhlIGRtIHRhcmdl
dHMgYXJlIGVxdWlwcGVkDQo+PiB3aXRoIGhhbmRsaW5nIHBtZW0gZHJpdmVyIHNwZWNpZmljIHRh
c2ssIHNvIGl0IGFwcGVhcnMgdGhhdCB0aGUgZmxhZw0KPj4gd291bGQgbmVlZCB0byBiZSBwYXNz
ZWQgZG93biB0byB0aGUgbmF0aXZlIHBtZW0gbGF5ZXIsIHJpZ2h0Pw0KPj4gQW0gSSB0b3RhbGx5
IG1pc3NpbmcgeW91ciBwb2ludD8NCj4gDQo+IFdlJ2xsIG5lZWQgdG8gcGFzcyBpdCB0aHJvdWdo
IChhc3N1bWluZyB3ZSB3YW50IHRvIGtlZXAgc3VwcG9ydGluZw0KPiBkbSwgc2VlIHRoZSByZWNl
bnQgZGlzY3Vzc2lvbiB3aXRoIERhbikuDQo+IA0KPiBGWUksIGhlcmUgaXMgYSBza2V0Y2ggd2hl
cmUgSSdkIGxpa2UgdG8gbW92ZSB0bywgYnV0IHRoaXMgaXNuJ3QgcHJvcGVybHkNCj4gdGVzdGVk
IHlldDoNCj4gDQo+IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQv
c2hvcnRsb2cvcmVmcy9oZWFkcy9kYXgtZGV2aXJ0dWFsaXplDQo+IA0KPiBUbyBzdXBwb3J0IHNv
bWV0aGluZyBsaWtlIERBWERFVl9GX1JFQ09WRVJZd2UnZCBuZWVkIGEgc2VwYXJhdGUNCj4gZGF4
X29wZXJhdGlvbnMgbWV0aG9kcy4gIFdoaWNoIHRvIG1lIHN1Z2dlc3QgaXQgcHJvYmFibHkgc2hv
dWxkIGJlDQo+IGEgZGlmZmVyZW50IG9wZXJhdGlvbiAoZmFsbG9jYXRlIC8gaW9jdGwgLyBldGMp
IGFzIERhcnJpY2sgZGlkIGVhcmxpZXIuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBpbmZvIQ0KLWph
bmUNCg==
