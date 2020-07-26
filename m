Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C58422E101
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGZQEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgGZQEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:04:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24BC0619D2;
        Sun, 26 Jul 2020 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVJtNGHKrqJibaPA3Azyc6Icu8sYoP/gQC/o3PwnvVU=; b=IMzGjam+jYWweR4dE5pR1jb47q
        qJXQ+Q7F6bVEJHCiZDBrXvepJnhu3S/KypM4zhSAz7STtXk734nGPy60m4rprHbKqbMugtEKLVk2G
        5jvpAMrlGIwP4oyLv7TWQuMlG2KHgzh7ngSLFCDc8s7CyjRI6oB0cNuO6pjpbt8cB7pMcdPe3bh4n
        TdqHuxvv/UqBhoApHqUwRZGuSbGw5mHj1PvrzJOpNghWIUeT8nADLuCxRQdzDxghU9cNYqyNAorHD
        DVayd8gJHff0MxgLEloRwh1tX2pIMEwcgbpdWBk4jqh13fOuFyo9hjv3bBzcQrgMildKtzWsoWar4
        vcR76Kpg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzj84-0000YE-O7; Sun, 26 Jul 2020 16:04:01 +0000
Date:   Sun, 26 Jul 2020 17:04:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] xfs: introduce task->in_fstrans for transaction
 reservation recursion protection
Message-ID: <20200726160400.GF23808@casper.infradead.org>
References: <20200726145726.1484-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726145726.1484-1-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 10:57:26AM -0400, Yafang Shao wrote:
> Bellow comment is quoted from Dave,

FYI, you mean "Below", not "Bellow".  Dave doesn't often bellow.

> As a result, we should reintroduce PF_FSTRANS. Because PF_FSTRANS is only
> set by current, we can move it out of task->flags to avoid being out of PF_
> flags. So a new flag in_fstrans is introduced.

I don't think we need a new flag for this.  I think you can just set
current->journal_info to a non-NULL value.

> +++ b/fs/xfs/xfs_linux.h
> @@ -111,6 +111,20 @@ typedef __u32			xfs_nlink_t;
>  #define current_restore_flags_nested(sp, f)	\
>  		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
>  
> +static inline unsigned int xfs_trans_context_start(void)
> +{
> +	unsigned int flags = current->in_fstrans;
> +
> +	current->in_fstrans = 1;
> +
> +	return flags;
> +}
> +
> +static inline void xfs_trans_context_end(unsigned int flags)
> +{
> +	current->in_fstrans = flags ? 1 : 0;
> +}

Does XFS support nested transactions?  If we're just using
current->journal_info, we can pretend its an unsigned long and use it
as a counter rather than handle the nesting the same way as the GFP flags.

