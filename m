Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A7436F79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJVBj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:39:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16198 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhJVBj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:39:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LNib1w019173;
        Fri, 22 Oct 2021 01:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5Uo3GLI+ghCPI0bNMJRk62r2+DyOYMZgf77VxA8MMEA=;
 b=LVPrSSD0cXUL8WVBa9rIj15cS9gqp34zYqCbIEr2SQC/e2R4Ybn1QlFgN7OLV7nNPF4D
 sk+S/F0qHr/SMMVAF28pi/Uv66unFZBQeg1e7xU7+tGNW8GPsEf761lcSG2dyL2cRb5m
 BmBmHiKJFjLl8+67tZM2XqdDsPiTNWOal0CkXNWF/9mbiUGVmksyqi6TancDM08YL0bj
 1pDx7k7LT5IayupZPLDMVGTkXvuvUeENKqN/CuhhDjA8nOdykSsojLdUKsy7lAd2UhIj
 TEe6cXYmDjhLWrgOOmtlzadt2PwNyqnFGu1/tlIUIiZBRtdS2n/olYW/oBb/BWlZdRzy cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqp2rgcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 01:37:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19M1Vfea084363;
        Fri, 22 Oct 2021 01:37:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3bqkv2wdx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 01:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUpPSijyx2GZEkxnF0zu8T9kkg2V4OG+lACwWpSIxw5oWporuJwoA5XjrkmaDNSfb5sITVgPzQyHNEEQlqQhXvtNoVB93fl8Ze44Adn8WIRaDIRCRlijWg06568Z9okEib1lMFIX3mon8h8cySNcCUKnTollcuNbsrNjNxFHrt+Y2QHwyv47KFCLAIlE6AoNW+WJ5f7jZJM3FmGhxt/gh3kJdMn7dwKRmt6Wvipscu/9Gx5pkjpN8kXeZ565BQgaCWSVEEYREdzqkEcL6Wjv5RK/TrNQGgoNqw5F72NcDDrzrJi90Iq41XLVJJAuaF7/49IzE0leMCf/NLHrIDUkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Uo3GLI+ghCPI0bNMJRk62r2+DyOYMZgf77VxA8MMEA=;
 b=PzH7JsLRvqNDaeAtKOS2f0CK+/LOdStlaR/nzvNGRwBrmz4ZhdFnWBnlYcRG+LnhbBCGbO0yf8prRimnXcSEb2IECT74YA89lpgZlQQILpgESjcQN5B4tAAVFit+3ZQ+u1vpnQD0FpUnEzXvyr0RZQ9eNhpNsfwbfZP4To9A5U883PFs2J+r7KhXVORFirVZmhgfVGfk642npF1EBVTZGrfv7/UCQew/Fv94ZH9E8StPHY5at6yRBQX3Ly9Xpcr5KE4hY2QOuH+H/AN13YBMGQInLi5F0OApn+TIJso7JtR061cvHJwhiF3hfXhAn8fQQqR6gsQzsub7rM07LnujRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uo3GLI+ghCPI0bNMJRk62r2+DyOYMZgf77VxA8MMEA=;
 b=Zwky0JUwzJV/UdwW3dsZjZ5GA4XLwKsYnbvyqOUFXHNZ8Is5nmSw/u9NXG05X8S3u9uSMf7/TYYNBHH/ksQXH3FmpHjTI0r/83lvsfzwDEA5MG7RT872eynHDis3nPLCpSdXnt4bTXGtz4bIkR9z47V8xlJBBOdu78ENeIODlC0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3224.namprd10.prod.outlook.com (2603:10b6:a03:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 01:37:28 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 01:37:28 +0000
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
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA
 flag
Thread-Topic: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Thread-Index: AQHXxhAze/H2dZp4I0O0xNcfyRn+pqvdUicAgADsdoA=
Date:   Fri, 22 Oct 2021 01:37:28 +0000
Message-ID: <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
In-Reply-To: <YXFPfEGjoUaajjL4@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea73eff8-2c62-4869-608a-08d994fc8226
x-ms-traffictypediagnostic: BYAPR10MB3224:
x-microsoft-antispam-prvs: <BYAPR10MB32241B676D280424BEBC4EC0F3809@BYAPR10MB3224.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgknTlS1HUD2+NGPDe8IHEp5G8MWclxk4C2hzaXFZACjen5uZUwlqyXc+ZQ+r3Gi+Y0rDFU1shVUDRHHR86Ih9eWqKIo81BceaQhD2vsuwlgzOqr0DwE5ZDXcLkUr8mU4a1O2gfUKaIhevYgANBX2ewlxaPrRG6LpUzuQfEm5wZBn9ajEgzcBMoNKK2SRkTNd0y6TrF93YWkrYR48JxlJL0D1ZJd97JA5uZXvBrM3oaD7kCCzifry82s6CkC9VF4Q218g7JNDLm3MOEyX+mVQqK47aQkCgPLkMLLHAEsxayCnRwKlQbdwY2ZDlHjPgCLUcux9yOlSkblciOCm6Hxal4/l33W71riABgAwFzQzKI0vgckQF684CSgTUqfs5giJfkKRrSKL76aU/IUjCYZSuS3uwcM6HZrCEHHiiLCwXNOMeqFsj8Z2qIPm1u8J1QeXCD9LprPGaj1AN3VxfuFy1gA4IPbvs5fiRN14nm/ULQ5sdw4/VTOerLzVs9p2Ajxo94ybusz4sYKeGvKAcYFh70bVqB0jFVzvyP7k2Odnz5aqJYYSMClyJ4w3l4VKPeNmJ18iAGcolADJGGw2zBZiNNFuHT2K5o35aPzN++QBahl2TN3sJTtcYhVueKp0yx9vOeqljlWGkbFQHgn8jSsG7sPhmF63sKkGphWqtMisn7eF5q01tz1kQarn7kN/+5YLaU6UdUHVfHeM+tm1olG67Fz1oOP3vfW16pPpEPY6mBavqJ/2Jz+hDCHmqht2cxeKIrHlRJ/5ceXdzct7FsvZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(2616005)(122000001)(6512007)(38100700002)(66556008)(5660300002)(54906003)(76116006)(44832011)(66946007)(31686004)(6486002)(66476007)(83380400001)(2906002)(316002)(91956017)(31696002)(86362001)(6506007)(8676002)(71200400001)(64756008)(36756003)(7416002)(186003)(4326008)(38070700005)(508600001)(8936002)(66446008)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHFnOG1CaWUwbjg3R1NIM2RpSVByRkZKT0FrZVJKUVU4QXVOOEJjQTdBT1Rz?=
 =?utf-8?B?TVltQWs5Q1p1ZlF0SGs3U01UVE1QUHYyZlh1OGxqSXNNaSt4VmxvRU9XaXlV?=
 =?utf-8?B?c1Z4bVVXNlZtRDVCTEFCWnVyV3hzclRmbkkvclladFBmeHZXaVlZTzBlN1d3?=
 =?utf-8?B?VGVob05venpJVWFPV2FNd3JPOHAvOUVCQk5La3FoMjg5RW9DREVqTlZNcXdP?=
 =?utf-8?B?RUhzeUZqYkZpaEsvOGs0WlBDRS95aUVHOHdkbkNBekRsYWtjOTBXRGNsdXF1?=
 =?utf-8?B?RmJCem9oSnFGTHRJOHhobDNQS1lyMVlPbUhvY3QwQ2ZqQnY1dy9vL1BlVWpG?=
 =?utf-8?B?WFVaQ0F1bWZ6cE1NVHcvT2g5bDlGUFNNR05lYVkrVVAyWXFwN0pXdSt6RFRl?=
 =?utf-8?B?YStmV2dKOXhjTm1kNGU5NUlybnRXL3lQVVVteHV3WEdVODRFVFVJbTc1U1Y4?=
 =?utf-8?B?U0lsOEMzOUNzZllFNEZ4d0g4OWJoa0RMR2lxYnBucGZuWmFSWFpjbVhMbVFi?=
 =?utf-8?B?WE1ZVEZGZElodTV6L1RlK3FueU5xWnhLclpHVXNNQ3FpaFEvdlN5UzRibjNZ?=
 =?utf-8?B?K3F0WnZUdjFqSVNwVHNnNDhvOHRTZzNmSkdtalltQ2tTZ21jVy9CL28yT2to?=
 =?utf-8?B?M1poRHZzblZuWFNmV3VQOXB3aWF3NlZrMGY2Q2w2THY2L1ZGaG5Ma1lPcnpR?=
 =?utf-8?B?Rkc5SWtGdndwbWh1SmN1VGU5L0l0ejR1U0ZmQ3hWNWQ5VXlDbGxDT1dGMnZz?=
 =?utf-8?B?ZHZmWGlKNnZyY3hZa0pXU2hvejJmcldjR2JrM2FrOWlLYUZOYmRJMURuSGdv?=
 =?utf-8?B?d1BDb1pzSVptTlJRNHJoWENnSUdyaHpxNnROR1IydWFaNzdma3BXQ3c3NU83?=
 =?utf-8?B?R3lXUDRLaFhBMGlQYnpWdUticTBGTGg0cmdRUzBhaExsWm8vR2Y5MDRiSjZ0?=
 =?utf-8?B?TDdlT0hDTk1ZS21RSGJsSlo0NVY4MGZBL1pkcEhsRlRxSEk1YUphSTJUMkQz?=
 =?utf-8?B?YXdScTJwSDlMcG5UN0orUWdlUUZ2MGx6cWdFL3RwK1VTcHcycDU1MERwQW5Q?=
 =?utf-8?B?NVdKc1dNL0w0WDVvTHJ5QU1wcGJyaHIvYk1teTdtRm9EamdodHRtSGF3bWRV?=
 =?utf-8?B?ZmtoNzZEbmpSbUtWQjQ0Nmh6c21WdkRMVjNyd2h6WlRFVnNIdmFMbEF0Y1I4?=
 =?utf-8?B?aFdvaC9EdUFnQmUvL1pjMHF5dmdpRWpySGY1WFJRS2EvQUs0Tnl6bkthcmY4?=
 =?utf-8?B?MzY4eWpIYTRPRWtGV1RTZUVGZnhZVG5KdDJSNWJwaFlHSUNNYXppOFUxZ1Ri?=
 =?utf-8?B?bEp3RHRXaTN6eGU0U1FFVEdRRWNsVDJGUGZzU282SmtKVkcrVzZrTmtXYmxu?=
 =?utf-8?B?TC9wNDFERy9BZjJrK2lSUk5nY2s3VGNyQ2NRdU5mVENXZHRKNjhTQkcyZmZQ?=
 =?utf-8?B?THJpdFlmZGdUWmVzMkJ2UWczSVpib3VxdG1rMS9oZVBaNG9pZDRJbzFZTzVO?=
 =?utf-8?B?d2dvTWFnbEZueEU4Vjk0THlnL2dOMENicHYvcmhtNVN3ZG5MaFRyVURVcExR?=
 =?utf-8?B?T3l5blN1Z2tmZkFYSEYwTjg4S2dpdWZrNS8vUlZZZFdEUXowSGtzcnBuV2NO?=
 =?utf-8?B?U0pqa21CNVlNR215YXFDekZmdk1iTUZMN2tPYWtGLzJQaDZGWi9iaXhhV2pR?=
 =?utf-8?B?ZTFLemFnd0FpZm9tbUx3ZmsxZ3k5bVl1NXFMOGRVeGIrWkthemI2QklKa3lR?=
 =?utf-8?Q?AKReQmK/zEPQsHPEhw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D0B4C40E28A1A4D8C2C44AC19319ACC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea73eff8-2c62-4869-608a-08d994fc8226
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 01:37:28.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3224
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220006
X-Proofpoint-ORIG-GUID: 4VggrbHW5vKK4dlcbEmtotYV-qv6imVk
X-Proofpoint-GUID: 4VggrbHW5vKK4dlcbEmtotYV-qv6imVk
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSA0OjMxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTG9va2lu
ZyBvdmVyIHRoZSBzZXJpZXMgSSBoYXZlIHNlcmlvdXMgZG91YnRzIHRoYXQgb3ZlcmxvYWRpbmcg
dGhlDQo+IHNsb3cgcGF0aCBjbGVhciBwb2lzb24gb3BlcmF0aW9uIG92ZXIgdGhlIGZhc3QgcGF0
aCByZWFkL3dyaXRlDQo+IHBhdGggaXMgc3VjaCBhIGdyZWF0IGlkZWEuDQo+IA0KDQpVbmRlcnN0
b29kLCBzb3VuZHMgbGlrZSBhIGNvbmNlcm4gb24gcHJpbmNpcGxlLiBCdXQgaXQgc2VlbXMgdG8g
bWUNCnRoYXQgdGhlIHRhc2sgb2YgcmVjb3Zlcnkgb3ZlcmxhcHMgd2l0aCB0aGUgbm9ybWFsIHdy
aXRlIG9wZXJhdGlvbg0Kb24gdGhlIHdyaXRlIHBhcnQuIFdpdGhvdXQgb3ZlcmxvYWRpbmcgc29t
ZSB3cml0ZSBvcGVyYXRpb24gZm9yDQoncmVjb3ZlcnknLCBJIGd1ZXNzIHdlJ2xsIG5lZWQgdG8g
Y29tZSB1cCB3aXRoIGEgbmV3IHVzZXJsYW5kDQpjb21tYW5kIGNvdXBsZWQgd2l0aCBhIG5ldyBk
YXggQVBJIC0+Y2xlYXJfcG9pc29uIGFuZCBwcm9wYWdhdGUgdGhlDQpuZXcgQVBJIHN1cHBvcnQg
dG8gZWFjaCBkbSB0YXJnZXRzIHRoYXQgc3VwcG9ydCBkYXggd2hpY2gsIGFnYWluLA0KaXMgYW4g
aWRlYSB0aGF0IHNvdW5kcyB0b28gYnVsa3kgaWYgSSByZWNhbGwgRGFuJ3MgZWFybGllciByZWpl
Y3Rpb24NCmNvcnJlY3RseS4NCg0KSXQgaXMgaW4gbXkgcGxhbiB0aG91Z2gsIHRvIHByb3ZpZGUg
cHdyaXRldjIoMikgYW5kIHByZWFkdjIoMikgbWFuIHBhZ2VzDQp3aXRoIGRlc2NyaXB0aW9uIGFi
b3V0IHRoZSBSV0ZfUkVDT1ZFUllfREFUQSBmbGFnIGFuZCBzcGVjaWZpY2FsbHkgbm90DQpyZWNv
bW1lbmRpbmcgdGhlIGZsYWcgZm9yIG5vcm1hbCByZWFkL3dyaXRlIG9wZXJhdGlvbiAtIGR1ZSB0
byBwb3RlbnRpYWwNCnBlcmZvcm1hbmNlIGltcGFjdCBmcm9tIHNlYXJjaGluZyBiYWRibG9ja3Mg
aW4gdGhlIHJhbmdlLg0KDQpUaGF0IHNhaWQsIHRoZSBiYWRibG9jayBzZWFyY2hpbmcgaXMgdHVy
bmVkIG9uIG9ubHkgaWYgdGhlIHBtZW0gZGV2aWNlDQpjb250YWlucyBiYWRibG9ja3MoaS5lLiBi
Yi0+Y291bnQgPiAwKSwgb3RoZXJ3aXNlLCB0aGUgcGVyZm9ybWFuY2UNCmltcGFjdCBpcyBuZXh0
IHRvIG5vbmUuIEFuZCBvbmNlIHRoZSBiYWRibG9jayBzZWFyY2ggc3RhcnRzLA0KaXQgaXMgYSBi
aW5hcnkgc2VhcmNoIG92ZXIgdXNlciBwcm92aWRlZCByYW5nZS4gVGhlIHVud2FudGVkIGltcGFj
dA0KaGFwcGVucyB0byBiZSB0aGUgY2FzZSB3aGVuIHRoZSBwbWVtIGRldmljZSBjb250YWlucyBi
YWRibG9ja3MNCnRoYXQgZG8gbm90IGZhbGwgaW4gdGhlIHVzZXIgc3BlY2lmaWVkIHJhbmdlLCBh
bmQgaW4gdGhhdCBjYXNlLCB0aGUNCnNlYXJjaCB3b3VsZCBlbmQgaW4gTygxKS4NCg0KVGhhbmtz
IQ0KLWphbmUNCg0KDQo=
