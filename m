Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0C2E82E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jan 2021 05:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbhAAEIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Dec 2020 23:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbhAAEIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Dec 2020 23:08:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B0C061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Dec 2020 20:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TOG64ho11HP0VppbDk/f9ke+cHTRQUCyUm/vFGW2q8M=; b=p/91M4L/wI/WkYMnYzA8/uI0hH
        FsEF/gqXDk2SPbykVnIx+okDZdWX6S2uCthq783sYXQu+BGBUaAdZ5Vtd2BgY2QxA0dA1uT2IswLy
        8JXpNH3yAbtR8fwEWBW9qvlXXtNl0wXo1IH+La7DTjkYSQE/2qE724PiNWxGocxpxZeVImsNuIwsd
        +jh4C/PxeMUnhSLDkMUElJIA3paWAA6c+cvYdes06QhisWfzMUSENFEh0aMOVUUO2pDdtrUqaS3I7
        MCxar6rdNg/ZUBagkAeas8AtXaZR0dABXdJD/b1oZRVJQawx/ZYcpmIXjjbZiCXLIMMXf2T6/8KDd
        xz9CqK9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kvBjU-001OQ9-D2; Fri, 01 Jan 2021 04:08:09 +0000
Date:   Fri, 1 Jan 2021 04:08:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>
Subject: Re: problem with orangefs readpage...
Message-ID: <20210101040808.GB18640@casper.infradead.org>
References: <CAOg9mSQkkZtqBND-HKb2oSB8jxT6bkQU1LuExo0hPsEUhcMrPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSQkkZtqBND-HKb2oSB8jxT6bkQU1LuExo0hPsEUhcMrPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 04:51:53PM -0500, Mike Marshall wrote:
> Greetings...
> 
> I hope some of you will suffer through reading this long message :-) ...

Hi Mike!  Happy New Year!

> Orangefs isn't built to do small IO. Reading a
> big file in page cache sized chunks is slow and painful.
> I tried to write orangefs_readpage so that it would do a reasonable
> sized hard IO, fill the page that was being called for, and then
> go ahead and fill a whole bunch of the following pages into the
> page cache with the extra data in the IO buffer.

This is some new version of orangefs_readpage(), right?  I don't see
anything resembling this in the current codebase.  Did you disable
orangefs_readpages() as part of this work?  Because the behaviour you're
describing sounds very much like what the readahead code might do to a
filesystem which implements readpage and neither readahead nor readpages.

> orangefs_readpage gets called for the first four pages and then my
> prefill kicks in and fills the next pages and the right data ends
> up in /tmp/nine. I, of course, wished and planned for orangefs_readpage
> to only get called once, I don't understand why it gets called four
> times, which results in three extraneous expensive hard IOs.

I might suggest some judicious calling of dump_stack() to understand
exactly what's calling you.  My suspicion is that it's this loop in
read_pages():

                while ((page = readahead_page(rac))) {
                        aops->readpage(rac->file, page);
                        put_page(page);
                }

which doesn't test for PageUptodate before calling you.

It'd probably be best if you implemented ->readahead, which has its own
ideas about which pages would be the right ones to read.  It's not always correct, but generally better to have that logic in the VFS than in each filesystem.

You probably want to have a look at Dave Howells' work to allow
the filesystem to expand the ractl:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

specifically this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-iter&id=f582790b32d5d1d8b937df95a8b2b5fdb8380e46
