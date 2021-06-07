Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183E939DF02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFGOpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFGOpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:45:38 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91055C061766;
        Mon,  7 Jun 2021 07:43:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqGTc-005UWf-Io; Mon, 07 Jun 2021 14:43:40 +0000
Date:   Mon, 7 Jun 2021 14:43:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3mxdEc7uw4rhjn@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:28:37AM +0100, Christoph Hellwig wrote:
> On Sun, Jun 06, 2021 at 03:46:37PM -0700, Linus Torvalds wrote:
> > And yes, I realize that 'uaccess_kernel()' is hopefully always false
> > on any architectures we care about and so the compiler would just pick
> > one at compile time rather than actually having both those
> > initializers.
> > 
> > But I think that "the uaccess_kernel() KVEC case is legacy for
> > architectures that haven't converted to the new world order yet" thing
> > is just even more of an argument for not duplicating and writing the
> > code out in full on a source level (and making that normal case be
> > ".iov = iov").
> 
> It can't even happen for the legacy architectures, given that the
> remaining set_fs() areas are small and never do iov_iter based I/O.

	Umm...  It's a bit trickier than that - e.g. a kernel thread on
a CONFIG_SET_FS target passing a kernel pointer to vfs_read() could've
ended up with new_sync_write() hitting iov_iter_init().

	AFAICS, we don't have any instances of that, but it's not
as simple as "we don't do any iov_iter work under set_fs(KERNEL_DS)"
