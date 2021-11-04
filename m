Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD510445B13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhKDUaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 16:30:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhKDUaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:30:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4KOSH2009207;
        Thu, 4 Nov 2021 20:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=F9P2aGL1/lOzWsR+TIchg/2/ILE0oFWwHKyMF8MxaoU=;
 b=NPiAS0SFUD44iiPgoYOEvSE0jGEUkkWTbcxMXIZoAOo0cIQAL+jQYlSYqGFt+nLj6dUT
 V30asPbDfnmNrgBRdeWBPYG+IB3+xLwLJ8NlTxcbBGdVFAhpe4gkDZy6ENfgKvb70Cwq
 /+DztWu7dy2k4hGShxXysn+3bTdFFaz9W3+8gT3NXvzOzzAupkACTGoSMQex+RTPh11P
 ZwgyeNLn+bwxYN/RxtX90Tpi4Zf4I0AGK/VbC2KDDo0V+AOE1hf+/BJ1y/4DmCGvhCIj
 XsGhDw575dQ86AZOnSun+HoIIP62IyxHTMQtG6AeWsvKAb90W4Lv45/wignPZE4oJWKS LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n8pa9ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 20:27:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4KCIRS145552;
        Thu, 4 Nov 2021 20:27:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3c0wv8b90u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 20:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYyQHPXYPfx5+UBxEWWk4axenrdlxKDlPsa4lnIToaeiJ8OuNPZfs6R2I2pxUUUoFjX21Qh7LBUC5a2t+T48KgNRQwVbKtcHMQf06NjIYT9KcZg8ndqsIfqi7cysTpZLKY3d7E3XCH3DPX+AJAZ174ZrBMsJIkgQujh7/aSeKxKxNVpFTnn6Hi5s6EMWJmqJ9icyuHzNWgjEzamHxLeXCMDV/SU3eaZErhVo7uqtHCiyjRF71wtBlnR4H0AwgJMYL5fAQPDdutB+ZLmj9ydHiDiMUMGMNThsijsPZcxvsxfiXiv6m0rHYJmitdUlpj9DWMwl6ltoKTWJFfspPah6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9P2aGL1/lOzWsR+TIchg/2/ILE0oFWwHKyMF8MxaoU=;
 b=dtNd+UwxNYFCijP8ryBihGu3h3Or6OPWFYyI1A1TJ8l+kSazR/xGOvfFQp3Ky9xAQ7DqP+UXwjADjefJ5/Jd/L1HISnZMKgz2U9MGppVc2w5jgpbpHAUWwWHO1pwncTQPvb6DGT8mh0ecg6dJaS/42hK7un0KXGTr9N1n6c4Dm7qKh6fKRA//RkAofCq0XkSMbRcg7J2rp8/dAVfAnqqOvv2TZrclaW27gkddSVmiBDUuIQCeANVLI4yLUW0SwxywGSdgzOcggQJFLjDpq2G/if/M4vB4ta0xL2y/hnqP/3mYkexCUqurVCY8EM2pQFuQfbFk7W9fYiHacviI5XIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9P2aGL1/lOzWsR+TIchg/2/ILE0oFWwHKyMF8MxaoU=;
 b=kkzGWNKWGAJl/Gr8URGYBuksOPXwZUGb23oeOvRt4JNY9elxUtdeBKZJ9sk+RhwC/D0X/NZchEYQukldx6BCvyTHlCM11rwZlNA2muEVhBDhrzv6NH8wUYMeWIIQiWyMjmvHK5HPrU2APUnTzgwv6CTKAaOvVGG5EtzOkXq6AuM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3512.namprd10.prod.outlook.com (2603:10b6:a03:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 4 Nov
 2021 20:27:21 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 20:27:21 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
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
Thread-Index: AQHXxhAze/H2dZp4I0O0xNcfyRn+pqvdUicAgADsdoCAAELPAIABAAaAgAbwJYCAASa6gIAIPpYAgADknQCAAWBnAIAAPDYAgADIRwCAAIRIgIAAJDSAgAAHXwCAABhYAA==
Date:   Thu, 4 Nov 2021 20:27:21 +0000
Message-ID: <342eb71c-0aff-77e5-3c71-92224d7d48e0@oracle.com>
References: <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
 <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org>
 <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
 <YYOaOBKgFQYzT/s/@infradead.org>
 <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
 <6d21ece1-0201-54f2-ec5a-ae2f873d46a3@oracle.com>
 <CAPcyv4hJjcy2TnOv-Y5=MUMHeDdN-BCH4d0xC-pFGcHXEU_ZEw@mail.gmail.com>
In-Reply-To: <CAPcyv4hJjcy2TnOv-Y5=MUMHeDdN-BCH4d0xC-pFGcHXEU_ZEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5f7557e-19b7-4953-f50f-08d99fd18116
x-ms-traffictypediagnostic: BYAPR10MB3512:
x-microsoft-antispam-prvs: <BYAPR10MB3512ADE88FD15BFB98782B41F38D9@BYAPR10MB3512.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1qLVq5OJkFYKdC39HNSImIYwfGOZ49LdZw9dOjhjIoLF9Lxg2MPJq3xhBEJQ7YyN/9UO7rCT+Y2U+TUpneyYna3BO6ohsbTkAvu5SJYmNyxzftBKV29PD5FHHhLrVY+LrkoaxRM0TkMfSE6diXm1n7wL9HtwWRO0npmQamDMJw/32M+y4vuVLRfiaC5mqvURkxNL6qe1Lg21jwmAxHfyMUV6sn45Acs51ga4E6/kQ/UoM2qsW1QIopnwKC1krEd2EL8pX880YkVhxGF+w59a5/RC25KmdtJxH8YSLfujmzVNV8Nn6fnhRnIOZh3qr1PsPYcqKxV0tEjYoVcIKtuceSIvQ+4Qf5ETz0BHHwGGHlT70mor1X9g8ECOUBS7Exo6aXQyKYP602wOKEqwiv1tu0uuolyIT/+lvtREV2l+NGw+ODt1FD8NYpJ5mNZHw+ecgIOXsG3d326nNaINqkJYIZ/h6JPiF9he6UA1gGV7ehf0a9ajo/fKuUS3KfovSA0f6lSwIKzA75plR/G2XArUgJ0zrzjr9uBb8/ouAJ5afcwJVoRxRt7uHp8oNH5tshsk3Ncm8wfZKfObKXh846s64np87wDWb96ReposglMR9g6yq6lP/nuFe0I0N5MLkV9UNVRUTtYbeU+dWZxMGeuWfbw3KyM9scE2XADsAzQh2gInZ3kqlUgKfUgBXF+xQjeOPqhV9XeyHUPCQxirCsjhTZu/9hSOv/LcXQnToRXbkDjkB62w8VFmPE81b/EJUQo1HESM0P43u6HAXsHwQrbZOf8bmLCHfQO8jtk0uCUZH0MVS1bGA/44IEvmyPpvZKV4Lxq+rwlrx/xMkc+KWxMGv90Tc1r+EXTVRRmLR0R8co=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(91956017)(76116006)(66556008)(66946007)(6506007)(66476007)(186003)(316002)(2616005)(83380400001)(5660300002)(2906002)(31686004)(64756008)(66446008)(31696002)(7416002)(8936002)(6512007)(54906003)(71200400001)(26005)(44832011)(86362001)(4326008)(966005)(38070700005)(6916009)(8676002)(36756003)(6486002)(122000001)(508600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTNSUE16MjgvUUlHMHg4L0JLbjRYZFBTaEJ0cW11ck9pVDVtYnlhWGd5Y1Rx?=
 =?utf-8?B?THpzY2tRSDlnZUorS2VHeDJ4YWtGaFNwamJKMnB4aHJ0eTllc2NjcElNK1BJ?=
 =?utf-8?B?TlhsRFJNdWFEbm8yc2VKVHZEM2VHbkwvNmdSSlo2MGJkRm0vMGVPOWVZWGpn?=
 =?utf-8?B?MDVDRm04NUxXcmg4S1BZZmhlVkRJcWlJWStNWERtRkR5MlFxL2V3UDBHNUVB?=
 =?utf-8?B?UEtUS1ovUkxsVTNGQkhCUlc0aTZQNlFTUlFwK2Q5T0huSUtxNUxxYTJtdnd0?=
 =?utf-8?B?RzVCRmxzd1BGcE1tNVlIaFNEekFYaDBTcTRHaFN5L00xbTZkWUVsSzdtMUtG?=
 =?utf-8?B?RFRLbVZsMDhaMTlSMVQ2QXhJcUlqUmlreFd0Q0QzNEhVb0ZGL3FoNStvQ215?=
 =?utf-8?B?bTJDbjJoK1FYUHJWRHFWRTlJSVhaNGIvNDVqK2FnQWpiUkwxZnNPbFFkNHN0?=
 =?utf-8?B?MjhicVFZd0NlWTJhZFVQcHdEOGlCVFVST29uNThvb1NWQlE5aGNiczV1aVky?=
 =?utf-8?B?b2cwRUJHOGRpTzNyMHdVNUxYQ3dETHZCb2xJTGg2Y2FaK25WKzI0MWhpVFRj?=
 =?utf-8?B?eVRPdWR5RlpqcUhmOElWSnAycStaczA2Sk44bGxpUDhWN0Mwa3kvUEJsaGE4?=
 =?utf-8?B?MTJvckswdHZYYU4wRFBHbVZwNE0xQW5DSXFZeGp1WUVzVlB5SlNIUTNFeDVy?=
 =?utf-8?B?aWk5ZmVkUFNwc21qelNuR3ROeFBnYkpuOStvVGcrODM3M2VSVDFGZlFTSkRm?=
 =?utf-8?B?WWFqY0g5bTlma0xlZVZscUI2TERGMEZremJDenFsd0JmZjJJNmtYb3RvRkNN?=
 =?utf-8?B?bTNpQlh1VjNMc0Y4cE1ZM1dCYkZTcWZ0NUFoVFJ6YUhNMnQ5QnR5VjBxRnB6?=
 =?utf-8?B?cW9HcjVTMzVyTWJIdEZnY2I0ZS9mYUpScy93NzZKLy9ITkRLb0VlY1poN3ZT?=
 =?utf-8?B?VTZRSGRtOGMzeUFoeURnN1JFSWg3QkxaaHR0d2dWSlExOXpIQ1l0RXJUWGlW?=
 =?utf-8?B?N3V3V3Z6OVpDMDVOTWpqY0ZoWnpqRnh6MVlWMnV0NzczK0w1aU1IWnQzckov?=
 =?utf-8?B?WTF3bXpibVd6bFdnQWhaRGs1aldlM3FmRHdkK1ZaTFQ0ZmE3TGFXMExCQUFK?=
 =?utf-8?B?Smc4bU5wNmhnalphNGIzUmtiV09qRHZ3SmY1YmpvVExuZ1BXa05xS3pqTzNl?=
 =?utf-8?B?M2tLSDZsSXhJeG9MamNqM1JhSEpnanYyZjA4c1pMeTRnNkNlUVNuUWJERHBm?=
 =?utf-8?B?RWxaNEpvaVVqU2cvaVhDUElSVkl0KzkwS3lLdm1kU25ZOXpiOE0wakpjVCti?=
 =?utf-8?B?UVpJc01sSmJWMHVzZ0NYWXJoYnVXZFoxNXlzcUZwY21SblplTDBTWkN5OTVQ?=
 =?utf-8?B?RGZIYXdUbUVzUWlrdlFFY2t2NkkxQUJnNmxjSVU3N0JNZjhYdWFKT0xERWdi?=
 =?utf-8?B?RW1LREFtZkdyNC83T0d5aHFBTlNrTEZ6SzhBNU5Fb1hHMmo0MXF5eC81VVRY?=
 =?utf-8?B?RGF2UTVKK1ArSnZYMnFGZmgzTG1oa0dWbU1hSzBNc3I0RDRUTTZIeERDNzBr?=
 =?utf-8?B?d3pSNTV1eTBQak5uMnVCQlhYNDM0amhTWDU0OVZRVTdMR3hJaTMvejZSdUxY?=
 =?utf-8?B?aFhRUU1rS2Z4VXZ0aGwvN21uUTZ1dFI3RXZLdm9qb2dUcXc3RnFQRHg0dmNj?=
 =?utf-8?B?NnZIRDJVY1pCeU9aK3RFaXJzT0VXKys5VlNDMmhHRDQzb0NBYXM5clhIVU1D?=
 =?utf-8?B?TWlaS2w4ckdoUnlSM3NZeTZwc2RwTWp3ZGdxVFhHcmErek1oUVdKNDRkQmFa?=
 =?utf-8?B?VkhtbGY3WDQ5TEt5WTErV282ZFhTOXVTcUFYRGVOMnIwYzlYMXM1OFh0SzYv?=
 =?utf-8?B?cWg5L29tdkhYdlJReVRPN1o5VEszM2REVE5ib3dqS1FXamZwT29jR044OE5D?=
 =?utf-8?B?WDgwdmJqWVRYcUJrREtTVG1aSnNtLzFrVlM3bjZvRVVRN2pHTEdaRmFOTGtw?=
 =?utf-8?B?RkNpa3RCckhTdjhwanpKbzkxVjJLVGdObURJL252V0k0T0ZkTWFUK1J3eVZG?=
 =?utf-8?B?VDJVQm10OTdLNzU2K2k3ZFJkYkNMYkhMVUhlek1HajZHUDl5MzJDSUhrSzlw?=
 =?utf-8?B?cUxEVkVvMDRLOG5DUXY0YjdOTjVRT2pYcElxdXhDQ3Rud204WkNacmZ0eGw5?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01DCC2ACCEEBC54EBF7311E72E96B3BD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f7557e-19b7-4953-f50f-08d99fd18116
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 20:27:21.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwTZ8tAJo9JoIQXbJsnre4zoiwrl2GNkI63NifPwmqew6+15Gndyr3A/HhATlxfXqSHlDfGgX3F04LTr7IyIkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3512
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040079
X-Proofpoint-ORIG-GUID: -RF93fyzrJTKJjpOAWzZi2b8YO7cagdY
X-Proofpoint-GUID: -RF93fyzrJTKJjpOAWzZi2b8YO7cagdY
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNC8yMDIxIDEyOjAwIFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQoNCj4+DQo+PiBJZiB0
aGlzIHVuZGVyc3RhbmRpbmcgaXMgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbiwgdGhlbiBJJ2QgbGlr
ZSB0bw0KPj4gcHJvcG9zZSBiZWxvdyBjaGFuZ2VzIHRvDQo+PiAgICAgZGF4X2RpcmVjdF9hY2Nl
c3MoKSwgZGF4X2NvcHlfdG8vZnJvbV9pdGVyKCksIHBtZW1fY29weV90by9mcm9tX2l0ZXIoKQ0K
Pj4gICAgIGFuZCB0aGUgZG0gbGF5ZXIgY29weV90by9mcm9tX2l0ZXIsIGRheF9pb21hcF9pdGVy
KCkuDQo+Pg0KPj4gMS4gZGF4X2lvbWFwX2l0ZXIoKSByZWx5IG9uIGRheF9kaXJlY3RfYWNjZXNz
KCkgdG8gZGVjaWRlIHdoZXRoZXIgdGhlcmUNCj4+ICAgICAgaXMgbGlrZWx5IG1lZGlhIGVycm9y
OiBpZiB0aGUgQVBJIHdpdGhvdXQgREFYX0ZfUkVDT1ZFUlkgcmV0dXJucw0KPj4gICAgICAtRUlP
LCB0aGVuIHN3aXRjaCB0byByZWNvdmVyeS1yZWFkL3dyaXRlIGNvZGUuICBJbiByZWNvdmVyeSBj
b2RlLA0KPj4gICAgICBzdXBwbHkgREFYX0ZfUkVDT1ZFUlkgdG8gZGF4X2RpcmVjdF9hY2Nlc3Mo
KSBpbiBvcmRlciB0byBvYnRhaW4NCj4+ICAgICAgJ2thZGRyJywgYW5kIHRoZW4gY2FsbCBkYXhf
Y29weV90by9mcm9tX2l0ZXIoKSB3aXRoIERBWF9GX1JFQ09WRVJZLg0KPiANCj4gSSBsaWtlIGl0
LiBJdCBhbGxvd3MgZm9yIGFuIGF0b21pYyB3cml0ZStjbGVhciBpbXBsZW1lbnRhdGlvbiBvbg0K
PiBjYXBhYmxlIHBsYXRmb3JtcyBhbmQgY29vcmRpbmF0ZXMgd2l0aCBwb3RlbnRpYWxseSB1bm1h
cHBlZCBwYWdlcy4gVGhlDQo+IGJlc3Qgb2YgYm90aCB3b3JsZHMgZnJvbSB0aGUgZGF4X2NsZWFy
X3BvaXNvbigpIHByb3Bvc2FsIGFuZCBteSAidGFrZQ0KPiBhIGZhdWx0IGFuZCBkbyBhIHNsb3ct
cGF0aCBjb3B5Ii4NCj4gDQo+PiAyLiB0aGUgX2NvcHlfdG8vZnJvbV9pdGVyIGltcGxlbWVudGF0
aW9uIHdvdWxkIGJlIGxhcmdlbHkgdGhlIHNhbWUNCj4+ICAgICAgYXMgaW4gbXkgcmVjZW50IHBh
dGNoLCBidXQgc29tZSBjaGFuZ2VzIGluIENocmlzdG9waCdzDQo+PiAgICAgICdkYXgtZGV2aXJ0
dWFsaXplJyBtYXliZSBrZXB0LCBzdWNoIGFzIERBWF9GX1ZJUlRVQUwsIG9idmlvdXNseQ0KPj4g
ICAgICB2aXJ0dWFsIGRldmljZXMgZG9uJ3QgaGF2ZSB0aGUgYWJpbGl0eSB0byBjbGVhciBwb2lz
b24sIHNvIG5vIG5lZWQNCj4+ICAgICAgdG8gY29tcGxpY2F0ZSB0aGVtLiAgQW5kIHRoaXMgYWxz
byBtZWFucyB0aGF0IG5vdCBldmVyeSBlbmRwb2ludA0KPj4gICAgICBkYXggZGV2aWNlIGhhcyB0
byBwcm92aWRlIGRheF9vcC5jb3B5X3RvL2Zyb21faXRlciwgdGhleSBtYXkgdXNlIHRoZQ0KPj4g
ICAgICBkZWZhdWx0Lg0KPiANCj4gRGlkIEkgbWlzcyB0aGlzIHNlcmllcyBvciBhcmUgeW91IHRh
bGtpbmcgYWJvdXQgdGhpcyBvbmU/DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIx
MTAxODA0NDA1NC4xNzc5NDI0LTEtaGNoQGxzdC5kZS8NCg0KSSB3YXMgcmVmZXJyaW5nIHRvDQog
DQpodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0L3Nob3J0bG9nL3Jl
ZnMvaGVhZHMvZGF4LWRldmlydHVhbGl6ZQ0KdGhhdCBoYXMgbm90IGNvbWUgb3V0IHlldCwgSSBz
YWlkIGVhcmx5IG9uIHRoYXQgSSdsbCByZWJhc2Ugb24gaXQsDQpidXQgbG9va3MgbGlrZSB3ZSBz
dGlsbCBuZWVkIHBtZW1fY29weV90by9mcm9tX2l0ZXIoKSwgc28uDQoNCj4gDQo+PiBJJ20gbm90
IHN1cmUgYWJvdXQgbm92YSBhbmQgb3RoZXJzLCBpZiB0aGV5IHVzZSBkaWZmZXJlbnQgJ3dyaXRl
JyBvdGhlcg0KPj4gdGhhbiB2aWEgaW9tYXAsIGRvZXMgdGhhdCBtZWFuIHRoZXJlIHdpbGwgYmUg
bmVlZCBmb3IgYSBuZXcgc2V0IG9mDQo+PiBkYXhfb3AgZm9yIHRoZWlyIHJlYWQvd3JpdGU/DQo+
IA0KPiBObywgdGhleSdyZSBvdXQtb2YtdHJlZSB0aGV5J2xsIGFkanVzdCB0byB0aGUgc2FtZSBp
bnRlcmZhY2UgdGhhdCB4ZnMNCj4gYW5kIGV4dDQgYXJlIHVzaW5nIHdoZW4vaWYgdGhleSBnbyB1
cHN0cmVhbS4NCj4gDQo+PiB0aGUgMy1pbi0xIGJpbmRpbmcgd291bGQgYWx3YXlzIGJlDQo+PiBy
ZXF1aXJlZCB0aG91Z2guIE1heWJlIHRoYXQnbGwgYmUgYW4gb25nb2luZyBkaXNjdXNzaW9uPw0K
PiANCj4gWWVhaCwgbGV0J3MgY3Jvc3MgdGhhdCBicmlkZ2Ugd2hlbiB3ZSBjb21lIHRvIGl0Lg0K
PiANCj4+IENvbW1lbnRzPyBTdWdnZXN0aW9ucz8NCj4gDQo+IEl0IHNvdW5kcyBncmVhdCB0byBt
ZSENCj4gDQoNClRoYW5rcyEgIEknbGwgc2VuZCBvdXQgYW4gdXBkYXRlZCBwYXRjaHNldCB3aGVu
IGl0J3MgcmVhZHkuDQoNCi1qYW5lDQoNCg0K
