Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2284A7A7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 22:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347555AbiBBVbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 16:31:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33104 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230460AbiBBVbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:31:49 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212Kwoju024834;
        Wed, 2 Feb 2022 21:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xti5zbtNMqmceiIa5K1Q6vLDZkqjS4PaIZwE6M4mIVs=;
 b=CIO6fOyvgqcwUFtWQKmpfZpP5QZf6P76ua9WPdLEdiG0fi5BPzTNNkGq4t82LVYC1AKd
 t21wCtwPxpwbwGlxcHgoBh7Alhh9MXAgZfE0wwJhxrVFWTY62Kl9M5rBwaV6QbOqwL+F
 VLqfJMOhgrv5U4nJI76NCYtgFM46ksvbrP9YkLapoOUJqwAS7VjbdyiuHb5Qy0znL3Ku
 W+ptutDYzrxhC/hqyE/FpUpeRhjFHsmUDsYG8MI/JknvxKS69OZmSGzh6qPh/Pzcd3Jf
 /F/cvUMwTE8GpWD6B7W983znnfHEpVYiXNPf6qiPAz8l+y5q5as5JVCei3xZdIzXECTl Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatyh32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:31:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212LVUXw127767;
        Wed, 2 Feb 2022 21:31:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3dvwd903aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3i+NT4+WJEaIBfd9nfD50WhbAUqyJKn2gptCPR3SmIk26+PPKhg27fF1YtEy0MuOdRAROnhuIqrIhCCALqhcRAkvqXH4QJZsM/6LXkpsmIxWWQwQtyACik1zsnOc6Z5xwRb3XDf4E6BtDVxbKmzJNhatC9isGG3es809nUBqBKgeMdfTPM0J2yy25NqXuAGMBz9UCv2HHCd3we3BhlseF1hQimrfo48p34Nxjk1KXaxRlU6PyliuegsC/alhW1WHsJjINB9M7dbysGqQmKDOPDKcLsQVBzUUwFDMTIbQIN8TBknlyshSWAlfNGfw/ttq0ZNpqDB4U1Up5tnXOPijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xti5zbtNMqmceiIa5K1Q6vLDZkqjS4PaIZwE6M4mIVs=;
 b=Bw8hhEovTLpsNElTETBu8xn0cnTibgPVU0pkvyreeoBWrXNT/A5I0I3oGBXya/9u6I4E8rW6imEmQz1Q30J6s8SiQs+c+OAdw9li/gKznVQGy05O/rNP0qcn3ue7yh3H4ictEKGO1RzgfX1me/VnheUhX8pK5RkuA3q3SCa+DCIOXCJhZD9/+d4xqPch6nR1ZTctv1eaOam6j40ZVYVV+6olwqb5PWxddeyyIvRaYa0YypdLL7G2MTyIhqKEDKrgHgbejI3B/zoJdk6ZZRF+7UtzisWlvYcHULarYEMnpXNDjPpIJ/stoaj8wgSDm30VJtih4vbvYVO36HDsFLGStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xti5zbtNMqmceiIa5K1Q6vLDZkqjS4PaIZwE6M4mIVs=;
 b=Lw/d9tsTcEb6bmsoNnOhr+GhS60PW/qZ7qLsnXPHuvhiIn0w/t3Sbg7pZi2FlTdbnYrTpA2DZsidXLq6qbgyR5BfGFOUGjmkD7F2FAhsgD+eCAt3apboIEGxD7VR9mOMuzOj32qknVu1X+oPHF7DAKbt52/py/+oHyelMeiwtFU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB3435.namprd10.prod.outlook.com (2603:10b6:5:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 21:31:33 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:31:33 +0000
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
Subject: Re: [PATCH v5 7/7] pmem: fix pmem_do_write() avoid writing to 'np'
 page
Thread-Topic: [PATCH v5 7/7] pmem: fix pmem_do_write() avoid writing to 'np'
 page
Thread-Index: AQHYFI6Q/lmHxWShk024TAEhoFquSKyASHuAgACG54A=
Date:   Wed, 2 Feb 2022 21:31:33 +0000
Message-ID: <9a423d47-451b-6339-6cf7-a44c20425069@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-8-jane.chu@oracle.com>
 <YfqHC8zpPlyWhVkj@infradead.org>
In-Reply-To: <YfqHC8zpPlyWhVkj@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72981cad-5016-4515-929f-08d9e6936294
x-ms-traffictypediagnostic: DM6PR10MB3435:EE_
x-microsoft-antispam-prvs: <DM6PR10MB343537A67C58977470BFFB6CF3279@DM6PR10MB3435.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:486;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulKSkPtdiD7tqNf+sGFuxv2e/GQkXJqEsD/jDZonMVWyTw1xDspmJ58sZEn6CXPVs5x1B1oMIvuI7h0KSILiZArL0/LVt25ZkEppRlDqhDqRftLL9ZeeRLGWHZ+vLHspUVXG7QcUFZChPHRZRWw+0KaB167XwGO3jLUoXA8sZxEx6mZtwMiakRwL+y9AN9STtncTt9WBvf43fYy9QXVWZyrJjVCkxs9SXCkeIYi9ZyeQYJCrhSuJD1GAWt4UBh5ziQxD6B0Qhdntx7U38LBV+MIlTDf3OW0yLju97VTA3cFbKyP/HEVtFMuLkgwU4+8fy9TD2i6kGlWtympK+yZagDTSqm78WCGc6/kjHxffqG9XJqE7YxXLB6eA9bOePhX7MJD220RYm4gSO6TcGgdfjmD5jbHC+mknKSlxTanTLa4hV6rd8rJeONztA6EjJ0q2ndBUAPD95qO5z/nMR0bmaZlc1qlfP7TCqzKzTffGCAyc2QYUg9a6pI6wNaLLQIbVZ7rijdsL1DnMcFD2NNj6bgYvKrkE72kzgVxaNlVo1ruB/oLkmNiNdiO7vDA1GrgvbNrI2iz11mes8XXu/YOhfpKNWCO9i44+90nbxBIKcDigiGAxKAO4f6wSUM3cfqqAIRUUHlfWP2aFmQlkToLuVY0pRfKgURTzFtt+Z6gH5ZCRmsP/pHtaFN7EOPx1P4ZSBR8GtqpndFIh+lyUhXLq3VB46LYnzMGesFtIAhUqUrYAZkMqYdm2nm6FzC581/1Rn1h8RJMPXRX3MMi/yNRkpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(31686004)(64756008)(38100700002)(31696002)(76116006)(66556008)(66946007)(86362001)(54906003)(66446008)(508600001)(91956017)(66476007)(6486002)(4326008)(8936002)(8676002)(6916009)(83380400001)(5660300002)(44832011)(4744005)(6506007)(6512007)(36756003)(53546011)(2906002)(38070700005)(7416002)(26005)(186003)(71200400001)(122000001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFlFbUYwQk5yUGhGWU9IL0pZRW5HT1BBSmk1VHZaK0tVR0ZEZmprbkZHQS91?=
 =?utf-8?B?SVkyakpxbEtCNi9FaDlqV2Nyd1F2UGhJUWVCRzhQTXZyeVlmeUxqbHlzMnRO?=
 =?utf-8?B?anV3Q2c3V3FlZzNHSXFwSk4vR1BDOXNqeFVXdTc3OTZSZDhwenhWdGphWlFC?=
 =?utf-8?B?UmZXd2JSa2w5M1g4VEkyU0VvYXJGcDZiNDE1SUMyczZlUy9VVDdMQk5iMFFX?=
 =?utf-8?B?RzBxdHEzamZXc2t2ZlZ2aGphVkN6bTArcFpYcjlaQXJzK1dxWFNWT0dnc1cy?=
 =?utf-8?B?Qi9pWWFRb3ZjSlh5Z2s1QlBTeUpEN2RWamxPbWN4ZVVGdTd0NVVJWkx4NENw?=
 =?utf-8?B?OUdHdm9lM0NQSzdTZGE5UGtDdmd3cWdtcVRaMDNKdi9kNHZNWlgvMWkxTTF2?=
 =?utf-8?B?TklGY3VGUXI4bW1FekdkaUxrd1dMQXQ1L2pnc0gxaWFsVWw4SDd4ZnE2TXVw?=
 =?utf-8?B?clNwM2RyOUFwaG1hNGlVaGxiNUdqNlJ2QytpYktNQytFRUlQQU1ESDZWNHRy?=
 =?utf-8?B?bkNHRmhDdmlLYXFVd0tFTk1GbUhuRVp5Zm41Ym12K1BjY1A3bkJIK1hHR2FX?=
 =?utf-8?B?Z2w2b3lpSHBKS2tUNDhDUC9EYlNNdE9NTFRrcTB6YjFOWlJLTVVQRXh4V3RI?=
 =?utf-8?B?dnQxNU5UUWRXM1BpTWVBRndQVVhjYVczLzUxeUJvN1A1L1BYcTQ1WUlKcVpB?=
 =?utf-8?B?TEZYSGF3T1BtNCtNYjUwckJsWHd4NXFrZG40cE5kWmRTb2lvamFCTU9VYkx3?=
 =?utf-8?B?UzNFVEc4ZzZEMHNnL2p0VHFsdTZSRkNrcDVteG1vNnF1YkpOWXhhSDFaMzRP?=
 =?utf-8?B?aC9VMHQ2bDJzVzJKOERrYTZmRzNKU3g3U21ObkxqY2ppNVVHMEJHWSs4cXp1?=
 =?utf-8?B?dDlkL1BJa0JxOGFnZEFod3drdlBZUDd5SERtbGx2VGUrUk1oWVJKZjZURjRZ?=
 =?utf-8?B?SXl4dmUyNTRnWjdaWEpjNzMwQ0JCbnpWSk4yWjlaQWR2eGZrR3NuSWVZdFdC?=
 =?utf-8?B?T2JhUHpKUnV4MzZzM3BPZDkxQWI5bzJGVnNQbmNvUzRhb2t0cFp1UEtNZzZV?=
 =?utf-8?B?bDhoRWZJTTNHWVRxME9xajFvbFA1alVhT29JRGhGZU52TWx2UVEwQjNEVGl5?=
 =?utf-8?B?WmVYNm0ya3VIK2ZGMHNOSFpZTkI2NCtGa3BkSDlHV0VXbmhXVDM4U2F3MzN6?=
 =?utf-8?B?dzlBWU5UaFFHUWV1ZVprQkVaODkzbUdDSGFDaE9CQldZbkwvbEF5bWEwY2wz?=
 =?utf-8?B?amhONEVYY3YrWUZ4bFVsc3lnaGhBTHcrOFF3KytNZTZvNG1MWVhIbnZ1N0lZ?=
 =?utf-8?B?ZW5MMWxwVVZSVVVWSU1sN2dDS2oxck0xTGV2bjdla0NGQndEQitZengvZXYz?=
 =?utf-8?B?cnptU0Nzb2tKMjdTSUFoaWdsUm8weEVQTXRFYjlJU1BVbWNqd21tbE9XOGFw?=
 =?utf-8?B?K0NHczl2SEM4ZU1LTFl3TWRjN05IZVRDVFN2KzB5MTVsOERSdkJiQUNNQVAy?=
 =?utf-8?B?K2lselhNNkt2d1RPL3Zrb3RwTnNkZU50MFh0RW0xUkdiWU80VmlySmFRMzZi?=
 =?utf-8?B?cjB1emZNMEt1eWJwMjR0Qjg0TnRGM2FNNFRuTVIrQTVKMWczUG91bWxRM3dx?=
 =?utf-8?B?alE1MkZhdm5MZjRFbzZjSWJuSUpSRkxmNCszUGZGSDhUbnFtcmdheWp0T1ZX?=
 =?utf-8?B?djVPZ3lYUk1yV1lOdjg4N05rd2NnY2puN3RLeWJiN1Q4REtLb2dhWlk2NHNz?=
 =?utf-8?B?VnF2bHFmREdDQmt2T29vbm5MK2o3YWxGUW83d3pId1djTDBFZDQxMHZXcEZG?=
 =?utf-8?B?aGxMQVBZQmFnMnp1czhkQWh5azhlcXh2aDBQUURnbnBTWC9SWmJVYVg1dlRQ?=
 =?utf-8?B?bHl0MWNoMzY3aG1weDN0LzdGMEtSdEI2clJjVkI4Y2p1L09RRmhxK3BHd0I5?=
 =?utf-8?B?UlhudkNEM3NydXBrejBjYSs0NVBRR2ZpMFpIZTNkU3dtenRRMXJZWjNEdXdK?=
 =?utf-8?B?cG5UVG44SGxRbVo0SGtCY1JKN1BsQ2RyK0wwejZJQ0p6NlU2Rkh4dnp6UE1J?=
 =?utf-8?B?Z2Y3RnRvQlhncUFoTldHcXNxRittV2N6UURBTUlzL3p6MXFpaDJGRnYyeTB6?=
 =?utf-8?B?RHZlbzZINFBmdXgrYWh6TWl5OVlEd3EwU2l1VzkrS1gxTHcwWGtkL2dSYnYz?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C6B0D0D7F377D46A374677B18E0B772@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72981cad-5016-4515-929f-08d9e6936294
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 21:31:33.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE7iUva6FpeE7GmlJ5uOBabfaKIPLiMGgW92O7hdeNEsbsn1GxdbZ/PgW+rN+yqhVjHwNBI6PEx20ZBd6kpS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3435
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020117
X-Proofpoint-GUID: edYPlANiHWhGuHOb_lcUDfDlmUpbfFfR
X-Proofpoint-ORIG-GUID: edYPlANiHWhGuHOb_lcUDfDlmUpbfFfR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgNToyOCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwg
SmFuIDI4LCAyMDIyIGF0IDAyOjMxOjUwUE0gLTA3MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gKwlp
ZiAoIWJhZF9wbWVtKSB7DQo+PiAgIAkJd3JpdGVfcG1lbShwbWVtX2FkZHIsIHBhZ2UsIHBhZ2Vf
b2ZmLCBsZW4pOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJcmMgPSBwbWVtX2NsZWFyX3BvaXNvbihw
bWVtLCBwbWVtX29mZiwgbGVuKTsNCj4+ICsJCWlmIChyYyA9PSBCTEtfU1RTX09LKQ0KPj4gKwkJ
CXdyaXRlX3BtZW0ocG1lbV9hZGRyLCBwYWdlLCBwYWdlX29mZiwgbGVuKTsNCj4+ICsJCWVsc2UN
Cj4+ICsJCQlwcl93YXJuKCIlczogZmFpbGVkIHRvIGNsZWFyIHBvaXNvblxuIiwNCj4+ICsJCQkJ
X19mdW5jX18pOw0KPiANCj4gVGhpcyB3YXJuaW5nIHByb2JhYmx5IG5lZWRzIHJhdGVsaW1pdGlu
Zy4NCg0KV2lsbCBkbywgaW4gY2FzZSBiYWQgaGFyZHdhcmUgaXMgZW5jb3VudGVyZWQsIEkgY2Fu
IHNlZSBsb3RzIG9mIHdhcm5pbmdzLg0KDQo+IA0KPiBBbHNvIHRoaXMgZmxvdyBsb29rcyBhIGxp
dHRsZSBvZGQuICBJJ2QgcmVkbyB0aGUgd2hvbGUgZnVuY3Rpb24gd2l0aCBhDQo+IGNsZWFyIGJh
ZF9tZW0gY2FzZToNCj4gDQo+IAlpZiAodW5saWtlbHkoaXNfYmFkX3BtZW0oJnBtZW0tPmJiLCBz
ZWN0b3IsIGxlbikpKSB7DQo+IAkJYmxrX3N0YXR1c190IHJjID0gcG1lbV9jbGVhcl9wb2lzb24o
cG1lbSwgcG1lbV9vZmYsIGxlbik7DQo+IA0KPiAJCWlmIChyYyAhPSBCTEtfU1RTX09LKSB7DQo+
IAkJCXByX3dhcm4oIiVzOiBmYWlsZWQgdG8gY2xlYXIgcG9pc29uXG4iLCBfX2Z1bmNfXyk7DQo+
IAkJCXJldHVybiByYzsNCj4gCQl9DQo+IAl9DQo+IAlmbHVzaF9kY2FjaGVfcGFnZShwYWdlKTsN
Cj4gCXdyaXRlX3BtZW0ocG1lbV9hZGRyLCBwYWdlLCBwYWdlX29mZiwgbGVuKTsNCj4gCXJldHVy
biBCTEtfU1RTX09LOw0KPiANCj4gDQoNClRoaXMgaXMgbXVjaCBiZXR0ZXIsIHRoYW5rcyBmb3Ig
dGhlIHN1Z2dlc3Rpb24hDQoNCi1qYW5lDQoNCg==
