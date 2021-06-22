Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712863B0D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhFVSjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhFVSjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:39:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E02C061574;
        Tue, 22 Jun 2021 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZyyOQJC5AkmlnIUMiV1fpY23WHIZqnkcqStd28Qh6PI=; b=Jq3BKYpcGxlCzsbHxXq+Pr9zgU
        ei3KP85EWqFj2ho5yopI3JYR+LSNafUe28wTQ6Y6ui+v+wbDQ+lsHIhySNRIJxxTbdLenk4ggAViZ
        O2c9pow5liOMzC8D0FSQdGKnaPABHJTyvL/oyNp1rxY109jSwyBCBnd5Q/KeyEobme5+/hgAV94MC
        1vLXyxV3Yh+9uyezHDBYC4KGM4sd3hKPzgfaiD9Pobe8HdfPYojrDWlh8Z5gCz/OFDgXjAUxwQcbW
        AhDJY35HL5SMXZ4V4M+PREJGPKX2Zw4auyVRezgQDwCyGZ6j7nCugUjhpw0FTwamZSCbU5qOgX1or
        0xmCjeZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvlG6-00Ed9x-Jm; Tue, 22 Jun 2021 18:36:32 +0000
Date:   Tue, 22 Jun 2021 19:36:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNItqqZA9Y1wOnZY@casper.infradead.org>
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk>
 <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
 <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk>
 <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
 <YNIqjhsvEms6+vk9@casper.infradead.org>
 <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:28:30AM -0700, Linus Torvalds wrote:
> On Tue, Jun 22, 2021 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > It wouldn't be _that_ bad necessarily.  filemap_fault:
> 
> It's not actually the mm code that is the biggest problem. We
> obviously already have readahead support.
> 
> It's the *fault* side.
> 
> In particular, since the fault would return without actually filling
> in the page table entry (because the page isn't ready yet, and you
> cannot expose it to other threads!), you also have to jump over the
> instruction that caused this all.

Oh, I was assuming that it'd be a function call like
get_user_pages_fast(), not an instruction that was specially marked to
be jumped over.  Gag reflex diminishing now?

