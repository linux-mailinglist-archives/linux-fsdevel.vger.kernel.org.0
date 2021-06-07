Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A254039E8DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGVJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFGVJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 17:09:04 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E43C061574;
        Mon,  7 Jun 2021 14:07:12 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqMSc-005abR-Q6; Mon, 07 Jun 2021 21:07:02 +0000
Date:   Mon, 7 Jun 2021 21:07:02 +0000
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
Message-ID: <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org>
 <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
 <YL5CTiR94f5DYPFK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL5CTiR94f5DYPFK@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:59:10PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 07, 2021 at 02:43:40PM +0000, Al Viro wrote:
> > > It can't even happen for the legacy architectures, given that the
> > > remaining set_fs() areas are small and never do iov_iter based I/O.
> > 
> > 	Umm...  It's a bit trickier than that - e.g. a kernel thread on
> > a CONFIG_SET_FS target passing a kernel pointer to vfs_read() could've
> > ended up with new_sync_write() hitting iov_iter_init().
> 
> Yes, that is a possbility, but rather unlikely - it would require an
> arch-specific thread using iov_iter_init.  iov_iter_init instances are
> rather fewer, and only very few in arch code.

Doesn't have to be in arch code itself (see above re vfs_read()/vfs_write()),
but AFAICS it doesn't happen.

Anyway, what I'm going to do is
void iov_iter_init(struct iov_iter *i, unsigned int direction,
                        const struct iovec *iov, unsigned long nr_segs,
			size_t count)
{
	WARN_ON(direction & ~(READ | WRITE));

        if (WARN_ON(uaccess_kernel())) {
		// shouldn't be any such callers left...
		iov_iter_kvec(i, direction, (const struct kvec *)iov,
			      nr_segs, count);
		return;
	}
	*i = (struct iov_iter) {
		.iter_type = ITER_IOVEC,
		.data_source = direction,
		.iov = iov,
		.nr_segs = nr_segs,
		.iov_offset = 0,
		.count = count
	};
}

and in a cycle or two replace that if (WARN_ON()) into flat BUG_ON()

Linus, can you live with that variant?  AFAICS, we really should have
no such callers left on any targets.
