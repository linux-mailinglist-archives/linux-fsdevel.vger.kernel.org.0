Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF128A083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfHLORD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 10:17:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfHLORD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UnBehz4jsZ/osXbtN5Sf3BgUk5aQQ9ky7AyvIPjJnPM=; b=Vfjr3xcNQ0VvJCHJkkJrwgVf2
        5L05Jtu2C9yCPm5Mcw30uA6FyuRaKbOgqKFh/VEpYDYFL+rfS4ZBMpQcxDtDTz3/38SixZPFOHzvd
        lAJclNwlnMUDaTsONJ5byVzNhinJy0wzLjodHYemwfXS5w0BFcsGC6hXte4OFgwNKpwTaikFdJ+xz
        Z2sRn0cbavt52hSKLgF/+GcwsRkYwFJVh8r+UuOqIIuxOwkCZINMrqUB8aQi8AgRTJlCJPUyIuZLj
        GxLaWfQUZrZdxC7h9zz4hvdmzXeSEXyJmuMHOvIibFbVcn0WtSsAkSPWuNL/q/s8MKAWT04loLsCX
        wjyqUWgxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxB89-00088q-Ve; Mon, 12 Aug 2019 14:17:01 +0000
Date:   Mon, 12 Aug 2019 07:17:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 resend] fs: Add VirtualBox guest shared folder
 (vboxsf) support
Message-ID: <20190812141701.GA31267@infradead.org>
References: <20190811163134.12708-1-hdegoede@redhat.com>
 <20190811163134.12708-2-hdegoede@redhat.com>
 <20190812114926.GB21901@infradead.org>
 <b95eaa46-098d-0954-34b4-a96c7ed7ffa2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95eaa46-098d-0954-34b4-a96c7ed7ffa2@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 03:35:39PM +0200, Hans de Goede wrote:
> > Also these casts to uintptr_t for a call that reads data look very
> > odd.
> 
> Yes, as I already discussed with Al, that is because vboxsf_read
> can be (and is) used with both kernel and userspace buffer pointers.
> 
> In case of a userspace pointer the underlying IPC code to the host takes
> care of copy to / from user for us. That IPC code can also be used from
> userspace through ioctls on /dev/vboxguest, so the handling of both
> in kernel and userspace addresses is something which it must be able
> to handle anyways, at which point we might as well use it in vboxsf too.
> 
> But since both Al and you pointed this out as being ugly, I will add
> 2 separate vboxsf_read_user and vboxsf_read_kernel functions for the
> next version, then the cast (and the true flag) can both go away.

What might be even better is to pass a struct iov_iter to the low-level
function.  That gets you 90% of implementing the read_iter and
write_iter methods, as well as a versatile low-level primite that
can deal with kernel and user address, as well as pages.

> > > +	/* Make sure any pending writes done through mmap are flushed */
> > 
> > Why?
> 
> I believe that if we were doing everything through the page-cache then a regular
> write to the same range as a write done through mmap, with the regular write
> happening after (in time) the mmap write, will overwrite the mmap
> written data, we want the same behavior here.

But what happens if you mmap and write at the same or at least
barely the same time.

> 
> > > +	err = filemap_fdatawait_range(inode->i_mapping, pos, pos + nwritten);
> > > +	if (err)
> > > +		return err;
> > 
> > Also this whole write function seems to miss i_rwsem.
> 
> Hmm, I do not see e.g. v9fs_file_write_iter take that either, nor a couple
> of other similar not block-backed filesystems. Will this still
> be necessary after converting to the iter interfaces?

Yes.

> The problem is that the IPC to the host which we build upon only offers
> regular read / write calls. So the most consistent (also cache coherent)
> mapping which we can offer is to directly mapping read -> read and
> wrtie->write without the pagecache. Ideally we would be able to just
> say sorry cannot do mmap, but too much apps rely on mmap and the
> out of tree driver has this mmap "emulation" which means not offering
> it in the mainline version would be a serious regression.
> 
> In essence this is the same situation as a bunch of network filesystems
> are in and I've looked at several for inspiration. Looking again at
> e.g. v9fs_file_write_iter it does similar regular read -> read mapping
> with invalidation of the page-cache for mmap users.

v9 is probably not a good idea to copy in general.  While not the best
idea to copy directly either I'd rather look at nfs - that is another
protocol without a real distributed lock manager, but at least the
NFS close to open semantics are reasonably well defined and allow using
the pagecache.

> I must admit that I've mostly cargo-culted this from other fs code
> such as the 9p code, or the cifs code which has:
> 
> /*
>  * If the page is mmap'ed into a process' page tables, then we need to make
>  * sure that it doesn't change while being written back.
>  */
> static vm_fault_t
> cifs_page_mkwrite(struct vm_fault *vmf)
> {
>         struct page *page = vmf->page;
> 
>         lock_page(page);
>         return VM_FAULT_LOCKED;
> }
> 
> The if (page->mapping != inode->i_mapping) is used in several places
> including the 9p code, bit as you can see no in the cifs code. I couldn't
> really find a rational for that check, so I'm fine with dropping that check.

If you don't implement ->page_mkwrite the caller will just lock the page
for you..
