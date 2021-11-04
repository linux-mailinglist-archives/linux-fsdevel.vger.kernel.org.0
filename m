Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242E94459C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 19:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhKDSgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 14:36:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1524 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhKDSgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:36:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4IUwwJ027083;
        Thu, 4 Nov 2021 18:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WgwqZ3fgf89GbBGjkvjdoGdsNLp3xz6CjtD3L6qgHhE=;
 b=PtnS2rmUGBvS6q0gq3GhLncziNQdi51ECHZMQe8wMv3kGQXvZP8y0tMyM8hnnwzqJihZ
 IK2ppVsRsjgR7NYQurnVeTQ8aBjiq6dxmoTHuQANVfNldWuRUU0kMEcAo43Hfh1+rUze
 ktC9YHc1c5EG0L3UZNvDYFwaWdbJdBmLacFyiejM54qgJ/eg6lyqPbhdAm1L8WL2rTEq
 qsYkBNBEPxjYtJNnkuUY3tKSTMYm9745MwbqCB0LT7swNOEemdoURqjdVKg538hZD2r+
 QRxCejPmyYdKdiOr1rw2tybAvFHaTBPqaAUQH2IclWqyP80x6NF3MA+/YxOfgral72bp EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mxhac41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 18:33:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4IUO2Y161052;
        Thu, 4 Nov 2021 18:33:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 3c1khxmru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 18:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kex196lObWWL/nlHdrCc71qYIGO7+jmBQoQFAYACAQfKp03f6+eHQPFbHErCv2rRVFFKLSzwD7SjtmYIXa57d/aAZQc1cuq/xpkG5U+7230hWnKUZuZ/A8MWt9zfNtZOhfAaECBdZVxJWsRuZ92J3c3DQwn5VgWyY3y0nfe0wARIL4RZUWgM8AexFynpF4H83EDkHPu3llWMWb9OOCtQz3SWWq1s51YfokI2LmJKTsNOHwU8Z0hSU8dYKAXhav21nW5XH+sxXxkyNIW0zflyK9KNrMWnwLO46moHotUHZ7fFk9oNUvgHwov3T+OG9cqF3ByAtWcs14l48KZnvQaV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgwqZ3fgf89GbBGjkvjdoGdsNLp3xz6CjtD3L6qgHhE=;
 b=adZ7S19jFxFWHc+TEwXwj6GEijlmfKG6EEPzD5vvxru0ExO5Ymvep39BGWTz5M2sVKVc3a3r1nH8QzYt4iGDiRvxdJl1SBRTqY6anxE0nkdg9D21B8exRIbspRr1rKGWerSO4Td1olzGXYr+UXrKtWUyE30OMteq7nsD0e79sSg/o6tLXKXQCWm4BylaEPMx1NWvTScEQ8R8DDcvOxFLb0oacNBHBmC3wAASjUyYMpE+zHXXfKQ5/tg3Qgbn5JF6/ZFnWNaeVZ/U6CYZH/3IxwOdSf08C55AMJYNhBPLgfTu8LFNn3th0kWmT5fd+lNnM6/vMipya/ck+KF1vpQ+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgwqZ3fgf89GbBGjkvjdoGdsNLp3xz6CjtD3L6qgHhE=;
 b=H9IdSJeY5qBjDUIFurWab1Z/yn5v41bJNQU7rQutcHQLLVwn6tCzRpbupSRSRmHb+TjEjkArMlX4IrpbD/02izxPrwna6yNUDsDwUkgSciB2ngccuA473KHMwAVZnzLJuNDiAUCqJgVEc3b9p3yDgoNiDtD9AjXiknUaVGhHX9c=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 18:33:49 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 18:33:49 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
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
Thread-Index: AQHXxhAze/H2dZp4I0O0xNcfyRn+pqvdUicAgADsdoCAAELPAIABAAaAgAbwJYCAASa6gIAIPpYAgADknQCAAWBnAIAAPDYAgADIRwCAAIRIgIAAJDSA
Date:   Thu, 4 Nov 2021 18:33:49 +0000
Message-ID: <6d21ece1-0201-54f2-ec5a-ae2f873d46a3@oracle.com>
References: <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
 <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org>
 <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
 <YYOaOBKgFQYzT/s/@infradead.org>
 <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
