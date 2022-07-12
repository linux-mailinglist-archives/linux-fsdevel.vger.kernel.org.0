Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B6572224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiGLSDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiGLSCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:02:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06218D1391;
        Tue, 12 Jul 2022 11:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPJFoNiMrg9Z1riFwMu8JSeLFCyYX+FCTGdUNVgQt+r9c7yxB1d5FeZry5Hb/oIy4d2fGLeI9tzeSPJgIMCxtUA8kg1U2BDkUAyx0tJ6/FxEZcKKShEuhpN6i98ZvRBEa2u07nSEJ/l4S62CgjcK1fTL3bhsfAPC3s2lkThEanBCZOuo8vftJ4u1Kk8Z/ZED9aGAfrQjEVNzjsLtVD6sneE+AVE+tD+yZekVCgChtDigUM4c5KbMWsHfeDCKq+MYRdF1YLxbVFa6tkyv3X7sY0RsnshR5rNQ7pbVK9CQVlo2KSxx3lyloS8WU0FUT3ozCTcKa1Q5K75Uq013ZJ1DeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EYITfmExrsDJY0Q03NUvIoqQ3PNQ1QnVy4kPiPRk+8=;
 b=lakwHjqIzqcmxWD0QhPlC0j77yZw7r1ZUUthHRHBBMxkuwhMDxvpw00y3bo5TrzmoDIZmH0p8URCz95EZWFvcyUBG1ZuVblI75LLJNb6ypSQ011vtEhBbxkc7RAtBLm7t68CyRmbdyYsKIIUDM+KT2fG5lM5Uan/P8l50YwLIwz9teb0Dvkc7ZhRRPGIcND9knvL3NUcYXD24eUxgdcPj3Pl6D8gX3ze7dgVt6KdoPLjT2dsCn9R5VMhBTKViodkU8sazAEQ2oR1kPLIZvDmOtSjwxuKgYcXIrZilrkh52+C6N5t6LarOFUJ8NVxL0/7Xj1HoOYj+9FWaqwhrP+kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EYITfmExrsDJY0Q03NUvIoqQ3PNQ1QnVy4kPiPRk+8=;
 b=zJ1upMRn7rmoEBGqczQYA48Tr7l1I/J9z/G/xfBfdGOA0QI4GCflgFd8VDDb0QkXj1ymRXi/7ECllnrCVedMkcR/iLmGSyIvy3XIO6p1TLM7yczWhLWSnKNVOUPSjvmTaMCdwLoO5uppYa1S+GFXACMHVKr7VwX0yBoZFsi7yOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by SA0PR12MB4558.namprd12.prod.outlook.com
 (2603:10b6:806:72::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 18:02:49 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Tue, 12 Jul
 2022 18:02:47 +0000
Message-ID: <c4112b84-9359-d4c8-1852-0057c074607c@amd.com>
Date:   Tue, 12 Jul 2022 20:02:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b87450-6a68-4d54-614f-08da6430ba65
X-MS-TrafficTypeDiagnostic: SA0PR12MB4558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4mZtZCv6YEwoz2STSxRkmhKZpE1yOh3OXwuZr+x2SAuXlJ3mVPe6PmcCkpeoixshnAMW9h5ALT5Tp92ByfM08mKOgeir5abJaJLur9CPxiaVpLj5aMOMDkeX4s17RRbSFzHW6hlSpvGoujxGCfUGZPu0EK4nKWlHZ6C8qm62+8o4//Ld5bB3hVYbLffY+8gpUhS1yNvQ1R7bKxVsW5ds+DLS9yDFIhi2QEIOQJiQaJ/Y1Obeu7ypivKZNcPcBP4QlHTQmEUr/Z5hdAq4jAXplqE7fzY84eNAMiGWndfTnKKytISmIesHXKPt3jWpvxP18r64O9DBaLs6IVr1qfCYq4elG/4KdpMT24MjtFtnZF3lBPZDfVgkhu3aeYW2jFlJaIhB/9mEsZQW7ev4qldkrVBN2RLv/zh7tNTnUjf8z//lZE6usVE5LX1J9hizdvQuIQte4RoSMKWJdx10dlc2YATPIguoZHcVvTiQbNsCoSvx7+q6/DIoCsV2Xjtw9IVg/tg0JwY8DmKayBE+LLB91uMYR+9ZxCIhp6+d+E4ZreU+bs0CBIqFjtj+RNS3xbnlO1HT0ghB3OWOVI1oaBQK0WvQiFNlxoc7MiIhfQQ8A2IUcbf61xF7nNQQqdc2n5tH7p2BtsCe2dEJnQjoodScSpjlwrYFzbRDv2utcFyMCwIplbaNB43OEck3QUaZSup6+msj2L3ChWy25wQCVuYoiKi6yaFjwk3V36IwfyT5vkKLm1iC+zmXWWS6DME3sSCDD3ZcPtQluIVa1RCvPfrmnj9zAO9N2UkvB/Ouy4myX4mVTVsfM0+OLDQnE2gj2als73LwrY4ufUee65/V+vfyEhQ2bSUcwEM04QLjgiVy+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(66476007)(66946007)(66556008)(8676002)(316002)(4326008)(31686004)(54906003)(7416002)(8936002)(7406005)(6486002)(478600001)(2906002)(5660300002)(36756003)(53546011)(6666004)(86362001)(26005)(41300700001)(6512007)(6506007)(2616005)(186003)(38100700002)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpGVmIzRlpLMUFFL21SVno1dlJoTHhkRytEZWpZY3I5eW1RK2kvSnpxVzhB?=
 =?utf-8?B?VUhpajF0T1l1U0xUeHVDOUNWdmlnS3pvYU5UeERrVzBTdTFjYzd2VXJGdWJ1?=
 =?utf-8?B?b2VzZTNTTFFsNkhodHMxYnhUK2tOS3lBYS9SQlYrUkFwK2Z0ZExqTUdCWDNa?=
 =?utf-8?B?aVBSRW5aY3BPNHltWmdDaVdNd05wMkwwZ2VzMWt0SkhiMytrdXlpSnAyWUNJ?=
 =?utf-8?B?VTNsbGpaaWVlYXhwT1hyZkRubnp1UnphWW9qRThsV3hYd21sWmIwbzJFMy9O?=
 =?utf-8?B?VTR5c0Y3dDBWSGhzbnQxeGVTNStQL0YxdldrVW9RR3VCeXFlU3BUSExXcmpM?=
 =?utf-8?B?RnlBRUtmSGZtR1pYS1MzaE9OT2VyeHpiT0dTZm9mZE5tVVVJUUZCeVkvMWNL?=
 =?utf-8?B?S2YrRnI2M0NldGxkNTZ1TVJhQVFEVHpQK3NzNm01OFREVklDQmUzbTloM0hj?=
 =?utf-8?B?dGFIVENpYllLMDdGc0JxNnJuSVllSDllUS9ES3BYM2l0RkVqOFplWmo5MkhZ?=
 =?utf-8?B?RnAwbDNPQ0ZZbUtDYUJodFRWVzZmbS8wUlZZcFUraUhSelBCNlVEUFBRQllW?=
 =?utf-8?B?eUhHUExQOGFYcTA5eUZPbnJZWWJ2WGVwQlNUcXVSZmpJMG1VdVpiRGZTeCtP?=
 =?utf-8?B?bmJyU0xlYWFDdWxFZXFzVUpOeDZKZUNjRlQwREg3Z0s0T3gyYkVNU09QTHNX?=
 =?utf-8?B?MG9vSmtHSWJBN0ZDd1R6VEhzamVpMThXVmwzQW1CN1RMdXA2WUdNTFBhQUxS?=
 =?utf-8?B?cjlCN3BCSnVOc01vTzJSYnZ3ZXZSdWFxUTYrbldneVU0ZlYzcmFNOUZVRG95?=
 =?utf-8?B?SklQeXp2bTY4ZzNreURGbDg4NVF2SW1jZzZBbTNucVpVQUVLemtodnFTeHJF?=
 =?utf-8?B?dzhDZmdtOUlGTDNLKyswZDRMY1g2WmIwZ1c0QWx1dHlRb0NZYmU2anlTaU5D?=
 =?utf-8?B?aXpMYStyVjNiQ3F3eWtGd3h4TEZxTkhwQlRMbDBRQnZMVHVxMkdTTVMwM1Iw?=
 =?utf-8?B?eGk1QWVWKzBYWmhnZUJGWHNkTkN3bjJhdTRCdHc4KzVLdzB2M0x4TzZtUkJO?=
 =?utf-8?B?aE04b0dja0c0QjFmdURCeEJyTUx3bkRIRDFkMXJaRmhvSU1rY0NsWkUrVW5L?=
 =?utf-8?B?ZHVaMXM4dFFKTTI1blJuWHZ6aVViRFBjS0hReWlhZFBna2RrM3F0bWJ2SnVp?=
 =?utf-8?B?TUZaMmtlK0JGa0JxaXF5SnJJTmJtdTNqNHFoMHRtRjByWGltOHIvSHJlS3di?=
 =?utf-8?B?VDNlK2I4MlBCK0x6TThqc29UQ3pqUEJzcnNUYXdqa0pRUWZBcklQcmZPK0xp?=
 =?utf-8?B?MUs5YmJPTkIzbkcxWjNHTDV3K1YrdmNPdTVvZlZRSmdseDJ1QWNkUmVSOVlT?=
 =?utf-8?B?SkZ5RWRFMEo0WUVUdnBpQis4c0JUL0tVUkV2MEhzL1NrclljVUxsWFprUDJz?=
 =?utf-8?B?SldxR1J5c25hSWMydFNERFBGOS8yanA5M0xVSlVnMGhhS2pkUVJaNzhsZFh4?=
 =?utf-8?B?VVhLYTYvdnJjNGdxa0RUcUxSeVFZQVFZcXVaUlRWTWExaFBLSE1adzU4S09B?=
 =?utf-8?B?aGo3UlZ4UmdVNmdKSHdiRU5zcVN6Tmw5YmVmUUI3OEIrckF1bUJuRXNMeXUw?=
 =?utf-8?B?YU1LZWxqYkg0QW9seFI0WUkwVlNRTDF1NTVDblNJczhSWmpENlRhWHRtcmQ0?=
 =?utf-8?B?Vzc2VkNHNWwzbDJvZnJmdEsvTXRuSG1ucUxtKyt2UHd0NG91ak1xS0hLNVFX?=
 =?utf-8?B?Zy8wczZTTW1TaTJpRUNhd0Z5UE93bllWQzFreWN1NVVkTmpFbVBXWkRHWXZZ?=
 =?utf-8?B?ZHhYTGNkcEE0MmtQZ3NXU1M3eDRiUHZtcnJQTmNOKzdFMkNaTFBtOFNtdGt3?=
 =?utf-8?B?U055OTB3bWd4bXh1cGl5Vk9YNTJYa05ZeDkyQ2x4M2ZWbDZIbm1lVXVzcjho?=
 =?utf-8?B?SjZURXNDRkFnVDRyZG01b2w1YjFhaHBXQ2doTU9NdUF5RElGZEdMVzJxN2JI?=
 =?utf-8?B?SEh2blhmSUZrclFTSHp5UHVwTE1NVUJEd1hrQkF3UkdVdWJBakdreHI4MVlN?=
 =?utf-8?B?RGROWjZrMm1BM1ZQVkUyT2p3aTNMVWhKQU80a3NZSGkyVDZvdDI0VVBGWmVM?=
 =?utf-8?Q?Z7KowFhhZVJtp6MoQcNIUAF0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b87450-6a68-4d54-614f-08da6430ba65
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 18:02:47.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKdhfVUp6/Cn3AynQG59cwe2S2EFRgdglzmZjdUD9zmxdDac9Y38rofbAQUKyelWiGFgdGERvfagG8TMLoIpmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/6/2022 10:20 AM, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Implement shmem as a memfile_notifier backing store. Essentially it
> interacts with the memfile_notifier feature flags for userspace
> access/page migration/page reclaiming and implements the necessary
> memfile_backing_store callbacks.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>   include/linux/shmem_fs.h |   2 +
>   mm/shmem.c               | 109 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a68f982f22d1..6031c0b08d26 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -9,6 +9,7 @@
>   #include <linux/percpu_counter.h>
>   #include <linux/xattr.h>
>   #include <linux/fs_parser.h>
> +#include <linux/memfile_notifier.h>
>   
>   /* inode in-kernel data */
>   
> @@ -25,6 +26,7 @@ struct shmem_inode_info {
>   	struct simple_xattrs	xattrs;		/* list of xattrs */
>   	atomic_t		stop_eviction;	/* hold when working on inode */
>   	struct timespec64	i_crtime;	/* file creation time */
> +	struct memfile_node	memfile_node;	/* memfile node */
>   	struct inode		vfs_inode;
>   };
>   
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6c8aef15a17d..627e315c3b4d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -905,6 +905,17 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>   	return page ? page_folio(page) : NULL;
>   }
>   
> +static void notify_invalidate(struct inode *inode, struct folio *folio,
> +				   pgoff_t start, pgoff_t end)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	start = max(start, folio->index);
> +	end = min(end, folio->index + folio_nr_pages(folio));
> +
> +	memfile_notifier_invalidate(&info->memfile_node, start, end);
> +}
> +
>   /*
>    * Remove range of pages and swap entries from page cache, and free them.
>    * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
> @@ -948,6 +959,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>   			}
>   			index += folio_nr_pages(folio) - 1;
>   
> +			notify_invalidate(inode, folio, start, end);
> +
>   			if (!unfalloc || !folio_test_uptodate(folio))
>   				truncate_inode_folio(mapping, folio);
>   			folio_unlock(folio);
> @@ -1021,6 +1034,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>   					index--;
>   					break;
>   				}
> +
> +				notify_invalidate(inode, folio, start, end);
> +
>   				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
>   						folio);
>   				truncate_inode_folio(mapping, folio);
> @@ -1092,6 +1108,13 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
>   		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>   			return -EPERM;
>   
> +		if (info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE) {
> +			if (oldsize)
> +				return -EPERM;
> +			if (!PAGE_ALIGNED(newsize))
> +				return -EINVAL;
> +		}
> +
>   		if (newsize != oldsize) {
>   			error = shmem_reacct_size(SHMEM_I(inode)->flags,
>   					oldsize, newsize);
> @@ -1336,6 +1359,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   		goto redirty;
>   	if (!total_swap_pages)
>   		goto redirty;
> +	if (info->memfile_node.flags & MEMFILE_F_UNRECLAIMABLE)
> +		goto redirty;
>   
>   	/*
>   	 * Our capabilities prevent regular writeback or sync from ever calling
> @@ -2271,6 +2296,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>   	if (ret)
>   		return ret;
>   
> +	if (info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE)
> +		return -EPERM;
> +
>   	/* arm64 - allow memory tagging on RAM-based files */
>   	vma->vm_flags |= VM_MTE_ALLOWED;
>   
> @@ -2306,6 +2334,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>   		info->i_crtime = inode->i_mtime;
>   		INIT_LIST_HEAD(&info->shrinklist);
>   		INIT_LIST_HEAD(&info->swaplist);
> +		memfile_node_init(&info->memfile_node);
>   		simple_xattrs_init(&info->xattrs);
>   		cache_no_acl(inode);
>   		mapping_set_large_folios(inode->i_mapping);
> @@ -2477,6 +2506,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>   		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
>   			return -EPERM;
>   	}
> +	if (unlikely(info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE))
> +		return -EPERM;
>   
>   	if (unlikely(info->seals & F_SEAL_AUTO_ALLOCATE))
>   		sgp = SGP_NOALLOC;
> @@ -2556,6 +2587,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		end_index = i_size >> PAGE_SHIFT;
>   		if (index > end_index)
>   			break;
> +
> +		if (SHMEM_I(inode)->memfile_node.flags &
> +				MEMFILE_F_USER_INACCESSIBLE) {
> +			error = -EPERM;
> +			break;
> +		}
> +
>   		if (index == end_index) {
>   			nr = i_size & ~PAGE_MASK;
>   			if (nr <= offset)
> @@ -2697,6 +2735,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>   			goto out;
>   		}
>   
> +		if ((info->memfile_node.flags & MEMFILE_F_USER_INACCESSIBLE) &&
> +		    (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))) {
> +			error = -EINVAL;
> +			goto out;
> +		}
> +
>   		shmem_falloc.waitq = &shmem_falloc_waitq;
>   		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
>   		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
> @@ -3806,6 +3850,20 @@ static int shmem_error_remove_page(struct address_space *mapping,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_MIGRATION
> +static int shmem_migrate_page(struct address_space *mapping,
> +			      struct page *newpage, struct page *page,
> +			      enum migrate_mode mode)
> +{
> +	struct inode *inode = mapping->host;
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	if (info->memfile_node.flags & MEMFILE_F_UNMOVABLE)
> +		return -EOPNOTSUPP;
> +	return migrate_page(mapping, newpage, page, mode);

Wondering how well page migrate would work for private pages
on shmem memfd based backend?

> +}
> +#endif
> +
>   const struct address_space_operations shmem_aops = {
>   	.writepage	= shmem_writepage,
>   	.dirty_folio	= noop_dirty_folio,
> @@ -3814,7 +3872,7 @@ const struct address_space_operations shmem_aops = {
>   	.write_end	= shmem_write_end,
>   #endif
>   #ifdef CONFIG_MIGRATION
> -	.migratepage	= migrate_page,
> +	.migratepage	= shmem_migrate_page,
>   #endif
>   	.error_remove_page = shmem_error_remove_page,
>   };
> @@ -3931,6 +3989,51 @@ static struct file_system_type shmem_fs_type = {
>   	.fs_flags	= FS_USERNS_MOUNT,
>   };
>   
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static struct memfile_node *shmem_lookup_memfile_node(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +
> +	if (!shmem_mapping(inode->i_mapping))
> +		return NULL;
> +
> +	return  &SHMEM_I(inode)->memfile_node;
> +}
> +
> +
> +static int shmem_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +			 int *order)
> +{
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(file_inode(file), offset, &page, SGP_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	unlock_page(page);
> +	*pfn = page_to_pfn_t(page);
> +	*order = thp_order(compound_head(page));
> +	return 0;
> +}
> +
> +static void shmem_put_pfn(pfn_t pfn)
> +{
> +	struct page *page = pfn_t_to_page(pfn);
> +
> +	if (!page)
> +		return;
> +
> +	put_page(page);
> +}
> +
> +static struct memfile_backing_store shmem_backing_store = {
> +	.lookup_memfile_node = shmem_lookup_memfile_node,
> +	.get_pfn = shmem_get_pfn,
> +	.put_pfn = shmem_put_pfn,
> +};
> +#endif /* CONFIG_MEMFILE_NOTIFIER */
> +
>   void __init shmem_init(void)
>   {
>   	int error;
> @@ -3956,6 +4059,10 @@ void __init shmem_init(void)
>   	else
>   		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
>   #endif
> +
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +	memfile_register_backing_store(&shmem_backing_store);
> +#endif
>   	return;
>   
>   out1:

