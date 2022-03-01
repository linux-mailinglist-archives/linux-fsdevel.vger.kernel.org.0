Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B654C8299
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 05:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiCAEk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 23:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCAEk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:40:58 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3576BDFA;
        Mon, 28 Feb 2022 20:40:15 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2214dnit019095;
        Tue, 1 Mar 2022 04:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=VvIud66fTQxrLqigve3Jp3MaWXbDm3NipIdem9r6ne8=;
 b=nyDYH56wRMa/cs6gpw2FgaJJsoh+dwcciJ+ATDtxitBfWLcErQ5LJHT4o4sKnP6g3SeW
 NpKOGypzSbhAs3d/5VDz4VLmVEt/ME3UeLzZtJ63q4jK2PTV0srtSyV8CrM9aaJlmcih
 f4a+VzQI79/DaJyBAe/zKbrKcy4JHoeZsHpjILmS55OKjPpCtphVZEHq1EHfp1zBCu7k
 pJPCuOaIZswsJiAeXtP6VMZp+5BiBj7Zgwh0PaDYfYmI2Xa0RCK1EZo/8Q23G3ujsgF5
 6FUzsDh1JueywhNYwIz3pywpbBJZrwl4G/wV3cijBjUj0ExT61cKCzEerATkj+hOS8WA pA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3eh0yj8hv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 04:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMjrPnkCr4FmAd4JK9vz4hmlHdzzoYvrP5s2xLnoJTfp8L3UCdAWxfwRRTBcvr8EfS38ePR8vrgdXl+XSteoNKZNa+miXZUcj6kFnxPSkltxknhT9lTZnu4VPY6ALyGaZc64oLTo8bicuX9IwVKD6QLblO99rS/mcIsw0SFfur3DjRi1EQ3jSCuC+cyIfTid+UPTSWefoUliaJ29mtxgqWIf90ulVt1nEuDni6qA+AFyyCxBKZczp6bWiawsdW5foaBj5yIUniMDLJVF4V+VIskTVYyeWHfC4vXj4xtbN8gY6rW1SyNg4nB45veZpwFTwUPYNXhqEYA3a8fPHvLfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvIud66fTQxrLqigve3Jp3MaWXbDm3NipIdem9r6ne8=;
 b=E/GDSOUpa/hnN5K6kNtdqQPSEvZEB0bQgW55p0Bwdo7iNN8TvjJror3sTrX3CKLICrxRAvVU+S43C0y5aqTUBzevQPaiQBXLe808iuStxsNRYosl4iz8J1uSwP8NvOhNjtRa9cwS9Vzomfj00/7RX9+E0kOEU+I4L+19NXqqlZVbBrmLOKYb9j1fomJ5+kuwzdrXDvC9pFdGdc+JMQNJ+KwaRB9Jpm+7WLayneOKJGjeim/e57pnufL5r7ZfhmpM0axaKwFX0DHQsWQbmV+CcUclsYyUfAXOeb6rgvdL6sTlSdlHEpCfaYBtFKm21Y4k3iGTx3uECmJNBaXnRGxMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB3008.namprd11.prod.outlook.com (2603:10b6:805:cf::18)
 by BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 04:39:46 +0000
Received: from SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3]) by SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 04:39:46 +0000
Subject: Re: [PATCH] proc: fix documentation and description of mmap
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        tiberiu.georgescu@nutanix.com, florian.schmidt@nutanix.com,
        ivan.teterevkov@nutanix.com, sj@kernel.org, shy828301@gmail.com,
        david@redhat.com, axelrasmussen@google.com, linmiaohe@huawei.com,
        aarcange@redhat.com, ccross@google.com, apopple@nvidia.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220301032115.384277-1-yun.zhou@windriver.com>
 <Yh2aKofkcWsLswQm@xz-m1.local>
