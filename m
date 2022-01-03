Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010948378C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 20:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiACT2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 14:28:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37116 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236147AbiACT2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:28:45 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203IjReB003342;
        Mon, 3 Jan 2022 19:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9uvCNT/GK0PwhJglkTrbegZwXNZGgmKJwPBkhcP+bk8=;
 b=NdBXI6XqyPIho8tmgKXefN2c73NU2e3AYowdE79cN1E4EuLZ7AJSopKq8ySqsaSvhNVT
 xJigiF5RmUGOsrSNb+RIiud491Tr00qcWPHm85rax7Y6IHk5cxzApCTAK+bAfj9m8tAP
 y/0tTln1PKULrE1gZhSKGwzRmOVyP9bKk5AsAum0FrEJTg8LLTUMJxjuS/5sRVWybpG+
 itvgPzmv4iUL6rNW3yY8mZmsw16/4pwZE/bJK0Da9RKoqIqP5pDUeOGPbwduW6wLOAi/
 lFYV0eUUvvVvG9qOIl6N9xkAE3ZoLI6LfMFaqCPInMHxEImlRsJTbOFGgq4N+paGgpdQ Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4ghd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 19:28:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203JFXNK076006;
        Mon, 3 Jan 2022 19:28:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3daes2p99s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 19:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3ESwMyIeHz4nb/kFfYBBeHh/4G2GikeSbTQxx0DbICAicwJwamYkQflAmHVi3k9vV3ilPCAOlgl5vruqQgsa0t2oto1z8m5TqvLTaWVE4+6Q5m9iwKnOWotCXlfNv2tfrC9lxFveutXdH7KZH/VtoBxapjx8lmGoUpaTDZyXx3EwKofYI556+Z0BTg8nIjvaobbuLVFjYL1P33CBMCF3cahEeY0yVb9XQDjknR7nrqAJ/cfYEYD3OeJMs4nujH07tyrdWqahLFXHKHiyjNj0Xt1r/Uau8/F1w9cYxR8PRPrHJGDsbF2+ak446ZJHl9TzD69qUmN8DJfldap6PJ5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uvCNT/GK0PwhJglkTrbegZwXNZGgmKJwPBkhcP+bk8=;
 b=kIzXkhVcYGNjiNjtm6r2XGn+qVo8ECeb0wmZl/48gxk6od/z4DS4PNxDQpXn6x5pUYCpPWXDPTkMSDLI+8P/qOTgnoul0nqdaqW2EfIOZ/iTykA4xRIMi8Zx9o3vqENqJ0dvbTJbCRGe3g1oHfeeR2AoPJ80+Z20DoZJzeIuo6BFRWAMVxEqjmACXED4e87gPhHAjGjr37fhRuqSzX4VuZZ4zAolm5UAvfLa/SaXk820rHqqnH+kmWhduA4gEaafok7nMT21cLPx3ImjDKvPFDcDhmkcqMhn/Lel38ykprDLEMf670UTgSoJxOCqD7pOySQAxRfSXxrbZsXBcQBd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uvCNT/GK0PwhJglkTrbegZwXNZGgmKJwPBkhcP+bk8=;
 b=JyCRp1DXjkx6ZV1jZWy+abHh8ktqTCXNkiZqEuJTQgSekogxFc5LMFECbKWldWMqoFGjEtVGWY0RvzTlS9tV3PYCG8zq+DgTmmYOvKJ9/82dpjE/zpdgLuO5lSRRNlprW4mbcR6nzNew4EL/ZWX5b8snT80U5EyDiN3Y1wHaPG4=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2877.namprd10.prod.outlook.com (2603:10b6:805:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 19:28:33 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:28:33 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 00/48] Folios for 5.17
Thread-Topic: [PATCH 00/48] Folios for 5.17
Thread-Index: AQHX6/80rg9MDEdb8U2tokmUet0pZaxFdzoAgAsy6wCAAS4Neg==
Date:   Mon, 3 Jan 2022 19:28:33 +0000
Message-ID: <AA189F68-386F-4D7B-9758-B1F0F34D515F@oracle.com>
References: <20211208042256.1923824-1-willy@infradead.org>
 <D0BCCF0D-FCC6-4A36-8FC9-D5F18072E50A@oracle.com>
 <YdJRAC0ksaDW9M4Z@casper.infradead.org>
