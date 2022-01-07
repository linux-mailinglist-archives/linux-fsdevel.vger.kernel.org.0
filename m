Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C164879EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 16:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbiAGPxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 10:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiAGPxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:53:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E081C061574
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b2yd3jqrlE4paTEK5U5zvhRDmcYO7C7R5TS2BGFojms=; b=cDraS37wLiLvalAuiDZqRYXJYy
        pmHdeL8lH1erKsxET3rHEEuTxqZeQ4zc1/JRK2jvcVepQZb2kr+7emVo/t+Yg9nht+M9/Y0+e6lda
        0x0lm6hNiF5rzH+cHQkqjPYOu967HdHwu0sFQdroZaCfumFmd9Bu7TxvnI5wbkEhF9syXhEFQNj+C
        kjzoB77cJ2WpeIIqZZFGo5IfgJHqYQB+hYbsLjkpWldINReLcMeQpmWatMzd9ZaCLjsjyjvZg6mtf
        F6l3/JafJhlOJQ373xk0mF1w2obGMOBJmcCszb1HBCL5FgM5Y0Hfq9neGt5R6OzRwFWXO/VAcp6Hk
        e8LHQdOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5rY7-00GT4o-2z; Fri, 07 Jan 2022 15:53:03 +0000
Date:   Fri, 7 Jan 2022 15:53:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 2/3] shmem: Fix data loss when folio truncated
Message-ID: <Ydhh39A92g7Xe1df@casper.infradead.org>
References: <24d53dac-d58d-6bb9-82af-c472922e4a31@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d53dac-d58d-6bb9-82af-c472922e4a31@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 05:34:05PM -0800, Hugh Dickins wrote:
> xfstests generic 098 214 263 286 412 used to pass on huge tmpfs (well,
> three of those _require_odirect, enabled by a shmem_direct_IO() stub),
> but still fail even with the partial_end fix.
> 
> generic/098 output mismatch shows actual data loss:
>     --- tests/generic/098.out
>     +++ /home/hughd/xfstests/results//generic/098.out.bad
>     @@ -4,9 +4,7 @@
>      wrote 32768/32768 bytes at offset 262144
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      File content after remount:
>     -0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>     -*
>     -0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     ...

generic/098 is passing for me ;-(  I'm using 'always' for THPs.
I'll have to try harder.  Regardless, I think your fix is good ...

> +static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)

Love the better calling convention.

> +	folio = __filemap_get_folio(inode->i_mapping, index,
> +					FGP_ENTRY | FGP_LOCK, 0);
> +	if (!folio || !xa_is_value(folio))
> +		return folio;

That first '!folio' is redundant.  xa_is_value(NULL) is false.

