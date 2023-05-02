Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637126F44F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEBN0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEBN0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 09:26:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D46C5BB9;
        Tue,  2 May 2023 06:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG0CqiieXkFBwyghzfhCd2Umc83LDbP7xxSRhodOEehdIzs3ZACEgbOdU69/1bzZgi6U98J7XjD87Ubx+7p50m4qgd+5aQHrZhtzHYEl1luhYv+rS6nJAvwnVi2QfNfnLfLAK7UcijSqs+e4x6l4d6VGWF1uKAFzVBHhqORVHWY/6Nh1C1Ymt4Xnc2fmA6psH9CYOzrVG3x9gioW5845nVBJ3t1AW+lR0jhPWC23npXs2Ew9aTOvQm/XLT3eqXGgTjUR5boFGX6ka8dugVkEcC6cMfBB4vyfjxWZdHxwrK/IqQH09v0t4h+Ja+tMvfHhOfoKGYAC7uWo+joqnQTEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63MSliVS6yOkjLJhnNXJ+wvujOHFRKAT0WilNwXBHGM=;
 b=Yc/gbYnDlOQhXFuBO0t7TV9kbS4trOwZM32w27bzoLEv9ivYj3yLVQRcGyfw37LYnWcOd7YuPfhOp5ANWXcCbBH0hc4aorjhT5iL64pZQNngg8GmRG1cWDOKFy4iP8ahDKXIa5v25OzB8S9yl4m1ZGtunU4nNdLQFpmjNIXPksdK3fsBvsPT1iRMYG4H1svpKGuAMTXNnAPIoh/XJj++mhlTK/99L9OJBM/FkKXY+foS6yQUxG7w2Ecs9vR68LYRm1vk7sUtGuBQgVidn3Hi5Anr+WEgYXgbxEgefTUSUwOo389AdXGzKqTXmH/LnhOCB1ML0BBXe7mtGE6qIFepuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63MSliVS6yOkjLJhnNXJ+wvujOHFRKAT0WilNwXBHGM=;
 b=KoxrCr9+TH1nPekvHZuC0mbkVSI05+ism3JVHtI+UzJ1paqxRY1PRecJ93gU2Gql88v6Bdfm5moXxA2sntk0GDmRKIDW++84wriTbWeb6UyUcyeVCEQvSU4lxuWA8cOCPdCKsbyEJeGUv96o3uzgfSir82my8o9XO1gAKduffhNXKHcn+tFo7lbi+7P040/q1e740OWBfQ/mAmywbeabHj600Oh+tIGmVq8pwuBaGn2sOsnq8OLNshHe++u5BLQmxIvfqGLpWvZbanXIE2t49AFwds53L/O+UI5Lu8QWkDXS5oSDXbfV7RzriLfvRQtZU04nM4y7ttXoxYo5MMQ/AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:26:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:26:48 +0000
References: <20230501175025.36233-1-surenb@google.com>
 <20230501175025.36233-2-surenb@google.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/3] mm: drop VMA lock before waiting for migration
