Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2918A44C6C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 19:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKJS31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 13:29:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19164 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhKJS30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 13:29:26 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAI0Fgb002009;
        Wed, 10 Nov 2021 18:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Uq+db0nBSCIF4wzq93LAxy2oFlI7Ax+2vqa1fny1zSM=;
 b=wTegX3G9GsQnfkzXBBx/WoP/aY577DhAxqV8tCwxtRx2zzCCpbfKlqYSgVYJ/fda3Q56
 8uf/GhkLqklcshMHbqtooSSC5esUxKdeElxqYBYKRnglLxDVKh6IbuEzU6bJDZKg1AwF
 G4AbGWjE0t0daiI93nB6Y3UPxupTnDv5JywWeUlLMi07cCgxT+5yYl3rfgf7oLhRZ/Zi
 fCvplsmvykR22qz4ghKDzLkuEnhq3GYOk0L+vYhWufphy20nVUSOKFsd7Wa99vF75wyO
 0rnU9qdT478i8NTeIOfufea3J1deMUntgNMGGnbwV0l5LeIpcqLy5BAzmoeHxGZSW+gj pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c880rvgbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 18:26:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AAIAirc075984;
        Wed, 10 Nov 2021 18:26:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3c63fv1v56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 18:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyusG3efeUxWO03bercB06v3GG3plMmQxY7bpUOJZHapeoEbUv3BZa5XJZxF3NCXdAiW6BPyPpnDga2SneTpD+1BnFzZgiYwFJwDKd1xRo4CxAE7PWoBvtj0Wr9mhhpqZntqJgMnCaeeyWsrOVQ1UoERDoabHFjxEWBOSBfokO0No/PBoFRjT85CYTdAJjvvM/pSccOR4Z7+IB95ai9Txwb62odSYW+AgfKNKNGCKggosu8F0gtB3to+J14cZnP4skdiaq6meh+fY9QtrROcq1EqOqnuruinkuwLJqieS5Nv4fpsKzJ0p7e3yT/HlwehN2PflPjFjrhF7Q2PQjojww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq+db0nBSCIF4wzq93LAxy2oFlI7Ax+2vqa1fny1zSM=;
 b=AjiDDJrbYoJvRpJyiohbGJoHszoMk+XXBzvzgyY8+uqhH8zQ2sRrTLJ5B7ycGQ9LfyzT8urS8fEd/osp5aS7iEAl7iz6O5ROnIhaT15J+hYZ67jld5tt62qlaa62pDKyu6hQh562WfpvnxR8vjtn2xX/AA9NI1NlSSpJWD7gUgyz+nPsDbeI+/LKHFx288/xpdlvt7ooLrJjUJNqIqFjM6Uq+8kxquCNj9kbXNXSNvb5pDWLOaoVy5KGVQgL8RJdiGkGJvb5PmHXOaWnu7wA8GFv5d/DM1OIpI4OsZYF59JNXhDXxobV3e9YW7Xg4O2frfLgvVDZP4NR6LGYnj+Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq+db0nBSCIF4wzq93LAxy2oFlI7Ax+2vqa1fny1zSM=;
 b=lBLWlhks7O0SJnza0o2hbq40QtLkGXuI0saexpFF+7AjBK/Rt+PKpm17r9oc1RHnEnHRc9QI2YmNRkAgRH1hywGvk54g58IVbI1scZXwWJRlmw/ZFGdsUfFu7wlN+LAef6krkwFY8cUOeVZs4QNeTF18Vw8Ir3IJMIyvCT8gL7U=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5534.namprd10.prod.outlook.com (2603:10b6:a03:3fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 18:26:01 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 18:26:01 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
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
Thread-Index: AQHX0qwHA1irfgJJPUKt0/SD8Ofb86v60R0AgAC+aoCAABOLAIAAEcSAgAFmpAA=
Date:   Wed, 10 Nov 2021 18:26:01 +0000
Message-ID: <795a0ced-68b4-4ed8-439b-c539942b925e@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
 <YYoi2JiwTtmxONvB@infradead.org>
 <CAPcyv4hQrUEhDOK-Ys1_=Sxb8f+GJZvpKZHTUPKQvVMaMe8XMg@mail.gmail.com>
 <15f01d51-2611-3566-0d08-bdfbec53f88c@oracle.com>
 <CAPcyv4gwbZ=Z6xCjDCASpkPnw1EC8NMAJDh9_sa3n2PAG5+zAA@mail.gmail.com>
In-Reply-To: <CAPcyv4gwbZ=Z6xCjDCASpkPnw1EC8NMAJDh9_sa3n2PAG5+zAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e02c91-580b-432c-0857-08d9a4778c4f
x-ms-traffictypediagnostic: SJ0PR10MB5534:
x-microsoft-antispam-prvs: <SJ0PR10MB55343FB00253A9AC4B1DD3E6F3939@SJ0PR10MB5534.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llhCXkMSOXMCRaw9g0lSdQ9mFEvd6bJ/htzUYEul8Ds8GWzHGLCJeF8LK6IIZ6Rh4X/LCHkjLwTZyQQTC4cK0TSwjRMnQQ4l1QWi/G6IJuMYWkCfdXpGFdJ5kyTJRVY7FPlv6x5vQpKvWtlBl27MSDq8NMDsNz0RjviPKih1EG5AtuI5xhkbWRgB3vFSUYI6/rS0+PaWp0aOdSNfgrYIdxLDCbu3koJBwbm9x7PEltREopa+OUwCUFuNenVzgnhGJKb7RE+XvxadjIORgChf+fB9f4fafz/xOIOhcybhWuTwKL7qysowbEHRG3LosKtpYeQyFripJyyQLAntG7FQb2ftVz1IT0SkoFxgp3Sz4xNNxrGU8rm3bKJ848LTBwk9u7f1z9iwCggYqAVkNwwfNTqxg9krjV9tiKuu+ACtx9EOXF89tzzRQFLE8ceh14xW6eeyWj5ftR8WX9z1ZnZNE3liabqNU/udIn1+9AMkbKeUrPQs7m7zrFQqQeXT0kYBwmbVGz8Lyo/iIiuTWXrvGlQULxXztcd/3kV6J5DlmIb+v8ZAQbKWsaXUtZ2BGWRpkSgu6ryLanyekWEslINyXXLULupgrleIuwEyeTfGv6vx5uby9WQSysAYOeXJosmk3Wes1MeEq/DOG4YsmK/RT/ayFshlZVtPCeOvkt5eUzDAIgaH7FlvAqzKZmjhgFvBes9Q4zyGWywP25KQ40wv1fRS+XuAHhKyf/ecF+pqMupR4iD010eNlfeHIyOT8oinMiY3fTmQAU6ZPsRvhGBVhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(83380400001)(8936002)(38070700005)(38100700002)(66476007)(316002)(64756008)(186003)(54906003)(66946007)(31686004)(2616005)(36756003)(508600001)(7416002)(71200400001)(31696002)(2906002)(5660300002)(6506007)(53546011)(8676002)(6486002)(26005)(6512007)(44832011)(86362001)(6916009)(66446008)(4326008)(66556008)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTR0VDY2WFpZN2VKS2FoaFNoZFdjbGlDYm9uSDlWdXh1Ry9tK1B0UElTd3lL?=
 =?utf-8?B?TFlQWWNWQUsvcHlUTk4rREozekRLNUcxaFUvS296TElhbkYxeHdNTllQWHdi?=
 =?utf-8?B?YWsrYmhaMElBRzNnS1hoODQyZHlPYXNHamM3UXR4QWVONDFmK1QzMHA4UGVD?=
 =?utf-8?B?ZUJ6elpzQm5JSXhCTS8rczdHYlN0MnRSVEJDSERVYUlwcDFSU3ZkTm5Dd3RK?=
 =?utf-8?B?VFNJWU9nbFl5cG5ZT3Y3TkVEK09VeHg3dHpHUlI0RkFKdk0wSldqaE5aKzF6?=
 =?utf-8?B?emY4SnkwYWRKcnhhSWZ5ZDVCNjF6bWdrbE5TMDFPdUU1Y3k1TkczWGdvWkJG?=
 =?utf-8?B?RWRDaVRwejJTc0FNWSs2SG54V1hzR1JrMm5YcGVzTWhUd25jdlVYaDE0UERn?=
 =?utf-8?B?TEZ5YXhqTkVqUS9IYlRURnJOZnR1bXpVU0JCOENrenNPZFd0ZmVMZHZ4d2ho?=
 =?utf-8?B?bWZKVXIrSGorcTlvUGxSZkZzQ2syT1FRWTlIdW1EYlAwNVVJYWdVYldGbXlU?=
 =?utf-8?B?R3JvcWM4U1B5VjVjb1dPb3ppZW9uL2U4SGQydUJ5TUNNMUN5V2ZpQmJJT3hC?=
 =?utf-8?B?dE1iVld2NGpTamFXU0dNVC9mTW5XMkRKdFNqVmQzZm5jLzRBeVdISVlyak14?=
 =?utf-8?B?UUxqNW9ESkVrSys0LzU5QkFrWXYxd1VON2l1WlkrV0JjK2dCbFJJdmY2SmIz?=
 =?utf-8?B?WnU2Tyt0djVqK1VXWllSRlhzQ1krODVVQys0aUV2dEl0UFpvbGlMRExrM21G?=
 =?utf-8?B?elFQU0NWcWNwUUY3ZFEwRlJORStYMHU1Mk5lRHZRV0U2MjFkWjAyZlozdklV?=
 =?utf-8?B?S05YdStsTi9lUkNQc3NoY2VLMzdQN0lGRjlHNzhyQ2VIUVd0QmJIUE5PRTFP?=
 =?utf-8?B?ZWQ0NW5XWjBIVVAxNkhjZ3MwejFNZ3VpMVEra3R6N2t4aFhiOGNDZkN5aFpa?=
 =?utf-8?B?c1lIYVNKcU82bSs5Z3dBUWxaT3VDcHY4SXdSR1I2MERxMHdSN0xoTFdsLzdE?=
 =?utf-8?B?UHJZRkl6TmVyQzJUZndybVpxV0M1bUloYkxnYy9sYUtFRWo4WXE4cGl2azVF?=
 =?utf-8?B?b0ZTQlRqZjVDNGlxcmFYbWZnWTJBWWRtQVlIdy9teFJJdjh5N3FLd0w0VDhp?=
 =?utf-8?B?N0ZiNkZQTURwUGdobm5iSDFxdHdyMTNpZHAycnV4b2cvQkl3WEhEbUtBNW4v?=
 =?utf-8?B?ajFqeE5FMGRQK2g2MUdSNzBXbmRKUkppZWJmS0VtMnIxRG5TL043WVVlRGJ5?=
 =?utf-8?B?M25ucHorZU1EeEx2Wkd1UllrU1NGaXB2RHBVcWgxdW1XWlBZYUJkL213dzVS?=
 =?utf-8?B?S3UyQTFZMFpueHFaMGpjUHcvSTd1ekdOaW1yT3BqeFFwVkhKZ1FZRmZrU1NC?=
 =?utf-8?B?akNCd0FQaW5ENXF3V0Z4ZlM2UVFsSElkakNGc1U2L1U4RFpDTnRtSC8wTTE0?=
 =?utf-8?B?Rzl3cURCTGJxbUJYQmFlVmtqOVI4Znk2NUJib1hzNmZ2NE9UajBsYjVhTk5C?=
 =?utf-8?B?ZE1ubEc4YUh6QjEwcHhLak1jZlBKb1FPTGl0ZVNuYWdmeHRDT0k3RzlLOVds?=
 =?utf-8?B?aS83dDduMjJQQlZTektGZlp6MngrdE43Snc2bGgwazVYcVVDb0hJdnpNRDlk?=
 =?utf-8?B?QUpqMTEvNUVsaloxbjdFbHoyeXFSTEl4VGxnWE9lTXE2YkFYMGdzTTFyOE5z?=
 =?utf-8?B?VGIrbzhjcDN4c0hxd3BlSEV0eW9ZMFkvVkdjQ2hUMmlFL2J1VG1MK3NXSGcr?=
 =?utf-8?B?UUZLM0JaNXZqUmtnbncwcU40QVJEcEF6T0pKNFRmYVpyVk9uQ3FMQTFtaEcw?=
 =?utf-8?B?TU9salo0WjFTTWNXMHZqZ3UyYk82dnpMYzE3ZUUwOGRkQ3BaT1BJbW11R0Fj?=
 =?utf-8?B?eHhrc1dPWHQrNzZDdit4SStuc2lMSTI1eWxxcDUrQjZiSnJocThtZHltVVJ3?=
 =?utf-8?B?c3didG9RaEFWNTF5Ullwcml6bFZDQU9nZ0t1cnNxQkY2V0cxV0ZrWFBqUFQ2?=
 =?utf-8?B?MVRuS0tFQllRMWd3VXc5cTVGZUVXQXFDMlF4NVJwaEZUdUFNUHVjSm5LblBu?=
 =?utf-8?B?VWFUa2JzaEJSZGMvQjFqSy9wYjFvSjJ3OTBsV3NNWllWaVZSS2xSYjdya296?=
 =?utf-8?B?bTBxSkhiZFZCL3Jxa3hvS0pWRlgyeUdYYUxMeU9kUTRyNnQ2NkFxZGN1Ujdh?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02425C3062B0BB4D8EB70258B3CA0A2D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e02c91-580b-432c-0857-08d9a4778c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 18:26:01.0454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s650s6cUZibOl5zv8fdLoz4F4AUE78HL4aLnOYtGaG2ZK8Tnw4NicCthJ0E9Adh0sS6Zx8RrMeSiu91nDJ2EaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5534
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100091
X-Proofpoint-GUID: t8AFUFFuH-1HZaCuCF5T5DRVP34guocL
X-Proofpoint-ORIG-GUID: t8AFUFFuH-1HZaCuCF5T5DRVP34guocL
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvOS8yMDIxIDE6MDIgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gVHVlLCBOb3Yg
OSwgMjAyMSBhdCAxMTo1OSBBTSBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gT24gMTEvOS8yMDIxIDEwOjQ4IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4g
T24gTW9uLCBOb3YgOCwgMjAyMSBhdCAxMToyNyBQTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiBGcmksIE5vdiAwNSwgMjAyMSBhdCAw
NzoxNjozOFBNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+Pj4+ICAgIHN0YXRpYyBzaXplX3Qg
cG1lbV9jb3B5X2Zyb21faXRlcihzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2RldiwgcGdvZmZfdCBw
Z29mZiwNCj4+Pj4+ICAgICAgICAgICAgICAgICB2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0
cnVjdCBpb3ZfaXRlciAqaSwgaW50IG1vZGUpDQo+Pj4+PiAgICB7DQo+Pj4+PiArICAgICBwaHlz
X2FkZHJfdCBwbWVtX29mZjsNCj4+Pj4+ICsgICAgIHNpemVfdCBsZW4sIGxlYWRfb2ZmOw0KPj4+
Pj4gKyAgICAgc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtID0gZGF4X2dldF9wcml2YXRlKGRheF9k
ZXYpOw0KPj4+Pj4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gcG1lbS0+YmIuZGV2Ow0KPj4+
Pj4gKw0KPj4+Pj4gKyAgICAgaWYgKHVubGlrZWx5KG1vZGUgPT0gREFYX09QX1JFQ09WRVJZKSkg
ew0KPj4+Pj4gKyAgICAgICAgICAgICBsZWFkX29mZiA9ICh1bnNpZ25lZCBsb25nKWFkZHIgJiB+
UEFHRV9NQVNLOw0KPj4+Pj4gKyAgICAgICAgICAgICBsZW4gPSBQRk5fUEhZUyhQRk5fVVAobGVh
ZF9vZmYgKyBieXRlcykpOw0KPj4+Pj4gKyAgICAgICAgICAgICBpZiAoaXNfYmFkX3BtZW0oJnBt
ZW0tPmJiLCBQRk5fUEhZUyhwZ29mZikgLyA1MTIsIGxlbikpIHsNCj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICBpZiAobGVhZF9vZmYgfHwgIShQQUdFX0FMSUdORUQoYnl0ZXMpKSkgew0KPj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiRm91bmQgcG9p
c29uLCBidXQgYWRkciglcCkgYW5kL29yIGJ5dGVzKCUjbHgpIG5vdCBwYWdlIGFsaWduZWRcbiIs
DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIsIGJ5dGVz
KTsNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAoc2l6ZV90KSAt
RUlPOw0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICBwbWVtX29mZiA9IFBGTl9QSFlTKHBnb2ZmKSArIHBtZW0tPmRhdGFfb2Zmc2V0Ow0K
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChwbWVtX2NsZWFyX3BvaXNvbihwbWVtLCBw
bWVtX29mZiwgYnl0ZXMpICE9DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQkxLX1NUU19PSykNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAoc2l6ZV90KSAtRUlPOw0KPj4+Pj4gKyAgICAgICAgICAgICB9DQo+Pj4+
PiArICAgICB9DQo+Pj4+DQo+Pj4+IFRoaXMgaXMgaW4gdGhlIHdyb25nIHNwb3QuICBBcyBzZWVu
IGluIG15IFdJUCBzZXJpZXMgaW5kaXZpZHVhbCBkcml2ZXJzDQo+Pj4+IHJlYWxseSBzaG91bGQg
bm90IGhvb2sgaW50byBjb3B5aW5nIHRvIGFuZCBmcm9tIHRoZSBpdGVyLCBiZWNhdXNlIGl0DQo+
Pj4+IHJlYWxseSBpcyBqdXN0IG9uZSB3YXkgdG8gd3JpdGUgdG8gYSBudmRpbW0uICBIb3cgd291
bGQgZG0td3JpdGVjYWNoZQ0KPj4+PiBjbGVhciB0aGUgZXJyb3JzIHdpdGggdGhpcyBzY2hlbWU/
DQo+Pj4+DQo+Pj4+IFNvIElNSE8gZ29pbmcgYmFjayB0byB0aGUgc2VwYXJhdGUgcmVjb3Zlcnkg
bWV0aG9kIGFzIGluIHlvdXIgcHJldmlvdXMNCj4+Pj4gcGF0Y2ggcmVhbGx5IGlzIHRoZSB3YXkg
dG8gZ28uICBJZi93aGVuIHRoZSA2NC1iaXQgc3RvcmUgaGFwcGVucyB3ZQ0KPj4+PiBuZWVkIHRv
IGZpZ3VyZSBvdXQgYSBnb29kIHdheSB0byBjbGVhciB0aGUgYmFkIGJsb2NrIGxpc3QgZm9yIHRo
YXQuDQo+Pj4NCj4+PiBJIHRoaW5rIHdlIGp1c3QgbWFrZSBlcnJvciBtYW5hZ2VtZW50IGEgZmly
c3QgY2xhc3MgY2l0aXplbiBvZiBhDQo+Pj4gZGF4LWRldmljZSBhbmQgc3RvcCBhYnN0cmFjdGlu
ZyBpdCBiZWhpbmQgYSBkcml2ZXIgY2FsbGJhY2suIFRoYXQgd2F5DQo+Pj4gdGhlIGRyaXZlciB0
aGF0IHJlZ2lzdGVycyB0aGUgZGF4LWRldmljZSBjYW4gb3B0aW9uYWxseSByZWdpc3RlciBlcnJv
cg0KPj4+IG1hbmFnZW1lbnQgYXMgd2VsbC4gVGhlbiBmc2RheCBwYXRoIGNhbiBkbzoNCj4+Pg0K
Pj4+ICAgICAgICAgICByYyA9IGRheF9kaXJlY3RfYWNjZXNzKC4uLiwgJmthZGRyLCAuLi4pOw0K
Pj4+ICAgICAgICAgICBpZiAodW5saWtlbHkocmMpKSB7DQo+Pj4gICAgICAgICAgICAgICAgICAg
a2FkZHIgPSBkYXhfbWtfcmVjb3Zlcnkoa2FkZHIpOw0KPj4NCj4+IFNvcnJ5LCB3aGF0IGRvZXMg
ZGF4X21rX3JlY292ZXJ5KGthZGRyKSBkbz8NCj4gDQo+IEkgd2FzIHRoaW5raW5nIHRoaXMganVz
dCBkb2VzIHRoZSBoYWNrZXJ5IHRvIHNldCBhIGZsYWcgYml0IGluIHRoZQ0KPiBwb2ludGVyLCBz
b21ldGhpbmcgbGlrZToNCj4gDQo+IHJldHVybiAodm9pZCAqKSAoKHVuc2lnbmVkIGxvbmcpIGth
ZGRyIHwgREFYX1JFQ09WRVJZKQ0KDQpPa2F5LCBob3cgYWJvdXQgY2FsbCBpdCBkYXhfcHJlcF9y
ZWNvdmVyeSgpPw0KDQo+IA0KPj4NCj4+PiAgICAgICAgICAgICAgICAgICBkYXhfZGlyZWN0X2Fj
Y2VzcyguLi4sICZrYWRkciwgLi4uKTsNCj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gZGF4
X3JlY292ZXJ5X3tyZWFkLHdyaXRlfSguLi4sIGthZGRyLCAuLi4pOw0KPj4+ICAgICAgICAgICB9
DQo+Pj4gICAgICAgICAgIHJldHVybiBjb3B5X3ttY190b19pdGVyLGZyb21faXRlcl9mbHVzaGNh
Y2hlfSguLi4pOw0KPj4+DQo+Pj4gV2hlcmUsIHRoZSByZWNvdmVyeSB2ZXJzaW9uIG9mIGRheF9k
aXJlY3RfYWNjZXNzKCkgaGFzIHRoZSBvcHBvcnR1bml0eQ0KPj4+IHRvIGNoYW5nZSB0aGUgcGFn
ZSBwZXJtaXNzaW9ucyAvIHVzZSBhbiBhbGlhcyBtYXBwaW5nIGZvciB0aGUgYWNjZXNzLA0KPj4N
Cj4+IGFnYWluLCBzb3JyeSwgd2hhdCAncGFnZSBwZXJtaXNzaW9ucyc/ICBtZW1vcnlfZmFpbHVy
ZV9kZXZfcGFnZW1hcCgpDQo+PiBjaGFuZ2VzIHRoZSBwb2lzb25lZCBwYWdlIG1lbV90eXBlIGZy
b20gJ3J3JyB0byAndWMtJyAoc2hvdWxkIGJlIE5QPyksDQo+PiBkbyB5b3UgbWVhbiB0byByZXZl
cnNlIHRoZSBjaGFuZ2U/DQo+IA0KPiBSaWdodCwgdGhlIHJlc3VsdCBvZiB0aGUgY29udmVyc2F0
aW9uIHdpdGggQm9yaXMgaXMgdGhhdA0KPiBtZW1vcnlfZmFpbHVyZSgpIHNob3VsZCBtYXJrIHRo
ZSBwYWdlIGFzIE5QIGluIGNhbGwgY2FzZXMsIHNvDQo+IGRheF9kaXJlY3RfYWNjZXNzKCkgbmVl
ZHMgdG8gY3JlYXRlIGEgVUMgbWFwcGluZyBhbmQNCj4gZGF4X3JlY292ZXJfe3JlYWQsd3JpdGV9
KCkgd291bGQgc2luayB0aGF0IG9wZXJhdGlvbiBhbmQgZWl0aGVyIHJldHVybg0KPiB0aGUgcGFn
ZSB0byBOUCBhZnRlciB0aGUgYWNjZXNzIGNvbXBsZXRlcywgb3IgY29udmVydCBpdCB0byBXQiBp
ZiB0aGUNCj4gb3BlcmF0aW9uIGNsZWFyZWQgdGhlIGVycm9yLg0KDQpPa2F5LCAgd2lsbCBhZGQg
YSBwYXRjaCB0byBmaXggc2V0X21jZV9ub3NwZWMoKS4NCg0KSG93IGFib3V0IG1vdmluZyBzZXRf
bWVtb3J5X3VjKCkgYW5kIHNldF9tZW1vcnlfbnAoKSBkb3duIHRvDQpkYXhfcmVjb3ZlcnlfcmVh
ZCgpLCBzbyB0aGF0IHdlIGRvbid0IHNwbGl0IHRoZSBzZXRfbWVtb3J5X1ggY2FsbHMNCm92ZXIg
ZGlmZmVyZW50IEFQSXMsIGJlY2F1c2Ugd2UgY2FuJ3QgZW5mb3JjZSB3aGF0IGZvbGxvd3MNCmRh
eF9kaXJlY3RfYWNjZXNzKCk/DQoNCj4gDQo+Pj4gZGF4X3JlY292ZXJ5X3JlYWQoKSBhbGxvd3Mg
cmVhZGluZyB0aGUgZ29vZCBjYWNoZWxpbmVzIG91dCBvZiBhDQo+Pj4gcG9pc29uZWQgcGFnZSwg
YW5kIGRheF9yZWNvdmVyeV93cml0ZSgpIGNvb3JkaW5hdGVzIGVycm9yIGxpc3QNCj4+PiBtYW5h
Z2VtZW50IGFuZCByZXR1cm5pbmcgYSBwb2lzb24gcGFnZSB0byBmdWxsIHdyaXRlLWJhY2sgY2Fj
aGluZw0KPj4+IG9wZXJhdGlvbiB3aGVuIG5vIG1vcmUgcG9pc29uZWQgY2FjaGVsaW5lIGFyZSBk
ZXRlY3RlZCBpbiB0aGUgcGFnZS4NCj4+Pg0KPj4NCj4+IEhvdyBhYm91dCB0byBpbnRyb2R1Y2Ug
MyBkYXhfcmVjb3Zlcl8gQVBJczoNCj4+ICAgICBkYXhfcmVjb3Zlcl9kaXJlY3RfYWNjZXNzKCk6
IHNpbWlsYXIgdG8gZGF4X2RpcmVjdF9hY2Nlc3MgZXhjZXB0DQo+PiAgICAgICAgaXQgaWdub3Jl
cyBlcnJvciBsaXN0IGFuZCByZXR1cm4gdGhlIGthZGRyLCBhbmQgaGVuY2UgaXMgYWxzbw0KPj4g
ICAgICAgIG9wdGlvbmFsLCBleHBvcnRlZCBieSBkZXZpY2UgZHJpdmVyIHRoYXQgaGFzIHRoZSBh
YmlsaXR5IHRvDQo+PiAgICAgICAgZGV0ZWN0IGVycm9yOw0KPj4gICAgIGRheF9yZWNvdmVyeV9y
ZWFkKCk6IG9wdGlvbmFsLCBzdXBwb3J0ZWQgYnkgcG1lbSBkcml2ZXIgb25seSwNCj4+ICAgICAg
ICByZWFkcyBhcyBtdWNoIGRhdGEgYXMgcG9zc2libGUgdXAgdG8gdGhlIHBvaXNvbmVkIHBhZ2U7
DQo+IA0KPiBJdCB3b3VsZG4ndCBiZSBhIHByb3BlcnR5IG9mIHRoZSBwbWVtIGRyaXZlciwgSSBl
eHBlY3QgaXQgd291bGQgYmUgYQ0KPiBmbGFnIG9uIHRoZSBkYXggZGV2aWNlIHdoZXRoZXIgdG8g
YXR0ZW1wdCByZWNvdmVyeSBvciBub3QuIEkuZS4gZ2V0DQo+IGF3YXkgZnJvbSB0aGlzIGJlaW5n
IGEgcG1lbSBjYWxsYmFjayBhbmQgbWFrZSB0aGlzIGEgbmF0aXZlIGNhcGFiaWxpdHkNCj4gb2Yg
YSBkYXggZGV2aWNlLg0KPiANCj4+ICAgICBkYXhfcmVjb3Zlcnlfd3JpdGUoKTogb3B0aW9uYWws
IHN1cHBvcnRlZCBieSBwbWVtIGRyaXZlciBvbmx5LA0KPj4gICAgICAgIGZpcnN0IGNsZWFyLXBv
aXNvbiwgdGhlbiB3cml0ZS4NCj4+DQo+PiBTaG91bGQgd2Ugd29ycnkgYWJvdXQgdGhlIGRtIHRh
cmdldHM/DQo+IA0KPiBUaGUgZG0gdGFyZ2V0cyBhZnRlciBDaHJpc3RvcGgncyBjb252ZXJzaW9u
IHNob3VsZCBiZSBhYmxlIHRvIGRvIGFsbA0KPiB0aGUgdHJhbnNsYXRpb24gYXQgZGlyZWN0IGFj
Y2VzcyB0aW1lIGFuZCB0aGVuIGRheF9yZWNvdmVyeV9YIGNhbiBiZQ0KPiBkb25lIG9uIHRoZSBy
ZXN1bHRpbmcgYWxyZWFkeSB0cmFuc2xhdGVkIGthZGRyLg0KDQpJJ20gdGhpbmtpbmcgYWJvdXQg
dGhlIG1peGVkIGRldmljZSBkbSB3aGVyZSBzb21lIHByb3ZpZGVzDQpkYXhfcmVjb3ZlcnlfWCwg
b3RoZXJzIGRvbid0LCBpbiB3aGljaCBjYXNlIHdlIGRvbid0IGFsbG93DQpkYXggcmVjb3Zlcnkg
YmVjYXVzZSB0aGF0IGNhdXNlcyBjb25mdXNpb24/IG9yIHNob3VsZCB3ZSBzdGlsbA0KYWxsb3cg
cmVjb3ZlcnkgZm9yIHBhcnQgb2YgdGhlIG1peGVkIGRldmljZXM/DQoNCj4gDQo+PiBCb3RoIGRh
eF9yZWNvdmVyeV9yZWFkL3dyaXRlKCkgYXJlIGhvb2tlZCB1cCB0byBkYXhfaW9tYXBfaXRlcigp
Lg0KPiANCj4gWWVzLg0KPiANCg0KdGhhbmtzIQ0KLWphbmUNCg==
