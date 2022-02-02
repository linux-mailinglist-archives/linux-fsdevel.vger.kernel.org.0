Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666214A7AEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 23:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbiBBWTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 17:19:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37726 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235181AbiBBWTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:19:00 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwYh1003711;
        Wed, 2 Feb 2022 22:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xRNsClRYcqqqT/W4CQUUGiFiq1yxTAM62zWu8mzosOA=;
 b=NJ/qSq2XxX1GhYbYvSwzVVs7oCobmMdy97TCWQqfb0Drbvq9p2VEh7hdXIGBMpW0qIIY
 pz3mKeBDRsJp8F6srlrOOtRvBHzhLB6pM1suHiTXifTeTT1vsM5Okb3ZPeD567/NTmTN
 nI190CHNlaNvAf7ih+XvttY88HDbmzrPDo291oh0U/oWcS1mWxnmBWDTFrmOzvYah+Xn
 jT9/nOX2eP/5cYec7cW2sXwUfY/xuf1+KP1p1dPgbdNyGmovtOl2xtiGnkwqRQoZlaSH
 BRBzGH4XXyglfGUWcVuFiDwNiDhYvyP3paF/q9KmUpyspm5afVwfCWO/+OGEVuh5ASfK ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vfm65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 22:18:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212MFl6h122368;
        Wed, 2 Feb 2022 22:18:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3dvumj9j5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 22:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9nneXOwsPbsKfthmtbsIvDinvOSf56AA3PhRUZpAn6wShpOcQl++ts88LFFAbJtYzjDUhGHernpY6KLcxNavAoEeu+5IZB0tanfSAcP4eNlkt+twi0JPT5HQmLRlT9zlULYh5J9MX4oaQ+5kHBP4I/t6ytPa5czs7wRcnYSkCecV0+yoHWhHJYWUAEPDu0eUnhbGpNk1kftd6vctcOiVaaoLuocbvYUR+GkR+mw47lQ302J4w++Qiuw4vQHgwXh1JhnR5bBbzd7PaPuECfPtVb9nA54sjuSkTcmSk8xcHargck/JojWMyepK4lItqRkpV6ZH6N81B3+bHuGV87JKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRNsClRYcqqqT/W4CQUUGiFiq1yxTAM62zWu8mzosOA=;
 b=ecEXoSqZ7Fi9T/GFdhJoMMVRdV9XggNfas5+3Ie8db7ECaop8WhmWvGfpc2zGcnv+UoGmVf3A0aXpNaIETkfpOEweymUVReZ4sGjZw4S4r6Qu+RTZ8hrFw73erCgtce2GsWDdum4/TanyX8iEFbfejcQczYX3XbwjAVbVW5qF0B/9ZbHHOyutKayfV0QG76SzmDmYvZCed8Yq9OdJAI/B8BHaj894d7FLCZm0aJMEdV0YKDS48d90tdnqHNqZsqSJmN8uqZkAaHrgyO9+Ay05xZORxaBxCUkuQ3sVg/sy6qEplR/gjkAL9aSAjBYWBQnfB7lnc/edcveQmHfCZ4g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRNsClRYcqqqT/W4CQUUGiFiq1yxTAM62zWu8mzosOA=;
 b=oCGqczzbaodimmtMDyG/oe+7ttaN+Gqn7VavCstfSGtLb9LXWtEOSuVgoES/oGXe6TDzPeU87G2hQv2yGgQD+I/1tYIrfFh+PR4QogxOKR4MG01Wi83WCy41MT8922ufs06ax9BYzlsjZGN181+0Nq71I1mvsUMfgB0y9VUCTtA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB3563.namprd10.prod.outlook.com (2603:10b6:5:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 22:18:39 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 22:18:39 +0000
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
Subject: Re: [PATCH v5 6/7] dax: add recovery_write to dax_iomap_iter in
 failure path
Thread-Topic: [PATCH v5 6/7] dax: add recovery_write to dax_iomap_iter in
 failure path
Thread-Index: AQHYFI6P7d70lHAIX0mg02wePMQ1DayATMGAgACPyoA=
Date:   Wed, 2 Feb 2022 22:18:39 +0000
Message-ID: <48bbf3e1-0eeb-5a77-44c7-20d0cfdb8338@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-7-jane.chu@oracle.com>
 <YfqKoZ79CqvW8eLq@infradead.org>
In-Reply-To: <YfqKoZ79CqvW8eLq@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51e79358-4566-4684-2b71-08d9e699f6f5
x-ms-traffictypediagnostic: DM6PR10MB3563:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3563D6F707DB8FD8D9F3C4D2F3279@DM6PR10MB3563.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZmtmqBeUIz0EbZZTqAew+xgvjSGVyUbDAmqxAdTaE9oRJ41SU4hTCgx/rfYZy16RCPxaZhSFSmgu8hig/8AIi3T4WO9pasw02u9fj/yiBhHQRIiXX9KuWL1wj1uRM1DKHQW8YHss3u5gm9sE3kwr2PXILq7nOipRykEolXAMZM6OH2PzqgBcbJPvQLUJNbr350jeqhhSpj8P8VMfWp+MFn56gEihuZHXR7WhhjZAqP7W3u1ceNN9pe1VbM4WZQOjhVfgWvNSPKI7ZU6yRc54oz3ahfHf75a1pJ8NlGm/GfNMfnG52gg0sxW42OoKfEVL+68JvFzS0LpM1pM0Gfnj5ReDeRPBFvRb0Ksxnsqv0ZtwQ3OjRD/82SZddNOBQGVtLu3N9OPgX0ujY8w7e+s1wQ6r6IsRpg9BrxnRlILoIhL5AvcebxIPDu5vlBJfx7WSLW7qTOlEI9khZhkvcymFzHRcQDtO0F3gW7rxTAPOx5nA0mZ4hqwY9nbksBgpwEhYS7AWPSd9QQuNFEJCnSkKI3j1VPbldcBfS+/1yHdN8UTvnYPSpepvTR0Ju6yqnM+uxWbNeKf94y+N/Jg2WJ+AlGrC1GXwhue+hF4T9tw7kFWcU+lB9uVruud0a/vRw7I33AwVE+SWG5RsjLn8AS0+V/d2Yiy8t7ft3+VxQva6M6tCIbwolmvpJtfjMGsdZwgBP0ZQLnqfc1no3mw88m+/P8YflwWkcfqzgHG4XbAqyPdYVLw5Ki/4tZIk3pidM1ZxN5PZFgjS4997ZRR5oa+Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(7416002)(2906002)(122000001)(38070700005)(38100700002)(31686004)(4326008)(8676002)(8936002)(64756008)(66556008)(86362001)(5660300002)(66476007)(66446008)(6486002)(6916009)(54906003)(186003)(2616005)(76116006)(316002)(91956017)(31696002)(66946007)(508600001)(71200400001)(36756003)(6512007)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk1LSjlPN2pLcU9xSXFYT3YveHFWSW43dnFoQVY1SXp2SE1zTHJNMjUxM2RB?=
 =?utf-8?B?N2p0TlNvL0xycWx6eXFQNHRPdEFxRnErQ2ZxbTFheTMrQ2Z0YVg2cWZUV2Ft?=
 =?utf-8?B?Q0lpNFh6K3FBMS9RcUdlL1FEZExOWTRzYU9LU2t5R0NSa0dNczhJY0E4YURW?=
 =?utf-8?B?MlpqZ0xtSVNtTnRjbEhMQUx0MWVZRThNWXFZV1lhUjVLZWQ1dGhDSWlWRkZ3?=
 =?utf-8?B?aHAvM0k3Y05BN1F6bHdzc3JzSTB0K1o3WWtDdGdrRUR6cjgzUUJHMDN3TjFj?=
 =?utf-8?B?QnAxTXFnS1I0VytCcTNqT0l6S1hucXVYSGtIZlJtTW9rYjQ5R3M0ejJ5Q2Nl?=
 =?utf-8?B?OS9xTjgrRTJxSDMyenVJb0tuUmNXMUlUU2puWHI5VStHeFVnM1EwUmI3d1NW?=
 =?utf-8?B?b0JmS2kxY0xYNmhFdUQ4blBteUl4K0Zib3Q3akhidlV2dE5mRXRiRHZnVVpv?=
 =?utf-8?B?dkRvbWg4bDgxU0trTjJNdWpOL0xoaHRkZ2JlSGFWSDZuSGh4NFhyREU4TW56?=
 =?utf-8?B?S1dhN1IwcG1JT1d5SUdTVWl2aVdDV0lZSUpxQWl3S2lrSUEyVXloVjhFTzNm?=
 =?utf-8?B?N2xmQW12QmtJRjgwbDh6UTA1eDV6MEtPTDRtWDE3UEJwTC9xVmQ2eHNoMk1w?=
 =?utf-8?B?K3o0TDRNZ05BTi9hMnBrZ1FqWE9EQUpMY0F1TEo5U1h4RFkvQm1paE9qOE0y?=
 =?utf-8?B?dHgwTFVORlR0SmNGbkJaN21TNzRuWEhxZmFwU2U4Y0FaZWxSN0xPc1FoRGFr?=
 =?utf-8?B?L0JDcmxuNGxhZUlPQ0U1eGU3ZGpXYktuVVRsWGVIak9FSThSTnJUV3VVbHMw?=
 =?utf-8?B?eGJGdUVpQ2RvWU55NEJiTCtzOXBoTjc0bytuOC9iblhhZ1Vpc3U3dHJ5UWNE?=
 =?utf-8?B?Y3FjSis5cUdrWlpvZzBrS3dkK1ZEWGJTWFJXQmdUN3Y4emVEMXJubm1vRUdW?=
 =?utf-8?B?SEhmZ2FOTWl3VWdJTUVlU29JTUR2K1BMUFJycGtZK2VUd0xrNVVlRm8wazI0?=
 =?utf-8?B?aXh6cTFQTDN2T01UdlNaVk96SWFGbTBsYzBHZmpCaGR0bDZ3aERpcnB2ZWZR?=
 =?utf-8?B?TjVEMmp1QTVEdkxyOUF3MWlEN1ovZGwzTUxqK0d0VWVVeVM5dysvbjNSd3E0?=
 =?utf-8?B?TkJlTkZhdVU5UnBvRkZiamcxTVRTV0paV0orVWVQNkFDaDBCanZXZ2x2Tm9k?=
 =?utf-8?B?YlZSTFBCdEF0WHVhY3VjKzc1ZzExTmFVY1k5S2ViZXkvMGlYR0o2UlJMUUo4?=
 =?utf-8?B?b2lwUkZqb2dqRlNPZXZSWWtHNGxxWDlmQkFzcDZlYmNrK3FMcENManR4YTl5?=
 =?utf-8?B?bHNTMUZ5aG1UM3k0LzU5anNOeTdNa2FlemxMVENmaTM3L2NiNlhJMWdQUm16?=
 =?utf-8?B?bDJxeG5jZlR3V2xPY3RERE5Lbm0waDBmdmlKTktCbWFwOXhIamZiVjVvc1hl?=
 =?utf-8?B?dktuTlNWVmd0dE1hS3FsdHFKZXNPbitHb1RDTUpUODZsK29nVU9SRkN3WWhI?=
 =?utf-8?B?bVhrM3BoVGwvdk9oQ0dmVjJkbDZUdHZmYlFra2Y1aU4xRHBUZTh4enpETzhR?=
 =?utf-8?B?K29WbTRwUXB5bERzbENuZ0NKMkQxU20rSmE2cHhSbnVTaWQrSGRrQ014Q0Zk?=
 =?utf-8?B?NVFUVG9yRzRsZnlTczJ2ZzhnNVpnMGlsd1pCdU1TRHN6RHpJdWZ4WklzL0xm?=
 =?utf-8?B?ZDcrc2EyR2FWRWpBVFN2cm1IZ2gwenVPTTdId1lDMUQxU0NuY2xBYzBOTmla?=
 =?utf-8?B?UGlqUmp3UTZoZU0vTGZvVGtpbGNLQjhXVE85bEY0VzRpbGZRK2ZEYnMycEVz?=
 =?utf-8?B?YmdUUWlyZ3hmS1NKWW9LVGU1aFB0WmxWRlA0QXlUaEQwbmxLVUVXWkp6S3Zq?=
 =?utf-8?B?cXB5TlRyVmdKemorUXBxT2NXeWROWklhb2R1QkMzeVBLRmdOdjVSSXFmU0JC?=
 =?utf-8?B?Njl6OGVZTitTOXJNQ0FQVm12U2gxV2ZteDcxd0ZsWnpma1RtZ0NIcFpvNjNy?=
 =?utf-8?B?UFQ2WFhHQ3ZmWU1LZkZwT1VScHkxWnNpUDJUTmpQZVRwUjEvallGTXZpMDQy?=
 =?utf-8?B?emEvVnRRckprVkZwcFJoVGRHakhNUVdtTy9FYXNhamVONXBiSmpvcVAxWFVz?=
 =?utf-8?B?MXZtWmo4S2FSME9kOWt2QXplVlNoYjQzcFM5SFo5ZzZ5TThYMkJabGdZY20z?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD42EFAB89ABB438D45A91B16B52257@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e79358-4566-4684-2b71-08d9e699f6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 22:18:39.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XI/zNEfuO7RfryxLH4ESSka+DfflQR5wI+VaUsT5ePL7Znk0bDseVsuctJyOWUYehDI4E1f+YkUGhoz2gErb8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3563
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020121
X-Proofpoint-ORIG-GUID: WsDzVRlj9c4eMgSzIHB1PW2kPUdOmiEb
X-Proofpoint-GUID: WsDzVRlj9c4eMgSzIHB1PW2kPUdOmiEb
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgNTo0NCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwg
SmFuIDI4LCAyMDIyIGF0IDAyOjMxOjQ5UE0gLTA3MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gK3R5
cGVkZWYgc2l6ZV90ICgqaXRlcl9mdW5jX3QpKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LCBw
Z29mZl90IHBnb2ZmLA0KPj4gKwkJdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92
X2l0ZXIgKmkpOw0KPj4gICBzdGF0aWMgbG9mZl90IGRheF9pb21hcF9pdGVyKGNvbnN0IHN0cnVj
dCBpb21hcF9pdGVyICppb21pLA0KPj4gICAJCXN0cnVjdCBpb3ZfaXRlciAqaXRlcikNCj4+ICAg
ew0KPj4gQEAgLTEyMTAsNiArMTIxMiw3IEBAIHN0YXRpYyBsb2ZmX3QgZGF4X2lvbWFwX2l0ZXIo
Y29uc3Qgc3RydWN0IGlvbWFwX2l0ZXIgKmlvbWksDQo+PiAgIAlzc2l6ZV90IHJldCA9IDA7DQo+
PiAgIAlzaXplX3QgeGZlcjsNCj4+ICAgCWludCBpZDsNCj4+ICsJaXRlcl9mdW5jX3Qgd3JpdGVf
ZnVuYyA9IGRheF9jb3B5X2Zyb21faXRlcjsNCj4gDQo+IFRoaXMgdXNlIG9mIGEgZnVuY3Rpb24g
cG9pbnRlciBjYXVzZXMgaW5kaXJlY3QgY2FsbCBvdmVyaGVhZC4gIEEgc2ltcGxlDQo+ICJib29s
IGluX3JlY292ZXJ5IiBvciBkb19yZWNvdmVyeSBkb2VzIHRoZSB0cmljayBpbiBhIHdheSB0aGF0
IGlzDQo+IGJvdGggbW9yZSByZWFkYWJsZSBhbmQgZ2VuZXJhdGVzIGZhc3RlciBjb2RlLg0KDQpH
b29kIHBvaW50LCB0aGFua3MhDQoNCj4gDQo+PiArCQlpZiAoKG1hcF9sZW4gPT0gLUVJTykgJiYg
KGlvdl9pdGVyX3J3KGl0ZXIpID09IFdSSVRFKSkgew0KPiANCj4gTm8gbmVlZCBmb3IgdGhlIGJy
YWNlcy4NCg0KRGlkIHlvdSBtZWFuIHRoZSBvdXRlciAiKCApIiA/DQoNCj4gDQo+PiAgIAkJaWYg
KGlvdl9pdGVyX3J3KGl0ZXIpID09IFdSSVRFKQ0KPj4gLQkJCXhmZXIgPSBkYXhfY29weV9mcm9t
X2l0ZXIoZGF4X2RldiwgcGdvZmYsIGthZGRyLA0KPj4gLQkJCQkJbWFwX2xlbiwgaXRlcik7DQo+
PiArCQkJeGZlciA9IHdyaXRlX2Z1bmMoZGF4X2RldiwgcGdvZmYsIGthZGRyLCBtYXBfbGVuLCBp
dGVyKTsNCj4+ICAgCQllbHNlDQo+PiAgIAkJCXhmZXIgPSBkYXhfY29weV90b19pdGVyKGRheF9k
ZXYsIHBnb2ZmLCBrYWRkciwNCj4+ICAgCQkJCQltYXBfbGVuLCBpdGVyKTsNCj4gDQo+IGkuZS4N
Cj4gDQo+IAkJaWYgKGlvdl9pdGVyX3J3KGl0ZXIpID09IFJFQUQpDQo+IAkJCXhmZXIgPSBkYXhf
Y29weV90b19pdGVyKGRheF9kZXYsIHBnb2ZmLCBrYWRkciwNCj4gCQkJCQltYXBfbGVuLCBpdGVy
KTsNCj4gCQllbHNlIGlmICh1bmxpa2VseShkb19yZWNvdmVyeSkpDQo+IAkJCXhmZXIgPSBkYXhf
cmVjb3Zlcnlfd3JpdGUoZGF4X2RldiwgcGdvZmYsIGthZGRyLA0KPiAJCQkJCW1hcF9sZW4sIGl0
ZXIpOw0KPiAJCWVsc2UNCj4gCQkJeGZlciA9IGRheF9jb3B5X2Zyb21faXRlcihkYXhfZGV2LCBw
Z29mZiwga2FkZHIsDQo+IAkJCQkJbWFwX2xlbiwgaXRlcik7DQo+IA0KDQpXaWxsIGRvLg0KDQpU
aGFua3MgYSBsb3QhDQoNCi1qYW5lDQo=