Date:   Tue, 02 May 2023 23:21:08 +1000
In-reply-to: <20230501175025.36233-2-surenb@google.com>
Message-ID: <875y9aj23u.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0201f0-4ea0-498d-7b2e-08db4b10e1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lskfGQK5qLg+HZAMLdoLorUSfvs6aWZP5cbzC1wIIZCaQ7sIgMeV7JQvxk6sVaKZTODfIv0Ur23piHzXYoQA7NAHhNvHvmOs9ZpIb9XM3PDbHqrGPsJb3uyvCcZFBTlAD1EwkhAAZxZjezBgq9ccXLJD37cgWpfFi8vXXUDUHZBIUlEXBPUFV1mKOs2OWNs72/sanc+vopKcK4JadSv7olNEaNTQsAfEq8qJbK0ZhUwun97pF79QEEgrNIOBKMdvLsbGF4ilSEMJyFh/NPk4W5jjvcxNOIuN0FheCdnsgmcTTaxJFJxtxSz45JWzUInJdCqjJkQzbMgvw8EFSmsUmhrBUyuoK6XZa0vGHTBxTS9sly4wJokQq4oL9rkAiOzt38agyRDUfCYHcaNJ5zNUFnnoqxjCIcRcoCU0dKhHKZtbWnhczz5Z6saUNLjqQjw98gSqUtGjH81A1UP3rdCBJNmNUHiwoETtK7kZnOftlB4b/FCJHmNx6ahwGiYE0ocHZfX2s0XQ18s6AHYYnWotBR/90fQelvjrusmebR6/oq15PtW6MsGlF5Fv/9TwB+Ky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(478600001)(86362001)(26005)(186003)(8936002)(8676002)(83380400001)(66946007)(66476007)(66556008)(2906002)(5660300002)(6512007)(6506007)(7416002)(2616005)(41300700001)(38100700002)(316002)(6666004)(6486002)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzbVzR9ImuN4dctNRwLKble0YZXqW8u5QXEyUlkm+VATx4IIRWy6cMGxeS7D?=
 =?us-ascii?Q?MX8H6pbhY3pPlLKR0UCyiRF8FFMqnV4yT9QgPR8duKP1tOjqmpB5CPlGxgz8?=
 =?us-ascii?Q?ouOqpzDqB1Ap4aCSrLtdR85QAPcWSTvubP+KEs/+dEqsrWqXlPSeTpWd50Zc?=
 =?us-ascii?Q?J/wa1c6Trz+AZn7mUFc71df1QQIg92XAf40qpTPJZG3OWIk86egWASuMyxPs?=
 =?us-ascii?Q?dpg50yr3TKxSYXvJjbJGGM9hzD+VmXmNQgPgQHkrEs0HD605Ou+VllAv8YUL?=
 =?us-ascii?Q?UOo7M6XGO0YM68mSP1659bEYuqYky9JyKFwyi7PRvcFebnpEyr0KFyW3Zluo?=
 =?us-ascii?Q?pLh1Pvhr1lP+TRybdOY8yWqs8kv6C7v3R32hhYa6Xo4IiJW4VnQGPnHiINKc?=
 =?us-ascii?Q?TZm1Av4Pam/h0/icylnOyuXXFqQ+CpQ/8gg9byjg6wVWMiLFMefEMKyzVwEd?=
 =?us-ascii?Q?u3Y6RfpwCIax+NzOguNy5jMVyqV8NT61dHsWZm2PFelzU3lnDFBPUIHANyRe?=
 =?us-ascii?Q?YGbt1pFJSPgxwJTBxdZFKqEAPcc4u4hOs2sMhDyfCSHk6uPCDXMwebJ3BY2V?=
 =?us-ascii?Q?xtnRLBBuXP4JwzpwAYfShbu/LyDWh3jtV5XGqRzJD1U5dDHRdXxOnkWhSMSQ?=
 =?us-ascii?Q?VyvlnGrksmDqs6NMJJGGn/RskFNvQXmLoCl1AumFnONIREVnHasQjEAGRNLb?=
 =?us-ascii?Q?nPHKbqH9XvlWn9pwWWrRibi/323GuYHtYorKppDphuJk8lyQa3uz0p1BjkiV?=
 =?us-ascii?Q?cW2G1PtFbyTK1n1rxNL/ssZkd/m3b3vPx5EYxguYxN3hKQlsUXCmGwjOWxKk?=
 =?us-ascii?Q?1p4RCkKHuQ8r++HP35gmJTM+V7TB1H0ZOEh0smiYsj/b8nlNnejBIGKhtQ8t?=
 =?us-ascii?Q?jQg1bDDEYcDhcNRCQmI1BkfJWTjTcL4clbLvbIc6fI26ra2MRqKVXwePhwX3?=
 =?us-ascii?Q?LkLG5xUOJ862ex/YdJ5pq3wBi17ukQzxtXVkw0+xxj3roRkp7N0NeqxmHTeW?=
 =?us-ascii?Q?GcLXgONv3NGZgmlfeojxGluEFqDWWEDroEd9xzM/UIDvv7QFfHqvwsru/RZy?=
 =?us-ascii?Q?YJM9m+XLmg/FNnS6glXqcFspCGhZoHbNXUqnwP93Ocp71pLNjcbziYug/1h/?=
 =?us-ascii?Q?ySEUjgo4tmBccI/MhEbNMQjoLf0k82gVrOs6YjBdvNGdZahOk5kzJ/HzvRVJ?=
 =?us-ascii?Q?v6XSs4ZBtGaq9YSiwn4boTLa5/MDFM6xE/l+u2AH3d4I1FbhfOpv3SmMsyPE?=
 =?us-ascii?Q?WGhYjemq2mLe1AgmY3h85k2M8tJrSzlT875v22VGuMyp4/9p9OLVhneOj+1J?=
 =?us-ascii?Q?Gy82IUJ+/gE7szaQLQ9RvmAx4z1hErPlclrvGTVtMhLl54OHyUybc0QytI6e?=
 =?us-ascii?Q?7BeBrB/m0NVuCYVgSLY8YrnjzZyFZJoWC9Q6+UJm+sA2WKRxluGdjsojo02V?=
 =?us-ascii?Q?GwV7pTXStmclWEMi6hRmV39QmHgCxFeCa8d6aiLYNNKvrg3+qJ0382ElyPpk?=
 =?us-ascii?Q?rHTEAdFJ2vZAz/kYzDwedefAzsRw/RrCRq4BkGO13Ez7fGcmO1W2gA2HRqus?=
 =?us-ascii?Q?ePRBShK6Ctb8XPS01fCEcy44jgYMwjesh/6uOo5e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0201f0-4ea0-498d-7b2e-08db4b10e1bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:26:48.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf9YmyjYlNaH0T2aWYGttni8nhsBCw+1K2HiUmI1vh4aDJTX4bANM7mUdjXhB9O90PSm0jgITEQLI/alpn0kqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Suren Baghdasaryan <surenb@google.com> writes:

