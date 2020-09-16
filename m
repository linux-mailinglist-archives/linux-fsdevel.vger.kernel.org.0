Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101126BBBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 07:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIPFVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 01:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:21:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081BC06174A;
        Tue, 15 Sep 2020 22:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Hrrl2YETgQJ18Mz1U8xxlDYud6hDQ7zBp3JCuVggPw=; b=s70emVkAQH2kuz+hYMjOjppFaz
        F1vOeln/Wbn46zef2EvyFVo0mjopnkBIJf4sTbbD5nQJRC5gIlKsTkwjclVWi19c79juGkVg3WgA0
        kfRdab9r/L47O1QWDwhi43xUL5G4+Vhff+QXP0gbHov+VFRRRfC9aYO9H3rhk5KFDbxr5TOqsmObu
        /vL8K8EhuRdSsepWbdmDb2QkXL9oiEAF7kGbFuzbNf/Wbn1B/7wMPUUORpX735qvLTxpReZ5JLW/D
        PsTKTwiixhsUDdFH1Kdh6h1myAdLtk2FtcXnn/BAJPr3E84RxyjY9y3Dym9mRnAIf+F7+K36dZJMX
        wg5EC0/g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIPsk-0003YW-VP; Wed, 16 Sep 2020 05:21:27 +0000
Date:   Wed, 16 Sep 2020 06:21:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 2/2] fs: Do not update nr_thps for mappings which support
 THPs
Message-ID: <20200916052126.GA12923@infradead.org>
References: <20200916032717.22917-1-willy@infradead.org>
 <20200916032717.22917-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916032717.22917-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 04:27:17AM +0100, Matthew Wilcox (Oracle) wrote:
> The nr_thps counter is to support THPs in the page cache when the
> filesystem doesn't understand THPs.  Eventually it will be removed, but
> we should still support filesystems which do not understand THPs yet.
> Move the nr_thp manipulation functions to filemap.h since they're
> page-cache specific.

Honestly I don't think we should support the read-only THP crap.  We
should in fact never have merged that bandaid to start with given that
you did good progress on the real thing.
