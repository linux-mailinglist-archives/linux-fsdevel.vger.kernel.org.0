Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2841B416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhI1Qnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbhI1Qni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:43:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED482C06161C;
        Tue, 28 Sep 2021 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WZIHzocEelFp8OufIzX41zG6IC2iFCm0QYf5egEA+AI=; b=u1HDPNTgGv7XbtgQTpfZqd9EMt
        xHFhyYl5PFwciQXO6WwKozCfWvmNRCBH3p6FJ0e+ehJXr50ItGoKxkP/Al4oULutIFHIYvIpC6Rsh
        Wyibelk5B5a/3aye9oZDkweSh+Cz8K3KlPdsVySGLypu593p0SE8qn8xx/hZO3YJsLmKhKA9E6q9e
        wmNTzkb/u00t9t9zBOdEH6BP18mL7jERfUaGJR1YU9Q4zhbmYYDMb+BEw7B6g1ZY2M9JfdYYx3a/2
        zgLsjpewzwHSHxafEKEz5R23yuj2mbcRSGhacufhS1rLSL2LcoQolz5jiiYml/tJSSeOrVn/xvcVT
        rhCkUe9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVG76-00B1nC-Up; Tue, 28 Sep 2021 16:38:06 +0000
Date:   Tue, 28 Sep 2021 17:37:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fdmanana@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 03/19] gup: Turn fault_in_pages_{readable,writeable}
 into fault_in_{readable,writeable}
Message-ID: <YVNE4HGKPb7bw+En@casper.infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-4-agruenba@redhat.com>
 <CAL3q7H7PdBTuK28tN=3fGUyTP9wJU8Ydrq35YtNsfA_3xRQhzQ@mail.gmail.com>
 <CAHc6FU7rbdJxeuvoz0jov5y_GH_B4AtjkDnbNyOxeeNc1Zw5+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7rbdJxeuvoz0jov5y_GH_B4AtjkDnbNyOxeeNc1Zw5+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:02:43PM +0200, Andreas Gruenbacher wrote:
> On Fri, Sep 3, 2021 at 4:57 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > On Fri, Aug 27, 2021 at 5:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > +size_t fault_in_writeable(char __user *uaddr, size_t size)
> > > +{
> > > +       char __user *start = uaddr, *end;
> > > +
> > > +       if (unlikely(size == 0))
> > > +               return 0;
> > > +       if (!PAGE_ALIGNED(uaddr)) {
> > > +               if (unlikely(__put_user(0, uaddr) != 0))
> > > +                       return size;
> > > +               uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
> > > +       }
> > > +       end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
> > > +       if (unlikely(end < start))
> > > +               end = NULL;
> > > +       while (uaddr != end) {
> > > +               if (unlikely(__put_user(0, uaddr) != 0))
> > > +                       goto out;
> > > +               uaddr += PAGE_SIZE;
> >
> > Won't we loop endlessly or corrupt some unwanted page when 'end' was
> > set to NULL?
> 
> What do you mean? We set 'end' to NULL when start + size < start
> exactly so that the loop will stop when uaddr wraps around.

But think about x86-64.  The virtual address space (unless you have 5
level PTs) looks like:

[0, 2^47)		userspace
[2^47, 2^64 - 2^47)	hole
[2^64 - 2^47, 2^64)	kernel space

If we try to copy from the hole we'll get some kind of fault (I forget
the details).  We have to stop at the top of userspace.
