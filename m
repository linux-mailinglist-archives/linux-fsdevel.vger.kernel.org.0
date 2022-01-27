Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9536449D6AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 01:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiA0A0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 19:26:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbiA0A0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:26:17 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZ7qj017314;
        Thu, 27 Jan 2022 00:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5JfvMoIRtHatb6eef4hqYYEmQS6IcLmS/YychWU1Eo0=;
 b=k0csC3U1eXaRR+yMw7ShMdCbLefVmxaHm1aIlgfMbmMA5qP9BdZQqtLhxwuYDRIAtgc9
 IL7k1pXKBqRUsY1EXNC2xzYfQbR7oFi7X7CD+s4TwyQxMKH1MjeivqDP1nQK5A1M17tF
 vgtY3yygiI5NFPTfIJPPCBrSVCke9zCt7e6yGLiM27hdnlZGnWkgnUdTo/gYtdE38SHK
 PhSqiJ6Ko1rqvTl2qqXc6datnXT/yz68Sqz/apyehprxFd5SDj8tVhbYCzqJ4+vJrhiw
 YjRCIgqhmIPivQOyG8/+QYk7n/GpydPx7csQ8fcVBo8MfI7KaLTij8roSDgoOwAPFr+D tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s7k2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 00:25:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20R0H317046880;
        Thu, 27 Jan 2022 00:25:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3dr7227whc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 00:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtQr1ZiUlusxTf0mKYdvycer10euk+bJn4cMdAYoezNY3UOajlNuTiLCM+xEE/sGbdbgBF4CFQHfRF4aPTF+7HzguqKhHpnFcCy3H97xMOzpTucPUb1bJL85LMRphzNaHRrcuWaI69y5rsVTXhU4uMcBf07dt10FGqzAphPt12eCY09Wjs2VruhAOcdTaMM1KVe6t8ul1qSZkKKPU5n1yDWOUPrNaNsV5/RrkZKl3ZM1//JwJgbVEiSlneKEptsUZo9ML+UutDhXguXl0/GqdyFdzMO4+42jmQCXzbXM0hrtZpKLuHVza6F/JMDfFiBzVJNo8uhVA3ABZ1ZOK6VZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JfvMoIRtHatb6eef4hqYYEmQS6IcLmS/YychWU1Eo0=;
 b=VXBYez8Kcq3kxWd8q1xmpKnrB7kCAgr6vfPX1t1CsMuN/PNb3svslCOyxp+eVAP2CgWiyy54qqkrUJZFlE6bW1I062BfApMrZkoKLEbGFs15q0+QSIzvU7Ho3xESH9RqWVnENTQY/adNK5m+tSd1elTRScK1VFgvWLWJ1SJQ4zAN5Qz/nLFgG0Fr4Ssi2/g5fbGB9BEGwcTMGu/2F+g0XszfiM7iq2xy5vjSbA+6Uxr4N7GES5yd/y1+UYuFm082k1vhakkRYimEygbpxylbyvjGBNiXaE0YOqJPBwGls4B/4zT1rvmuNGTJRV+dlLMXE9ZeoQ3ekeDy2SQsh8uClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JfvMoIRtHatb6eef4hqYYEmQS6IcLmS/YychWU1Eo0=;
 b=xSg1VS6L7hTxX9pHMCkCNBnf8bzmUEP54N5qk8ITcp/arEIsKQJkECRDJlHDtkPGCh7Sjjz3eR+XQklsiCCZdJLr7eRwJ7sVnYGll6ryxaj9wE/PAL9ce1xel3ZgkKffJQdWBc/nBFO3oWAI+waWzgZ6muiJ6+YXnGgozgpaw+s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 27 Jan
 2022 00:25:56 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 00:25:56 +0000
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
Subject: Re: [PATCH v3 0/7] DAX poison recovery
Thread-Topic: [PATCH v3 0/7] DAX poison recovery
Thread-Index: AQHYBx1mMl0+u9/A1ECT4doipsHhkaxruVyAgAEGPwCABTQgAIAEJu+A
Date:   Thu, 27 Jan 2022 00:25:55 +0000
Message-ID: <eb09688d-2fa1-80c2-61e5-972ff58eadbf@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
 <Yekxd1/MboidZo4C@infradead.org>
 <4e8c454f-ae48-d4a2-27c4-be6ee89fc9b3@oracle.com>
 <Ye5q7MSypmwdV4iT@infradead.org>
