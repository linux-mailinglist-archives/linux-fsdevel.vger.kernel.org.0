Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57C5EBA91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 08:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiI0GZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiI0GZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:25:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB64A81C;
        Mon, 26 Sep 2022 23:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifnYfLiJnTIPRDMtE6scYyJlESwB+4q/SlbQblb3Rkh3xdjdV+mZKwTWIsKyLejzA/rumQIOCN/EOA1I378MzK3o1f2s1fOv32xTXp+TSrn8tdFBw5ZnldJ8rFJ6fFDpNH+VkxFKtWpjh6MboljlR42K3r6sxsJuuHz1kUzZbwPvqSJGvggETj6Rhx7XxX0adT58HSTk7AaVaV1zYeuzMzMO+jNYictKR1LkHwApFveaInX9b873mZCFDUVBYDZud4VrwVQ+K1gAwTTFgoD6/dbmLfv7OXXVQHmaegGU6kXT1w7SyFYQ2LfwV+z6WZVFIHbtPB9FtH8kT3QMbxVQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHCSCp94X1MYU5l8dZqzmRqkTkbDCbRdA8J2zba3xUQ=;
 b=ISFyxynilANft9PEAum8WgD+1nfsLCOlCaPapfNfIZ32e4k950uVkXu52fd9b/Oi9bjTdzLVtGA/0Mtpco6OwOg8TYBzdfqtuAsbBKTmbQd31jfGXLOZ94ssktZzVVqv2cU9ylf37PWzqipA2ZTRjSd3HMVU/oIpfZ6hUpSOcSJJH/ct88rHlpuK6awXgEUFeoF7eLXbKf6U/F6RIUvjKnEC6kKlX0er9fYDSwaPG8j2bl70XRuyD5gyXwgH7NUsSkffydgzvw4eD7g+B1x4zyUDDWP8UPwY3ix0oQFszGWcMTK4AyCwfJe9zpAbrIAqXBlEnOVDA8hzwHdR9DTNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHCSCp94X1MYU5l8dZqzmRqkTkbDCbRdA8J2zba3xUQ=;
 b=JKtMlaVHuPIcR+RoeK4gXmWN5G3Xznn8kMu5wubeF5o6OTPy08KIXH8zaIvNR2LJB7L5gePc8+D6bGqgg9biFOFiUJbEsLkKBxnjHaFIkr2fRay/IhsGOAOLOHqvqg7bi0LzUPeb1Ogl7tlBbBkogpdYnQq/qe40KlU6EYrSNPfA2dqZsOK2Bkam1aVdOX7waaA33sCxgGn+C1hl0ZOi0r9jMlOSe2V7Y07J1j/38ez4cNM/eq6YME0EuucQpufU/eP54WF186yTMSzxNXb6S1F1w9MjJaKFS93NAbdz7gs37BzV7NVWFX0NGjt0XQTooNWLgke7a2zFP0OzvpTW+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:25:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:25:37 +0000
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329937873.2786261.10966526479509910698.stgit@dwillia2-xfh.jf.intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 12/18] devdax: Move address_space helpers to the DAX
 core
