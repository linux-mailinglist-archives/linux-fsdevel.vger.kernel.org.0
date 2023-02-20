Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC469CC11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBTN1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 08:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjBTN1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:27:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70101A66C;
        Mon, 20 Feb 2023 05:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64BADB80B96;
        Mon, 20 Feb 2023 13:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6B3C433EF;
        Mon, 20 Feb 2023 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676899622;
        bh=gABycNmDsaE8rStdHvaqVjETdB3UP1bj2wN6aXwFGQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkLjZU/xmTq7YtlM2nRS961aOed/9VW/PzOscHWvnJF+9fL9OLHpz1uahozF0Culs
         d8ASa1roMSsa4yEEvcwtNAyQIcxKxTfi0dHgjHd/MHDmnkP7KsvLSvvqu1IVdPyjiB
         J8WphKgkLEFGTCxTD1Lh6sEdPMz+PiK6tycDIjJzTl9I6ZeVGKH3xlvpNMohSwh0F6
         rd4FLUysaC1d6mr0vnuyr+6v5RgiQD7rMki64k3V9UK4sarN/1MpAgFkFrIcC+AdNY
         Qo3MKGc1EYFMS9hVjLnCz94LHRQvxBArNBrvr2uKJuFkf7Pa3rzHV9j3p9AtdIVNbT
         PUPxhGqs7wdcw==
Date:   Mon, 20 Feb 2023 15:26:42 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y/N1EnEEE9y0qp/n@kernel.org>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202112915.867409-4-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>   (PAGE_IS_SWAPPED).
> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>   pages have been written-to.
> - Find pages which have been written-to and write protect the pages
>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
> 
> +/*
> + * struct pagemap_scan_arg - Pagemap ioctl argument
> + * @start:		Starting address of the region
> + * @len:		Length of the region (All the pages in this length are included)
> + * @vec:		Address of page_region struct array for output
> + * @vec_len:		Length of the page_region struct array
> + * @max_pages:		Optional max return pages
> + * @flags:		Flags for the IOCTL
> + * @required_mask:	Required mask - All of these bits have to be set in the PTE
> + * @anyof_mask:		Any mask - Any of these bits are set in the PTE
> + * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
> + * @return_mask:	Bits that are to be reported in page_region
> + */
> +struct pagemap_scan_arg {
> +	__u64 start;
> +	__u64 len;
> +	__u64 vec;
> +	__u64 vec_len;
> +	__u32 max_pages;
> +	__u32 flags;
> +	__u64 required_mask;
> +	__u64 anyof_mask;
> +	__u64 excluded_mask;
> +	__u64 return_mask;
> +};

After Nadav's comment I've realized I missed the API part :)

A few quick notes for now:
* The arg struct is fixed, so it would be impossible to extend the API
later. Following the clone3() example, I'd add 'size' field to the
pagemam_scan_arg so that it would be possible to add new fields afterwards.
* Please make flags __u64, just in case
* Put size and flags at the beginning of the struct, e.g.

strucr pagemap_scan_arg {
	size_t size;
	__u64 flags;
	/* all the rest */
};

> +
> +/* Special flags */
> +#define PAGEMAP_WP_ENGAGE	(1 << 0)
> +
>  #endif /* _UAPI_LINUX_FS_H */
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
