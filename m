Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B385307439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 11:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhA1Kzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 05:55:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhA1Kzn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:55:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3300BABC4;
        Thu, 28 Jan 2021 10:55:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 75DFC1E14D9; Thu, 28 Jan 2021 11:55:01 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:55:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     bingjingc <bingjingc@synology.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cccheng@synology.com,
        robbieko@synology.com, willy@infradead.org, rdunlap@infradead.org
Subject: Re: [PATCH v2 0/3] handle large user and group ID for isofs and udf
Message-ID: <20210128105501.GC3324@quack2.suse.cz>
References: <1611817947-2839-1-git-send-email-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611817947-2839-1-git-send-email-bingjingc@synology.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-01-21 15:12:27, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> The uid/gid (unsigned int) of a domain user may be larger than INT_MAX.
> The parse_options of isofs and udf will return 0, and mount will fail
> with -EINVAL. These patches try to handle large user and group ID.
> 
> BingJing Chang (3):
>   parser: add unsigned int parser
>   isofs: handle large user and group ID
>   udf: handle large user and group ID

Thanks for your patches! Just two notes:

1) I don't think Matthew Wilcox gave you his Reviewed-by tag (at least I
didn't see such email). Generally the rule is that the developer has to
explicitely write in his email that you can attach his Reviewed-by tag for
it to be valid.

2) Please split the cleanup of kernel doc comments in lib/parser.c in a
separate patch. It is unrelated to adding parse_uint() function so it
belongs into a separate patch (we occasionally do include small unrelated
cleanups if they are on the same line we change anyway but your changes
definitely triggered my treshold of this should be a separate patch).

Thanks!

								Honza

> 
>  fs/isofs/inode.c       |  9 +++++----
>  fs/udf/super.c         |  9 +++++----
>  include/linux/parser.h |  1 +
>  lib/parser.c           | 44 +++++++++++++++++++++++++++++++++-----------
>  4 files changed, 44 insertions(+), 19 deletions(-)
> 
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
