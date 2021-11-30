Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FC462BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 05:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhK3Eux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 23:50:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37966 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238255AbhK3Euw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:50:52 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU45RlO028188;
        Tue, 30 Nov 2021 04:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ku0h2IZN7xlei5P2LoLM0/Cj7OC1UJR+GP6NL8rbNcU=;
 b=IMfZiClh2xl6WkZGJedGycI+m9rmd12BHGeN4mvR3BPONaCMpnLcXtVwia36jsqXo7X3
 qlyUcABozNDK6vwdKZGIuxcP8zAAO8QVNd1QnHdCKvm8YFNPj9d+kM6m4z8XU999HT8t
 VnY061/0Z5Khgt1L7y/9TPUP8SBnAwZjuUVfJwjQC6EG1gkSz4e6UotKNqgbTFdIB16y
 9k9ZN2KGJ6KrkqwTYVNlfzjU/hpfega7xITHE3TLKW1xezEdhJ16k5Sc6Rft8IilWo1b
 ZP13EOH74kI06OACfdKDNvnJ7eaFsJCKq9hvmKbtmJJ6ofB7XADmTOGF+hQe4NA851lE MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1we6tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:47:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU4fflI061663;
        Tue, 30 Nov 2021 04:47:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3cmmupa8a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVVj+ELKB4TRID7KdQDqRldXeTDyBtL4kPUtsnuwnCAG4yHERAl580KFso+ZkRuDw5okE0j8M8POkC839eFs7ukIWVJi8QshmLBPX8+9x4tmXOs+5Vl49e+P/pSwFsmUdy2jGVLP8tuM8qI7VJvO4pngH3BKmcryLd9zdtIsEdVLOVAh5PSTDq0VurrigMHOoo1fzY61E31VZSpaOVFhD4erNViZwSj5nS6j4o3UQT0TNXUkAAKfdLd5dhz2Iwp0PF0lOI/hJ07v5Ukr0ySqYguCAa9RRfDIcZj8p17hZaNiMnjhKPSNdiARRDPCPXJrt93+MiMms/od9AZvezD3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku0h2IZN7xlei5P2LoLM0/Cj7OC1UJR+GP6NL8rbNcU=;
 b=MkO2huOFqBcNd69Acw1HH+f/Wy+Sw3kMOlkzOzvnCR5bj8I523H9HIFBRRwHCNijW7gwjRCT+ZhvegfyEOI2x1KzLPypjuM7cjMQUAfpPTu/1SdahJj56K2nBt2keJAk4NxR8A3FR+5fxuFWp5TJytAtLpXpbDAtDEhxuaQ7bL2YZBKlwwLqUbfMTx5tZfSpAjmWuT+5qbzvQKY6WDtLN+rw6GdM93vJ9eMBvJHUEcAfi2XMB+crCRV+SaCh8NPosNYkmy0rqomS6wrKZJqKMCmABEXFn2ZRm34CrU6KhsMisd85FqIKuqpNYWcLV485etSbro1JI9kfYd0y7uuCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku0h2IZN7xlei5P2LoLM0/Cj7OC1UJR+GP6NL8rbNcU=;
 b=g1Nz+DFjOmINExBotlG04QMSDz4oHh1LqfIycVexejCRLUhTXgqYdCzbvE6zaUBLgi+I2CoXHvG4I57O6DM3OkDY9qpi/aOyhKst7NohyxWH40dZGpPSWck55BcvtpC9YiIsPHtKLsv5a8K7hvnFACKHhsA6UrOh2u0JPTpanZE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 04:47:24 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:47:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHXtMzhlpWZW1OG5ESdBSdOgoHETqu+oymAgAANi4CASGLiAIAA/bOAgAA+8oCAAD8yAIAALy8AgAZzIgCAC+1zAIAABPIAgAARGgCAAAipAIAACTgAgAAabACAADKYgIAAGWS/gAAovICAAArgqQ==
Date:   Tue, 30 Nov 2021 04:47:24 +0000
Message-ID: <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
         <20211001205327.GN959@fieldses.org>
         <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
         <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
         <20211117141433.GB24762@fieldses.org>
         <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
         <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
         <20211118003454.GA29787@fieldses.org>
         <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
         <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
         <20211129173058.GD24258@fieldses.org>
         <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
         <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
         <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
         <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
         <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
         <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
