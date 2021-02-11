Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BD318D12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBKONG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 09:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhBKOKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:10:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740BC061574;
        Thu, 11 Feb 2021 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Id1rvYTl6OU9FX0z5Yd573l7tF4Bgejp/fPk91EVH/c=; b=S7pdJ9ns6qMKUu6eNpgc2ZbeHn
        Itf69hnjbyHpRZRwWeZIgENy4xl7cCFrvswYtM4My5Un9ipLEHMHBD/PYRBnVIbNbDSaUfwW75FTI
        9RpIXQwnnV4yadb8Xdhu/TJxaBDtK2G0stoiq2FtXNQ+DKppMGjFhhRebSOdZrYDTH0F+h92gSzN1
        n6Dtvl9owj3Olb6XDJb6Q3Ef7tA2dwFRZgW9bJxs30zmKXvIgRIT47Mkyz/CMlTFNibUczP6RK99x
        fVlSCs8NSAjl4Lg5CllXXi5zgmYTq/hYkl+ELdK/YWHRZ2/ayVjakIH6114aDA0cxmrfUxTx4NYB7
        GUOuHIvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lACfG-00AKE2-Tu; Thu, 11 Feb 2021 14:09:51 +0000
Date:   Thu, 11 Feb 2021 14:09:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2] [RFC] mm: fs: Invalidate BH LRU during page migration
Message-ID: <20210211140950.GJ308988@casper.infradead.org>
References: <cover.1613020616.git.cgoldswo@codeaurora.org>
 <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:35:40PM -0800, Chris Goldsworthy wrote:
> +/* These are used to control the BH LRU invalidation during page migration */
> +static struct cpumask lru_needs_invalidation;
> +static bool bh_lru_disabled = false;

As I asked before, what protects this on an SMP system?

> @@ -1292,7 +1296,9 @@ static inline void check_irqs_on(void)
>  /*
>   * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
>   * inserted at the front, and the buffer_head at the back if any is evicted.
> - * Or, if already in the LRU it is moved to the front.
> + * Or, if already in the LRU it is moved to the front. Note that if LRU is
> + * disabled because of an ongoing page migration, we won't insert bh into the
> + * LRU.

And also, why do we need to do this?  The page LRU has no equivalent
mechanism to prevent new pages being added to the per-CPU LRU lists.
If a BH has just been used, isn't that a strong hint that this page is
a bad candidate for migration?

