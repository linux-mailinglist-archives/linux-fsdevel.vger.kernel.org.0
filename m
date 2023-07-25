Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDAB7603EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 02:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGYAX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGYAX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:23:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D2115;
        Mon, 24 Jul 2023 17:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQshaVJo+Imw5FT/PvX0SjTY1S/D5JTwn+kMFtJBELz5ci1VIEATPDbjWlA3X+dA7fTNk4byOnlnUfMzEHUyYXnaxNHe3VLDDGu/7TiHxfSVIQmQAdljcibGiQ6+PwCQopPpXemQq2r94D0nIpoeXsTkLY1w44Nx/UzbtwtEOv2npAR0nPKO6OW+qwSPNehOO4NvmjyzGXEdgn8KfxMoAag6PiKSu1PVNkkyBZb3CDn3x2gW09zNUXC5TtuLGPl7ky1I+K/AV6OwGlI1a00wb3THQ2DFq4hFeo456OXovbVtPJ/7Di6hd4+870Y8u2wg7/3tRjtXjw1e1dXR0fm6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku6MUz4MWhYaOMPRiAjUDVhN6Zt5HLCAWnUljt2NgLo=;
 b=JQ25lgqCSeh5MPALkOkA9kQ0tNXkhLmMn7HgUpgZK4hrrWV0i1b0kgPGYyZb0Z2EwWcsTBjKh+tAxcCULGXKA04b7KCw4Z33UBJ2Mk2nb6FguIqF3OaUpuihgYFPWt0zgmZFcuC9rVUlm01wf0cc89AxS7Xjmty3/aK9BmMwryPUpcL7trPAnGrz1EfJ7GjCOg9OFQH9TzYHsi0Lgg/CV8XPJWQOqNW+DACdDseULXI2BDkJL0vZ9fqFMYKSXivPmJISRJzlqlrEJArb8uR/AXqCmW2MNPB5S85F3OTA0K3eXaToY+duCvA8RTZ6geTwzEb0hEDauRtifyFY3uQg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku6MUz4MWhYaOMPRiAjUDVhN6Zt5HLCAWnUljt2NgLo=;
 b=mdsDlMRO0DBL2q0erXUI795RiQl6DMQUds39J3UEyLbK23zeMbizJDRR0f//NbcQsDUd6EQT9gc71FmrWEq4tayoEuJCrBXIClK6yGe7/50QzWOauI779HblHYX8YsExnIfxSgQb1TjbHGzbjmQ/13eoFXUNL9Nb8/roFp3wCTu2ZoJH1XsgbJkLc5l24RwVDsnZr0WbRVykDNQps2Qin8itswWkBx90aYierPwu88n07Zu2904e5PsWiA8xeB1WLr4faD84USCBMZZwIomszGKrK0cSKSNVMh51sP7hkjZKU17wvlVyWSYzy+JrQntOe2IIpSjRgmaQ7pbCYxLBFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 00:23:55 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::3eb6:cda8:4a56:25fe]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::3eb6:cda8:4a56:25fe%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 00:23:54 +0000
References: <8f293bb51a423afa71ddc3ba46e9f323ee9ffbc7.1689768831.git-series.apopple@nvidia.com>
 <20230719225105.1934-1-sj@kernel.org> <877cqvl7vr.fsf@nvdebian.thelocal>
 <ZL7AbLJ+RUUgzt8O@bombadil.infradead.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        SeongJae Park <sj@kernel.org>, kevin.tian@intel.com,
        x86@kernel.org, ajd@linux.ibm.com, kvm@vger.kernel.org,
        linux-mm@kvack.org, catalin.marinas@arm.com, seanjc@google.com,
        will@kernel.org, linux-kernel@vger.kernel.org, npiggin@gmail.com,
        zhi.wang.linux@gmail.com, jgg@ziepe.ca, iommu@lists.linux.dev,
        nicolinc@nvidia.com, jhubbard@nvidia.com, fbarrat@linux.ibm.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
Subject: Re: [PATCH v2 3/5] mmu_notifiers: Call invalidate_range() when
 invalidating TLBs
