Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9B39E158
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFGQBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 12:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGQBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:01:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF69C061766;
        Mon,  7 Jun 2021 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KBGLaC2sxDi2TgP5A87e+zrE0ZBFQFcgfy0ErG7XGd4=; b=lLxM9giupcKjQNjrxgGZxnGavb
        Sq5oJmkSMQJclCVnVoXdn49dKYr70RyUWRvyiSWjVlmzVqrsNehwEOVrCL6yfWeUyx/QdpekZAyY+
        b0JfFvYQONqJ2+Xjl9zJBoMzw7frYAhmlEqL+MVQ1MUFEIQp62PbidBN9Hk0P0sfuWUxDjYwP37F3
        Yk+XmQKv0K/4WoFaU+xL5Mj2qxX1gXc/08b8y7rd1LS0/p3yX4bPlPjIB097bvjIgYvs/9SHftAQT
        9dv/PR9HL2tzQu9wwdaKCM+VnBrGCkBZB5/+DFCfGBbD18dZqaq+s85JNPZU/gwmWiATMlmcRpWEJ
        Mv9CkjYQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqHeg-00FyIH-U8; Mon, 07 Jun 2021 15:59:13 +0000
Date:   Mon, 7 Jun 2021 16:59:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YL5CTiR94f5DYPFK@infradead.org>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org>
 <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:43:40PM +0000, Al Viro wrote:
> > It can't even happen for the legacy architectures, given that the
> > remaining set_fs() areas are small and never do iov_iter based I/O.
> 
> 	Umm...  It's a bit trickier than that - e.g. a kernel thread on
> a CONFIG_SET_FS target passing a kernel pointer to vfs_read() could've
> ended up with new_sync_write() hitting iov_iter_init().

Yes, that is a possbility, but rather unlikely - it would require an
arch-specific thread using iov_iter_init.  iov_iter_init instances are
rather fewer, and only very few in arch code.

> 	AFAICS, we don't have any instances of that, but it's not
> as simple as "we don't do any iov_iter work under set_fs(KERNEL_DS)"

Indeed.
