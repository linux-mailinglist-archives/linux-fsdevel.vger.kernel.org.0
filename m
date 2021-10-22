Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E16437FA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhJVUzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:55:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27974 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233732AbhJVUzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:55:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MJ9qn5026503;
        Fri, 22 Oct 2021 20:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u+vT7YH5IMCFkLSt3NTBN8ewPgLe1q51hoF4AvZVLWg=;
 b=kLin6+hEGWbsif8txVMGPkm7mrMOkrb+ucj7xmpO0SNnITrndnPER1stBq8pi4RkMJGX
 S327AYLjdAeGR2KqZpT90s0/Few/UKaRHMuoOoomzAxuouEha/SchxHFQadQc4cW84T+
 mMQ2//F64odVFNcfvYeG5ucmmcIsBwoK2FZSL8NGJEz78tK6BgKEXutN9Esqiux9kT1H
 CKrZiFTi6x3XI0R/z7x+Mge+MrN2yqHn87ZUFIE+f5hUwZzUG4/LCCCzBGscUq63A6ap
 f9uz7H+p8VdWOUyXaHH8wJYdu7LGEFov5KwwpcHL3h62pNMgm4jJxXORVCGrnK5L3tIC rA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bundfmjem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:52:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MKjL1Z065182;
        Fri, 22 Oct 2021 20:52:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3bqpjb69eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkmdjCN+wTowS1dTU72Z1kBxsgTYavvlhKPSyyJZcVT9IVdrmmCF8iIDBsNl3d0ThXgFxb1p44B9H+g0lTPpzl8HTnlYqFUJkaR/8UTgAGv/2oskqFUDCH9IFtJpevKyCuT6Z5WY1EAyZpXpY0o8c3WUW2M/w225/r+btHytl8u1n7AYL7U+r959j/b96NnWq+yPjRdO7ZMZkjQfKxxYU7ki8jIzJYLXIMF0/ftexvrPSLC1D0Z5NfY4b2Y8QZ7wqFvTVK43SWWBh5nOs82vz00AAzRrR0//qjtpVsKC1IkPv7Ek7DAf0psYK/cvLHITdakwW6m0LCdpo8fykfrAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+vT7YH5IMCFkLSt3NTBN8ewPgLe1q51hoF4AvZVLWg=;
 b=HcJOViRG82qVQvbGUc/VZHT3u50RNaXiGw3KH5Stv98uCrvDUJQ7O4pXkGI0V0hmZDPi3kXkAWSX/Wsx0dyJDt6d9NS9guftBlMicVxf7aG/tn+UdQil3tpgIulL+n/3yvxdZ4qLuSomO6SodKmHaG/n3os/Km0dR8nmsmKU4rwlGWqIhnygHJnbPQOVgjRFIbP5mwaqvWU8KryeOUwDGjfz/3R9QV2W9K6ueP98CfcS59KS3QWiQ6Nt13M5NVHMQ9xOsSyQFTlzB2j8E8BNPoeS+Lj0g+hQ025kB0kvcRam+IRryTy0ofE4Qj7AZ7K0Jjswsy20f/Nw19r+hSAJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+vT7YH5IMCFkLSt3NTBN8ewPgLe1q51hoF4AvZVLWg=;
 b=YjyFqMb5CqAc2ET+7331be6V+H19SbQaOUtr1gqA8UPpYmG1T091gtSMDg+rOSrKivm/p7r2cmR1fzgaT/VraRpc41AMnDIVLbk2Agm8HlXcOW/aULPM/QIKea+zlzdLPrONjbs4mm2v4L0/R2ay4n49g44hX/JaSw1sLRZOLPA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 20:52:55 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 20:52:55 +0000
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
Thread-Index: AQHXxhAze/H2dZp4I0O0xNcfyRn+pqvdUicAgADsdoCAAELPAIABAAaA
Date:   Fri, 22 Oct 2021 20:52:55 +0000
Message-ID: <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
In-Reply-To: <YXJN4s1HC/Y+KKg1@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f68e89e-66b7-4332-ce14-08d9959dec72
x-ms-traffictypediagnostic: SJ0PR10MB4623:
x-microsoft-antispam-prvs: <SJ0PR10MB4623D231008406D117BA8B8FF3809@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+pagA++qWelxE9tCbikAUz87/MUTVPdJHAkWIKJDyADOB2V4vaKU3jwQM6l7YkukgHJEq/Uct85tXBswjZqnUKAmXQE+XCV5/cGiTG91jbPKgjFitWOuDPBKXJF7S8oe4pJf1T+RXAOc/Hd2UZO8uHSPiOUkf41vWS35jTQR4ERQeD0jPMFEiigsd516ddPoc30vUpXH3EV9EQ6W7UJY2+Kp69FhDxQVdHEFJ1bkcfvIsZzeJG0ZtzI0SJ2zqJkgC/y2k4jGty3cVb8397ySx71OBI1AvKhDRjnD8h0dL1SVpDt5wDgpl1Z644BsSjK4t2fiYm9DJbwnLd2/VNY/XHG7calvCpAhwwkWezB8tmVT3dM4ro/ZMHv1UK/14PizcJQGdgQ2O/eqm7F3Rq4sbwUhQ+AUfLe8hPvEcQpuC0fDcKAaO60lE1rnVquGz34VZW0EZSz8s7L4NTCBKlFi6x+k4mMFzKaz0wDWdjY8TZT4XXjy5XjTbpEDG9wkA/Y9QJzxPc5sWGKnRuXPlKyDTXL52gZ4z0ZN9Tv2t3nbcHB17duho89K0JR6FOFdRjDFU5H3JVaACZWgHupdZuwCELQs3hFKbDziia/unhKA6MqZSf8xn95miH/4CVUk7bjfruL6+WCZ4TVdknN5yVGZx+V3mGfMOl6DT1fRyBzm0ASsXQtUBKCvca5CIM8YazRhR7Gsh7OBtS72pvpJFtUkneRwxEarswWzDT8fQ+72MFrpwD3jVd378kR3fa171cR3k3k3Ay3Pr4l8BVKYnxJPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(8676002)(8936002)(508600001)(6512007)(6486002)(316002)(7416002)(2616005)(6916009)(186003)(44832011)(31686004)(76116006)(5660300002)(91956017)(4326008)(66476007)(122000001)(64756008)(6506007)(66946007)(38100700002)(66556008)(71200400001)(86362001)(66446008)(54906003)(38070700005)(2906002)(53546011)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TituSWhLckVvcXJuOXBWbUU1aVFwR2JlNktxckE5THNhS21hUlhCZ3pnTEJV?=
 =?utf-8?B?TEhuYjlqRnJhMGp5eEU1Ym5Zd3hNajkzem56dTlZL2xNNUxsamwwUXlMcHlo?=
 =?utf-8?B?L3Zpd0NOZU82aXJsQXNHMVQxMndMRnJwZFB6c0FKd202MzBMclJnZWpHMjZI?=
 =?utf-8?B?RlNieFZvSzVDemxhcHFFbTVzK3J4VFhqaWhWMHpxSlRqZWN5YXV2M1htWmNQ?=
 =?utf-8?B?M1QvUWRoaEhpR2IzOUZYb2lvYUY5TnNPWjhIUlI0Z2VSSkRTMHVnS2R6TWZr?=
 =?utf-8?B?bTFZcVRaZ1ZCbVUwR2w0TzYxelpVeDdzRFZVZXpxOG94NUJ5eVdxYXZLOUYy?=
 =?utf-8?B?OGh3UzNRamlIcE5SZTdhNXNERDg1RlJtTWFpZEZ5cEZ4YUpRR3hQUVoxa0VR?=
 =?utf-8?B?dzBrSmVvY01yOWNJMVFZNnc5Q0IyRkZhSUdkTFJvTVJaVXE4blhDL3E3U013?=
 =?utf-8?B?Nk9BVGMzdkUwbFAyM3d0TXp6RjJmNDYyY2YvY1haTWhXL0JCd3N3c1FBc2gv?=
 =?utf-8?B?TDNZQS9YeExWcW1TcHdkV1poWlNhOGplUVhIcE0zZHE3YS84Rnl5bHp0TVRm?=
 =?utf-8?B?Z3NCcXVLYWZiUEVnZndRdHBIS2ZERU5rQnNOaURRdVR1cklqeXpmaHl2Z1FD?=
 =?utf-8?B?THBuWHdQSlAwZm10WnFmdzhBeDNTK1R4a0l3Vi9CcWEvRUtmMTVSbnNPMlZ2?=
 =?utf-8?B?T3RzUDBJMzJsMXVod2p1dTQwck1rcFp1NktYeUw1ZDVlMnYya1NLZnU4UnZV?=
 =?utf-8?B?OXYvSVh2RWoyU2MyUWdsQ1V1UkhjSHZiT0NqSFlQUlpFQjZmQ0duZzNpcTFW?=
 =?utf-8?B?bzBydmxWWHkxaUR2UU15cndEcmxua2NCNldFVWorVUxGNHM4UmsyZTNENktx?=
 =?utf-8?B?eHZvdGJRM3B1UnZvWEp3QjVIR0JEVWdjdXBieVRzM0J6TTVVUGxNK3g3aWRr?=
 =?utf-8?B?OUdoOEJKSG8xdG9NbzJXc09zVE1QV1VNNzlsL3dPcERxMm1SMkk3VW82SGox?=
 =?utf-8?B?SUNKQnQxT1dTUjhWSXlQb1JOVXE0bnJvMFZyR1FkQkhqUStma1dFM2QzdzZX?=
 =?utf-8?B?dzNvK0dEK3l2VnNuMTM2blJkS3RvZTRYeEVpckVpNkdyajdIQi9qSlU5SXpB?=
 =?utf-8?B?Sk5laytlQzRuTXJxSTRLMkxnNnVCRlNDU09Wcjdta3hScy9WdjNMVUl6WXc4?=
 =?utf-8?B?U2xIYmd0bGJabksvZmcwU01OV3lhWnp5RkN0K0lFQW96ZENocHBsZGllSnp5?=
 =?utf-8?B?TTVPNGxTSks3OHlnQmxzU0VkYzNNeE10ZFZ1bkZBS250ZEdYNXlINDBmSDB4?=
 =?utf-8?B?Y0lTY3JMUEIydStYbHFjM2s0YUZRb2dORGIvVy9JS0dhUHU0TlB1UmVMeDY2?=
 =?utf-8?B?dzd5aHd4eG8vQ0NYM2lRa0hFS3kyMTVaWFNvRTNHRDdZQWl5ZTNGOEtVRUNV?=
 =?utf-8?B?ZC9tMGcvaDlVdFpEUGFybU9mVDhpcnJ6K2M4M1FUbVU5dnludThIWXZQVUhq?=
 =?utf-8?B?b3hSRURSd3JDWmtaM2ZxR1pjV2lYdUtwQ1QrSHo0UXBYeTdoQ3JzRk9UMzZj?=
 =?utf-8?B?REUxRzVoZk9QOXR3OXI2cHdIRlVFNXRlS3c3LzE2bGI5UUg0RTkyRFlBNjk5?=
 =?utf-8?B?VWtrV0lYNTZ2SjJXY3IzRDd6OU5iOWRCMElIeVpGcVNmRlVWUlVqbHBBc0pJ?=
 =?utf-8?B?eTBSTzJQQ2Y2Q2luNzhUQlV3VzdjZ01oRitTM0YxSHRTL0tIeWJVY3JUL2JV?=
 =?utf-8?B?eldFRXZiSVdibERMRWdIV2dWSk4xTVo4cTM1eVhCMTVLb1JIRDBMc0Rxamx1?=
 =?utf-8?B?TG5KZjhwYmJ1T202SmdLTVpMNEwvT0ZPWklSNkkzYzhTcGliYzhuN0RVZGRO?=
 =?utf-8?B?ME8vNkFRS0NMeDhMQUd3eXU1UVBtOXYwMEFQamVnU3lGRUJVSkx5eWxoSGQ1?=
 =?utf-8?Q?NRLlMph/UCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <021EC1710E3A6E4CA006BA3EBA297DF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f68e89e-66b7-4332-ce14-08d9959dec72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 20:52:55.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220116
