Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995A3404960
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhIILi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhIILi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:38:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464AC061575;
        Thu,  9 Sep 2021 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fPS8ABV3p1/Cc6qzU5y4vmmF2vrRk2q/3Li1BJ3OVOY=; b=H+oBGp3JjF8wCD9YKCIWRjD64D
        c60kA8H4/8JfQVuMOPr92UZYsMgK52eScn3cIUBTeoQegGP9sC+esrf01Ayo532kOnaRWDsJfxX34
        tQYy9TkblQiC3kXLfKE4W0NHrOuZU1vDOmi3lKigJ4Dk8VFULHA5N/FFYfQc4vZWozbvNcRRIybaV
        BIW6H8sO1w4QetEH/L5auibNq8VcVVWR6NYM0x31uxGCIot9ez9zRri0dmFrj9LfGnPqsfvmONPgf
        EqlbuknP5VNqDpcMZWYZ+hyTF8H3hBNHcpd9AlkLwkYE/8cRbPdxd5mVc1xKKMSdT9oxesP+cN5BE
        KAB524LA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOILm-009lu0-R5; Thu, 09 Sep 2021 11:36:19 +0000
Date:   Thu, 9 Sep 2021 12:36:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 17/19] gup: Introduce FOLL_NOFAULT flag to disable
 page faults
Message-ID: <YTnxruxm/xA/BBmQ@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-18-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-18-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:24PM +0200, Andreas Gruenbacher wrote:
> Introduce a new FOLL_NOFAULT flag that causes get_user_pages to return
> -EFAULT when it would otherwise trigger a page fault.  This is roughly
> similar to FOLL_FAST_ONLY but available on all architectures, and less
> fragile.

So, FOLL_FAST_ONLY only has one single user through
get_user_pages_fast_only (pin_user_pages_fast_only is entirely unused,
which makes totally sense given that give up on fault and pin are not
exactly useful semantics).

But it looks like they want to call it from atomic context, so we can't
really share it.  Sight, I hate all these single-user FOLL flags that
make gup.c a complete mess.

But otherwise this looks fine.
