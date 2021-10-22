Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1900F436F84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhJVBnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:43:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20514 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhJVBnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:43:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LNifU4010955;
        Fri, 22 Oct 2021 01:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eFrrxr4RBbNdFO+LqEiAPhmSQDQR+j48obrGpSw6VAU=;
 b=mM9Rlmwls1wty713GCKKgDYwfg5kg60Do7fxNz73VTXpaD/bLzku2u6V/ZV/ASFEdtM+
 LxCbXhFo8sjS9diTajymnx9TdhgN1jp9BX7ceHAtCm38muk7uKvZuyFsFQvvQcqvI9zK
 AgLp34J4JcUUVhIvn5X9EUlx8G/7M7/A4n0KJdgdBLeW/d9JE08x7n64P490NusKD0mr
 qcQpecYRj2sJyv3tz0kXJkCNLrKX6KEaN+xvM5HX/eI30xpWl7Ib9UliZ9c0yA0dkoag
 UreZ1r+/xCXcpD9lGYmF9xVmLzInLcVJk1q/I2Np/2ohe10gWQFQtotyBUQWB9/7Dj5+ /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqyprjfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 01:41:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19M1VeS3084304;
        Fri, 22 Oct 2021 01:41:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3bqkv2wm1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 01:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9mJTl0pRfuz8wAwmdTI64feYBCinFPt4ZxstKHhWA1Hb+QdCCRK/8jZCk+IyuhSDept2ecvHRTWZ6NIMLlBxod0MRpO5DVY07EyFq+Q50oEeImI4IP2nD8o67hHg5iqKRlAW3BERX88OJ8uGzRmdc1gHgnpi2Q0Z/yboLW1YSPRD3SIxF8AZcPPrXx6p4mDWEWJdL3TwFQVODaup+foexHHVeI0nEcHakQOYJzBSUKT++cpD0VsrqHX2qUzNTBlrrWkoTxr4v3JGaYwqbKQ49V+Tt/OK5MNFghun+yo3+pMGn7srS9imXBnR0M49ykZJw85eyr8s1m3HlTDote4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFrrxr4RBbNdFO+LqEiAPhmSQDQR+j48obrGpSw6VAU=;
 b=OVciW6xRdiHfp55eaZc/wrw1GRdcFp9UB09zOf14+IqlhttLzhZ5Wbbn2GxsHFStspB15bwJoKGOZiEJ7HczdaWqz79PAMmg1DDP7aEYNxQdncsRsVPb9NuXGr5Xbb9EZHxtxufmkQCPiyXCWmc0p5bPccl8R7PfIZ/l7Biq/bZBluraMF3J6D0TFxnNuqA4rR1StBTHDw/dUxs+1eOX6J5jpMo2nsA6NMtrga+IAjv3nVwn3V3D4yw1SONRC48aNldp6rivjLpDjYGIfeVjqsw+0OLKYFh70hg5GdXRNKmQXEfvkptX79i5KJVxk1rlN84m25fuvH4tulECqsuDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFrrxr4RBbNdFO+LqEiAPhmSQDQR+j48obrGpSw6VAU=;
 b=b8nCEChdVhtCumy2/lSYxFLgs5HOQZubtqiRdjOc+6YXNFAeq6hEAgQC/w/VfkPx+zj/XMHc8AVRalL36EsDtsxlS+cV799dAEnEzNWFKTwVgL6hR5vpB02OndEGCw98S9DCkWTaz41NG7IIVOei23RoxPaxTN66enGqcJkS0vw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2518.namprd10.prod.outlook.com (2603:10b6:a02:b8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 01:41:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 01:41:16 +0000
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
Subject: correction: Re: [PATCH 4/6] dm,dax,pmem: prepare
 dax_copy_to/from_iter() APIs with DAXDEV_F_RECOVERY
Thread-Topic: correction: Re: [PATCH 4/6] dm,dax,pmem: prepare
 dax_copy_to/from_iter() APIs with DAXDEV_F_RECOVERY
Thread-Index: AQHXxhA/migZDNV1a0+SBofbRrgPHKvdURMAgADgEICAAA6KAA==
Date:   Fri, 22 Oct 2021 01:41:16 +0000
Message-ID: <63e13de0-9167-3176-4d7f-b127bdf9cc07@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-5-jane.chu@oracle.com>
 <YXFOlKWUuwFUJxUZ@infradead.org>
 <325baeaf-54f6-dea0-ed2b-6be5a2ec47db@oracle.com>
In-Reply-To: <325baeaf-54f6-dea0-ed2b-6be5a2ec47db@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e39ed84-8a1d-49c6-52b0-08d994fd0a1f
x-ms-traffictypediagnostic: BYAPR10MB2518:
x-microsoft-antispam-prvs: <BYAPR10MB251840E69BC536B2456819DFF3809@BYAPR10MB2518.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rtzLkF1U+Nk9gDgTiN48YUU5QlA+5Q6JzLcq+698RN6bWEG6d1LArbm4btGJRIJszC/Gos6/ji84A0LjBA928X4hQM8xcpK0sI+2npb15cEv9efC4SoNOxoU/AsCk/tqRzPvCnFUmi3EMgZ+vLtrmgbz2RAuiXeOBnXtVJJOtrJAAeYO6+CA3tVtrarrzCKFcPpvlEeOIiSsnaoqaxLpAEr6IHz1iEiZ2Sa+rfI9T6RHfIY/CxPjNvFDFm/mwo6eX0KnS33QVZUW1W3oig/MpE+Gr8moz/HaSWffHusD0U+nUHFV4sJAj6QW3TVO8wugrCrk4EkgURtmisuCLigS0DJOgyVbhhGoR98Mh9wscZIQAK2EIQweHeyyBXM905S1zBAEXzETJc8yAJlmZEC65Iy7O09W6vhfjKiGhv9nxyOWmMAu1uwSQCcaA4ZqAEuA5u5ra12ghQaRLfcfEjOSpiux5Ri7xigz3OjguF7j+lkbL5R84QFeWzfuGyxiOlB0nystRKeHOANJG6akxWJRu9ng1kn1cWgJ2S4QPb5WuIlcArYFhZLgBDiUb4Pqd4/T3MAxu+AFvIas4HAPk5CXQysyWl3W//Ye3BGUZTs2iB6IZX7qAJR7ZI90HPxLyfLlcFdyAblJH2S3VZlxbohoyMu6AhAptW7HY46srmfk3CW2V2dp8uVf0pWLm5B8H5H5GXbsmRuY+D5K/Mby3nU/I424dFuKSftwFU8hb1s8ppSrN/IaxW6W5rfRkL51CO8E28SdBykuDsU8B3oTJ0R8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66476007)(508600001)(2616005)(186003)(36756003)(66946007)(71200400001)(66446008)(5660300002)(4326008)(26005)(31686004)(2906002)(7416002)(91956017)(44832011)(66556008)(76116006)(6916009)(31696002)(53546011)(8676002)(316002)(38070700005)(38100700002)(6512007)(122000001)(6506007)(86362001)(8936002)(83380400001)(6486002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0RnU1VNOStxZno3dmdLcEhNVWs3Vy9XK1Z6eEE5aFcxVS9BWDBXdnpJQzhD?=
 =?utf-8?B?Wnk0Nmljc1gzNVlIbkpSeUtOZ3pINm9yYTFwTkpJNklmdmtLWHNTRDg4YmJM?=
 =?utf-8?B?K1VKRWZFR0Z6cTVFUVJ5TWt1cWpPR3J4V0k5R0VvZEVSVEtUaEF3cVRveFIy?=
 =?utf-8?B?OG1QZ0lpZ1BVRzlSWUZ6SVNRV0dEbFI2VmdHNnlFZUdCYkZoR2U2SXppSWha?=
 =?utf-8?B?M09jTzdVSUJ3b0dxVjN2MjgzeHBwdjZBamhBcXRRd2pXYkRYVDMwdmNUdzd2?=
 =?utf-8?B?OUdPVklhYkw5M2l4U0ZCQ0dFZU1iekZ5RnM5NGVTSzJKMDBHMUswZDBUdHZL?=
 =?utf-8?B?ekZOUzZDQzlJUE93TDBycC90OGxoZFg1cUxMZVI4b09GNUU2YmVCVEp3dnBC?=
 =?utf-8?B?US9xcWlqNWlLS2JuNjl4bm5iTGE4a3MvaUZUdmk1b2RxRHNBb3F2RXVGeEhN?=
 =?utf-8?B?cGpNZkswbnlIRy9zTXlUNzVyMlJDREN3L05wU2lTR2tiSDlzS1JlSlAxUDgr?=
 =?utf-8?B?cktQVDB6ZFJ6RzhzS1A5N3hpWTA1b0FKK01jYUJpWFFiWW1YelZpRUc1VHQ4?=
 =?utf-8?B?ZTJDemNLNmo0eENvY3NHdzNCL1cvZWwyOXNFb0cwcktjVGdQZmwrb3U5eDM3?=
 =?utf-8?B?NzR4R3N6cE5UNFl2YU42YlF0Mk9Rc3lSb1pWOVBCTzJ1eDJLQmZXcFZ5NHdI?=
 =?utf-8?B?a21IeUpVYkJ4TVVxMHVmYjFSZzlCakFrU1E0UnNrc0UwbUFmNTNhbE9kUk1r?=
 =?utf-8?B?Y05zb0xmbW82TnljL2wxVWpDTkpCRjcvUXRmVTVRQlc3Yll2WjQ5R1YzaFFp?=
 =?utf-8?B?UGVMdW55akx0b0RSUHI3cExIMzlCY0xFVzNaUnZyZTRycE1SZEZhUXIvU3dU?=
 =?utf-8?B?UmhhMk9acTZ3RnhOdmVsdnp2NU5zN0gxTlhOVGV5T2tTZXpLZy9nRTZpMVZ4?=
 =?utf-8?B?UFRNUE9iL1VzZytkYVFjc1Z1OC8xampRbmRSaFdjeDhOcGVUZ2ludG9aTW9J?=
 =?utf-8?B?aVRhNmgzTHJSNS9Wc2RpTjk0emRpaGozWFE5MU8zelp6NjAyTVV2UTNwTHht?=
 =?utf-8?B?cE4vRWVlRHdxM3JHRHlzL3ZNaFU2VGFRc2xTU1B2WVpmYmNHWkNNbS9ianBT?=
 =?utf-8?B?eGVJam9QUWpYeWVTNlYwRUtaTE5pdmVmN05XQmFVOWxuTXM0N2oyOWVDV0xX?=
 =?utf-8?B?SGpEWjNuS3JHK0lEVGlwWlNsU0RaUStQbVYrVklQUVd4UHBOSjkxMTltcE9j?=
 =?utf-8?B?TXk5aG1TZ1QrQ0JTd3h6RFRWKytUVjRCbG95dDBjQjNGblNCNFVKYlB1LzFx?=
 =?utf-8?B?Y01xVHRvN2RaMjJxTmVNWjQrOFVvencvK2dSMFIrZ2tITlNNVS9TK2Fmd0xG?=
 =?utf-8?B?bjZiblZCc3duOWsyTkRwQlJlN1JOV3B6WmlUREZpYlExYnRBRHJESzQzZzFo?=
 =?utf-8?B?U2g3aWhHTFpTZDBEdFBWM085QTR3cXMrTlFzbjB1TEZRazFLalM3K2locmpC?=
 =?utf-8?B?aHZwa2lHVUpvRE1icUVHZHlaVThiSHJWWG5uSStvczJYbkFKWEpBTFJNSElW?=
 =?utf-8?B?NVBvayt3aW5ndDlaeEpkQWJuSUkrc3hZeEJ6WUY3VkZZZ2ZwUjVCcEdwM2NK?=
 =?utf-8?B?d0p6K0xkdzE1RXRneExBZU43ZXJyemNpblNyeXAwV041VVdhY3RpbUl2S2Yr?=
 =?utf-8?B?SmRnZm9jT2hvRTFFaHhNYUZuWlJteHZva2dhK1RNNEwvbzZ4ZUswUEdnVFV1?=
 =?utf-8?B?MzZRWWE4dUxlQkgyOWpzWERGa2tPQy8zNXJKSnNzOGcxN0dVRC8zWmRQaXVn?=
 =?utf-8?B?UndnVFNrYVFPS3FyckRvUnBGb0lHdFJoUTJkYm5ZSnMxZldlUXVydVNkZGNS?=
 =?utf-8?B?MTM5WU11c1IrbTgyMWk5THFmbFRTVWZ6WnRQZHBiTTNZT1RXd3pZNXQwY2Fs?=
 =?utf-8?Q?V/BXhUYGhow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6D15D8636F3B49AFDB786F5470921E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e39ed84-8a1d-49c6-52b0-08d994fd0a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 01:41:16.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2518
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220006
X-Proofpoint-ORIG-GUID: pyz1KEocIsiAEUmg7QYwNsXKM12udw-e
X-Proofpoint-GUID: pyz1KEocIsiAEUmg7QYwNsXKM12udw-e
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSA1OjQ5IFBNLCBKYW5lIENodSB3cm90ZToNCj4gT24gMTAvMjEvMjAyMSA0
OjI3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IE9uIFdlZCwgT2N0IDIwLCAyMDIx
IGF0IDA2OjEwOjU3UE0gLTA2MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+IFByZXBhcmUgZGF4X2Nv
cHlfdG8vZnJvbV9pdGVyKCkgQVBJcyB3aXRoIERBWERFVl9GX1JFQ09WRVJZIGZsYWcNCj4+PiBz
dWNoIHRoYXQgd2hlbiB0aGUgZmxhZyBpcyBzZXQsIHRoZSB1bmRlcmx5aW5nIGRyaXZlciBpbXBs
ZW1lbnRhdGlvbg0KPj4+IG9mIHRoZSBBUElzIG1heSBkZWFsIHdpdGggcG90ZW50aWFsIHBvaXNv
biBpbiBhIGdpdmVuIGFkZHJlc3MNCj4+PiByYW5nZSBhbmQgcmVhZCBwYXJ0aWFsIGRhdGEgb3Ig
d3JpdGUgYWZ0ZXIgY2xlYXJpbmcgcG9pc29uLg0KPj4NCj4+IEZZSSwgSSd2ZSBiZWVuIHdvbmRl
cmluZyBmb3IgYSB3aGlsZSBpZiB3ZSBjb3VsZCBqdXN0IGtpbGwgb2ZmIHRoZXNlDQo+PiBtZXRo
b2RzIGVudGlyZWx5LiAgQmFzaWNhbGx5IHRoZSBkcml2ZXIgaW50ZXJhY3Rpb24gY29uc2lzdHMg
b2YgdHdvDQo+PiBwYXJ0czoNCj4+DQo+PiAgICBhKSB3ZXRoZXIgdG8gdXNlIHRoZSBmbHVzaGNh
Y2hlL21jc2FmZSB2YXJpYW50cyBvZiB0aGUgZ2VuZXJpYyBoZWxwZXJzDQo+PiAgICBiKSBhY3R1
YWxseSBkb2luZyByZW1hcHBpbmcgZm9yIGRldmljZSBtYXBwZXINCj4+DQo+PiB0byBtZSBpdCBz
ZWVtcyBsaWtlIHdlIHNob3VsZCBoYW5kbGUgYSkgd2l0aCBmbGFncyBpbiBkYXhfb3BlcmF0aW9u
cywNCj4+IGFuZCBvbmx5IGhhdmUgYSByZW1hcCBjYWxsYmFjayBmb3IgZGV2aWNlIG1hcHBlci4g
IFRoYXQgd2F5IHdlJ2QgYXZvaWQNCj4+IHRoZSBpbmRpcmVjdCBjYWxscyBmb3IgdGhlIG5hdGl2
ZSBjYXNlLCBhbmQgYWxzbyBhdm9pZCB0b25zIG9mDQo+PiBib2lsZXJwbGF0ZSBjb2RlLiAgImZ1
dGhlciBkZWNvdXBsZSBEQVggZnJvbSBibG9jayBkZXZpY2VzIiBzZXJpZXMNCj4+IGFscmVhZHkg
bWFzc2FnZXMgdGhlIGRldmljZSBtYXBwZXIgaW50byBhIGZvcm0gc3VpdGFibGUgZm9yIHN1Y2gN
Cj4+IGNhbGxiYWNrcy4NCj4+DQo+IA0KPiBJJ3ZlIGxvb2tlZCB0aHJvdWdoIHlvdXIgImZ1dGhl
ciBkZWNvdXBsZSBEQVggZnJvbSBibG9jayBkZXZpY2VzIiBzZXJpZXMNCj4gYW5kIGxpa2VzIHRo
ZSB1c2Ugb2YgeGFycmF5IGluIHBsYWNlIG9mIHRoZSBob3N0IGhhc2ggbGlzdC4NCj4gV2hpY2gg
dXBzdHJlYW0gdmVyc2lvbiBpcyB0aGUgc2VyaWVzIGJhc2VkIHVwb24/DQo+IElmIGl0J3MgYmFz
ZWQgb24geW91ciBkZXZlbG9wbWVudCByZXBvLCBJJ2QgYmUgaGFwcHkgdG8gdGFrZSBhIGNsb25l
DQo+IGFuZCByZWJhc2UgbXkgcGF0Y2hlcyBvbiB5b3VycyBpZiB5b3UgcHJvdmlkZSBhIGxpbmsu
IFBsZWFzZSBsZXQgbWUNCj4ga25vdyB0aGUgYmVzdCB3YXkgdG8gY29vcGVyYXRlLg0KPiANCj4g
VGhhdCBzYWlkLCBJJ20gdW5jbGVhciBhdCB3aGF0IHlvdSdyZSB0cnlpbmcgdG8gc3VnZ2VzdCB3
aXRoIHJlc3BlY3QNCj4gdG8gdGhlICdEQVhERVZfRl9SRUNPVkVSWScgZmxhZy4gIFRoZSBmbGFn
IGNhbWUgZnJvbSB1cHBlciBkYXgtZnMNCj4gY2FsbCBzdGFjayB0byB0aGUgZG0gdGFyZ2V0IGxh
eWVyLCBhbmQgdGhlIGRtIHRhcmdldHMgYXJlIGVxdWlwcGVkDQo+IHdpdGggaGFuZGxpbmcgcG1l
bSBkcml2ZXIgc3BlY2lmaWMgdGFzaywgc28gaXQgYXBwZWFycyB0aGF0IHRoZSBmbGFnDQoNCkFw
b2xvZ2llcy4gVGhlIGFib3ZlIGxpbmUgc2hvdWxkIGJlDQoiLi4uLCBhbmQgdGhlIGRtIHRhcmdl
dHMgYXJlIF9ub3RfIGVxdWlwcGVkIHdpdGggaGFuZGxpbmcgcG1lbSBkcml2ZXINCnNwZWNpZmlj
IHRhc2ssIg0KDQotamFuZQ0KDQoNCj4gd291bGQgbmVlZCB0byBiZSBwYXNzZWQgZG93biB0byB0
aGUgbmF0aXZlIHBtZW0gbGF5ZXIsIHJpZ2h0Pw0KPiBBbSBJIHRvdGFsbHkgbWlzc2luZyB5b3Vy
IHBvaW50Pw0KPiANCj4gdGhhbmtzLA0KPiAtamFuZQ0KPiANCg0K
