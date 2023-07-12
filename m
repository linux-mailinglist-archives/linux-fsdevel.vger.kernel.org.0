Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46910750E75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGLQZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjGLQZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:25:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB2213B;
        Wed, 12 Jul 2023 09:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMQY69OsbHpYa8pdE2U0rC6WHGhZe/guMD/qRM/yzjmEeVpE226KswZ4lpWNvY3qyPs5ZiO+shWV4/pX17WSKRGkYW+Pjfu+fxmad8GzXuHXpBdG3uwmO2jpe//zhHwFA7/rGtrDiXFb54Q+HT/hVz3mT+rMpcZnySXi1u5XL/UCpoN5BZkZ2VohoIofY2YIGrEYJKn4dyIUhuTJ6yBD0yQhLTwWWRY1dZUUetipNUiLwNARNTXkobfP2DWm+1elelycVg1KjPzjWt1hDF3sGZWo0gBalaLm8DYh+xnhddR9xskiaT589YJks3R5MRssF4u+fwxa4N/UU28T7La8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3/47gkvMH55/0CMpRSovEUXrZ/vEpWrsM9f3h0jkD4=;
 b=WSztg56+BI7hLJOvNlhO7fWZsctji2JzCErEhsSR43Agh1WKN5IuBUiAAEFHLwC9KTetS5LueozC8iiH3KsumjfcI01eGXE9/cjO9+ZQKVSYSUpH1eXumncOsKcdz0Q3Rx7nL7VBfQDnryc9q/D6uN8d0TYDA0xSaauSMcUIHDuuoWAZ6ykelru3fK2hOadRLyg8+m+fPXTWab1TCj/7sd4tcUCgFv1tUlfv+Kw5pwrkcMKPuYPLv6lxFYUbU5uNBNEB72ybrndExjyLmO71xf/fzeiRNQQCY8iJjOAxWQ2Zeh8+Pfz+cOS5QOM3Lbgkkxvezl0S7OF1Q/PCWfNhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3/47gkvMH55/0CMpRSovEUXrZ/vEpWrsM9f3h0jkD4=;
 b=nmP0PBH9CMjr7HUHzTS0M6Qlb2T3j2VcFqwUjXoiZCnbQ6TjLGGdInTY/P5tAk5FcNr7Fbw7cYqQcV0DvDIVdBdV/AcNmTLw3LofU6RDO+4tOuNznBgrzeIGbiucGPtdvEgOb9OcHKaNton06mzHJ9qLeF4UV2leme4ck9kslkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 16:25:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6588.022; Wed, 12 Jul 2023
 16:25:01 +0000
