Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFF4447F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 19:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKCSNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 14:13:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6034 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231147AbhKCSNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:13:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3HgItm008338;
        Wed, 3 Nov 2021 18:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x9FkC8MVbk5tJcpDC2G+Crb9xVGepsL/UvEcZF0jBcI=;
 b=QzBKRW+hJXiRKSHimoOmnAxw2438QfVs3RT7UMZuvKNBFcz0pz+ugEd0ERbgiuSNAtFm
 aQilxt6rW4wZ7rBNjxGnX2YTEwzKyMPF+fnpimEY74yfRGPNs0Wn5v2c0stG3SEb2sGn
 OPVJmMq3YWsy0CoCbZeVAlJgEvi8HDOKrkdZyQKkWawexXgyL6RsQe1Ds/wLWlQTjRDG
 R9CtqpDlhCZDXxrrOR4uhmLRkDaPFfYf/PJmPLEtsX47cWbkcq7hL73kJhd5EiNM4aw2
 Ed4wNcovUt3USFVy0TncBbMGe+dgL33EDENwMDjsu6t3yQku+7XoSaSyprCkMwCFfhze 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3q1nb6hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 18:10:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3Htga5018954;
        Wed, 3 Nov 2021 18:10:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3c3pfy26sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 18:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evy1p/VB/m7QFL9wxkGKf87PjC0nySvlKlF3U6kNhy8HiMXAOyXXQ9a2mlVAgTgCHgMjbNlXXPBUm7TQLu6h4o3IstsAKfEuJJn/h2XUTYkW6pFoMZfzpeo8E7Vsry4y9zNVyfLHa9TOv1FLKaWEr23IYzVDDB715g6+kjSYljydEQprhhzfDjvp6jgRb6JRoyPeVRxAwy85I9J+pUi2XgusvLJul8jSpqtl33yGiP/Vg+R2o8NofanAdlwi6ZD4zij3dahogS0yVZMpeUdsH1igb3HGzt2VqgsS+t5F4DxleuvcQejQ2lquhBsUbmgqehVGlGvyGwW0ros9GZjchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9FkC8MVbk5tJcpDC2G+Crb9xVGepsL/UvEcZF0jBcI=;
 b=DfA4QBY4eYZ5bEXSmIbxdxX4Mlt+NIAKPWbfG3C4b9Q4FOd5sOr6QmlYiapfk1SuUYmN2J/GmRCgPiUQ3qMrdf5EsvLRK4IJVCqBHrkcT1m2sBndN4pSmIL/bWtFRKYNoGO3Co39r1kifVSoSC6Odrc6c62aX9Ti8NWVZVomXBxXSRhdWL8Cv37mzcYS+tP5TrPKVojI9u2XdHxpPcxI6xVToC9Oqo2LVoglYvoYXhjzJ/rkzLHmjNlWFBi8ewErFdUexNAZJZrJeRqjOJEbvsSXSs+KOu3gLN6sWB/aDlJPWAIwyEVWRxfO+OKB7U7L8yQX8cvFgpdmLo9y0zeuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9FkC8MVbk5tJcpDC2G+Crb9xVGepsL/UvEcZF0jBcI=;
 b=fEupG/49QlcOhkwFs2GaJ9WPFTzwfZEalcXvhSyuRsroyUV0jwZh7HEtjY+nr9Uyf82bAx3wTnN1NeZRj2pWLIxNLfWjnV6xYMBSJ+/1zI0n7toh5OAhTCAxx7ChFkxrhVX2thDcOlMZCEJrqh0Zt/jE2dLZDA268bAwvuFv+SU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2967.namprd10.prod.outlook.com (2603:10b6:a03:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Wed, 3 Nov
 2021 18:09:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.011; Wed, 3 Nov 2021
 18:09:57 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
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
Thread-Index: AQHXxhAze/H2dZp4I0O0xNcfyRn+pqvdUicAgADsdoCAAELPAIABAAaAgAbwJYCAASa6gIAIPpYAgAJY/YA=
Date:   Wed, 3 Nov 2021 18:09:57 +0000
Message-ID: <dfca8558-ad70-41d5-1131-63db66b70542@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
In-Reply-To: <YYDYUCCiEPXhZEw0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f6b887-5d2c-4ef4-0e81-08d99ef52525
x-ms-traffictypediagnostic: BYAPR10MB2967:
x-microsoft-antispam-prvs: <BYAPR10MB2967D4507EE6E02BADE2819CF38C9@BYAPR10MB2967.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9ngDCMj9/BGiwlH5070rFXWjvJwOu/AqLAwWuRxZdWmRS61IxmhKEv/ohOSybO0UK+cZPFcXKkt0ICRm+NDxj/PErQzD0IXxrLp8dYS7fIoWA4LFdXmYt4XEoTeL0Z8TN9iBYRK09s6Rji3SL2SHnvdUBP8d5vEMkh3kefMQTxWxMUfIMmlTXrKCtT7w24jJpwmUozk1Ie6qwxxCxjTiiIw4LXGgrobk/nprqdSH2FJfIbMUf7EKIhN/YGPmNfVrivp79q/cyW/6uvQ7MqE5LrmKQdrFx6eCquj1MZQyrNRNBfkWPDHqyWAxPgv2asJGHPolf/FGaHj00ZmF11hIh8ZZVTSRHPGuGpYRKZMBEVjTklN7T6FMGFYukm4uHriitNDbUka6cQoG0brnGJht2XU6ZsKY0n9x7b6deMXSoQaAfp9YtFIVNIVURFJB2jIaWstifqAyH6+rUSCoSyh7FMwERAyDTNKqnc8Vz7RnpFQ1dzG3fhRmpmcGPpl0v4VRIglMxNZrZNU3sdhJIHqQGNn/nC8W/3m1nzu+u4jeYFxGhRr+jSVt4QgyVzAhQyFqcg49v1DByOcILBLhPd3826E9y6wY4P8lBJCIho/t9Xb8FoHo/ARXOqKI9CteMqnY4lFyBpEjkeJgjVrBJsZ8Ej3STERmH7Jo0NNOCLI9guL7j0DISTBRdHo5Ku8FOWgsj41z+Hox95lQ884Bnehw52nSe3i3TLc5AHN/Sfxc9D0EGe8k6hurWj+Uym1o14at0670N1RbNl8L96uzrN/ofzMZouwa4UURHpo2Oki261qqmV2HLwPRCagskOBmKCsi1RpRQEJsBxxkoDxlAYURRKiB/AojaK+NFeMcIRO5PC98YDR4nJE4FUiuqkeuN+TQAJYCxTNGxEZGUjAf+6rlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(54906003)(8936002)(6486002)(86362001)(36756003)(31696002)(186003)(2906002)(2616005)(316002)(71200400001)(26005)(83380400001)(5660300002)(64756008)(66476007)(66946007)(508600001)(4326008)(6506007)(7416002)(966005)(38070700005)(6512007)(31686004)(8676002)(53546011)(66446008)(44832011)(91956017)(66556008)(38100700002)(76116006)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUg1cWFYSzVBSFJFTUp6WFpybWFiVy9VRjZ2TCsvWkozQTFiTUd1WjVhNmRJ?=
 =?utf-8?B?UTFldmFsdzRrZk01TWdhUU8vNkRkWkhPbkF6aW9qQmhXTExJN0Y0cmJxejFG?=
 =?utf-8?B?RUdvNjUwWmd5U1hLbGIyZU1zY1hwRUw0d01pb1VWREd0U0lsdDVuenZXSzlj?=
 =?utf-8?B?YUkwbWxOb0h6anZGTFNNUktnd09mRkJuOS9rK2d3UjFRMGxlTXd1YzhKNFh6?=
 =?utf-8?B?L056eGNUd0ljUjEvSmJjdFp0ZFFleTNOMFcwcjZ3N3dha1NCRHhYOGYzaTV0?=
 =?utf-8?B?N2ZOclZOSVlaWlQ0TjFpb3dlUVZ2K2I1cW9vSVNTSGpHQzhuTnFBazI3MERF?=
 =?utf-8?B?alNMdHh3TzFMdVV5SE8wbi9ISkIyRDMzRTdXQ3BmMHV4bVprWVNjMEVSYXBq?=
 =?utf-8?B?TjBaeTAvaXJOeWFUUGpIM3VBalBLS2RnOU5yblBpeHJvTTVlUDI1TE9jREtH?=
 =?utf-8?B?Tzl1aWs4L2RUckFocU8xS0QxWWdyL1FST01iRVdPUTduV0MrUElGVnUwSksv?=
 =?utf-8?B?MzBocU0zUVg1L3VwaU4yOGl5M2pUQ0tENVBWMDZNUHVIZ250RWNzeDhxWlUy?=
 =?utf-8?B?N2ppMmZvREVuWmRFSUNIZVdRdTFZdXpySnFxSURNcTltQjM3VmpzT0ZwbVVY?=
 =?utf-8?B?UytNbVdpdDA3Wm8xaVEwVXRwZUNRWGpsSi9aditkblZCcEh6dFJJTGM3Q1dn?=
 =?utf-8?B?QUl2dGZFc01yVWpXKzNYL3FqLzhobXFqaW5rVHYrQXpibW0rUkpsd2cyc2tX?=
 =?utf-8?B?VklBSXVBYzdNMjRqQy9jcVlibStwZ1BuVjF2TmZXdmZrSWJuM1U3N3l3djRI?=
 =?utf-8?B?WUVFM3BIUVl2Qyt3UkxhSytsTWFOY0h6bkZHK0RRNVVhdTF5ZUttU3IxTGtD?=
 =?utf-8?B?WXdKZkg3djNpNElSTXRoNDZ3cHpxN3RKRGJzcG0wSWhYZGxuTmFpNVMrakFo?=
 =?utf-8?B?c3hiQXhIZ25UZEc3QzRvSSswQjFtM0U0QkVLSFFidjNQQjdaemZhRG5UYW5u?=
 =?utf-8?B?YnZxc2J4YzlHY2F2d1FzUnROQmJqNzJXZFU3MzF5MG42WStDR1FPcE11NUcz?=
 =?utf-8?B?SzVYOHVFOUZqSHpubGYrMTJxUXQzOGxFQ2ZTMWJMVXA2UU1uSUZOMmI0V0w3?=
 =?utf-8?B?Z3FCZ0hGa3ltN0FpOW42dWsxNXZRc3MvR2o5dDVudzV4YjN4QWQybTN1YUJX?=
 =?utf-8?B?SUcvOXJJMVlCOEY5MENsb2RzazcyNGRxRjRQSjNxNlNVK1Jmb3lqdWl3ZEJD?=
 =?utf-8?B?OUJBdnVZUUJYRVVZazNoY1IrNWN2emdkZ0hOeUxmZ1owS0RyRFdxN0FzN3Zs?=
 =?utf-8?B?eTRyZVB3UVdORU5tTlBnR1dyUlBJYmxYbCtmaUFFeStSd0h5S0g5QUNtVDR1?=
 =?utf-8?B?dlZ3bWxGbm5qdTJwOXFzVHNHNklWem9KUFU1Z3RrUnBDNXBNNTIxL1hRMEc5?=
 =?utf-8?B?NnZ0ekFJTnVkTzFzT2p2ODQyUU0xRjZ4ZEpzcjQwejFnSEQ4c1p4K0V3YzVX?=
 =?utf-8?B?QUhSWXZNa3JyenQ0N1REaXZxWDVDa25qYTMybzE2eG9PRjFjQlFReUllRHpT?=
 =?utf-8?B?QlBYc0tzeHRSd2FYOW95NmdaZUR4djR2cmNFZkg2ZWJiUVRmV1kwMU1OOUp1?=
 =?utf-8?B?bFN1QXlzRm5aV3BIbFRIVTl5VHo1NnNtRFhhSEdyNU5LRVFuNkVIb1d3SkFE?=
 =?utf-8?B?Mzl6Lzl0UGsvVzBWLy9ERFJlb3dEODNhbGs5SHMxM2RyL2ltQ1ZvQThud2hV?=
 =?utf-8?B?dm5lQ3BBMys5MWVKcEZmVCtzbit4MEJVYm5OSC9HK25nM2plZmIxaEdjUWtB?=
 =?utf-8?B?Y05BMys4Ymt1eDlFRlFRalRjSElxdmxMZm03aFpFTW1XSkt5WHhpc2dSUGFG?=
 =?utf-8?B?SnNHME9UQVE0c29wK3dBNTRwTSszVlZSZjYydUJLUTVBZXI5dyszZDNBclEy?=
 =?utf-8?B?bG5vNGF6T0FvMVZFejJlUlpYTnJsbDh6RkNKS1cxdkVhSDdobk1jZHhsSnhJ?=
 =?utf-8?B?aklQWXVNM1ZHdW9VT3FEWk84S2kyRVFyN2NRRmpkbnI0bUY0ZDBTWCs3U0tm?=
 =?utf-8?B?bE5pZWc2M2ZwTHZEQjFyTGJBdFkzRDVOTUdUUHdONmNSSk5NOW80L0xGZDBJ?=
 =?utf-8?B?VmFveDZzeFpSb2sxaWhxRjA4SUJHYXcyaHFNS0YyNjUvRDhicXNHdnJFTy8y?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82AAA3E6AE7CCC4AAFCDAAE954D866E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f6b887-5d2c-4ef4-0e81-08d99ef52525
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 18:09:57.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nbc/iXgUQK/KbZln7fo+T4eTvz3vKgVOdjAD6REI4q5rRyj4H2xg+UcIwzFfqJnt5G4Jdn7YydN7jeTDUC0U1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2967
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030096
X-Proofpoint-ORIG-GUID: XhpW4DRbLRb9jAE0d1IfqUrFu4lPa2Ad
X-Proofpoint-GUID: XhpW4DRbLRb9jAE0d1IfqUrFu4lPa2Ad
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMS8yMDIxIDExOjE4IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gV2Vk
LCBPY3QgMjcsIDIwMjEgYXQgMDU6MjQ6NTFQTSAtMDcwMCwgRGFycmljayBKLiBXb25nIHdyb3Rl
Og0KPj4gLi4uc28gd291bGQgeW91IGhhcHBlbiB0byBrbm93IGlmIGFueW9uZSdzIHdvcmtpbmcg
b24gc29sdmluZyB0aGlzDQo+PiBwcm9ibGVtIGZvciB1cyBieSBwdXR0aW5nIHRoZSBtZW1vcnkg
Y29udHJvbGxlciBpbiBjaGFyZ2Ugb2YgZGVhbGluZw0KPj4gd2l0aCBtZWRpYSBlcnJvcnM/DQo+
IA0KPiBUaGUgb25seSBvbmUgd2hvIGNvdWxkIGtub3cgaXMgSW50ZWwuLg0KPiANCj4+IFRoZSB0
cm91YmxlIGlzLCB3ZSByZWFsbHkgL2RvLyB3YW50IHRvIGJlIGFibGUgdG8gKHJlKXdyaXRlIHRo
ZSBmYWlsZWQNCj4+IGFyZWEsIGFuZCB3ZSBwcm9iYWJseSB3YW50IHRvIHRyeSB0byByZWFkIHdo
YXRldmVyIHdlIGNhbi4gIFRob3NlIGFyZQ0KPj4gcmVhZHMgYW5kIHdyaXRlcywgbm90IHtwcmUs
Zn1hbGxvY2F0aW9uIGFjdGl2aXRpZXMuICBUaGlzIGlzIHdoZXJlIERhdmUNCj4+IGFuZCBJIGFy
cml2ZWQgYXQgYSBtb250aCBhZ28uDQo+Pg0KPj4gVW5sZXNzIHlvdSdkIGJlIG9rIHdpdGggYSBz
ZWNvbmQgSU8gcGF0aCBmb3IgcmVjb3Zlcnkgd2hlcmUgd2UncmUNCj4+IGFsbG93ZWQgdG8gYmUg
c2xvdz8gIFRoYXQgd291bGQgcHJvYmFibHkgaGF2ZSB0aGUgc2FtZSB1c2VyIGludGVyZmFjZQ0K
Pj4gZmxhZywganVzdCBhIGRpZmZlcmVudCBwYXRoIGludG8gdGhlIHBtZW0gZHJpdmVyLg0KPiAN
Cj4gV2hpY2ggaXMgZmluZSB3aXRoIG1lLiAgSWYgeW91IGxvb2sgYXQgdGhlIEFQSSBoZXJlIHdl
IGRvIGhhdmUgdGhlDQo+IFJXRl8gQVBJLCB3aGljaCB0aGVtIG1hcHMgdG8gdGhlIElPTUFQIEFQ
SSwgd2hpY2ggbWFwcyB0byB0aGUgREFYXw0KPiBBUEkgd2hpY2ggdGhlbiBnZXRzIHNwZWNpYWwg
Y2FzaW5nIG92ZXIgdGhyZWUgbWV0aG9kcy4NCj4gDQo+IEFuZCB3aGlsZSBQYXZlbCBwb2ludGVk
IG91dCB0aGF0IGhlIGFuZCBKZW5zIGFyZSBub3cgb3B0aW1pemluZyBmb3INCj4gc2luZ2xlIGJy
YW5jaGVzIGxpa2UgdGhpcy4gIEkgdGhpbmsgdGhpcyBhY3R1YWxseSBpcyBzaWxseSBhbmQgaXQg
aXMNCj4gbm90IG15IHBvaW50Lg0KPiANCj4gVGhlIHBvaW50IGlzIHRoYXQgdGhlIERBWCBpbi1r
ZXJuZWwgQVBJIGlzIGEgbWVzcywgYW5kIGJlZm9yZSB3ZSBtYWtlDQo+IGl0IGV2ZW4gd29yc2Ug
d2UgbmVlZCB0byBzb3J0IGl0IGZpcnN0LiAgV2hhdCBpcyBkaXJlY3RseSByZWxldmFudA0KPiBo
ZXJlIGlzIHRoYXQgdGhlIGNvcHlfZnJvbV9pdGVyIGFuZCBjb3B5X3RvX2l0ZXIgQVBJcyBkbyBu
b3QgbWFrZQ0KPiBzZW5zZS4gIE1vc3Qgb2YgdGhlIERBWCBBUEkgaXMgYmFzZWQgYXJvdW5kIGdl
dHRpbmcgYSBtZW1vcnkgbWFwcGluZw0KPiB1c2luZyAtPmRpcmVjdF9hY2Nlc3MsIGl0IGlzIGp1
c3QgdGhlIHJlYWQvd3JpdGUgcGF0aCB3aGljaCBpcyBhIHNsb3cNCj4gcGF0aCB0aGF0IGFjdHVh
bGx5IHVzZXMgdGhpcy4gIEkgaGF2ZSBhIHZlcnkgV0lQIHBhdGNoIHNlcmllcyB0byB0cnkNCj4g
dG8gc29ydCB0aGlzIG91dCBoZXJlOg0KPiANCj4gaHR0cDovL2dpdC5pbmZyYWRlYWQub3JnL3Vz
ZXJzL2hjaC9taXNjLmdpdC9zaG9ydGxvZy9yZWZzL2hlYWRzL2RheC1kZXZpcnR1YWxpemUNCj4g
DQo+IEJ1dCBiYWNrIHRvIHRoaXMgc2VyaWVzLiAgVGhlIGJhc2ljIERBWCBtb2RlbCBpcyB0aGF0
IHRoZSBjYWxsZXJzIGdldHMgYQ0KPiBtZW1vcnkgbWFwcGluZyBhbiBqdXN0IHdvcmtzIG9uIHRo
YXQsIG1heWJlIGNhbGxpbmcgYSBzeW5jIGFmdGVyIGEgd3JpdGUNCj4gaW4gYSBmZXcgY2FzZXMu
ICBTbyBhbnkga2luZCBvZiByZWNvdmVyeSByZWFsbHkgbmVlZHMgdG8gYmUgYWJsZSB0bw0KPiB3
b3JrIHdpdGggdGhhdCBtb2RlbCBhcyBnb2luZyBmb3J3YXJkIHRoZSBjb3B5X3RvL2Zyb21faXRl
ciBwYXRoIHdpbGwNCj4gYmUgdXNlZCBsZXNzIGFuZCBsZXNzLiAgaS5lLiBmaWxlIHN5c3RlbXMg
Y2FuIGFuZCBzaG91bGQgdXNlDQo+IGRpcmVjdF9hY2Nlc3MgZGlyZWN0bHkgaW5zdGVhZCBvZiB1
c2luZyB0aGUgYmxvY2sgbGF5ZXIgaW1wbGVtZW50YXRpb24NCj4gaW4gdGhlIHBtZW0gZHJpdmVy
LiAgQXMgYW4gZXhhbXBsZSB0aGUgZG0td3JpdGVjYWNoZSBkcml2ZXIsIHRoZSBwZW5kaW5nDQo+
IGJjYWNoZSBudmRpbW0gc3VwcG9ydCBhbmQgdGhlIChob3JyaWJseSBhbmQgb3V0IG9mIHRyZWUp
IG5vdmEgZmlsZSBzeXN0ZW1zDQo+IHdvbid0IGV2ZW4gdXNlIHRoaXMgcGF0aC4gIFdlIG5lZWQg
dG8gZmluZCBhIHdheSB0byBzdXBwb3J0IHJlY292ZXJ5DQo+IGZvciB0aGVtLiAgQW5kIG92ZXJs
b2FkaW5nIGl0IG92ZXIgdGhlIHJlYWQvd3JpdGUgcGF0aCB3aGljaCBpcyBub3QNCj4gdGhlIG1h
aW4gcGF0aCBmb3IgREFYLCBidXQgdGhlIGFic29sdXRlbHkgZmFzdCBwYXRoIGZvciA5OSUgb2Yg
dGhlDQo+IGtlcm5lbCB1c2VycyBpcyBhIGhvcnJpYmxlIGlkZWEuDQo+IA0KPiBTbyBob3cgY2Fu
IHdlIHdvcmsgYXJvdW5kIHRoZSBob3JyaWJsZSBudmRpbW0gZGVzaWduIGZvciBkYXRhIHJlY292
ZXJ5DQo+IGluIGEgd2F5IHRoYXQ6DQo+IA0KPiAgICAgYSkgYWN0dWFsbHkgd29ya3Mgd2l0aCB0
aGUgaW50ZW5kZWQgZGlyZWN0IG1lbW9yeSBtYXAgdXNlIGNhc2UNCj4gICAgIGIpIGRvZXNuJ3Qg
cmVhbGx5IGFmZmVjdCB0aGUgbm9ybWFsIGtlcm5lbCB0b28gbXVjaA0KPiANCj4gPw0KPiANCg0K
VGhpcyBpcyBjbGVhcmVyLCBJJ3ZlIGxvb2tlZCBhdCB5b3VyICdkYXgtZGV2aXJ0dWFsaXplJyBw
YXRjaCB3aGljaCANCnJlbW92ZXMgcG1lbV9jb3B5X3RvL2Zyb21faXRlciwgYW5kIGFzIHlvdSBt
ZW50aW9uZWQgYmVmb3JlLA0KYSBzZXBhcmF0ZSBBUEkgZm9yIHBvaXNvbi1jbGVhcmluZyBpcyBu
ZWVkZWQuIFNvIGhvdyBhYm91dCBJIGdvIGFoZWFkDQpyZWJhc2UgbXkgZWFybGllciBwYXRjaA0K
IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDkxNDIzMzEzMi4zNjgwNTQ2LTIt
amFuZS5jaHVAb3JhY2xlLmNvbS8NCm9uICdkYXgtZGV2aXJ0dWFsaXplJywgcHJvdmlkZSBkbSBz
dXBwb3J0IGZvciBjbGVhci1wb2lzb24/DQpUaGF0IHdheSwgdGhlIG5vbi1kYXggOTklIG9mIHRo
ZSBwd3JpdGUgdXNlLWNhc2VzIGFyZW4ndCBpbXBhY3RlZCBhdCBhbGwNCmFuZCB3ZSByZXNvbHZl
IHRoZSB1cmdlbnQgcG1lbSBwb2lzb24tY2xlYXJpbmcgaXNzdWU/DQoNCkRhbiwgYXJlIHlvdSBv
a2F5IHdpdGggdGhpcz8gIEkgYW0gZ2V0dGluZyBwcmVzc3VyZSBmcm9tIG91ciBjdXN0b21lcnMN
CndobyBhcmUgYmFzaWNhbGx5IHN0dWNrIGF0IHRoZSBtb21lbnQuDQoNCnRoYW5rcyENCi1qYW5l
DQoNCg0KDQoNCg0KDQo=
