Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308D49D580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 23:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiAZWfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 17:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAZWfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:35:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD12C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=czEgEE0p8FWVV54NqFyujRjTBh35gkIdbYekZFplHkI=; b=IhfX/Da7DKSlQtI4yB+nLehwPo
        REZN7VGUPfu8iWfm4UAqsUFm3BePHHfYnxFYnI7mGB6Qesjj++TirECzIdAlNr/6GytNNJgoffUan
        +e0w0EnQFGfRgveB8cB7O6Ylqidaqr1aKdMfpLBSfBVK/hoK2ZmXHGZp8XdmYViNal4MfhH1gMf4D
        ZJ7dm6rSeki8Pbm/pqK4m0qr3JCm/ssS0pB6O7/3Ot+/Wsk29+ICRXUFnZp1e2NOx/XcihlLs5fkp
        tav9Q4ZK2SUh2v0dWNv82lFpzhQekKaHxLWlI1n1po7S6kAAXWdvpRhsHbKhpx+QBy+9i0uThGoVx
        jbHfMJKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCqsp-004XNu-66; Wed, 26 Jan 2022 22:35:19 +0000
Date:   Wed, 26 Jan 2022 22:35:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hayley Leblanc <hleblanc@utexas.edu>
Cc:     linux-fsdevel@vger.kernel.org, rust-for-linux@vger-kernel.org,
        Vijay Chidambaram <vijayc@utexas.edu>
Subject: Re: Persistent memory file system development in Rust
Message-ID: <YfHMp+zhEjrMHizL@casper.infradead.org>
References: <CAFadYX5iw4pCJ2L4s5rtvJCs8mL+tqk=5+tLVjSLOWdDeo7+MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFadYX5iw4pCJ2L4s5rtvJCs8mL+tqk=5+tLVjSLOWdDeo7+MQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:02:56PM -0600, Hayley Leblanc wrote:
> I'm a PhD student at UT Austin advised by Vijay Chidambaram (cc'ed).
> We are interested in building a file system for persistent memory in
> Rust, as recent research [1] has indicated that Rust's safety features
> could eliminate some classes of crash consistency bugs in PM systems.
> In doing so, we'd like to build a system that has the potential to be
> adopted beyond the research community. I have a few questions (below)
> about the direction of work in this area within the Linux community,
> and would be interested in hearing your thoughts on the general idea
> of this project as well.

Hi Hayley,

Thanks for reaching out to us.

First, my standard advice for anyone thinking of writing a Linux
filesystem: Absolutely do it; you'll learn so much, and it's a great deal
of fun.  Then my standard advice for anyone thinking about releasing a
Linux filesystem: Think very carefully about whether you want to do it.
If you're lucky, it's only about as much work as adopting a puppy.
If you're unlucky, it's like adopting a parrot; far more work and it
may outlive you.

In particular, the demands of academia (generate novel insights, write
as many papers as possible, get your PhD) are at odds with the demands
of a production filesystem (move slowly, don't break anything, DON'T
LOSE USER DATA).  You wouldn't be the first person to try to do both,
but I think you might be the first person to be successful.

There's nothing wrong with having written an academic filesystem
that you learned things from.  I think I've written three filesystems
myself that have never seen a public release -- and I'm totally fine
with that.

> 1. What is the state of PM file system development in the kernel? I
> know that there was some effort to merge NOVA [2] and nvfs [3] in the
> last few years, but neither seems to have panned out.

Correct.  I'm not aware of anything else currently under development.
I'd file both those filesystems under "Things people tried and learned
things from", although maybe there'll be a renewed push to get one
or the other merged.

> 2. What is the state of file system work, if any, on the Rust for
> Linux side of things?

I only have a toe in Rust development, but I'm not aware of
any work being done specifically for filesystems, that said ...

> 3. We're interested in using a framework called Bento [4] as the basis
> for our file system development. Is this project on Linux devs' radar?
> What are the rough chances that this work (or something similar) could
> end up in the kernel at some point?

Bento seems like a good approach (based on a 30 second scan of their
git repo).  It wasn't on my radar before, so thanks for bringing it up.
I think basing your work on Bento is a defensible choice; it might be
wrong, but the only way to find out is to try.

All this is just my opinion, and it's worth exactly what you're paying
for it.  I have no say in what gets merged and what doesn't, and I
decided academia was not for me after getting my BSc.  I hope it all
works out for you, and we end up seeing your paper(s) in FAST.
