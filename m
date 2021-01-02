Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380712E860E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jan 2021 03:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbhABCIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jan 2021 21:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbhABCIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jan 2021 21:08:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D5C061573
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jan 2021 18:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Bj2i+mdxjQoyZ5DP+s0xeyewIlRtG8L+lLotgEXPTA=; b=vqliXBs+UanoJM5P13V3/y4UsA
        NdDrHECp2lKC2DqUQ8vDyoykb1yXpyxro+8UwdY4juYCHkD9QrZLyNj0FbnueYzVEaWlhnGxU2MUl
        cgmGHbgFBUAgD/w+1lM6YNlJjGQ9hmbmG5ozS/aZyvzMlHi/h5sN3XWOgnwNfnd7pPwM467hZzjyw
        3cJayHpuUfQf3fUZ5DVCXPLEMFVxVAf7NX/ZxP5Lzganq3zF0SuuwMZkY1SMa8JjmtxSVDie6DXFs
        yDsXMJyat2H2kXCXz3FEbGZTy6bkcKrt9Kk8jWu1qghVlo2KKDFplxv6ajCTFxgjXV2sHhYQii8Zs
        DCcC2eEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kvWKL-002JWS-9F; Sat, 02 Jan 2021 02:07:34 +0000
Date:   Sat, 2 Jan 2021 02:07:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcapsc@gmail.com>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: problem with orangefs readpage...
Message-ID: <20210102020733.GA431927@casper.infradead.org>
References: <CAOg9mSQkkZtqBND-HKb2oSB8jxT6bkQU1LuExo0hPsEUhcMrPw@mail.gmail.com>
 <20210101040808.GB18640@casper.infradead.org>
 <CAAoczXbw9A+kqMemEsJax+CaPkQsJzZNw6Y7XFhTsBqDnGD6hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoczXbw9A+kqMemEsJax+CaPkQsJzZNw6Y7XFhTsBqDnGD6hw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 01, 2021 at 05:15:32PM -0500, Mike Marshall wrote:
> Hi Matthew... Thanks so much for the suggestions!
> > This is some new version of orangefs_readpage(), right?
> No, that code has been upstream for a while... that readahead_control
> thing looks very interesting :-) ...

Oh, my, I was looking at a tree from before 2018 that still had
orangefs_readpages.  So, yes, I think what's happening is that
orangefs_readpage() is being called from the readahead code.
You'll hit this path:

                        next_page = find_get_page(inode->i_mapping, index);
                        if (next_page) {
                                gossip_debug(GOSSIP_FILE_DEBUG,
                                        "%s: found next page, quitting\n",
                                        __func__);
                                put_page(next_page);
                                goto out;

because readahead already allocated those pages for you and is trying
to fill them one-at-a-time.

Implementing ->readahead, even without dhowells' patch to expand
the ractl will definitely help you!

> -Mike
> 
> On Thu, Dec 31, 2020 at 11:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Dec 31, 2020 at 04:51:53PM -0500, Mike Marshall wrote:
> > > Greetings...
> > >
> > > I hope some of you will suffer through reading this long message :-) ...
> >
> > Hi Mike!  Happy New Year!
> >
> > > Orangefs isn't built to do small IO. Reading a
> > > big file in page cache sized chunks is slow and painful.
> > > I tried to write orangefs_readpage so that it would do a reasonable
> > > sized hard IO, fill the page that was being called for, and then
> > > go ahead and fill a whole bunch of the following pages into the
> > > page cache with the extra data in the IO buffer.
> >
> > This is some new version of orangefs_readpage(), right?  I don't see
> > anything resembling this in the current codebase.  Did you disable
> > orangefs_readpages() as part of this work?  Because the behaviour you're
> > describing sounds very much like what the readahead code might do to a
> > filesystem which implements readpage and neither readahead nor readpages.
> >
> > > orangefs_readpage gets called for the first four pages and then my
> > > prefill kicks in and fills the next pages and the right data ends
> > > up in /tmp/nine. I, of course, wished and planned for orangefs_readpage
> > > to only get called once, I don't understand why it gets called four
> > > times, which results in three extraneous expensive hard IOs.
> >
> > I might suggest some judicious calling of dump_stack() to understand
> > exactly what's calling you.  My suspicion is that it's this loop in
> > read_pages():
> >
> >                 while ((page = readahead_page(rac))) {
> >                         aops->readpage(rac->file, page);
> >                         put_page(page);
> >                 }
> >
> > which doesn't test for PageUptodate before calling you.
> >
> > It'd probably be best if you implemented ->readahead, which has its own
> > ideas about which pages would be the right ones to read.  It's not always
> > correct, but generally better to have that logic in the VFS than in each
> > filesystem.
> >
> > You probably want to have a look at Dave Howells' work to allow
> > the filesystem to expand the ractl:
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> >
> > specifically this patch:
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-iter&id=f582790b32d5d1d8b937df95a8b2b5fdb8380e46
> >