Message-ID: <83f11260-cd26-5b46-e9d4-1ca97565a1d0@amd.com>
Date:   Wed, 12 Jul 2023 12:24:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] drm/amdkfd: use vma_is_stack() and vma_is_heap()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-4-wangkefeng.wang@huawei.com>
 <ZK671bHU1QLYagj8@infradead.org>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ZK671bHU1QLYagj8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d2cf1a-4060-42c6-f067-08db82f48a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdS/k/UyI757s5MIVZCkAnaiewmbp9b9MhABMbpSasgeLFu+dl+cRwaDZ6j501gaswKmBIhVv/3D0xWQcsKXbXvQtcHDbTX3kBzaPmoLYP7Qb6vX3uyCdVaPZaD8yuZZFUq+xCdZ+FziuSHce91BeZlZGB7uEtSW4aTJU1ohNIK+F7HYz8AhXpCtadbA8NL+OmajUF6q7YE/687Be48OK9imbGNdWy04mDUvOWOySO6/5TI1zXB1vCTG3nX+dDFRJWmAjoiA16gbTmTWPMswGszLFFNw86eOyHuzvnrMcn+7SqmmpizYtOscSvvddU1RNAhVSFDvtjjou1GHlbFisSV22K3/suW37Ji3frPD+uxZs6JB9R09cUctI6ftQeeb/zmc8OY5v014qpgaUt/yLpN0JZPfhjq8tKVV3yKCXc9gni2VxT3zfg2FNggzW8U2v0/ZU61rbUP5Uy/93xtLEN1R/WMDLkGIsDfQvKDuOvQOhynwrP7K8qTQNzU24QRwaCnMRvOOSg8sUvexe4PLnTIlDroX8er1DaVD84z3Pss3NjD793FpmqCMSATJPAtecp8OSZ6YsM5gnOiTXd9HKorVrWErsxA0zAsKBQo0LWvy1vVBc0TsuzzlQzvP6aGW47OryX3tbXuSKMGI32Qqhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(38100700002)(31696002)(86362001)(31686004)(186003)(6666004)(36756003)(110136005)(6486002)(6506007)(26005)(5660300002)(2616005)(6512007)(66946007)(2906002)(66556008)(316002)(4744005)(66476007)(7416002)(8676002)(44832011)(8936002)(478600001)(83380400001)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0V0cy96UU1JUitoMURIQ3RkZG5sbFNFT3FPbTROeCs5VDllYWYrZzdwNjBR?=
 =?utf-8?B?djNCL1VzQUd6WXRHUGxqQmNoZ2J2VTcvNkRNT2ZyK1FQMUFKOXdGOFFpWTd4?=
 =?utf-8?B?cFo3YTh1cmtCVTBReGdZdTFaK092SkRsbTlXSG4vVFliTXVjdGpxZyt5WW15?=
 =?utf-8?B?SStxMXVvZ1NWaXk2T0VSVStySHRzT1FCeFkyS09JL3JHTm9WRGYxZnlTZFpI?=
 =?utf-8?B?SkJsckFNYnFXNjF1N1FoeTZYNGJ5cXUvdVZkWGZJUjV0RzFOL2FLQ2MzdE1V?=
 =?utf-8?B?d0dHYUJRL3VDbDB2TjRQMlZVRDB5cnpUYVhsdzB3NkVnWW9RWXJhSnJGY3hK?=
 =?utf-8?B?RUpXMEsrSElxL2FRLzVGdis1MVBsSmtoaG5jcytzZDJmeUV2bzd3UUJ2d2VL?=
 =?utf-8?B?eCttakhkUWdpSlZPazNZY0dBWlphZ20yK3dwckEzaFRoWU1MNUFrOU5zKzhp?=
 =?utf-8?B?YU5FMWFjcFJHaEIyZU5USnJiaW9VUXpRK3JhWDIyOHRsZ29OQldmNG1ibWwz?=
 =?utf-8?B?ZkNWUHQ4dk9ycUdkVlY2SkloUlpHMzg0bjZkRUxMaXBSVDRQZkEwSmNpV2xa?=
 =?utf-8?B?Qy85bk94enVjTmQ4ZmN2Mml0bFU0M0VtTytVKzV6My9qeTVqVUVkTnU5Y0RC?=
 =?utf-8?B?d2RlTG9xUHJrcTlvTlo1M0hSV3Y1aFFvMVhzZmh6UlVncTBWZC9zSC9MQ29B?=
 =?utf-8?B?aDl2NEVuNHpwSTkxZXdBZWdwVGdQWHNYWkdvbjlVeHNoMHRScms3amc5ckhj?=
 =?utf-8?B?MDNFWHMxQmJXNVhwdGFtZHR6dklPMTdBUDFONUtITm8vem5YM3hEQ25OeDhZ?=
 =?utf-8?B?ZmtnL25XN2pOS0JSVmdIQmZsUC93SDRQempaK2Z3VUpCM3R2cE1jRTZFdHlQ?=
 =?utf-8?B?TndBTXROeFJuc0RhR2dVVmtPaEh4QUxIN1Q3Q0QwakJVQ3FNUlV0YjNSVllF?=
 =?utf-8?B?RWIzSzZHR1ZETFZ0ZEtMRzRVMkVyVFdaR3pVNStkWXFxOUtaNnRNVEx6QXQ4?=
 =?utf-8?B?RnlFMklaYlNwRW41K3cxU3dDVVZibTBpcmhOTkpRMFplWFBnL3RvZlUxdU5J?=
 =?utf-8?B?NWlvdGZvL3gwRWtxeVFSeGFnWVpqOU5CUWhQM3ZMSlE2eHNLNGhjZjJoNzIx?=
 =?utf-8?B?R2l4alQvb0NkcjlnRzB5UCtiMlVGdk9SajlQV3EvY01CSVRFeFNBbXpzUExG?=
 =?utf-8?B?QVlSWTRGWThHZkNKdER2MHd4d0l3S1Y4L040bDFXc1NrYlU3Qnl4VnBaNU03?=
 =?utf-8?B?UGVaN1IvWi9ZWVRISjVrZkJHeFZvc2k4b3FFNUtCU3BKVTRQNFgrcjdWemQx?=
 =?utf-8?B?WFNXd0dNenpiTlJpNkkvMTF1V2ZQZ21oK0tXQlZLMUVyRitveENoOURDN0p0?=
 =?utf-8?B?Wi9ObWlLdU5iS1hPN2VzVmMzVW5SRko4anZVRE9tUlhYU0t2R0dweWZ4VmZR?=
 =?utf-8?B?c1dGc3BEbkEyOWVuRy9pQ0dtUzBvcmRkZkp6SHpDNDVaZXVHY1krTkRkdkVN?=
 =?utf-8?B?OCtpblNZK3lvODJFcGZoUDJaNS9NNmRJRll6ellwdTJIU0lYd3NnVzIzQ3hO?=
 =?utf-8?B?emYxZHVkV2VES0c2N0gwKzhQcHFCaEd4Y1BVc1B5N0lUZnI0QXFHenhEY2Jp?=
 =?utf-8?B?TXdZZVNRcTBHeElwVWhSS2x6WGttR29oaWJadTkvSDVvYTFqQ1N3UFJCcTNz?=
 =?utf-8?B?cCs1aHZicjJXbWZIa0pUZElmWCt4NFZRZ0pjOUlMK2g5MFhscWF3MnpNQW5T?=
 =?utf-8?B?YnRMeVlSVFBUN2NyZ29yVVovUkJGWlNjR3RJRjArNVVTNVBtV1dqR0FDaWs5?=
 =?utf-8?B?WmxLeVh1QU04Y2VnM2pNYnViTlJBdUlsUlhTeXE4bjYzaEd4L2xrRTJSOE1Y?=
 =?utf-8?B?czd3WnRwRFdrMzJBT1lma0ZjUThjbllOTmhTalpsVDBmWEdLRUZMZkNSb2RS?=
 =?utf-8?B?VjFlUk10UnhZUzVxMWlWT05Na0FrSUwrQ3JJMTg5cHFzQjVOTGhodlN1MkVs?=
 =?utf-8?B?ekpEOHlneE9FZGhQWnhNbWxIT2NxVnpPTjZjTHRZYjlpREJSQ3Q1VnB6cmRo?=
 =?utf-8?B?ekRTUU4zNERQZXJKVzZBeGZYcHpQbS9YQkhES0VDbElFVVdxbHpGYk5aMzFR?=
 =?utf-8?Q?k6zPpGmn6hJnz4s4tpRnwbJVg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d2cf1a-4060-42c6-f067-08db82f48a53
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:25:00.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1zh1/k5wDb4P/oLtfnufCF8yl68ug1VUFVZPmHwO/NuQxu1Q3mWaf+9JHW8ifrz3c+Ggr0EtkKciPcpuSSyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allocations in the heap and stack tend to be small, with several 
allocations sharing the same page. Sharing the same page for different 
allocations with different access patterns leads to thrashing when we 
migrate data back and forth on GPU and CPU access. To avoid this we 
disable HMM migrations for head and stack VMAs.

Regards,
   Felix


Am 2023-07-12 um 10:42 schrieb Christoph Hellwig:
> On Wed, Jul 12, 2023 at 10:38:29PM +0800, Kefeng Wang wrote:
>> Use the helpers to simplify code.
> Nothing against your addition of a helper, but a GPU driver really
> should have no business even looking at this information..
>
>