Date:   Tue, 27 Sep 2022 16:20:37 +1000
In-reply-to: <166329937873.2786261.10966526479509910698.stgit@dwillia2-xfh.jf.intel.com>
Message-ID: <87y1u5jpus.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0147.ausprd01.prod.outlook.com
 (2603:10c6:0:30::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH2PR12MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 066f3433-b4e1-47d2-db49-08daa05117a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPoqRfLgRI8mjDU+DDzHcGPLIBw47c/vT/hLXTb1Aia8USqRUsXMKQxEnDuRCuq93xMyU0jTgbZwCm6JY+dwpgL31YZflMC/PedPwfBYXtiMyw2+fRJdUW8XGwyX9UUc+6/ItFsTjtcwTBs78qkhtQwTBiN+s4WLaaGmFQHK7Jm3zGZULADPQVDgUhT4VS0Nz8E4GB65/SmY88x8zscBN+pJ6RBf4gKOpmrTcWq5pl8g74iR5r1LI/LxrIFIh3NBQsOaYEU2xd0N6K/wAOXR7+aKGgvUYzfupmA5khCus5Ny4/SWjROGQ5r8w2fhjLGPfqKn8Kns1kdmz/K0N2O32izdxaO0NImiQIMR+uNYBqjzXagtRylZgx2ZUl4a1GBfBINZJ0on6cFBSu6ObE5337BvlM2BqId4cvVSxcjNalXTsfowiLv91FKOlo//Zaw4Bsrr7glq8cE1An6QE73CKDINEcF2EidyCweE7qUGphbvKC+J/ke44OrBS00HrOBQGOo9yJ/zVCtjiEg0CpQY+ihfDFGzg5+XW1HgyUL9WmZJKPW5Hh0ftH5Tspl35pa/TgnabwaAJAGynFOhTgrJ8NULowcN4VIRQDvDZ1UMsBhP0RFu7oALbZbJ1hnUxPaRDKTeSwah7Q3Y5tlhwYqGeoOLyrPSQa08F4QDK6ngG69j9v8cIDmYeh+GMxFM8Gn7mT5PeeKk5s2dlwC0sTaLqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(38100700002)(86362001)(478600001)(30864003)(2906002)(5660300002)(7416002)(6486002)(66556008)(4326008)(66476007)(66946007)(316002)(54906003)(6916009)(8936002)(186003)(8676002)(83380400001)(6512007)(6506007)(9686003)(26005)(41300700001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytKOVkOwxF5Qi2W2eufNV8fIhgSq1+pXclLS/6/ucy6FVtHC/jBiafZzW0Qr?=
 =?us-ascii?Q?RnFo0rIuwvMDK1Frp3HcbYRoYkXux6GW56ymCNFnahPVnHpLEeEDUTd+hWWl?=
 =?us-ascii?Q?Z/0+JnnDMFARWlUWGyPJaZDbJmIGWEV2TmiqZdgFA4O6A5TCieN5UdXxerjg?=
 =?us-ascii?Q?6CWJcTk32ibossbbsttB+RO/bvX2M8e3u1/io4iFdCNloCZOPlvHXQXnJRLr?=
 =?us-ascii?Q?uJHlUU2qFEPu0ak5ELlaoZc9NYvswJ2owx4ZK8SIxqDyQd8PSqY5EnC6K7oO?=
 =?us-ascii?Q?UjQNPqmoJ/HnsayfS/RB0zcc4KNFakXoQbvDkSpMOLwXbh8FfOAx5JD19RAj?=
 =?us-ascii?Q?xHB8CFRPPhMdqE8yS6CvqiKWzeM7IjEEGjLRHALa8tm6GmoJqK1bZJUGk3aN?=
 =?us-ascii?Q?QuaFHCNujaZdIJB0TvbJsCb25dy99Mck650y6k4wjL6Yx0WEevChxW5tju4t?=
 =?us-ascii?Q?RY7CipR0hZTYQoYLfgoGFKrixE4A5FMu6Tv52xGP8nxrK7HvNtAyI+vJXO5J?=
 =?us-ascii?Q?ypGwhI1BS+SPV/xsMm/XkHOfVBBy8Xp4YwWsP6saBnadYdDQHrnoGC/JhELN?=
 =?us-ascii?Q?Kj5e7nflNhF20CstPDB6rrXEdciVWclPJIVCklsFm+QmAIQThNQeLjgnGb9q?=
 =?us-ascii?Q?sn4I8pww2QMRgz8FUS5ZZiaNnKPtL+Q6CpC/8BeW5/lFfQSw4k5WNuRoFm98?=
 =?us-ascii?Q?/XmuILs+r1wO0RsyRZApNoScFYWnPzl62uY6GwNsAQv0n+8ibLJFPr9rNICM?=
 =?us-ascii?Q?EPUInX9xHZjlPelvxZQfjq8dbAZkLlCC58Moqc+ew4epi5X/ONx6zDP2231i?=
 =?us-ascii?Q?sjgrqweaaQvI/kHtEQPfADjlLf/YdfLZTyuntqzguSkXyqWF5G86sClsHNXd?=
 =?us-ascii?Q?NlJqtzZ1CGXAIaA7c9gl82eQlFt2GzNFLdf5dnr7kGBbSC+H8IGP3ZygQj9O?=
 =?us-ascii?Q?+fvkZll/XFlLzTPsU/zR8+gHud+GUEzMwhZzL+DQYxY4HoUtvaC8lggeCFhU?=
 =?us-ascii?Q?KSFxzpymfUZ+cS+9ptnelmjFEO8soiMqs6HoKxpOpfSCeqN7RIYXInqPMFSS?=
 =?us-ascii?Q?Uq/L7JQIWibmbQEBoiZ20L6F6rm7v02lkQtJHN/Xmaq2AnZYQ9kaBlxs8j+o?=
 =?us-ascii?Q?gjkhv17PtJYz9+VgZS+LRQdFGuV37AnsCRZ6vitRo3wtikLAPBeK/Wf69tti?=
 =?us-ascii?Q?0zsGTdHB5Awh+ZbZG/AJimjrrP/0WOxnC5DhPB9jZMcqfsjWcIn0ix5YxEkv?=
 =?us-ascii?Q?sJyweA4cBnxvv8KcwExA6aJTHUdPVTM137YS4i2D2fWAJ4Z9NJ63BITj83az?=
 =?us-ascii?Q?h0NVTRs3g60SB54065iiLagkDYGk87IUdEEQUI+mm0GwgaozZG6pbOz+wYFg?=
 =?us-ascii?Q?qL1GpUoBKAi6ar0XYnUi2slYf439BtXXwjP7zStYyY/EYRy0BW1VKt0iCiAU?=
 =?us-ascii?Q?d9XfwJS4s/ZYqZxkvukC11xM/9VrZDAzQrMw5VbUnFmVLVCA+t2V7IYnHj4t?=
 =?us-ascii?Q?BWESgRJOuM1osHRUSX1sciXkT/bHbhquvUbtGkXzyfJ1M+oS6WKIZhhfcz0d?=
 =?us-ascii?Q?+Tfbanw0i+MCqduFX2ooA9Y0lz8/uzmygxFwDr0i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066f3433-b4e1-47d2-db49-08daa05117a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:25:37.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoqZq0hu+1NjowdZglmwhYZhk6ZWrWJJCzYFsli4NexwgvoMfBIa0Rkj3pfAzy25YBZ0EEhn9RAZZmdLAWatRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dan Williams <dan.j.williams@intel.com> writes:

[...]

> +/**
> + * dax_zap_mappings_range - find first pinned page in @mapping
> + * @mapping: address space to scan for a page with ref count > 1
> + * @start: Starting offset. Page containing 'start' is included.
> + * @end: End offset. Page containing 'end' is included. If 'end' is LLONG_MAX,
> + *       pages from 'start' till the end of file are included.
> + *
> + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> + * 'onlined' to the page allocator so they are considered idle when
> + * page->count == 1. A filesystem uses this interface to determine if

Minor nit-pick I noticed while reading this but shouldn't that be
"page->count == 0" now?

> + * any page in the mapping is busy, i.e. for DMA, or other
> + * get_user_pages() usages.
> + *
> + * It is expected that the filesystem is holding locks to block the
> + * establishment of new mappings in this address_space. I.e. it expects
> + * to be able to run unmap_mapping_range() and subsequently not race
> + * mapping_mapped() becoming true.
> + */
> +struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
> +				    loff_t end)
> +{
> +	void *entry;
> +	unsigned int scanned = 0;
> +	struct page *page = NULL;
> +	pgoff_t start_idx = start >> PAGE_SHIFT;
> +	pgoff_t end_idx;
> +	XA_STATE(xas, &mapping->i_pages, start_idx);
> +
> +	/*
> +	 * In the 'limited' case get_user_pages() for dax is disabled.
> +	 */
> +	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> +		return NULL;
> +
> +	if (!dax_mapping(mapping))
> +		return NULL;
> +
> +	/* If end == LLONG_MAX, all pages from start to till end of file */
> +	if (end == LLONG_MAX)
> +		end_idx = ULONG_MAX;
> +	else
> +		end_idx = end >> PAGE_SHIFT;
> +	/*
> +	 * If we race get_user_pages_fast() here either we'll see the
> +	 * elevated page count in the iteration and wait, or
> +	 * get_user_pages_fast() will see that the page it took a reference
> +	 * against is no longer mapped in the page tables and bail to the
> +	 * get_user_pages() slow path.  The slow path is protected by
> +	 * pte_lock() and pmd_lock(). New references are not taken without
> +	 * holding those locks, and unmap_mapping_pages() will not zero the
> +	 * pte or pmd without holding the respective lock, so we are
> +	 * guaranteed to either see new references or prevent new
> +	 * references from being established.
> +	 */
> +	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
> +
> +	xas_lock_irq(&xas);
> +	xas_for_each(&xas, entry, end_idx) {
> +		if (WARN_ON_ONCE(!xa_is_value(entry)))
> +			continue;
> +		if (unlikely(dax_is_locked(entry)))
> +			entry = get_unlocked_entry(&xas, 0);
> +		if (entry)
> +			page = dax_zap_pages(&xas, entry);
> +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> +		if (page)
> +			break;
> +		if (++scanned % XA_CHECK_SCHED)
> +			continue;
> +
> +		xas_pause(&xas);
> +		xas_unlock_irq(&xas);
> +		cond_resched();
> +		xas_lock_irq(&xas);
> +	}
> +	xas_unlock_irq(&xas);
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(dax_zap_mappings_range);
> +
> +struct page *dax_zap_mappings(struct address_space *mapping)
> +{
> +	return dax_zap_mappings_range(mapping, 0, LLONG_MAX);
> +}
> +EXPORT_SYMBOL_GPL(dax_zap_mappings);
> +
> +static int __dax_invalidate_entry(struct address_space *mapping, pgoff_t index,
> +				  bool trunc)
> +{
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	int ret = 0;
> +	void *entry;
> +
> +	xas_lock_irq(&xas);
> +	entry = get_unlocked_entry(&xas, 0);
> +	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> +		goto out;
> +	if (!trunc && (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
> +		       xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
> +		goto out;
> +	dax_disassociate_entry(entry, mapping, trunc);
> +	xas_store(&xas, NULL);
> +	mapping->nrpages -= 1UL << dax_entry_order(entry);
> +	ret = 1;
> +out:
> +	put_unlocked_entry(&xas, entry, WAKE_ALL);
> +	xas_unlock_irq(&xas);
> +	return ret;
> +}
> +
> +int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
> +				      pgoff_t index)
> +{
> +	return __dax_invalidate_entry(mapping, index, false);
> +}
> +
> +/*
> + * Delete DAX entry at @index from @mapping.  Wait for it
> + * to be unlocked before deleting it.
> + */
> +int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
> +{
> +	int ret = __dax_invalidate_entry(mapping, index, true);
> +
> +	/*
> +	 * This gets called from truncate / punch_hole path. As such, the caller
> +	 * must hold locks protecting against concurrent modifications of the
> +	 * page cache (usually fs-private i_mmap_sem for writing). Since the
> +	 * caller has seen a DAX entry for this index, we better find it
> +	 * at that index as well...
> +	 */
> +	WARN_ON_ONCE(!ret);
> +	return ret;
> +}
> +
> +/*
> + * By this point dax_grab_mapping_entry() has ensured that we have a locked entry
> + * of the appropriate size so we don't have to worry about downgrading PMDs to
> + * PTEs.  If we happen to be trying to insert a PTE and there is a PMD
> + * already in the tree, we will skip the insertion and just dirty the PMD as
> + * appropriate.
> + */
> +vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +			    void **pentry, pfn_t pfn, unsigned long flags)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = flags & DAX_DIRTY;
> +	bool cow = flags & DAX_COW;
> +	void *entry = *pentry;
> +
> +	if (dirty)
> +		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> +
> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
> +		unsigned long index = xas->xa_index;
> +		/* we are replacing a zero page with block mapping */
> +		if (dax_is_pmd_entry(entry))
> +			unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
> +					    PG_PMD_NR, false);
> +		else /* pte entry */
> +			unmap_mapping_pages(mapping, index, 1, false);
> +	}
> +
> +	xas_reset(xas);
> +	xas_lock_irq(xas);
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +		void *old;
> +
> +		dax_disassociate_entry(entry, mapping, false);
> +		dax_associate_entry(new_entry, mapping, vmf, flags);
> +		/*
> +		 * Only swap our new entry into the page cache if the current
> +		 * entry is a zero page or an empty entry.  If a normal PTE or
> +		 * PMD entry is already in the cache, we leave it alone.  This
> +		 * means that if we are trying to insert a PTE and the
> +		 * existing entry is a PMD, we will just leave the PMD in the
> +		 * tree and dirty it if necessary.
> +		 */
> +		old = dax_lock_entry(xas, new_entry);
> +		WARN_ON_ONCE(old !=
> +			     xa_mk_value(xa_to_value(entry) | DAX_LOCKED));
> +		entry = new_entry;
> +	} else {
> +		xas_load(xas); /* Walk the xa_state */
> +	}
> +
> +	if (dirty)
> +		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
> +
> +	if (cow)
> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
> +	xas_unlock_irq(xas);
> +	*pentry = entry;
> +	return 0;
> +}
> +
> +int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> +		      struct address_space *mapping, void *entry)
> +{
> +	unsigned long pfn, index, count, end;
> +	long ret = 0;
> +	struct vm_area_struct *vma;
> +
> +	/*
> +	 * A page got tagged dirty in DAX mapping? Something is seriously
> +	 * wrong.
> +	 */
> +	if (WARN_ON(!xa_is_value(entry)))
> +		return -EIO;
> +
> +	if (unlikely(dax_is_locked(entry))) {
> +		void *old_entry = entry;
> +
> +		entry = get_unlocked_entry(xas, 0);
> +
> +		/* Entry got punched out / reallocated? */
> +		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> +			goto put_unlocked;
> +		/*
> +		 * Entry got reallocated elsewhere? No need to writeback.
> +		 * We have to compare pfns as we must not bail out due to
> +		 * difference in lockbit or entry type.
> +		 */
> +		if (dax_to_pfn(old_entry) != dax_to_pfn(entry))
> +			goto put_unlocked;
> +		if (WARN_ON_ONCE(dax_is_empty_entry(entry) ||
> +					dax_is_zero_entry(entry))) {
> +			ret = -EIO;
> +			goto put_unlocked;
> +		}
> +
> +		/* Another fsync thread may have already done this entry */
> +		if (!xas_get_mark(xas, PAGECACHE_TAG_TOWRITE))
> +			goto put_unlocked;
> +	}
> +
> +	/* Lock the entry to serialize with page faults */
> +	dax_lock_entry(xas, entry);
> +
> +	/*
> +	 * We can clear the tag now but we have to be careful so that concurrent
> +	 * dax_writeback_one() calls for the same index cannot finish before we
> +	 * actually flush the caches. This is achieved as the calls will look
> +	 * at the entry only under the i_pages lock and once they do that
> +	 * they will see the entry locked and wait for it to unlock.
> +	 */
> +	xas_clear_mark(xas, PAGECACHE_TAG_TOWRITE);
> +	xas_unlock_irq(xas);
> +
> +	/*
> +	 * If dax_writeback_mapping_range() was given a wbc->range_start
> +	 * in the middle of a PMD, the 'index' we use needs to be
> +	 * aligned to the start of the PMD.
> +	 * This allows us to flush for PMD_SIZE and not have to worry about
> +	 * partial PMD writebacks.
> +	 */
> +	pfn = dax_to_pfn(entry);
> +	count = 1UL << dax_entry_order(entry);
> +	index = xas->xa_index & ~(count - 1);
> +	end = index + count - 1;
> +
> +	/* Walk all mappings of a given index of a file and writeprotect them */
> +	i_mmap_lock_read(mapping);
> +	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, end) {
> +		pfn_mkclean_range(pfn, count, index, vma);
> +		cond_resched();
> +	}
> +	i_mmap_unlock_read(mapping);
> +
> +	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
> +	/*
> +	 * After we have flushed the cache, we can clear the dirty tag. There
> +	 * cannot be new dirty data in the pfn after the flush has completed as
> +	 * the pfn mappings are writeprotected and fault waits for mapping
> +	 * entry lock.
> +	 */
> +	xas_reset(xas);
> +	xas_lock_irq(xas);
> +	xas_store(xas, entry);
> +	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
> +	dax_wake_entry(xas, entry, WAKE_NEXT);
> +
> +	trace_dax_writeback_one(mapping->host, index, count);
> +	return ret;
> +
> + put_unlocked:
> +	put_unlocked_entry(xas, entry, WAKE_NEXT);
> +	return ret;
> +}
> +
> +/*
> + * dax_insert_pfn_mkwrite - insert PTE or PMD entry into page tables
> + * @vmf: The description of the fault
> + * @pfn: PFN to insert
> + * @order: Order of entry to insert.
> + *
> + * This function inserts a writeable PTE or PMD entry into the page tables
> + * for an mmaped DAX file.  It also marks the page cache entry as dirty.
> + */
> +vm_fault_t dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn,
> +				  unsigned int order)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
> +	void *entry;
> +	vm_fault_t ret;
> +
> +	xas_lock_irq(&xas);
> +	entry = get_unlocked_entry(&xas, order);
> +	/* Did we race with someone splitting entry or so? */
> +	if (!entry || dax_is_conflict(entry) ||
> +	    (order == 0 && !dax_is_pte_entry(entry))) {
> +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> +		xas_unlock_irq(&xas);
> +		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
> +						      VM_FAULT_NOPAGE);
> +		return VM_FAULT_NOPAGE;
> +	}
> +	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
> +	dax_lock_entry(&xas, entry);
> +	xas_unlock_irq(&xas);
> +	if (order == 0)
> +		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> +#ifdef CONFIG_FS_DAX_PMD
> +	else if (order == PMD_ORDER)
> +		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
> +#endif
> +	else
> +		ret = VM_FAULT_FALLBACK;
> +	dax_unlock_entry(&xas, entry);
> +	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
> +	return ret;
> +}
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 4909ad945a49..0976857ec7f2 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -564,6 +564,8 @@ static int __init dax_core_init(void)
>  	if (rc)
>  		return rc;
>
> +	dax_mapping_init();
> +
>  	rc = alloc_chrdev_region(&dax_devt, 0, MINORMASK+1, "dax");
>  	if (rc)
>  		goto err_chrdev;
> @@ -590,5 +592,5 @@ static void __exit dax_core_exit(void)
>
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
> -subsys_initcall(dax_core_init);
> +fs_initcall(dax_core_init);
>  module_exit(dax_core_exit);
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index 5a29046e3319..3bb17448d1c8 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -78,6 +78,7 @@ config NVDIMM_DAX
>  	bool "NVDIMM DAX: Raw access to persistent memory"
>  	default LIBNVDIMM
>  	depends on NVDIMM_PFN
> +	depends on DAX
>  	help
>  	  Support raw device dax access to a persistent memory
>  	  namespace.  For environments that want to hard partition
> diff --git a/fs/dax.c b/fs/dax.c
> index ee2568c8b135..79e49e718d33 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -27,847 +27,8 @@
>  #include <linux/rmap.h>
>  #include <asm/pgalloc.h>
>
> -#define CREATE_TRACE_POINTS
>  #include <trace/events/fs_dax.h>
>
> -static inline unsigned int pe_order(enum page_entry_size pe_size)
> -{
> -	if (pe_size == PE_SIZE_PTE)
> -		return PAGE_SHIFT - PAGE_SHIFT;
> -	if (pe_size == PE_SIZE_PMD)
> -		return PMD_SHIFT - PAGE_SHIFT;
> -	if (pe_size == PE_SIZE_PUD)
> -		return PUD_SHIFT - PAGE_SHIFT;
> -	return ~0;
> -}
> -
> -/* We choose 4096 entries - same as per-zone page wait tables */
> -#define DAX_WAIT_TABLE_BITS 12
> -#define DAX_WAIT_TABLE_ENTRIES (1 << DAX_WAIT_TABLE_BITS)
> -
> -/* The 'colour' (ie low bits) within a PMD of a page offset.  */
> -#define PG_PMD_COLOUR	((PMD_SIZE >> PAGE_SHIFT) - 1)
> -#define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
> -
> -/* The order of a PMD entry */
> -#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> -
> -static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
> -
> -static int __init init_dax_wait_table(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < DAX_WAIT_TABLE_ENTRIES; i++)
> -		init_waitqueue_head(wait_table + i);
> -	return 0;
> -}
> -fs_initcall(init_dax_wait_table);
> -
> -/*
> - * DAX pagecache entries use XArray value entries so they can't be mistaken
> - * for pages.  We use one bit for locking, one bit for the entry size (PMD)
> - * and two more to tell us if the entry is a zero page or an empty entry that
> - * is just used for locking.  In total four special bits.
> - *
> - * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
> - * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
> - * block allocation.
> - */
> -#define DAX_SHIFT	(5)
> -#define DAX_MASK	((1UL << DAX_SHIFT) - 1)
> -#define DAX_LOCKED	(1UL << 0)
> -#define DAX_PMD		(1UL << 1)
> -#define DAX_ZERO_PAGE	(1UL << 2)
> -#define DAX_EMPTY	(1UL << 3)
> -#define DAX_ZAP		(1UL << 4)
> -
> -/*
> - * These flags are not conveyed in Xarray value entries, they are just
> - * modifiers to dax_insert_entry().
> - */
> -#define DAX_DIRTY (1UL << (DAX_SHIFT + 0))
> -#define DAX_COW   (1UL << (DAX_SHIFT + 1))
> -
> -static unsigned long dax_to_pfn(void *entry)
> -{
> -	return xa_to_value(entry) >> DAX_SHIFT;
> -}
> -
> -static void *dax_make_entry(pfn_t pfn, unsigned long flags)
> -{
> -	return xa_mk_value((flags & DAX_MASK) |
> -			   (pfn_t_to_pfn(pfn) << DAX_SHIFT));
> -}
> -
> -static bool dax_is_locked(void *entry)
> -{
> -	return xa_to_value(entry) & DAX_LOCKED;
> -}
> -
> -static bool dax_is_zapped(void *entry)
> -{
> -	return xa_to_value(entry) & DAX_ZAP;
> -}
> -
> -static unsigned int dax_entry_order(void *entry)
> -{
> -	if (xa_to_value(entry) & DAX_PMD)
> -		return PMD_ORDER;
> -	return 0;
> -}
> -
> -static unsigned long dax_is_pmd_entry(void *entry)
> -{
> -	return xa_to_value(entry) & DAX_PMD;
> -}
> -
> -static bool dax_is_pte_entry(void *entry)
> -{
> -	return !(xa_to_value(entry) & DAX_PMD);
> -}
> -
> -static int dax_is_zero_entry(void *entry)
> -{
> -	return xa_to_value(entry) & DAX_ZERO_PAGE;
> -}
> -
> -static int dax_is_empty_entry(void *entry)
> -{
> -	return xa_to_value(entry) & DAX_EMPTY;
> -}
> -
> -/*
> - * true if the entry that was found is of a smaller order than the entry
> - * we were looking for
> - */
> -static bool dax_is_conflict(void *entry)
> -{
> -	return entry == XA_RETRY_ENTRY;
> -}
> -
> -/*
> - * DAX page cache entry locking
> - */
> -struct exceptional_entry_key {
> -	struct xarray *xa;
> -	pgoff_t entry_start;
> -};
> -
> -struct wait_exceptional_entry_queue {
> -	wait_queue_entry_t wait;
> -	struct exceptional_entry_key key;
> -};
> -
> -/**
> - * enum dax_wake_mode: waitqueue wakeup behaviour
> - * @WAKE_ALL: wake all waiters in the waitqueue
> - * @WAKE_NEXT: wake only the first waiter in the waitqueue
> - */
> -enum dax_wake_mode {
> -	WAKE_ALL,
> -	WAKE_NEXT,
> -};
> -
> -static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
> -		void *entry, struct exceptional_entry_key *key)
> -{
> -	unsigned long hash;
> -	unsigned long index = xas->xa_index;
> -
> -	/*
> -	 * If 'entry' is a PMD, align the 'index' that we use for the wait
> -	 * queue to the start of that PMD.  This ensures that all offsets in
> -	 * the range covered by the PMD map to the same bit lock.
> -	 */
> -	if (dax_is_pmd_entry(entry))
> -		index &= ~PG_PMD_COLOUR;
> -	key->xa = xas->xa;
> -	key->entry_start = index;
> -
> -	hash = hash_long((unsigned long)xas->xa ^ index, DAX_WAIT_TABLE_BITS);
> -	return wait_table + hash;
> -}
> -
> -static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
> -		unsigned int mode, int sync, void *keyp)
> -{
> -	struct exceptional_entry_key *key = keyp;
> -	struct wait_exceptional_entry_queue *ewait =
> -		container_of(wait, struct wait_exceptional_entry_queue, wait);
> -
> -	if (key->xa != ewait->key.xa ||
> -	    key->entry_start != ewait->key.entry_start)
> -		return 0;
> -	return autoremove_wake_function(wait, mode, sync, NULL);
> -}
> -
> -/*
> - * @entry may no longer be the entry at the index in the mapping.
> - * The important information it's conveying is whether the entry at
> - * this index used to be a PMD entry.
> - */
> -static void dax_wake_entry(struct xa_state *xas, void *entry,
> -			   enum dax_wake_mode mode)
> -{
> -	struct exceptional_entry_key key;
> -	wait_queue_head_t *wq;
> -
> -	wq = dax_entry_waitqueue(xas, entry, &key);
> -
> -	/*
> -	 * Checking for locked entry and prepare_to_wait_exclusive() happens
> -	 * under the i_pages lock, ditto for entry handling in our callers.
> -	 * So at this point all tasks that could have seen our entry locked
> -	 * must be in the waitqueue and the following check will see them.
> -	 */
> -	if (waitqueue_active(wq))
> -		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
> -}
> -
> -/*
> - * Look up entry in page cache, wait for it to become unlocked if it
> - * is a DAX entry and return it.  The caller must subsequently call
> - * put_unlocked_entry() if it did not lock the entry or dax_unlock_entry()
> - * if it did.  The entry returned may have a larger order than @order.
> - * If @order is larger than the order of the entry found in i_pages, this
> - * function returns a dax_is_conflict entry.
> - *
> - * Must be called with the i_pages lock held.
> - */
> -static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
> -{
> -	void *entry;
> -	struct wait_exceptional_entry_queue ewait;
> -	wait_queue_head_t *wq;
> -
> -	init_wait(&ewait.wait);
> -	ewait.wait.func = wake_exceptional_entry_func;
> -
> -	for (;;) {
> -		entry = xas_find_conflict(xas);
> -		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> -			return entry;
> -		if (dax_entry_order(entry) < order)
> -			return XA_RETRY_ENTRY;
> -		if (!dax_is_locked(entry))
> -			return entry;
> -
> -		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
> -		prepare_to_wait_exclusive(wq, &ewait.wait,
> -					  TASK_UNINTERRUPTIBLE);
> -		xas_unlock_irq(xas);
> -		xas_reset(xas);
> -		schedule();
> -		finish_wait(wq, &ewait.wait);
> -		xas_lock_irq(xas);
> -	}
> -}
> -
> -/*
> - * The only thing keeping the address space around is the i_pages lock
> - * (it's cycled in clear_inode() after removing the entries from i_pages)
> - * After we call xas_unlock_irq(), we cannot touch xas->xa.
> - */
> -static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> -{
> -	struct wait_exceptional_entry_queue ewait;
> -	wait_queue_head_t *wq;
> -
> -	init_wait(&ewait.wait);
> -	ewait.wait.func = wake_exceptional_entry_func;
> -
> -	wq = dax_entry_waitqueue(xas, entry, &ewait.key);
> -	/*
> -	 * Unlike get_unlocked_entry() there is no guarantee that this
> -	 * path ever successfully retrieves an unlocked entry before an
> -	 * inode dies. Perform a non-exclusive wait in case this path
> -	 * never successfully performs its own wake up.
> -	 */
> -	prepare_to_wait(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
> -	xas_unlock_irq(xas);
> -	schedule();
> -	finish_wait(wq, &ewait.wait);
> -}
> -
> -static void put_unlocked_entry(struct xa_state *xas, void *entry,
> -			       enum dax_wake_mode mode)
> -{
> -	if (entry && !dax_is_conflict(entry))
> -		dax_wake_entry(xas, entry, mode);
> -}
> -
> -/*
> - * We used the xa_state to get the entry, but then we locked the entry and
> - * dropped the xa_lock, so we know the xa_state is stale and must be reset
> - * before use.
> - */
> -static void dax_unlock_entry(struct xa_state *xas, void *entry)
> -{
> -	void *old;
> -
> -	BUG_ON(dax_is_locked(entry));
> -	xas_reset(xas);
> -	xas_lock_irq(xas);
> -	old = xas_store(xas, entry);
> -	xas_unlock_irq(xas);
> -	BUG_ON(!dax_is_locked(old));
> -	dax_wake_entry(xas, entry, WAKE_NEXT);
> -}
> -
> -/*
> - * Return: The entry stored at this location before it was locked.
> - */
> -static void *dax_lock_entry(struct xa_state *xas, void *entry)
> -{
> -	unsigned long v = xa_to_value(entry);
> -	return xas_store(xas, xa_mk_value(v | DAX_LOCKED));
> -}
> -
> -static unsigned long dax_entry_size(void *entry)
> -{
> -	if (dax_is_zero_entry(entry))
> -		return 0;
> -	else if (dax_is_empty_entry(entry))
> -		return 0;
> -	else if (dax_is_pmd_entry(entry))
> -		return PMD_SIZE;
> -	else
> -		return PAGE_SIZE;
> -}
> -
> -static unsigned long dax_end_pfn(void *entry)
> -{
> -	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
> -}
> -
> -/*
> - * Iterate through all mapped pfns represented by an entry, i.e. skip
> - * 'empty' and 'zero' entries.
> - */
> -#define for_each_mapped_pfn(entry, pfn) \
> -	for (pfn = dax_to_pfn(entry); \
> -			pfn < dax_end_pfn(entry); pfn++)
> -
> -static inline bool dax_mapping_is_cow(struct address_space *mapping)
> -{
> -	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
> -}
> -
> -/*
> - * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
> - */
> -static inline void dax_mapping_set_cow(struct page *page)
> -{
> -	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
> -		/*
> -		 * Reset the index if the page was already mapped
> -		 * regularly before.
> -		 */
> -		if (page->mapping)
> -			page->index = 1;
> -		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
> -	}
> -	page->index++;
> -}
> -
> -/*
> - * When it is called in dax_insert_entry(), the cow flag will indicate that
> - * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * FS_DAX_MAPPING_COW, and use page->index as refcount.
> - */
> -static vm_fault_t dax_associate_entry(void *entry,
> -				      struct address_space *mapping,
> -				      struct vm_fault *vmf, unsigned long flags)
> -{
> -	unsigned long size = dax_entry_size(entry), pfn, index;
> -	struct dev_pagemap *pgmap;
> -	int i = 0;
> -
> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> -		return 0;
> -
> -	if (!size)
> -		return 0;
> -
> -	if (!(flags & DAX_COW)) {
> -		pfn = dax_to_pfn(entry);
> -		pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
> -		if (!pgmap)
> -			return VM_FAULT_SIGBUS;
> -	}
> -
> -	index = linear_page_index(vmf->vma, ALIGN(vmf->address, size));
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		if (flags & DAX_COW) {
> -			dax_mapping_set_cow(page);
> -		} else {
> -			WARN_ON_ONCE(page->mapping);
> -			page->mapping = mapping;
> -			page->index = index + i++;
> -			page_ref_inc(page);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void dax_disassociate_entry(void *entry, struct address_space *mapping,
> -		bool trunc)
> -{
> -	unsigned long size = dax_entry_size(entry), pfn;
> -	struct page *page;
> -
> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> -		return;
> -
> -	if (!size)
> -		return;
> -
> -	for_each_mapped_pfn(entry, pfn) {
> -		page = pfn_to_page(pfn);
> -		if (dax_mapping_is_cow(page->mapping)) {
> -			/* keep the CoW flag if this page is still shared */
> -			if (page->index-- > 0)
> -				continue;
> -		} else {
> -			WARN_ON_ONCE(trunc && !dax_is_zapped(entry));
> -			WARN_ON_ONCE(trunc && !dax_page_idle(page));
> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		}
> -		page->mapping = NULL;
> -		page->index = 0;
> -	}
> -
> -	if (trunc && !dax_mapping_is_cow(page->mapping)) {
> -		page = pfn_to_page(dax_to_pfn(entry));
> -		put_dev_pagemap_many(page->pgmap, PHYS_PFN(size));
> -	}
> -}
> -
> -/*
> - * dax_lock_page - Lock the DAX entry corresponding to a page
> - * @page: The page whose entry we want to lock
> - *
> - * Context: Process context.
> - * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
> - * not be locked.
> - */
> -dax_entry_t dax_lock_page(struct page *page)
> -{
> -	XA_STATE(xas, NULL, 0);
> -	void *entry;
> -
> -	/* Ensure page->mapping isn't freed while we look at it */
> -	rcu_read_lock();
> -	for (;;) {
> -		struct address_space *mapping = READ_ONCE(page->mapping);
> -
> -		entry = NULL;
> -		if (!mapping || !dax_mapping(mapping))
> -			break;
> -
> -		/*
> -		 * In the device-dax case there's no need to lock, a
> -		 * struct dev_pagemap pin is sufficient to keep the
> -		 * inode alive, and we assume we have dev_pagemap pin
> -		 * otherwise we would not have a valid pfn_to_page()
> -		 * translation.
> -		 */
> -		entry = (void *)~0UL;
> -		if (S_ISCHR(mapping->host->i_mode))
> -			break;
> -
> -		xas.xa = &mapping->i_pages;
> -		xas_lock_irq(&xas);
> -		if (mapping != page->mapping) {
> -			xas_unlock_irq(&xas);
> -			continue;
> -		}
> -		xas_set(&xas, page->index);
> -		entry = xas_load(&xas);
> -		if (dax_is_locked(entry)) {
> -			rcu_read_unlock();
> -			wait_entry_unlocked(&xas, entry);
> -			rcu_read_lock();
> -			continue;
> -		}
> -		dax_lock_entry(&xas, entry);
> -		xas_unlock_irq(&xas);
> -		break;
> -	}
> -	rcu_read_unlock();
> -	return (dax_entry_t)entry;
> -}
> -
> -void dax_unlock_page(struct page *page, dax_entry_t cookie)
> -{
> -	struct address_space *mapping = page->mapping;
> -	XA_STATE(xas, &mapping->i_pages, page->index);
> -
> -	if (S_ISCHR(mapping->host->i_mode))
> -		return;
> -
> -	dax_unlock_entry(&xas, (void *)cookie);
> -}
> -
> -/*
> - * dax_lock_mapping_entry - Lock the DAX entry corresponding to a mapping
> - * @mapping: the file's mapping whose entry we want to lock
> - * @index: the offset within this file
> - * @page: output the dax page corresponding to this dax entry
> - *
> - * Return: A cookie to pass to dax_unlock_mapping_entry() or 0 if the entry
> - * could not be locked.
> - */
> -dax_entry_t dax_lock_mapping_entry(struct address_space *mapping, pgoff_t index,
> -		struct page **page)
> -{
> -	XA_STATE(xas, NULL, 0);
> -	void *entry;
> -
> -	rcu_read_lock();
> -	for (;;) {
> -		entry = NULL;
> -		if (!dax_mapping(mapping))
> -			break;
> -
> -		xas.xa = &mapping->i_pages;
> -		xas_lock_irq(&xas);
> -		xas_set(&xas, index);
> -		entry = xas_load(&xas);
> -		if (dax_is_locked(entry)) {
> -			rcu_read_unlock();
> -			wait_entry_unlocked(&xas, entry);
> -			rcu_read_lock();
> -			continue;
> -		}
> -		if (!entry ||
> -		    dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> -			/*
> -			 * Because we are looking for entry from file's mapping
> -			 * and index, so the entry may not be inserted for now,
> -			 * or even a zero/empty entry.  We don't think this is
> -			 * an error case.  So, return a special value and do
> -			 * not output @page.
> -			 */
> -			entry = (void *)~0UL;
> -		} else {
> -			*page = pfn_to_page(dax_to_pfn(entry));
> -			dax_lock_entry(&xas, entry);
> -		}
> -		xas_unlock_irq(&xas);
> -		break;
> -	}
> -	rcu_read_unlock();
> -	return (dax_entry_t)entry;
> -}
> -
> -void dax_unlock_mapping_entry(struct address_space *mapping, pgoff_t index,
> -		dax_entry_t cookie)
> -{
> -	XA_STATE(xas, &mapping->i_pages, index);
> -
> -	if (cookie == ~0UL)
> -		return;
> -
> -	dax_unlock_entry(&xas, (void *)cookie);
> -}
> -
> -/*
> - * Find page cache entry at given index. If it is a DAX entry, return it
> - * with the entry locked. If the page cache doesn't contain an entry at
> - * that index, add a locked empty entry.
> - *
> - * When requesting an entry with size DAX_PMD, grab_mapping_entry() will
> - * either return that locked entry or will return VM_FAULT_FALLBACK.
> - * This will happen if there are any PTE entries within the PMD range
> - * that we are requesting.
> - *
> - * We always favor PTE entries over PMD entries. There isn't a flow where we
> - * evict PTE entries in order to 'upgrade' them to a PMD entry.  A PMD
> - * insertion will fail if it finds any PTE entries already in the tree, and a
> - * PTE insertion will cause an existing PMD entry to be unmapped and
> - * downgraded to PTE entries.  This happens for both PMD zero pages as
> - * well as PMD empty entries.
> - *
> - * The exception to this downgrade path is for PMD entries that have
> - * real storage backing them.  We will leave these real PMD entries in
> - * the tree, and PTE writes will simply dirty the entire PMD entry.
> - *
> - * Note: Unlike filemap_fault() we don't honor FAULT_FLAG_RETRY flags. For
> - * persistent memory the benefit is doubtful. We can add that later if we can
> - * show it helps.
> - *
> - * On error, this function does not return an ERR_PTR.  Instead it returns
> - * a VM_FAULT code, encoded as an xarray internal entry.  The ERR_PTR values
> - * overlap with xarray value entries.
> - */
> -static void *grab_mapping_entry(struct xa_state *xas,
> -		struct address_space *mapping, unsigned int order)
> -{
> -	unsigned long index = xas->xa_index;
> -	bool pmd_downgrade;	/* splitting PMD entry into PTE entries? */
> -	void *entry;
> -
> -retry:
> -	pmd_downgrade = false;
> -	xas_lock_irq(xas);
> -	entry = get_unlocked_entry(xas, order);
> -
> -	if (entry) {
> -		if (dax_is_conflict(entry))
> -			goto fallback;
> -		if (!xa_is_value(entry)) {
> -			xas_set_err(xas, -EIO);
> -			goto out_unlock;
> -		}
> -
> -		if (order == 0) {
> -			if (dax_is_pmd_entry(entry) &&
> -			    (dax_is_zero_entry(entry) ||
> -			     dax_is_empty_entry(entry))) {
> -				pmd_downgrade = true;
> -			}
> -		}
> -	}
> -
> -	if (pmd_downgrade) {
> -		/*
> -		 * Make sure 'entry' remains valid while we drop
> -		 * the i_pages lock.
> -		 */
> -		dax_lock_entry(xas, entry);
> -
> -		/*
> -		 * Besides huge zero pages the only other thing that gets
> -		 * downgraded are empty entries which don't need to be
> -		 * unmapped.
> -		 */
> -		if (dax_is_zero_entry(entry)) {
> -			xas_unlock_irq(xas);
> -			unmap_mapping_pages(mapping,
> -					xas->xa_index & ~PG_PMD_COLOUR,
> -					PG_PMD_NR, false);
> -			xas_reset(xas);
> -			xas_lock_irq(xas);
> -		}
> -
> -		dax_disassociate_entry(entry, mapping, false);
> -		xas_store(xas, NULL);	/* undo the PMD join */
> -		dax_wake_entry(xas, entry, WAKE_ALL);
> -		mapping->nrpages -= PG_PMD_NR;
> -		entry = NULL;
> -		xas_set(xas, index);
> -	}
> -
> -	if (entry) {
> -		dax_lock_entry(xas, entry);
> -	} else {
> -		unsigned long flags = DAX_EMPTY;
> -
> -		if (order > 0)
> -			flags |= DAX_PMD;
> -		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
> -		dax_lock_entry(xas, entry);
> -		if (xas_error(xas))
> -			goto out_unlock;
> -		mapping->nrpages += 1UL << order;
> -	}
> -
> -out_unlock:
> -	xas_unlock_irq(xas);
> -	if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
> -		goto retry;
> -	if (xas->xa_node == XA_ERROR(-ENOMEM))
> -		return xa_mk_internal(VM_FAULT_OOM);
> -	if (xas_error(xas))
> -		return xa_mk_internal(VM_FAULT_SIGBUS);
> -	return entry;
> -fallback:
> -	xas_unlock_irq(xas);
> -	return xa_mk_internal(VM_FAULT_FALLBACK);
> -}
> -
> -static void *dax_zap_entry(struct xa_state *xas, void *entry)
> -{
> -	unsigned long v = xa_to_value(entry);
> -
> -	return xas_store(xas, xa_mk_value(v | DAX_ZAP));
> -}
> -
> -/**
> - * Return NULL if the entry is zapped and all pages in the entry are
> - * idle, otherwise return the non-idle page in the entry
> - */
> -static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
> -{
> -	struct page *ret = NULL;
> -	unsigned long pfn;
> -	bool zap;
> -
> -	if (!dax_entry_size(entry))
> -		return NULL;
> -
> -	zap = !dax_is_zapped(entry);
> -
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		if (zap)
> -			page_ref_dec(page);
> -
> -		if (!ret && !dax_page_idle(page))
> -			ret = page;
> -	}
> -
> -	if (zap)
> -		dax_zap_entry(xas, entry);
> -
> -	return ret;
> -}
> -
> -/**
> - * dax_zap_mappings_range - find first pinned page in @mapping
> - * @mapping: address space to scan for a page with ref count > 1
> - * @start: Starting offset. Page containing 'start' is included.
> - * @end: End offset. Page containing 'end' is included. If 'end' is LLONG_MAX,
> - *       pages from 'start' till the end of file are included.
> - *
> - * DAX requires ZONE_DEVICE mapped pages. These pages are never
> - * 'onlined' to the page allocator so they are considered idle when
> - * page->count == 1. A filesystem uses this interface to determine if
> - * any page in the mapping is busy, i.e. for DMA, or other
> - * get_user_pages() usages.
> - *
> - * It is expected that the filesystem is holding locks to block the
> - * establishment of new mappings in this address_space. I.e. it expects
> - * to be able to run unmap_mapping_range() and subsequently not race
> - * mapping_mapped() becoming true.
> - */
> -struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
> -				    loff_t end)
> -{
> -	void *entry;
> -	unsigned int scanned = 0;
> -	struct page *page = NULL;
> -	pgoff_t start_idx = start >> PAGE_SHIFT;
> -	pgoff_t end_idx;
> -	XA_STATE(xas, &mapping->i_pages, start_idx);
> -
> -	/*
> -	 * In the 'limited' case get_user_pages() for dax is disabled.
> -	 */
> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> -		return NULL;
> -
> -	if (!dax_mapping(mapping))
> -		return NULL;
> -
> -	/* If end == LLONG_MAX, all pages from start to till end of file */
> -	if (end == LLONG_MAX)
> -		end_idx = ULONG_MAX;
> -	else
> -		end_idx = end >> PAGE_SHIFT;
> -	/*
> -	 * If we race get_user_pages_fast() here either we'll see the
> -	 * elevated page count in the iteration and wait, or
> -	 * get_user_pages_fast() will see that the page it took a reference
> -	 * against is no longer mapped in the page tables and bail to the
> -	 * get_user_pages() slow path.  The slow path is protected by
> -	 * pte_lock() and pmd_lock(). New references are not taken without
> -	 * holding those locks, and unmap_mapping_pages() will not zero the
> -	 * pte or pmd without holding the respective lock, so we are
> -	 * guaranteed to either see new references or prevent new
> -	 * references from being established.
> -	 */
> -	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
> -
> -	xas_lock_irq(&xas);
> -	xas_for_each(&xas, entry, end_idx) {
> -		if (WARN_ON_ONCE(!xa_is_value(entry)))
> -			continue;
> -		if (unlikely(dax_is_locked(entry)))
> -			entry = get_unlocked_entry(&xas, 0);
> -		if (entry)
> -			page = dax_zap_pages(&xas, entry);
> -		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> -		if (page)
> -			break;
> -		if (++scanned % XA_CHECK_SCHED)
> -			continue;
> -
> -		xas_pause(&xas);
> -		xas_unlock_irq(&xas);
> -		cond_resched();
> -		xas_lock_irq(&xas);
> -	}
> -	xas_unlock_irq(&xas);
> -	return page;
> -}
> -EXPORT_SYMBOL_GPL(dax_zap_mappings_range);
> -
> -struct page *dax_zap_mappings(struct address_space *mapping)
> -{
> -	return dax_zap_mappings_range(mapping, 0, LLONG_MAX);
> -}
> -EXPORT_SYMBOL_GPL(dax_zap_mappings);
> -
> -static int __dax_invalidate_entry(struct address_space *mapping,
> -					  pgoff_t index, bool trunc)
> -{
> -	XA_STATE(xas, &mapping->i_pages, index);
> -	int ret = 0;
> -	void *entry;
> -
> -	xas_lock_irq(&xas);
> -	entry = get_unlocked_entry(&xas, 0);
> -	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> -		goto out;
> -	if (!trunc &&
> -	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
> -	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
> -		goto out;
> -	dax_disassociate_entry(entry, mapping, trunc);
> -	xas_store(&xas, NULL);
> -	mapping->nrpages -= 1UL << dax_entry_order(entry);
> -	ret = 1;
> -out:
> -	put_unlocked_entry(&xas, entry, WAKE_ALL);
> -	xas_unlock_irq(&xas);
> -	return ret;
> -}
> -
> -/*
> - * Delete DAX entry at @index from @mapping.  Wait for it
> - * to be unlocked before deleting it.
> - */
> -int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
> -{
> -	int ret = __dax_invalidate_entry(mapping, index, true);
> -
> -	/*
> -	 * This gets called from truncate / punch_hole path. As such, the caller
> -	 * must hold locks protecting against concurrent modifications of the
> -	 * page cache (usually fs-private i_mmap_sem for writing). Since the
> -	 * caller has seen a DAX entry for this index, we better find it
> -	 * at that index as well...
> -	 */
> -	WARN_ON_ONCE(!ret);
> -	return ret;
> -}
> -
> -/*
> - * Invalidate DAX entry if it is clean.
> - */
> -int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
> -				      pgoff_t index)
> -{
> -	return __dax_invalidate_entry(mapping, index, false);
> -}
> -
>  static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
>  {
>  	return PHYS_PFN(iomap->addr + (pos & PAGE_MASK) - iomap->offset);
> @@ -894,195 +55,6 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
>  	return 0;
>  }
>
> -/*
> - * MAP_SYNC on a dax mapping guarantees dirty metadata is
> - * flushed on write-faults (non-cow), but not read-faults.
> - */
> -static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
> -		struct vm_area_struct *vma)
> -{
> -	return (iter->flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC) &&
> -		(iter->iomap.flags & IOMAP_F_DIRTY);
> -}
> -
> -static bool dax_fault_is_cow(const struct iomap_iter *iter)
> -{
> -	return (iter->flags & IOMAP_WRITE) &&
> -		(iter->iomap.flags & IOMAP_F_SHARED);
> -}
> -
> -static unsigned long dax_iter_flags(const struct iomap_iter *iter,
> -				    struct vm_fault *vmf)
> -{
> -	unsigned long flags = 0;
> -
> -	if (!dax_fault_is_synchronous(iter, vmf->vma))
> -		flags |= DAX_DIRTY;
> -
> -	if (dax_fault_is_cow(iter))
> -		flags |= DAX_COW;
> -
> -	return flags;
> -}
> -
> -/*
> - * By this point grab_mapping_entry() has ensured that we have a locked entry
> - * of the appropriate size so we don't have to worry about downgrading PMDs to
> - * PTEs.  If we happen to be trying to insert a PTE and there is a PMD
> - * already in the tree, we will skip the insertion and just dirty the PMD as
> - * appropriate.
> - */
> -static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> -				   void **pentry, pfn_t pfn,
> -				   unsigned long flags)
> -{
> -	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> -	void *new_entry = dax_make_entry(pfn, flags);
> -	bool dirty = flags & DAX_DIRTY;
> -	bool cow = flags & DAX_COW;
> -	void *entry = *pentry;
> -
> -	if (dirty)
> -		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> -
> -	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
> -		unsigned long index = xas->xa_index;
> -		/* we are replacing a zero page with block mapping */
> -		if (dax_is_pmd_entry(entry))
> -			unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
> -					PG_PMD_NR, false);
> -		else /* pte entry */
> -			unmap_mapping_pages(mapping, index, 1, false);
> -	}
> -
> -	xas_reset(xas);
> -	xas_lock_irq(xas);
> -	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> -		void *old;
> -
> -		dax_disassociate_entry(entry, mapping, false);
> -		dax_associate_entry(new_entry, mapping, vmf, flags);
> -		/*
> -		 * Only swap our new entry into the page cache if the current
> -		 * entry is a zero page or an empty entry.  If a normal PTE or
> -		 * PMD entry is already in the cache, we leave it alone.  This
> -		 * means that if we are trying to insert a PTE and the
> -		 * existing entry is a PMD, we will just leave the PMD in the
> -		 * tree and dirty it if necessary.
> -		 */
> -		old = dax_lock_entry(xas, new_entry);
> -		WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
> -					DAX_LOCKED));
> -		entry = new_entry;
> -	} else {
> -		xas_load(xas);	/* Walk the xa_state */
> -	}
> -
> -	if (dirty)
> -		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
> -
> -	if (cow)
> -		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> -
> -	xas_unlock_irq(xas);
> -	*pentry = entry;
> -	return 0;
> -}
> -
> -static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> -		struct address_space *mapping, void *entry)
> -{
> -	unsigned long pfn, index, count, end;
> -	long ret = 0;
> -	struct vm_area_struct *vma;
> -
> -	/*
> -	 * A page got tagged dirty in DAX mapping? Something is seriously
> -	 * wrong.
> -	 */
> -	if (WARN_ON(!xa_is_value(entry)))
> -		return -EIO;
> -
> -	if (unlikely(dax_is_locked(entry))) {
> -		void *old_entry = entry;
> -
> -		entry = get_unlocked_entry(xas, 0);
> -
> -		/* Entry got punched out / reallocated? */
> -		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> -			goto put_unlocked;
> -		/*
> -		 * Entry got reallocated elsewhere? No need to writeback.
> -		 * We have to compare pfns as we must not bail out due to
> -		 * difference in lockbit or entry type.
> -		 */
> -		if (dax_to_pfn(old_entry) != dax_to_pfn(entry))
> -			goto put_unlocked;
> -		if (WARN_ON_ONCE(dax_is_empty_entry(entry) ||
> -					dax_is_zero_entry(entry))) {
> -			ret = -EIO;
> -			goto put_unlocked;
> -		}
> -
> -		/* Another fsync thread may have already done this entry */
> -		if (!xas_get_mark(xas, PAGECACHE_TAG_TOWRITE))
> -			goto put_unlocked;
> -	}
> -
> -	/* Lock the entry to serialize with page faults */
> -	dax_lock_entry(xas, entry);
> -
> -	/*
> -	 * We can clear the tag now but we have to be careful so that concurrent
> -	 * dax_writeback_one() calls for the same index cannot finish before we
> -	 * actually flush the caches. This is achieved as the calls will look
> -	 * at the entry only under the i_pages lock and once they do that
> -	 * they will see the entry locked and wait for it to unlock.
> -	 */
> -	xas_clear_mark(xas, PAGECACHE_TAG_TOWRITE);
> -	xas_unlock_irq(xas);
> -
> -	/*
> -	 * If dax_writeback_mapping_range() was given a wbc->range_start
> -	 * in the middle of a PMD, the 'index' we use needs to be
> -	 * aligned to the start of the PMD.
> -	 * This allows us to flush for PMD_SIZE and not have to worry about
> -	 * partial PMD writebacks.
> -	 */
> -	pfn = dax_to_pfn(entry);
> -	count = 1UL << dax_entry_order(entry);
> -	index = xas->xa_index & ~(count - 1);
> -	end = index + count - 1;
> -
> -	/* Walk all mappings of a given index of a file and writeprotect them */
> -	i_mmap_lock_read(mapping);
> -	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, end) {
> -		pfn_mkclean_range(pfn, count, index, vma);
> -		cond_resched();
> -	}
> -	i_mmap_unlock_read(mapping);
> -
> -	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
> -	/*
> -	 * After we have flushed the cache, we can clear the dirty tag. There
> -	 * cannot be new dirty data in the pfn after the flush has completed as
> -	 * the pfn mappings are writeprotected and fault waits for mapping
> -	 * entry lock.
> -	 */
> -	xas_reset(xas);
> -	xas_lock_irq(xas);
> -	xas_store(xas, entry);
> -	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
> -	dax_wake_entry(xas, entry, WAKE_NEXT);
> -
> -	trace_dax_writeback_one(mapping->host, index, count);
> -	return ret;
> -
> - put_unlocked:
> -	put_unlocked_entry(xas, entry, WAKE_NEXT);
> -	return ret;
> -}
> -
>  /*
>   * Flush the mapping to the persistent domain within the byte range of [start,
>   * end]. This is required by data integrity operations to ensure file data is
> @@ -1219,6 +191,37 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
>  	return 0;
>  }
>
> +/*
> + * MAP_SYNC on a dax mapping guarantees dirty metadata is
> + * flushed on write-faults (non-cow), but not read-faults.
> + */
> +static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
> +				     struct vm_area_struct *vma)
> +{
> +	return (iter->flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC) &&
> +	       (iter->iomap.flags & IOMAP_F_DIRTY);
> +}
> +
> +static bool dax_fault_is_cow(const struct iomap_iter *iter)
> +{
> +	return (iter->flags & IOMAP_WRITE) &&
> +	       (iter->iomap.flags & IOMAP_F_SHARED);
> +}
> +
> +static unsigned long dax_iter_flags(const struct iomap_iter *iter,
> +				    struct vm_fault *vmf)
> +{
> +	unsigned long flags = 0;
> +
> +	if (!dax_fault_is_synchronous(iter, vmf->vma))
> +		flags |= DAX_DIRTY;
> +
> +	if (dax_fault_is_cow(iter))
> +		flags |= DAX_COW;
> +
> +	return flags;
> +}
> +
>  /*
>   * The user has performed a load from a hole in the file.  Allocating a new
>   * page in the file would cause excessive storage usage for workloads with
> @@ -1701,7 +704,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && !vmf->cow_page)
>  		iter.flags |= IOMAP_WRITE;
>
> -	entry = grab_mapping_entry(&xas, mapping, 0);
> +	entry = dax_grab_mapping_entry(&xas, mapping, 0);
>  	if (xa_is_internal(entry)) {
>  		ret = xa_to_internal(entry);
>  		goto out;
> @@ -1818,12 +821,12 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		goto fallback;
>
>  	/*
> -	 * grab_mapping_entry() will make sure we get an empty PMD entry,
> +	 * dax_grab_mapping_entry() will make sure we get an empty PMD entry,
>  	 * a zero PMD entry or a DAX PMD.  If it can't (because a PTE
>  	 * entry is already in the array, for instance), it will return
>  	 * VM_FAULT_FALLBACK.
>  	 */
> -	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
> +	entry = dax_grab_mapping_entry(&xas, mapping, PMD_ORDER);
>  	if (xa_is_internal(entry)) {
>  		ret = xa_to_internal(entry);
>  		goto fallback;
> @@ -1897,50 +900,6 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
>  }
>  EXPORT_SYMBOL_GPL(dax_iomap_fault);
>
> -/*
> - * dax_insert_pfn_mkwrite - insert PTE or PMD entry into page tables
> - * @vmf: The description of the fault
> - * @pfn: PFN to insert
> - * @order: Order of entry to insert.
> - *
> - * This function inserts a writeable PTE or PMD entry into the page tables
> - * for an mmaped DAX file.  It also marks the page cache entry as dirty.
> - */
> -static vm_fault_t
> -dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> -{
> -	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> -	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
> -	void *entry;
> -	vm_fault_t ret;
> -
> -	xas_lock_irq(&xas);
> -	entry = get_unlocked_entry(&xas, order);
> -	/* Did we race with someone splitting entry or so? */
> -	if (!entry || dax_is_conflict(entry) ||
> -	    (order == 0 && !dax_is_pte_entry(entry))) {
> -		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> -		xas_unlock_irq(&xas);
> -		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
> -						      VM_FAULT_NOPAGE);
> -		return VM_FAULT_NOPAGE;
> -	}
> -	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
> -	dax_lock_entry(&xas, entry);
> -	xas_unlock_irq(&xas);
> -	if (order == 0)
> -		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> -#ifdef CONFIG_FS_DAX_PMD
> -	else if (order == PMD_ORDER)
> -		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
> -#endif
> -	else
> -		ret = VM_FAULT_FALLBACK;
> -	dax_unlock_entry(&xas, entry);
> -	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
> -	return ret;
> -}
> -
>  /**
>   * dax_finish_sync_fault - finish synchronous page fault
>   * @vmf: The description of the fault
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index f6acb4ed73cb..de60a34088bb 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -157,15 +157,33 @@ static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc);
>
> -struct page *dax_zap_mappings(struct address_space *mapping);
> -struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
> -				    loff_t end);
> +#else
> +static inline int dax_writeback_mapping_range(struct address_space *mapping,
> +		struct dax_device *dax_dev, struct writeback_control *wbc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif
> +
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +		const struct iomap_ops *ops);
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +		const struct iomap_ops *ops);
> +
> +#if IS_ENABLED(CONFIG_DAX)
> +int dax_read_lock(void);
> +void dax_read_unlock(int id);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +void run_dax(struct dax_device *dax_dev);
>  dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
>  		unsigned long index, struct page **page);
>  void dax_unlock_mapping_entry(struct address_space *mapping,
>  		unsigned long index, dax_entry_t cookie);
> +struct page *dax_zap_mappings(struct address_space *mapping);
> +struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
> +				    loff_t end);
>  #else
>  static inline struct page *dax_zap_mappings(struct address_space *mapping)
>  {
> @@ -179,12 +197,6 @@ static inline struct page *dax_zap_mappings_range(struct address_space *mapping,
>  	return NULL;
>  }
>
> -static inline int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct dax_device *dax_dev, struct writeback_control *wbc)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>  static inline dax_entry_t dax_lock_page(struct page *page)
>  {
>  	if (IS_DAX(page->mapping->host))
> @@ -196,6 +208,15 @@ static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
>  {
>  }
>
> +static inline int dax_read_lock(void)
> +{
> +	return 0;
> +}
> +
> +static inline void dax_read_unlock(int id)
> +{
> +}
> +
>  static inline dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
>  		unsigned long index, struct page **page)
>  {
> @@ -208,11 +229,6 @@ static inline void dax_unlock_mapping_entry(struct address_space *mapping,
>  }
>  #endif
>
> -int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> -		const struct iomap_ops *ops);
> -int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops);
> -
>  /*
>   * Document all the code locations that want know when a dax page is
>   * unreferenced.
> @@ -222,19 +238,6 @@ static inline bool dax_page_idle(struct page *page)
>  	return page_ref_count(page) == 1;
>  }
>
> -#if IS_ENABLED(CONFIG_DAX)
> -int dax_read_lock(void);
> -void dax_read_unlock(int id);
> -#else
> -static inline int dax_read_lock(void)
> -{
> -	return 0;
> -}
> -
> -static inline void dax_read_unlock(int id)
> -{
> -}
> -#endif /* CONFIG_DAX */
>  bool dax_alive(struct dax_device *dax_dev);
>  void *dax_get_private(struct dax_device *dax_dev);
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> @@ -255,6 +258,9 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
>  		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
>  vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  		enum page_entry_size pe_size, pfn_t pfn);
> +void *dax_grab_mapping_entry(struct xa_state *xas,
> +			     struct address_space *mapping, unsigned int order);
> +void dax_unlock_entry(struct xa_state *xas, void *entry);
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> @@ -271,6 +277,56 @@ static inline bool dax_mapping(struct address_space *mapping)
>  	return mapping->host && IS_DAX(mapping->host);
>  }
>
> +/*
> + * DAX pagecache entries use XArray value entries so they can't be mistaken
> + * for pages.  We use one bit for locking, one bit for the entry size (PMD)
> + * and two more to tell us if the entry is a zero page or an empty entry that
> + * is just used for locking.  In total four special bits.
> + *
> + * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
> + * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
> + * block allocation.
> + */
> +#define DAX_SHIFT	(5)
> +#define DAX_MASK	((1UL << DAX_SHIFT) - 1)
> +#define DAX_LOCKED	(1UL << 0)
> +#define DAX_PMD		(1UL << 1)
> +#define DAX_ZERO_PAGE	(1UL << 2)
> +#define DAX_EMPTY	(1UL << 3)
> +#define DAX_ZAP		(1UL << 4)
> +
> +/*
> + * These flags are not conveyed in Xarray value entries, they are just
> + * modifiers to dax_insert_entry().
> + */
> +#define DAX_DIRTY (1UL << (DAX_SHIFT + 0))
> +#define DAX_COW   (1UL << (DAX_SHIFT + 1))
> +
> +vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +			    void **pentry, pfn_t pfn, unsigned long flags);
> +vm_fault_t dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn,
> +				  unsigned int order);
> +int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> +		      struct address_space *mapping, void *entry);
> +
> +/* The 'colour' (ie low bits) within a PMD of a page offset.  */
> +#define PG_PMD_COLOUR ((PMD_SIZE >> PAGE_SHIFT) - 1)
> +#define PG_PMD_NR (PMD_SIZE >> PAGE_SHIFT)
> +
> +/* The order of a PMD entry */
> +#define PMD_ORDER (PMD_SHIFT - PAGE_SHIFT)
> +
> +static inline unsigned int pe_order(enum page_entry_size pe_size)
> +{
> +	if (pe_size == PE_SIZE_PTE)
> +		return PAGE_SHIFT - PAGE_SHIFT;
> +	if (pe_size == PE_SIZE_PMD)
> +		return PMD_SHIFT - PAGE_SHIFT;
> +	if (pe_size == PE_SIZE_PUD)
> +		return PUD_SHIFT - PAGE_SHIFT;
> +	return ~0;
> +}
> +
>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>  void hmem_register_device(int target_nid, struct resource *r);
>  #else
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index fd57407e7f3d..e5d30eec3bf1 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -221,6 +221,12 @@ static inline void devm_memunmap_pages(struct device *dev,
>  {
>  }
>
> +static inline struct dev_pagemap *
> +get_dev_pagemap_many(unsigned long pfn, struct dev_pagemap *pgmap, int refs)
> +{
> +	return NULL;
> +}
> +
>  static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap)
>  {
