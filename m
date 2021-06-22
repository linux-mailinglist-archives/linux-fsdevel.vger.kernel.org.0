Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE63B0C93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhFVSLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhFVSLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:11:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A45C06114F;
        Tue, 22 Jun 2021 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4u1NCyaAJJ8fxeYpU8Gk6l5XhQlmfpxfNSoBL7x9hjU=; b=aJ7Lp27qSS9eU0YVfkFs/6IM+l
        vOm9pcgy0M/v1BWlSBTFWibCJsqiIsGsH2Ikhl8ZZw18gUkZAT+TqJjWv6rWzGyB9kKoRihWKBFuE
        YON+ElnCJqFLFsFWHpf16nUklwXeXQaaEIrhxVJXUdCNKfXCf/1t3/V55teOiZMhGZBHaKGv+vZOm
        G6vMCqeL4lpnDdWmPsTdyeTODow4zPRM28Rvm3cUCNXEm2U+K9RprOiDEr9bK+gpGqNoFmzDYQHCn
        ne9RPTW7I0nHh3L6B3BftRe5xspS9jEKwG2DCx/j3F2RKbrNTEtwvmCV8uglJSefFA5siLrRs45t9
        UeMqdmuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvkkk-00EasQ-G3; Tue, 22 Jun 2021 18:04:26 +0000
Date:   Tue, 22 Jun 2021 19:04:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNImEkqizzuStW72@casper.infradead.org>
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk>
 <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
 <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3231150.1624384533@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 06:55:33PM +0100, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > End result: doing the fault_in_readable "unnecessarily" at the
> > beginning is likely the better optimization. It's basically free when
> > it's not necessary, and it avoids an extra fault (and extra
> > lock/unlock and retry) when it does end up faulting pages in.
> 
> It may also cause the read in to happen in the background whilst write_begin
> is being done.

Huh?  Last I checked, the fault_in_readable actually read a byte from
the page.  It has to wait for the read to complete before that can
happen.
