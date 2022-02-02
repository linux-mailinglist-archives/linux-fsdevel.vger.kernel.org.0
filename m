Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83904A7B7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 00:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348013AbiBBXIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 18:08:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15604 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbiBBXID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:08:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwYAK013006;
        Wed, 2 Feb 2022 23:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uIJhCZkutbXRRW8vkNebYdNc+nPCj1xVkejkuYwXSeQ=;
 b=lqwDiFj1Siyv4copH+qmEPMEKA27r1i9fEeROr6diGPutq+YnnFuId29t2hgXS6/9/1y
 UmM4c4YzO7/vsRew7Eiq80nVvj6h/937ALwGCgQjTRzwg45Ud4SllILzp6FhZrOSN7DM
 Blsiw4TRtyheYpF4dSs4epeTOwAYVIZISXaSpqkCr88Vfg3WhWAPXLMvoP+bk1jX9BcO
 6kpEfBUeD/LRa58HL+vtY1Dd2c8y4hdE01aPeLkdthdbFLmS97B0SgGMW9SwjL8bXLhT
 aRiONww5CccKGLi9dAsCvQuIDbqvgaXTpGQt/jFdhBdQu71/YvNCTWfDJHJIeaEaY+4l cQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fymvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 23:07:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212N0At7141158;
        Wed, 2 Feb 2022 23:07:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 3dvy1tga8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 23:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csXxpxtIXCKXyjVqKeWjezx6cpsVi56j7bwCffjDNF2K05vXn1sgakLEtffup8bFUSDo3dljo65CqLuz5wkh0vYUu655sBVGVEFOAOU252ur5ws5+ZqctMTmj/lCvo1FKmTxH2pA5fzXF/opSAuYHwHphIay1AV9DY2uyJpItNSs0h9ssEN9Y/D7vjV3Mp3itLi+2Q2hzxlTezsS4N90EJH953l5MkgFCusJzN7mBsXGR1CU/7N+HVzmmeAvQy9NhhvJAXIIOZ4sAaMBpsMhFkDkDBtXYWxpykMavS4EbC4yosZOXd19GMix+eMwpfjScfcmkTLM5Nu+MRRPtzy44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIJhCZkutbXRRW8vkNebYdNc+nPCj1xVkejkuYwXSeQ=;
 b=auOiD+zAofPcNe5h0jz8sggff7c88tixcakh1LG39/LzPUgby5Epm2GTtMGpJ8qeKlquoDbMM/btvuahgPV/YbgRbabQeL6SPZfcMCtT+3fV+w+G+EJBD6rdtywHRFwFg7wI4l4X5oknMfgXIk8YDT6lHRXdC1fFL8RgP7p1dMTEawJrqC42cPR7cm5jYKSTXgFEvUez7J2uJZmDDuYc0kC85c1yJxNUrqiPTUA7uuZnw5gtxvZxtjjQF0gGLle0jNlk9LBOsxtDt/JIcAhMUQU7m8nff38LQfmIs+nce6qhP4/XJcjJz8Q6mJ2FuXoYMVX+MexyfyxvXolimrR+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIJhCZkutbXRRW8vkNebYdNc+nPCj1xVkejkuYwXSeQ=;
 b=ttYMjvIOIZVO5oymnogjjDYIVrATNtiJX8N49raAswTlC6OGOTI5/oS+IBq+KWfZUG9FUevH/+syoyxVIvO6n/gRN6JENXBThYDzHu12eX1tXZAzjxx8xPcuXT92QiksrXGKnHGSnxepGqLz782pO13ZJLL3WQJ7f8n2tfl2NZM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN6PR10MB1955.namprd10.prod.outlook.com (2603:10b6:404:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 23:07:37 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 23:07:37 +0000
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
Subject: Re: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYFI6GHFAsB7tXYk+ZNKUkZMvm/qyARncAgACF2oCAAB3ogA==
Date:   Wed, 2 Feb 2022 23:07:37 +0000
Message-ID: <950a3e4e-573c-2d9f-b277-d1283c7256cd@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-2-jane.chu@oracle.com>
 <YfqFWjFcdJSwjRaU@infradead.org>
 <d0fecaaa-8613-92d2-716d-9d462dbd3888@oracle.com>
In-Reply-To: <d0fecaaa-8613-92d2-716d-9d462dbd3888@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3077c3a2-0fae-4104-3f2f-08d9e6a0ce12
x-ms-traffictypediagnostic: BN6PR10MB1955:EE_
x-microsoft-antispam-prvs: <BN6PR10MB195578A10119D29AFE8398C9F3279@BN6PR10MB1955.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKwWoDzpONeWPA0Y4LwL1H9KvjI0fuvci7LfNqXIvqNg5nnh9u3Eb3E1d3iiLEltiQNFUQ1tVGA2MymGLPlr/lHg9oGmQyGpBYWUmP7nq4MU7z8rscAAI0lN1+D9IvVKwslSIErpm7nQSjE/bEZ/G4ECc1u0EOAH36yymiAFXdRyFrFKkPssUSnWbIUGqT7UffDoLvzpsSHXTx5V7ZRx579x+hF6utFShAd0rMaPgpSa/h6U2iLurjIDrzmvr/v8MwJNKE+ZCNyusJbi9fEvpS76T1XoaC4xzbMQ7XqpOk85OBOpPGCX5/MZqkdAAHkfzg055qlRyPqygaPh+YhZi3gGvMu/HVnig3mvyoD7NLB7CkvBqHm7M56IivC8ZFayGDMYMYoM1fSPEDNlNVykVDJAK2gLS4VnI9pZTVnxf9UoUOgcVF2bw5hoP/reaiNoWSkXRdizXYaTDdIreJMYxScCIP2PODVtVQLph4hbehHtfJLdJc1vzrocu6pSl97Za6GzaQveVPf7XAK4xs2Fllz8bTLyS/9xDaygBtNZEexZsuZRHa21y8QsqEZ6/Wu84GdRlNnfopKgWWJqy/I9VxHIhoFjhnQV3/W3yjxMjjEidBiznguJkrjQCfEQGn+gT/7UxS1Hz8zIMnjlG0VirJ7d/CnDEYCuuFBgb9iVFoysss6zFIoDBvZkGUfmsGFbjfCM5gCzFBEzy2+4brFTr1CG5daTeDntkSSk+iIaAjWdpRLivIvyIFrF9RpxqtodWA93lBIR7Nnj0dNjvb/Eww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(54906003)(2616005)(44832011)(31686004)(316002)(31696002)(122000001)(2906002)(508600001)(7416002)(26005)(186003)(6916009)(86362001)(36756003)(6486002)(71200400001)(66476007)(8676002)(66946007)(38100700002)(83380400001)(91956017)(76116006)(4326008)(38070700005)(66556008)(6512007)(64756008)(66446008)(6506007)(53546011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVNPaFFQMk1YbXJIV1RHTHhpbFM5SVhXb2l1VVVPdVF2TXVJcGJzSmhxS1li?=
 =?utf-8?B?MGQ5L2NRc25ZVkw4Y1B2VzBId1hQenZWZ1NrbHlvZ3lmK3NMUkxUK3VsQVNh?=
 =?utf-8?B?QXI4SWRoTlNFWkNyUUs1RWNWUVdVVXZxSDk5OWlWTEdHWGhnK093Rm1JcHkv?=
 =?utf-8?B?Mmh3MUY3bWw5aDhVWENxWmdKSHZMbFNBemZ3cmhUbkwvS0lYTGd3OUJPcWN4?=
 =?utf-8?B?TEFkVzVNb2xadHUvTDIxdTdqRDF0Nno2cldUTFRueFMrVWVueUJhVDVkVFpz?=
 =?utf-8?B?bENBV1hzRytKNHhaZmZnR2ZQMlgyd3Y2Zlhhek4rZ1NpM1hreVVTTjRkdStX?=
 =?utf-8?B?MnNyMWV4dnJwUDFPTzlXZ1MveEVmZ1drNVQrK1lsMHBtcE1jK2xaZGhabTdC?=
 =?utf-8?B?bmwxcnBKUStXcEVxYlRtblRIODQ4bDI5QmlsOHF2NG03eTF5RGpBaDl5RVlk?=
 =?utf-8?B?WjBtTEIwRCs1SjQ4TUFCR3Q5RDZseTY1V01GbS9TbGFwNUs3RStkVDMvTTRk?=
 =?utf-8?B?R3pHYUdRRmpOeVliVGZhWEFiTWJZUDZMbTFkYm1OcHNKUEthZXpHVTZGb2ln?=
 =?utf-8?B?eUZsZUovV0RZT3NjNnpnNVpIZFFlNzdpQnd4VGVIRWhzWU1jNGZtTzd5bDZG?=
 =?utf-8?B?Q3kwKzhMTG1YNWx1Njd4ak5pOS9MWlQrN2czK3JqdkQ4czJhSi9QVnFiV2hq?=
 =?utf-8?B?K2g5TUYxUG9BRnNZYVVpRzJNTno2MjRITWQwczFsYUhrYTFPSE5zWEl3Rng4?=
 =?utf-8?B?a1ZSR0hnMFRYY01jc1VoYjROUXR4czZtbHRWME5iKzdIaHpZRVZ0RnEzN05E?=
 =?utf-8?B?WlFBNUNETmxDNDhJdk9tZVozcG0veVZQdWVVdEZ1VFpIYmlKV3NKQkx6Y2p4?=
 =?utf-8?B?ZjhSQTVPeWdKUXZ0V3hRL1VnSnQvclVCUi9ZQ3o2QXIyM3kxS2hXQ2kvdWUr?=
 =?utf-8?B?VndPbTlpdVBFS1NZWktUdUp3OHJHSlNwdGdvUUM3aDdCMXVEWEVmN2JvSkQw?=
 =?utf-8?B?dGgxYmNkN2RaeVljZmJwaDFQMGVTZkpqR1lQaE5xejJsMnRya3o5dXZPOUxi?=
 =?utf-8?B?RytZRFRybk1RM25La2lHVisyRWVncUFlQ0hhK0k0Q0l2RlR2OTl5RzAwOEtU?=
 =?utf-8?B?UytxcWYrS08wR2lkSzVUQVA4bWZtbFo2S2x2em9vU2xFMGVTdE9EL0xXaWxp?=
 =?utf-8?B?K2dTYXpOVkhkdHhhRE5OcC9zeGVqdG5wSmNhV0Y4WkhDeU1Oc0dhaWpDMDJm?=
 =?utf-8?B?bHE2MGhpd281YzRxZW9HVk0xbU5GdVlYY1IxOVVCbklhNVBqL3cwbUV5KzFh?=
 =?utf-8?B?aVhSUnE5YmJvVmRmQmFPenNubTBvb0JLUmVhVUt6NWtFbTVCSk1qRzlpcFBY?=
 =?utf-8?B?TjlOcHNKVG9WYjk5emdkV0R1RmFJcldENGgvR2w2VDc1TkQ3NVR0SUZYZFRn?=
 =?utf-8?B?YldSU0U3SXNGN2RLRU1XR0RTODAyV3lkRXl5MFVJa3I4aDJYUXNaeTRUOUdx?=
 =?utf-8?B?aEk0ck95cUV3WHBqN1FxOGM2TW9jTWJxa2toOUd4MzJpNElaVkRubHJlNWNr?=
 =?utf-8?B?MUh1VmFqWHU0QnZubTg0ME5UUmZtVFNSeFA2ZHVnRUU5SXNFRHhwTndXazJX?=
 =?utf-8?B?dEVDK0Y3c2JVTnFuOEdjNWN1ak05RGZ4VzZ2RDJ1TTRFVW9mR21JRDN0TXMv?=
 =?utf-8?B?SE41bkFTN3N4VHU2NVNPeDFDUmUzMERwWDNLdzc0bDF6aTdFU0dsVnZvUWZB?=
 =?utf-8?B?dWNYR2NqQkMvbjQrcEw3RVNuZW9HSXhFdkhyZEhsUnBsaVdZdW5aWVZ2VkVs?=
 =?utf-8?B?ZUdCZkx0U3hWcWY3VnV0ZHVhOW9tSHRqdlZJTEhWUW5QYW9TZW5kMXNLR0pz?=
 =?utf-8?B?aFhUU3ZBWm5Rd0t6QVBzVmhrOE1sVTlzZGUrRlZoL0FQSGZpWjg5dVBlWGdQ?=
 =?utf-8?B?MCtIWWFxL2E2cEhxdnFJMUp0aUZPb3JFbHpBS3NLcFJpNnBPdTFjVG9IZEo5?=
 =?utf-8?B?Njl3Z0xkYzBzWENIMHJ1YzJHMmVzWFVQUSs4MlR5K2ZJNWVSR3kyWTM0VnVr?=
 =?utf-8?B?RFVsNG9jTE4xU0hTenF1dW9aa29Pc0lLUUNoQjJEUlRyL1JWYk1iclF2UUkv?=
 =?utf-8?B?aWgzZ2VuMFF3NU1KdTlNMlNMMThHYWxqak5FeE5UamtBUC8vazVSa2VDNlVI?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B22E15EFCFE74341AF8360A8061A986A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3077c3a2-0fae-4104-3f2f-08d9e6a0ce12
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 23:07:37.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pDUB6sBDkSahOaLJiwYmn8Mhhz4NKvc1EFJGfszy6IvM+N9C/icIcQ0W+Ad0qPNcniARXf/WF5Ti1PR+EtJVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020125
X-Proofpoint-GUID: 2J4IppWgnVtEhR6wa961RHjlpxxSZiZ_
X-Proofpoint-ORIG-GUID: 2J4IppWgnVtEhR6wa961RHjlpxxSZiZ_
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgMToyMCBQTSwgSmFuZSBDaHUgd3JvdGU6DQo+IE9uIDIvMi8yMDIyIDU6MjEg
QU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+ICtzdGF0aWMgaW5saW5lIGludCBzZXRf
bWNlX25vc3BlYyh1bnNpZ25lZCBsb25nIHBmbikNCj4+PiAgICB7DQo+Pj4gICAgCXVuc2lnbmVk
IGxvbmcgZGVjb3lfYWRkcjsNCj4+PiAgICAJaW50IHJjOw0KPj4+IEBAIC0xMTcsMTAgKzExMyw3
IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNldF9tY2Vfbm9zcGVjKHVuc2lnbmVkIGxvbmcgcGZuLCBi
b29sIHVubWFwKQ0KPj4+ICAgIAkgKi8NCj4+PiAgICAJZGVjb3lfYWRkciA9IChwZm4gPDwgUEFH
RV9TSElGVCkgKyAoUEFHRV9PRkZTRVQgXiBCSVQoNjMpKTsNCj4+PiAgICANCj4+PiAtCWlmICh1
bm1hcCkNCj4+PiAtCQlyYyA9IHNldF9tZW1vcnlfbnAoZGVjb3lfYWRkciwgMSk7DQo+Pj4gLQll
bHNlDQo+Pj4gLQkJcmMgPSBzZXRfbWVtb3J5X3VjKGRlY295X2FkZHIsIDEpOw0KPj4+ICsJcmMg
PSBzZXRfbWVtb3J5X25wKGRlY295X2FkZHIsIDEpOw0KPj4+ICAgIAlpZiAocmMpDQo+Pj4gICAg
CQlwcl93YXJuKCJDb3VsZCBub3QgaW52YWxpZGF0ZSBwZm49MHglbHggZnJvbSAxOjEgbWFwXG4i
LCBwZm4pOw0KPj4+ICAgIAlyZXR1cm4gcmM7DQo+Pj4gQEAgLTEzMCw3ICsxMjMsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBzZXRfbWNlX25vc3BlYyh1bnNpZ25lZCBsb25nIHBmbiwgYm9vbCB1bm1h
cCkNCj4+PiAgICAvKiBSZXN0b3JlIGZ1bGwgc3BlY3VsYXRpdmUgb3BlcmF0aW9uIHRvIHRoZSBw
Zm4uICovDQo+Pj4gICAgc3RhdGljIGlubGluZSBpbnQgY2xlYXJfbWNlX25vc3BlYyh1bnNpZ25l
ZCBsb25nIHBmbikNCj4+PiAgICB7DQo+Pj4gLQlyZXR1cm4gc2V0X21lbW9yeV93YigodW5zaWdu
ZWQgbG9uZykgcGZuX3RvX2thZGRyKHBmbiksIDEpOw0KPj4+ICsJcmV0dXJuIF9zZXRfbWVtb3J5
X3ByZXNlbnQoKHVuc2lnbmVkIGxvbmcpIHBmbl90b19rYWRkcihwZm4pLCAxKTsNCj4+PiAgICB9
DQo+Pg0KPj4gV291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIG1vdmUgdGhlc2UgaGVscGVy
cyBvdXQgb2YgbGluZSByYXRoZXINCj4+IHRoYW4gZXhwb3J0aW5nIF9zZXRfbWVtb3J5X3ByZXNl
bnQ/DQo+IA0KPiBEbyB5b3UgbWVhbiB0byBtb3ZlDQo+ICAgICByZXR1cm4gY2hhbmdlX3BhZ2Vf
YXR0cl9zZXQoJmFkZHIsIG51bXBhZ2VzLCBfX3BncHJvdChfUEFHRV9QUkVTRU5UKSwgMCk7DQo+
IGludG8gY2xlYXJfbWNlX25vc3BlYygpIGZvciB0aGUgeDg2IGFyY2ggYW5kIGdldCByaWQgb2Yg
X3NldF9tZW1vcnlfcHJlc2VudD8NCj4gSWYgc28sIHN1cmUgSSdsbCBkbyB0aGF0Lg0KDQpMb29r
cyBsaWtlIEkgY2FuJ3QgZG8gdGhhdC4gIEl0J3MgZWl0aGVyIGV4cG9ydGluZyANCl9zZXRfbWVt
b3J5X3ByZXNlbnQoKSwgb3IgZXhwb3J0aW5nIGNoYW5nZV9wYWdlX2F0dHJfc2V0KCkuICBQZXJo
YXBzIHRoZSANCmZvcm1lciBpcyBtb3JlIGNvbnZlbnRpb25hbD8NCg0KLWphbmUNCg==