In-Reply-To: <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feb87378-dea7-4c73-7e2b-08d99fc1a517
x-ms-traffictypediagnostic: BY5PR10MB4387:
x-microsoft-antispam-prvs: <BY5PR10MB43879581499D40C6B2128D29F38D9@BY5PR10MB4387.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4NLcLaU+imd5VEHx+ZkEpFlnlK1uQ+bUJba246VyezqxdMRlK5bvODUPYUBPdEd5IrowPjDySb2sS0lQIlapGXHLL5K5dEXvg09Sj2PHky4mSpOblrQnSlW0QVVaoELyJoFJxm+KKnknezCNyCJhQ7pAZCMgtB9NVpf7+Guctl+UFAQjUK+ten8l2SkzFKAWWXOdXW9t/Bu4WZhv8KWfYbMaAyNruf1EuhC5X8Vyt91DlLNcM/72uEmRe/uWmMP8o5y6Wip6pRoVs2h4SKEeMlhFOr2Mwp8DxTQeg+iTTG7xmBnz4/q7oerH9jt3D07f6XaZ2qgAZUobB9jrWYcK5YFGtMrXJrClOKl7+RxewdqH4YGVnFoqAOdvzV4er7F9cbQei+LajDITpIYclCdg6aj3NjR19rvkdrT8AQ8feNgse+VxJ2vHDT3Jt1asEDZOQXra1bUNGd1wCXiKDI5cFwgZZIXbHK/HaNA+9NVja0htlCWMm8njUztQWnxde2zWgpMtD21/X10CF52gHUpaiFpr+UYcFPdtsmqyHXgsQO3zKJJa+Zot8aGrZxjK+H9fLV7NE+5hiwi/uWm/yjYt9l3fEofzz0o9Tkde0uwN5UnqxN86GvwBD/hcbkmUHcYX6/IPavD9842Il5pActxsJSvDaFbGRbLIEXgrFRum8VSLsZ2UIAzwxjNF5UftMFfdVIBUGNVJ8xyw0coJvU+myfotpfelGuFFdxVtlkGHFLV1+2hsCMqxD6EYC4slbVn2DgIfJS84DDhxSIXKakRbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(71200400001)(4326008)(2616005)(86362001)(6486002)(31686004)(110136005)(316002)(44832011)(54906003)(26005)(6512007)(66446008)(64756008)(38100700002)(122000001)(5660300002)(7416002)(66946007)(66476007)(66556008)(186003)(76116006)(2906002)(31696002)(6506007)(36756003)(8936002)(83380400001)(38070700005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG9KUlN5UXl6cnJ1U0gyRW1zR3N6bmdDRGpqOE9JaDZhNGlLdmp5RERiN0lT?=
 =?utf-8?B?ek9WSzZTaDgzTFltVkFnN0hBMDBYLzF4eG1rRnZGS0N2cXk2VmdxYUxZZ2Ez?=
 =?utf-8?B?YzVEWEJONTl6ZTh5K2E2dFZ6NW80Tkk4Nm8yWE1ibFRheDkvazl0bmRiSlNy?=
 =?utf-8?B?c2plSm9jcFlNNUJqN29ENDJrNWdDaXdkcWFrOXVLL0t3SFRZMnI2UkFvejh6?=
 =?utf-8?B?aElQVnN4Z0oydGxOQzMxTzBpdHVGdXhFNjZFR0RLcXc2WHVudDVWbW5CdjRv?=
 =?utf-8?B?TzZSQVBzbk9VbjFVUEs0cm5mMEc3QW9IS2Z0OG1sV2dMTkpHVmFBYUdCSWJ1?=
 =?utf-8?B?MkhOc2VvTUdzVW5ZREZqVWNJenlVWkhoNkZVellQVzRJNE1UdllDMDZLSkJn?=
 =?utf-8?B?dEtmQkVza1JuMHowQ3dTSkR1SEZoTWVrMldkVDRsMzJ3TFlFNm1Ma3czditD?=
 =?utf-8?B?a1ZNdzkwV2RGQkNvK0M5blpJY1p0N0dadlNYWWFJbHYxYkIzYXpUbUtCbE5o?=
 =?utf-8?B?Q0VwS3F4NzBBZytOcGVDdUlzS2Nqa016RUFIMzlUQzdxMWpSUVF6ZmJQejdU?=
 =?utf-8?B?ZkNnZmU5RHNaVDd5SHZvbXBHbEhlbmFrTzJwYnFUVzliZGkzdkJYK0hYMWNM?=
 =?utf-8?B?SVZBYXJucndncE1yU0Y1REE0aGpLZDhya25aNjJUNDAzZXI2UGtWZDFUTmNn?=
 =?utf-8?B?TU9VcnBQb2xPNWdNWlIrZUtaM0F5SjN3blFSbFdvNlZBSEt3UmlqdWdDdHAx?=
 =?utf-8?B?VHkvakJ4ZVV3SGdhZ01yc0ZZZHlKQ3RwME95WU1GSUtQSW1mdzNpKzZSTjQy?=
 =?utf-8?B?VmpSWkhsVFZ2RUttdWdNdjI3MktlY2oxWHpidnhsanl5NmFkeWZQdXo5ckNU?=
 =?utf-8?B?R3BEQkVndHdHVytJS1hjRTgzZFFqNS90Y3NWeWY4NUFuamZjOU96cWorUTNJ?=
 =?utf-8?B?SUo0U1BlNmtsTFhCN0NyTUZrdXFtTW5IaDVhdU1BcytiN1FyNk1uYmFuMHVq?=
 =?utf-8?B?dDMxNEozblVlMGdHQVU1OWNCME5GcE9GQ24zdklNYjVuR3pWRkRueEZVTzNi?=
 =?utf-8?B?OFhadGNSSkM4ZW1ZRWhsNG4zY0tMWHBQY1FxWXUyOWJrZTRLOG9kU0o1U1dZ?=
 =?utf-8?B?c2xPVkJBelorV2JXTk1QOURUdlRLN2JPeS9tZzdPY1E0ZTRlMmFNYlBqd0hv?=
 =?utf-8?B?VEsvSXpQWmIwRWl1ZFE3YmJYOG5kdVNXKytNWkptVHpGVE10V3hmdGtjSEQw?=
 =?utf-8?B?L1JGOUdiQ1RNWmVCYlJlSFZkakdHZGhwY2ZGRlVRRFNTem5JUldPOUY4N2Iv?=
 =?utf-8?B?VkVmTWdhUS84TFR0SEg3UkRYbU5FQnJsK1U5RmE3cjJtc1pnVzZvSDNPL2dn?=
 =?utf-8?B?bW9lUUxybUNOdTRrZ0dBKzBIWnlXYlhadVNpVFZQWkc2NExKNy9UTjJvclNa?=
 =?utf-8?B?YlI2VXQ3bWxxcjRmU0lEbHJUYUQyeWEvL2VLc3FuUjBveU1yclJaY29mbFU3?=
 =?utf-8?B?djV3UFdQcHlzWXlhdmw5YjdPVHI0WHMzdFduUkVYajZYYi9jSklUMkpldThF?=
 =?utf-8?B?SUhZcTd2U2Q4Qlh1UEYzclFsRytKdU1VM3E2UTdRVzJoeHJLM0Fram8rNDgr?=
 =?utf-8?B?QzgwTWZySnhmbGhJb2dnZkNYV0ZDdHkyMG40WUNoajZMTkhMbFdpQ1h2MmMy?=
 =?utf-8?B?RXBLZFJaMW1MMElQdXZvT2c2Q05HbUkyaGlVZ1E3ZThjV0JEQWl2NHRMOEpk?=
 =?utf-8?B?NEVqdTZtcXEzZGE4ZGdtNTlpMzRkS0YyaEZINzVrVDNBc3JxcDhnLzNacDBu?=
 =?utf-8?B?NnRwMjRwSjliYkY3dTNKRExRQmx0ZklsVzkvTTZzR2l5azlNWEhzeTkwd0Qy?=
 =?utf-8?B?UjFjYXRPYkJic3Jpam4zeFl4dlNIM3dOMFJqN3dpZjVpWWI5dmdIWFVzWStT?=
 =?utf-8?B?Zk95bDNNLzFBSFVtK3RLa2Irb1FMTWI3M095a29JVDFINE1rZDBPSExYeENU?=
 =?utf-8?B?bzJHc0FkOU5zK1NFbnQrd0FNMTlGVFhvaS9nbFRzZVI2bVpFeUhZNi9jOUFj?=
 =?utf-8?B?Z1VQbUQwS2VRUnVtdkhPRitmeHZoY0JtejdMNGg4MEVLNmF0SVdkSzF6cVlr?=
 =?utf-8?B?NUpNRFlMdERwalJLQ1RvZ2FpZlROMi94ZnJlaVZ5SUdOcG1ZbFl0bFl4N0Nt?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C1C778101671E4EA5D1B9F80B0B9A44@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb87378-dea7-4c73-7e2b-08d99fc1a517
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 18:33:49.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWljXOsnVf/cvuBCXbw5sIzPnyOPcww1t1lj3AV5sJgJt2kl6myveJHSQdnDmKBRR5Nx+xi/CPhdRevxv0iBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040072
X-Proofpoint-ORIG-GUID: BV7LzkUpA8-2rXvY1wA3pdHIT9kH81Vo
X-Proofpoint-GUID: BV7LzkUpA8-2rXvY1wA3pdHIT9kH81Vo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZW5saWdodGVuaW5nIGRpc2N1c3Npb24gaGVyZSwgaXQncyBzbyBoZWxw
ZnVsIQ0KDQpQbGVhc2UgYWxsb3cgbWUgdG8gcmVjYXAgd2hhdCBJJ3ZlIGNhdWdodCB1cCBzbyBm
YXIgLQ0KDQoxLiByZWNvdmVyeSB3cml0ZSBhdCBwYWdlIGJvdW5kYXJ5IGR1ZSB0byBOUCBzZXR0
aW5nIGluIHBvaXNvbmVkDQogICAgcGFnZSB0byBwcmV2ZW50IHVuZGVzaXJhYmxlIHByZWZldGNo
aW5nDQoyLiBzaW5nbGUgaW50ZXJmYWNlIHRvIHBlcmZvcm0gMyB0YXNrczoNCiAgICAgIHsgY2xl
YXItcG9pc29uLCB1cGRhdGUgZXJyb3ItbGlzdCwgd3JpdGUgfQ0KICAgIHN1Y2ggYXMgYW4gQVBJ
IGluIHBtZW0gZHJpdmVyLg0KICAgIEZvciBDUFVzIHRoYXQgc3VwcG9ydCBNT1ZFRElSNjRCLCB0
aGUgJ2NsZWFyLXBvaXNvbicgYW5kICd3cml0ZScNCiAgICB0YXNrIGNhbiBiZSBjb21iaW5lZCAo
d291bGQgbmVlZCBzb21ldGhpbmcgZGlmZmVyZW50IGZyb20gdGhlDQogICAgZXhpc3RpbmcgX2Nv
cHlfbWNzYWZlIHRob3VnaCkgYW5kICd1cGRhdGUgZXJyb3ItbGlzdCcgZm9sbG93cw0KICAgIGNs
b3NlbHkgYmVoaW5kOw0KICAgIEZvciBDUFVzIHRoYXQgcmVseSBvbiBmaXJtd2FyZSBjYWxsIHRv
IGNsZWFyIHBvc2lvbiwgdGhlIGV4aXN0aW5nDQogICAgcG1lbV9jbGVhcl9wb2lzb24oKSBjYW4g
YmUgdXNlZCwgZm9sbG93ZWQgYnkgdGhlICd3cml0ZScgdGFzay4NCjMuIGlmIHVzZXIgaXNuJ3Qg
Z2l2ZW4gUldGX1JFQ09WRVJZX0ZMQUcgZmxhZywgdGhlbiBkYXggcmVjb3ZlcnkNCiAgICB3b3Vs
ZCBiZSBhdXRvbWF0aWMgZm9yIGEgd3JpdGUgaWYgcmFuZ2UgaXMgcGFnZSBhbGlnbmVkOw0KICAg
IG90aGVyd2lzZSwgdGhlIHdyaXRlIGZhaWxzIHdpdGggRUlPIGFzIHVzdWFsLg0KICAgIEFsc28s
IHVzZXIgbXVzdG4ndCBoYXZlIHB1bmNoZWQgb3V0IHRoZSBwb2lzb25lZCBwYWdlIGluIHdoaWNo
DQogICAgY2FzZSBwb2lzb24gcmVwYWlyaW5nIHdpbGwgYmUgYSBsb3QgbW9yZSBjb21wbGljYXRl
ZC4NCjQuIGRlc2lyYWJsZSB0byBmZXRjaCBhcyBtdWNoIGRhdGEgYXMgcG9zc2libGUgZnJvbSBh
IHBvaXNvbmVkIHJhbmdlLg0KDQpJZiB0aGlzIHVuZGVyc3RhbmRpbmcgaXMgaW4gdGhlIHJpZ2h0
IGRpcmVjdGlvbiwgdGhlbiBJJ2QgbGlrZSB0bw0KcHJvcG9zZSBiZWxvdyBjaGFuZ2VzIHRvDQog
ICBkYXhfZGlyZWN0X2FjY2VzcygpLCBkYXhfY29weV90by9mcm9tX2l0ZXIoKSwgcG1lbV9jb3B5
X3RvL2Zyb21faXRlcigpDQogICBhbmQgdGhlIGRtIGxheWVyIGNvcHlfdG8vZnJvbV9pdGVyLCBk
YXhfaW9tYXBfaXRlcigpLg0KDQoxLiBkYXhfaW9tYXBfaXRlcigpIHJlbHkgb24gZGF4X2RpcmVj
dF9hY2Nlc3MoKSB0byBkZWNpZGUgd2hldGhlciB0aGVyZQ0KICAgIGlzIGxpa2VseSBtZWRpYSBl
cnJvcjogaWYgdGhlIEFQSSB3aXRob3V0IERBWF9GX1JFQ09WRVJZIHJldHVybnMNCiAgICAtRUlP
LCB0aGVuIHN3aXRjaCB0byByZWNvdmVyeS1yZWFkL3dyaXRlIGNvZGUuICBJbiByZWNvdmVyeSBj
b2RlLA0KICAgIHN1cHBseSBEQVhfRl9SRUNPVkVSWSB0byBkYXhfZGlyZWN0X2FjY2VzcygpIGlu
IG9yZGVyIHRvIG9idGFpbg0KICAgICdrYWRkcicsIGFuZCB0aGVuIGNhbGwgZGF4X2NvcHlfdG8v
ZnJvbV9pdGVyKCkgd2l0aCBEQVhfRl9SRUNPVkVSWS4NCjIuIHRoZSBfY29weV90by9mcm9tX2l0
ZXIgaW1wbGVtZW50YXRpb24gd291bGQgYmUgbGFyZ2VseSB0aGUgc2FtZQ0KICAgIGFzIGluIG15
IHJlY2VudCBwYXRjaCwgYnV0IHNvbWUgY2hhbmdlcyBpbiBDaHJpc3RvcGgncw0KICAgICdkYXgt
ZGV2aXJ0dWFsaXplJyBtYXliZSBrZXB0LCBzdWNoIGFzIERBWF9GX1ZJUlRVQUwsIG9idmlvdXNs
eQ0KICAgIHZpcnR1YWwgZGV2aWNlcyBkb24ndCBoYXZlIHRoZSBhYmlsaXR5IHRvIGNsZWFyIHBv
aXNvbiwgc28gbm8gbmVlZA0KICAgIHRvIGNvbXBsaWNhdGUgdGhlbS4gIEFuZCB0aGlzIGFsc28g
bWVhbnMgdGhhdCBub3QgZXZlcnkgZW5kcG9pbnQNCiAgICBkYXggZGV2aWNlIGhhcyB0byBwcm92
aWRlIGRheF9vcC5jb3B5X3RvL2Zyb21faXRlciwgdGhleSBtYXkgdXNlIHRoZQ0KICAgIGRlZmF1
bHQuDQoNCkknbSBub3Qgc3VyZSBhYm91dCBub3ZhIGFuZCBvdGhlcnMsIGlmIHRoZXkgdXNlIGRp
ZmZlcmVudCAnd3JpdGUnIG90aGVyDQp0aGFuIHZpYSBpb21hcCwgZG9lcyB0aGF0IG1lYW4gdGhl
cmUgd2lsbCBiZSBuZWVkIGZvciBhIG5ldyBzZXQgb2YNCmRheF9vcCBmb3IgdGhlaXIgcmVhZC93
cml0ZT8gIHRoZSAzLWluLTEgYmluZGluZyB3b3VsZCBhbHdheXMgYmUNCnJlcXVpcmVkIHRob3Vn
aC4gTWF5YmUgdGhhdCdsbCBiZSBhbiBvbmdvaW5nIGRpc2N1c3Npb24/DQoNCkNvbW1lbnRzPyBT
dWdnZXN0aW9ucz8NCg0KVGhhbmtzIQ0KLWphbmUNCg0KDQoNCg0K
