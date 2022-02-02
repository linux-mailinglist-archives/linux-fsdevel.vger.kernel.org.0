Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC44A7ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 23:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbiBBWDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 17:03:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17688 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347744AbiBBWDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:03:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212Kwl3x009905;
        Wed, 2 Feb 2022 22:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2fFI21VrGQl0CJl1zFlAH9Q4OLRybQ0S3JHrvONkodo=;
 b=DlJjbiy0je93jeZHYo9yv5sdlbKi2fX/Kslikk/9dXzPM6WQdFO6JQ591NzoDZdwr1Gn
 ekDX0TWr+Ct3wiF6z3RHeLk8XTl+oVnJulwZ3V2Vk9xxi17VlI815rWynpN57hYIJIG1
 pIxE3X+BotRWq6h+7oT1QPk4Akje8gzdbEVZrsMVn6IDyiEBVV7gtwLV58G9zf74huyo
 kX76RVTvtmwP8hUjMb+br3t84XGOXpVZ18xpxzHR9R6tdcBX9epy2TT/Fc2K3P8epYHL
 MyJM/Im+aqrw0qSLONH2sltxjzwKYna5ydYOz0lkFFhNdF0OGkBTe49yiRJIct093WPY /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac7d54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 22:03:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212M1SWv098035;
        Wed, 2 Feb 2022 22:03:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3dvtq3me2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 22:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnBPwbq46bQP8mBUqcx8fMRW1eYfvxEle/WJE5szll6M759GfHnC+Ue8ak701QRav+rlnMPBis2JnUbJTx5PIuq5nzvhvZr6hxTVR1iKfsczyp7GG5eQUZJzNWzklNtvHmjPQnJyZX8oSnqsFw0L+gmz2NkxkWYnWZ+qr00E/6/mzXIqtnXXFs/MEuE+lSNGqj5lbWnB8gulIcGTcDQdYrqcGLfAhYb9pnEDCNBMS1MuVaTrtvL6fNldUZAupWuejkMijvaYw+ex0qbpQDMP5OuF4D1TZKTQ4NJj8zF354I8PZbEpITS0swLXzg4k1WFsEySzH4AMEUKfzZB1mQy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fFI21VrGQl0CJl1zFlAH9Q4OLRybQ0S3JHrvONkodo=;
 b=RPUIUvx664l7dyKZjYmAEC7BmCN4kEqmHwWJBUNtxIQM3YHMv8mUKkAmsy0OEj6xNpqJkpFOCs2rAmZZ5zX5HIWTRmd2vTnvIEi6+X5au9YMchc8TByrvafTfbtJpY/f296DNHDV/ZcwpzZi4uOJvWF2FcBh3GgDeUR32P0EUwRnHmE8bJdafgQzqHvDk0Aqb0CgeYS21PEVh+Vmn9jDdX2HQqiftbyQ4r0ELxE4F97iJ+wiWa4DxVd36rBAOmNhhdJN6Q0UEtgFy65Xyn8yLM4kW9ANXmY1uJ4qUWVSYYBF8mKTBI8CcXNC8QsGYFqlGMFLbXbDFLIqqDTLk5bL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fFI21VrGQl0CJl1zFlAH9Q4OLRybQ0S3JHrvONkodo=;
 b=u9vnKVSDLREqr1aV3TgGyIyrvgo/5FnWZnQZRIufZZnxL5PGH0mKQC7sLiRDipGQvmPcFn7z4HLzbs8ltgM4Z9HqcdfzmDZMwiaOpdR+K6KaRNK041T20EWAmzmVgGzXucki6iUjjdmtjlcgg3648cAqZzer3dLs46CXAQ3sTYw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 22:03:12 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 22:03:12 +0000
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
Subject: Re: [PATCH v5 4/7] dax: add dax_recovery_write to dax_op and dm
 target type
Thread-Topic: [PATCH v5 4/7] dax: add dax_recovery_write to dax_op and dm
 target type
Thread-Index: AQHYFI6LEOTCAew0QE2MfSX8Pkzm9KyASjoAgACN/wA=
Date:   Wed, 2 Feb 2022 22:03:12 +0000
Message-ID: <fba7dc7a-ed09-bb1f-4882-da50fc470c20@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-5-jane.chu@oracle.com>
 <YfqIgliJi0GkviXD@infradead.org>
