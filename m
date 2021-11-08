Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96114449D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhKHUqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 15:46:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64880 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhKHUqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:46:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JxiuM028580;
        Mon, 8 Nov 2021 20:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zvqkKHZ5yfAUAN8QFsVSFj7iaegjjUweZp6CxTk5TMo=;
 b=oyHjcSAkw0QLWxK14MnPRAfz/bmqFB53bEO8lOdNzB6JeVZdaLu76wNnlQudac30Bk+G
 YqEXY0n0e9EPtMeEuAOdhDtECqLkan2IOmr8oZpImyQzzV4SEQyv9dBUz2qd50F6J3pw
 lhkR8n+m7NMbvSO9NPhaBv/TXFHjF4qijF9xBHK0oYIGTE2MOwwSD+EQ03FucZk0MAtX
 FkH1UR9nqwyMnDceXV/xxo1j3DpU8fZpLYmgkpHZp9D+dpHAAge5vCc7TTtcCyCvJPds
 aBaJx9eFjE+exEEH/QLTSlUSlDBypTkzldIaaXqSRYy/V3HwzRHc7fADtiGtBCHmIqOK zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6st8pctd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 20:43:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8Kad7O016545;
        Mon, 8 Nov 2021 20:43:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3c63frv93q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 20:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ7dkQ64JsUHdQlr7rXXyB3Yete3PYIZZ+gu4sCdPGBTvOltUyS3bNWA67ZkM2LEWjl3Bx3BDrOX5m5+lxpPgux4azEuncyNo/JaZHMOimZHrbyD8pVBsTBcDp7FIpTn9LIkEJd3TkkVKP03LakZUk2qaXhbOdXNpBvnEIQSo0uah6HIMUSdJVP4NLaubNypHwcS1+y7+Ia8L6IGkUVFOJ+x0IV5C4EsOl1jay/cqryT2ryHwWBrGb02nZJUBRKnqcrIlctJsGkmguk0r1JvRay2gR1HX2ZRlMstgKXfMUmgdfEw1Fjx1ruoqawwPXWEZKiHVTgupiHyT+KmbD/B2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvqkKHZ5yfAUAN8QFsVSFj7iaegjjUweZp6CxTk5TMo=;
 b=oW5TDf2zBMjtaIgqdkCGzZz/uRg+2N3AQM8SczUxgoyqy01agQGkcDdQPnM2NLLo/krVX7O33WSRNweyZVA7fLKS6oi+i5NGDl7nGe1MKhG71MttDdT3PygRRHujgyYu8SPtjZLzl15I5pJaZa4Vt5OcB/1h/mM99adcxGu5U+YGctO2/i8l7sKzpOj0qYdfHo3KR4xYQM2Bh+J0h4b9COCTd1fuC3Lk8QIPQfB4dTq+xQkItjScuIWHLZmRjEBE670vih+lkqoUtEEcSXHXrySOQMEu9yVCTa8fsl8+CJBLDkb9s5jjCarkW+FUute8HwzHyFpPNM4i+bRFqrXing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvqkKHZ5yfAUAN8QFsVSFj7iaegjjUweZp6CxTk5TMo=;
 b=G55Rn5mBpXQYNWfdbcjG0Feyb51uD5QW28UN0K+oTniREb8jLqT/HfZP3Lq1xl0vvGNLsc78PqlPAAbBE6c3alRiWABPW+OiUsKt9s7h+RiJqIMbmLO+sVtZLDGbsBr/pet7XqJMvf0z5oS+wdsJrGAWbG0sEEcT88Y6qZmgcME=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3111.namprd10.prod.outlook.com (2603:10b6:a03:159::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 20:43:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 20:43:16 +0000
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
Subject: Re: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation
 modes
Thread-Topic: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation
 modes
Thread-Index: AQHX0qwD5+Ie66qqNUGG2WP/amHP1av1vCQAgARhBgA=
Date:   Mon, 8 Nov 2021 20:43:16 +0000
Message-ID: <7c8c71a4-ab7a-080e-1d61-d559003f052f@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-2-jane.chu@oracle.com>
 <20211106015058.GK2237511@magnolia>
In-Reply-To: <20211106015058.GK2237511@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f22a845-faee-473e-e207-08d9a2f86451
x-ms-traffictypediagnostic: BYAPR10MB3111:
x-microsoft-antispam-prvs: <BYAPR10MB311129F25AB57797C981EFC3F3919@BYAPR10MB3111.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUgBKSMvnZk6zCBga6XNNkCdNoB+UuMeaSZJ4CMOTk6gnBZfQG9wj8U8sw8wsf8VlSJKjnirqplKKmGTF1uo0sLyCnay9GE9PlPEql+C86xWJ2c9OJPqNW0axtK+gpU+j8TNMz3q1XRPjAjRux9TudJrnscxNA3WBAqlBXD0QhzATfl0QE+PA+O6X3UR1W/2y6rjLgaKH9uYEofY6esbVnuybPc3zqn4DT8lH6C2QXHsXzONZYol2BIJCa4Zm7O6QdVOoJFp7oRHa2O71K2rOrkEzXXogxfIn0jHvkEHdaWEyrAe9lXaH9F+QYQEUFBBJqc625/Ab2XLznPJ5cZCtcM7Lga7oBe+ZBEJt/fi+9+VWJCtk8zR9piR2hwKdsII7DV+CF8WR/muqiIviHEJadiFRlhQNmSjPAPjUDdpItIs1Rs+YqnhDSMki4KjgizNTE7mD3Y0slX1ONrKfy4uCKTOgavC7e5cMHUXHNxNrVrdDHCl7LaXY+/kSDX+wVexGJaHK8d1b0oZQk5598YncT8nPExi979C6sqcKjgZW5Xunvhrui8kuY9FyJtJPIxsHPDCBPkCJ6mtIq3mF32jKxQy1JEEZ3ChIIq0GZZlDEZadjasOqG05q/D/YOMdk0bPqoC5KyfbUgQB/r6whMMU/8IbVMZoSEfmf4uOYRJ3OB67QyaI2y98jg+BtM8ZinASb/D/mxhCjzoHsJ8IJGGMUUKerHyDRnvANdBB2G0yIj525ieAblVfacXiOVult/8CbKyxqLLoufpmB32724QPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(36756003)(76116006)(31696002)(66476007)(186003)(66556008)(66446008)(83380400001)(6512007)(508600001)(86362001)(31686004)(54906003)(2616005)(122000001)(6506007)(53546011)(64756008)(6916009)(44832011)(4326008)(5660300002)(6486002)(91956017)(66946007)(71200400001)(7416002)(8676002)(38070700005)(316002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vjh1ZG9Qb3F6cS9MUzJLN3ZjR3Y4OHdOaGVXRnl3NTNwZFN3TjFQRkRxNWJH?=
 =?utf-8?B?Wm8xQmw1Tk9sM3lvRkhMdDhFS1A2L1dQQXpaTzI2cXFmd3YreE9tblYydDNk?=
 =?utf-8?B?cXhoSUd4bDYxVGxHOGRTQlZMcWhpWmVRc2MwMVUwVGZnVWVpMSttMXYya25Z?=
 =?utf-8?B?RnJ0UU5ZRTlGSCtpK1ljTWRkSkVpQjJlVklYa2lNZXRqcFZWN0FtNHd6L1p1?=
 =?utf-8?B?WlJFUnhMNENQQzFDRmE1VHFwN2RVbUt1YnZWOWxmN2o3UUxHZzhJMWJiUURn?=
 =?utf-8?B?N1NLaUlIbWVjUHoyQ2llY3dxM0ZWYXlQMjdxQ05id1ByMFFoQU5OYVhhNlJK?=
 =?utf-8?B?RGl6eFJxT2RNZFJwc3I3MFZLWitvdEJMRmVYLzBMTUhiVlQydU10UDZiMmE3?=
 =?utf-8?B?dEpwZHVBVVBhZERGaEFUT0xYak5WUkliUmsvWUl1OXZlR3hzdFpmQm1rdkpM?=
 =?utf-8?B?OXhnc0ZFUUdBUTYyOWZxTTNjNDZ1V3BNWTU4OGlFRitmQkViWE0rZE1kaTJF?=
 =?utf-8?B?VmhUQ0Q5V25iK05vOElhREpqMDVsaHppcUxPUnhwOFRHQ1JCZFJtVHZQQzM4?=
 =?utf-8?B?UnFqZTRMTGN2UFJVNUdzTFZQMlpVUVp2aXZ3UWpCUUVQemdJOW9FbGpJU1o0?=
 =?utf-8?B?OFJORzhqbmVidnRXVW9JTnBEQUZ2R2R3ck83OVBsRmIrYXJuVDhEMnVreUpK?=
 =?utf-8?B?bDU1cGdIQklXajRVRUpGVFNCWWJ0NEF0YjVkYUJBTkhsVkdFdE1ybExGdE0x?=
 =?utf-8?B?Tit5dU1ZeXVIRXRmeTJIQ2ZxOGovVWwzQk5QbEcvS3RYWDVTUC84UmdwbkZD?=
 =?utf-8?B?eGtTS28zUDFHODNtOURoWm5IbVlRUnFFR1F1emIrNHlERE9kc3huSytKdVpZ?=
 =?utf-8?B?d0MycVU1L3NESk1mTWFXWnhEbG94U014dFZHRTZYRmZ4NE85Y2FSV2Q4Umlm?=
 =?utf-8?B?Nm5tRi9VRWZIK093VnJDTzRhZWU0VVpid254T1ZNTFlCbjJlWURDR0pheE53?=
 =?utf-8?B?VXUrUGppZ0JUT3NhNy9xM29NYzdiRGpJUFlDZkFBSSs4aHliYjBKeWVid055?=
 =?utf-8?B?Z3UwYkNaRGxrZi9hSlZhUGVpcDdMeWNOU0l4d2tma1czZ0xkNjgrUW5maDZR?=
 =?utf-8?B?ck04VjVuTm5jYzdQVERoY2FGNURHOWIxUUZFRXVZWGJuVjdvTXAzQVFMTE9U?=
 =?utf-8?B?K0g3ZGxmRnNORGJUVjM1aHVieGZlM3dCWWlNMFB4Q2NSaTZTbWNGQ0VBQnNG?=
 =?utf-8?B?dHhXQlRUTVZnNjhYSEs0S25iM21UMDV3Mno2cW1PbW9sQ2plMGF1ODQxVXVj?=
 =?utf-8?B?KzNPcjNudE5WN2xUTElPWEFxNWFBZ0VDM1lINkg1dHA4WnJGRXM4OW9ubWkw?=
 =?utf-8?B?QnpKcGEzYTBqMHJoOHJvQnFXV3BwdXVGTzRKclNSTzZXVlR5MGc0ZHJmQjcr?=
 =?utf-8?B?TnFVeVQzbHphU0syNXdGQlZZTWdVY0J4Mi9jUDJadUVIMC9KdXNkZlZWSXVX?=
 =?utf-8?B?dUJoVFdoRm9hbktRL3cxcU1sMXc5cGQrSmsxRkEyQzFNQUUwVGhaajlVc3VW?=
 =?utf-8?B?WEg5YUx0MktKdk1xaWt3cG5XR3dkZ29Ca1FxUE1CUmkwWGVmVlorcjc1Z3pl?=
 =?utf-8?B?cVdBUUpZTURuRzMwd2FzVFJ5cER0UFI2SkE4bkNxRlMvWlhPeWUyYzYvQk52?=
 =?utf-8?B?TWpqUk9sT24yMUxyc2dNK0ptZnBXa0Zocm5WQzN6SGVFOHJOOHJ0NFUzZWNp?=
 =?utf-8?B?Mnd6N24xVU9aVjBnejdVd0dMc1lOSE40VGtFcTJjQTJGejdYSnZjWGxOZkN6?=
 =?utf-8?B?UnNXMjluSUZXM1VaRjhub29qUCswcHhFMCt0eFprR2xERjlNTGNhcUdqNzJk?=
 =?utf-8?B?SHhYM2djaldrVDQ0aFFtMFp2REVWbUFVWFRHVEFNUjZEYm10OVE3aUFzb2RW?=
 =?utf-8?B?OHhmcWhkM2xFNFR4UWRtSU05ZlJRaWttRi9CVmNhY0NpRlVpaXZsMi9PbVlB?=
 =?utf-8?B?L3J2RHpyaTlueDBlQk56MzlTSnRGSzAzeDl1N0tQRnEzYm95TXVZUk1yc0Z1?=
 =?utf-8?B?QlFFbUgxVG1KZ1I4YVFzSE0wS1RLM2JyN1Y0TkdWRFp2TURUa2V0cnpYeVNp?=
 =?utf-8?B?c2dtMWFuSmZEQy9MLzNWY1dPQlRpN1lYNG5mRDFVU05Sd3VWUHRVWTZacXNv?=
 =?utf-8?Q?7/4/2jTW0m0r98W2Z9mFEwEbOJKHuWvGHvjvl/uriyH8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75AD54115B87654589DBDBC573D465C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f22a845-faee-473e-e207-08d9a2f86451
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 20:43:16.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/dNnDXsY0YsaOpAX83XqPEeqVlGy2V2s/e4FNrRjoyxqsnQ44jopxLE5+q18GEYn0YjR7kg9S1wXh+HPbN4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3111
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080121
X-Proofpoint-ORIG-GUID: kMM1QFaZcWaPW0Hw3-BQmWgy2LFi2shq
X-Proofpoint-GUID: kMM1QFaZcWaPW0Hw3-BQmWgy2LFi2shq
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNS8yMDIxIDY6NTAgUE0sIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gDQo+IDxzbmlw
Pg0KPiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RheC5oIGIvaW5jbHVkZS9saW51
eC9kYXguaA0KPj4gaW5kZXggMzI0MzYzYjc5OGVjLi45MzE1ODZkZjI5MDUgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2RheC5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RheC5oDQo+
PiBAQCAtOSw2ICs5LDEwIEBADQo+PiAgIC8qIEZsYWcgZm9yIHN5bmNocm9ub3VzIGZsdXNoICov
DQo+PiAgICNkZWZpbmUgREFYREVWX0ZfU1lOQyAoMVVMIDw8IDApDQo+PiAgIA0KPj4gKy8qIGRh
eCBvcGVyYXRpb24gbW9kZSBkeW5hbWljYWxseSBzZXQgYnkgY2FsbGVyICovDQo+PiArI2RlZmlu
ZQlEQVhfT1BfTk9STUFMCQkwDQo+PiArI2RlZmluZQlEQVhfT1BfUkVDT1ZFUlkJCTENCj4gDQo+
IE1vc3RseSBsb29rcyBvayB0byBtZSwgYnV0IHNpbmNlIHRoaXMgaXMgYW4gb3BlcmF0aW9uIG1v
ZGUsIHNob3VsZCB0aGlzDQo+IGJlIGFuIGVudW0gaW5zdGVhZCBvZiBhbiBpbnQ/DQoNClllYWgs
IEkgdHJpZWQgZW51bSBhdCBmaXJzdCwgYW5kIHRoZW4gbm90aWNlZCB0aGF0IHRoZQ0KbmV3IGRh
eCBlbnVtIHR5cGUgbmVlZCB0byBiZSBpbnRyb2R1Y2VkIHRvIGRldmljZS1tYXBwZXIuaA0KYnkg
ZWl0aGVyIGluY2x1ZGUgZGF4Lmggb3IgZGVmaW5lIGEgbWlycm9yZWQgZW51bSwgYW5kDQpJIHdv
bmRlcmVkIGlmIHRoYXQgd291bGQgYmUgYW4gb3ZlciBraWxsLCBzbyBJIGVuZGVkIHVwDQpzZXR0
bGUgb24gI2RlZmluZS4NCg0KPiANCj4gR3JhbnRlZCBJIGFsc28gdGhpbmsgc2l4IGFyZ3VtZW50
cyBpcyBhIGxvdC4uLiB0aG91Z2ggSSBkb24ndCByZWFsbHkNCj4gc2VlIGFueSBiZXR0ZXIgd2F5
IHRvIGRvIHRoaXMuDQoNCkRhbiBoYXMgYSBzdWdnZXN0aW9uLCBhbmQgdGhhdCdsbCByZWR1Y2Ug
dGhlIG51bWJlciBvZiBhcmdzIHRvIDUuDQo+IA0KPiAoRHVubm8sIEkgc3BlbnQgYWxsIGRheSBy
dW5uaW5nIGludGVybmFsIHBhdGNoZXMgdGhyb3VnaCB0aGUgcHJvY2Vzcw0KPiBnYXVudGxldCBz
byB0aGlzIGlzIHRoZSByZW1haW5pbmcgMiUgb2YgbXkgYnJhaW4gc3BlYWtpbmcuLi4pDQoNClRo
YW5rcyENCi1qYW5lDQoNCj4gDQo+IC0tRA0KPiANCg==
