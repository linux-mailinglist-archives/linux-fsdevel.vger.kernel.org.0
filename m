Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25FE39D8BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFGJax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGJaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE0C061766;
        Mon,  7 Jun 2021 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3ilKjog+LD2m6MlB+TLyrrS26QUsGDSfne3lHiiEnA=; b=npTPY5ylAi3bxcJDFZgkrzGR4m
        KOqyRTuOH6X6RtZyOQNF/koOtabqvl4WWe4z0U5fkBRrDP++dBfhxeJP6pFAxBOsh+bNd+fhETJMT
        /iPWsT8J+rkMWvJVmEmPWPw+Es2jowG5HuRmUM0f0mQ78RJgIN1FT4d83exar1ExLBpVrWn+ALF2N
        eqtjYGVqNE6wc93Lv8xqWlOMtSEsjcZLalYqWIffu71RFr3wWzYMCOhkypmycXqRf2K0goj9/ikZ9
        yLNIGK43u05KLpBUCOg7Y7tWf9oU5ixmipHj3dkj/92HpZgLfCtNJPd1KXLemJ3qXCykkV37cYQvD
        XxP8bCqw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqBYj-00Fa3N-9T; Mon, 07 Jun 2021 09:28:40 +0000
Date:   Mon, 7 Jun 2021 10:28:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YL3mxdEc7uw4rhjn@infradead.org>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 06, 2021 at 03:46:37PM -0700, Linus Torvalds wrote:
> And yes, I realize that 'uaccess_kernel()' is hopefully always false
> on any architectures we care about and so the compiler would just pick
> one at compile time rather than actually having both those
> initializers.
> 
> But I think that "the uaccess_kernel() KVEC case is legacy for
> architectures that haven't converted to the new world order yet" thing
> is just even more of an argument for not duplicating and writing the
> code out in full on a source level (and making that normal case be
> ".iov = iov").

It can't even happen for the legacy architectures, given that the
remaining set_fs() areas are small and never do iov_iter based I/O.