In-Reply-To: <Ye5q7MSypmwdV4iT@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcfde5b1-7718-4436-44d5-08d9e12b95b5
x-ms-traffictypediagnostic: SN4PR10MB5605:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5605A165BB45CB68BB202B4BF3219@SN4PR10MB5605.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvngJnniqeHTZRQu6d/8PEqHRwhbLeHeoCcDxdALouv9qjGvMXh8EaOsKsRQLQwjKDdazPMvN/ivFpmpLRgFrTE70VsgohceJ492il8ez5jnxpi8Vf7ROpIn5BVPHwibPX9lAjVhxcGBED1FPWIGpeAxtb0+FozHgCjVvKc3cQ7yUmi5TNeVlCIcp4wdgDWptQZWKY3TII9ObggJpXtO/1t4WtCoQNJKigEv3uYtZfi4Wq6qM7qRPxH4ZUu8T++S5eegyiKD18XoRhrbo1PY8JdICLLRikqvU3EsRYxivPnklT/HzNlt8ttxTJSN2jvr/5enEnHi22MSuy4/3z0YdCo8Z9+bp0bj3OYC2M2hD3fnBrQQ1ngB92qwjWDuNTPsadoIhyzxct/WsNqy2hIoKpjzMNbwmQ1tUVOYUBcvUBPq+0zAqApUw6O3T5iP4oz5y7H/dbss5SjQ9hj3EhYvGjYcInJ71ZR8my16Tx3jr3zynUAIO7XMuNaNc069qPbbyKy9C0h64yEP3+7SSatOdxs2rlVkoyreQ0QbBt1gfCMWCNVPhPAgkkK33fCCY/49Uga+dhgdEgtOMecYcCagv9Ine3QI8tv2RFCaqbSr4l8PU4eWa5Dyr9xkfJnKzM7FYFoWniN0fDaGyGkkP6/n/2e0xJ7nUO2yZSBMv0FnLXywKmSD/UvESyfWFIbKbCChWLW2KCzP7MyRHRRJjWxAE9xFv2PRHqWk0SL4CS7BKdnXFRfCw+oGBnaQJU32uDj0z6BgFkPEQstCg6XQCI+1Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(71200400001)(66946007)(66446008)(122000001)(316002)(31686004)(64756008)(44832011)(6512007)(76116006)(91956017)(26005)(38100700002)(7416002)(54906003)(2906002)(4326008)(83380400001)(38070700005)(8936002)(4744005)(36756003)(31696002)(8676002)(6916009)(186003)(86362001)(508600001)(2616005)(66476007)(66556008)(5660300002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXEveW0vejhNVjZiOS9yR2orbnVITmRtTVV3bkpYSVcxYnlRYUE0REJjZnlY?=
 =?utf-8?B?WkdUMEtUd1JSVDFURGNsM2F1K2NLRHpMRWw1Q0pUcnBrWnM4VFQ3aTFwdW16?=
 =?utf-8?B?d0RGUTZNam13bnV5ZkNwMTBNb3dXcDFiaDlEUk9nUWlOUnRaazZnam5rMWkz?=
 =?utf-8?B?MGw1Mm1YZ1pyQ0tzUHh5Zm53N04rT0EvbUhGdEtJOU82K2owOVF6RjR1Ym5r?=
 =?utf-8?B?aS9qNHQyMnB6UjlybzZiVW5aNVlzL2pkSm9Benlja2VHWW5pYmQxWEJ5QVpm?=
 =?utf-8?B?Rk9LMGRmenFuWWc5ay9QTEhZSWsvc3lMelRFQ3hhWVhNaUhRT0JUUTZqZ2tI?=
 =?utf-8?B?TEI1MG5QOW1ua0JDMno3R2RNcE5ycGM1NXBNL284dHY4UlZ3cEc3bGQ2YlJr?=
 =?utf-8?B?M2EycFlJY011RHRlTmFNc1pwbS9icEVoOVEwOFdoTy9aK1ZwNnNUM1JUU2cw?=
 =?utf-8?B?NUMvSWVQTjBtZmlBQUovSk1Mb3VBaWFYcHo1MVlDNmNYaEZSeHJLRDREWUhL?=
 =?utf-8?B?VnMvek1DUE9KVWFIRnZHbWQ0eWFGd2Z2dEdLM3VmemhYM3FCYzFnd29iZHBq?=
 =?utf-8?B?ZHJRU3VzNlBNaXRZS1ZCNTRPcENCWUQwQUVTdXdOT1NHVFdJdXgwS3ZPcTda?=
 =?utf-8?B?RldvQ0pSTWtaNGVBVXZQVDZWc3lsVXNpdm1PSGFNWHlxNnd4b1lTU0d2b0RQ?=
 =?utf-8?B?SXVWTmZUQVFONDdWUVpSeUZIVjlHeHVIbGFJWTlCemVkSWFsdjQ0QlpJWWU1?=
 =?utf-8?B?NXdvZTZ1ejlwcTB4WE83bWlTNm5NV1U2SUpEMGJ5dkpWZ3VCeTBoaDByOWtH?=
 =?utf-8?B?ZDVBcmFIN2RmRFJqaWxFNitTZ1ZIMHVrY3d6NVp0Q0xyZVRPc3FpbW9VeVVx?=
 =?utf-8?B?bHR3b0VyR3phb1F5S1VDS1pDYklPZkZSWi8yOEk5UWlBbUR5UnlCeFhmeWZ2?=
 =?utf-8?B?SjJ0bStuVFdlWCtqZ3FLRXlkc2k0b0pMV0FzWHhDL1NLTWJKVUkvaHZWVUcy?=
 =?utf-8?B?cUlNaDhadVl4bVZsb0RvcEdrNWk2SzdBT1h1QkN4ODd1b0t5QzFpVWhacm9Z?=
 =?utf-8?B?VStUN1gzNXQ1L2xxa2JxdXI4ZDNQb0JBMG56QmlYcjFVbVljRU1DblVZQ3Az?=
 =?utf-8?B?K2xxL3FxN3FFK3hnOTZqVm4wYk16WVpPbWVqdlZDVEExZ2N0TndBMUJHWEJS?=
 =?utf-8?B?VHdGQkZGZnZ2c3hmbVNGdjROWWZtMmYyV0FUWUV0bTAyVERtcTMzNmdPcHVh?=
 =?utf-8?B?ZzNLaEV4STRuR0dPS2swSGU4WGlDeHNydGt2MjViYnp1MkV5ZWpGcXNGbkRo?=
 =?utf-8?B?cG15UGxkN1VIeEp4allTY1EzRDdJSWljcFhDTzVsK2p5aXg3VHFydXVTc1JN?=
 =?utf-8?B?OVhyakJpMS9SUERZZVpzRWxNVTRabEVHMk1OcUZsUEczWStOcmh6ZWZqRkU4?=
 =?utf-8?B?ODlER09JYWFVQVl6WUZ5MnRQZjhjc0dmanhuSksrNlQ1WVBSMFphV0tTdE5v?=
 =?utf-8?B?RnhuWklHcWpkL0t5dG5pLzIrckcxQ010aDhnbCszVkRybmpzTnNPdmVkbzhu?=
 =?utf-8?B?U0pHcXFMODU2L2d2azlOdHRTS0REcjdUa3ZmdUZxZ09lVFh0T3dEL2hZUDJG?=
 =?utf-8?B?MnZwSWJhVC9ZTC92T3lkUCs2Z3dKZE9aUDRBY3FTeGh1NE0vK01meU8yZXc0?=
 =?utf-8?B?anBuSW5yK3N6Q1c0U2FSVWx6Z25ldU1hMlJqVlU2NmY5dlIyR2NkVjFobkFM?=
 =?utf-8?B?RnZ0Ymg2dXViWWo5ejY3bzhhT2RhUFBKQXpZS2paWmo0SExxb2F0QkRUOVFx?=
 =?utf-8?B?TW80dW1IdlorSzRtenczTjNvQytVYUMvUTZYRXVzSDVIUC9NVnNQZ3I1b1h5?=
 =?utf-8?B?aWRpbFZTOGJzZDRBVlE2OUpuY09qTzNBR05YNGRHU2twV1BLek1ISk4zeXpK?=
 =?utf-8?B?TkI2OXYzQ2RUZFNBbmJJT3lDZWFMOE9OelVwWFJFL2RPV1psL3ZuKzFjM0ta?=
 =?utf-8?B?NzhRWCt0T1V1d2tqMnB6ZGZJS29ScXNBZmsyNVU4c2lmK2U2cEZSNkhDL0V2?=
 =?utf-8?B?VE03bTV5Ly9KRFptVDAyQVAvYlpYb0lHQURlWlpKQlpXaGl2UU93NkszeWdw?=
 =?utf-8?B?Vy9wQXA0c3BLSWhDbkJMM0hTVkpFQ2crSERrOUJYdjJUR3FaT3BSNFRiOU4v?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7ADC38D4B7FFF418AF7B8B42C5651E4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfde5b1-7718-4436-44d5-08d9e12b95b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 00:25:56.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LcuAIdlHeNX3L6ylCu2tb0TjZe0WTp6v3VtPa0haavtutMFwnhOZbpiHfEiFw/tylFf1/72SXr1/laCbu5EZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=946
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270000
X-Proofpoint-GUID: _9Kn0o8E__aAen6zdxizj9bXtfKVpt6o
X-Proofpoint-ORIG-GUID: _9Kn0o8E__aAen6zdxizj9bXtfKVpt6o
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8yNC8yMDIyIDE6MDEgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBGcmks
IEphbiAyMSwgMjAyMiBhdCAwMTozMzo0MEFNICswMDAwLCBKYW5lIENodSB3cm90ZToNCj4+PiBX
aGF0IHRyZWUgaXMgdGhpcyBhZ2FpbnN0PyBJIGNhbid0IGFwcGx5IGl0IHRvIGVpdGhlciA1LjE2
IG9yIExpbnVzJw0KPj4+IGN1cnJlbnQgdHJlZS4NCj4+DQo+PiBJdCB3YXMgYmFzZWQgb24geW91
ciAnZGF4LWJsb2NrLWNsZWFudXAnIGJyYW5jaCBhIHdoaWxlIGJhY2suDQo+IA0KPiBEbyB5b3Ug
aGF2ZSBhIGdpdCB0cmVlIHdpdGggeW91ciBwYXRjaGVzIGluY2x1ZGVkIGF2YWlsYWJsZSBzb21l
d2hlcmU/DQoNClNvcnJ5IEkgZG9uJ3QgaGF2ZSBhIGdpdCB0cmVlLCBzbyBJIHJlYmFzZWQgdGhl
IHNlcmllcyB0byANCnY1LjE3LXJjMS04MS1nMDI4MGUzYzU4ZjksIGhvcGUgdGhhdCBoZWxwcy4N
Cg0KLWphbmUNCg0K
