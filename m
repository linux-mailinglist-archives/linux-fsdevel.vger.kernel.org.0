Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D23449D45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 21:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhKHU4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 15:56:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19224 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232955AbhKHU4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:56:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JxtMV020162;
        Mon, 8 Nov 2021 20:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RrgtVfbQRBOevhn6OceFUU3fis/18ps1JTbmZYIj2hQ=;
 b=EhKdr4mnsjYtVvMvxGbLsSdGKz6Q7918vjatPRdVBE7mx/y44PDH2mPrg446NI7z3vx9
 GyKqf3Q28OwnmvKP5VLZdwBK3x6BFkC7A/XzQi6/MFcYrE8UQywhOwmLlW1G+t4TTBw8
 VUdmIjJl2DumwnlY8a2MZLJC3YONlqLwSc5vNVFoxqFixc6eEw2Ut//nHoC8zFF8X9B7
 C3AtGouGuq5Yd6bK8iLsV3YP/jfdnaKtNfAH9hqnVewD/5qlVuiEGjcxK7QMUL/ML2no
 JPYZ5K1zghxcSfzC6CxHgZqADzqIst7t/nqlCrJXwLkuon54Lqfs9VczJO8fzPdtZnaD uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6t705uqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 20:53:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8Kob9c082661;
        Mon, 8 Nov 2021 20:53:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3020.oracle.com with ESMTP id 3c63frvq26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 20:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpfjKLK2hVJ1xsDWEX023OxjBORkffYPAkfyz7rmt2rE9TUtQ5luq/td96EReY0DEm13ir4sTNDcKuRPfEekGfBFN89jtmOjHAXmLqNUJJWW0QKYgzJzbbYCGTv9ATR8x9Hy1LpVxO3FKyvkWX4P8R8vLQAXGd6mxsRNwuH+dp2pUdWib7YXSCZv5a1QxaNbxtl7szhYvHzwwt4ohxBAeQWJnjxeFnJHtBum2Ca1NLhUddUsKdYW4U4OkykS0jrAyrlMPj60bt0wjpwQI1JAEySW8pq2eIwwxoUN/dEPvXWKg7gUFsNC4xo5PI6zuuKLU8nQIe8y8GQEDyUOX/L4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrgtVfbQRBOevhn6OceFUU3fis/18ps1JTbmZYIj2hQ=;
 b=X+YF2bMijh6fphLHeX2s0n/ggmmLEtQpzp87kw6JTadBzgK8+RFxTfNSFfGp+TL3jB/CuVjvq7PWc+bLrRT7KBWiQR8MU2sHVNs9hPbmW1mc9lOkk0H2oHfTraAQpoFrCq2Aj1pxT4+zxQfyLIt0dDDgzNKm/s4PvzNrwC75IB3zaynYN+jqmPamwYFgojdVRQe731jhrwQ+tbAdYoF16rXy4l7LKET+QQA19RnETz8J69LYip0DGG4N3coNYsSqBoK6HweHfeQJrW2KBbGnz5Y6hgfBbX/vf98GI3ZSYAHWuAePFV6UA0qPFL1BeQwpOV4FCNMIbea9B4l5/KTU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrgtVfbQRBOevhn6OceFUU3fis/18ps1JTbmZYIj2hQ=;
 b=WNgg51BP+uxHSkdXBfnvAL3m9g8W7gOeYp+w8gKiVRY4AfSv90XFXfoD4oWGckWLYBFpnS3Zo15PRGFTTDHWR1IsR9W6mUAzC52/aY3+tWXAhY3ZV7q6kh44oY5M+MARpB3ePcZxddr2eCuZ0E4JurWD8j3Wuw18/8QVDpzaR0Q=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 20:53:39 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 20:53:39 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
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
Thread-Index: AQHX0qwHA1irfgJJPUKt0/SD8Ofb86v1wA+AgARgAQA=
Date:   Mon, 8 Nov 2021 20:53:39 +0000
Message-ID: <b3ed6cbb-4993-7930-6020-635b19ff1273@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
 <20211106020459.GL2237511@magnolia>