In-Reply-To: <YfqIgliJi0GkviXD@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b73fedee-d94d-45a2-19ae-08d9e697ce81
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB46899ECBC3CF704FE499F37DF3279@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yenOaRAcMzpmCBHushK7uk3nNhPnE44fd6PxSmCy4dwiC1HG4P8ErsnxPMNuUkDHi4Fx9Frt4RR9gg0wj9g6soLb4Tm23Uj53O81ODkqLUgG1KHwfnCPurVqE0jQEIIKVv5JWyTdmSD5jK9lXSboX5hUZWCfgUTlivfV22XpXIDTi9L/qzR9BUg6VDYgn0MbrdollYEbeuWG/AkSSiH3QSzHybas6hKwg0SZElDkbdHpbpM/Fq2u+THcrlcARO4LHS8QZ1WWWL7A9PdxD6K+WuRj2Z3mYm1MiLIbo0f7TFVc3p3m1IpEmjWJ39jgaTatKyBvUTytWgPfOyH0fUqe83jOdNGKsZmHrRvdeiPOJioVRECGWabJGpAkScjnfqF8MYArGMq0bFxHUbfpGw1+UCm9bEdi95po/HpjxGrmlUVyFwxFhgQh0877O7aeT5VA+LsngHEkIf8S5O7iX2w6Tyo2wv1Dpo3kgn42rIiXvvt678H1ppYjVf9vaZ0b8ixlsDM8jVO44lFMGAbwLhCMShHQvYimVFLs1mo2zFvDPfLcyMAdJefnPa2VKTIbBWTIyN0abfdl+8gdkttJiqKCCBPMpIGW4BJ4EC8RoIBkRpJrDRcl8BXqBpWXmUNBPNwv8EhHjMP7Bav59+o3+b+LPMCOSLhJKDLUC7bIB7+fQCwrVPft/otJ83rp6FWTgMQ26/YBd1eO3D+Ykv1hYPfEH8WG7EzxJRf0lmHdru+vAnD/vXaxXg/aJMaL7WM0q3Kz1Cn6OZJ/xrAZEl+4PAlh2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2616005)(31686004)(54906003)(44832011)(122000001)(186003)(316002)(31696002)(7416002)(26005)(508600001)(6916009)(86362001)(36756003)(8676002)(66476007)(38100700002)(91956017)(4326008)(76116006)(38070700005)(66946007)(66556008)(6512007)(6506007)(64756008)(66446008)(53546011)(71200400001)(6486002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ty8xY0Z3U09hRFFvS0krSWNrby8rWFIzd3pubkhtdDdZdFNvWU9FRjhhdzhj?=
 =?utf-8?B?dXB6OVNZWGtwTXd4UnFaUDJ1dnBnSTRCY09QWWRlbGRiaFovVUNob0w4ZVhJ?=
 =?utf-8?B?eFBJNU8rbW9xNFBSVGlsSmRRQ2JZZlBvTUNSZ05WYW1SdUFQZGk5NGhjUmRX?=
 =?utf-8?B?ZFRLRGg1K2tPazNvK2JEcGNZbkIyRW41aXd1TzNHeVExS1pYaDJxQVYyZkxO?=
 =?utf-8?B?MFRQMnNCY2EwbytvVUhVcTc1cmZ6dSs2RDJ3SVB4SkE0NmRxYy9DOTVrRktK?=
 =?utf-8?B?aUxPd21FNkRLOGFOOFlTdGVMN3NqdkxkUzZVK0VGd1RSZVpMTHVFS2tYMTZm?=
 =?utf-8?B?M0EzM0dmS05FNHN3alNEOVlnNU40ekh1RU9ETGJuQjhuNXVZQ2ovVnJ6Nldw?=
 =?utf-8?B?Q3VjVHpWZk12Q2lvalB5KytDdEp2bTRGNVhtVkM5VDQ3VDRvSEx1aDBJQkFt?=
 =?utf-8?B?TzdvQU52bHphdHJrSXFabGZ5ZmZLNzNDLzQrbUpOSkN6WDFkWDJqejVRWFNp?=
 =?utf-8?B?ajZtcHFkYm1seENob0E3ZkorOUxoMzJXZXNyNW1VZGs2ZkU1M3NBNGdQQXZ0?=
 =?utf-8?B?bWUyZ05oYllTWW5qc2xBWlRQdnUwZ1hzMkg2NEQvOHcxL2F2dXA2WmlFV0FK?=
 =?utf-8?B?QXRpelZaWXMwdGIrcmYva1lpb0pNSmFpdDRvTmNidWJTRzFURjNQcXlLZE5m?=
 =?utf-8?B?VkpZS3pwT2RMd1VNZHVaRHNKRlNmY0xaTDVTdnFkSnRlUVBFTWg5Q0o0UUhl?=
 =?utf-8?B?NlZpWHBhd1NkTUNCcVhNeGx6cGRLejN4V2NKaCtxWWFLdk1ISjEyb2s4SWo2?=
 =?utf-8?B?czZvRktxNWppMURuajNidi9obWVnQlNkZnVYQ0pyYkNIdTgvMmdVUWZOSnRW?=
 =?utf-8?B?UzdXai9Hb0tUUUtYR1ZXKys0Y05wakN6ekk5eDNEaXhDR2IwZkxWeXQya1BM?=
 =?utf-8?B?NE1KTXlCNjh0Y0hFSHhsUlU4cTRMd2Z4dGVoOHBVNEFHQ3pPRkI4SFpyTlRQ?=
 =?utf-8?B?UXBFancydEhZZFpVUDl4a0RDcTBFZERPR25oOWNyOEZpL2tydlArRUtIUTZZ?=
 =?utf-8?B?T284cWFuSmVZbWZYWkwrc0pGQ2E5QlhUVFJWTlEwNFhma1VWMWN3VDhrckp3?=
 =?utf-8?B?ZEU0ODZYZVVtc0JJQ2dER3JsS1loRTVDeFRHNVNLaG5YVk91Yk9Cemw5cDRI?=
 =?utf-8?B?TXBvbFlPQ213SDRFQWlNTzk1U25lRXhxUlFwZXRYUzZkckRmOExaWWxWSDNl?=
 =?utf-8?B?bXp2WFFhMkhVWWI3MHFkWGh2ZXRDc1NvNGZGNlBCWXNiSGJ2enQwdHp2UEh3?=
 =?utf-8?B?MlNXNk1jOWR2R1NMajc4UXkrUW1QZnhIRmJFRWI1bUxRV3g5dTJHTnRTYksy?=
 =?utf-8?B?UUNjVlZDQWYzVGZIZkx5Rjg5QndIWjkzUHFaNVBYRmtHUkFadFNham9leGVW?=
 =?utf-8?B?RGRjajZaVTZIYWh2MVVhYlVUOEgwNUxKaUFyQks1Q0dOZHN5NEdkdEVpeXdB?=
 =?utf-8?B?Q1pPLy9zbXlmb0VNSDl0dEdrUGFxcEowazlaWXdRcDh2RVhuSm8xNy9IaE5K?=
 =?utf-8?B?QVU2YW1Dc0ZqOTQxVkdhZGVVMytEVEJmVU9XQUJlcXRvU3JPQzY0UVJQRjBu?=
 =?utf-8?B?MjU4aUoyTlBYWmo1T2t4UGVPQThrU3FHVm0xWDhUWXVEbTdvUURPd3crYjRY?=
 =?utf-8?B?SkxnL0hQWGY4UmlqY050TDYwSnRNODM1bkdPV2J6V3luamNDazh3Wm50WDdV?=
 =?utf-8?B?NFRoZnRlNHdKT0ptbnBBK2dvZExqZ09LU1Ztd3Mvcmd5N1k0c3BQVm1lZitv?=
 =?utf-8?B?Tk0yUjcrNTdINElrNG1pTUM0OUd6MTlreW04Vmt4OUFIRXNQeFVOdWJJc0hI?=
 =?utf-8?B?ZlYrNHBTU3AvdWVjVVlORVFzN0N4d2NMUlNiNEFFQllzSXgyamZsNDFwZE5x?=
 =?utf-8?B?OVlwdklzSGdIckEzRTlSNjlnOGRUR1ZNQW1NSmNtRWFybzdJcnB3TDRqSzhV?=
 =?utf-8?B?VWt4ajVST0tMNVdEeTI0VkJGNHl0eGN3dSs0dUVOeHhjanhsSFkvZ2FVeTBH?=
 =?utf-8?B?RUFUc2R5QlMveW10L1UzNU50anVPYWRSK3pGa0ZvRE5kQnZlQ3pLRE1yZ0Z6?=
 =?utf-8?B?VXRlTHUxWVN5UmlORjd1TzJPMDBxejJWNG04dHJkVURhQ1ZyZ0FlaElPcEt5?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BF30A4EEDAA2548BE48ED01A4208027@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73fedee-d94d-45a2-19ae-08d9e697ce81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 22:03:12.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdlkKRaFjAN5xOsUchOcq5ReoCQ/aLURaiA3eXJI931B7aPSmtGxr8KchrFf2wRyv4LkNLldEUSI6NOF4BiYaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020119
X-Proofpoint-GUID: ZzgP2TL42LjwBsjlcCysPsqzmLlsPg7H
X-Proofpoint-ORIG-GUID: ZzgP2TL42LjwBsjlcCysPsqzmLlsPg7H
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgNTozNCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwg
SmFuIDI4LCAyMDIyIGF0IDAyOjMxOjQ3UE0gLTA3MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gZGF4
X3JlY292ZXJ5X3dyaXRlKCkgZGF4IG9wIGlzIG9ubHkgcmVxdWlyZWQgZm9yIERBWCBkZXZpY2Ug
dGhhdA0KPj4gZXhwb3J0IERBWERFVl9SRUNPVkVSWSBpbmRpY2F0aW5nIGl0cyBjYXBhYmlsaXR5
IHRvIHJlY292ZXIgZnJvbQ0KPj4gcG9pc29ucy4NCj4+DQo+PiBETSBtYXkgYmUgbmVzdGVkLCBp
ZiBwYXJ0IG9mIHRoZSBiYXNlIGRheCBkZXZpY2VzIGZvcm1pbmcgYSBETQ0KPj4gZGV2aWNlIHN1
cHBvcnQgZGF4IHJlY292ZXJ5LCB0aGUgRE0gZGV2aWNlIGlzIG1hcmtlZCB3aXRoIHN1Y2gNCj4+
IGNhcGFiaWxpdHkuDQo+IA0KPiBJJ2QgZm9sZCB0aGlzIGludG8gdGhlIHByZXZpb3VzIDIgcGF0
Y2hlcyBhcyB0aGUgZmxhZyBhbmQgbWV0aG9kDQo+IGFyZSBjbGVhcmx5IHZlcnkgdGlnaHRseSBj
b3VwbGVkLg0KDQpNYWtlIHNlbnNlLCB3aWxsIGRvLg0KDQo+IA0KPj4gK3N0YXRpYyBzaXplX3Qg
bGluZWFyX2RheF9yZWNvdmVyeV93cml0ZShzdHJ1Y3QgZG1fdGFyZ2V0ICp0aSwgcGdvZmZfdCBw
Z29mZiwNCj4+ICsJdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKmkp
DQo+IA0KPiBGdW5jdGlvbiBsaW5lIGNvbnRpbnVhdGlvbnMgdXNlIHR3byB0YWIgaW5kZW50YXRp
b25zIG9yIGFsaWdubWVudCBhZnRlcg0KPiB0aGUgb3BlbmluZyBicmFjZS4NCg0KT2theS4NCg0K
PiANCj4+ICt7DQo+PiArCXN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2ID0gbGluZWFyX2RheF9w
Z29mZih0aSwgJnBnb2ZmKTsNCj4+ICsNCj4+ICsJaWYgKCFkYXhfcmVjb3ZlcnlfY2FwYWJsZShk
YXhfZGV2KSkNCj4+ICsJCXJldHVybiAoc2l6ZV90KSAtRU9QTk9UU1VQUDsNCj4gDQo+IFJldHVy
bmluZyBhIG5lZ2F0aXYgZXJybm8gdGhyb3VnaCBhbiB1bnNpZ25lZCBhcmd1bWVudCBsb29rcyBk
YW5nZXJvdXMuDQoNClNvcnJ5LCBzaG91bGQgYmUgKHNzaXplX3QpIHRoZXJlLg0KDQo+IA0KPj4g
KwkvKiByZWNvdmVyeV93cml0ZTogb3B0aW9uYWwgb3BlcmF0aW9uLiAqLw0KPiANCj4gQW5kIGV4
cGxhbmF0aW9uIG9mIHdoYXQgdGhlIG1ldGhvZCBpcyB1c2UgZm9yIG1pZ2h0IGJlIG1vcmUgdXNl
ZnVsIHRoYW4NCj4gbWVudGlvbmluZyB0aGF0IGlzIGlzIG9wdGlvbmFsLg0KDQpXaWxsIGFkZCBz
dWJzdGFuY2UgdG8gY29tbWVudHMuDQoNCj4gDQo+PiArCXNpemVfdCAoKnJlY292ZXJ5X3dyaXRl
KShzdHJ1Y3QgZGF4X2RldmljZSAqLCBwZ29mZl90LCB2b2lkICosIHNpemVfdCwNCj4+ICsJCQkJ
c3RydWN0IGlvdl9pdGVyICopOw0KPiANCj4gU3BlbGxpbmcgb3V0IHRoZSBhcmd1bWVudHMgdGVu
ZHMgdG8gaGVscCByZWFkYWJpbGl0eSwgYnV0IHRoZW4gYWdhaW4NCj4gbm9uZSBvZiB0aGUgZXhp
c3RpbmcgbWV0aG9kcyBkb2VzIGl0Lg0KDQpUaGFua3MhDQotamFuZQ0KDQo=
