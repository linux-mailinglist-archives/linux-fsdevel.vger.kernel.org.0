Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B535404900
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhIILMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhIILMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:12:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D1C061575;
        Thu,  9 Sep 2021 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Px05a8oX7TB9LNqdiKccha6Ty68j1DakKrgzz154FJ4=; b=uNC1B6KfWxZ5MirPlWNm0FWy1W
        wHfgm7FiRVQ5r47H8bBJ57z3lfVyGRAv0ru1wioZNLUaxUPHqCKAUiiwa6FhAsOmi/4nZzsR+hhbC
        2ugctxWgzI8wuQdUye0toOLXpg8X3uCCaLY3OvsWsQjp0NZAnDL0TBh782mwDHOIV5H9j5c/bESI/
        frOJgEH0wbG/9NyP+IBioVw9xKmNaodJdzvLv1MGtJgqpbI4YcoaFe62C+ekKmTm+VdxT9vV5K3bG
        KgzNXEJs2o4wi1ruyMpGYfMtrahoFFKMOyJNJteSjJX906JV1rnl0a899VcHRkUjSs8un3Ymq9/4R
        WFuVfGng==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOHwN-009kWU-38; Thu, 09 Sep 2021 11:10:05 +0000
Date:   Thu, 9 Sep 2021 12:09:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 01/19] iov_iter: Fix iov_iter_get_pages{,_alloc} page
 fault return value
Message-ID: <YTnrh2AUzActMoxl@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-2-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:08PM +0200, Andreas Gruenbacher wrote:
> Both iov_iter_get_pages and iov_iter_get_pages_alloc return the number
> of bytes of the iovec they could get the pages for.  When they cannot
> get any pages, they're supposed to return 0, but when the start of the
> iovec isn't page aligned, the calculation goes wrong and they return a
> negative value.  Fix both functions.
> 
> In addition, change iov_iter_get_pages_alloc to return NULL in that case
> to prevent resource leaks.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
