Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9700C257FD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgHaRm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHaRmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:42:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F10BC061573;
        Mon, 31 Aug 2020 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YnNEV33wLo5xHrYQ9gYU5hq0dtzL01pLvIAQRW2TrBg=; b=Hmgou9hFQSS+bBnXVrEcA6rVbb
        zsM3VwfTM1FBio0Dy9gCBypsdS1dM//Qw1u2o7q6GYqsLfD6airLGo6K0fFifuuKW/XTWi7T0xVhg
        bu/GWNTpKjvAuJiiqq9bZL9kzeBk1r3MBoYDZoSJMp0VirV/rFyT9Oqa+0W2ihS+bB2zXI1ec6Fgs
        X9kIAShxn7bcewohlgU9BW47Sw4f3yreIFsncCNPq8X2BNFhDDeQlvKDcUPieEFgGg1uFaqUZEJhw
        SGwRD3O/VEj0gHytSTVztVbstsT7s4h3yd75Nh4A0lTbRpwJu0S9SfvCJ45cYaMrM064IPJnHKHiA
        5DaUMZLw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCnox-0000HL-II; Mon, 31 Aug 2020 17:42:19 +0000
Date:   Mon, 31 Aug 2020 18:42:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     darrick.wong@oracle.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iomap: Fix WARN_ON_ONCE() from unprivileged users
Message-ID: <20200831174219.GI14765@casper.infradead.org>
References: <20200831172534.12464-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831172534.12464-1-cai@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 01:25:34PM -0400, Qian Cai wrote:
> +	case IOMAP_DELALLOC:
> +		/*
> +		 * DIO is not serialised against mmap() access at all, and so
> +		 * if the page_mkwrite occurs between the writeback and the
> +		 * iomap_apply() call in the DIO path, then it will see the
> +		 * DELALLOC block that the page-mkwrite allocated.
> +		 */
> +		path = file_path(dio->iocb->ki_filp, pathname,
> +				 sizeof(pathname));
> +		if (IS_ERR(path))
> +			path = "(unknown)";
> +
> +		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %s Comm: %.20s\n",
> +				    path, current->comm);

"File: %pD4"?

