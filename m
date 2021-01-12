Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151BC2F2D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbhALKoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbhALKoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:44:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E0C061575;
        Tue, 12 Jan 2021 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ol5oSeAbYBT78LdfybyyDXMhth/dQRk1esaarQzaPzU=; b=RAxeVxUpWBqgS3BvC4fbDHgU+F
        76p2mvfq0IdJqFJRT5pnVwqBU1n870wpQG1E3k165zBeF/Q6yF2ecETFjV+QvfbQtQEuH3Qah41YH
        Bw+MMUeyJu7a3T9LGGbMiDpsm32zKHQbcaxwc3BO1/hfO4z1VmCo649OdkkrWraZEZ+HCvdKqoqto
        JlazfM8dGku7/XvH7M64fWab5ZrY3rldZLp6tvureMzhOTVDgGbqfK8udCqZm+t0BgZCrttbbXFjy
        DIn2d42rWVKZmc7CV/uh8vWlCYDGYsr/diR4ySQZeu8LJNdQHuquc5pRZSxUANfCQMmYWbjo4VtMN
        nsBS2VAg==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzH8b-004efp-TR; Tue, 12 Jan 2021 10:43:04 +0000
Date:   Tue, 12 Jan 2021 11:42:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 6/6] xfs: reduce exclusive locking on unaligned dio
Message-ID: <X/19MZHQtcnj9NDc@infradead.org>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112010746.1154363-7-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index bba33be17eff..f5c75404b8a5 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -408,7 +408,7 @@ xfs_file_aio_write_checks(
>  			drained_dio = true;
>  			goto restart;
>  		}
> -	
> +

Spurious unrelated whitespace change.

>  	struct iomap_dio_rw_args args = {
>  		.iocb			= iocb,
>  		.iter			= from,
>  		.ops			= &xfs_direct_write_iomap_ops,
>  		.dops			= &xfs_dio_write_ops,
>  		.wait_for_completion	= is_sync_kiocb(iocb),
> -		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
> +		.nonblocking		= true,

I think this is in many ways wrong.  As far as I can tell you want this
so that we get the imap_spans_range in xfs_direct_write_iomap_begin. But
we should not trigger any of the other checks, so we'd really need
another flag instead of reusing this one.

imap_spans_range is a bit pessimistic for avoiding the exclusive lock,
but I guess we could live that if it is clearly documented as helping
with the implementation, but we really should not automatically trigger
all the other effects of nowait I/O.
