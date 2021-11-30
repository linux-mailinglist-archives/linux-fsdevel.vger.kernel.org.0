Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF12462D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 08:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhK3H0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 02:26:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64722 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhK3H0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:26:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU61csA028128;
        Tue, 30 Nov 2021 07:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jlKZ0OMC5cClfqgbte7A23SloPoW3KJon6V9fnx+uEU=;
 b=A0y12aiX7KHkmk8rYbSG0kYg4gLbFWo4rMJhv30stdlwgb3yrgCf0gYb3VF7SG9Yt/ew
 YMCbMg22tn9xcAANcJJGBEa4wAluv3xmn3JxCxNE8ME1BNFHtYzP/PszPTXfmC1HM3oh
 dlcTdqNuilrYrdS1lBDoXRsTyv4PinxHcJZsqTbWdR6ar6LV98CVdpFpz4OW2T9L4+/3
 BI6CQoO7e9rnuf1WjGgYM7TIACgNEuX/Lnzz+9khCFO7AKd9XBD4kZE+TpQMFX+nYJuD
 Pjglk4FFpAkeDrZwZtiPeb8UvUBDcKVVgLJTIkQHezlS44jHLd8hGTLDprAInH1Teb9u Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wevb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:22:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU7A8LG114764;
        Tue, 30 Nov 2021 07:22:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3cke4p0p1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIo8AQftytcjtbOCMYOn1hTjllXY7QeUJJYYqcdmHe2rXtV0xf+6UQtGS61TVhuU3jDkJ8yEGpP+RDB5ndDOmDFeGyOr4AvPnA2FOC9HQTVP6zuPyMxdcjldtvwjXmQGlSE4o63JTeFQ1IB0DRC2hbQSzbUAAYOqNuoP+y5r8fGG0eFnWz1XcvhIrUThxkWTsGZ+7sBDVxoNs8N4Ng2/vLhTq322rsvOk8LYBCWC+f7kWcPa+cEzjneoGuiQdQZGS05tS7rBLjScpa2xZDtMb9ef/Lwa+0dZEPF+5bD09Iz+TZpoBcmOeee/l2LVGfCyI1KhtXOVsQOp915beWZO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlKZ0OMC5cClfqgbte7A23SloPoW3KJon6V9fnx+uEU=;
 b=NN8gznHz06aXNAQUOJWh3rYk5F2TQjOisFUbZpLmUC2tLWZ7fEORNKC9u3Im+qrB6xLnwX2QTWA+qRp0owg1poMZvHYSt0tmFDDjrbUG/96zanYOf0ah17lHfnUEszn6FIwEgyZAV6N9PJoh7j/yUFbnztI58ALV1ZtfVtkYl8LiOrD1DU5pmivG7vPM19SzoWO8dZurbKRjWKQXAymQ/i7FxbbwS+fWZje7vj/zH+ONE7STFb2gj+VYDTmIDK9IcCxjB5kI71W//rpbnHFLXt7bHkcThRaWipbDbYvnEjW3kEEkpOeH1tLNO0nbsxPoytiXq6Z1grpB/kWNfLOQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlKZ0OMC5cClfqgbte7A23SloPoW3KJon6V9fnx+uEU=;
 b=TxG7i7QwjqKjBPUicYnqFUB6aJDi7erI0dGbn3lkuJ+prN46tCsAr88MiSG9uwXS9xzIqC/Sp04oV5bSnBwjrgCcsKRuvCuyPSVryl5UpDl6gyMxCXQDjcgSI4/HgL8wV9YTur9T+77C+UlMe4usB8mo7htwZqhiv7c3Xy5K2Lw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3509.namprd10.prod.outlook.com (2603:10b6:a03:11f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 07:22:22 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Tue, 30 Nov 2021
 07:22:22 +0000
Message-ID: <7548c291-cc0a-ed7a-ca37-63afe1d88c27@oracle.com>
Date:   Mon, 29 Nov 2021 23:22:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
 <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
 <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0062.namprd05.prod.outlook.com
 (2603:10b6:803:41::39) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by SN4PR0501CA0062.namprd05.prod.outlook.com (2603:10b6:803:41::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Tue, 30 Nov 2021 07:22:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367c0666-90ac-4460-8674-08d9b3d2269a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3509:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3509B30E262C456AB6C9934D87679@BYAPR10MB3509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vOkapkyk4eLcioJFSbviH9YiOU2JwP1NtOyu6qmLCR/eX2adx4QhczW10Hw0SxLLthfUb4I4qS4mthoKqIMS+LWEIfD1n4FqXL8GnWhzu3Ry4x9PUrRgr5wVksrbKquGsEZzQ3Jk1FRQe17X1yCoMb+gUzJIKlpI1z77DHOBLPYLpEdZxKzOXcIVuLhWPLDpx3jZQk8QZDfw53cdlvTxeih8nYbTXkTtGQo2TGoHl4Wi0mbLMWG7wmpXGpe2ENfZKfVR0aS9Pn1XC4UtCN9c1Yztx9BsW0U2sEWOXOey2gZD0K81geyAK624wn405MHXv22J4B+uPzqB4WlWxffTLM7Fj/hQj9lVLJvZOVdBwx8Rn8I0EWjXGbj1wJIe4EUTr3JzJbxIvlbgS/40j7fCBKQOvajkuDH+qQwGjd//aFyrkwyR0wuH9ItULQbEXFS3oiCLJG/ZuqIwRnFE7CGEz8A21KU1FMZMqu/e+FpWZNsjPRhTYFX1fkhz84ixrWcC0gH25olE74G0SNWuuJ34R7auvVIxoOxpbsQsdnfW7AAH/96DK3sIDehkpuH5Z16up29u5LH08XIpbVIDT+SkiWX5kKzftAHyst3S4TiuRwGm8Kmne5WMHi4cgrJSayGpJc32hFx5xGXI4p1mcoOUDrIV8ocwlJKlRpTF1i/bIH7ByOxJ0/zFXMIgtzPvy/YxmloB1BqKigZ/WQvdNwJMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(66946007)(86362001)(83380400001)(6486002)(53546011)(5660300002)(2616005)(36756003)(6666004)(110136005)(38100700002)(2906002)(186003)(54906003)(16576012)(508600001)(26005)(8936002)(30864003)(31686004)(8676002)(4326008)(956004)(9686003)(31696002)(4001150100001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNCUnNKcGJNaElESTJJVUlOWVJTa044TGdzODJ1aTJrTlpWMUgwU3JWdnh1?=
 =?utf-8?B?OFFEcHVJSTZ0bDJadnJKeVI3cGczYi9lMUtpaVgyRUdiZlJHVTdxbkd1TXN0?=
 =?utf-8?B?bWVtcDJNWHdhNTN3OFpPenpXSXEvYzBKem03a1ljb3RFUUFXdVYxekIweFll?=
 =?utf-8?B?a20xUUVxeFQ2bTk1V3VqM2tmcFRwZ2g5WHNUbWk4aXNvKzBCMTFtMTdWZzZi?=
 =?utf-8?B?dkxhTGl5TU0xYUMxTVI1UCtRR1lYOHl1alNnVGFmelF3Yi9US0pBQjlCeHM2?=
 =?utf-8?B?Y1l3YXhBUHcyN0FlbFBCVnpPdW0zaTJ6ZVI0MmE2R293bkR5Q2tXYzVhdEJT?=
 =?utf-8?B?SkwyRUpWNlZDWlpVQTJWM2FBNHhnaEFFUGtMVnl4K1dRcE1xbTZ4WnVNdlpW?=
 =?utf-8?B?WEx2elJjRTRzNWFhZ25rb3dWaXVVdjFxR0hBN0toNW1ic0NBS09LSENWUTVh?=
 =?utf-8?B?cWJNQWJNOGh2Y2R3Z295Y0tQbHFFUWd0b294M05nQUMvTGdUUVJvbzRZQ29D?=
 =?utf-8?B?Q2Y0S21qZ0pFdmN1eTg0WEhCVTdHT1VSOFh1QndhS2xUODY0cHdzTld0NkRn?=
 =?utf-8?B?VVJCRFNORDk0cHcxNWoxN0tvbFczNGZpWGIrRXAzZFF1OERhQW51U3VTZVJh?=
 =?utf-8?B?WXpwdlJjdVFiOEJzRi9UdzgrckhHRjNqMG1TY2xRZXhVYXNMSE1XOVdlcFBY?=
 =?utf-8?B?V0RZU0IzM2lST3lVTWwwL2UvRys1Z2hUaEQ2YXExU3hONE1McTNhZmQxelk5?=
 =?utf-8?B?N3BXTGxYMlJVQVE5dHJpYnZ5SWhYRlgwMW1YUHZIUHd3bWVmZG9RbURzM3NU?=
 =?utf-8?B?K2ZBdFFjbU5jVGNRL0NEUFlLUittc3dISXM1amhVRFljaERJTjgzdzZaNXNw?=
 =?utf-8?B?Q2Y4cTRDUUNrbmU2QjNOMTlDV2gvSHdGUU0va3orMnBNMVZsYlh4UXBFVXBT?=
 =?utf-8?B?aWovNzFadUoweHhTNWFsVGZTOTdsRkNiS2NrdjNnZEhPRm4rVzNvWTNqdVBj?=
 =?utf-8?B?Y2hYdkNvVG1ZSitqVTNCRmlSc3ppdnFLK3JZMnpmTmtzRHBjMGV0OUJXQVZM?=
 =?utf-8?B?d25PMzhRUG84TXRDbm5QcEM3WnV4cDhyN3ZMdldPZjV2dkxkNG1tbjFiMzhl?=
 =?utf-8?B?WGZpM1dNeXVzVm92d2dwQld3UUUwWjZaWGY1VGRsVDhSaTV3R25xSTJRVElW?=
 =?utf-8?B?NGxKS1JwajF1WDI1Q2lzbDR2b1BtRHhmRnNXd0RySEhGVm01Qk95REJOby93?=
 =?utf-8?B?STlSNXlSUURFNHkyNm1ib281VmUySUJWL0tPdlQ1MnFrdmk4Q1MwL1JsTTJs?=
 =?utf-8?B?akRxNCs3Qk1qZjlFUW5NL21HenovUUNKWG5sd3BRKzU3NDZHQ0N4enVJUDQw?=
 =?utf-8?B?OUpuZ25mUElxMzhlS0NHa3B6TFF1c3BBZERwcVdZSjhZSUhwVHNjMEVTelhE?=
 =?utf-8?B?ZnFVVndub1U5U0cwN0l2eHRKRkp5SmFycGZ1anZTUFFJKy9NWS9od3Zrbk9q?=
 =?utf-8?B?ZkpDTHFsME5YMSs1SktvKy9BdEVZSUtGY1JuQlBJRjI0RmhranI5NXhOTmZq?=
 =?utf-8?B?UXNwVjFDcnYzcjUvcURlaEJNaVB5YmpBUU93Z0lBYzlFYjRFZEJ1Y3c4YmZw?=
 =?utf-8?B?WUt4cndBVWVQclZ5VkorMXE1VkVPbG5nYkN2S0JqUUd6WUF5K3VJaDY5aE8v?=
 =?utf-8?B?MWxMYzlpV1V4OXJMQk1PcUtkU1J2Y3pYTHVFVlFvTG80QmlXSXlwZlloZmJJ?=
 =?utf-8?B?cmozQS9ZdFY2US9NNDZIWktCTjRLcXU0WXYxbkZybVV6THR3eUJ2bmJCcysy?=
 =?utf-8?B?YWNyTkhCd2Z0VDl5Nm1XYzBleGxSang5ekQrSFI1UWdSdEswS0thV0lDQTNV?=
 =?utf-8?B?TVNoRWJTMzZ1aGxPTFkvNFFQbTNQZ2FLaWd4QkQwV1F0cjdxSFNCdGU3M0wz?=
 =?utf-8?B?UW00bFV0UjhiSjRxSWhGNExPT0pZbFdTT2RvSEhLRTNUVjl0OXh3VTJlT3Vu?=
 =?utf-8?B?UlR2MW4zVlNHUi93MS9FNkZtVjAvY0s0YThmK3BCQmE2TFNTd3grRkp1UXMx?=
 =?utf-8?B?VVlvMzd0NXljZ3NDTUlQb3o3WnNsdmhqMmFUcDRDanhsVnRCdEJHaEU3Rkgx?=
 =?utf-8?B?YmdtcXk5Rnd3czVST3lJbEFCQ24zZ25WQWc5ZGxNTFhPUjk1ZkVWSzd5b1dP?=
 =?utf-8?Q?TjmPTB3DJDuW6zlEtBT6y3o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367c0666-90ac-4460-8674-08d9b3d2269a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:22:22.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQGvxD0Qg08pkMfw65qGjxScRwD9dVRT19NaKabM3JrewZfFSgrP7St82Z0knx/2wd8iL1xsKPR/iUzKO5EM3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3509
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300041
X-Proofpoint-GUID: 1F54vCyC8CcpfT0dDu8o5sFa_HniPP7f
X-Proofpoint-ORIG-GUID: 1F54vCyC8CcpfT0dDu8o5sFa_HniPP7f
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/29/21 8:57 PM, Trond Myklebust wrote:
> On Tue, 2021-11-30 at 04:47 +0000, Chuck Lever III wrote:
>>> On Nov 29, 2021, at 11:08 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>
>>> ﻿On Tue, 2021-11-30 at 01:42 +0000, Chuck Lever III wrote:
>>>>>> On Nov 29, 2021, at 7:11 PM, Dai Ngo <dai.ngo@oracle.com>
>>>>>> wrote:
>>>>> ﻿
>>>>>> On 11/29/21 1:10 PM, Chuck Lever III wrote:
>>>>>>
>>>>>>>> On Nov 29, 2021, at 2:36 PM, Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> wrote:
>>>>>>>
>>>>>>> On 11/29/21 11:03 AM, Chuck Lever III wrote:
>>>>>>>> Hello Dai!
>>>>>>>>
>>>>>>>>
>>>>>>>>> On Nov 29, 2021, at 1:32 PM, Dai Ngo
>>>>>>>>> <dai.ngo@oracle.com>
>>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>>>>>>>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800,
>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>> Hi Bruce,
>>>>>>>>>>>
>>>>>>>>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>>>>>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>>>>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800,
>>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>> On 11/17/21 9:59 AM,
>>>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800,
>>>>>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>>>>> Just a reminder that this patch is
>>>>>>>>>>>>>>>>> still
>>>>>>>>>>>>>>>>> waiting for your review.
>>>>>>>>>>>>>>>> Yeah, I was procrastinating and hoping
>>>>>>>>>>>>>>>> yo'ud
>>>>>>>>>>>>>>>> figure out the pynfs
>>>>>>>>>>>>>>>> failure for me....
>>>>>>>>>>>>>>> Last time I ran 4.0 OPEN18 test by itself
>>>>>>>>>>>>>>> and
>>>>>>>>>>>>>>> it passed. I will run
>>>>>>>>>>>>>>> all OPEN tests together with 5.15-rc7 to
>>>>>>>>>>>>>>> see if
>>>>>>>>>>>>>>> the problem you've
>>>>>>>>>>>>>>> seen still there.
>>>>>>>>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with
>>>>>>>>>>>>>> courteous and non-courteous
>>>>>>>>>>>>>> 5.15-rc7 server.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Nfs4.1 results are the same for both
>>>>>>>>>>>>>> courteous
>>>>>>>>>>>>>> and
>>>>>>>>>>>>>> non-courteous server:
>>>>>>>>>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned,
>>>>>>>>>>>>>>> 169
>>>>>>>>>>>>>>> Passed
>>>>>>>>>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>>>>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned,
>>>>>>>>>>>>>>> 577
>>>>>>>>>>>>>>> Passed
>>>>>>>>>>>>>> test failed: LOCK24
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>>>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned,
>>>>>>>>>>>>>>> 575
>>>>>>>>>>>>>>> Passed
>>>>>>>>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> OPEN18 and OPEN30 test pass if each is run by
>>>>>>>>>>>>>> itself.
>>>>>>>>>>>>> Could well be a bug in the tests, I don't know.
>>>>>>>>>>>> The reason OPEN18 failed was because the test
>>>>>>>>>>>> timed
>>>>>>>>>>>> out waiting for
>>>>>>>>>>>> the reply of an OPEN call. The RPC connection
>>>>>>>>>>>> used
>>>>>>>>>>>> for the test was
>>>>>>>>>>>> configured with 15 secs timeout. Note that OPEN18
>>>>>>>>>>>> only fails when
>>>>>>>>>>>> the tests were run with 'all' option, this test
>>>>>>>>>>>> passes if it's run
>>>>>>>>>>>> by itself.
>>>>>>>>>>>>
>>>>>>>>>>>> With courteous server, by the time OPEN18 runs,
>>>>>>>>>>>> there
>>>>>>>>>>>> are about 1026
>>>>>>>>>>>> courtesy 4.0 clients on the server and all of
>>>>>>>>>>>> these
>>>>>>>>>>>> clients have opened
>>>>>>>>>>>> the same file X with WRITE access. These clients
>>>>>>>>>>>> were
>>>>>>>>>>>> created by the
>>>>>>>>>>>> previous tests. After each test completed, since
>>>>>>>>>>>> 4.0
>>>>>>>>>>>> does not have
>>>>>>>>>>>> session, the client states are not cleaned up
>>>>>>>>>>>> immediately on the
>>>>>>>>>>>> server and are allowed to become courtesy
>>>>>>>>>>>> clients.
>>>>>>>>>>>>
>>>>>>>>>>>> When OPEN18 runs (about 20 minutes after the 1st
>>>>>>>>>>>> test
>>>>>>>>>>>> started), it
>>>>>>>>>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE
>>>>>>>>>>>> which causes the
>>>>>>>>>>>> server to check for conflicts with courtesy
>>>>>>>>>>>> clients.
>>>>>>>>>>>> The loop that
>>>>>>>>>>>> checks 1026 courtesy clients for share/access
>>>>>>>>>>>> conflict took less
>>>>>>>>>>>> than 1 sec. But it took about 55 secs, on my VM,
>>>>>>>>>>>> for
>>>>>>>>>>>> the server
>>>>>>>>>>>> to expire all 1026 courtesy clients.
>>>>>>>>>>>>
>>>>>>>>>>>> I modified pynfs to configure the 4.0 RPC
>>>>>>>>>>>> connection
>>>>>>>>>>>> with 60 seconds
>>>>>>>>>>>> timeout and OPEN18 now consistently passed. The
>>>>>>>>>>>> 4.0
>>>>>>>>>>>> test results are
>>>>>>>>>>>> now the same for courteous and non-courteous
>>>>>>>>>>>> server:
>>>>>>>>>>>>
>>>>>>>>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>>>>>>
>>>>>>>>>>>> Note that 4.1 tests do not suffer this timeout
>>>>>>>>>>>> problem because the
>>>>>>>>>>>> 4.1 clients and sessions are destroyed after each
>>>>>>>>>>>> test completes.
>>>>>>>>>>> Do you want me to send the patch to increase the
>>>>>>>>>>> timeout for pynfs?
>>>>>>>>>>> or is there any other things you think we should
>>>>>>>>>>> do?
>>>>>>>>>> I don't know.
>>>>>>>>>>
>>>>>>>>>> 55 seconds to clean up 1026 clients is about 50ms per
>>>>>>>>>> client, which is
>>>>>>>>>> pretty slow.  I wonder why.  I guess it's probably
>>>>>>>>>> updating the stable
>>>>>>>>>> storage information.  Is /var/lib/nfs/ on your server
>>>>>>>>>> backed by a hard
>>>>>>>>>> drive or an SSD or something else?
>>>>>>>>> My server is a virtualbox VM that has 1 CPU, 4GB RAM
>>>>>>>>> and
>>>>>>>>> 64GB of hard
>>>>>>>>> disk. I think a production system that supports this
>>>>>>>>> many
>>>>>>>>> clients should
>>>>>>>>> have faster CPUs, faster storage.
>>>>>>>>>
>>>>>>>>>> I wonder if that's an argument for limiting the
>>>>>>>>>> number of
>>>>>>>>>> courtesy
>>>>>>>>>> clients.
>>>>>>>>> I think we might want to treat 4.0 clients a bit
>>>>>>>>> different
>>>>>>>>> from 4.1
>>>>>>>>> clients. With 4.0, every client will become a courtesy
>>>>>>>>> client after
>>>>>>>>> the client is done with the export and unmounts it.
>>>>>>>> It should be safe for a server to purge a client's lease
>>>>>>>> immediately
>>>>>>>> if there is no open or lock state associated with it.
>>>>>>> In this case, each client has opened files so there are
>>>>>>> open
>>>>>>> states
>>>>>>> associated with them.
>>>>>>>
>>>>>>>> When an NFSv4.0 client unmounts, all files should be
>>>>>>>> closed
>>>>>>>> at that
>>>>>>>> point,
>>>>>>> I'm not sure pynfs does proper clean up after each subtest,
>>>>>>> I
>>>>>>> will
>>>>>>> check. There must be state associated with the client in
>>>>>>> order
>>>>>>> for
>>>>>>> it to become courtesy client.
>>>>>> Makes sense. Then a synthetic client like pynfs can DoS a
>>>>>> courteous
>>>>>> server.
>>>>>>
>>>>>>
>>>>>>>> so the server can wait for the lease to expire and purge
>>>>>>>> it
>>>>>>>> normally. Or am I missing something?
>>>>>>> When 4.0 client lease expires and there are still states
>>>>>>> associated
>>>>>>> with the client then the server allows this client to
>>>>>>> become
>>>>>>> courtesy
>>>>>>> client.
>>>>>> I think the same thing happens if an NFSv4.1 client neglects
>>>>>> to
>>>>>> send
>>>>>> DESTROY_SESSION / DESTROY_CLIENTID. Either such a client is
>>>>>> broken
>>>>>> or malicious, but the server faces the same issue of
>>>>>> protecting
>>>>>> itself from a DoS attack.
>>>>>>
>>>>>> IMO you should consider limiting the number of courteous
>>>>>> clients
>>>>>> the server can hold onto. Let's say that number is 1000. When
>>>>>> the
>>>>>> server wants to turn a 1001st client into a courteous client,
>>>>>> it
>>>>>> can simply expire and purge the oldest courteous client on
>>>>>> its
>>>>>> list. Otherwise, over time, the 24-hour expiry will reduce
>>>>>> the
>>>>>> set of courteous clients back to zero.
>>>>>>
>>>>>> What do you think?
>>>>> Limiting the number of courteous clients to handle the cases of
>>>>> broken/malicious 4.1 clients seems reasonable as the last
>>>>> resort.
>>>>>
>>>>> I think if a malicious 4.1 clients could mount the server's
>>>>> export,
>>>>> opens a file (to create state) and repeats the same with a
>>>>> different
>>>>> client id then it seems like some basic security was already
>>>>> broken;
>>>>> allowing unauthorized clients to mount server's exports.
>>>> You can do this today with AUTH_SYS. I consider it a genuine
>>>> attack
>>>> surface.
>>>>
>>>>
>>>>> I think if we have to enforce a limit, then it's only for
>>>>> handling
>>>>> of seriously buggy 4.1 clients which should not be the norm.
>>>>> The
>>>>> issue with this is how to pick an optimal number that is
>>>>> suitable
>>>>> for the running server which can be a very slow or a very fast
>>>>> server.
>>>>>
>>>>> Note that even if we impose an limit, that does not completely
>>>>> solve
>>>>> the problem with pynfs 4.0 test since its RPC timeout is
>>>>> configured
>>>>> with 15 secs which just enough to expire 277 clients based on
>>>>> 53ms
>>>>> for each client, unless we limit it ~270 clients which I think
>>>>> it's
>>>>> too low.
>>>>>
>>>>> This is what I plan to do:
>>>>>
>>>>> 1. do not support 4.0 courteous clients, for sure.
>>>> Not supporting 4.0 isn’t an option, IMHO. It is a fully supported
>>>> protocol at this time, and the same exposure exists for 4.1, it’s
>>>> just a little harder to exploit.
>>>>
>>>> If you submit the courteous server patch without support for 4.0,
>>>> I
>>>> think it needs to include a plan for how 4.0 will be added later.
>>>>
>>> Why is there a problem here? The requirements are the same for 4.0
>>> and
>>> 4.1 (or 4.2). If the lease under which the courtesy lock was
>>> established has expired, then that courtesy lock must be released
>>> if
>>> some other client requests a lock that conflicts with the cached
>>> lock
>>> (unless the client breaks the courtesy framework by renewing that
>>> original lease before the conflict occurs). Otherwise, it is
>>> completely
>>> up to the server when it decides to actually release the lock.
>>>
>>> For NFSv4.1 and NFSv4.2, we have DESTROY_CLIENTID, which tells the
>>> server when the client is actually done with the lease, making it
>>> easy
>>> to determine when it is safe to release all the courtesy locks.
>>> However
>>> if the client does not send DESTROY_CLIENTID, then we're in the
>>> same
>>> situation with 4.x (x>0) as we would be with bog standard NFSv4.0.
>>> The
>>> lease has expired, and so the courtesy locks are liable to being
>>> dropped.
>> I agree the situation is the same for all minor versions.
>>
>>
>>> At Hammerspace we have implemented courtesy locks, and our strategy
>>> is
>>> that when a conflict occurs, we drop the entire set of courtesy
>>> locks
>>> so that we don't have to deal with the "some locks were revoked"
>>> scenario. The reason is that when we originally implemented
>>> courtesy
>>> locks, the Linux NFSv4 client support for lock revocation was a lot
>>> less sophisticated than today. My suggestion is that you might
>>> therefore consider starting along this path, and then refining the
>>> support to make revocation more nuanced once you are confident that
>>> the
>>> coarser strategy is working as expected.
>> Dai’s implementation does all that, and takes the coarser approach at
>> the moment. There are plans to explore the more nuanced behavior (by
>> revoking only the conflicting lock instead of dropping the whole
>> lease) after this initial work is merged.
>>
>> The issue is there are certain pathological client behaviors (whether
>> malicious or accidental) that can run the server out of resources,
>> since it is holding onto lease state for a much longer time. We are
>> simply trying to design a lease garbage collection scheme to meet
>> that challenge.
>>
>> I think limiting the number of courteous clients is a simple way to
>> do this, but we could also shorten the courtesy lifetime as more
>> clients enter that state, to ensure that they don’t overrun the
>> server’s memory. Another approach might be to add a shrinker that
>> purges the oldest courteous clients when the server comes under
>> memory pressure.
>>
>>
> We already have a scanner that tries to release all client state after
> 1 lease period. Just extend that to do it after 10 lease periods. If a
> network partition hasn't recovered after 10 minutes, you probably have
> bigger problems.

Currently the courteous server allows 24hr for the network partition to
heal before releasing all client state. That seems to be excessive but
it was suggested for longer network partition conditions when switch/routers
being repaired/upgraded.

>
> You can limit the number of clients as well, but that leads into a rats
> nest of other issues that have nothing to do with courtesy locks and
> everything to do with the fact that any client can hold a lot of state.

The issue we currently have with courteous server and pynfs 4.0 tests
is the number of courteous 4.0 clients the server has to expire when a
share reservation conflict occurs when servicing the OPEN. Each client
owns only few state in this case so we think the server spent most time
for deleting client's record in /var/lib/nfs. This is why we plan to
limit the number of courteous clients for now. As a side effect, it might
also help to reduce resource consumption too.

-Dai

>