X-Proofpoint-ORIG-GUID: oqQeaT9yd6Hlp7JCBzOms4Bzj7zHRQRI
X-Proofpoint-GUID: oqQeaT9yd6Hlp7JCBzOms4Bzj7zHRQRI
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSAxMDozNiBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZy
aSwgT2N0IDIyLCAyMDIxIGF0IDAxOjM3OjI4QU0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4g
T24gMTAvMjEvMjAyMSA0OjMxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+PiBMb29r
aW5nIG92ZXIgdGhlIHNlcmllcyBJIGhhdmUgc2VyaW91cyBkb3VidHMgdGhhdCBvdmVybG9hZGlu
ZyB0aGUNCj4+PiBzbG93IHBhdGggY2xlYXIgcG9pc29uIG9wZXJhdGlvbiBvdmVyIHRoZSBmYXN0
IHBhdGggcmVhZC93cml0ZQ0KPj4+IHBhdGggaXMgc3VjaCBhIGdyZWF0IGlkZWEuDQo+Pj4NCj4+
DQo+PiBVbmRlcnN0b29kLCBzb3VuZHMgbGlrZSBhIGNvbmNlcm4gb24gcHJpbmNpcGxlLiBCdXQg
aXQgc2VlbXMgdG8gbWUNCj4+IHRoYXQgdGhlIHRhc2sgb2YgcmVjb3Zlcnkgb3ZlcmxhcHMgd2l0
aCB0aGUgbm9ybWFsIHdyaXRlIG9wZXJhdGlvbg0KPj4gb24gdGhlIHdyaXRlIHBhcnQuIFdpdGhv
dXQgb3ZlcmxvYWRpbmcgc29tZSB3cml0ZSBvcGVyYXRpb24gZm9yDQo+PiAncmVjb3ZlcnknLCBJ
IGd1ZXNzIHdlJ2xsIG5lZWQgdG8gY29tZSB1cCB3aXRoIGEgbmV3IHVzZXJsYW5kDQo+PiBjb21t
YW5kIGNvdXBsZWQgd2l0aCBhIG5ldyBkYXggQVBJIC0+Y2xlYXJfcG9pc29uIGFuZCBwcm9wYWdh
dGUgdGhlDQo+PiBuZXcgQVBJIHN1cHBvcnQgdG8gZWFjaCBkbSB0YXJnZXRzIHRoYXQgc3VwcG9y
dCBkYXggd2hpY2gsIGFnYWluLA0KPj4gaXMgYW4gaWRlYSB0aGF0IHNvdW5kcyB0b28gYnVsa3kg
aWYgSSByZWNhbGwgRGFuJ3MgZWFybGllciByZWplY3Rpb24NCj4+IGNvcnJlY3RseS4NCj4gDQo+
IFdoZW4gSSB3cm90ZSB0aGUgYWJvdmUgSSBtb3N0bHkgdGhvdWdodCBhYm91dCB0aGUgaW4ta2Vy
bmVsIEFQSSwgdGhhdA0KPiBpcyB1c2UgYSBzZXBhcmF0ZSBtZXRob2QuICBCdXQgcmVhZGluZyB5
b3VyIG1haWwgYW5kIHRoaW5raW5nIGFib3V0DQo+IHRoaXMgYSBiaXQgbW9yZSBJJ20gYWN0dWFs
bHkgbGVzcyBhbmQgbGVzcyBzdXJlIHRoYXQgb3ZlcmxvYWRpbmcNCj4gcHdyaXRldjIgYW5kIHBy
ZWFkdjIgd2l0aCB0aGlzIGF0IHRoZSBzeXNjYWxsIGxldmVsIG1ha2VzIHNlbnNlIGVpdGhlci4N
Cj4gcmVhZC93cml0ZSBhcmUgb3VyIEkvTyBmYXN0IHBhdGguICBXZSByZWFsbHkgc2hvdWxkIG5v
dCBvdmVybG9hZCB0aGUNCj4gY29yZSBvZiB0aGUgVkZTIHdpdGggZXJyb3IgcmVjb3ZlcnkgZm9y
IGEgYnJva2VuIGhhcmR3YXJlIGludGVyZmFjZS4NCj4gDQoNClRoYW5rcyAtIEkgdHJ5IHRvIGJl
IGhvbmVzdC4gIEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgYXJndW1lbnQNCmFib3V0IHRoZSBm
bGFnIGlzIGEgcGhpbG9zb3BoaWNhbCBhcmd1bWVudCBiZXR3ZWVuIHR3byB2aWV3cy4NCk9uZSB2
aWV3IGFzc3VtZXMgZGVzaWduIGJhc2VkIG9uIHBlcmZlY3QgaGFyZHdhcmUsIGFuZCBtZWRpYSBl
cnJvcg0KYmVsb25ncyB0byB0aGUgY2F0ZWdvcnkgb2YgYnJva2VubmVzcy4gQW5vdGhlciB2aWV3
IHNlZXMgbWVkaWENCmVycm9yIGFzIGEgYnVpbGQtaW4gaGFyZHdhcmUgY29tcG9uZW50IGFuZCBt
YWtlIGRlc2lnbiB0byBpbmNsdWRlDQpkZWFsaW5nIHdpdGggc3VjaCBlcnJvcnMuDQoNCkJhY2sg
d2hlbiBJIHdhcyBmcmVzaCBvdXQgb2Ygc2Nob29sLCBhIHNlbmlvciBlbmdpbmVlciBleHBsYWlu
ZWQNCnRvIG1lIGFib3V0IG1lZGlhIGVycm9yIG1pZ2h0IGJlIGNhdXNlZCBieSBjb3NtaWMgcmF5
IGhpdHRpbmcgb24NCnRoZSBtZWRpYSBhdCBob3dldmVyIGZyZXF1ZW5jeSBhbmQgYXQgd2hhdGV2
ZXIgdGltaW5nLiAgSXQncyBhbg0KYXJndW1lbnQgdGhhdCBtZWRpYSBlcnJvciB3aXRoaW4gY2Vy
dGFpbiByYW5nZSBpcyBhIGZhY3Qgb2YgdGhlIHByb2R1Y3QsDQphbmQgdG8gbWUsIGl0IGFyZ3Vl
cyBmb3IgYnVpbGRpbmcgbm9ybWFsIHNvZnR3YXJlIGNvbXBvbmVudCB3aXRoDQplcnJvcnMgaW4g
bWluZCBmcm9tIHN0YXJ0LiAgSSBndWVzcyBJJ20gdHJ5aW5nIHRvIGFydGljdWxhdGUgd2h5DQpp
dCBpcyBhY2NlcHRhYmxlIHRvIGluY2x1ZGUgdGhlIFJXRl9EQVRBX1JFQ09WRVJZIGZsYWcgdG8g
dGhlDQpleGlzdGluZyBSV0ZfIGZsYWdzLiAtIHRoaXMgd2F5LCBwd3JpdGV2MiByZW1haW4gZmFz
dCBvbiBmYXN0IHBhdGgsDQphbmQgaXRzIHNsb3cgcGF0aCAody8gZXJyb3IgY2xlYXJpbmcpIGlz
IGZhc3RlciB0aGFuIG90aGVyIGFsdGVybmF0aXZlLg0KT3RoZXIgYWx0ZXJuYXRpdmUgYmVpbmcg
MSBzeXN0ZW0gY2FsbCB0byBjbGVhciB0aGUgcG9pc29uLCBhbmQNCmFub3RoZXIgc3lzdGVtIGNh
bGwgdG8gcnVuIHRoZSBmYXN0IHB3cml0ZSBmb3IgcmVjb3ZlcnksIHdoYXQNCmhhcHBlbnMgaWYg
c29tZXRoaW5nIGhhcHBlbmVkIGluIGJldHdlZW4/DQoNCnRoYW5rcyENCi1qYW5lDQoNCg0KDQoN
Cg0KDQoNCg==