In-Reply-To: <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3351ce67-34f1-4d1a-811c-08d9b3bc80b9
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-microsoft-antispam-prvs: <SJ0PR10MB4687A17F71BD910B5286F96093679@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7VmSX3cexa/cqWwwlJXeyfNvX5iZ/+sLLk//YHoYTBEgp/3IZHdyyDw6kB2i52CqmPZCTJqNkd6pWGRTiyHPsjVgCxAfkQCEyk1wrsAmQ6bLDnh+ETFQdrCq8p4mZIwsA2jZr/tVHFyGD+AcsI4KZDgCmeT4APhe/VZs8E3obtPXqjlouzRHLHFWTG+V8mDzOhwQBD8lnnVZ/Dxs/zJOZeRK+Os0L6fBkh+u1hyvOcoOTE/jbDXhwF+EWTayKGgyeTj9tyyXGoCE1JPhMP2cdgr1jRg/6J4gnz+GTlD5ybys+ewITKe0io0JX8++jczS+fV0wgh/W5Tz05poHTeaJi1S2PjXBHEiik2w/qmrzp6qatiN5x8+Jkw5zV+SxUXK/hnFMreb4iyK3nxb6IeeV/gpB/etcXBS+9pngIEBbfgAtDxb4qHOKwWpt48oYvhxtvl0BjaG5Sm5c7lveixETmWD69DTjLQSspqu5CfGveLU4Qc6E5I6hzMFg+Z1p9U5rQpprSePEwX+I5waXxBMh6mP3SCLzGx+5cIclPP3zivvC7CDPjNiHWLHT7tPsvsBoyJLYkOHS9Fblc04U19uZCe6MvpB6s/yYOA8wcTCNKUFX56Bz2IsOaRkzVHypgyI77MDfMWudVI6gi7McTH+zDw2raWGVGRZNp/htwXxhUpWT3aqiqRrgn6k/OVh9PUbL6RnUcexDQd+g/qXp/Q+pS1aAr+tqWSnhJGa4UNX0SX/B8VpuvFgA432S0I609Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4001150100001)(122000001)(30864003)(86362001)(2616005)(83380400001)(38070700005)(508600001)(4326008)(76116006)(53546011)(26005)(186003)(66946007)(8936002)(54906003)(66476007)(66556008)(66446008)(8676002)(64756008)(36756003)(6916009)(6486002)(6512007)(5660300002)(316002)(71200400001)(33656002)(38100700002)(6506007)(91956017)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGtJb1JmbGF2K3c0RVhMV3VsMEwwa3dab3JZYTc3S2owYlhMR3hnYjUwRnNL?=
 =?utf-8?B?NktmZDQ2bUZWZVhYWlBWeDc3ZW81NXJDZ2dzSVE5Yi9Cdm1pSGtKckM0aUxZ?=
 =?utf-8?B?Zk1GS0xTbTJldktBb0libTcwMnlRd2xmMSsvdVdlYlBIdGhHVSt4aE8vb3Rv?=
 =?utf-8?B?ajVRZ0VzT3I1RWdkdGZZczhndWRDeENXOGFvYW9IZTFoOW1UN0RwaFhuSjAr?=
 =?utf-8?B?RGdETjNNNGlwdUxpdWpIOEg4M3B1a01ES3pVR1UrdFJlMkRJKzFiSFZEK0Q5?=
 =?utf-8?B?eFNFM3FjMGd1a09BbUczYWhrS1d3bUFaaVZsenBzcmk4MzBlMW0yYmNUcE03?=
 =?utf-8?B?Q1ZIb0hpZjJ3ZVQrdGw0Vm9PcmtUcUlONWJCcytZcDl2L2VqSkFrd1podG1L?=
 =?utf-8?B?MVl5ZGFWL05SNWFKNmM5bGF2WW9Qa2QxcXBaTEVuUG9CZGlsNTc2N3EzMHEw?=
 =?utf-8?B?V1BSYmpqNmF4QTg0alBVUHlpcnZXQzlUK2hGbW5TMEx2NzBvNjdBZkN0bjVE?=
 =?utf-8?B?MXlyM01tNldvdkJsbThSV20wUTR2d051VldNVVBKd3ZFamNWZnZPaUUzTTBM?=
 =?utf-8?B?djl6QkpWSGdkUUJxR3lkdUxWMXJEZjY3bnlYN3UxSEVRQzlzK2NqUStpYnZu?=
 =?utf-8?B?VHg2TkFPRytETTZlbTBlbTlvMlJLcTlmV2JJeW9MTEl4eXZtcnRRMWlUUThP?=
 =?utf-8?B?ZGRwdHROVExWOXNGbzliQ29CQnF5UW83OHdBa2s4OWxPdjJRL0xlYzVvRUg3?=
 =?utf-8?B?YXVmMVplbnI5c0VJWHJYK3JYUk5lQmY4RXU2cytYRFcrSDdpdUtPS0RRd2t5?=
 =?utf-8?B?N0xOUGhWUFQvTWtCeGtzRHRIWVViTktLUS9Gb25tOGl5OUdjbFdMaUJRenUw?=
 =?utf-8?B?TjZzQTlwVWZZY0dJaWlxNWU5U1hDU1Z3WXFETFJOZDRNa0dSbnVxMktRcE1Z?=
 =?utf-8?B?VDhvTmZmQjZTVUNJaDNzVkhuOWY1dXZqQllUNzVNY3lXQTRtanJodnZvak5k?=
 =?utf-8?B?VXNDNmduQ0I0Qi9UNWVWdUFMYVRwOEhha3k0NXQzbXBNZWQwWlVBK25mWm42?=
 =?utf-8?B?YjM5aEJPSkl0SWE0ZU1qMGc0RklsUGF0WFJ2NTU2dERwTWg0NUFRbTExN1FC?=
 =?utf-8?B?YTF6c2FIbzFtY01oTXJiMGVhVzNBU1E4TUVNaEYrQ1VxVTlBUlZnUGlVQms2?=
 =?utf-8?B?enBmYmFnUFNaN29VWE5FT3NDM0g2L1NwMHhIQkFVRGx5dDhPYUdrWnRGZkRN?=
 =?utf-8?B?Q09vUXhUbTVrRVZUcXhqZmlJajdndTNmTGQrdkNHWnFxRElET1NteHFTODlw?=
 =?utf-8?B?bGxOeld5ZkdFUkhkTEJtckkzc1NtNWc2bTRGS3VCYmpPWUY5VXlHMGtTUlFh?=
 =?utf-8?B?cmYzTFNTdEhrWW94NnE3R0xxcEdzOHQ5UmRneG90a1gvcFoxR2E4UmxZVml0?=
 =?utf-8?B?NzRQc3FLR2NyNTdvdlV4NS9YelJWbXV2MVdaS3ZQNGJYRjNGeTM4T2JDWllI?=
 =?utf-8?B?cktVSEtyMytjMFFYWTFwdHFyRExsZnZ5MUk3OVNuQlRpQUZNZEp0SlhKd3VU?=
 =?utf-8?B?UDIzcVZFL1FQWjJmSzd5aVk3QkNDdm1haXN2L0V1V0xyaW5FVi9UMVNLNm9Z?=
 =?utf-8?B?aWRqOXVOU05wcjdNOGdtczd3dHhQc09xMEt6UU5lOWc3dmVOM25vVFpURHA2?=
 =?utf-8?B?TDhvVStjL2NUT0hmZVFVWEkwcjJod2JtQnZ3RFJZbUwzTUxUZmtCVHZmY0JY?=
 =?utf-8?B?OUNGdW0ydVpkaUdLR0RrOS9KN3MxaGZoMHZqbDFZclB1OXZDajRDNU81RmlF?=
 =?utf-8?B?RE03Sk9CL2NxZWtuZ3ZzS2lmRnZUVDJUUE1ScDh2cnRTalhHSCs1K3hNM0lC?=
 =?utf-8?B?YkpwY3ZxWkF1T0lTVjNTdmlZeEJ4MXczVmtFbVlMa2U2ejBTdWQyYWFQem01?=
 =?utf-8?B?WWxlTk1zM3lrSGR4M2E5dUNRb0VuZFBieE1Wa2thRXo0Z29lOTFTNFlGMW5k?=
 =?utf-8?B?WmhZcU5VMXB0RVBMQmZocnhPWEJ3ZElmSThVSTJSUWVNVDQ5RUV1cUlyNUhk?=
 =?utf-8?B?S3ByTHFDVFBOTk9VQTRJV3pNWVR2WFEwQzBQZTZsQU9Sbzl2NWJ1U1NmU1k2?=
 =?utf-8?B?NWVTa05NQUcrdGxmc3FEUXQ2MDZkaDFFYVpLVDJOZEx5VWs1ckdJWEM0TmxE?=
 =?utf-8?Q?Mz6MOkxHkDD2iQownAc7HrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3351ce67-34f1-4d1a-811c-08d9b3bc80b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 04:47:24.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5ZXIdyw+wZAZ+9Bci0i+sazNB8qYKEO0Afyw85KsVbJp5zaW4Ppp+ImSfyTNC8DUJ6cJF3mwkCgmbVn3Bg9Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300027
