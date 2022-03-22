Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582F44E4911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiCVWVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCVWVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:21:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A90554AF;
        Tue, 22 Mar 2022 15:19:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxaMD012125;
        Tue, 22 Mar 2022 22:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0fsiwdG4c6x4V6+KYtIyFId2KECv648I/FyybFMd/N8=;
 b=N1UpbtQAB6nFtu+3iJS0E+YR7eJMJzZ2zdYqY9VL607TCz8GFrJ3izgJMpivPjKZ62rR
 Q1fc+RJHASg3EUMEEzFOW/tWKpllGfDwv9rQUEaUDPXQ+LR8yexg7IJivDruewKZPwI5
 Ty7aN2cx11gCtBVegVHTjTVL0J8LRs5VQSZT4Uluh7wDod+Ym7MV1z8rLn22DObRsppG
 53anZox8/zcnRafagAYO14hYZR7OacSE358ojTQBQCSl9o4/lks92S9jjxF5307roItN
 o9nt8zOgsKu3H7NUI7bdmqPQUaemOy/g68ZecLquqrnpbFQukiTOJbgw5EMGyI0iLGIt ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0qxj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 22:19:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MMCDxH068420;
        Tue, 22 Mar 2022 22:19:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3ew49r84pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 22:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYcaiU9d4fnmmydjPFeOQ9wloeD9vl1Z3uVJGpYEjyh0JQY9zgSJc7152UX+aIj9+6ExavwKPkNUf80lpMEJRKHm0DwTGBQ1mlFIX1fvJawAVy+xavnNyxgZ9Hyjg14DSl6yw+rRtxu2jTO+fc5Psqt2KvJqtoOYRWyQXEAKN0z2urJUf8n4TlpCi0SmSoDA1Om52z7C+QxkO5WVJ3XGQkyz6A8rlemOEj2j59+u6x7WycrE6VSGWrAdNyyRQF0ZKo1z2WwpKdjdti0EtrkAbpo67Voxo3T7ptwMIvIRkP/l8xUxhbEGEfD0NoiJMC2bdp5yGw4J6MGEQ3gia0RWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fsiwdG4c6x4V6+KYtIyFId2KECv648I/FyybFMd/N8=;
 b=FrraQIw41ME9PTrD+7dIxFCpaMNuu9yadqYF3ovXt4Z0UjkneVq8mNY22gzwuwXGUX+FdXoCKSHQ2SpGm8+YRQu7ZrGq7wXCrzFCUod+Z2F1MFrxpDO0h8j018NyVXN2ifoVD+6coil1cidbBC3RDW/GsvPEVCxybBoOF48TnX5Fu2W0RTXw6LU9d8j4LHztRwKF/9NAAno7Amor2QGzeiLof4MPzAfse+wsjvx601wB566Zbf2Y65L4Vdvz/4CH2Nv96b/IDMx/hiZW1z+WmFIESs7F0znA/2gtgVBNat4OaK8XXmOtH2K2Oio2S53qr+17gXDh7PU1ASjhu3pywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fsiwdG4c6x4V6+KYtIyFId2KECv648I/FyybFMd/N8=;
 b=Ol9+IHU+JjKZE+ssEzavp1puE3a+iNoudK4wQCBGOQu02k31h2sD/orMUgUH7xmoZEfuFW7r7neKuLkcv9fU9wtsrBYRSmQCx3nMLkGiegYOiSjj931az+N6a/X983yyKM+vWYo4vJu8W/DfCkbERsAmEEjMmFDfPe21wO2GDK4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB2970.namprd10.prod.outlook.com (2603:10b6:5:64::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Tue, 22 Mar
 2022 22:19:23 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 22:19:23 +0000
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
Subject: Re: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Thread-Topic: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Thread-Index: AQHYO1ql070j1sj5n0uvCqd0wwFVgKzLGuoAgADkIwA=
Date:   Tue, 22 Mar 2022 22:19:23 +0000
Message-ID: <24879c61-2ca9-491d-d308-ece8e697db30@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-3-jane.chu@oracle.com>
 <YjmMCjDuakvTzRRc@infradead.org>
In-Reply-To: <YjmMCjDuakvTzRRc@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ac9513-06ea-4879-c1bf-08da0c5204ad
x-ms-traffictypediagnostic: DM6PR10MB2970:EE_
x-microsoft-antispam-prvs: <DM6PR10MB297022902A26862389CB3E09F3179@DM6PR10MB2970.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJpLJwrusjXJVUCffw9AhBFLfOzhBtZS3mBVJMkyr8dipav5tuEHqLo8vMdnwUWQfQ/QnrbJ+dlKWR46krZyedCRtY9JV/G8q4CB1ewyTleceztSplJ4InwFHT2RLF5kbTmzVP2RF5Cw9ro1MyxhHWcq01yssIA4NDUnikdMVEJo+bDzj9VXpqvCQTfGAQPSPXFexZTFHXHdzlCUbaa6l3X1Z1jPCFmr0QsuDKhfhbtzKC0KfRzCQ3upNNXHACj/KQZ2sIYT5tyCG3YRoRgMsDbs32NPGSqPLqV6Txu+kGFbtFT3tte3mAFkowRqRjsilN6qZcXyUaQuMez8McphUvvjyli9Vexn3urXvRClCTVV2m71rzsI5CTjTiUEYOnRsy33KP5Q1ez21sFse6Ne6AIjefku8ZGpinrcx7rE4ziMqvnvezFmJbKr3KDAvJ/J6NBTbOFdHHBGpYRN4FsvL1xFLmvnAEqHQr4/wlMvEMW/TebDDOCqBq0bQQ33deoeHxAPMJrXQxUn/nT6tT1vtOKAgYzGy5ylKADF/UsagxvHe+6WbY6s77I3PrJG/thpaiwCf4I2IGnzwFVGuD22ORyVVPf/e5SqWD7lLKo0CP0f+gRu09nOHxrzMSi+hk+DFhIgxN6sWXsImJHWAEPwO5iYG/3VshQh+YtN2fOUWoJEPCMYAXoVpNn/PaX27ypteEncNkSeV5PwH8dZ9AvZdErklCu6sAhjs+nOPgunDx4OVltYFsgGjmhyGQKK6hgU7dD713FmP6d9m/+xAoSrQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(6512007)(44832011)(83380400001)(66446008)(64756008)(66946007)(8676002)(66556008)(66476007)(4326008)(76116006)(53546011)(122000001)(6486002)(6506007)(508600001)(2906002)(316002)(31686004)(2616005)(38070700005)(186003)(26005)(8936002)(54906003)(6916009)(5660300002)(38100700002)(4744005)(31696002)(36756003)(86362001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3dnYUxvbjJvUVdSb2dEZUxSVFBRSjg0cjFKcTVYUXNlNThXUGZxSWpiNWpl?=
 =?utf-8?B?Vlp1ellzQTl1V2JxNUh5YzlpM0NhbVNmbzZsVFlNK3JnSG5wa1QvLzFQa09K?=
 =?utf-8?B?dzZEb2FUTklmdkYvOGlBczBuQXZybmVjRW5tOUhUeGc1cXpmNGN4dkRZcmJN?=
 =?utf-8?B?SzhoV0c2amovcThoSXYvZTBwTUJvd2ZxN0N6bUdVZkZTWUhVMVlVSEZzQXNP?=
 =?utf-8?B?M3ZsQUtZaEs0Qzd6dmVDUlQySllnK1NaNHlzK1picmdvL2hMdVhoZTJ1SytP?=
 =?utf-8?B?QU9iOTVuUi8zNmowU2NJRHZMT25tcm9jYnBlVDlieFRleGt3MVNVcXdQMTND?=
 =?utf-8?B?QkRLMVkzUlpIZjVwcTYrb0M1N1VXSWsxM2I1K3lsM3phT2VBVlE4ZUVkRkpJ?=
 =?utf-8?B?OWZqSHMza2t1ejV4YTRqTHk5Q0dOUmZrSG1OWnRjNjFHZUxUbkdRU1BwVXda?=
 =?utf-8?B?N0xVRVpqUW02a3JCMzhDUmZNS2MwbEU4a3B4dDBmVjlObThmRjJJaUdIWS9j?=
 =?utf-8?B?YXNoZUdwN1NHcnpySUVsRjF3WW5aY1dqS2hFR1hDd0RQd0dEWjhmWGJJK2pF?=
 =?utf-8?B?YXVCaHIybEFNc1BDamFxdklWUkFNb01rbXVraDNRSWFEeHNaQ09NVm5FNUs5?=
 =?utf-8?B?VEFBckp3OXQ1SWY0bE8vMDBWdDAwQWdtbDBXMmN2SkxWVWdNOFVnaVhJckxu?=
 =?utf-8?B?dlp0YUlIdC94SUdrMlBjVXVaTy9FWXFBcU93OFI4KzVFNW9ESXVxYVdXeFRJ?=
 =?utf-8?B?RC90aUZjM3owc3k0MCtoNkFPK3kvMzYrQ0ZQbnZpRmhkajZiVTIyYWdsL0pU?=
 =?utf-8?B?dWlsT1U1b3RMTWtuNERMcWJsMTBmVTQ5eldXc2lNYkNLZXFXd2I1VkFPdlI5?=
 =?utf-8?B?UmR4VUJjMnFjMG9qc3JTS1dIeDlNclJ0ZmdsQUowL0pxY3lZMlZqRmVOenNm?=
 =?utf-8?B?OXZySGcwMTE1akRIUlcwdm9uSjNIQU9TMzE2aVk5RVFLNm1vZzRGdE9DMXVm?=
 =?utf-8?B?TEg3R0ExRDcrOUpLQU5oZlVUU2xYNUJxNXF1eElkZ0dmRzBrNDNlbzAxUWpr?=
 =?utf-8?B?ZHd2emJQWmtaVGsrRVV3QjBYUW1mYnJEM0tUdUlOV3hMWFR1SFV3MVdqWS9m?=
 =?utf-8?B?UVJqek1qOFo3SXZMNVJuUnFvUGJ4WlBLNThjSFNyVkVidU1uQU92dGV3dEZj?=
 =?utf-8?B?Z1BlYUJpQVJQZUh2Z1g2NGZGOWVLMWwvUUlBeTczS2ZvQkhNTVdoaE9rWlRs?=
 =?utf-8?B?SlByeWhsTDJXWWxWVGc3NHhESHZkUmpZT1JyRVFxam1oZmk5Wk9abVZiWHVN?=
 =?utf-8?B?cWRUSWwxaXVxVkNwdm94UndoMkQ5c0h4UkZ2YWh0cEtldVZmeEUveFZhUDlo?=
 =?utf-8?B?dmlwMFdVem1YdUZPREluTWgwRXEyYXNDc0I0RDYwYVZsQjhKaWFVSjI5N0xS?=
 =?utf-8?B?RXhrQU4vc3c5RGNBUVNHdWJxNlVlZk5MeUxoREhHalhOZDRlZ2k4UEJVL1Ex?=
 =?utf-8?B?WEg5ZGZSKzRra0dVd2JFYnZheTNVajlYbTRNM0tadk1heHNmRFF3S3lhS0Fw?=
 =?utf-8?B?akJDMkYwU0FzQW93dE43KzcwUDlCaTNvaCtZdkZURTg5YXdBci9RK0xjRTBL?=
 =?utf-8?B?VGpDanJsbnpGdnpxblNLZU1aclF0ZkJZWGlrckdGemxCQUFkTlhqNWFDYU00?=
 =?utf-8?B?SDlhSi8vNlkwUkNQcXh5ODNoZ2Q1WHE1NVdwNnFreFZESGpjQjNnbnRmNndY?=
 =?utf-8?B?NnpKSWxSRzg0UGZ1TDU3a0xoRXA5V0tFVDJOV0gyR3UxRzk1cHRNMzNTcDYy?=
 =?utf-8?B?aXJDcVlFT05EOEEyeTVmM2dXL2FVWkwzbHhoaG5veGNXbk9OMjFCNW1ycGFX?=
 =?utf-8?B?MVRXM0JySytuSDB0eStaK2Q2WXBSNmdPaEMrcHdWQjJ2bkI2RHBRemtDZ2lI?=
 =?utf-8?Q?1NGTxqslPKRE4z8D12qYwdcjCxjrLdMT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B9F707AFBDBC4D99FE4370CD727EA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ac9513-06ea-4879-c1bf-08da0c5204ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 22:19:23.0913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fk1Kx61/u3Mf/RpByLp8zojoJiDx2nYCb24z50mrbAs7rp8JlqAeqTJOEjfJwqBJfFVPLQJeaztP2yxu6w9/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=851 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220112
X-Proofpoint-GUID: b9i48SWmYCjRP21DO05xMn5nHZr3rWod
X-Proofpoint-ORIG-GUID: b9i48SWmYCjRP21DO05xMn5nHZr3rWod
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMi8yMDIyIDE6NDIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gK0VYUE9S
VF9TWU1CT0woc2V0X21jZV9ub3NwZWMpOw0KPiANCj4gTm8gbmVlZCBmb3IgdGhpcyBleHBvcnQg
YXQgYWxsLg0KDQpJbmRlZWQsIG15IGJhZCwgd2lsbCByZW1vdmUgaXQuDQoNCj4gDQo+PiArDQo+
PiArLyogUmVzdG9yZSBmdWxsIHNwZWN1bGF0aXZlIG9wZXJhdGlvbiB0byB0aGUgcGZuLiAqLw0K
Pj4gK2ludCBjbGVhcl9tY2Vfbm9zcGVjKHVuc2lnbmVkIGxvbmcgcGZuKQ0KPj4gK3sNCj4+ICsJ
cmV0dXJuIHNldF9tZW1vcnlfd2IoKHVuc2lnbmVkIGxvbmcpIHBmbl90b19rYWRkcihwZm4pLCAx
KTsNCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTChjbGVhcl9tY2Vfbm9zcGVjKTsNCj4gDQo+IEFu
ZCB0aGlzIHNob3VsZCBiZSBFWFBPUlRfU1lNQk9MX0dQTC4NCg0KWWVzLg0KDQpUaGFua3MhDQot
amFuZQ0KDQo=
