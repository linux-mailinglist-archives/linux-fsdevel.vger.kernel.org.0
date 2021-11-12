Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483EE44EC59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 19:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhKLSDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 13:03:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53188 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235570AbhKLSDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:03:30 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACH8XI3004095;
        Fri, 12 Nov 2021 18:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H66o6CAP+i2zte1Sq8JhPZigmHljBQtdf/8Ef6q2iv0=;
 b=ZGiV31+XiX3YECwHkH6ZdHtZS20/jER9T+jpEMd9PB6aOxsCtT1zgf1sPPJpfXlrfRDO
 y8WPlwYc0KdMQ/NU+3FZPG3PNyBP1MUcDkL2TD5eOGi3bDn/cTF/eXhuHjZrzt4the+6
 eNIHQu7C1uQ1b3IlRwzj9s3TtahUf4hBqE204jUGGvLU2zpQPITtcacGGNH9HUQdw7N3
 7Zr6rx/XAiBK0QvijFFwicE6Rx3uxxtbCGie/z2CZD9jEXjGc8E2iQzY7YgL/MuQD1Cr
 WH5/N/t4GrbG22oqmBwj/VB5qNQTQ4qi/hoBkFEM93Lt2t7SouGcAhyN26j2+gVLrHth 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c9t709mb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 18:00:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ACHoEer135322;
        Fri, 12 Nov 2021 18:00:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3c5frjt3e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 18:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpFJuDk2oTaZa6VQ9bKbFJlOxEdarjT3V9BeZdrTuYahDc9NEvYZ1DJVk0nD6K5r7fgObfXdcCVv10Ad11yg4QCP4TGdZnVLEUfmmSkB/OTp40qjTnU39dYGLtK5MEvtdakdUhExMEfMf+NM+s0UZcCxCy4SoqUGS1OzwsN8Ac4cS3Rs5PVMIbK63I6i/nVc/3CiyXkW8Dl53tjdQkNfXKlWnqz84MRTSXFLe3lsNDyXXwrKnHueiIuo6R5z8lepg0OrSSXkwoqd8Oxow/RdLcjgN5+HiQRnXUWsxqrdRUb8Sw/tVvJRa9dhQgCecOTzOIsUriEtpFOXNeoAqARirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H66o6CAP+i2zte1Sq8JhPZigmHljBQtdf/8Ef6q2iv0=;
 b=IfpMX66g4HpKZrzVdi41YfFqgPm0/RrK1vfD0K+qRfWYkvGcAeQ1QntwYFqDBH3M8qYDYgBp9fcQ1VCgkDqUg2e9nRfJm9q9q/h2mKa+esrl7BUu/WWdXel45msLheNSI+uBt0foWdEQ+yJTPVpBqsKoEGQKo5s2njJ7Y3b/pd0hHQKb784poYwRJWPMF3QrwZAzmcS6q0yx7tdALl9FjcitCuunV+Qww6Aw1BIipv1IY4+Vbo9tDWiLKr1Yo6pWvJJIR+eR9jEiv7CkCj4sYDmZ+IRTLcpyzuSa0ksPhYt6c0m34RYV4Wm81ajn6IOFVFBSSzQZ8WYUP/bedO/KoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H66o6CAP+i2zte1Sq8JhPZigmHljBQtdf/8Ef6q2iv0=;
 b=Mfty+iKq+chraNpf5J2bItgdpddI3de7NDa3WhR4Utq41uJuzzLlywzxKhxValxO9jMOWCdD7M1C2sRoy7EeDJxWgimGN43fR58RGbk1lGjuZ7ZH7wUsm5romxD3BV+xQMiCBnzZkqts0GB/AizCBjRxexJ98tnTQEDLZozl/Jg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB3922.namprd10.prod.outlook.com (2603:10b6:a03:1fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 18:00:02 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.019; Fri, 12 Nov 2021
 18:00:02 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Topic: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Index: AQHX0qwHA1irfgJJPUKt0/SD8Ofb86v60R0AgAC+aoCAABOLAIAAEcSAgAFmpACAAvVOAIAAKBmA
Date:   Fri, 12 Nov 2021 18:00:02 +0000
Message-ID: <5ca628b6-d5b6-f16a-480d-ea34dfc53aef@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
 <YYoi2JiwTtmxONvB@infradead.org>
 <CAPcyv4hQrUEhDOK-Ys1_=Sxb8f+GJZvpKZHTUPKQvVMaMe8XMg@mail.gmail.com>
 <15f01d51-2611-3566-0d08-bdfbec53f88c@oracle.com>
 <CAPcyv4gwbZ=Z6xCjDCASpkPnw1EC8NMAJDh9_sa3n2PAG5+zAA@mail.gmail.com>
 <795a0ced-68b4-4ed8-439b-c539942b925e@oracle.com>
 <YY6J/mdSmrfK8moV@redhat.com>
In-Reply-To: <YY6J/mdSmrfK8moV@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c9a576f-6521-4e49-a36b-08d9a606400f
x-ms-traffictypediagnostic: BY5PR10MB3922:
x-microsoft-antispam-prvs: <BY5PR10MB392212FB8D9F7006DB950554F3959@BY5PR10MB3922.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yq7tAWue4MvS4AAh85jWyPz1pMN20FzpRMZROrt+Jc5QNRVyz6LRN80CqwRP5ekubVgg2P3krlludMcZhnfoQNmvaPRezBk0+Q/1PUSlKiQFPRDkmw/q8SbUCMyIBrfGjlGRUC2dGJLGh8OUUKnM0Uixd3vc+7BKVE3b37F/t+FXBOza1FIWaAqYdbfryvk/hDAzRc2LlqxlWZGo6xq38/kWWk5heU9xM1OmGvAkdrileJFF5mg7mEzpvKcUz18/6nqNFEM6bieuRk6Hiu5wBWYAzCx2ehfUSyn/Fj+2vsZCBd7LqjDs/YPJFTZMzRZXwXBe0jrL3VV8EKI20BcWGtrslpDsgV/k3oAanyRkzsyGAV2IiiFoZKR7nFMGrXoCBKJIysb87q4nRGa24P5+pVTSf9jeeAz5vxAas9ELedu0CoYMVri1vWwz00s8J1WN4K+Bc4AWcsfqAtiXjnrI+2APhvfyYt0A7r9BauocoWc/Ogu0Lj7gXgjtlvHAZocaPHCIkylatdUMEosJIGd31j9MgaQwle8Dymyrb324ga2tlmoj1YzIVNzQO2T0o+4pHgjjF9ddKFAjSSXMQVIyu1op/irkL6xH0QV5q5TIWi7ZAlLKlUWMPZHVn5zQTCD7NF+2wzv96zw6btUPmWNuANKjNEFw2EEruO5r06DNzw/XIaKJINQcjBUvX7isBU74h+JxpT0thRk0RRkkpghLlmiVt7KpcA/1Jnsvzazpzum5otuwVb0jx5uv6VHF6XOmABXh+Iqd44C+BhRcHn/Jfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(54906003)(36756003)(76116006)(66556008)(66446008)(66946007)(7416002)(508600001)(6486002)(44832011)(122000001)(66476007)(5660300002)(2906002)(64756008)(2616005)(6916009)(186003)(53546011)(31686004)(6506007)(8676002)(86362001)(38100700002)(6512007)(8936002)(316002)(38070700005)(4326008)(71200400001)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5zS2hmM2s1TWs3bnI1b29ySDZyUys1TFNzWHAyWFhrKzBPQUtLYUE1UE95?=
 =?utf-8?B?UG9sanhQNVpzTjhySVF0VXRVaW1aSS9zQmtselJCb3ZIbHV1OUREcEJqdWdQ?=
 =?utf-8?B?YVRtT1FLUUlSNjJrMXhnbE1XVjZQeHpkNEhjRHJnYy9ndXFxODRwTDErSzFh?=
 =?utf-8?B?ZEVVbDhBRSs0NmxtcHhsbFVQa1JvL01kdHJZenZ2Y2lkRFl6TmZiZExHSkhM?=
 =?utf-8?B?TS9ydGltdS9TZmFCM2xENVJ1TFV0bVFlelBHVldadGFxNWpoWWlnTitLOHUr?=
 =?utf-8?B?ODI5amxKWUx6NTcxLzh0aHpPLzJ2NWtySWY1aHl1eUsyY01JZEZiZXNCekZj?=
 =?utf-8?B?b2Vkcis5TTlTNzJrK2VHVml0aURmUG14K1BZRjc4aXhpOEFPbHNOZ2tKZlU4?=
 =?utf-8?B?MWJWakZrWXdYZndtck1mR0RjUWtrUDlBN2ZTYm54ZUpTMkorUWkydDlDZTJ1?=
 =?utf-8?B?a1dqSFgxbTQxY3dZTjJSUk1wMlFLSmFoczE2Z0tHVkxQaE83WEI5RW9mZ1Av?=
 =?utf-8?B?OWpZd1lUcSs4S3gwOVFsaWlQV1prWDViUm9tc0k1d2UySTVqSXQ0SkpYQlIr?=
 =?utf-8?B?aWJjb0xBRS9pWUxXT1F3eGNVb21zSmJ2bmh0VGo1OUFuVzZIR1RUVWxteXVQ?=
 =?utf-8?B?T0J1REhrL04wRmxRcUdoOXZ4RXV1LzZUMGVQcEV4aXlVZ21LQnBnRE1WMENG?=
 =?utf-8?B?WnIzVlQvLzFCZWJNSkVvMjg4RXFsdGRPcjgzWnYrMXpkSk9RQmVyMkhHc3Rj?=
 =?utf-8?B?N3BXQVJiZnRVYmpOR05mTFpYRGVaSVpNeVRTNU10REdRa2tBZ3lSNStUOEJN?=
 =?utf-8?B?bllOYVdidWRIZE9Ed3ovN2VFWFpXQml2Q2VseTNTMXh3ajFFNkNkWENyMGQy?=
 =?utf-8?B?L3o5RFI3dWt5SGZuNXFaRURILzNCZkphb2U3aDNIZkFmejVXM004M0FKaVk3?=
 =?utf-8?B?Wm1hRXY1ZHAxZnNBRGtCayt3RktwUkgza1p4dXNuRjlSTkQ3Rk9IeE41anZO?=
 =?utf-8?B?K2RKWDR6bnVNWlNqaGZyRXlRaC9uNW1RWEt2WUVsUDBRbHhEUVZvV3o0QlRy?=
 =?utf-8?B?enFINHdQZkk5QlVQK0xPL1VsNnhDZkNUZ2NmMGJ1U3RNUGtBRnhlaHloQ1du?=
 =?utf-8?B?aW14UGQzMlhuRlJLVEU1Ty85OG8wUmdVTTVGeFlXWVhpL1NKbU9mRkpJWTlR?=
 =?utf-8?B?VzVlWWhVZVV6MmhKUXdlNzB2UWU2WjZmbWRVei9oQm1IanlnUkVrc1FIZk9a?=
 =?utf-8?B?S0Y2U05MUW96RlJSSmdrL0VmT3grVzRCMUpFSWpYWFgwblhVSm1RZFNyMWhF?=
 =?utf-8?B?Zk1yQ3BZV3AySnNVZXRFR2JSVGtUUEUzZitrVnRpN1ZONENJRU9jdFRuek5z?=
 =?utf-8?B?dEY3Q2xpWWZJZjN6ZnVJOUI4SEkrR255UlUwb0xFYTNPR3htSU9Nc3EvSTQr?=
 =?utf-8?B?OVp2YkFDM2VLaFJrRnFrZnFxd1pDalVDNHJOT21OZUxGVmZ6Y3dOWEdVMXp4?=
 =?utf-8?B?NWxFbUxSdWMweDM3NFprYmJMNWl5S2tiQktkM0QzbDg0QWg0V2JJWDlvWUhY?=
 =?utf-8?B?QnFmSkZvUTFPSEJXcUhuM25yakpmTGxCT0ZubXBwbG1xRjZpa2RSMVlYcmtL?=
 =?utf-8?B?ZUZuWll3SnRLbXpuOUk5OGladXZSV0QrYU5EclpKVzA2RXpSQnptMTkzTmtV?=
 =?utf-8?B?Y2NmYXltb1NUYkNoUGFtOWR5V2xNbFBSVmtFMGUxS3AwdGVjNjVYMm9KY3RZ?=
 =?utf-8?B?Zk5oZDRMQ2FySU0vUlIxRXdvbDZDSWMrUWdad0tMSEF2ZHR5U09iTU10dTFs?=
 =?utf-8?B?ZlgwNzNxd2E4bXVqZGdjMlNsdmRpdTdJMHBPV3E2QTcxNTNvMit6bUkzczRY?=
 =?utf-8?B?dTlTdEpEaktha3U2SGFpdUoyNjVnRXFNbDJndWY2SUl2ZGYxd0IwNTFVdlBt?=
 =?utf-8?B?MG1NV0ppeUx6UkhuVVkrckVkUjZjVDhZOEFhU3RTY09sZlNLbmszVWpkR0Nz?=
 =?utf-8?B?Q2VLSzZqckVZQWpieXE4SGRDUFhIK3Flc0lOSWtmd291TitpTmJzd2hrVVUw?=
 =?utf-8?B?UTE5YkZVTzdxeThxNGZBUDZxcWFyN1YzdG92bklQbHI0TWlXUTVabDNvaTFl?=
 =?utf-8?B?VnhZN20xcE1ic3VubklwenRtcHErOERrTnJvTk0vaDVNbE1EOWtuU1QzbE11?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBEC190E00E35044B00AC2CCD7CB1C3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9a576f-6521-4e49-a36b-08d9a606400f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 18:00:02.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IH7zaZ+FlNh7xt1xJHt/3OrNeFWRAX3NOsW2+SEOIAqcXDUU/LDDetflXBK5bAvPX8d+vosxo5RY0KSqO8CyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3922
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120098
X-Proofpoint-GUID: 1nwcnBZaWSWA2t3kEaJP9fnp5s3Z9qYZ
X-Proofpoint-ORIG-GUID: 1nwcnBZaWSWA2t3kEaJP9fnp5s3Z9qYZ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMTIvMjAyMSA3OjM2IEFNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+IE9uIFdlZCwgTm92
IDEwIDIwMjEgYXQgIDE6MjZQIC0wNTAwLA0KPiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNv
bT4gd3JvdGU6DQo+IA0KPj4gT24gMTEvOS8yMDIxIDE6MDIgUE0sIERhbiBXaWxsaWFtcyB3cm90
ZToNCj4+PiBPbiBUdWUsIE5vdiA5LCAyMDIxIGF0IDExOjU5IEFNIEphbmUgQ2h1IDxqYW5lLmNo
dUBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gMTEvOS8yMDIxIDEwOjQ4IEFNLCBE
YW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4+PiBPbiBNb24sIE5vdiA4LCAyMDIxIGF0IDExOjI3IFBN
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+Pj4+Pj4NCj4+
Pj4+PiBPbiBGcmksIE5vdiAwNSwgMjAyMSBhdCAwNzoxNjozOFBNIC0wNjAwLCBKYW5lIENodSB3
cm90ZToNCj4+Pj4+Pj4gICAgIHN0YXRpYyBzaXplX3QgcG1lbV9jb3B5X2Zyb21faXRlcihzdHJ1
Y3QgZGF4X2RldmljZSAqZGF4X2RldiwgcGdvZmZfdCBwZ29mZiwNCj4+Pj4+Pj4gICAgICAgICAg
ICAgICAgICB2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSwgaW50
IG1vZGUpDQo+Pj4+Pj4+ICAgICB7DQo+Pj4+Pj4+ICsgICAgIHBoeXNfYWRkcl90IHBtZW1fb2Zm
Ow0KPj4+Pj4+PiArICAgICBzaXplX3QgbGVuLCBsZWFkX29mZjsNCj4+Pj4+Pj4gKyAgICAgc3Ry
dWN0IHBtZW1fZGV2aWNlICpwbWVtID0gZGF4X2dldF9wcml2YXRlKGRheF9kZXYpOw0KPj4+Pj4+
PiArICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwbWVtLT5iYi5kZXY7DQo+Pj4+Pj4+ICsNCj4+
Pj4+Pj4gKyAgICAgaWYgKHVubGlrZWx5KG1vZGUgPT0gREFYX09QX1JFQ09WRVJZKSkgew0KPj4+
Pj4+PiArICAgICAgICAgICAgIGxlYWRfb2ZmID0gKHVuc2lnbmVkIGxvbmcpYWRkciAmIH5QQUdF
X01BU0s7DQo+Pj4+Pj4+ICsgICAgICAgICAgICAgbGVuID0gUEZOX1BIWVMoUEZOX1VQKGxlYWRf
b2ZmICsgYnl0ZXMpKTsNCj4+Pj4+Pj4gKyAgICAgICAgICAgICBpZiAoaXNfYmFkX3BtZW0oJnBt
ZW0tPmJiLCBQRk5fUEhZUyhwZ29mZikgLyA1MTIsIGxlbikpIHsNCj4+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmIChsZWFkX29mZiB8fCAhKFBBR0VfQUxJR05FRChieXRlcykpKSB7DQo+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIkZvdW5k
IHBvaXNvbiwgYnV0IGFkZHIoJXApIGFuZC9vciBieXRlcyglI2x4KSBub3QgcGFnZSBhbGlnbmVk
XG4iLA0KPj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIs
IGJ5dGVzKTsNCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIChz
aXplX3QpIC1FSU87DQo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICB9DQo+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICBwbWVtX29mZiA9IFBGTl9QSFlTKHBnb2ZmKSArIHBtZW0tPmRh
dGFfb2Zmc2V0Ow0KPj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKHBtZW1fY2xlYXJf
cG9pc29uKHBtZW0sIHBtZW1fb2ZmLCBieXRlcykgIT0NCj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJMS19TVFNfT0spDQo+Pj4+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAoc2l6ZV90KSAtRUlPOw0KPj4+Pj4+PiAr
ICAgICAgICAgICAgIH0NCj4+Pj4+Pj4gKyAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBpcyBp
biB0aGUgd3Jvbmcgc3BvdC4gIEFzIHNlZW4gaW4gbXkgV0lQIHNlcmllcyBpbmRpdmlkdWFsIGRy
aXZlcnMNCj4+Pj4+PiByZWFsbHkgc2hvdWxkIG5vdCBob29rIGludG8gY29weWluZyB0byBhbmQg
ZnJvbSB0aGUgaXRlciwgYmVjYXVzZSBpdA0KPj4+Pj4+IHJlYWxseSBpcyBqdXN0IG9uZSB3YXkg
dG8gd3JpdGUgdG8gYSBudmRpbW0uICBIb3cgd291bGQgZG0td3JpdGVjYWNoZQ0KPj4+Pj4+IGNs
ZWFyIHRoZSBlcnJvcnMgd2l0aCB0aGlzIHNjaGVtZT8NCj4+Pj4+Pg0KPj4+Pj4+IFNvIElNSE8g
Z29pbmcgYmFjayB0byB0aGUgc2VwYXJhdGUgcmVjb3ZlcnkgbWV0aG9kIGFzIGluIHlvdXIgcHJl
dmlvdXMNCj4+Pj4+PiBwYXRjaCByZWFsbHkgaXMgdGhlIHdheSB0byBnby4gIElmL3doZW4gdGhl
IDY0LWJpdCBzdG9yZSBoYXBwZW5zIHdlDQo+Pj4+Pj4gbmVlZCB0byBmaWd1cmUgb3V0IGEgZ29v
ZCB3YXkgdG8gY2xlYXIgdGhlIGJhZCBibG9jayBsaXN0IGZvciB0aGF0Lg0KPj4+Pj4NCj4+Pj4+
IEkgdGhpbmsgd2UganVzdCBtYWtlIGVycm9yIG1hbmFnZW1lbnQgYSBmaXJzdCBjbGFzcyBjaXRp
emVuIG9mIGENCj4+Pj4+IGRheC1kZXZpY2UgYW5kIHN0b3AgYWJzdHJhY3RpbmcgaXQgYmVoaW5k
IGEgZHJpdmVyIGNhbGxiYWNrLiBUaGF0IHdheQ0KPj4+Pj4gdGhlIGRyaXZlciB0aGF0IHJlZ2lz
dGVycyB0aGUgZGF4LWRldmljZSBjYW4gb3B0aW9uYWxseSByZWdpc3RlciBlcnJvcg0KPj4+Pj4g
bWFuYWdlbWVudCBhcyB3ZWxsLiBUaGVuIGZzZGF4IHBhdGggY2FuIGRvOg0KPj4+Pj4NCj4+Pj4+
ICAgICAgICAgICAgcmMgPSBkYXhfZGlyZWN0X2FjY2VzcyguLi4sICZrYWRkciwgLi4uKTsNCj4+
Pj4+ICAgICAgICAgICAgaWYgKHVubGlrZWx5KHJjKSkgew0KPj4+Pj4gICAgICAgICAgICAgICAg
ICAgIGthZGRyID0gZGF4X21rX3JlY292ZXJ5KGthZGRyKTsNCj4+Pj4NCj4+Pj4gU29ycnksIHdo
YXQgZG9lcyBkYXhfbWtfcmVjb3Zlcnkoa2FkZHIpIGRvPw0KPj4+DQo+Pj4gSSB3YXMgdGhpbmtp
bmcgdGhpcyBqdXN0IGRvZXMgdGhlIGhhY2tlcnkgdG8gc2V0IGEgZmxhZyBiaXQgaW4gdGhlDQo+
Pj4gcG9pbnRlciwgc29tZXRoaW5nIGxpa2U6DQo+Pj4NCj4+PiByZXR1cm4gKHZvaWQgKikgKCh1
bnNpZ25lZCBsb25nKSBrYWRkciB8IERBWF9SRUNPVkVSWSkNCj4+DQo+PiBPa2F5LCBob3cgYWJv
dXQgY2FsbCBpdCBkYXhfcHJlcF9yZWNvdmVyeSgpPw0KPj4NCj4+Pg0KPj4+Pg0KPj4+Pj4gICAg
ICAgICAgICAgICAgICAgIGRheF9kaXJlY3RfYWNjZXNzKC4uLiwgJmthZGRyLCAuLi4pOw0KPj4+
Pj4gICAgICAgICAgICAgICAgICAgIHJldHVybiBkYXhfcmVjb3Zlcnlfe3JlYWQsd3JpdGV9KC4u
Liwga2FkZHIsIC4uLik7DQo+Pj4+PiAgICAgICAgICAgIH0NCj4+Pj4+ICAgICAgICAgICAgcmV0
dXJuIGNvcHlfe21jX3RvX2l0ZXIsZnJvbV9pdGVyX2ZsdXNoY2FjaGV9KC4uLik7DQo+Pj4+Pg0K
Pj4+Pj4gV2hlcmUsIHRoZSByZWNvdmVyeSB2ZXJzaW9uIG9mIGRheF9kaXJlY3RfYWNjZXNzKCkg
aGFzIHRoZSBvcHBvcnR1bml0eQ0KPj4+Pj4gdG8gY2hhbmdlIHRoZSBwYWdlIHBlcm1pc3Npb25z
IC8gdXNlIGFuIGFsaWFzIG1hcHBpbmcgZm9yIHRoZSBhY2Nlc3MsDQo+Pj4+DQo+Pj4+IGFnYWlu
LCBzb3JyeSwgd2hhdCAncGFnZSBwZXJtaXNzaW9ucyc/ICBtZW1vcnlfZmFpbHVyZV9kZXZfcGFn
ZW1hcCgpDQo+Pj4+IGNoYW5nZXMgdGhlIHBvaXNvbmVkIHBhZ2UgbWVtX3R5cGUgZnJvbSAncncn
IHRvICd1Yy0nIChzaG91bGQgYmUgTlA/KSwNCj4+Pj4gZG8geW91IG1lYW4gdG8gcmV2ZXJzZSB0
aGUgY2hhbmdlPw0KPj4+DQo+Pj4gUmlnaHQsIHRoZSByZXN1bHQgb2YgdGhlIGNvbnZlcnNhdGlv
biB3aXRoIEJvcmlzIGlzIHRoYXQNCj4+PiBtZW1vcnlfZmFpbHVyZSgpIHNob3VsZCBtYXJrIHRo
ZSBwYWdlIGFzIE5QIGluIGNhbGwgY2FzZXMsIHNvDQo+Pj4gZGF4X2RpcmVjdF9hY2Nlc3MoKSBu
ZWVkcyB0byBjcmVhdGUgYSBVQyBtYXBwaW5nIGFuZA0KPj4+IGRheF9yZWNvdmVyX3tyZWFkLHdy
aXRlfSgpIHdvdWxkIHNpbmsgdGhhdCBvcGVyYXRpb24gYW5kIGVpdGhlciByZXR1cm4NCj4+PiB0
aGUgcGFnZSB0byBOUCBhZnRlciB0aGUgYWNjZXNzIGNvbXBsZXRlcywgb3IgY29udmVydCBpdCB0
byBXQiBpZiB0aGUNCj4+PiBvcGVyYXRpb24gY2xlYXJlZCB0aGUgZXJyb3IuDQo+Pg0KPj4gT2th
eSwgIHdpbGwgYWRkIGEgcGF0Y2ggdG8gZml4IHNldF9tY2Vfbm9zcGVjKCkuDQo+Pg0KPj4gSG93
IGFib3V0IG1vdmluZyBzZXRfbWVtb3J5X3VjKCkgYW5kIHNldF9tZW1vcnlfbnAoKSBkb3duIHRv
DQo+PiBkYXhfcmVjb3ZlcnlfcmVhZCgpLCBzbyB0aGF0IHdlIGRvbid0IHNwbGl0IHRoZSBzZXRf
bWVtb3J5X1ggY2FsbHMNCj4+IG92ZXIgZGlmZmVyZW50IEFQSXMsIGJlY2F1c2Ugd2UgY2FuJ3Qg
ZW5mb3JjZSB3aGF0IGZvbGxvd3MNCj4+IGRheF9kaXJlY3RfYWNjZXNzKCk/DQo+Pg0KPj4+DQo+
Pj4+PiBkYXhfcmVjb3ZlcnlfcmVhZCgpIGFsbG93cyByZWFkaW5nIHRoZSBnb29kIGNhY2hlbGlu
ZXMgb3V0IG9mIGENCj4+Pj4+IHBvaXNvbmVkIHBhZ2UsIGFuZCBkYXhfcmVjb3Zlcnlfd3JpdGUo
KSBjb29yZGluYXRlcyBlcnJvciBsaXN0DQo+Pj4+PiBtYW5hZ2VtZW50IGFuZCByZXR1cm5pbmcg
YSBwb2lzb24gcGFnZSB0byBmdWxsIHdyaXRlLWJhY2sgY2FjaGluZw0KPj4+Pj4gb3BlcmF0aW9u
IHdoZW4gbm8gbW9yZSBwb2lzb25lZCBjYWNoZWxpbmUgYXJlIGRldGVjdGVkIGluIHRoZSBwYWdl
Lg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSG93IGFib3V0IHRvIGludHJvZHVjZSAzIGRheF9yZWNvdmVy
XyBBUElzOg0KPj4+PiAgICAgIGRheF9yZWNvdmVyX2RpcmVjdF9hY2Nlc3MoKTogc2ltaWxhciB0
byBkYXhfZGlyZWN0X2FjY2VzcyBleGNlcHQNCj4+Pj4gICAgICAgICBpdCBpZ25vcmVzIGVycm9y
IGxpc3QgYW5kIHJldHVybiB0aGUga2FkZHIsIGFuZCBoZW5jZSBpcyBhbHNvDQo+Pj4+ICAgICAg
ICAgb3B0aW9uYWwsIGV4cG9ydGVkIGJ5IGRldmljZSBkcml2ZXIgdGhhdCBoYXMgdGhlIGFiaWxp
dHkgdG8NCj4+Pj4gICAgICAgICBkZXRlY3QgZXJyb3I7DQo+Pj4+ICAgICAgZGF4X3JlY292ZXJ5
X3JlYWQoKTogb3B0aW9uYWwsIHN1cHBvcnRlZCBieSBwbWVtIGRyaXZlciBvbmx5LA0KPj4+PiAg
ICAgICAgIHJlYWRzIGFzIG11Y2ggZGF0YSBhcyBwb3NzaWJsZSB1cCB0byB0aGUgcG9pc29uZWQg
cGFnZTsNCj4+Pg0KPj4+IEl0IHdvdWxkbid0IGJlIGEgcHJvcGVydHkgb2YgdGhlIHBtZW0gZHJp
dmVyLCBJIGV4cGVjdCBpdCB3b3VsZCBiZSBhDQo+Pj4gZmxhZyBvbiB0aGUgZGF4IGRldmljZSB3
aGV0aGVyIHRvIGF0dGVtcHQgcmVjb3Zlcnkgb3Igbm90LiBJLmUuIGdldA0KPj4+IGF3YXkgZnJv
bSB0aGlzIGJlaW5nIGEgcG1lbSBjYWxsYmFjayBhbmQgbWFrZSB0aGlzIGEgbmF0aXZlIGNhcGFi
aWxpdHkNCj4+PiBvZiBhIGRheCBkZXZpY2UuDQo+Pj4NCj4+Pj4gICAgICBkYXhfcmVjb3Zlcnlf
d3JpdGUoKTogb3B0aW9uYWwsIHN1cHBvcnRlZCBieSBwbWVtIGRyaXZlciBvbmx5LA0KPj4+PiAg
ICAgICAgIGZpcnN0IGNsZWFyLXBvaXNvbiwgdGhlbiB3cml0ZS4NCj4+Pj4NCj4+Pj4gU2hvdWxk
IHdlIHdvcnJ5IGFib3V0IHRoZSBkbSB0YXJnZXRzPw0KPj4+DQo+Pj4gVGhlIGRtIHRhcmdldHMg
YWZ0ZXIgQ2hyaXN0b3BoJ3MgY29udmVyc2lvbiBzaG91bGQgYmUgYWJsZSB0byBkbyBhbGwNCj4+
PiB0aGUgdHJhbnNsYXRpb24gYXQgZGlyZWN0IGFjY2VzcyB0aW1lIGFuZCB0aGVuIGRheF9yZWNv
dmVyeV9YIGNhbiBiZQ0KPj4+IGRvbmUgb24gdGhlIHJlc3VsdGluZyBhbHJlYWR5IHRyYW5zbGF0
ZWQga2FkZHIuDQo+Pg0KPj4gSSdtIHRoaW5raW5nIGFib3V0IHRoZSBtaXhlZCBkZXZpY2UgZG0g
d2hlcmUgc29tZSBwcm92aWRlcw0KPj4gZGF4X3JlY292ZXJ5X1gsIG90aGVycyBkb24ndCwgaW4g
d2hpY2ggY2FzZSB3ZSBkb24ndCBhbGxvdw0KPj4gZGF4IHJlY292ZXJ5IGJlY2F1c2UgdGhhdCBj
YXVzZXMgY29uZnVzaW9uPyBvciBzaG91bGQgd2Ugc3RpbGwNCj4+IGFsbG93IHJlY292ZXJ5IGZv
ciBwYXJ0IG9mIHRoZSBtaXhlZCBkZXZpY2VzPw0KPiANCj4gSSByZWFsbHkgZG9uJ3QgbGlrZSB0
aGUgYWxsIG9yIG5vdGhpbmcgYXBwcm9hY2ggaWYgaXQgY2FuIGJlIGF2b2lkZWQuDQo+IEkgd291
bGQgaW1hZ2luZSB0aGF0IGlmIHJlY292ZXJ5IHBvc3NpYmxlIGl0IGJlc3QgdG8gc3VwcG9ydCBp
dCBldmVuDQo+IGlmIHRoZSBETSBkZXZpY2UgaGFwcGVucyB0byBzcGFuIGEgbWl4IG9mIGRldmlj
ZXMgd2l0aCB2YXJ5aW5nIHN1cHBvcnQNCj4gZm9yIHJlY292ZXJ5Lg0KDQpHb3QgaXQhDQoNCnRo
YW5rcyENCi1qYW5lDQoNCj4gDQo+IFRoYW5rcywNCj4gTWlrZQ0KPiANCg0K
