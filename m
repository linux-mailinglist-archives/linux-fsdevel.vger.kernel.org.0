Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3073F671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjF0IGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjF0IGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:06:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD8CC;
        Tue, 27 Jun 2023 01:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETeoG8ebn0jb9YHMIgerJ5slQOHDONynfAiJXtdMk9MCE70WvXG3XayPQTiJRlx3bnxVuJDJKlOjPNF1CDhqHdAmT0lGqLo+/7ekyuCr7jBOkVYkiikBdh+jh4qTAdbLVl4wqjN1zlARgDfSo0fE7P8QYkiylRoCYVq6U6ai8/FCoSMC6tNlUFf9G2llTO5zcQkwPfioBc1R4O/opuu7dtdZDlfzDjCEQp7yNDf2VG9e9051slIVWXWiqu9eDq8/Lt7ely+qTGZ9IiZqljDf03Kwh3uP+zaveWhdJuPTHQqBXdITAsko+Kx6ip9TJDfysWVce360C2iYjCsrGZaATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnSbjIee3hIiRWIMo/mmBEbUyKXpeqV7uo5iAfWtavQ=;
 b=YjkM1/MkF4m4yqmKJuBX2g9do7ZyXYxoTE+zm2/8XM+nCDwif9gnxddb3FzwpRUfkCFLJBBlBwehwTl9gfydTT5Smj9mvZ6CvTR/PAnnarYmFr3OxAFj0lvaI5Sk95Ja/C4ZSjCd5zSkJtUUuBuU0W7PEvkxcKraxEVAxqDNhnN2q9237vKkNMfBvvbKWRB3NQ2n/ZC+fFCE3SekIb1dwqRp9/lggYeKPqi96vp8FRoWeb4j3/77UdyJPK4hGspk/rlaOOj6gGh5Y6XuhtMjMQP9oPTzoxOi7QB/v8rL0keCrmpFhKIlL5m1eh9+XCli90BV6Hk9YJcP6tkPj2m9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnSbjIee3hIiRWIMo/mmBEbUyKXpeqV7uo5iAfWtavQ=;
 b=M87L/Ya6FKuoMpLdpsMYLogrHObV6iu2r3GslamZ7GzcZPSmU20fbF9NTU0ObS41uvq3b0N/HTyQ6ZQuX7Y7VHuavAzz3g/IHI2El10EJYNA5jeMDXg2jJsuFeyfw8YT0dbvrVwkLF4Bi071OkGVoG1lNs2kbqWXE8XVdzN7/l7Am7Fk7wfZ1EoMLgh4ELKN1jgzkU2g8JxDp3oMVwJ0D2btJt85nw45yQuPNVxvyMGJsSV7RU9fIhMxSa9SrUJ4+tW0mBQybfdbmm1BStD6tr6V97L3zC5cZ3Jru31HvccOZdAgVmZm9CjI1K+atjv1nvdMJG24EaHRWACF2ZKT8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 08:06:00 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6cea:921f:eb00:c1e7%6]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 08:05:59 +0000
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-8-surenb@google.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 7/8] mm: drop VMA lock before waiting for migration
Date:   Tue, 27 Jun 2023 18:02:10 +1000
In-reply-to: <20230627042321.1763765-8-surenb@google.com>
Message-ID: <875y792uu7.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0017.ausprd01.prod.outlook.com (2603:10c6:1::29)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 36319030-02f2-4ef8-eb9f-08db76e55788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIXvKXzSY+bfZrS2/XiFgiE5S7dOin4jlDMpYPYkSDQbxUtOzCLKhL64+8548Ivz64Nsak/34WGFBtDHP4JtS1AF3w/oUzT4qfLaYLZvXg4x0EqjfnFFhto4FEUJZwaojIkSuzuE+RHRCOz8mPYGSpe5cndCSKvXjXedyCXI2MGHssNjR/DtQgQZ11hfwB1maanyRf8KitVt07R9Mw07cOdm5XakL8QFsHEkT0smCJgtzpqOY0MkxRnoiZuxo0JLzrdd6Ow6PAHZTudfQoApECArabFMR6xEqOcYSj5/BG77ESbH6ruEaTalEKrIV+p5YNKF8rz76jdK/1zP9LFUElC29je5xdWB5AMDiQ6WuhfMGncmL/9tXrID1nz4fc9UbV5eFI2qV7LmsoCsL00iKMHdCZcgCC03gARsmoI8YPdGXEHudm6jn+Qbx05Y/WRz2QNdcvEJMiaV/1iEJmdjPo6MUMWq/65SMsm1JmkwHc+k1Ib/IApngmx81BHb7S0jBQy8FxUfXW3UKZw282WxjXhwHyoeWL1yIul3kx9u4ED+x4/WLGAr66CXFhBtfrWR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7406005)(7416002)(5660300002)(66946007)(66556008)(4326008)(66476007)(6916009)(478600001)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(9686003)(6506007)(6512007)(26005)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9ikwiMcL3Bz2H50byXAgrZp84YG0XNqu9rUrGsxFjH38EZ4Z8unyaqngZYX?=
 =?us-ascii?Q?3cSTkVsr9mwLcLSw8+YOJNwFEfA9gwtxjZbjnaxI/O91RBhL6VptWqTEA4n7?=
 =?us-ascii?Q?VDifJ0zbidFnSBjXg+OMdLHhIaAAjoebOba5fJQVH0O7wEhAbGHjhxEPKRZA?=
 =?us-ascii?Q?xRCxRUtDH9fphHcXNICgQs20MaFEcU5DCI+m4eWkBoJqMnRJJrm4tOl9vnhL?=
 =?us-ascii?Q?XXgY1bmnz0LS83ZOHWOzUe5GHPDoEOFlc62osTT+zkyQR4DPTPrXUPjVLWo1?=
 =?us-ascii?Q?c3dl62T1zA/9lEtpV5tpUg+G+4c1LRGVonlSK5GR5kvu762RsccdZoLBDWjg?=
 =?us-ascii?Q?2OsjStwocLFkYOVpmtcy1zVdyHs9xxYzTR7PfB7ZOA7Ksr0zhIa4qcmKQERS?=
 =?us-ascii?Q?F2Suo5SXpBKKq+fkYly4XyX3h01vk/eLCkNBIv1kTwq4tZ/rw56aXcQWiIfe?=
 =?us-ascii?Q?QodGUjrmL0e1gzvDy53CMNmyDltxzleE/LyPFAvP1OdEjhZckpFrgejE3756?=
 =?us-ascii?Q?Vjt0jIGerf02kWJqbmoXx4jWpRzVoVH8QDkigXBzVQWe1qR/CoTMgnPA/NMM?=
 =?us-ascii?Q?lhznYY4gW0t3ilkvwcpbazIJTonK8iztP4tOXraF//Z35yVquS5Iw3KMRcg9?=
 =?us-ascii?Q?5n7FB3hZwhkc3ofoaKPwC3irsnXwLiVhuTpw/VaFaP8DtLs1OsOErmkK5tVH?=
 =?us-ascii?Q?4LUM0q2F+QiDYrmsG7IjcP+aAoxF6zp5slP+JXTojbO6dT6hiYFi9h0GURpO?=
 =?us-ascii?Q?fUJTFIyHzNR7kCv/Qo5wSQqpG6AMKOJNCX8k/t9bIDASJV4nJbFnQGeLZW74?=
 =?us-ascii?Q?cvLYMYvuGRIwSJYN8+VLNxbcb6cxBiAahmbtoxtr7kWa5E2/9oRcLYHVivdC?=
 =?us-ascii?Q?hijM+465AfmDVlGjtbXBRKgKSYp2rztFJvRggNeeW7/C554yC2FPhrMP2s7n?=
 =?us-ascii?Q?y6feFDi5J7pdOzOYoK38YU0uqwA6jCl6aSTMeZ7VRjOh/PQHDhJyMagrty5n?=
 =?us-ascii?Q?TeNqJi+MgRqVa/DD2xc7XrfRX0Y1EHZ/U4AyWWvhJsA7Z+fR2K8oYLGmpeTR?=
 =?us-ascii?Q?R0kDnkg5GyznYIa4GkV4adItHzA5yFsUeJEH9HGjHMnpmAA3GQrxslLa/ZSx?=
 =?us-ascii?Q?XoHgq8waKmUky4TD+vTyCMIkt2BNTV0qed5eVGdZhAr11Xkc1LAwu31u8hZV?=
 =?us-ascii?Q?muazZqFNib29i2N7NSberKZYs2Rb0pOtoAJlEvC9RxrrGZVxpymkFZc4dhlb?=
 =?us-ascii?Q?1OFUuLlwcw1z5Nvu5IcGKZHvZP6/A0Xwwup4H+Tu18VTsgeXM8N8cqhz32di?=
 =?us-ascii?Q?jXAQBZ1Bn8u5rtoqlovcTYab4vhPFa7VSWOa8tl6LGQWP0HBUaygLphZKI8/?=
 =?us-ascii?Q?aJOPtKk6mHn0emrfVp0nDG0yp9OjeWpoaKymu6cnbooHFS+Z7dIRCEcky9H4?=
 =?us-ascii?Q?KhWnMycPPqjOosE4tRFjFgGAtkbUCoJt15pl3IZFtSV5MPsnxR8RCovXE+iH?=
 =?us-ascii?Q?2gJ5YoEu7Umc5ho8BdvpwYl778/YcHM1SNSJSZ00mqjttmF36GS+O9HOAaal?=
 =?us-ascii?Q?a7I90Eps/PSGANgVcONEOFfjjrupAOdS8FDy77GT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36319030-02f2-4ef8-eb9f-08db76e55788
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:05:59.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akimAM5jy3SsMpAhGPOGqqMovQzSo4PsZe5xeGyZOtFe5gt4c65K6NZX7Yeq3vyzO+Vy3lCwitueXcNAdNLrSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Suren Baghdasaryan <surenb@google.com> writes:

> migration_entry_wait does not need VMA lock, therefore it can be
> dropped before waiting.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/memory.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 5caaa4c66ea2..bdf46fdc58d6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3715,8 +3715,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	if (unlikely(non_swap_entry(entry))) {
>  		if (is_migration_entry(entry)) {
> -			migration_entry_wait(vma->vm_mm, vmf->pmd,
> -					     vmf->address);
> +			/* Save mm in case VMA lock is dropped */
> +			struct mm_struct *mm = vma->vm_mm;
> +
> +			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +				/*
> +				 * No need to hold VMA lock for migration.
> +				 * WARNING: vma can't be used after this!
> +				 */
> +				vma_end_read(vma);
> +				ret |= VM_FAULT_COMPLETED;

Doesn't this need to also set FAULT_FLAG_LOCK_DROPPED to ensure we don't
call vma_end_read() again in __handle_mm_fault()?

> +			}
> +			migration_entry_wait(mm, vmf->pmd, vmf->address);
>  		} else if (is_device_exclusive_entry(entry)) {
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			ret = remove_device_exclusive_entry(vmf);

