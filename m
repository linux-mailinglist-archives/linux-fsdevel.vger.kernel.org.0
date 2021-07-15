Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59303CA0BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 16:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhGOOeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhGOOeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:34:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8FC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p3LUvr3mjoFX0oNMPlmLpu09f7lyOkd/nLcjhfFGIIM=; b=Ikod35+XCfjrldDurEyLlx/G8m
        pIhXyAAKjXnwcLAhKOzXnHMHBW7VIdOw0afDnnxS5RyX20ddgkmVQigRuLretf9azb1zd5GF1oBS3
        mXParICaDc/mgCtspkDjK+yxpmeQshdHMmVo1/VWDLaj0s2/6ti8hylAlt25eyQrE8iqaX5w8NiLD
        u7WG5oW7nzceE05jiOZ80jFPnZzQ87vFDcbTjjntXGYSTCblebxP3FabhtWufGvVW8gU88N3prhw/
        Bt7KTesgPimKiERgzIebRPsVw9NxmMWPsz3FRWFlnlr+CWJ6Vy1ypqyMj9xtk3ofKkX6j13TnFEkr
        Eub8JR5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m42O8-003R2n-1G; Thu, 15 Jul 2021 14:31:03 +0000
Date:   Thu, 15 Jul 2021 15:30:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
Message-ID: <YPBGoDlf9T6kFjk1@casper.infradead.org>
References: <20210715141309.38443-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715141309.38443-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 05:13:09PM +0300, Nikolay Borisov wrote:
> Currently the comparison method vfs_dedupe_file_range_compare utilizes
> is a plain memcmp. This effectively means the code is doing byte-by-byte
> comparison. Instead, the code could do word-sized comparison without
> adverse effect on performance, provided that the comparison's length is
> at least as big as the native word size, as well as resulting memory
> addresses are properly aligned.

Sounds to me like somebody hasn't optimised memcmp() very well ...
is this x86-64?

> @@ -256,9 +257,35 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		flush_dcache_page(src_page);
>  		flush_dcache_page(dest_page);
> 
> -		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
> -			same = false;
> 
> +		if (!IS_ALIGNED((unsigned long)(src_addr + src_poff), block_size) ||
> +		    !IS_ALIGNED((unsigned long)(dest_addr + dest_poff), block_size) ||
> +		    cmp_len < block_size) {

Can this even happen?  Surely we can only dedup on a block boundary and
blocks are required to be a power of two and at least 512 bytes in size?

> +			if (memcmp(src_addr + src_poff, dest_addr + dest_poff,
> +				   cmp_len))
> +				same = false;
> +		} else {
> +			int i;
> +			size_t blocks = cmp_len / block_size;
> +			loff_t rem_len = cmp_len - (blocks * block_size);
> +			unsigned long *src = src_addr + src_poff;
> +			unsigned long *dst = dest_addr + src_poff;
> +
> +			for (i = 0; i < blocks; i++) {
> +				if (src[i] - dst[i]) {
> +					same = false;
> +					goto finished;
> +				}
> +			}
> +
> +			if (rem_len) {
> +				src_addr += src_poff + (blocks * block_size);
> +				dest_addr += dest_poff + (blocks * block_size);
> +				if (memcmp(src_addr, dest_addr, rem_len))
> +					same = false;
> +			}
> +		}
> +finished:
>  		kunmap_atomic(dest_addr);
>  		kunmap_atomic(src_addr);
>  unlock:
> --
> 2.25.1
> 