In-Reply-To: <20211106020459.GL2237511@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31a5a4ef-df24-4f0d-c091-08d9a2f9d762
x-ms-traffictypediagnostic: SJ0PR10MB5647:
x-microsoft-antispam-prvs: <SJ0PR10MB5647832FB8C6AC9F40604892F3919@SJ0PR10MB5647.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /voTo9tCA052/+TyLr+n1AHcOoMAsqLKXqxtdUWxEcrU5fHnIm02lNKwEPmSewJEIHVcoyTGe4o7b7dBejUNwNbFh+5k1VZUKBexe8OyQ0ToNOsvhb3jUycPLCBdMePedCkVA1gmcgQjMERapORvcG4+ZcSh/PvihUQbQQVpv0B5ok1Xx/nPrCdrfCFOV2SNT04j9YLfxnwYdVAhTfgM20o5TiBnlsuaEaCyQiIYZcULfx5its2dA6i2ExfrplWlqgMmws1VavfqCrw6dlgaEMtHg20UlHOWdYtrb9o46Jx3n8gCazSORovsho+zaAq7M3KZT0hEN8bKIVFCkR6UzQfPA83et2T1ZuMwNVubOqQXKzr+h5KrDEcbMgRvm0eO8l1SX1iX1X8GtEl8TjI/pZeYdJ5eizt1iv9YljO+0vPe5oHh/aszt/oWC2eQl99WSJXSiNaBgXeiZOYMyaFp/36MsjJL4+WzoOFpE55n+FMl8XTRpzr4KfozPa9Rbl1EdNe2mcBU8rWAeaq9IBHKHsx8tyYXmwoDubK9WPGcu/xfuNePzTVanh/166tEKLWDgADvwAbYFTkHPQ92cMt0ApZnzKGZc3Olr968TtvPle6WUXuwoK2EDpnUZ30nll5q2gPRbk0V76ijgZtm8kNEL+XT1chEXhzQMwUtf9468aQsLrHfpjx3+tJzrIIfUf2zTRbfUMg60Qi6LBXdgkGaARABxdIgfHgQYBkdGm3CcTpIiZoUohcPQmaIBAfWozIJwsM+yNi4mnG5/Pxq3kLmIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(38100700002)(71200400001)(31686004)(66946007)(91956017)(7416002)(5660300002)(66476007)(316002)(36756003)(6916009)(53546011)(66446008)(66556008)(76116006)(8676002)(122000001)(64756008)(44832011)(8936002)(31696002)(83380400001)(38070700005)(86362001)(6506007)(508600001)(6486002)(4326008)(2616005)(54906003)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGxVdnpSYWhpM1JwVzQyU1RXb2xTeEtRb01zMi9nSlF5Zm11QjJadTZjYXpo?=
 =?utf-8?B?ZURpUUtMRHh6dlRnVnF5OXVHVWRDdkU0eWtYekZnNWJPbDJXMWNoUVJmMEhJ?=
 =?utf-8?B?bU1BamdhUTNtNFE3aE1sZEo5M2lrOCtCTlpqVUJmTU5FbHJpdVFDMzg1MTFt?=
 =?utf-8?B?OVBtZXprM20zd2RWV1NPd25hWUhFZmdUZDcrWUd1ekMxTzVKVE1oUTYyaDFI?=
 =?utf-8?B?aENJMkNRVkRuUkU4QXFycVBrb29GNFNCT0lodXNFSzM0RmMxSVBhT3JjNG5F?=
 =?utf-8?B?aTVOMTJLVzVEV2RCRGZyKzQ3TWlOQ2ZoWElmcWtWVFpmV1p4T1J6M2gzS2FF?=
 =?utf-8?B?ZDF4Y1NsbVV3QVJ3S1NzRzl1TlFmVVJ5OVlHYXR4M3pHYUJkbXZFRDk5bG5P?=
 =?utf-8?B?QndDNE5mcndYbk5xbWFKLzljdlQ1d1pCWkZqVWNHb1VDSlFDWnF1NmNFMzI0?=
 =?utf-8?B?NjhCSGZxNkU1dVZSRjFyWncyQy9LMk5ycEEvWGNKcDhsWFEzdzNOeE1mRnVM?=
 =?utf-8?B?WjhsZEM3Sk13MXFZM25Pby9QMW5QT1pYTmZ4WllXcnZ2aUhPV2hqUE1XQjhi?=
 =?utf-8?B?M0pMRmNhbHg0WXFubWc1RVZIa3RDblBMaDJsUlJhcndLSHA1T1NWNWxoVW9q?=
 =?utf-8?B?ZDBRWXZ3c3ZZZExuVHo5S2tNVzBMZmNKa3BWT3JQSFFWeFJSbnNFY0x4WnVK?=
 =?utf-8?B?Wk9ocWx2R1llVDBTZzZNSnh4aHU3eW1GVGxwbjhLOEtrdmljTm5IbzhoVi93?=
 =?utf-8?B?N2RJeUlLRUZDeEppTDR1WVRiRERjbjBmdC9qbWhLeDRzRGtDZEN1eERrZGtS?=
 =?utf-8?B?WjNoQzFkdHRpV0d5ZkZtSWxWN2lrem91Uzd1Sld5b0o0czJTUHlmdnhqcG1B?=
 =?utf-8?B?YXJiQUZLL3JtelR2bSt4TzZFeUo4M0M4S29UQ2RubmlOYmZrTE1CTkpSdjhF?=
 =?utf-8?B?L1Q0bGcwalc0TTRqdCtsbHRqRFF4U0Z5dE9DcGdwYnZmZVh4R0ZsTlJlUS9z?=
 =?utf-8?B?MkNzdU12eGNXSFl5cVd6NjFCWThCUGxlTWJaQTQ4YTV1SUtDZ2xPT1F3eCsv?=
 =?utf-8?B?ZTdOcUJOeng1cHlRajlQZmhXZm5KanFjOFQ5a2QvNGdhdFNCNnkvdXZuTTUw?=
 =?utf-8?B?Y3FPK1JkdUxWQUJmbWpPU0xWMmJ6ZVUySEkxdy91SlVKMnNFWkQyREpxSWRN?=
 =?utf-8?B?ZFA0S3NkMHI5M2VISUJZTzNLOXdOTTl0OVpwY3JuQ2NiNlQ3V01pOFJFcjlK?=
 =?utf-8?B?NmNTNEpLaDdhMDFMZDBkSXlhZGFnRTg3c2ZVTzBoNmFRKzlPSXVpRlBBd3FC?=
 =?utf-8?B?UGtUeE9JUndod1RoTEZaK1lvd2ViSzJxZmdNbGNUWVkvRkNjYXM3OGNpRktK?=
 =?utf-8?B?TDlWdUhCNkwyWWp1c0h5YWxmb0lDeWtvTjFsdGh4eUFBazBlZHRvN1JsRlN3?=
 =?utf-8?B?aXZYUFI3bm8yMVhJekR4ak5XbDFwb0xvMUJqUTBxY1hjcXU0WWg4Q2s1cjVN?=
 =?utf-8?B?cEJ1RGtWMzkwNGczemhqR1VqbEFsNkNPRHdUSnRtUmgzSTB0QnNHYmpqVS80?=
 =?utf-8?B?VzZROFcrSWkzNmNTZExOUkZ5YUxwd2FGVjBSR1lqckRXckNqaU9KZU9xRElj?=
 =?utf-8?B?TllFN1hyR3NON3VDa2VjSkZpN2VKU0p3NDhZa2hrSEdLOGE4VDJOcHhMcEVr?=
 =?utf-8?B?L1NkSGppMmM2U2U5cGQxNmZ5SGhWZDJ0bWFnZ2I0YTJBTWxqREZKd2oyMy9y?=
 =?utf-8?B?VkZ5RVdtaVU2dmxhU29XVzZDTlRJU21xRmFRdW43TTRCSklrUUxvaWlZVElW?=
 =?utf-8?B?dHRqd3NETGFLQWYwN0dGUFMrdXdpSDdZc0NlczFUWmpidXpxcmIzTXZsT1Rz?=
 =?utf-8?B?VlJmZ0FOVG1OZEdPMk1nd1Q1NVhoaEhvbHR2VjUrMXJ3SmhHbGlXSUdJSUxC?=
 =?utf-8?B?Z0ZSaDlSODdxaFVKN3pMMUxBZ3lpV0lFUWo1YjkrTlBNOGRpcnRVN01TZ0hT?=
 =?utf-8?B?NVlDSTlaVEYwdE5aMlBSOFVvYWpQMDl3UmNBZ092T0RjSFZvUXhkRjdmWGh4?=
 =?utf-8?B?Y3RWZU12WEhqY3pZdUhJZGVteC8xMUpReCtUUFNJbXdhd1ZkTFZ6enBDVmNy?=
 =?utf-8?B?NytKNXU3S0tGUStDZmNUZlRaNDczVmdCNGpYclE3RlByUHlvaTlCdWQvZ3F5?=
 =?utf-8?Q?OVJtvgOFHy2ajlc6kmtfc2vYWcQTMYg+kqKQXBozyazF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEE376727798434F84CF54E97B027533@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a5a4ef-df24-4f0d-c091-08d9a2f9d762
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 20:53:39.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jO7KYV5UkcCd70VO6WV/dqp5CAaNLLXVwUzoKVOPFXawdWCca3TYi+w+hRumOKdUvOB+pRcd9qGim8Nv6SXg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080123
X-Proofpoint-GUID: RE3F2MM2jaP60G1ooY-MC4BnFrGTz8AF
X-Proofpoint-ORIG-GUID: RE3F2MM2jaP60G1ooY-MC4BnFrGTz8AF
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNS8yMDIxIDc6MDQgUE0sIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCjxzbmlwPg0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLmMgYi9kcml2ZXJzL21kL2RtLmMNCj4+IGlu
ZGV4IGRjMzU0ZGIyMmVmOS4uOWIzZGFjOTE2ZjIyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9t
ZC9kbS5jDQo+PiArKysgYi9kcml2ZXJzL21kL2RtLmMNCj4+IEBAIC0xMDQzLDYgKzEwNDMsNyBA
QCBzdGF0aWMgc2l6ZV90IGRtX2RheF9jb3B5X2Zyb21faXRlcihzdHJ1Y3QgZGF4X2RldmljZSAq
ZGF4X2RldiwgcGdvZmZfdCBwZ29mZiwNCj4+ICAgCWlmICghdGkpDQo+PiAgIAkJZ290byBvdXQ7
DQo+PiAgIAlpZiAoIXRpLT50eXBlLT5kYXhfY29weV9mcm9tX2l0ZXIpIHsNCj4+ICsJCVdBUk5f
T04obW9kZSA9PSBEQVhfT1BfUkVDT1ZFUlkpOw0KPj4gICAJCXJldCA9IGNvcHlfZnJvbV9pdGVy
KGFkZHIsIGJ5dGVzLCBpKTsNCj4+ICAgCQlnb3RvIG91dDsNCj4+ICAgCX0NCj4+IEBAIC0xMDY3
LDYgKzEwNjgsNyBAQCBzdGF0aWMgc2l6ZV90IGRtX2RheF9jb3B5X3RvX2l0ZXIoc3RydWN0IGRh
eF9kZXZpY2UgKmRheF9kZXYsIHBnb2ZmX3QgcGdvZmYsDQo+PiAgIAlpZiAoIXRpKQ0KPj4gICAJ
CWdvdG8gb3V0Ow0KPj4gICAJaWYgKCF0aS0+dHlwZS0+ZGF4X2NvcHlfdG9faXRlcikgew0KPj4g
KwkJV0FSTl9PTihtb2RlID09IERBWF9PUF9SRUNPVkVSWSk7DQo+IA0KPiBNYXliZSBqdXN0IHJl
dHVybiAtRU9QTk9UU1VQUCBoZXJlPw0KPiANCj4gV2FybmluZ3MgYXJlIGtpbmRhIGxvdWQuDQo+
IA0KDQpJbmRlZWQuICBMb29rcyBsaWtlIHRoZQ0KICAgImlmICghdGktPnR5cGUtPmRheF9jb3B5
X3RvX2l0ZXIpIHsiDQpjbGF1c2Ugd2FzIHRvIGFsbG93IG1peGVkIGRheCB0YXJnZXRzIGluIGRt
LCBzdWNoIGFzIGRjc3MsIGZ1c2UgYW5kDQp2aXJ0aW9fZnMgdGFyZ2V0cy4gVGhlc2UgdGFyZ2V0
cyBlaXRoZXIgZG9uJ3QgZXhwb3J0DQouZGF4X2NvcHlfZnJvbS90b19pdGVyLCBvciBkb24ndCBu
ZWVkIHRvLg0KQW5kIHRoZWlyIC5kYXhfZGlyZWN0X2FjY2VzcyBkb24ndCBjaGVjayBwb2lzb24s
IGFuZCBjYW4ndCByZXBhaXINCnBvaXNvbiBhbnl3YXkuDQoNCkkgdGhpbmsgdGhlc2UgdGFyZ2V0
cyBtYXkgc2FmZWx5IGlnbm9yZSB0aGUgZmxhZy4gIEhvd2V2ZXIsIHJldHVybmluZw0KLUVPUE5P
VFNVUFAgaXMgaGVscGZ1bCB0byBjYXRjaCBmdXR1cmUgYnVnLCBzdWNoIGFzIHNvbWVvbmUgYWRk
IGENCm1ldGhvZCB0byBkZXRlY3QgcG9pc29uLCBidXQgZGlkbid0IGFkZCBhIG1ldGhvZCB0byBj
bGVhciBwb2lzb24sIGluDQp0aGF0IGNhc2UsIHdlIGZhaWwgdGhlIGNhbGwuDQoNCkRhbiwgZG8g
eW91IGhhdmUgYSBwcmVmZXJlbmNlPw0KDQp0aGFua3MhDQotamFuZQ0KDQo=
