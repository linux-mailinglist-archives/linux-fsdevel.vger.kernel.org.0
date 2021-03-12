Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367CF339705
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhCLTBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 14:01:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:48102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233886AbhCLTAl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:00:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF3FAAF4D;
        Fri, 12 Mar 2021 19:00:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BDDD7DA81D; Fri, 12 Mar 2021 19:58:39 +0100 (CET)
Date:   Fri, 12 Mar 2021 19:58:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs/btrfs: Convert kmap to kmap_local_page() using
 coccinelle
Message-ID: <20210312185839.GR7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210217024826.3466046-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217024826.3466046-2-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:48:23PM -0800, ira.weiny@intel.com wrote:
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -118,7 +118,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	struct workspace *workspace = list_entry(ws, struct workspace, list);
>  	int ret = 0;
>  	char *data_in;
> -	char *cpage_out;
> +	char *cpage_out, *sizes_ptr;
>  	int nr_pages = 0;
>  	struct page *in_page = NULL;
>  	struct page *out_page = NULL;
> @@ -258,10 +258,9 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	}
>  
>  	/* store the size of all chunks of compressed data */
> -	cpage_out = kmap(pages[0]);
> -	write_compress_length(cpage_out, tot_out);
> -
> -	kunmap(pages[0]);
> +	sizes_ptr = kmap_local_page(pages[0]);
> +	write_compress_length(sizes_ptr, tot_out);
> +	kunmap_local(sizes_ptr);

Why is not cpage_out reused for this mapping? I don't see any reason for
another temporary variable, cpage_out is not used at this point.
