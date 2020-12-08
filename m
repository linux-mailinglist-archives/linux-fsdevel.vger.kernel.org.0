Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C290C2D2109
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgLHCmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:42:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D7C061749;
        Mon,  7 Dec 2020 18:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lxhPd96G94u8hhUO8dm3oxiKcUEqLHrJKJGAgEVgEFI=; b=KBfNGlZOfeCKT1AQZmqamolqPx
        SGAm2hc2A1w0bhK6VmVaLe28sKjp9KrQoh6+DJyc/JuS1iuWl2ml7pZRyZaZMAX6v7J06a9eiPx02
        vnRWzChkIoDZXOM68PJ7VxmwA533CuN5QDjw6oucAOPSQjBqKl5+aXq53Oy4ff9YcWB952AynH1CV
        6YvZPFdBMF4jL0cqO4B64Gx25hlnMEdnuB3JvG995QuV4C1CS4dR/C5tg+P6RusnMHF5dnn4VmOfu
        0EHFcS/QZosYqKsE3UxwwQnJpNyOhInF9kGxH4Md9DwQ5afLS1JktknImbGk+NhHr2JvjE8rebrPI
        lFWz32tw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmSww-0002s6-PN; Tue, 08 Dec 2020 02:41:58 +0000
Date:   Tue, 8 Dec 2020 02:41:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     darrick.wong@oracle.com, david@fromorbit.com, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 4/4] xfs: use current->journal_info to avoid
 transaction reservation recursion
Message-ID: <20201208024158.GF7338@casper.infradead.org>
References: <20201208021543.76501-1-laoar.shao@gmail.com>
 <20201208021543.76501-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208021543.76501-5-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:15:43AM +0800, Yafang Shao wrote:
> -	/*
> -	 * Given that we do not allow direct reclaim to call us, we should
> -	 * never be called in a recursive filesystem reclaim context.
> -	 */
> -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> -		goto redirty;
> -
>  	/*
>  	 * Is this page beyond the end of the file?
>  	 *
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2371187b7615..28db93d0da97 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -568,6 +568,16 @@ xfs_vm_writepage(
>  {
>  	struct xfs_writepage_ctx wpc = { };
>  
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */
> +	if (xfs_trans_context_active()) {
> +		redirty_page_for_writepage(wbc, page);
> +		unlock_page(page);
> +		return 0;
> +	}

Dave specifically asked for this one to WARN too.
