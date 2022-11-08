Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E25621D61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKHUDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 15:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiKHUDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:03:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BA2CC9C
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 12:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ECx4ac/43Sve770ApDnoLkpre//8zzwIrtSe8weF9T0=; b=Vscp9mnUyEA3c2afpa4mUNmJCa
        9droWRl9WrSRZgdH8YXmFBi64pCRsWzlsNObTnHQFthJVWhfIX1A1/k70XxjhIsYJ9Pg2zZFjBAHY
        o2mOYnqmRSqh16HSDqko2Jwcdda5y/r4urubWONKi69tG0bS1DoA1AgcRkumtE78XfYGBGypTG0w6
        +ePdF98yAW0oCLw1T8WloWVm35SWPVUzSpJw8dxJzr7ExXstz6QpaNKFfFRjSsLFCUFSJ/9XYs2Un
        e0bCdpi7PciBQMffDs2PjBOl9jBXSjmdgf0wDdaCaBcw9WUXgYVVxdnNshptXnI6r7S3csnqdkOfG
        Ry14GU/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osUor-00AZ68-Eo; Tue, 08 Nov 2022 20:03:37 +0000
Date:   Tue, 8 Nov 2022 20:03:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] shmem: implement user/group quota support for tmpfs
Message-ID: <Y2q2GRFDBi+XTvgi@casper.infradead.org>
References: <20221108133010.75226-1-lczerner@redhat.com>
 <20221108133010.75226-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108133010.75226-2-lczerner@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:30:09PM +0100, Lukas Czerner wrote:
> +	err = shmem_get_folio(inode, index, &folio, SGP_WRITE);
> +	if (err)
> +		return err;
> +
> +	page = folio_file_page(folio, index);
> +	if (PageHWPoison(page)) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		return -EIO;
> +	}
> +
> +	/* Write data, or zeroout the portion of the page */
> +	if (data)
> +		memcpy(page_address(page) + offset, data, len);
> +	else
> +		memset(page_address(page) + offset, 0, len);
> +
> +	SetPageUptodate(page);

This is suspicious.  There is no per-page Uptodate bit, there is only a
per-folio Uptodate bit.  So this should be folio_mark_uptodate().
Except that you've only done one of the pages in the folio, so you
have no business setting the uptodate bit at all.

