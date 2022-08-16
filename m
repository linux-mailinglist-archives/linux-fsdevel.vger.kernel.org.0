Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92529595AE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiHPLzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiHPLyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:54:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A275A83F;
        Tue, 16 Aug 2022 04:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCXA7gzoMB3Hpo2wOQDjBVYwJgNp6CRHZGZORWz373hiYfkNFWfZ7Jvq/6VmAza/qpgDz45USUUqpZ/pPMjU5oo7VmB6fcbdK0t7eEYMpkBopIFbq1oOFATLuvYhQuWUpIeIY3KuPGZrw3Bm4ufo+Q1zg8lixanckKsAxH3717nfcqx3pcWl4XP5s59gAeOcZYR46R9WvgZy13UZlp3mFT98i4xp0+c3JwfxnywGlpGo1pw99o9E6VfCa4DdOnKcPScsCGoVr0hNKcS3xoU3f1VEecS4T2quVdwCI0bdLoU0V0SJ98gftsbJ51tew09cYZOtt/krSDp5+vgfqKpy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pUlho0++U/VTbejrAjIJ3HXfrbClNezApHohX8InyM=;
 b=KZDh25dlZ27XsPjx9FS9pGwaTWa5H96dRyOJvtGANA8JF9FPOZwzpaSwa1q+4aDt61icwFZZLQE3pUoGUbCOeBg/LJIXfIYLFrXEuiXvOZxcaWYA7RM9AZW4f9t24Lk0ODxYW0ZRkeLD7RflqV718/LayzoGNuHpicy7B89irw6bPrsvYQ0f4iQ/6qtrJQTXJ1ZBnmwv2ZRP6ZbZS3E7MGoaqkSs7BxdfrjXHB71bQmVxOLbZiiP/wP2Yyf+bFgf2YRuq8LVW7iI6MqlTLIX+Wmt9wKIhpu8+lR1Rv7W7YgO1VKBlizAJObNjQVydy4aoeNGZneQFeeebdbO4w+ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pUlho0++U/VTbejrAjIJ3HXfrbClNezApHohX8InyM=;
 b=sT3TTB+XW5ba7NbfkGDeOxMkHZ1k8nBIZmj6nrnN0nhjm7WbTbhCdT1i1/bl2v1L9kon9d1QoU2k2eQI5pUnakxUXzFhcotSroPSF91fPMiFjWkGhyka8D8sCft71i8W68O4aEARq5vZgMMj6ie27YpPDKCx1+6OM5YdEjSmZQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by CY4PR12MB1270.namprd12.prod.outlook.com
 (2603:10b6:903:43::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 11:33:19 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.025; Tue, 16 Aug
 2022 11:33:16 +0000
Message-ID: <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
Date:   Tue, 16 Aug 2022 13:33:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     "Nikunj A. Dadhania" <nikunj@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
 <20220815130411.GA1073443@chaop.bj.intel.com>
Content-Language: en-US
In-Reply-To: <20220815130411.GA1073443@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::11) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa13b2e2-72e3-497f-ab30-08da7f7b1c62
X-MS-TrafficTypeDiagnostic: CY4PR12MB1270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWhWuK1IdLG43K4/P4Uy4qgONs2r9+nyGGCC+NEG9g0jJcdP4E+B5AEPCi3TKEKWfnTS0HW1RoUTo2Rod1P+FA4oGA4m89LbH+O54toGOB2rkNGDNQosEi/Aa1jZkDXFc3/39OgRsi9zzMNFUXTV0srjayFe6bJzhhywKBpK6fIwicgwP5ES3n7a7LH8/Pt0JlkYqRMtTsDD1R9bBfvk8MBXkttSrho6IHF/WtMC/JBTOke5q9P5etm7SIFXdYv0jWe4A5pR6jAbi3TpcpDKSXNLkHmErjcW8bw4FjjnCRYZ4e0A6V5MBYOykOeGmHNAe3GzBbZHMGTpRGcjz8PF979UlX0TfOAx2M+8z9K+gn+Nqc4DILGLPUr1VevdfsbDTl6MAohUky8SSCP0k91XLHqFniaoUUF39fMPhKuiTNzunSXFlaWhnsUL34dUB8qRI1HXBheUoqwBB5feomlhV+hQyLcKFrowYYaTtfO99pghRMbU9q482n1QIH/jVeZeu8Tfir21F1DihicKEf8S159r9/jHZqWouB27/KZ4ruO2dmgmgJ950YXJyg8Rv3QNdeEqausKuRXN68pL47FeMAYw0l+6P09I+rrP3PkVsHniv/cdpReQbtM9USesjoBVdDN6E8mQiclgty9lBkjHLQ26IsHRPbAvqjoV0zBDk9ZaETpsj7/q7grj9QIKPJV3k3P/FxThWWPLR/D4L+69c2Yelc/yG2sLFd+iYNBnM2LO8G5XiF4RluojvIqT0wh4N/O+O9o46UIwqRU2shjM23PD7ALshqHQ7xblV+YzaPSLtPebVRBfwPftsZJt0oTKJai3HQGEcbvwJGrvmqHXtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(26005)(5660300002)(6512007)(36756003)(186003)(86362001)(31686004)(4326008)(6666004)(2616005)(2906002)(41300700001)(316002)(6916009)(66556008)(38100700002)(66476007)(31696002)(54906003)(7416002)(478600001)(7406005)(6506007)(8936002)(4744005)(8676002)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZPbUZsNEtzb1dITGVsM01OdnE1WFh3QlgwTjJhWGExakUrekViMGkwYWJz?=
 =?utf-8?B?NXM4R3NzUjlWaG5yZmt2TlhFVzhmSzNOSXZPS0lNVVFoTm1GNG5VL2habW9J?=
 =?utf-8?B?WFA1VjVJU3dQYnRrV0pRMnU2SlNsMDNxV1pINmhxcGozM3JYekppdndyaXZT?=
 =?utf-8?B?aXVWWUtqM0JiTXJHVVNEU3pjVXFEZ1A4Wm1CbXBXQUhmU0ZwZEVCNFAvbnda?=
 =?utf-8?B?UFFNV2NWOFU4eldDRmtBVkFkRlFYWnpoUXUzeGxnMlR1VUR4Q3ZQcmt6UTVI?=
 =?utf-8?B?YlZjRGJLWEJiejBNLzJYUWJWUHN2OWFHWmVhNDZPQXdvZ1h0em1aWlZvVGdI?=
 =?utf-8?B?TFRNcTVieERuY0oxNjVxbzVWTzltbUVLWWVEV0UzYkFwZ1FPN2dYWWJPMmp2?=
 =?utf-8?B?WnlQR2VHc0U3QmxXVnNqU3hmOW5Zc2JrUlpWUlZiWW95RjN1MWQvODgxVG0w?=
 =?utf-8?B?R056ODNKdkdXN2JBU0gzMno1R2RGMGUwUkUwaWlXZFNhbTdpM0dJb2RTVkhN?=
 =?utf-8?B?ZW1JSnJjSlV0TU1pUy9HRmV1a0RVT3RRRlhidVV5OUc1bDFXaGtwMnhtMDY3?=
 =?utf-8?B?WlBIQUVrQW9pOHJSNHRKWkM3eEhXUWxVQXBwc1VxVm0ybFB2ME8wQUVrMXkx?=
 =?utf-8?B?bUZWeXJYbmZjSjlpeFJ4Q2VSTU5NYm9qOEtTL1YyTXZEbU04SElwL0lEVHNm?=
 =?utf-8?B?ZjlCZnNKam44M3I5Q1Q3YUhMVjZMSzNzM21uOFVTTlRYSU5NQzhzMXBIMFhr?=
 =?utf-8?B?bVNDakloTStxSHZVNzRNNjlocUM0c2ZIamxjMXBSTnM3MTgyOThzenNYd3dI?=
 =?utf-8?B?SWJOTnp4YmVWKzkwQWRNY2paY0VxcWpPanFqV3U0VEhlWGZ6Rk1TbWs3L1g0?=
 =?utf-8?B?Vll4RkdqQnBUTDJyYWhveDFtd2Y2c3NHd1N2UHY0dE1aTkM5d3lKWGEwc1A0?=
 =?utf-8?B?ODVQYWZqYnMrYUtrMHppTk84TjhsaCtHSTU1dkNHOHhIbTFCa09EWDdrMko1?=
 =?utf-8?B?ek5kRkwzQ1hvaEoyVSt3RTI5dEJOWDMrR3E0RThxbnpKb2xNMUUxbk5GQ2V6?=
 =?utf-8?B?eXFXRXBTMjNrWmFNNTYxQytoa055V3lUKzRuR28xR3JKS2k0YUxkMFZNekgw?=
 =?utf-8?B?Zmp4VGcxUGxIWktyM3IwTFlyRDBnV1d0UWJzTTZ1dUFNb2VVazQyTVNLeVZ5?=
 =?utf-8?B?eWhseWVUSGMyUldwYXhaSTdCc09BWVMxTVFGdDVINHNRNFFkV3hFbjJWeXRp?=
 =?utf-8?B?Uis2Q0tRbjJFOUF2Z052WDhXSzV1cy8xS2p6aWViTFBEQTRKNUhrRmo1aWpL?=
 =?utf-8?B?OGdLZTZxNmpoajBHTVNEa3VSTGJFUitTdGc5YUswQVhHcFRsTkN0OHZhZUxV?=
 =?utf-8?B?Z3IxRWJySlRpbkZEbDBQVFRFNFR1am5KOHZYa00rTHVuMjlZck53YTY2V0dX?=
 =?utf-8?B?d1VqYVJjanJJYkVIVlVRS2tIQ3B2d2dZdURna0Y3V1ZzK2xBTVd0L0ZmRVR4?=
 =?utf-8?B?RXRRODV1bXpXZDM3dG05N0IxTERLUHc0anJCL1laSS9sNFBzRXJwcnFvQ1Vv?=
 =?utf-8?B?MXJ0RzZ1djU4NThRV2xYdjlhRVpoc3lWYzh4OTBQUGJMYkc4T0l0WUEzUGVt?=
 =?utf-8?B?MzNZbTZJNWVjeGdGUjkrTGZqeTVYYmozMFJ0amVWQnRsSDRwNWVrOVUzckpv?=
 =?utf-8?B?QldVV3VxTXJQRC83SGJlZzNkYTJOQXNoYTRQVW1GZVpvVWNZdVpORnBJczRj?=
 =?utf-8?B?YUlVSEVDekxJRko0ZmFjaU15MzladStyQzlzek95L0ZJWWo1ckNWZ0xjRjJI?=
 =?utf-8?B?TUtURDFiZWgrT0x3SWk1SFQxYnFYWk9QL2kwUG1jR29jdVJkbExhOFB4MlRJ?=
 =?utf-8?B?c3FmMExyajg4UWw5b25NRXp5eWs2eUg0blZiSGU3dzZEYW51R2xvd25aek54?=
 =?utf-8?B?UFRubVRrWU1rbHZuR1pNVkhyWTQzT1lEUUpsemd5ZnUxbFBLczBxRGJNK1ht?=
 =?utf-8?B?NlVPUTdsZ00zQVNQWWV6N1RGNy9NTjg0RkVOWk5FdENtS3JUenZxYmVOMWJH?=
 =?utf-8?B?d2tQYnl2YUplNkttMGo1eUZGTHZSTFBOMjJUZjI2a284Wi9WV0c3UlJ5d3Bl?=
 =?utf-8?Q?NTHmx/4bwOg33YZYd6A0VkEKo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa13b2e2-72e3-497f-ab30-08da7f7b1c62
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 11:33:16.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGAwZmatWUwtifIQkNIEAMLUkhM8Cd5EyRuw7Qyccdr3yCBjoGJOWfHLU0ETOGOzqFB6Q1O580qHrXjE4Wb8MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

> 
> Actually the current version allows you to delay the allocation to a
> later time (e.g. page fault time) if you don't call fallocate() on the
> private fd. fallocate() is necessary in previous versions because we
> treat the existense in the fd as 'private' but in this version we track
> private/shared info in KVM so we don't rely on that fact from memory
> backstores.

Does this also mean reservation of guest physical memory with secure 
processor (both for SEV-SNP & TDX) will also happen at page fault time?

Do we plan to keep it this way?

Thanks,
Pankaj
> 
> Definitely the page will still be pinned once it's allocated, there is
> no way to swap it out for example just with the current code. That kind
> of support, if desirable, can be extended through MOVABLE flag and some
> other callbacks to let feature-specific code to involve.

