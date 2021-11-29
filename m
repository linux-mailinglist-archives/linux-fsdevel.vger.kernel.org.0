Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA0462114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 20:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbhK2T4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 14:56:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47024 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233840AbhK2TyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:54:16 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJV4NY028197;
        Mon, 29 Nov 2021 19:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WAJfziUx3WCt/Z3/oPTH1RtOWpn5t2WOdSAXeQDU44I=;
 b=O+5XOWFnWA5jBmr/HqkT1XpmqDMsmpeexlfI5BtAF9Wp9AbtLKKHMEe1NtwHfWzZtsRk
 sTyxeujXEp8KZRWBYXAqDxa0QrKvkmOrMDafSwDrX0d91D4LXblKnP+pU5diIBKydz0r
 wP/WERB8wEwPBmPWqQHZlvfZ18mli1dmsqcpQKaJGtxXkL3XM36IJ/be4n4kVzxzMi6P
 VHcLAIs0Rqv9orRzxYZOfeDHoQSZE37c6K3c4vRiSpP4fdnIQEKySGNEOrA2QenA0hBh
 xiLC4kDVeWp3Ozz+0XBZKkYFMNJixBzUgN2YgWTaJ6Ece/sKwU7g0vTT3IikRe34Tw+T Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wbrjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:50:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJZavB142078;
        Mon, 29 Nov 2021 19:36:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ckaqdbtgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzfMhAUZYkU6oHUjZOoneYNT8NcEe4aq9ZNCZde71ebksupX08kZhe/P9E20Wthjba9SKDwcFjDHNzDADM7L5/1dnT3H+hRaoc5yrPwRwKiOEZpaQPKGfUMBNNhgoK1OaRcLaUZF8UD37TACtgl4KyW4tGh+YnMfXOG/Kl8qKV5BfLoC5OC9rYV18Q4LfKPBRdHu6BLw+Op+GURYOJyCR5snxEu4Wg0L17RtUBJpkic7Iet9TFMiuP33cBn1kgspnGb2VqwPFWX1ZG8UXriGbV3umTjKaV4h9OnvdESdlYc5mMBUNPUFL0b9rJi2N7AbUCrz77HL+APHG3HOdChvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAJfziUx3WCt/Z3/oPTH1RtOWpn5t2WOdSAXeQDU44I=;
 b=HiRG+mfA/vxMPUY06H0NIPwqKwRpCey7DRtBU//wu0VxZo6cUBZ9Xqbc4WowgCmDlbUP4TxLLdeqGnYjdyhAImH2NlRM8xawWcQejNprXjQG1QXu0lpJpN2/TJhqykVqOEoE86Y5VT39ASAVTrJiIo607jY3OHj+5mVpgE90h6Ha+2PUNJhhLI0bHAMyRupN5vZVaDfVNhCSsddaX5bs20MQ3Rjb9ULJzNTdErADA9PdA/jR+oaDCXWRROa2nfg4Jm82uZO6Pwasu65RHk4ddVuY/Vb5phV8idckIkBOBOGLqjIg3Ec6iIxM+3HH40UeeZrY0aeTO5e6q+Em/jxCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAJfziUx3WCt/Z3/oPTH1RtOWpn5t2WOdSAXeQDU44I=;
 b=ZeNaofkZIJbQ3CGfGO+1HEA37poyyuZ94LpQX80Mpth8sRWN3DL0k8wNu7AyY4YbjmES+VXpIpL2sqRGvKX6Ah9QGzmtT2GJNQ1ghx9o9topAxvSBWSnqzR/JQBUANAygFop+QfpvzEtCRDimEKYy1UtIUculTmhXuKyKzNMYTU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3045.namprd10.prod.outlook.com (2603:10b6:a03:86::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 19:36:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Mon, 29 Nov 2021
 19:36:13 +0000
Message-ID: <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
Date:   Mon, 29 Nov 2021 11:36:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
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
From:   dai.ngo@oracle.com
In-Reply-To: <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend Transport; Mon, 29 Nov 2021 19:36:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24075557-feff-4c08-6f8a-08d9b36f80a8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3045:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3045CFE2D6EDED2DC62F9D0A87669@BYAPR10MB3045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKamBDEcd1SFYM3KrVWD2xKfmzD22C1UAUX/q6Ba06DVSwNVccWvuJnEGLRtXuGd1aqfU6lj95XdmAUxORU36Mn5tGk0UMjWPZLcI2MxU63XOF6KsEa00xMN6WjeQvUhj245qA6UMZKAkqRPr3sghlkKJBdCbf9qZNi4p+eF0sKJHTTpvL6doRVo8sm2INVV7oTnm0Li+7dh7+GCiuGnhSGTHlcTtDppkG0o5SZgKQetH3yEDrfnxuFIX0qZFab5hIN2zOSPOqdryTthv7FvcABpb4MTyOj0aFmIUnLf0I2z7cRQrdDTJWaeJd+mY377irftJbiO0+xlizK4CKsQJROsfoOw7ZxUQOY/2K34ERbCI7AyDm3oKJMMNKC/pLVQ9hTQ0RF4fVqvK5v2UKRt/SRRffG81sT9oz1X65y10kd/yBqTbs0UquG3FdZb5UISo5CqcbH2T3G5/SG1JST1B5oFGj/W7dUcpe7BOpnE6fOZd1Te9gBVcVFkEYpVcASKbSnrsnn2vhjWHLpMPH9km+QLSKj2LNvHJuCsI1AXMx/S5w0T7Ab4dvT7fRxPKIbTf0zaqM0X3lwoN+jgOVBLX4S9+TfQhLWOq0hXcuCsUBfH/+lvnUep++OLh5q1mGSk7XKCcSitE/vCALw6yiwffZhA1GqL6Ckq4/SPEXjo9We1xwaH5qHvJFRvCvuMB9eFb04xT62wgWPhv2tl4keoSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6862004)(2616005)(54906003)(36756003)(9686003)(31686004)(8676002)(5660300002)(4326008)(53546011)(66476007)(956004)(26005)(2906002)(66946007)(31696002)(186003)(16576012)(83380400001)(6486002)(316002)(86362001)(66556008)(38100700002)(8936002)(37006003)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXo2Qml0RFJjRXRZM2Q2K2FEUjA1K1JsN0J1dUQ4SlNoWFBGT1UzSWxZdkFC?=
 =?utf-8?B?dWJGdzNleXRveW9senoxRFVyZGJJdElIVlhQQ3NEZllOeEFpakpYVU1XdTlG?=
 =?utf-8?B?TThkS2ZlUmZhL1ZiOERuRFd2WGxtWTlVMGpKVllUdWVoR2dXamRLd05tU3pl?=
 =?utf-8?B?emYyRzBNdmkyNzZ5RWNNZWJjTkRCZ2xXcUh2UzQyWGVKWWFYZE5QZkh1c0Js?=
 =?utf-8?B?eEIyYjR4Tk85alBtZ2EveFZOMm5NMnRnbHQ3eHBLNTVrT2wrVklvdWtQRWFw?=
 =?utf-8?B?MHJ0QnU3eVo2aC9iZjd0NmQ5dzJwYS9NTlBHdFVZNUhjbFZidEJ4L2M0M2pH?=
 =?utf-8?B?QVdFUDhmMHE5NDd5aWJQY0ZZb3R0dkJjaVczQkRUOHlqaURUeDBjT1k3cjFF?=
 =?utf-8?B?RjNPdGJGOFBHKzRpK0lJVGdOWkxaR0NWakdZbE1aOWlSbE1GN3E2cHBBQ0lo?=
 =?utf-8?B?bTdESXlJeUhpRXR5L29USmRUVm1oa1RWcmZVTlc0d1k5enZoSXZ0eUNPcmZn?=
 =?utf-8?B?cTZkSVEzUGt5R0ZoRFpoZ3orZVgrTllhcDhCRzlJZWhRNjdLTTcvUVFuT3Zv?=
 =?utf-8?B?QldVbmVFWEVac0RmbmhZMmhERDJrRU1NR1lpU1J3cXQzWUpnSDZSbWV6cmM4?=
 =?utf-8?B?VUNkMHE3STM0dS85cEwzbENTZUg2bG1QQ3JxQm5CNkVwTmZMaU9JNU5id0pW?=
 =?utf-8?B?Q3FRWG1hdjJYK2cyeUZYQTdzaDczMjV5VGJuSUMvYTRFRmw0NjJRVk5MK3NX?=
 =?utf-8?B?aHJaRnVieExrdW1hc1hGYW56SFU4WHVyb3BVMlVlbmZLRGZ1dU53QSt5aEg5?=
 =?utf-8?B?ZTlYOGZUeUZUT3EydEVQeU5uQy9RakxJY2Qza1RnQldkYVJySFUrSmpBMkhU?=
 =?utf-8?B?VzFyRWhSc3ZCOTFQM2lOUkZ3dzcxRjZ0U0xuaTRTZnN2QkdtcHh0ZjZYbUVh?=
 =?utf-8?B?NlVyd0hVOUdtdjRmRHJRSXJqV1UxQk5uY1g4cTA4QmZMTlNQYVhrWFowc3FU?=
 =?utf-8?B?QTU3WEkxalk1Vlh1OGllY2swWE5KYWlSbGFQeHJ3ZjZFb0RUeVJ3cWp5bW1X?=
 =?utf-8?B?Wi93QUR3bk90dCtkWTNQdlQvM1pWektDd2Fja0tHbkdaMm9EYW5KMWJacGZB?=
 =?utf-8?B?NFZ1ZG1JVmdaNlBlMURRNDdBTnBjWFZkUGk2b2Q3cnIvTFhnZVhYZm9VWWdH?=
 =?utf-8?B?Ry93N21GaS82Z1ltUktLNHpVNWwvVjBheFpadWQxSDFWTmFyb05YbFFWVHJv?=
 =?utf-8?B?K2NNaFdyVzFFWWRCdDZmaVJaMEJjMG8zUE1yN2ZiZnA1cXhYbm5TZWRmaGVm?=
 =?utf-8?B?WjVhWUhiVm0rWXNQTkNqaUR6aUdVbVNoaU1mZGtQd1R3WGI4Tnpka0pHMit1?=
 =?utf-8?B?RGYzUHhqbnY5Qm45ZCtGN3Z3azRSSE40Y1lzSGZPYmtoRlhPZ3BjenEyalpP?=
 =?utf-8?B?RSsrVFduY0JJL081ZVBxOHJDN2lQR3VoeVRBWXNZbXNnMHZ4NmVyM3RZU0VG?=
 =?utf-8?B?Y241dVpiS1RqTnhtVjdOM3JYcWdBelFiS1UyQkpncFc1ZktuZHhQVkk2Z1Jz?=
 =?utf-8?B?MGp2R2xCUHc4a1ZUYXg1bHZnY2ZQYVN0SnZSblRiZ3BqQzlPUnZoTEpXZlhG?=
 =?utf-8?B?bG1SdCsxbHIzckN5MDZYZWVUaTkzWHBvcHk1K0g4Z0xmWWRWVDRLS3VyYTRw?=
 =?utf-8?B?Z0hGRWFIZEtKdFVxcXJDc0kxVm9JbjFYazByQ2lkTHVmTkJJWk51eVBKVFZq?=
 =?utf-8?B?MDhOcU9MMjNINmtLYTM3UGpwTld1ZXZNQmVIVEFXTm1yREpIQmliRk1ZKzlI?=
 =?utf-8?B?TVp5eHRaRlFKTVpKdUtCZ2xxWHRPbVNZS09LV3loOXZPWmlPSG9tTU5KRnpR?=
 =?utf-8?B?aUpNVGhncURoT2Q4dFExR3hpdUlXYVlsUFdmQmtlOElWTUU2VlNhd0ltdm1V?=
 =?utf-8?B?cEhTbDN0SW5sNTFFVW56aWpISjdFMHBYN21aUm9aNFRhWmdIUE95ODlDV2lx?=
 =?utf-8?B?cXF2OTRYaUROaDVkOEtjSWFzdWJnN2VoTGpDbDVrY3JjRkJGNW12Nk1VbElW?=
 =?utf-8?B?dWVESHhuN3Z4WlVoVTBYck0wb2ZGOFRKTFNoTzg2Rk8wSlFiQk9vRXY1bmFE?=
 =?utf-8?B?M0xoN1pCa2hUakZSck00QkpQK0R2b2xkRzBJeitoMUorTDZucFJYdDRRNzYr?=
 =?utf-8?Q?rU7/88BjyifjFvA7QSXKoL8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24075557-feff-4c08-6f8a-08d9b36f80a8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:36:13.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfNGghd8kiZ9unUMUDzoP6h5vtbJNwG7FrJBWoLkCyUBT49AfQ2pzp4P7uh6gSgv2xc1ioHLovS66WMMsM9mJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3045
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290091
X-Proofpoint-GUID: LtgQYcdy-7kUSF8GzDWBzrzxjra3g64H
X-Proofpoint-ORIG-GUID: LtgQYcdy-7kUSF8GzDWBzrzxjra3g64H
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/29/21 11:03 AM, Chuck Lever III wrote:
> Hello Dai!
>
>
>> On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>>>> Hi Bruce,
>>>>
>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>>>>>> failure for me....
>>>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>>>>>> seen still there.
>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>>>>>>> 5.15-rc7 server.
>>>>>>>
>>>>>>> Nfs4.1 results are the same for both courteous and
>>>>>>> non-courteous server:
>>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>> test failed: LOCK24
>>>>>>>
>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>
>>>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>>>> Could well be a bug in the tests, I don't know.
>>>>> The reason OPEN18 failed was because the test timed out waiting for
>>>>> the reply of an OPEN call. The RPC connection used for the test was
>>>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>>>> the tests were run with 'all' option, this test passes if it's run
>>>>> by itself.
>>>>>
>>>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>>>> courtesy 4.0 clients on the server and all of these clients have opened
>>>>> the same file X with WRITE access. These clients were created by the
>>>>> previous tests. After each test completed, since 4.0 does not have
>>>>> session, the client states are not cleaned up immediately on the
>>>>> server and are allowed to become courtesy clients.
>>>>>
>>>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>>>> server to check for conflicts with courtesy clients. The loop that
>>>>> checks 1026 courtesy clients for share/access conflict took less
>>>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>>>> to expire all 1026 courtesy clients.
>>>>>
>>>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>>>> now the same for courteous and non-courteous server:
>>>>>
>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>
>>>>> Note that 4.1 tests do not suffer this timeout problem because the
>>>>> 4.1 clients and sessions are destroyed after each test completes.
>>>> Do you want me to send the patch to increase the timeout for pynfs?
>>>> or is there any other things you think we should do?
>>> I don't know.
>>>
>>> 55 seconds to clean up 1026 clients is about 50ms per client, which is
>>> pretty slow.  I wonder why.  I guess it's probably updating the stable
>>> storage information.  Is /var/lib/nfs/ on your server backed by a hard
>>> drive or an SSD or something else?
>> My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
>> disk. I think a production system that supports this many clients should
>> have faster CPUs, faster storage.
>>
>>> I wonder if that's an argument for limiting the number of courtesy
>>> clients.
>> I think we might want to treat 4.0 clients a bit different from 4.1
>> clients. With 4.0, every client will become a courtesy client after
>> the client is done with the export and unmounts it.
> It should be safe for a server to purge a client's lease immediately
> if there is no open or lock state associated with it.

In this case, each client has opened files so there are open states
associated with them.

>
> When an NFSv4.0 client unmounts, all files should be closed at that
> point,

I'm not sure pynfs does proper clean up after each subtest, I will
check. There must be state associated with the client in order for
it to become courtesy client.

> so the server can wait for the lease to expire and purge it
> normally. Or am I missing something?

When 4.0 client lease expires and there are still states associated
with the client then the server allows this client to become courtesy
client.

-Dai

>
>
>> Since there is
>> no destroy session/client with 4.0, the courteous server allows the
>> client to be around and becomes a courtesy client. So after awhile,
>> even with normal usage, there will be lots 4.0 courtesy clients
>> hanging around and these clients won't be destroyed until 24hrs
>> later, or until they cause conflicts with other clients.
>>
>> We can reduce the courtesy_client_expiry time for 4.0 clients from
>> 24hrs to 15/20 mins, enough for most network partition to heal?,
>> or limit the number of 4.0 courtesy clients. Or don't support 4.0
>> clients at all which is my preference since I think in general users
>> should skip 4.0 and use 4.1 instead.
>>
>> -Dai
> --
> Chuck Lever
>
>
>
