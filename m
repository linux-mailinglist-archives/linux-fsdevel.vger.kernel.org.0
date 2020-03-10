Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C118016F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 16:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJPTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 11:19:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:33159 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgCJPTI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:19:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 08:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="234378139"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2020 08:19:07 -0700
Date:   Tue, 10 Mar 2020 08:19:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 02/20] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200310151906.GA670549@iweiny-DESK2.sc.intel.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304165845.3081-3-vgoyal@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:58:27AM -0500, Vivek Goyal wrote:
>  
> +	/* If end == 0, all pages from start to till end of file */
> +	if (!end) {
> +		end_idx = ULONG_MAX;
> +		len = 0;

I find this a bit odd to specify end == 0 for ULONG_MAX...

>  }
> +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> +
> +/**
> + * dax_layout_busy_page - find first pinned page in @mapping
> + * @mapping: address space to scan for a page with ref count > 1
> + *
> + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> + * 'onlined' to the page allocator so they are considered idle when
> + * page->count == 1. A filesystem uses this interface to determine if
> + * any page in the mapping is busy, i.e. for DMA, or other
> + * get_user_pages() usages.
> + *
> + * It is expected that the filesystem is holding locks to block the
> + * establishment of new mappings in this address_space. I.e. it expects
> + * to be able to run unmap_mapping_range() and subsequently not race
> + * mapping_mapped() becoming true.
> + */
> +struct page *dax_layout_busy_page(struct address_space *mapping)
> +{
> +	return dax_layout_busy_page_range(mapping, 0, 0);

... other functions I have seen specify ULONG_MAX here.  Which IMO makes this
call site more clear.

Ira