From:   Yun Zhou <yun.zhou@windriver.com>
Message-ID: <4b23a6c4-4b69-019f-7885-d4c9f61e9503@windriver.com>
Date:   Tue, 1 Mar 2022 12:39:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Yh2aKofkcWsLswQm@xz-m1.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac60cb5-fd86-447b-a144-08d9fb3d82d7
X-MS-TrafficTypeDiagnostic: BN9PR11MB5433:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB5433D52BAAAFEEB907693A7A9F029@BN9PR11MB5433.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg6BYhQNMveRC4aRM0/Iz5p5O7L7A56RngDDykRMS48rW5LKH52fqYuadHPGghr8OXlkgaNn5fxLL4z4Wz9HWXfUQ6s5zQI23wnyrsTYVykee9KoGsSP6lew16y//lXtFHDOx0ZACRkK8TOsYDq7Sz/5Hl8MNBaIZ1jad+ackQb0dqjEfBC7q9tn/ULA7EKH8eGeVK9M04q5M/tkX0NIqph/qAlWLOxvd4NrtBlB/Bv/20cPv/Yo7TQs8gCuUFwosD1CJ2HC0AZmdTvmASgBAvPvBz21AEJgWcgEwvATztsPxxIcbg2GUKvEk+Bx30x4uKIegYosY+LHKZoyKVbC6wxXZ1XyvnWUtbUoW5nEbvp4QFSUDluC7fFKJMFAUKTI+VuoGse4X6/FDxK+zLgXxaHO8TROsuc2Ueks0lel2ejef8gWFqVmr9l9o4rPBr9OHI+f3qAA+QlAKaS7rlfeEBE2Kz1LasuZLp0QzTTRBe/2xcOSC7Btel7ClbTBB8H4k415mBcVw+tzK9JXgTrKg1B2natjf5mt+YnIO6p3eKvjDxqsItYbrqOvyL4XDDPPJFTbOZXCO4qk/+FVk310H24XHqyAmzD7bcuCqLBpE5MCesTOdJfeEPYFNsTvozdTfV2MczHH10cz5yyqdsLasf+7wL7AkKaUqN4QShPyg6wrlaRAgdLl2OfTMwt72mvBzk/Zas9HYpRKoGs5k2W4mJpKGOLjdPpTxLAZjUV2O6vQppNyyF+Z3Htvkkr7dJ8MMCdoFbF9hlzHGZhx2UZLiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(8676002)(66946007)(66556008)(83380400001)(4744005)(44832011)(508600001)(6486002)(53546011)(52116002)(86362001)(2616005)(66476007)(2906002)(6512007)(8936002)(6506007)(4326008)(5660300002)(6666004)(38350700002)(38100700002)(26005)(186003)(6916009)(31686004)(36756003)(316002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGp3YjlYNmxja1lDRWJib0hSVTJWWGxWUEFraGhkYVRWNGhGRm1RanAwV0VE?=
 =?utf-8?B?ZXBteGx6dGNNWUp2bG1GNTJ4V0dLYUtBSjh5NTZOR01sZTVLUlZnUnVjalVT?=
 =?utf-8?B?OFc1Y2thVWdlYXpURnh6MDBoL1JIT094bHY1MTRuMkt1OG1EOG94REgzeFRI?=
 =?utf-8?B?ZWlob0Z6aUFiMzdnajhodkRuM2U2MmF1L1BYRXh3MUx3TlRMc3RCMkt6VWdS?=
 =?utf-8?B?V1pyNkhsV2tVYlZ1ZDhkQWFKd0tWU0pmZU1ycGZKU05pcGl2T3FKUFZhbFc3?=
 =?utf-8?B?RythVVNHWVRxQzAvc0lQYTUveVAxZlJyYnBXRmVPMVZMZlcyUHFROElXbGo3?=
 =?utf-8?B?MkJGTUx3M01BU0lOTm5iNVJuTzNzcUNkZG5URFZaOUZWUVhKMEFvL3RFM1Iz?=
 =?utf-8?B?V05Makt2OWVRaWRhNVV5bG1WSzJIclhMZDhROWxvZytCc0toak9jZkNGSHBM?=
 =?utf-8?B?TndJL3VpQU5BVERyallncjQ2YUpwVEIyNkZaVkU5YjVlV0c0czJlQU91OFZq?=
 =?utf-8?B?OXFqL3VCN09JQXpUTTI5TGdpNGJneXJIOEhNZllzMEVrcG5MVkpyTGxIenM2?=
 =?utf-8?B?WW5NMkNSdWFHQnhPdi95NVp4MDZDbUswZlprekRXenUwcXJEaC9YSEV2WnFk?=
 =?utf-8?B?RGdXSW1raGQ3SjFDVWhvVWJuYjRTUnY0eWswQUl0dlJNcDBmaEwzV1N2eWVQ?=
 =?utf-8?B?b0xNSTBwOFRPd2NvbWFrSWh2TDM0aVJTTVFEVnh5d21oL3lHcVR1aWNqR1Ri?=
 =?utf-8?B?M0V0V0RNK24yVm91RHYweTFTb2dnSnBDaEVzQ1V4b3FEQi94U1dNcDAzc0V5?=
 =?utf-8?B?VWdVaWZWVjVNc2NlT2x1eUxjTzROSjk4dW1qVnlxakJ6c1VRUjVvSnpqTFZX?=
 =?utf-8?B?dVd0S1JCc05EU3BTUTlQcDN1azF5NGwrS2ZYNXJza1ppeGJEbkFCWkhLUDNx?=
 =?utf-8?B?ODl5UGV0cWI1a0RMNldXaVkzZTkyQWV0WEdXSjFRVkJoTm9IUERMbUg1VElm?=
 =?utf-8?B?SGtjMnVFTWdyZ3VTUTVJN2NmMDJxSnhkUFRKWTVKSVdjUnpLSml1d09WMTBq?=
 =?utf-8?B?R3BFMnBScm1FWHZ4NFV0M3l4L1pTZWRodEwxSVA0QW1zYlUvSTBHWi92SjY0?=
 =?utf-8?B?NVU2YTgyV1lHcTJTc1p5cVJuQ0w1eGdwMnRySUtpYU0yM2pYeUhFV3lTblRV?=
 =?utf-8?B?cCsrZDNaOVlFblVhOHRyWWdBQ3lJSVExUTAwM05SdEZ0Y2s0QzJRV1JHdDhm?=
 =?utf-8?B?eVVqdUpiRG0rS0lhajlTaGVLMXhYcVBJZTZZUy9WQmF4aXljUGRha01sVXpl?=
 =?utf-8?B?bWVJSnVkd09hTWhReGZ3S0dKZXN1emVuOUtxMWJWQkVGa3NDUnJCUm1ZKyt2?=
 =?utf-8?B?ZXZmN3AvZFJVSkFaREpXUmxFVzBUVDh3dWZ1bUVKbmRxYXlKTklLcnZJS3pk?=
 =?utf-8?B?dm1rZkphU1h5Tm9oeUw4d0VuRkhGOGNoRExBV01hYmc3Z1JNcWFYbHB2cGZa?=
 =?utf-8?B?YnNaUEk0UWRseHVPQjNMZThDd0YxOFg2bXRRR1ZyY1pKNXRNQUtHaVFIbGY2?=
 =?utf-8?B?c21kL0RTN09FQ0NnUXdCQnE5UG9wNmthU2VGajhuLzBIMWxGZnJ2V1N1eXFZ?=
 =?utf-8?B?MitZcGtnWjVkdUsxN1hQVkRMNWR3T3d1SHh0UmQ0Q2xuNDVBaDhtd3ExR2px?=
 =?utf-8?B?N2UzZDR6dzg5M21nODlla1JBc3FaMktFeWFOR0p6cXlQejE3V2kyU0JZTm84?=
 =?utf-8?B?NnAzYmRvVUU0bmJiaVJOTjZZRzN1R01JUnB4cWJHYlZONW5MSjE4QlZaditX?=
 =?utf-8?B?RHpvclVDY2FkSmtETWZycFo1RU1ibnl2djY1QW5UVWpZaEdGMktpQ3owSDlw?=
 =?utf-8?B?NHhpV3ZyRWxCcmZjV3g2eUJnOWhOSUNiNW1XeWR4L2k4dkVoLzhHWnlhcWho?=
 =?utf-8?B?YkxKODI2dC9vYzBWMUloSjg4K205TTE0TkFub3dwN2pWclZObDNKZnM4VGtS?=
 =?utf-8?B?UE1jVjFCTktvbUM2S2xFTmJLcWlBZFJQWnVOYUQ1M2RBT2oxQVlNRFh1S0Rh?=
 =?utf-8?B?Mm8wRkh5N2lza0JpclBJRUdrbEY2RWQ5SzNCKzJoZnh3VzFyUEkzSGkwRGFC?=
 =?utf-8?B?MUN0SEh6a29QSElQbXRpbFd5T2hma0RaeHBrcFFJL1UwSDVIcGVodkVsTTZ2?=
 =?utf-8?Q?cbF3VuYm5GOANcG+sUWfMOk=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac60cb5-fd86-447b-a144-08d9fb3d82d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 04:39:46.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4kWiGBPtbYtH0gpHZYVfkpZcaLvv1j/1nviDazeXrhXgcLQJXQcNI9P8usI+UeH+gcmTAlj0Uu02jAoU5AZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5433
X-Proofpoint-GUID: lygOOWBQBc661TMI8uWeTptFx3RJxo02
X-Proofpoint-ORIG-GUID: lygOOWBQBc661TMI8uWeTptFx3RJxo02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=764 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/1/22 11:59 AM, Peter Xu wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Tue, Mar 01, 2022 at 11:21:15AM +0800, Yun Zhou wrote:
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 78125ef20255..75511f78075f 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1596,7 +1596,8 @@ static const struct mm_walk_ops pagemap_ops = {
>>    * Bits 5-54  swap offset if swapped
>>    * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
>>    * Bit  56    page exclusively mapped
>> - * Bits 57-60 zero
>> + * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>                                                  ^^^^^^^^^^^^^^^^^ remove these?
Sorry for my mistake, I will follow your suggestion and send patch v2.

Thanks,
Yun
