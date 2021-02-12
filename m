Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BDF31A76C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 23:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBLWUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 17:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLWUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:20:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE614C061756;
        Fri, 12 Feb 2021 14:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RVK/AN6AEBmpXPega/cXcOXam0ZuYymejv9R+QiYt4U=; b=TPv4QhW0okuknx5KfPHQslKmIk
        Bk32+7pfv8cUQ+xYTvyMh2TFy5dsd0TRepl2SDYfBlIN6QV1eVicZy+B1d4hP/WS7bf44kxhj/u6e
        ZNn2Ty5TIejtLL3TmpLcjxcTiILo6hepKY+pbOBYu6ul74pYHnN10Ozucc3tMUs21mRZw2Ey2/uZJ
        t/dGPJX23+pTDYQvWUdzH9oZ2+Nmm8FZi3EYffEDGQULIjwQuHPOWt+Vct9gBnS2dMugMKs/0bre9
        mT+CQVT54eIOIFxbej6RteK4K1+yTNHRynL3fag3cgUxgPEzabo2mdY3fBFEmFs7GRJpikSLXFRjn
        I/s8QTuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAgmU-00CCMm-95; Fri, 12 Feb 2021 22:19:19 +0000
Date:   Fri, 12 Feb 2021 22:19:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
Message-ID: <20210212221918.GA2858050@casper.infradead.org>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
 <m1im6x0wtv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1im6x0wtv.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:01:48PM -0600, Eric W. Biederman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > Convert S_<FOO> permissions to the more readable octal.
> >
> > Done using:
> > $ ./scripts/checkpatch.pl -f --fix-inplace --types=SYMBOLIC_PERMS fs/proc/*.[ch]
> >
> > No difference in generated .o files allyesconfig x86-64
> >
> > Link:
> > https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
> 
> 
> I will be frank.  I don't know what 0644 means.  I can never remember
> which bit is read, write or execute.  So I like symbolic constants.

Heh, I'm the other way, I can't remember what S_IRUGO means.

but I think there's another way which improves the information
density:

#define DIR_RO_ALL(NAME, iops, fops)	DIR(NAME, 0555, iops, fops)
...
(or S_IRUGO or whatever expands to 0555)

There's really only a few combinations --
	root read-only,
	everybody read-only
	root-write, others-read
	everybody-write

and execute is only used by proc for directories, not files, so I think
there's only 8 combinations we'd need (and everybody-write is almost
unused ...)

> Perhaps we can do something like:
> 
> #define S_IRWX 7
> #define S_IRW_ 6
> #define S_IR_X 5
> #define S_IR__ 4
> #define S_I_WX 3
> #define S_I_W_ 2
> #define S_I__X 1
> #define S_I___ 0
> 
> #define MODE(TYPE, USER, GROUP, OTHER) \
> 	(((S_IF##TYPE) << 9) | \
>          ((S_I##USER)  << 6) | \
>          ((S_I##GROUP) << 3) | \
>          (S_I##OTHER))
> 
> Which would be used something like:
> MODE(DIR, RWX, R_X, R_X)
> MODE(REG, RWX, R__, R__)
> 
> Something like that should be able to address the readability while
> still using symbolic constants.

I think that's been proposed before.