[...]

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..b3b57c6da0e1 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1030,6 +1030,7 @@ typedef __bitwise unsigned int vm_fault_t;
>   *				fsync() to complete (for synchronous page faults
>   *				in DAX)
>   * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
> + * @VM_FAULT_VMA_UNLOCKED:	VMA lock was released

A note here saying vmf->vma should no longer be accessed would be nice.

>   * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
>   *
>   */
> @@ -1047,6 +1048,7 @@ enum vm_fault_reason {
>  	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
>  	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
>  	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> +	VM_FAULT_VMA_UNLOCKED   = (__force vm_fault_t)0x008000,
>  	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
>  };
>  
> @@ -1070,7 +1072,9 @@ enum vm_fault_reason {
>  	{ VM_FAULT_RETRY,               "RETRY" },	\
>  	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
>  	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
> -	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> +	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
> +	{ VM_FAULT_COMPLETED,           "COMPLETED" },	\

VM_FAULT_COMPLETED isn't used in this patch, guessing that's snuck in
from one of the other patches in the series?

> +	{ VM_FAULT_VMA_UNLOCKED,        "VMA_UNLOCKED" }
>  
>  struct vm_special_mapping {
>  	const char *name;	/* The name, e.g. "[vdso]". */
> diff --git a/mm/memory.c b/mm/memory.c
> index 41f45819a923..8222acf74fd3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3714,8 +3714,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	if (unlikely(non_swap_entry(entry))) {
>  		if (is_migration_entry(entry)) {
> -			migration_entry_wait(vma->vm_mm, vmf->pmd,
> -					     vmf->address);
> +			/* Save mm in case VMA lock is dropped */
> +			struct mm_struct *mm = vma->vm_mm;
> +
> +			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +				/* No need to hold VMA lock for migration */
> +				vma_end_read(vma);
> +				/* CAUTION! VMA can't be used after this */
> +				ret |= VM_FAULT_VMA_UNLOCKED;
> +			}
> +			migration_entry_wait(mm, vmf->pmd, vmf->address);
>  		} else if (is_device_exclusive_entry(entry)) {
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			ret = remove_device_exclusive_entry(vmf);