Date:   Tue, 25 Jul 2023 10:20:52 +1000
In-reply-to: <ZL7AbLJ+RUUgzt8O@bombadil.infradead.org>
Message-ID: <87v8e8zvmz.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::17) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: f49de129-5bb2-4bb7-a2a6-08db8ca56d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4kV4QoyxWeJb12KnNIxvGW2EgcWAB4DcWd8MnqcX5Ow77pu+WNj0mqYhoDaSOvEx688pjOalI0g3D69B1b5S3pJDpucMVbLIM5xDSW3DDbPkitABTHFRmmxEBPbbchrPEuEp29VBu5gX+Fji3Kd9pyybSWspIE2b59MqtI8K/eA0AUCnuDtpXew2ZYCXqN+LtR5ZS6iOr4+XIdXHWGo2pWvOzYuL3yv4RcqZiyc6Mu/4iT6+zWkTBaNOiMyM9p9w4vwJjSQ6S6auhGwvkoNOJI4azOMdTOKNk0erjctx47pxsJDEnYRUHc6pec0cnhTFWx2miMAr7FFXk1hmeIj/qSotl5Ct9yuEl78Jkxt4nI+AEOG3QzaU21kWHFF3UyoXy54iLeUXQzT7zDtA1ACbihsJX6EHZuSDZqEaBVc8n1nJI06XZvconfz40/SD6XcOrb8A8c1n1zNUBcfkgdjK4Pi+rSeqfmkMT0anCle7Hw2ef64r3/YGYHlqbLryv8BZPxOEqcREM9bjx6PILY76VgcS7WdrXHoUncswyis3epNqj00f7WEm4TKreeJw1wcfRA0WaXaVNxRh9wwgasvr5t9vYaGF8vH+C6v8orLTrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(5660300002)(83380400001)(2906002)(7416002)(8676002)(8936002)(38100700002)(54906003)(966005)(6486002)(6506007)(478600001)(26005)(186003)(41300700001)(6512007)(86362001)(66556008)(9686003)(66476007)(6916009)(4326008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZyENK2BIcQ5IWgp+X9tHTNXPyEU2ibIZKb/CxXI7KPjGUXl2e1C2NjDvWLEy?=
 =?us-ascii?Q?FCE7ql9oHYZnGFD7yPmqjKzdjlGs5nxc0B/2+1/78nTSY+PXPzsmedG1U2tY?=
 =?us-ascii?Q?DvUsvPk90g7GOec06g20huyXnTlkyFZvqKG7wynGda5SpiSsVNy//xbKKmFZ?=
 =?us-ascii?Q?4fVZkz195vhwdNJfyTeMiroNal2tPv7oyk+dypUhWTBO+nmm/Faf3afCyGle?=
 =?us-ascii?Q?OaiDn9FjxPf7A/27VlZnDJjQjyO/fexi3lCnVV8U/pKbm7hvPGY/BllJmM8G?=
 =?us-ascii?Q?2eOBjFGGuQ1EMorDmCL7tfIr+ub2FOYH49AOsGznIeT72IXfNLGVhvmprD0+?=
 =?us-ascii?Q?fFE7sEfz7tVuivNsGnJGsIfT92Ty6uKfBXwZ9z/UQUZPET9RSvxunw0XwMtx?=
 =?us-ascii?Q?QGQfUpC4EptsRoglaoOSIYmlUmRcNcEYGrgDwb7d88tkEtkiWYO8atgzsPzQ?=
 =?us-ascii?Q?XQLG/fCAxX7nc+J2TNWud49o1zbXaaiWco/bBQn0AEspmz3iS+Z6cdBrPViB?=
 =?us-ascii?Q?zR9zQGdjqGBFp4h7K7oZl78p0tgoUlGn7nKuJzEqsDUlo+crpHXEoo7YRFYo?=
 =?us-ascii?Q?V7pI73iJpwdKBDo+Vv9ryW/xjGu6fYKKvTEUSpwOr5Hd21gBFpb9lY/jjOxP?=
 =?us-ascii?Q?aPUoiEH3y5Bi/hiPSf4MdeEN9kf+G7MtUTZg+7f9u4/WylIrqMqWudmaOsvR?=
 =?us-ascii?Q?e002RKAENuJk9uJ7rG3ZkSRLGzNbtcRI/Y9IM3eJvpiRkHwqfpK+YMp3Ubdk?=
 =?us-ascii?Q?2r55Bv+ixReWr0L2So9UjZZVYmHiRBpZmxXfHYO5RwlHo8EEMVZvs4d7+HZs?=
 =?us-ascii?Q?Rz3UnkBnwXmmI89M7T6XhHnJYvU9crECnHqPA5QYuQj6uh6JOdbqOGJdFJce?=
 =?us-ascii?Q?BUoQEw0dgszYgqG+u11LJ4TKPxdFdszj49y55tEKwVwugjvfc4s6JVGoLfdA?=
 =?us-ascii?Q?x6JbPFmMjOq4xBLt5k//MKiyQX+sHUH0e53UC5JApyJmhbUhFd232DrdvfM9?=
 =?us-ascii?Q?V2rskMU4Njjco3qKO5Gx85ybYeCc+9qyneJIzalvi0fd+Fl1RX9UcZQVrCmH?=
 =?us-ascii?Q?76hN2qLIhVud1cwyqJeqJlV34hMTJ2CTBA3+aNfM2yWFDIXvBZDG84GZ1+HK?=
 =?us-ascii?Q?VbhEgahty7wb+WNBZXeKBBhaRiqOeBH58cytgiU8ZUxZNeiyk/tC6orRSMZs?=
 =?us-ascii?Q?SKjZAMAsIlxC1nJMqK5GOmlQbO8FmIiUAKzb/yLvGzARhMu7AAn2SENY7TQl?=
 =?us-ascii?Q?WhGpF2oAsO/Whxg9cRrwB6cRPa7hAmTX86LiIc/hvKCx+FeKgjjAYM6TQHJG?=
 =?us-ascii?Q?2RJRl/n1sVXTTvIGrLnW9KSSU6hcOrKNWVPBP6B4f1pnxEDmwvAEejfPhZ5W?=
 =?us-ascii?Q?ynTzvyvS3nwiUKeNhTSwX21JZigGHyyh/6vR+sQHrHEo29GL38/ABjO21srJ?=
 =?us-ascii?Q?zyod2d5ILmLm1CI7qxzq1zmCSgEGL1jfUlbgrdSdIlDO1Qn6xKiXar475e0q?=
 =?us-ascii?Q?luHlPvAulu15qyucFAim1QDreiIygQX+AE+Q9Ek8f6da/gEG3gSSgR0vzoHK?=
 =?us-ascii?Q?EKywRnJG3sP18fYRfnm2tUygPXqLy7J6vmVK60ZE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49de129-5bb2-4bb7-a2a6-08db8ca56d99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 00:23:54.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReXHcJFhI812pCDjT2afAZrcaKRkKrRr85XtzIEtPfHZTzrKl/Dd8y2PkKPUY8EW4JYPcWveeNVV7H4KOl+Bwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Luis Chamberlain <mcgrof@kernel.org> writes:

>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 837e4a50281a..79c46da919b9 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -4,6 +4,7 @@
>>  
>>  #include <linux/mm_types.h>
>>  #include <linux/sched.h>
>> +#include <linux/mmu_notifier.h>
>>  
>>  #include <asm/processor.h>
>>  #include <asm/cpufeature.h>
>> @@ -282,6 +283,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>>  {
>>  	inc_mm_tlb_gen(mm);
>>  	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
>> +	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>>  }
>>  
>>  static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 0b990fb56b66..2d253919b3e8 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -1265,7 +1265,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>>  
>>  	put_flush_tlb_info();
>>  	put_cpu();
>> -	mmu_notifier_arch_invalidate_secondary_tlbs(current->mm, 0, -1UL);
>>  }
>>  
>>  /*
>
> This patch also fixes a regression introduced on linux-next, the same
> crash on arch_tlbbatch_flush() is reproducible with fstests generic/176
> on XFS. This patch fixes that regression [0]. This should also close out
> the syzbot crash too [1]
>
> [0] https://gist.github.com/mcgrof/b37fc8cf7e6e1b3935242681de1a83e2
> [1] https://lore.kernel.org/all/0000000000003afcb4060135a664@google.com/
>
> Tested-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks Luis. The above fix/respin is already in yesterdays linux-next
(next-20230724) so hopefully you are no longer seeing issues.

>   Luis

