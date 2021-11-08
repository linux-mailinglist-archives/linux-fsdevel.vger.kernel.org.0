Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73331449D84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhKHVFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:05:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59068 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbhKHVFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:05:38 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8KwSH1031546;
        Mon, 8 Nov 2021 21:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1QDy7qV5F0LQWp20lgFpbTVoXPuoGdTbFQXR1gybb1w=;
 b=O1Vtt1To4RcQ2s7TfToMVnb7HJt3chfNCS4KqYQIrkf2qAa43pxWABUAl2bvCK71ti+i
 yMHHXl7DsjMdDbiYMBdFuAMeuLq6pIfugSN+4DfmXr3Erl25+as6iIl5g7hFyJVcH3JH
 mdIv8Q0eQWfAUyV9KSECGPARWA/I6thRQpgYWlp5f9Uuwc19KD1dWMa9/147ZkXZHPDx
 HtYdi4rjlhuJEEN3OhaMIg5sjB1aXYKFhfn6q5yOv/CZa2IR74NLRHaogBLouYP8y9u0
 HmwMDWbPSQ0eaBZDSUMgEMxWbMYIwD4VRmwqSEAH+sGYNKFWZjRcVlqQPHHn0cVBjijB ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6usne8jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 21:02:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8L0dWC133780;
        Mon, 8 Nov 2021 21:02:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3c63frw3hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 21:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy29i2JP3cJuLnjTpRHxfbeJ43GEJTHCs+tdvnIJxLYiBDiLCQRCXXCW84c2KhKMyhjeY9s+56hQa8h7Y70YaANPHCNuEXmSRHkdTSuy5cgqT8Ld+KN63oJrPlSZYprWR0INjrBgvCaD21rGKMdLufomzHvpljH4IG62/ORIIlDcBnASwNkH9V1gnp6Sqv+OVbRt0PNqz/MpIMYA+HUJWoBgwOk7RrpRuecL/Axu1wo62dnfTuJPRMyZfqLv5ZxQVOM3lmk3l1eoQXvv0YTPguvE2UV0C2ieInhLDH5gsWW2TSDKvdBZWQYbfXBP5kUm/mlt80+43BgyUfuBbm1ICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QDy7qV5F0LQWp20lgFpbTVoXPuoGdTbFQXR1gybb1w=;
 b=IgE+4hot74Zg0BKaENW5VmpmGUygUOH3Z3Eau4MuId3B0N1K0jL+8JuGcuG6StcstM9rhLBFkt6JIe7v7fHPZgE0IPDI23y40t886g3Bf+YqDooqOgaQjZF26gPhiST871OcqsrL9uf2l+diolFlJhVepnYzHz3kloXyk5dFoYUGexf64r76zeeQ2IuE1hJQH+ffBDXqZICmMJwGDt0EzXAFp4Bu2a+DX/CIRCstXn0ffoPfCubqyCFEws49L0ALATfn1iEiM4narm/f5pHUH5d24a/3GkM0sdKi7/wp5h9Al2VjU/cfCa3JsOMJ6svr3Jt9X1yNkS9s7JMXh9Jkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QDy7qV5F0LQWp20lgFpbTVoXPuoGdTbFQXR1gybb1w=;
 b=kmm+QC1+0dNpdCx4oY9YQqWXxfsClpZdpvruuXHwn5+wvH9qEdD6DozEr2foYfajIgW7qyXzlxMi385fXPbxy7UhC/o751WonmMoefMgXwWglpmOIqKV7T4AKq+8paCr8akBTicazylh5SUOe4YX7rzhAOue1uIKzZTvZcASwWo=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3335.namprd10.prod.outlook.com (2603:10b6:a03:15d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 21:02:29 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 21:02:29 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation
 modes
Thread-Topic: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation
 modes
Thread-Index: AQHX0qwD5+Ie66qqNUGG2WP/amHP1av2tvUAgANrlIA=
Date:   Mon, 8 Nov 2021 21:02:29 +0000
Message-ID: <63f89475-7a1f-e79e-7785-ba996211615b@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-2-jane.chu@oracle.com>
 <CAPcyv4jcgFxgoXFhWL9+BReY8vFtgjb_=Lfai-adFpdzc4-35Q@mail.gmail.com>
In-Reply-To: <CAPcyv4jcgFxgoXFhWL9+BReY8vFtgjb_=Lfai-adFpdzc4-35Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be211d7c-7795-446a-9989-08d9a2fb1387
x-ms-traffictypediagnostic: BYAPR10MB3335:
x-microsoft-antispam-prvs: <BYAPR10MB3335F92E042F027BAF0F8B34F3919@BYAPR10MB3335.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHPOoHYgKNxd9S2wYOnW0zE/E3bRbriOhZxvihR7Rzj/8TKbArdBYcYb4/GIu6Qbp384oPX8UxPxgdjt0rD6Jo3h8NAVfG8VHIxWzYGFJo5BowWeY5oayer+c2qUcCAun0IuCUPboE4Agw78Rv3O85+TidkMOyY7XgpEKwayIlVepJ+HX1COkcPNujM/daDYOsKXIiImTfUB8GSL5kAhMyoiH5MoyuvGQCdyCx5yiGr0ZKaAGWcltu79Zo2hn37JJ5YxMJSIcOr+QLJyTIMX9Jaf4qr1lbQTUEI676lnhNQ2pbeX9fvH7EUJn9w4f1zEP6hEB4/WdzoU3wyeQJqmxgRZ47ddLPWAeJk6RJDDAR+/JEA9CO78NKcKHJNvK98TJofqD0GYwlF77SjVHdt2C0hQ3IPndFuJ3lYdggTdH3eiPuGRDrc2OomgMFFUUPO5dZrW831pbGOGxpQSu2WsltiF2LQtapIut0BEgLHWcM8gvojTe7rDBLzk9iB4EZf+msxywyZoNYt7xbNyJb90W/o1rVjHdXEtoNPQuivmpGNaK9D/QS+U1LuRLTWmLdb1akrHDEGJ6rYGAY25fhwGCfjj4ZIlAWbACOmkFPMVohBo5MGsPz4C9uDVrpNlWD3r0Pzi+Gw1zzW4gqVOMlQa/v9uCB1263E2RfjChZcgfzEXV2TmyLodem3IPuSedbd4m+YpEcwFEM8nWYn1h++sMhA+QFFyAsta1tmHU/Y2AJuVM8Iapzl41N8DutpXgh3I3a5H0RzaCmxRc2tunA71ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(91956017)(83380400001)(316002)(66476007)(122000001)(66556008)(66446008)(53546011)(38070700005)(64756008)(36756003)(86362001)(76116006)(54906003)(5660300002)(38100700002)(66946007)(8936002)(508600001)(6512007)(6506007)(71200400001)(2906002)(186003)(6486002)(2616005)(31696002)(7416002)(44832011)(6916009)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGMrOHZkVHBrazJpWjlrQnFKT1hieDFMZVdYZjlkdmQ1ckNrMkpxZmFJWkhv?=
 =?utf-8?B?YllYa0hFckVybUVrUUw0L05FTjhscEhRb3MrZGVobUJTZ3dkR0JDRmVxSlkz?=
 =?utf-8?B?WmhzUEkwbHo4WFhaWUdWU1dCcnFrUFpzTlZHcmlPa0ZlME9TTHdYMDh1V2Yx?=
 =?utf-8?B?SVk0dm1vUzcrVVd0bWZyVEVpbEI1TG5nNnZkT0RQK093ZXczNkZvcDFUT1Vq?=
 =?utf-8?B?Y0h2blYxcmpSblo5YXNjWXBwZGw3dzF0SUMrdlgwTktQNVZtcnRWUmRWQ2dr?=
 =?utf-8?B?TDVJMjVSb1pIc3NOVnVUbDN5TndmUmMvQkpEWmJkdCtGZDZ5UTcyTWV6QURW?=
 =?utf-8?B?cEtDS1NDbzA2SWNMd0MxQU9HeTBVaSt4ZFNPZldySFRuaHU2SXhKZTlVQUgv?=
 =?utf-8?B?QnlYNm5SUTZOczJscVEzd3AwVjNaNDFDT2h6dXNIK3NMU3p6ZkJreUQ3VHJ2?=
 =?utf-8?B?dVhoejZvSGcvL2Y1ODA2d0lZZ0V0MlVpQnlnTG5sOHoxeDErL09PM3NWVHNy?=
 =?utf-8?B?b2ZSMk9vL3BUNFhSRXRHUThJK2s2SDk1dzlTMmM2RVpwaFZHOVU4NXQzWmtX?=
 =?utf-8?B?UnhVbXJhWE5yTlZONi9ubkd6cXAwQSt3VkJnQ2NQNFAxZmdFREJjMjQ2NG5D?=
 =?utf-8?B?ZnRWWHc4VW5ybnpMRFdTTU9VSUQxL2J2d0NLZXJ6ZnYvRmlJa1BVNTJpeHUy?=
 =?utf-8?B?MDdmOFRQQjVCelp0bDliMkNNMmJMY250dWRrc1VVaUJXT3ZxZkphTHVWYXpo?=
 =?utf-8?B?NHgrRmh5YmQ1d0h0V2ladjFCbnRybnk2N3owdnpnbWdkSlRsWWhoVGpTbnFm?=
 =?utf-8?B?c0dhMlB6V2FBV1l0THRSRmx6MjdvVjdQVjZoYW1BMEtPd2p2eUtIdVdPL3Vk?=
 =?utf-8?B?Yld3Uk9RUFRvdk5LUk5RbnY3Smd2MUxia2Z1VVVQS2VyUExiVCtBdjhUdThr?=
 =?utf-8?B?RlNqVTVESVkzTEZmT094OVlSV2xCVVpmdUJYSWtYSzdvM1RNSG1LNGE4K0p0?=
 =?utf-8?B?TnkyeUx6ZWtGa0tzNE5hMmNnQjY4aHhEaUtJMjNzM3N3STZBaCtjK3RpZ0Zw?=
 =?utf-8?B?Tm4vSDFIU0pvZHQ5eVJMdzJWVldJbXdEajdTQjNVTSsvdUZsWXJwNlF0RFFS?=
 =?utf-8?B?YUcrMTYwUDgxWnpEc1EvSW9XRHl2N095bG5ONDg0Tm1tNkF6MUZYcnNYQ3lq?=
 =?utf-8?B?N1FXQnppSTZYVm85UlVYaTF2bDBiSHVLd25tU21oV0RLdlNGUEVSM1FKYlFC?=
 =?utf-8?B?R2MvTUpTUUlGS1Y4NVA2S1BsbzlCSFpDRnF2QU5jR3NzVExTZ2lUeStCOXJV?=
 =?utf-8?B?ZGpuWlRSQUxTZkl2OXR0dHN6RHdkbXppY1doWE5KL0laKzdYL0NUa3ZBVkZk?=
 =?utf-8?B?UCtEYmxWRGV0cENTRG9TMUN1ZlE2WlpKbjZQVENpWllRbGVYaW9hS3lEVnd1?=
 =?utf-8?B?Q0hXS2NienVsQVZabjBxbldUeEJWU1pyKzVZQTgvQnpPSEpvUXJuSk1EbEFz?=
 =?utf-8?B?bVFaNVFmcmZ1WXc4ZHF2Q1NHUG1QM0kyYlhwUkVyc0tzRzErdE9RNFVFcnRw?=
 =?utf-8?B?eWowUTdKUEZ0RkhEUko0ZnZ3RnUrbitvM3pBcDVhUk1JL0VRV0pXdStSUlU4?=
 =?utf-8?B?L3JBbTlEeUJMWmVaVXdINU5la1hJME8yRURtZ2ZXeHRrMDVsQUNTdUVpY0Jp?=
 =?utf-8?B?NVJnejkxVUkyTG5GMCtSYktVWVUwT290WWM3Q2xJMWVuUTVmcUpEMDFLbUlq?=
 =?utf-8?B?RGJNNE5qMytxWCs2bE5MTHNpYnRvV2hpT0dvU3RSZ05BSGdjd1hEczAvUnpW?=
 =?utf-8?B?SVFyV2RvZ1hYOTBSNzlhcUQ5TDNoTGtBejRUYUwrN0lMN21NRy9EejF5TVZE?=
 =?utf-8?B?NTl4QjI5Mng2UUJVMWloY2ROYTM3c0NjMlByYU1RckR5NHB6cXJvMkI5ZlhX?=
 =?utf-8?B?L2w4eVNzQXdZSGVRSlNqeG0vcnF6WS90b0xFVXdoajROMmFpb1h6d1NKSnJy?=
 =?utf-8?B?TjAxeldsMGE4d256TTdiYVpBVEprNDZqL0FVa0x2UGRkTkprNHI4bFMwd0NW?=
 =?utf-8?B?TDFvMTNJZjhmWmgwMGVhdWpqak9SenBJS1U3cVBHSk1LUkNQNEdGS1B3NGsr?=
 =?utf-8?B?ZFo3MVFGbERpc2lDS201dEUySmp6VlpTdFBuUHA1UStOeUFrRU11SUllRG1S?=
 =?utf-8?Q?6TSVcPKuTHruS2/No1VtSq1lz2XluELnUF0kqYrm93Pt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AF8D5C40A3AF6408C3AC88A3D3ECC1E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be211d7c-7795-446a-9989-08d9a2fb1387
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 21:02:29.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHqYZte8HsmAX212q12TExnemHUEoh2FnVILcgXFtSKdv0OnpKqhDCirkgJ6/fQ2ayP8yhG96VjptZo/gHK54Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3335
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080124
X-Proofpoint-ORIG-GUID: 7AJ5FWTfkqp49jGYuzKUx2k233Fkdrzy
X-Proofpoint-GUID: 7AJ5FWTfkqp49jGYuzKUx2k233Fkdrzy
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNi8yMDIxIDk6NDggQU0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gRnJpLCBOb3Yg
NSwgMjAyMSBhdCA2OjE3IFBNIEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+DQo+PiBJbnRyb2R1Y2UgREFYX09QX05PUk1BTCBhbmQgREFYX09QX1JFQ09WRVJZIG9wZXJh
dGlvbiBtb2RlcyB0bw0KPj4ge2RheF9kaXJlY3RfYWNjZXNzLCBkYXhfY29weV9mcm9tX2l0ZXIs
IGRheF9jb3B5X3RvX2l0ZXJ9Lg0KPj4gREFYX09QX05PUk1BTCBpcyB0aGUgZGVmYXVsdCBvciB0
aGUgZXhpc3RpbmcgbW9kZSwgYW5kDQo+PiBEQVhfT1BfUkVDT1ZFUlkgaXMgYSBuZXcgbW9kZSBm
b3IgZGF0YSByZWNvdmVyeSBwdXJwb3NlLg0KPj4NCj4+IFdoZW4gZGF4LUZTIHN1c3BlY3RzIGRh
eCBtZWRpYSBlcnJvciBtaWdodCBiZSBlbmNvdW50ZXJlZA0KPj4gb24gYSByZWFkIG9yIHdyaXRl
LCBpdCBjYW4gZW5hY3QgdGhlIHJlY292ZXJ5IG1vZGUgcmVhZCBvciB3cml0ZQ0KPj4gYnkgc2V0
dGluZyBEQVhfT1BfUkVDT1ZFUlkgaW4gdGhlIGFmb3JlbWVudGlvbmVkIEFQSXMuIEEgcmVhZA0K
Pj4gaW4gcmVjb3ZlcnkgbW9kZSBhdHRlbXB0cyB0byBmZXRjaCBhcyBtdWNoIGRhdGEgYXMgcG9z
c2libGUNCj4+IHVudGlsIHRoZSBmaXJzdCBwb2lzb25lZCBwYWdlIGlzIGVuY291bnRlcmVkLiBB
IHdyaXRlIGluIHJlY292ZXJ5DQo+PiBtb2RlIGF0dGVtcHRzIHRvIGNsZWFyIHBvaXNvbihzKSBp
biBhIHBhZ2UtYWxpZ25lZCByYW5nZSBhbmQNCj4+IHRoZW4gd3JpdGUgdGhlIHVzZXIgcHJvdmlk
ZWQgZGF0YSBvdmVyLg0KPj4NCj4+IERBWF9PUF9OT1JNQUwgc2hvdWxkIGJlIHVzZWQgZm9yIGFs
bCBub24tcmVjb3ZlcnkgY29kZSBwYXRoLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphbmUgQ2h1
IDxqYW5lLmNodUBvcmFjbGUuY29tPg0KPiBbLi5dDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9kYXguaCBiL2luY2x1ZGUvbGludXgvZGF4LmgNCj4+IGluZGV4IDMyNDM2M2I3OThlYy4u
OTMxNTg2ZGYyOTA1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9kYXguaA0KPj4gKysr
IGIvaW5jbHVkZS9saW51eC9kYXguaA0KPj4gQEAgLTksNiArOSwxMCBAQA0KPj4gICAvKiBGbGFn
IGZvciBzeW5jaHJvbm91cyBmbHVzaCAqLw0KPj4gICAjZGVmaW5lIERBWERFVl9GX1NZTkMgKDFV
TCA8PCAwKQ0KPj4NCj4+ICsvKiBkYXggb3BlcmF0aW9uIG1vZGUgZHluYW1pY2FsbHkgc2V0IGJ5
IGNhbGxlciAqLw0KPj4gKyNkZWZpbmUgICAgICAgIERBWF9PUF9OT1JNQUwgICAgICAgICAgIDAN
Cj4gDQo+IFBlcmhhcHMgdGhpcyBzaG91bGQgYmUgY2FsbGVkIERBWF9PUF9GQUlMRkFTVD8NCg0K
U3VyZS4NCg0KPiANCj4+ICsjZGVmaW5lICAgICAgICBEQVhfT1BfUkVDT1ZFUlkgICAgICAgICAx
DQo+PiArDQo+PiAgIHR5cGVkZWYgdW5zaWduZWQgbG9uZyBkYXhfZW50cnlfdDsNCj4+DQo+PiAg
IHN0cnVjdCBkYXhfZGV2aWNlOw0KPj4gQEAgLTIyLDggKzI2LDggQEAgc3RydWN0IGRheF9vcGVy
YXRpb25zIHsNCj4+ICAgICAgICAgICAqIGxvZ2ljYWwtcGFnZS1vZmZzZXQgaW50byBhbiBhYnNv
bHV0ZSBwaHlzaWNhbCBwZm4uIFJldHVybiB0aGUNCj4+ICAgICAgICAgICAqIG51bWJlciBvZiBw
YWdlcyBhdmFpbGFibGUgZm9yIERBWCBhdCB0aGF0IHBmbi4NCj4+ICAgICAgICAgICAqLw0KPj4g
LSAgICAgICBsb25nICgqZGlyZWN0X2FjY2Vzcykoc3RydWN0IGRheF9kZXZpY2UgKiwgcGdvZmZf
dCwgbG9uZywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKiosIHBmbl90ICopOw0K
Pj4gKyAgICAgICBsb25nICgqZGlyZWN0X2FjY2Vzcykoc3RydWN0IGRheF9kZXZpY2UgKiwgcGdv
ZmZfdCwgbG9uZywgaW50LA0KPiANCj4gV291bGQgYmUgbmljZSBpZiB0aGF0ICdpbnQnIHdhcyBh
biBlbnVtLCBidXQgSSdtIG5vdCBzdXJlIGEgbmV3DQo+IHBhcmFtZXRlciBpcyBuZWVkZWQgYXQg
YWxsLCBzZWUgYmVsb3cuLi4NCg0KTGV0J3MgZG8geW91ciBzdWdnZXN0aW9uIGJlbG93LiA6KQ0K
DQo+IA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoqLCBwZm5fdCAq
KTsNCj4+ICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgKiBWYWxpZGF0ZSB3aGV0aGVyIHRoaXMg
ZGV2aWNlIGlzIHVzYWJsZSBhcyBhbiBmc2RheCBiYWNraW5nDQo+PiAgICAgICAgICAgKiBkZXZp
Y2UuDQo+PiBAQCAtMzIsMTAgKzM2LDEwIEBAIHN0cnVjdCBkYXhfb3BlcmF0aW9ucyB7DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2VjdG9yX3QsIHNlY3Rvcl90KTsNCj4+ICAgICAgICAg
IC8qIGNvcHlfZnJvbV9pdGVyOiByZXF1aXJlZCBvcGVyYXRpb24gZm9yIGZzLWRheCBkaXJlY3Qt
aS9vICovDQo+PiAgICAgICAgICBzaXplX3QgKCpjb3B5X2Zyb21faXRlcikoc3RydWN0IGRheF9k
ZXZpY2UgKiwgcGdvZmZfdCwgdm9pZCAqLCBzaXplX3QsDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgaW92X2l0ZXIgKik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgaW92X2l0ZXIgKiwgaW50KTsNCj4gDQo+IEknbSBub3Qgc3VyZSB0aGUgZmxhZyBpcyBuZWVk
ZWQgaGVyZSBhcyB0aGUgInZvaWQgKiIgY291bGQgY2FycnkgYQ0KPiBmbGFnIGluIHRoZSBwb2lu
dGVyIHRvIGluZGljYXRlIHRoYXQgaXMgYSByZWNvdmVyeSBrYWRkci4NCg0KQWdyZWVkLg0KDQo+
IA0KPj4gICAgICAgICAgLyogY29weV90b19pdGVyOiByZXF1aXJlZCBvcGVyYXRpb24gZm9yIGZz
LWRheCBkaXJlY3QtaS9vICovDQo+PiAgICAgICAgICBzaXplX3QgKCpjb3B5X3RvX2l0ZXIpKHN0
cnVjdCBkYXhfZGV2aWNlICosIHBnb2ZmX3QsIHZvaWQgKiwgc2l6ZV90LA0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGlvdl9pdGVyICopOw0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGlvdl9pdGVyICosIGludCk7DQo+IA0KPiBTYW1lIGNvbW1lbnQgaGVyZS4N
Cj4gDQo+PiAgICAgICAgICAvKiB6ZXJvX3BhZ2VfcmFuZ2U6IHJlcXVpcmVkIG9wZXJhdGlvbi4g
WmVybyBwYWdlIHJhbmdlICAgKi8NCj4+ICAgICAgICAgIGludCAoKnplcm9fcGFnZV9yYW5nZSko
c3RydWN0IGRheF9kZXZpY2UgKiwgcGdvZmZfdCwgc2l6ZV90KTsNCj4+ICAgfTsNCj4+IEBAIC0x
ODYsMTEgKzE5MCwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZGF4X3JlYWRfdW5sb2NrKGludCBp
ZCkNCj4+ICAgYm9vbCBkYXhfYWxpdmUoc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYpOw0KPj4g
ICB2b2lkICpkYXhfZ2V0X3ByaXZhdGUoc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYpOw0KPj4g
ICBsb25nIGRheF9kaXJlY3RfYWNjZXNzKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LCBwZ29m
Zl90IHBnb2ZmLCBsb25nIG5yX3BhZ2VzLA0KPj4gLSAgICAgICAgICAgICAgIHZvaWQgKiprYWRk
ciwgcGZuX3QgKnBmbik7DQo+PiArICAgICAgICAgICAgICAgaW50IG1vZGUsIHZvaWQgKiprYWRk
ciwgcGZuX3QgKnBmbik7DQo+IA0KPiBIb3cgYWJvdXQgZGF4X2RpcmVjdF9hY2Nlc3MoKSBjYWxs
aW5nIGNvbnZlbnRpb24gc3RheXMgdGhlIHNhbWUsIGJ1dA0KPiB0aGUga2FkZHIgaXMgb3B0aW9u
YWxseSB1cGRhdGVkIHRvIGNhcnJ5IGEgZmxhZyBpbiB0aGUgbG93ZXIgdW51c2VkDQo+IGJpdHMu
IFNvOg0KPiANCj4gdm9pZCAqKmthZGRyID0gTlVMTDsgLyogY2FsbGVyIG9ubHkgY2FyZXMgYWJv
dXQgdGhlIHBmbiAqLw0KPiANCj4gdm9pZCAqZmFpbGZhc3QgPSBOVUxMOw0KPiB2b2lkICoqa2Fk
ZHIgPSAmZmFpbGZhc3Q7IC8qIGNhbGxlciB3YW50cyAtRUlPIG5vdCByZWNvdmVyeSAqLw0KPiAN
Cj4gdm9pZCAqcmVjb3ZlcnkgPSAodm9pZCAqKSBEQVhfT1BfUkVDT1ZFUlk7DQo+IHZvaWQgKipr
YWRkciA9ICZyZWNvdmVyeTsgLyogY2FsbGVyIHdhbnRzIHRvIGNhcmVmdWxseSBhY2Nlc3MgcGFn
ZShzKQ0KPiBjb250YWluaW5nIHBvaXNvbiAqLw0KPiANCg0KR290IGl0Lg0KDQp0aGFua3MhDQot
amFuZQ0KDQo=
