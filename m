Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3536B30E891
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 01:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhBDAfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 19:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBDAfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:35:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1571C061573;
        Wed,  3 Feb 2021 16:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WtqSZ5oXvmEMoh+hrHkKFwo4xVGvGfHlBaygywAwMRc=; b=bV/LOyPvR3YFi448R5iR0V9ZkH
        Ifd2R06/CmXMjYSq2kHoj3ImbwBurDCzkOGgDGGLpKqpbYf/Vt8nkFTyC33iFq1+EX7HyGg1Wpoxq
        p7MMaFCswRhLvya4pvflqRE53U7fL/2Fwq4rhadyQiuWI8+NCpvJtzBSJEl+yN1D2zvtZyFYTMfWR
        DxDLmKBYFgVc2z0Nub49BqNHDh87smKk4EJXvJq6LCIhb6DAQYrrdEaQP/FWqHuelDDoOgRH25TDE
        aOTZLDFJLkpRVusKePNwtQyjW4U0ugbf3BERiv0Tc58lBXBmtT/QwLh31xMkoezEe5i4FyrFroKbN
        uQ+R4gPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7SbK-0008gX-8u; Thu, 04 Feb 2021 00:34:26 +0000
Date:   Thu, 4 Feb 2021 00:34:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Minchan Kim <minchan@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: fs: Invalidate BH LRU during page migration
Message-ID: <20210204003426.GC308988@casper.infradead.org>
References: <cover.1612248395.git.cgoldswo@codeaurora.org>
 <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:55:47PM -0800, Chris Goldsworthy wrote:
> @@ -1289,6 +1289,8 @@ static inline void check_irqs_on(void)
>  #endif
>  }
>  
> +bool bh_migration_done = true;

What protects this global variable?  Or is there some subtle reason it
doesn't need protection, in which case, please put that in a comment.

