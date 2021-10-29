Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AEC44029A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhJ2S5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:57:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8500 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhJ2S5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:57:01 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THe7O3028575;
        Fri, 29 Oct 2021 18:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fNy6Am8skKt8svqia0jktZBdEMff8T6/C2OIN2O91a8=;
 b=ur4d2zWocCTp5gRwAR1ylhqDsHbPqdhvz9pVp0rHUMC4EpgKPtqSeAnqKwzp2wGy76L1
 g/QpmDM5sho259XvRbJZPA37Z7127X6QKIVlZzmA+riqSseo8PCRkjAq3pdIZlUFUucV
 XDeIVrd0oqaeyhtOYliuOyRUojVRd3QhUvwQ7g8LaZZdOtNIXPVHn3WbkTAdEgLhPzzo
 hjdtH2HWAlinKkWSSxYj0eE30SrTksI4ONZpWPuVA0uevbkntPjGSEnW47TU4do8rwn5
 PovRD1ep0VhI+WA2udXyeq18UcVmVDE2Dfi2XNSM7HaQFTnYnVgfgoyuI5y2zOsqkGkK /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byhqrh52s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 18:53:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19TIpfPc078424;
        Fri, 29 Oct 2021 18:53:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3bx4ggb13r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 18:53:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIK0fz5kCKO9VuX+ka4sqiiLgjpP6RwAscsbmjU8xhJmxbJMVkhue3R2epu+P3Hmb+WWr9VbqHaq9TXxUJ6ElDBhyx5hdbSsDKhIXhEsZbxV9UaJCdVt5HhxY/T03p18OFIumopeMqZL3RPTByaVrhhygfu8C7EmlbPMHvK+lqsr4NUhoyjcZOrZ8rimHo2T9fxlmWGUnRD8+chO3ei7bR/UPqhc8G8ZQizw63j+9bdEV3ug7QgnBR1ywpPmTucpwLatMNKZwQSndfZAQ1nzkxvBKik7pwIUHy6vSjb7IksXvGMqHSF/TbnEpARJen6etNHbtTCvNiKTWyKE/VznfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNy6Am8skKt8svqia0jktZBdEMff8T6/C2OIN2O91a8=;
 b=IQ/z5srws38j/ecEOSww6225jDObbWIqW3+uXwMV6gF0uVhq3wRTrQea2wlj2z4V60i/dHdC/nXLopdSnoUHhDe3wdZ65+M2bKEguFnOjdRdCxtQ6voJviiKtvn9/RyRA/ePIyGwW/50sO1vjyRd7Zq2U8jJOhrf1flyHiVnRTFiB3/F8hZXKH+edmVJBj2s1KRhnsHBHTycO5ZGzKiOt3UM0d+RqbxBkY8K//u3qQ0WUqipFhrtSs8yDxwlmCFxGHggXW9hVkWbh2CNfBW2hZvAU/gjjdYUr/AxE2XIKWgCuLtNh3yE+hGvJ7FU2gDYp/eAv5ShdWp0BwI8i+MNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNy6Am8skKt8svqia0jktZBdEMff8T6/C2OIN2O91a8=;
 b=TgW08JyEz990crLZ2GE47qIW1EwzEbrHhrzOe9ri+89ltzMnKFhwOGzJOe/GUFvggrNoVyPYX6vekte336ue3SOkeMsXnrKZPdv4cprB7S+NUKCZc4OlgmSaOvC+hQKKqwCrO6TmZ7Uan4HVFACQut4M/knt/KCr1XV8xhB7wt0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2790.namprd10.prod.outlook.com (2603:10b6:a03:89::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 18:53:55 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 18:53:55 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
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
Thread-Index: AQHXxhAze/H2dZp4I0O0xNcfyRn+pqvdUicAgADsdoCAAELPAIABAAaAgAbwJYCAASa6gIABepqAgADWGwCAAHd9AA==
Date:   Fri, 29 Oct 2021 18:53:55 +0000
Message-ID: <35d4da2e-ae2f-2998-f6d2-3598afdeaf05@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <20211028225955.GA449541@dread.disaster.area>
 <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
In-Reply-To: <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5b47680-dfb7-4f04-e079-08d99b0d754d
x-ms-traffictypediagnostic: BYAPR10MB2790:
x-microsoft-antispam-prvs: <BYAPR10MB2790DED0742C03A220A708CAF3879@BYAPR10MB2790.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVEfVtHazmgoJNm3JelkmmOcN7/wJ7Z9ZPufB5NLoXUc7Gn2a/cj+TiSdIL4kdIcL+rkWADHhSoow5RQ3q6vH2OLOU4MNh8RtPjnpc4gvpX/X+XYtIZnoVOY0uoBP5zt/9UVhn78G7Btql/VmLsd43HT8yIvQW63AejWnTzyeOc/0549YP5UrkSWWEQ2XqySgU/ZmjPUhqgIXUoouC39U+sjPPIm6huONUi4oMJcwzZwZrdmqNIBglTaQBdkmFckL8eo5pLRgnYQVeLLtX8n5ZofX/W8Ff3mMKLvrjhpPrdrMY4aF92Hpic7/7Ys41xDvNa1dCXclThs2YSmmbKXUErbjwqIonLHTJZwaypWM0Hj9L+v/FRRkCib1bysyPHwuiX2ZsxAmMd9gIDb6vHkk3HYctllCyyv3w27XZND8/HyEj5ic5SqKXB6KLusIdVT8Hrhkgh/e++4DYD1DAhYjhfDsE+BCmLMbXBfc2OGMvPlua5M1+xntTEFamznOHaaQ2kUdJQ5n+W+dgOZEwYmj8Fq/IwkMR0UzVMywuCEnv9I9k5SmwufoEtdb41g9ul8XHiZwHYaHQd0NDKiQZMAellVPgKJJfjb66asg6EKFye5mHexryFfZSfUfN54GQX6u1cORx8r3COT+lGzm1niLIbBjwb+wkEH4ppmrPdyUQ0gE0/PTjC3t7EurFRn11XGy0IMdRIlb3sOlDHcEH1U2h+cF6i1uidM2zo6QgtXgdmNxlT6vhB0gw7KR14+YnhtMxv6kUDtNrKIE4vwcwMsog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(53546011)(6506007)(6486002)(26005)(71200400001)(44832011)(316002)(186003)(2906002)(5660300002)(6512007)(54906003)(110136005)(4326008)(86362001)(31696002)(122000001)(66446008)(64756008)(76116006)(66476007)(31686004)(66556008)(2616005)(38070700005)(38100700002)(7416002)(36756003)(8676002)(83380400001)(66946007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVVEOUlCdmpvd1RZbTNaKzNvaDdoell4aVY2UHRaa3BKM0s5UHRPM0VlNzZi?=
 =?utf-8?B?UEdqTmxuajZ3eDNYY0NFVCt0T0xsVU9YTlM3QmxveHhveEdPYzBBNGJlZE1K?=
 =?utf-8?B?QU1mVGRuU2E3b0hadFBDbS9HQUVGQmxRWnV6eXdIQnk5bzZadVhQeFJmVzA4?=
 =?utf-8?B?d1p4MFBtUnNwaFNmb2ZicDI1UGRxbHpHMkg4ZmtOS0Q3ckZISGdFZFlWV3R1?=
 =?utf-8?B?c1pHNGVBQ2VmSnVtRFB1bENRdHB2RUpmNFVkN3YwcnB0RVNHdEtDckx1czZi?=
 =?utf-8?B?dUozOE1oVlpudFhaL1BkaytkOTg0MnBLM0QvaGZYdDMwREgwNmdocFk1MzFU?=
 =?utf-8?B?RndZYm91WExMZmUxQjFLRjRoNEhRajBDVWxkaTc0cGtTV0JtczlxMUt6Qjdv?=
 =?utf-8?B?M0gzQmFxRTJLV3pGQ2tvNVpGZ213WHNtWU9OZW9BVkNVS2dyNzdtenZZQ0lw?=
 =?utf-8?B?Nzg1aTFwbm9YaStBdUdjRkRDSm5DcytSbHkyV0s3RWwzdTNKK1VDanM0N25R?=
 =?utf-8?B?NVk2TWljK2dBaTI5VVByRStJUUIxdDIzR01kb0wvcFdLMjdITzVkZlJWVTl4?=
 =?utf-8?B?NElVRS9mY0lWaFI3NjVWbWJUQTdIQ1pPNDJTM0V1QTF5Z3pIbWdESGdabFJl?=
 =?utf-8?B?d1RDTTBtUXdlaHl1bTNDU1hySUk0eTBKdHJFQlFsQ1dpUm45c0d6bTYzamsz?=
 =?utf-8?B?bTFXS2JUWUtvNTlXVVY3aXdQOEZGM05RWHVMR0d1YmdsN01PZG1IcUsvNGcw?=
 =?utf-8?B?VDB2SlZZS2h6UlRFVGE0elJMSjdtbS9lTDJhcFBkMG5Ua1dYTm9yeFhSMnFi?=
 =?utf-8?B?a2JJV0tPemZhdjJRam9wQUN6U0U2dTBZS0pUZUdzTHpxZ3NCRFh3K1QxcWo5?=
 =?utf-8?B?eUM0K01yY0pOd2tCVVVUTjRNODNLMnZBREcxM05wVndRM3NrYkxqQTUxbVlP?=
 =?utf-8?B?bkhqTExrZW9RSzVQU0FJRzhOUC9YaS96U3cyekY5RzhUbm91ZGV2NExvOFBE?=
 =?utf-8?B?cTRKa3d5UHFvWUNnZHFoNlJ5NURWWkZLQWYxV2l5ZERJVER0UU5WWkc3SCsw?=
 =?utf-8?B?aUJBbjhxakhFaHlVYnNrUzJhcXBsanFnT0k2NXY5Q3ZFNnJvK2VOTmROOW5X?=
 =?utf-8?B?VDVmOFJlQlZBTmpONEttNVpYSi94U2tIRnNiMmRqZ2JnRHM1WjlsaGVocFg1?=
 =?utf-8?B?RnVNd0pINnNXL2pDK2VMNHo2ZjZWYkxOSExMRUQ1MzdFNktjaXl1RmxETWg4?=
 =?utf-8?B?b1hkRnZTQ0FRKzZPby8wdVloQlRyMW5Iekg5dFVCOWxTS2lRMTlNczFPTDFV?=
 =?utf-8?B?bGhuQzN5cFhoVjF2MjA4dmRoeGlkMWo2akMrMUhVWVU4bjczeVZOQ0dudStO?=
 =?utf-8?B?bWNwdDlNNktSeWVGQ3dLK0NPWWNOOUUwblFNRmtaaWx2Z1NTYVo0Z0tqK1Zs?=
 =?utf-8?B?dXRaWkM5aHN0QVBSWlByTE1YeWF1aXFYdDZMQU9JVjcxdmZ3dnJlV08yVnhW?=
 =?utf-8?B?RXRoMkN4RFVaT2szRm1xT2VBSXI2Umw5MVVIZm1vWFlwTUFkbmpZcytVM20v?=
 =?utf-8?B?K09CZ3ZwT1dkU0VoZTR6eVNLSkRuN2lhZWM4VkpJTVVyenJtdnJYRnNPM3ZK?=
 =?utf-8?B?TnpRbnMzblgycDJadnJBWUE4dHlLZU1VT2RPeHBkTG52empvM1dkS1V5SzVj?=
 =?utf-8?B?SCt6UGE5TjlveDh1dVpudERZSUp4aTE3NjM4Wk9EbllmRU1LaWRsMC9KYmc3?=
 =?utf-8?B?cnMvUjV4djhyMXgwc21Pci9rS0E5NFBvT3BBMU1MOG1zQ1dpNWo4bDNaZXN6?=
 =?utf-8?B?bFVacU44R0pDcTBuZU5RVzlwaSttNDZ6bHRrK1JqQzVlNWJoWnp4dm5aY1Yv?=
 =?utf-8?B?OHpMcWh5YW8zTlFFa2FCdWpkYWwvUk9lZFpTemJjZDNqZjN5dFBBRVE1WEZR?=
 =?utf-8?B?WExYMitDeTdSN3JmcXU4SFdHa2tBVkRrOGVFYUFza1llVy9sV3JUUHpqS3Ro?=
 =?utf-8?B?TGVZaUpNZTJhZWRteTVnNmU5Z2VBUGJjZlc5VnhCK2F0K2hWQjBNTW9uTk5a?=
 =?utf-8?B?OXpjazBveU03c3hPZ012K3BBRFBndWZwZmVmaktHeTYzZW1aY2hLcGVmZ3pQ?=
 =?utf-8?B?eUQrME9KWDVrcFpMK0tua2l1d1VpclJ4Qkd1OUNmNjJVOXNOL3VEZ056RnV2?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90F861C1586DD049BFBACFC30B33572C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b47680-dfb7-4f04-e079-08d99b0d754d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 18:53:55.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egtwPy2A/UMVMBDyTzdU3/kIBL8C3pWJ8H7TxNr7Q68CHrq81eAtjdlMoeghyV/AWKUnJRj796Ob1Z+bfzteMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10152 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290103
X-Proofpoint-GUID: wOv3UPp8L5sa-BVu7hWNPapJ7BV-C8O7
X-Proofpoint-ORIG-GUID: wOv3UPp8L5sa-BVu7hWNPapJ7BV-C8O7
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjkvMjAyMSA0OjQ2IEFNLCBQYXZlbCBCZWd1bmtvdiB3cm90ZToNCj4gT24gMTAvMjgv
MjEgMjM6NTksIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gWy4uLl0NCj4+Pj4gV2VsbCwgbXkgcG9p
bnQgaXMgZG9pbmcgcmVjb3ZlcnkgZnJvbSBiaXQgZXJyb3JzIGlzIGJ5IGRlZmluaXRpb24gbm90
DQo+Pj4+IHRoZSBmYXN0IHBhdGguwqAgV2hpY2ggaXMgd2h5IEknZCByYXRoZXIga2VlcCBpdCBh
d2F5IGZyb20gdGhlIHBtZW0NCj4+Pj4gcmVhZC93cml0ZSBmYXN0IHBhdGgsIHdoaWNoIGFsc28g
aGFwcGVucyB0byBiZSB0aGUgKG11Y2ggbW9yZSANCj4+Pj4gaW1wb3J0YW50KQ0KPj4+PiBub24t
cG1lbSByZWFkL3dyaXRlIHBhdGguDQo+Pj4NCj4+PiBUaGUgdHJvdWJsZSBpcywgd2UgcmVhbGx5
IC9kby8gd2FudCB0byBiZSBhYmxlIHRvIChyZSl3cml0ZSB0aGUgZmFpbGVkDQo+Pj4gYXJlYSwg
YW5kIHdlIHByb2JhYmx5IHdhbnQgdG8gdHJ5IHRvIHJlYWQgd2hhdGV2ZXIgd2UgY2FuLsKgIFRo
b3NlIGFyZQ0KPj4+IHJlYWRzIGFuZCB3cml0ZXMsIG5vdCB7cHJlLGZ9YWxsb2NhdGlvbiBhY3Rp
dml0aWVzLsKgIFRoaXMgaXMgd2hlcmUgRGF2ZQ0KPj4+IGFuZCBJIGFycml2ZWQgYXQgYSBtb250
aCBhZ28uDQo+Pj4NCj4+PiBVbmxlc3MgeW91J2QgYmUgb2sgd2l0aCBhIHNlY29uZCBJTyBwYXRo
IGZvciByZWNvdmVyeSB3aGVyZSB3ZSdyZQ0KPj4+IGFsbG93ZWQgdG8gYmUgc2xvdz/CoCBUaGF0
IHdvdWxkIHByb2JhYmx5IGhhdmUgdGhlIHNhbWUgdXNlciBpbnRlcmZhY2UNCj4+PiBmbGFnLCBq
dXN0IGEgZGlmZmVyZW50IHBhdGggaW50byB0aGUgcG1lbSBkcml2ZXIuDQo+Pg0KPj4gSSBqdXN0
IGRvbid0IHNlZSBob3cgNCBzaW5nbGUgbGluZSBicmFuY2hlcyB0byBwcm9wYWdlIFJXRl9SRUNP
VkVSWQ0KPj4gZG93biB0byB0aGUgaGFyZHdhcmUgaXMgaW4gYW55IHdheSBhbiBpbXBvc2l0aW9u
IG9uIHRoZSBmYXN0IHBhdGguDQo+PiBJdCdzIG5vIGRpZmZlcmVudCBmb3IgcGFzc2luZyBSV0Zf
SElQUkkgZG93biB0byB0aGUgaGFyZHdhcmUgKmluIHRoZQ0KPj4gZmFzdCBwYXRoKiBzbyB0aGF0
IHRoZSBJTyBydW5zIHRoZSBoYXJkd2FyZSBpbiBwb2xsaW5nIG1vZGUgYmVjYXVzZQ0KPj4gaXQn
cyBmYXN0ZXIgZm9yIHNvbWUgaGFyZHdhcmUuDQo+IA0KPiBOb3QgcGFydGljdWxhcmx5IGFib3V0
IHRoaXMgZmxhZywgYnV0IGl0IGlzIGV4cGVuc2l2ZS4gU3VyZWx5IGxvb2tzDQo+IGNoZWFwIHdo
ZW4gaXQncyBqdXN0IG9uZSBmZWF0dXJlLCBidXQgdGhlcmUgYXJlIGRvemVucyBvZiB0aGVtIHdp
dGgNCj4gbGltaXRlZCBhcHBsaWNhYmlsaXR5LCBkZWZhdWx0IGNvbmZpZyBrZXJuZWxzIGFyZSBh
bHJlYWR5IHNsdWdnaXNoDQo+IHdoZW4gaXQgY29tZXMgdG8gcmVhbGx5IGZhc3QgZGV2aWNlcyBh
bmQgaXQncyBub3QgZ2V0dGluZyBiZXR0ZXIuDQo+IEFsc28sIHByZXR0eSBvZnRlbiBldmVyeSBv
ZiB0aGVtIHdpbGwgYWRkIGEgYnVuY2ggb2YgZXh0cmEgY2hlY2tzDQo+IHRvIGZpeCBzb21ldGhp
bmcgb2Ygd2hhdGV2ZXIgaXQgd291bGQgYmUuDQo+IA0KPiBTbyBsZXQncyBhZGQgYSBiaXQgb2Yg
cHJhZ21hdGlzbSB0byB0aGUgcGljdHVyZSwgaWYgdGhlcmUgaXMganVzdCBvbmUNCj4gdXNlciBv
ZiBhIGZlYXR1cmUgYnV0IGl0IGFkZHMgb3ZlcmhlYWQgZm9yIG1pbGxpb25zIG9mIG1hY2hpbmVz
IHRoYXQNCj4gd29uJ3QgZXZlciB1c2UgaXQsIGl0J3MgZXhwZW5zaXZlLg0KPiANCj4gVGhpcyBv
bmUgZG9lc24ndCBzcGlsbCB5ZXQgaW50byBwYXRocyBJIGNhcmUgYWJvdXQsIGJ1dCBpbiBnZW5l
cmFsDQo+IGl0J2QgYmUgZ3JlYXQgaWYgd2Ugc3RhcnQgdGhpbmtpbmcgbW9yZSBhYm91dCBzdWNo
IHN0dWZmIGluc3RlYWQgb2YNCj4gdGhyb3dpbmcgeWV0IGFub3RoZXIgaWYgaW50byB0aGUgcGF0
aCwgZS5nLiBieSBzaGlmdGluZyB0aGUgb3ZlcmhlYWQNCj4gZnJvbSBsaW5lYXIgdG8gYSBjb25z
dGFudCBmb3IgY2FzZXMgdGhhdCBkb24ndCB1c2UgaXQsIGZvciBpbnN0YW5jZQ0KPiB3aXRoIGNh
bGxiYWNrcyBvciBiaXQgbWFza3MuDQoNCk1heSBJIGFzayB3aGF0IHNvbHV0aW9uIHdvdWxkIHlv
dSBwcm9wb3NlIGZvciBwbWVtIHJlY292ZXJ5IHRoYXQgc2F0aXNmeQ0KdGhlIHJlcXVpcmVtZW50
IG9mIGJpbmRpbmcgcG9pc29uLWNsZWFyaW5nIGFuZCB3cml0ZSBpbiBvbmUgb3BlcmF0aW9uPw0K
DQp0aGFua3MhDQotamFuZQ0KDQoNCj4gDQo+PiBJT1dzLCBzYXlpbmcgdGhhdCB3ZSBzaG91bGRu
J3QgaW1wbGVtZW50IFJXRl9SRUNPVkVSWSBiZWNhdXNlIGl0DQo+PiBhZGRzIGEgaGFuZGZ1bCBv
ZiBicmFuY2hlc8KgwqDCoMKgwqAgdGhlIGZhc3QgcGF0aCBpcyBsaWtlIHNheWluZyB0aGF0IHdl
DQo+PiBzaG91bGRuJ3QgaW1wbGVtZW50IFJXRl9ISVBSSSBiZWNhdXNlIGl0IHNsb3dzIGRvd24g
dGhlIGZhc3QgcGF0aA0KPj4gZm9yIG5vbi1wb2xsZWQgSU8uLi4uDQo+Pg0KPj4gSnVzdCBmYWN0
b3IgdGhlIGFjdHVhbCByZWNvdmVyeSBvcGVyYXRpb25zIG91dCBpbnRvIGEgc2VwYXJhdGUNCj4+
IGZ1bmN0aW9uIGxpa2U6DQo+IA0KDQo=