X-Proofpoint-GUID: JiRSip_pdaqQ07-MzkFlROYYUWNM-r1i
X-Proofpoint-ORIG-GUID: JiRSip_pdaqQ07-MzkFlROYYUWNM-r1i
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE5vdiAyOSwgMjAyMSwgYXQgMTE6MDggUE0sIFRyb25kIE15a2xlYnVzdCA8dHJvbmRt
eUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCAyMDIxLTExLTMwIGF0
IDAxOjQyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+Pj4gT24gTm92IDI5
LCAyMDIxLCBhdCA3OjExIFBNLCBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+IHdyb3RlOg0K
Pj4+IA0KPj4+IO+7vw0KPj4+PiBPbiAxMS8yOS8yMSAxOjEwIFBNLCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+Pj4+IA0KPj4+Pj4+IE9uIE5vdiAyOSwgMjAyMSwgYXQgMjozNiBQTSwgRGFpIE5n
byA8ZGFpLm5nb0BvcmFjbGUuY29tPg0KPj4+Pj4+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiANCj4+
Pj4+IE9uIDExLzI5LzIxIDExOjAzIEFNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+Pj4g
SGVsbG8gRGFpIQ0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+PiBPbiBOb3YgMjksIDIwMjEsIGF0
IDE6MzIgUE0sIERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4+Pj4+Pj4gd3JvdGU6DQo+
Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gMTEvMjkvMjEgOTozMCBBTSwgSi4gQnJ1Y2Ug
RmllbGRzIHdyb3RlOg0KPj4+Pj4+Pj4gT24gTW9uLCBOb3YgMjksIDIwMjEgYXQgMDk6MTM6MTZB
TSAtMDgwMCwNCj4+Pj4+Pj4+IGRhaS5uZ29Ab3JhY2xlLmNvbSB3cm90ZToNCj4+Pj4+Pj4+PiBI
aSBCcnVjZSwNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiAxMS8yMS8yMSA3OjA0IFBNLCBkYWku
bmdvQG9yYWNsZS5jb20gd3JvdGU6DQo+Pj4+Pj4+Pj4+IE9uIDExLzE3LzIxIDQ6MzQgUE0sIEou
IEJydWNlIEZpZWxkcyB3cm90ZToNCj4+Pj4+Pj4+Pj4+IE9uIFdlZCwgTm92IDE3LCAyMDIxIGF0
IDAxOjQ2OjAyUE0gLTA4MDAsDQo+Pj4+Pj4+Pj4+PiBkYWkubmdvQG9yYWNsZS5jb20gd3JvdGU6
DQo+Pj4+Pj4+Pj4+Pj4gT24gMTEvMTcvMjEgOTo1OSBBTSwgZGFpLm5nb0BvcmFjbGUuY29tIHdy
b3RlOg0KPj4+Pj4+Pj4+Pj4+PiBPbiAxMS8xNy8yMSA2OjE0IEFNLCBKLiBCcnVjZSBGaWVsZHMg
d3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4+PiBPbiBUdWUsIE5vdiAxNiwgMjAyMSBhdCAwMzowNjozMlBN
IC0wODAwLA0KPj4+Pj4+Pj4+Pj4+Pj4gZGFpLm5nb0BvcmFjbGUuY29tIHdyb3RlOg0KPj4+Pj4+
Pj4+Pj4+Pj4+IEp1c3QgYSByZW1pbmRlciB0aGF0IHRoaXMgcGF0Y2ggaXMgc3RpbGwNCj4+Pj4+
Pj4+Pj4+Pj4+PiB3YWl0aW5nIGZvciB5b3VyIHJldmlldy4NCj4+Pj4+Pj4+Pj4+Pj4+IFllYWgs
IEkgd2FzIHByb2NyYXN0aW5hdGluZyBhbmQgaG9waW5nIHlvJ3VkDQo+Pj4+Pj4+Pj4+Pj4+PiBm
aWd1cmUgb3V0IHRoZSBweW5mcw0KPj4+Pj4+Pj4+Pj4+Pj4gZmFpbHVyZSBmb3IgbWUuLi4uDQo+
Pj4+Pj4+Pj4+Pj4+IExhc3QgdGltZSBJIHJhbiA0LjAgT1BFTjE4IHRlc3QgYnkgaXRzZWxmIGFu
ZA0KPj4+Pj4+Pj4+Pj4+PiBpdCBwYXNzZWQuIEkgd2lsbCBydW4NCj4+Pj4+Pj4+Pj4+Pj4gYWxs
IE9QRU4gdGVzdHMgdG9nZXRoZXIgd2l0aCA1LjE1LXJjNyB0byBzZWUgaWYNCj4+Pj4+Pj4+Pj4+
Pj4gdGhlIHByb2JsZW0geW91J3ZlDQo+Pj4+Pj4+Pj4+Pj4+IHNlZW4gc3RpbGwgdGhlcmUuDQo+
Pj4+Pj4+Pj4+Pj4gSSByYW4gYWxsIHRlc3RzIGluIG5mc3Y0LjEgYW5kIG5mc3Y0LjAgd2l0aA0K
Pj4+Pj4+Pj4+Pj4+IGNvdXJ0ZW91cyBhbmQgbm9uLWNvdXJ0ZW91cw0KPj4+Pj4+Pj4+Pj4+IDUu
MTUtcmM3IHNlcnZlci4NCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBOZnM0LjEgcmVzdWx0
cyBhcmUgdGhlIHNhbWUgZm9yIGJvdGggY291cnRlb3VzDQo+Pj4+Pj4+Pj4+Pj4gYW5kDQo+Pj4+
Pj4+Pj4+Pj4gbm9uLWNvdXJ0ZW91cyBzZXJ2ZXI6DQo+Pj4+Pj4+Pj4+Pj4+IE9mIHRob3NlOiAw
IFNraXBwZWQsIDAgRmFpbGVkLCAwIFdhcm5lZCwgMTY5DQo+Pj4+Pj4+Pj4+Pj4+IFBhc3NlZA0K
Pj4+Pj4+Pj4+Pj4+IFJlc3VsdHMgb2YgbmZzNC4wIHdpdGggbm9uLWNvdXJ0ZW91cyBzZXJ2ZXI6
DQo+Pj4+Pj4+Pj4+Pj4+IE9mIHRob3NlOiA4IFNraXBwZWQsIDEgRmFpbGVkLCAwIFdhcm5lZCwg
NTc3DQo+Pj4+Pj4+Pj4+Pj4+IFBhc3NlZA0KPj4+Pj4+Pj4+Pj4+IHRlc3QgZmFpbGVkOiBMT0NL
MjQNCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBSZXN1bHRzIG9mIG5mczQuMCB3aXRoIGNv
dXJ0ZW91cyBzZXJ2ZXI6DQo+Pj4+Pj4+Pj4+Pj4+IE9mIHRob3NlOiA4IFNraXBwZWQsIDMgRmFp
bGVkLCAwIFdhcm5lZCwgNTc1DQo+Pj4+Pj4+Pj4+Pj4+IFBhc3NlZA0KPj4+Pj4+Pj4+Pj4+IHRl
c3RzIGZhaWxlZDogTE9DSzI0LCBPUEVOMTgsIE9QRU4zMA0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4+Pj4+IE9QRU4xOCBhbmQgT1BFTjMwIHRlc3QgcGFzcyBpZiBlYWNoIGlzIHJ1biBieQ0KPj4+
Pj4+Pj4+Pj4+IGl0c2VsZi4NCj4+Pj4+Pj4+Pj4+IENvdWxkIHdlbGwgYmUgYSBidWcgaW4gdGhl
IHRlc3RzLCBJIGRvbid0IGtub3cuDQo+Pj4+Pj4+Pj4+IFRoZSByZWFzb24gT1BFTjE4IGZhaWxl
ZCB3YXMgYmVjYXVzZSB0aGUgdGVzdCB0aW1lZA0KPj4+Pj4+Pj4+PiBvdXQgd2FpdGluZyBmb3IN
Cj4+Pj4+Pj4+Pj4gdGhlIHJlcGx5IG9mIGFuIE9QRU4gY2FsbC4gVGhlIFJQQyBjb25uZWN0aW9u
IHVzZWQNCj4+Pj4+Pj4+Pj4gZm9yIHRoZSB0ZXN0IHdhcw0KPj4+Pj4+Pj4+PiBjb25maWd1cmVk
IHdpdGggMTUgc2VjcyB0aW1lb3V0LiBOb3RlIHRoYXQgT1BFTjE4DQo+Pj4+Pj4+Pj4+IG9ubHkg
ZmFpbHMgd2hlbg0KPj4+Pj4+Pj4+PiB0aGUgdGVzdHMgd2VyZSBydW4gd2l0aCAnYWxsJyBvcHRp
b24sIHRoaXMgdGVzdA0KPj4+Pj4+Pj4+PiBwYXNzZXMgaWYgaXQncyBydW4NCj4+Pj4+Pj4+Pj4g
YnkgaXRzZWxmLg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gV2l0aCBjb3VydGVvdXMgc2VydmVy
LCBieSB0aGUgdGltZSBPUEVOMTggcnVucywgdGhlcmUNCj4+Pj4+Pj4+Pj4gYXJlIGFib3V0IDEw
MjYNCj4+Pj4+Pj4+Pj4gY291cnRlc3kgNC4wIGNsaWVudHMgb24gdGhlIHNlcnZlciBhbmQgYWxs
IG9mIHRoZXNlDQo+Pj4+Pj4+Pj4+IGNsaWVudHMgaGF2ZSBvcGVuZWQNCj4+Pj4+Pj4+Pj4gdGhl
IHNhbWUgZmlsZSBYIHdpdGggV1JJVEUgYWNjZXNzLiBUaGVzZSBjbGllbnRzIHdlcmUNCj4+Pj4+
Pj4+Pj4gY3JlYXRlZCBieSB0aGUNCj4+Pj4+Pj4+Pj4gcHJldmlvdXMgdGVzdHMuIEFmdGVyIGVh
Y2ggdGVzdCBjb21wbGV0ZWQsIHNpbmNlIDQuMA0KPj4+Pj4+Pj4+PiBkb2VzIG5vdCBoYXZlDQo+
Pj4+Pj4+Pj4+IHNlc3Npb24sIHRoZSBjbGllbnQgc3RhdGVzIGFyZSBub3QgY2xlYW5lZCB1cA0K
Pj4+Pj4+Pj4+PiBpbW1lZGlhdGVseSBvbiB0aGUNCj4+Pj4+Pj4+Pj4gc2VydmVyIGFuZCBhcmUg
YWxsb3dlZCB0byBiZWNvbWUgY291cnRlc3kgY2xpZW50cy4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+IFdoZW4gT1BFTjE4IHJ1bnMgKGFib3V0IDIwIG1pbnV0ZXMgYWZ0ZXIgdGhlIDFzdCB0ZXN0
DQo+Pj4+Pj4+Pj4+IHN0YXJ0ZWQpLCBpdA0KPj4+Pj4+Pj4+PiBzZW5kcyBPUEVOIG9mIGZpbGUg
WCB3aXRoIE9QRU40X1NIQVJFX0RFTllfV1JJVEUNCj4+Pj4+Pj4+Pj4gd2hpY2ggY2F1c2VzIHRo
ZQ0KPj4+Pj4+Pj4+PiBzZXJ2ZXIgdG8gY2hlY2sgZm9yIGNvbmZsaWN0cyB3aXRoIGNvdXJ0ZXN5
IGNsaWVudHMuDQo+Pj4+Pj4+Pj4+IFRoZSBsb29wIHRoYXQNCj4+Pj4+Pj4+Pj4gY2hlY2tzIDEw
MjYgY291cnRlc3kgY2xpZW50cyBmb3Igc2hhcmUvYWNjZXNzDQo+Pj4+Pj4+Pj4+IGNvbmZsaWN0
IHRvb2sgbGVzcw0KPj4+Pj4+Pj4+PiB0aGFuIDEgc2VjLiBCdXQgaXQgdG9vayBhYm91dCA1NSBz
ZWNzLCBvbiBteSBWTSwgZm9yDQo+Pj4+Pj4+Pj4+IHRoZSBzZXJ2ZXINCj4+Pj4+Pj4+Pj4gdG8g
ZXhwaXJlIGFsbCAxMDI2IGNvdXJ0ZXN5IGNsaWVudHMuDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
PiBJIG1vZGlmaWVkIHB5bmZzIHRvIGNvbmZpZ3VyZSB0aGUgNC4wIFJQQyBjb25uZWN0aW9uDQo+
Pj4+Pj4+Pj4+IHdpdGggNjAgc2Vjb25kcw0KPj4+Pj4+Pj4+PiB0aW1lb3V0IGFuZCBPUEVOMTgg
bm93IGNvbnNpc3RlbnRseSBwYXNzZWQuIFRoZSA0LjANCj4+Pj4+Pj4+Pj4gdGVzdCByZXN1bHRz
IGFyZQ0KPj4+Pj4+Pj4+PiBub3cgdGhlIHNhbWUgZm9yIGNvdXJ0ZW91cyBhbmQgbm9uLWNvdXJ0
ZW91cyBzZXJ2ZXI6DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiA4IFNraXBwZWQsIDEgRmFpbGVk
LCAwIFdhcm5lZCwgNTc3IFBhc3NlZA0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gTm90ZSB0aGF0
IDQuMSB0ZXN0cyBkbyBub3Qgc3VmZmVyIHRoaXMgdGltZW91dA0KPj4+Pj4+Pj4+PiBwcm9ibGVt
IGJlY2F1c2UgdGhlDQo+Pj4+Pj4+Pj4+IDQuMSBjbGllbnRzIGFuZCBzZXNzaW9ucyBhcmUgZGVz
dHJveWVkIGFmdGVyIGVhY2gNCj4+Pj4+Pj4+Pj4gdGVzdCBjb21wbGV0ZXMuDQo+Pj4+Pj4+Pj4g
RG8geW91IHdhbnQgbWUgdG8gc2VuZCB0aGUgcGF0Y2ggdG8gaW5jcmVhc2UgdGhlDQo+Pj4+Pj4+
Pj4gdGltZW91dCBmb3IgcHluZnM/DQo+Pj4+Pj4+Pj4gb3IgaXMgdGhlcmUgYW55IG90aGVyIHRo
aW5ncyB5b3UgdGhpbmsgd2Ugc2hvdWxkIGRvPw0KPj4+Pj4+Pj4gSSBkb24ndCBrbm93Lg0KPj4+
Pj4+Pj4gDQo+Pj4+Pj4+PiA1NSBzZWNvbmRzIHRvIGNsZWFuIHVwIDEwMjYgY2xpZW50cyBpcyBh
Ym91dCA1MG1zIHBlcg0KPj4+Pj4+Pj4gY2xpZW50LCB3aGljaCBpcw0KPj4+Pj4+Pj4gcHJldHR5
IHNsb3cuICBJIHdvbmRlciB3aHkuICBJIGd1ZXNzIGl0J3MgcHJvYmFibHkNCj4+Pj4+Pj4+IHVw
ZGF0aW5nIHRoZSBzdGFibGUNCj4+Pj4+Pj4+IHN0b3JhZ2UgaW5mb3JtYXRpb24uICBJcyAvdmFy
L2xpYi9uZnMvIG9uIHlvdXIgc2VydmVyDQo+Pj4+Pj4+PiBiYWNrZWQgYnkgYSBoYXJkDQo+Pj4+
Pj4+PiBkcml2ZSBvciBhbiBTU0Qgb3Igc29tZXRoaW5nIGVsc2U/DQo+Pj4+Pj4+IE15IHNlcnZl
ciBpcyBhIHZpcnR1YWxib3ggVk0gdGhhdCBoYXMgMSBDUFUsIDRHQiBSQU0gYW5kDQo+Pj4+Pj4+
IDY0R0Igb2YgaGFyZA0KPj4+Pj4+PiBkaXNrLiBJIHRoaW5rIGEgcHJvZHVjdGlvbiBzeXN0ZW0g
dGhhdCBzdXBwb3J0cyB0aGlzIG1hbnkNCj4+Pj4+Pj4gY2xpZW50cyBzaG91bGQNCj4+Pj4+Pj4g
aGF2ZSBmYXN0ZXIgQ1BVcywgZmFzdGVyIHN0b3JhZ2UuDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSSB3
b25kZXIgaWYgdGhhdCdzIGFuIGFyZ3VtZW50IGZvciBsaW1pdGluZyB0aGUgbnVtYmVyIG9mDQo+
Pj4+Pj4+PiBjb3VydGVzeQ0KPj4+Pj4+Pj4gY2xpZW50cy4NCj4+Pj4+Pj4gSSB0aGluayB3ZSBt
aWdodCB3YW50IHRvIHRyZWF0IDQuMCBjbGllbnRzIGEgYml0IGRpZmZlcmVudA0KPj4+Pj4+PiBm
cm9tIDQuMQ0KPj4+Pj4+PiBjbGllbnRzLiBXaXRoIDQuMCwgZXZlcnkgY2xpZW50IHdpbGwgYmVj
b21lIGEgY291cnRlc3kNCj4+Pj4+Pj4gY2xpZW50IGFmdGVyDQo+Pj4+Pj4+IHRoZSBjbGllbnQg
aXMgZG9uZSB3aXRoIHRoZSBleHBvcnQgYW5kIHVubW91bnRzIGl0Lg0KPj4+Pj4+IEl0IHNob3Vs
ZCBiZSBzYWZlIGZvciBhIHNlcnZlciB0byBwdXJnZSBhIGNsaWVudCdzIGxlYXNlDQo+Pj4+Pj4g
aW1tZWRpYXRlbHkNCj4+Pj4+PiBpZiB0aGVyZSBpcyBubyBvcGVuIG9yIGxvY2sgc3RhdGUgYXNz
b2NpYXRlZCB3aXRoIGl0Lg0KPj4+Pj4gSW4gdGhpcyBjYXNlLCBlYWNoIGNsaWVudCBoYXMgb3Bl
bmVkIGZpbGVzIHNvIHRoZXJlIGFyZSBvcGVuDQo+Pj4+PiBzdGF0ZXMNCj4+Pj4+IGFzc29jaWF0
ZWQgd2l0aCB0aGVtLg0KPj4+Pj4gDQo+Pj4+Pj4gV2hlbiBhbiBORlN2NC4wIGNsaWVudCB1bm1v
dW50cywgYWxsIGZpbGVzIHNob3VsZCBiZSBjbG9zZWQNCj4+Pj4+PiBhdCB0aGF0DQo+Pj4+Pj4g
cG9pbnQsDQo+Pj4+PiBJJ20gbm90IHN1cmUgcHluZnMgZG9lcyBwcm9wZXIgY2xlYW4gdXAgYWZ0
ZXIgZWFjaCBzdWJ0ZXN0LCBJDQo+Pj4+PiB3aWxsDQo+Pj4+PiBjaGVjay4gVGhlcmUgbXVzdCBi
ZSBzdGF0ZSBhc3NvY2lhdGVkIHdpdGggdGhlIGNsaWVudCBpbiBvcmRlcg0KPj4+Pj4gZm9yDQo+
Pj4+PiBpdCB0byBiZWNvbWUgY291cnRlc3kgY2xpZW50Lg0KPj4+PiBNYWtlcyBzZW5zZS4gVGhl
biBhIHN5bnRoZXRpYyBjbGllbnQgbGlrZSBweW5mcyBjYW4gRG9TIGENCj4+Pj4gY291cnRlb3Vz
DQo+Pj4+IHNlcnZlci4NCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4+IHNvIHRoZSBzZXJ2ZXIgY2FuIHdh
aXQgZm9yIHRoZSBsZWFzZSB0byBleHBpcmUgYW5kIHB1cmdlIGl0DQo+Pj4+Pj4gbm9ybWFsbHku
IE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQo+Pj4+PiBXaGVuIDQuMCBjbGllbnQgbGVhc2Ug
ZXhwaXJlcyBhbmQgdGhlcmUgYXJlIHN0aWxsIHN0YXRlcw0KPj4+Pj4gYXNzb2NpYXRlZA0KPj4+
Pj4gd2l0aCB0aGUgY2xpZW50IHRoZW4gdGhlIHNlcnZlciBhbGxvd3MgdGhpcyBjbGllbnQgdG8g
YmVjb21lDQo+Pj4+PiBjb3VydGVzeQ0KPj4+Pj4gY2xpZW50Lg0KPj4+PiBJIHRoaW5rIHRoZSBz
YW1lIHRoaW5nIGhhcHBlbnMgaWYgYW4gTkZTdjQuMSBjbGllbnQgbmVnbGVjdHMgdG8NCj4+Pj4g
c2VuZA0KPj4+PiBERVNUUk9ZX1NFU1NJT04gLyBERVNUUk9ZX0NMSUVOVElELiBFaXRoZXIgc3Vj
aCBhIGNsaWVudCBpcw0KPj4+PiBicm9rZW4NCj4+Pj4gb3IgbWFsaWNpb3VzLCBidXQgdGhlIHNl
cnZlciBmYWNlcyB0aGUgc2FtZSBpc3N1ZSBvZiBwcm90ZWN0aW5nDQo+Pj4+IGl0c2VsZiBmcm9t
IGEgRG9TIGF0dGFjay4NCj4+Pj4gDQo+Pj4+IElNTyB5b3Ugc2hvdWxkIGNvbnNpZGVyIGxpbWl0
aW5nIHRoZSBudW1iZXIgb2YgY291cnRlb3VzIGNsaWVudHMNCj4+Pj4gdGhlIHNlcnZlciBjYW4g
aG9sZCBvbnRvLiBMZXQncyBzYXkgdGhhdCBudW1iZXIgaXMgMTAwMC4gV2hlbiB0aGUNCj4+Pj4g
c2VydmVyIHdhbnRzIHRvIHR1cm4gYSAxMDAxc3QgY2xpZW50IGludG8gYSBjb3VydGVvdXMgY2xp
ZW50LCBpdA0KPj4+PiBjYW4gc2ltcGx5IGV4cGlyZSBhbmQgcHVyZ2UgdGhlIG9sZGVzdCBjb3Vy
dGVvdXMgY2xpZW50IG9uIGl0cw0KPj4+PiBsaXN0LiBPdGhlcndpc2UsIG92ZXIgdGltZSwgdGhl
IDI0LWhvdXIgZXhwaXJ5IHdpbGwgcmVkdWNlIHRoZQ0KPj4+PiBzZXQgb2YgY291cnRlb3VzIGNs
aWVudHMgYmFjayB0byB6ZXJvLg0KPj4+PiANCj4+Pj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+Pj4g
DQo+Pj4gTGltaXRpbmcgdGhlIG51bWJlciBvZiBjb3VydGVvdXMgY2xpZW50cyB0byBoYW5kbGUg
dGhlIGNhc2VzIG9mDQo+Pj4gYnJva2VuL21hbGljaW91cyA0LjEgY2xpZW50cyBzZWVtcyByZWFz
b25hYmxlIGFzIHRoZSBsYXN0IHJlc29ydC4NCj4+PiANCj4+PiBJIHRoaW5rIGlmIGEgbWFsaWNp
b3VzIDQuMSBjbGllbnRzIGNvdWxkIG1vdW50IHRoZSBzZXJ2ZXIncyBleHBvcnQsDQo+Pj4gb3Bl
bnMgYSBmaWxlICh0byBjcmVhdGUgc3RhdGUpIGFuZCByZXBlYXRzIHRoZSBzYW1lIHdpdGggYQ0K
Pj4+IGRpZmZlcmVudA0KPj4+IGNsaWVudCBpZCB0aGVuIGl0IHNlZW1zIGxpa2Ugc29tZSBiYXNp
YyBzZWN1cml0eSB3YXMgYWxyZWFkeQ0KPj4+IGJyb2tlbjsNCj4+PiBhbGxvd2luZyB1bmF1dGhv
cml6ZWQgY2xpZW50cyB0byBtb3VudCBzZXJ2ZXIncyBleHBvcnRzLg0KPj4gDQo+PiBZb3UgY2Fu
IGRvIHRoaXMgdG9kYXkgd2l0aCBBVVRIX1NZUy4gSSBjb25zaWRlciBpdCBhIGdlbnVpbmUgYXR0
YWNrDQo+PiBzdXJmYWNlLg0KPj4gDQo+PiANCj4+PiBJIHRoaW5rIGlmIHdlIGhhdmUgdG8gZW5m
b3JjZSBhIGxpbWl0LCB0aGVuIGl0J3Mgb25seSBmb3IgaGFuZGxpbmcNCj4+PiBvZiBzZXJpb3Vz
bHkgYnVnZ3kgNC4xIGNsaWVudHMgd2hpY2ggc2hvdWxkIG5vdCBiZSB0aGUgbm9ybS4gVGhlDQo+
Pj4gaXNzdWUgd2l0aCB0aGlzIGlzIGhvdyB0byBwaWNrIGFuIG9wdGltYWwgbnVtYmVyIHRoYXQg
aXMgc3VpdGFibGUNCj4+PiBmb3IgdGhlIHJ1bm5pbmcgc2VydmVyIHdoaWNoIGNhbiBiZSBhIHZl
cnkgc2xvdyBvciBhIHZlcnkgZmFzdA0KPj4+IHNlcnZlci4NCj4+PiANCj4+PiBOb3RlIHRoYXQg
ZXZlbiBpZiB3ZSBpbXBvc2UgYW4gbGltaXQsIHRoYXQgZG9lcyBub3QgY29tcGxldGVseQ0KPj4+
IHNvbHZlDQo+Pj4gdGhlIHByb2JsZW0gd2l0aCBweW5mcyA0LjAgdGVzdCBzaW5jZSBpdHMgUlBD
IHRpbWVvdXQgaXMgY29uZmlndXJlZA0KPj4+IHdpdGggMTUgc2VjcyB3aGljaCBqdXN0IGVub3Vn
aCB0byBleHBpcmUgMjc3IGNsaWVudHMgYmFzZWQgb24gNTNtcw0KPj4+IGZvciBlYWNoIGNsaWVu
dCwgdW5sZXNzIHdlIGxpbWl0IGl0IH4yNzAgY2xpZW50cyB3aGljaCBJIHRoaW5rIGl0J3MNCj4+
PiB0b28gbG93Lg0KPj4+IA0KPj4+IFRoaXMgaXMgd2hhdCBJIHBsYW4gdG8gZG86DQo+Pj4gDQo+
Pj4gMS4gZG8gbm90IHN1cHBvcnQgNC4wIGNvdXJ0ZW91cyBjbGllbnRzLCBmb3Igc3VyZS4NCj4+
IA0KPj4gTm90IHN1cHBvcnRpbmcgNC4wIGlzbuKAmXQgYW4gb3B0aW9uLCBJTUhPLiBJdCBpcyBh
IGZ1bGx5IHN1cHBvcnRlZA0KPj4gcHJvdG9jb2wgYXQgdGhpcyB0aW1lLCBhbmQgdGhlIHNhbWUg
ZXhwb3N1cmUgZXhpc3RzIGZvciA0LjEsIGl04oCZcw0KPj4ganVzdCBhIGxpdHRsZSBoYXJkZXIg
dG8gZXhwbG9pdC4NCj4+IA0KPj4gSWYgeW91IHN1Ym1pdCB0aGUgY291cnRlb3VzIHNlcnZlciBw
YXRjaCB3aXRob3V0IHN1cHBvcnQgZm9yIDQuMCwgSQ0KPj4gdGhpbmsgaXQgbmVlZHMgdG8gaW5j
bHVkZSBhIHBsYW4gZm9yIGhvdyA0LjAgd2lsbCBiZSBhZGRlZCBsYXRlci4NCj4+IA0KPj4+IA0K
PiANCj4gV2h5IGlzIHRoZXJlIGEgcHJvYmxlbSBoZXJlPyBUaGUgcmVxdWlyZW1lbnRzIGFyZSB0
aGUgc2FtZSBmb3IgNC4wIGFuZA0KPiA0LjEgKG9yIDQuMikuIElmIHRoZSBsZWFzZSB1bmRlciB3
aGljaCB0aGUgY291cnRlc3kgbG9jayB3YXMNCj4gZXN0YWJsaXNoZWQgaGFzIGV4cGlyZWQsIHRo
ZW4gdGhhdCBjb3VydGVzeSBsb2NrIG11c3QgYmUgcmVsZWFzZWQgaWYNCj4gc29tZSBvdGhlciBj
bGllbnQgcmVxdWVzdHMgYSBsb2NrIHRoYXQgY29uZmxpY3RzIHdpdGggdGhlIGNhY2hlZCBsb2Nr
DQo+ICh1bmxlc3MgdGhlIGNsaWVudCBicmVha3MgdGhlIGNvdXJ0ZXN5IGZyYW1ld29yayBieSBy
ZW5ld2luZyB0aGF0DQo+IG9yaWdpbmFsIGxlYXNlIGJlZm9yZSB0aGUgY29uZmxpY3Qgb2NjdXJz
KS4gT3RoZXJ3aXNlLCBpdCBpcyBjb21wbGV0ZWx5DQo+IHVwIHRvIHRoZSBzZXJ2ZXIgd2hlbiBp
dCBkZWNpZGVzIHRvIGFjdHVhbGx5IHJlbGVhc2UgdGhlIGxvY2suDQo+IA0KPiBGb3IgTkZTdjQu
MSBhbmQgTkZTdjQuMiwgd2UgaGF2ZSBERVNUUk9ZX0NMSUVOVElELCB3aGljaCB0ZWxscyB0aGUN
Cj4gc2VydmVyIHdoZW4gdGhlIGNsaWVudCBpcyBhY3R1YWxseSBkb25lIHdpdGggdGhlIGxlYXNl
LCBtYWtpbmcgaXQgZWFzeQ0KPiB0byBkZXRlcm1pbmUgd2hlbiBpdCBpcyBzYWZlIHRvIHJlbGVh
c2UgYWxsIHRoZSBjb3VydGVzeSBsb2Nrcy4gSG93ZXZlcg0KPiBpZiB0aGUgY2xpZW50IGRvZXMg
bm90IHNlbmQgREVTVFJPWV9DTElFTlRJRCwgdGhlbiB3ZSdyZSBpbiB0aGUgc2FtZQ0KPiBzaXR1
YXRpb24gd2l0aCA0LnggKHg+MCkgYXMgd2Ugd291bGQgYmUgd2l0aCBib2cgc3RhbmRhcmQgTkZT
djQuMC4gVGhlDQo+IGxlYXNlIGhhcyBleHBpcmVkLCBhbmQgc28gdGhlIGNvdXJ0ZXN5IGxvY2tz
IGFyZSBsaWFibGUgdG8gYmVpbmcNCj4gZHJvcHBlZC4NCg0KSSBhZ3JlZSB0aGUgc2l0dWF0aW9u
IGlzIHRoZSBzYW1lIGZvciBhbGwgbWlub3IgdmVyc2lvbnMuDQoNCg0KPiBBdCBIYW1tZXJzcGFj
ZSB3ZSBoYXZlIGltcGxlbWVudGVkIGNvdXJ0ZXN5IGxvY2tzLCBhbmQgb3VyIHN0cmF0ZWd5IGlz
DQo+IHRoYXQgd2hlbiBhIGNvbmZsaWN0IG9jY3Vycywgd2UgZHJvcCB0aGUgZW50aXJlIHNldCBv
ZiBjb3VydGVzeSBsb2Nrcw0KPiBzbyB0aGF0IHdlIGRvbid0IGhhdmUgdG8gZGVhbCB3aXRoIHRo
ZSAic29tZSBsb2NrcyB3ZXJlIHJldm9rZWQiDQo+IHNjZW5hcmlvLiBUaGUgcmVhc29uIGlzIHRo
YXQgd2hlbiB3ZSBvcmlnaW5hbGx5IGltcGxlbWVudGVkIGNvdXJ0ZXN5DQo+IGxvY2tzLCB0aGUg
TGludXggTkZTdjQgY2xpZW50IHN1cHBvcnQgZm9yIGxvY2sgcmV2b2NhdGlvbiB3YXMgYSBsb3QN
Cj4gbGVzcyBzb3BoaXN0aWNhdGVkIHRoYW4gdG9kYXkuIE15IHN1Z2dlc3Rpb24gaXMgdGhhdCB5
b3UgbWlnaHQNCj4gdGhlcmVmb3JlIGNvbnNpZGVyIHN0YXJ0aW5nIGFsb25nIHRoaXMgcGF0aCwg
YW5kIHRoZW4gcmVmaW5pbmcgdGhlDQo+IHN1cHBvcnQgdG8gbWFrZSByZXZvY2F0aW9uIG1vcmUg
bnVhbmNlZCBvbmNlIHlvdSBhcmUgY29uZmlkZW50IHRoYXQgdGhlDQo+IGNvYXJzZXIgc3RyYXRl
Z3kgaXMgd29ya2luZyBhcyBleHBlY3RlZC4NCg0KRGFp4oCZcyBpbXBsZW1lbnRhdGlvbiBkb2Vz
IGFsbCB0aGF0LCBhbmQgdGFrZXMgdGhlIGNvYXJzZXIgYXBwcm9hY2ggYXQgdGhlIG1vbWVudC4g
VGhlcmUgYXJlIHBsYW5zIHRvIGV4cGxvcmUgdGhlIG1vcmUgbnVhbmNlZCBiZWhhdmlvciAoYnkg
cmV2b2tpbmcgb25seSB0aGUgY29uZmxpY3RpbmcgbG9jayBpbnN0ZWFkIG9mIGRyb3BwaW5nIHRo
ZSB3aG9sZSBsZWFzZSkgYWZ0ZXIgdGhpcyBpbml0aWFsIHdvcmsgaXMgbWVyZ2VkLg0KDQpUaGUg
aXNzdWUgaXMgdGhlcmUgYXJlIGNlcnRhaW4gcGF0aG9sb2dpY2FsIGNsaWVudCBiZWhhdmlvcnMg
KHdoZXRoZXIgbWFsaWNpb3VzIG9yIGFjY2lkZW50YWwpIHRoYXQgY2FuIHJ1biB0aGUgc2VydmVy
IG91dCBvZiByZXNvdXJjZXMsIHNpbmNlIGl0IGlzIGhvbGRpbmcgb250byBsZWFzZSBzdGF0ZSBm
b3IgYSBtdWNoIGxvbmdlciB0aW1lLiBXZSBhcmUgc2ltcGx5IHRyeWluZyB0byBkZXNpZ24gYSBs
ZWFzZSBnYXJiYWdlIGNvbGxlY3Rpb24gc2NoZW1lIHRvIG1lZXQgdGhhdCBjaGFsbGVuZ2UuDQoN
CkkgdGhpbmsgbGltaXRpbmcgdGhlIG51bWJlciBvZiBjb3VydGVvdXMgY2xpZW50cyBpcyBhIHNp
bXBsZSB3YXkgdG8gZG8gdGhpcywgYnV0IHdlIGNvdWxkIGFsc28gc2hvcnRlbiB0aGUgY291cnRl
c3kgbGlmZXRpbWUgYXMgbW9yZSBjbGllbnRzIGVudGVyIHRoYXQgc3RhdGUsIHRvIGVuc3VyZSB0
aGF0IHRoZXkgZG9u4oCZdCBvdmVycnVuIHRoZSBzZXJ2ZXLigJlzIG1lbW9yeS4gQW5vdGhlciBh
cHByb2FjaCBtaWdodCBiZSB0byBhZGQgYSBzaHJpbmtlciB0aGF0IHB1cmdlcyB0aGUgb2xkZXN0
IGNvdXJ0ZW91cyBjbGllbnRzIHdoZW4gdGhlIHNlcnZlciBjb21lcyB1bmRlciBtZW1vcnkgcHJl
c3N1cmUuDQoNCg0K
