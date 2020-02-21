Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12124166D74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 04:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgBUD1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 22:27:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10842 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgBUD1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:27:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f4de60000>; Thu, 20 Feb 2020 19:26:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 19:27:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 19:27:03 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 03:27:03 +0000
Subject: Re: [PATCH v7 06/24] mm: Rename various 'offset' parameters to
 'index'
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-7-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <110bd4a5-0d12-7f8e-0d5d-78869b3f9135@nvidia.com>
Date:   Thu, 20 Feb 2020 19:27:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-7-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582255590; bh=owcb4CMNvaoIORlq5lNkIRvU5IPCuIJMoPXOl4x4Vi0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GVE5JgGQrgvZz6V3WcHAMb67LvTCiKjS8hKTk2B9obgdAVU0QHb0/YJxV39UHoes4
         fTXr2Jtotj3X/Fwe/w/9iL/HOFWfI2kViUR6nyfJwvx8nqtqScXQ3n96GkcYB1wNPO
         XGPagBrK93GOX00pFiXiJHkA1qTPFqsROFjX2+5h+HL+PQ8ZjWDS/3ZuHc4z0dVP+h
         WtmdiPx3QGWa8NpWywZApZlnSwpXa0whA86w7R9jBhModR2G6pTCPMMywLXmz0jQhU
         Mq6qMUcVjmHdejFgFbiZFY8CM3ofmVhq2v/OrR1Fl6wAqwzwAWcR355R9KcDSaIEbJ
         Cl3cmTmb4JbpQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The word 'offset' is used ambiguously to mean 'byte offset within
> a page', 'byte offset from the start of the file' and 'page offset
> from the start of the file'.  Use 'index' to mean 'page offset
> from the start of the file' throughout the readahead code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 86 ++++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6a9d99229bd6..096cf9020648 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -156,7 +156,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
>   * We really don't want to intermingle reads and writes like that.
>   */
>  void __do_page_cache_readahead(struct address_space *mapping,
> -		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
> +		struct file *filp, pgoff_t index, unsigned long nr_to_read,
>  		unsigned long lookahead_size)


One more tiny thing: seeing as how this patch is also changing "size" to "count",
maybe it should also change lookahead_size to lookahead_count.


thanks,
-- 
John Hubbard
NVIDIA
