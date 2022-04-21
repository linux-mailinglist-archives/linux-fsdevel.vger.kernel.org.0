Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23EC509AFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386894AbiDUIuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386909AbiDUIu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:50:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801220F63;
        Thu, 21 Apr 2022 01:47:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KkWPk528TzhXyZ;
        Thu, 21 Apr 2022 16:47:22 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:47:29 +0800
Subject: Re: [PATCH v13 5/7] mm: Introduce mf_dax_kill_procs() for fsdax case
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-6-ruansy.fnst@fujitsu.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <68579c32-268f-0431-72e9-d3d104bc10bf@huawei.com>
Date:   Thu, 21 Apr 2022 16:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220419045045.1664996-6-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/4/19 12:50, Shiyang Ruan wrote:
> This new function is a variant of mf_generic_kill_procs that accepts a
> file, offset pair instead of a struct to support multiple files sharing
> a DAX mapping.  It is intended to be called by the file systems as part
> of the memory_failure handler after the file system performed a reverse
> mapping from the storage address to the file and file offset.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
...
>  
> +#ifdef CONFIG_FS_DAX
> +/**
> + * mf_dax_kill_procs - Collect and kill processes who are using this file range
> + * @mapping:	the file in use
> + * @index:	start pgoff of the range within the file

Might replacing 'file' with 'mapping' or 'address_space within file' will be better?

> + * @count:	length of the range, in unit of PAGE_SIZE
> + * @mf_flags:	memory failure flags
> + */
> +int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> +		unsigned long count, int mf_flags)
> +{
> +	LIST_HEAD(to_kill);
> +	dax_entry_t cookie;
> +	struct page *page;
> +	size_t end = index + count;
> +
> +	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> +
> +	for (; index < end; index++) {
> +		page = NULL;
> +		cookie = dax_lock_mapping_entry(mapping, index, &page);
> +		if (!cookie)
> +			return -EBUSY;
> +		if (!page)
> +			goto unlock;
> +

Should we do hwpoison_filter here?

> +		SetPageHWPoison(page);
> +
> +		collect_procs_fsdax(page, mapping, index, &to_kill);
> +		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
> +				index, mf_flags);
> +unlock:
> +		dax_unlock_mapping_entry(mapping, index, cookie);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> +#endif /* CONFIG_FS_DAX */
> +
>  /*
>   * Called from hugetlb code with hugetlb_lock held.
>   *
> 

Except from the above nit, this patch looks good to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