In-Reply-To: <YdJRAC0ksaDW9M4Z@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b6d7b2b-643b-465c-df3f-08d9ceef3b1a
x-ms-traffictypediagnostic: SN6PR10MB2877:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2877246ED5B788A88531A81381499@SN6PR10MB2877.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ce8H/S7rjWG3kkAYZvKvm5WYTWn3wIXHgtaLDmPMZdR51+EdlRcVf3TxhuoZpnFA3hfqgI6489d7HAT8mqSYPISF9fnDExd7FMY9EcLM27/AtzQwChng3TmmMNJX94vT98Kl71+DCLspAAbxSvEzB8tqxd3IkTJhPwkRxGRl+/beIkjP8w8N/+8RZOSyemYnZGyj+lh/e23mR69f1EksXzWz9RD39/gRwM1d3acjt1NwBlqhr5bw4uHR/hXHQUvXzl2Ysj3E77rq3tNevIRx//I07S3GgyOJVgAQ6x+BNk81/5BIExH8Am5jVk1xruph+9H7zd2STtiGCGc1r0MVWVnKZhEQiDLJ5dSXHDyvbECZ0ub9ZvJutz2wV2pV4tv66wrHJXHjtCLguxqxRRTxoMSVrCW6NAW3mIKK5k0/y6frWi1c9+q1GYRjEgDFvddFNQulS2yFRtEG6npe9R34koSbJoSoFoJc6HR6zhsMmPUcBhrsUGqC735BQ/T0Ufmw0Rv98xjaMF9N+MlkEOc5yGe7mHdJX6ScrNbSuG+v4Gb9DlFtsiFtScTjP//tk6brts/5OGvn+Tou4yuIs4rk9T9FWy82rBW3Xt6eT1Zf1D1B7Z1mQjsho6ZfmhvZESWGyrcMmtc1eiTqkPUp6Xwo0W7rDF5URXSJ+a3cWV9yQ1jKCKp/QOqJLfPcH+aTXHpJMz8O+wKy9sQxsQuqhW9uGfVX8EYiPgkH1tJN8wqi6hA5aErVTcKl9oOyW/VkfWMHaglSO4NynwDkZkdc+Xv4YKXX52XfNqyxilXcmLSDVr7LYkpAkIIeuNtRqTjbgR4V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6506007)(71200400001)(83380400001)(53546011)(38100700002)(6512007)(66946007)(64756008)(36756003)(2906002)(33656002)(122000001)(8676002)(6486002)(8936002)(44832011)(2616005)(5660300002)(76116006)(91956017)(54906003)(316002)(966005)(6916009)(186003)(508600001)(66556008)(38070700005)(66446008)(66476007)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1R2MHVrb3NESEZWVHhIWW1RRXM0SFlEOXNzVmlRSCtJTEVmaDhoeHI1Ync1?=
 =?utf-8?B?ODh4cVhKNHFhWWJKckdTNUZ1S2ZtTUk5TkJ2ZzBSUlBKVTZlMk1jMklRUmRk?=
 =?utf-8?B?Z3dLK2RkT1lxYnliSC9FTmtBRWptRjRSNjZ0NVNTamwvaVg1TDhuYUpKQlY2?=
 =?utf-8?B?Y2V2V2xjdGtJNzRHZkpDaDVWV2pBcEtRWW1rRnZzVUVCSzV0WUg0bllJVjlZ?=
 =?utf-8?B?MSsvUkRibWFLbFlNWXIxUGRhTDVlRWtxMjFqRm1UM1pPU3lwaHQrM3Q2ODk1?=
 =?utf-8?B?cnFVb3FLTjBXRDF5Z3dmSE5pSy96dE9sL0xTR08wZy9zVm5oRmF6QXRtb256?=
 =?utf-8?B?SGtUbHYvN1p0Sjh5N3g4aFdiNXhvS2VYeFFxVG9zWTVDbzRsQ2hSWkJaTkVB?=
 =?utf-8?B?QWFwNGZreG5hNzdxTFE5Tm1RWjFid0Z1ckpnaTE3WTdCVVo0cWcrWmltdXoz?=
 =?utf-8?B?UFJ2NjVPc0hSbk1UOWRQcDE4N3VtWDU1YmcxdUNsekNsODRucVJLTjhzbHEr?=
 =?utf-8?B?bjIwbGlvWk01c3RwSDU2bzNydkF4WDNLV1Q4ZU5Wd3l2MjV4VzZxc0t6VStz?=
 =?utf-8?B?N0RlNlZXUU1QSFV2ZG9qNmZZVWVTeGczTlBEOEwxUWo4Y2lWd3BtZ1FmQkky?=
 =?utf-8?B?TU55bGplanAxYUNYQkcraDlDQm8xUkp0cnRDWlhZZGpybFlvZFU3eTRob1pj?=
 =?utf-8?B?VUEzVEhGL3M5cWZsSHEydmU3cmNrbUwvajhZVFVvRERMTGR4RENWV09raFFZ?=
 =?utf-8?B?TWN1REpFblFhMTZQc3RBNHQ1RHFoVHlZNi9QT2ZrcWk3MldRSDlkT2VIL0Mx?=
 =?utf-8?B?dE14NS9PSTNhYWQrQmZtc0FrQVBOclVNTTF5aGo4aWZTUVFrTWdRVzhlUTBk?=
 =?utf-8?B?MEI2c0lkb3pBblBjMk9xYXBIT2wwdmpvWnlLUG9EdFFSODMrUHowTHVQZGp2?=
 =?utf-8?B?Q1pSRVBnMGJoNmZ6bENDZFExQThMKzJQVm53b1NqVE1iUjNscmx5eFJublZo?=
 =?utf-8?B?OGV6M1h2R1Z3QllaMDlsUEUwTllScjYxc0NhN3d6VXpFbE83S0VZcnN5Y2xh?=
 =?utf-8?B?c2Y5ZC9KRCtZMVRuN0o1WHltY1c3U21KanJ5aHY4eFFWNlc0eHlHNm83QS9T?=
 =?utf-8?B?K2dXWHVqSWlnTFhwUTZzZDczN0lqajBFVXlCUDV5Vzc0U1diNGxDbldPWS84?=
 =?utf-8?B?OXpDVWRPVVk2d3NLMDA3ZjZyUGJFc3Z5K0FHellMV043VW1QY29VWjdpZHhy?=
 =?utf-8?B?WWptTzVEaTNlMi9oOWNpVW9FM0wzVXFqU2hRQXlqdW92MERXRjZKQXcvbUhj?=
 =?utf-8?B?bjlhM2toM1kyNmE2d3QrUXZYaHJ1cFZJWGtRYTh6QVFya3N3RUdwMzl4TnZl?=
 =?utf-8?B?ZE5SMlkzVTlhRHNhSTk4NElHQ2lOWDM4d1NEZUkzOGZuUFNzS1B1NzFZMThX?=
 =?utf-8?B?M2dwdzJJRWFqQk1kQ0RkY1I3a3h0UEJmTDBxQmtoODVWTHVhY3JYK1ZKYnJw?=
 =?utf-8?B?UXdWZVJlamdLRmNDWC9qaWQxc1FhV0VZZGt0amk3TGsxL0twakMrd2p3cVMy?=
 =?utf-8?B?M2xLc2JSemxYcDF2QWc0enhmeURPZE15NjFWdEJYanV6ZXEyQTQrblpUZlR1?=
 =?utf-8?B?cWlkM2lwMXkvZXFMR3R2TDkvZW1YZDlwTDVqa1BrOFRiNG5xMHIyeVF2b3lS?=
 =?utf-8?B?THVnWkw3U1hpdWozYmN5WWhtb1NKSVN4SVIyT2lwME1SYkFYQVVuWE9QakVm?=
 =?utf-8?B?T3pwSFpjdnE2b1JXMlZLbXhEZ2t3cmpwR0V5cXZOdzJaMkViUE9pVG91R1Mv?=
 =?utf-8?B?STdYTmJ1dDNtbjRzbldmWGZtY2s5U3NoaUZrMHZlcjdRWVZsb1ZvZGJxTWtk?=
 =?utf-8?B?WFQ4Y1ZXTXpVdG5JNjFaVjZ1cm5YR3V0ZFMxU1crMFBFTnRrRisxY081czkz?=
 =?utf-8?B?Mm83akZEaWNsTjE4d3dFS3NWZnJIcnhxYWNXZStvK2Y1TVNQYlRUUkJZcDdZ?=
 =?utf-8?B?S2IxTFZWakx2YlRRM3hLY0kwbk50K3RkSmU0Z25IVEhBNG83MzVrMHRyMCtn?=
 =?utf-8?B?M0haQWxqd3EwQ1FWWDMrTGhIaDdvOVhzZlRhbFZUNHh6MTc1OUpuc21QOFdm?=
 =?utf-8?B?YW5uRU5RT1pnN2V4WCtmZ01XMFQ2WVNaSVJRWWdwc0psZnB4R2dZMEdDamg3?=
 =?utf-8?B?VGhURFIwYmY0aUxqZ1lnTHZwUUZUdWE5a0VJYmJ0Q0k3bklVYnM3ek9FeCs2?=
 =?utf-8?B?b0Fya3c1V09HdnVwTEd5ekdETDZZVVlWVTVIQVBsS21LeFI4OXJRQmhLc1Za?=
 =?utf-8?B?UTI1M2NUWGJDbk5NYkZmOUhBUWh1VEdlQVFnVXJhaGhnVVN4Q3Nudz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6d7b2b-643b-465c-df3f-08d9ceef3b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 19:28:33.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qx8qTxv5kmzG8jOY7pEoFukK5x0Zp9Kojj+1lQIqDvvLcQGQ/J/Gaodc6hjSNVudS/DgiZ3MThxCp/kRPxYBdibnW34RqIY03rlCmkZf2C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2877
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030132
X-Proofpoint-GUID: SEpzh0-GRDfhb6FMfscztxQ8E7LOoFr2
X-Proofpoint-ORIG-GUID: SEpzh0-GRDfhb6FMfscztxQ8E7LOoFr2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzLg0KDQpJIGxpa2UgeW91ciBjaGFuZ2VzIGFuZCB3aWxsIGRlZmVyIHRvIHlvdSBvbiB0
aGUgcGVyaW9kIGFuZCBPeGZvcmQgY29tbWEuIDotKQ0KDQo+IE9uIEphbiAyLCAyMDIyLCBhdCAx
ODoyNywgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4g
77u/U29ycnkgSSBtaXNzZWQgdGhpcyB3aGlsZSB0cmF2ZWxsaW5nLg0KPiANCj4+IE9uIFN1biwg
RGVjIDI2LCAyMDIxIGF0IDEwOjI2OjIzUE0gKzAwMDAsIFdpbGxpYW0gS3VjaGFyc2tpIHdyb3Rl
Og0KPj4gQ29uc29saWRhdGVkIG11bHRpcGxlIHJldmlldyBjb21tZW50cyBpbnRvIG9uZSBlbWFp
bCwgdGhlIG1ham9yaXR5IGFyZSBuaXRzIGF0DQo+PiBiZXN0Og0KPj4gDQo+PiBbUEFUQ0ggMDQv
NDhdOg0KPj4gDQo+PiBBbiBvYm5veGlvdXNseSBwZW5kYW50aWMgRW5nbGlzaCBncmFtbWFyIG5p
dDoNCj4+IA0KPj4gKyAqIGxvY2spLiAgVGhpcyBjYW4gYWxzbyBiZSBjYWxsZWQgZnJvbSBtYXJr
X2J1ZmZlcl9kaXJ0eSgpLCB3aGljaCBJDQo+PiANCj4+IFRoZSBwZXJpb2Qgc2hvdWxkIGJlIGlu
c2lkZSB0aGUgcGFyZW4sIGUuZy46ICJsb2NrLikiDQo+IA0KPiBUaGF0J3MgYXQgbGVhc3QgZGVi
YXRhYmxlLiAgVGhlIGZ1bGwgY29udGV4dCBoZXJlIGlzOg0KPiANCj4gWy4uLl0gQSBmZXcgaGF2
ZSB0aGUgZm9saW8gYmxvY2tlZCBmcm9tIHRydW5jYXRpb24gdGhyb3VnaCBvdGhlcg0KPiArICog
bWVhbnMgKGVnIHphcF9wYWdlX3JhbmdlKCkgaGFzIGl0IG1hcHBlZCBhbmQgaXMgaG9sZGluZyB0
aGUgcGFnZSB0YWJsZQ0KPiArICogbG9jaykuDQo+IA0KPiBBY2NvcmRpbmcgdG8gQVAgU3R5bGUs
IHRoZSBwZXJpb2QgZ29lcyBvdXRzaWRlIHRoZSBwYXJlbiBpbiB0aGlzIGNhc2U6DQo+IGh0dHBz
Oi8vYmxvZy5hcGFzdHlsZS5vcmcvYXBhc3R5bGUvMjAxMy8wMy9wdW5jdHVhdGlvbi1qdW5jdGlv
bi1wZXJpb2RzLWFuZC1wYXJlbnRoZXNlcy5odG1sDQo+IA0KPiBJJ20gc3VyZSB5b3UgY2FuIGZp
bmQgYW4gYXV0aG9yaXR5IHRvIHN1cHBvcnQgYWx3YXlzIHBsYWNpbmcgYSBwZXJpb2QNCj4gaW5z
aWRlIGEgcGFyZW4sIGJ1dCB3ZSBkb24ndCBoYXZlIGEgY29udHJvbGxpbmcgYXV0aG9yaXR5IGZv
ciBob3cgdG8NCj4gcHVuY3R1YXRlIG91ciBkb2N1bWVudGF0aW9uLiAgSSdtIGdyZWF0IGZ1biBh
dCBwYXJ0aWVzIHdoZW4gSSBnZXQgZ29pbmcNCj4gb24gdGhlIHN1YmplY3Qgb2YgdGhlIE94Zm9y
ZCBjb21tYS4NCj4gDQo+PiBbUEFUQ0ggMDUvNDhdOg0KPj4gDQo+PiArICAgICAgIHVuc2lnbmVk
IGNoYXIgYXV4WzNdOw0KPj4gDQo+PiBJJ2QgbGlrZSB0byBzZWUgYW4gZXhwbGFuYXRpb24gb2Yg
d2h5IHRoaXMgaXMgIjMuIg0KPiANCj4gSSBnb3QgcmlkIG9mIGl0IC4uLiBmb3Igbm93IDstKQ0K
PiANCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgZm9saW9fYmF0Y2hfaW5pdChzdHJ1Y3QgZm9saW9f
YmF0Y2ggKmZiYXRjaCkNCj4+ICt7DQo+PiArICAgICAgIGZiYXRjaC0+bnIgPSAwOw0KPj4gK30N
Cj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBmb2xpb19iYXRjaF9jb3VudChz
dHJ1Y3QgZm9saW9fYmF0Y2ggKmZiYXRjaCkNCj4+ICt7DQo+PiArICAgICAgIHJldHVybiBmYmF0
Y2gtPm5yOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBmYmF0
Y2hfc3BhY2Uoc3RydWN0IGZvbGlvX2JhdGNoICpmYmF0Y2gpDQo+PiArew0KPj4gKyAgICAgICBy
ZXR1cm4gUEFHRVZFQ19TSVpFIC0gZmJhdGNoLT5ucjsNCj4+ICt9DQo+PiArDQo+PiArLyoqDQo+
PiArICogZm9saW9fYmF0Y2hfYWRkKCkgLSBBZGQgYSBmb2xpbyB0byBhIGJhdGNoLg0KPj4gKyAq
IEBmYmF0Y2g6IFRoZSBmb2xpbyBiYXRjaC4NCj4+ICsgKiBAZm9saW86IFRoZSBmb2xpbyB0byBh
ZGQuDQo+PiArICoNCj4+ICsgKiBUaGUgZm9saW8gaXMgYWRkZWQgdG8gdGhlIGVuZCBvZiB0aGUg
YmF0Y2guDQo+PiArICogVGhlIGJhdGNoIG11c3QgaGF2ZSBwcmV2aW91c2x5IGJlZW4gaW5pdGlh
bGlzZWQgdXNpbmcgZm9saW9fYmF0Y2hfaW5pdCgpLg0KPj4gKyAqDQo+PiArICogUmV0dXJuOiBU
aGUgbnVtYmVyIG9mIHNsb3RzIHN0aWxsIGF2YWlsYWJsZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMg
aW5saW5lIHVuc2lnbmVkIGZvbGlvX2JhdGNoX2FkZChzdHJ1Y3QgZm9saW9fYmF0Y2ggKmZiYXRj
aCwNCj4+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPj4gK3sNCj4+ICsg
ICAgICAgZmJhdGNoLT5mb2xpb3NbZmJhdGNoLT5ucisrXSA9IGZvbGlvOw0KPj4gDQo+PiBJcyB0
aGVyZSBhbnkgbmVlZCB0byB2YWxpZGF0ZSBmYmF0Y2ggaW4gdGhlc2UgaW5saW5lcz8NCj4gDQo+
IEkgZG9uJ3QgdGhpbmsgc28/ICBBdCBsZWFzdCwgdGhlcmUncyBubyB2YWxpZGF0aW9uIGZvciB0
aGUgcGFnZXZlYw0KPiBlcXVpdmFsZW50cy4gIEknZCBiZSBvcGVuIHRvIGFkZGluZyBzb21ldGhp
bmcgY2hlYXAgaWYgaXQncyBsaWtlbHkgdG8NCj4gY2F0Y2ggYSBidWcgc29tZW9uZSdzIGxpa2Vs
eSB0byBpbnRyb2R1Y2UuDQo+IA0KPj4gW1BBVENIIDA3LzQ4XToNCj4+IA0KPj4gKyAgICAgICB4
YXNfZm9yX2VhY2goJnhhcywgZm9saW8sIFVMT05HX01BWCkgeyAgICAgICAgICAgICAgICAgIFwN
Cj4+ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxlZnQ7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4+IC0gICAgICAgICAgICAgICBpZiAoeGFzX3JldHJ5KCZ4YXMsIGhlYWQp
KSAgICAgICAgICAgICAgICAgICAgICBcDQo+PiArICAgICAgICAgICAgICAgc2l6ZV90IG9mZnNl
dCA9IG9mZnNldF9pbl9mb2xpbyhmb2xpbywgc3RhcnQgKyBfX29mZik7ICBcDQo+PiArICAgICAg
ICAgICAgICAgaWYgKHhhc19yZXRyeSgmeGFzLCBmb2xpbykpICAgICAgICAgICAgICAgICAgICAg
XA0KPj4gICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPj4gLSAgICAgICAgICAgICAgIGlmIChXQVJOX09OKHhhX2lzX3ZhbHVl
KGhlYWQpKSkgICAgICAgICAgICAgICAgIFwNCj4+ICsgICAgICAgICAgICAgICBpZiAoV0FSTl9P
Tih4YV9pc192YWx1ZShmb2xpbykpKSAgICAgICAgICAgICAgICBcDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+PiAt
ICAgICAgICAgICAgICAgaWYgKFdBUk5fT04oUGFnZUh1Z2UoaGVhZCkpKSAgICAgICAgICAgICAg
ICAgICAgXA0KPj4gKyAgICAgICAgICAgICAgIGlmIChXQVJOX09OKGZvbGlvX3Rlc3RfaHVnZXRs
Yihmb2xpbykpKSAgICAgICAgIFwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+IC0gICAgICAgICAgICAgICBmb3Ig
KGogPSAoaGVhZC0+aW5kZXggPCBpbmRleCkgPyBpbmRleCAtIGhlYWQtPmluZGV4IDogMDsgXA0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgaiA8IHRocF9ucl9wYWdlcyhoZWFkKTsgaisrKSB7ICAg
ICAgICAgICAgIFwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmthZGRyID0ga21h
cF9sb2NhbF9wYWdlKGhlYWQgKyBqKTsgICAgICAgIFwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGJhc2UgPSBrYWRkciArIG9mZnNldDsgICAgICAgICAgICAgICAgICBcDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICBsZW4gPSBQQUdFX1NJWkUgLSBvZmZzZXQ7ICAgICAgICAgICAgICAg
XA0KPj4gKyAgICAgICAgICAgICAgIHdoaWxlIChvZmZzZXQgPCBmb2xpb19zaXplKGZvbGlvKSkg
eyAgICAgICAgICAgIFwNCj4+IA0KPj4gU2luY2Ugb2Zmc2V0IGlzIG5vdCBhY3R1YWxseSB1c2Vk
IHVudGlsIGFmdGVyIGEgYnVuY2ggb2YgZXJyb3IgY29uZGl0aW9ucw0KPj4gbWF5IGV4aXQgb3Ig
cmVzdGFydCB0aGUgbG9vcCwgYW5kIGlzbid0IHVzZWQgYXQgYWxsIGluIGJldHdlZW4sIGRlZmVy
DQo+PiBpdHMgY2FsY3VsYXRpb24gdW50aWwganVzdCBiZWZvcmUgaXRzIGZpcnN0IHVzZSBpbiB0
aGUgIndoaWxlLiINCj4gDQo+IEhtbS4gIFRob3NlIGNvbmRpdGlvbnMgYXJlbid0IGxpa2VseSB0
byBvY2N1ciwgYnV0IC4uLiBub3cgdGhhdCB5b3UNCj4gbWVudGlvbiBpdCwgY2hlY2tpbmcgeGFf
aXNfdmFsdWUoKSBhZnRlciB1c2luZyBmb2xpbyBhcyBpZiBpdCdzIG5vdCBhDQo+IHZhbHVlIGlz
IFdyb25nLiAgU28gSSdtIGdvaW5nIHRvIGZvbGQgaW4gdGhpczoNCj4gDQo+IEBAIC03OCwxMyAr
NzgsMTQgQEANCj4gICAgICAgIHJjdV9yZWFkX2xvY2soKTsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgeGFzX2Zvcl9lYWNoKCZ4YXMsIGZvbGlvLCBV
TE9OR19NQVgpIHsgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGxlZnQ7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gLSAgICAgICAgICAg
ICAgIHNpemVfdCBvZmZzZXQgPSBvZmZzZXRfaW5fZm9saW8oZm9saW8sIHN0YXJ0ICsgX19vZmYp
OyAgXA0KPiArICAgICAgICAgICAgICAgc2l6ZV90IG9mZnNldDsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICBpZiAoeGFzX3JldHJ5KCZ4YXMsIGZv
bGlvKSkgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgY29u
dGludWU7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgICAgICAg
aWYgKFdBUk5fT04oeGFfaXNfdmFsdWUoZm9saW8pKSkgICAgICAgICAgICAgICAgXA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQo+ICAgICAgICAgICAgICAgIGlmIChXQVJOX09OKGZvbGlvX3Rlc3RfaHVnZXRsYihmb2xp
bykpKSAgICAgICAgIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICBicmVhazsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgICAgICAgICAgb2Zmc2V0ID0gb2Zm
c2V0X2luX2ZvbGlvKGZvbGlvLCBzdGFydCArIF9fb2ZmKTsgXA0KPiAgICAgICAgICAgICAgICB3
aGlsZSAob2Zmc2V0IDwgZm9saW9fc2l6ZShmb2xpbykpIHsgICAgICAgICAgICBcDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgYmFzZSA9IGttYXBfbG9jYWxfZm9saW8oZm9saW8sIG9mZnNldCk7
IFwNCj4gICAgICAgICAgICAgICAgICAgICAgICBsZW4gPSBtaW4obiwgbGVuKTsgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiANCj4+IFJldmlld2VkLWJ5OiBXaWxsaWFtIEt1Y2hhcnNraSA8d2ls
bGlhbS5rdWNoYXJza2lAb3JhY2xlLmNvbT4NCj4gDQo+IFRoYW5rcy4gIEknbGwgZ28gdGhyb3Vn
aCBhbmQgYWRkIHRoYXQgaW4sIHRoZW4gcHVzaCBhZ2Fpbi4NCj4gDQo=
