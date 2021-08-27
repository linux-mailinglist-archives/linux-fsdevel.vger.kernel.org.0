Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4488D3F9F9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhH0TJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:09:33 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42624 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhH0TJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:09:32 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJhDO-00GZVm-U4; Fri, 27 Aug 2021 19:08:34 +0000
Date:   Fri, 27 Aug 2021 19:08:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 03/19] gup: Turn fault_in_pages_{readable,writeable}
 into fault_in_{readable,writeable}
Message-ID: <YSk4Mvbyp8lxPfPF@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-4-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:10PM +0200, Andreas Gruenbacher wrote:
> Turn fault_in_pages_{readable,writeable} into versions that return the
> number of bytes not faulted in (similar to copy_to_user) instead of
> returning a non-zero value when any of the requested pages couldn't be
> faulted in.  This supports the existing users that require all pages to
> be faulted in as well as new users that are happy if any pages can be
> faulted in at all.
> 
> Neither of these functions is entirely trivial and it doesn't seem
> useful to inline them, so move them to mm/gup.c.
> 
> Rename the functions to fault_in_{readable,writeable} to make sure that
> this change doesn't silently break things.

I'm sorry, but this is wrong.  The callers need to be reviewed and
sanitized.  You have several oddball callers (most of them simply
wrong) *and* the ones on a very hot path in write(2).  And _there_
the existing behaviour does the wrong thing for memory poisoning setups.

	Do we have *any* cases where we both need the fault-in at all *and*
would not be better off with "fail only if the first byte couldn't have been
faulted in"?

> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 0608581967f0..38c3eae40c14 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1048,7 +1048,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  	if (new_ctx == NULL)
>  		return 0;
>  	if (!access_ok(new_ctx, ctx_size) ||
> -	    fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
> +	    fault_in_readable((char __user *)new_ctx, ctx_size))
>  		return -EFAULT;

This is completely pointless.  Look at do_setcontext() there.  Seriously,
it immediately does
        if (!user_read_access_begin(ucp, sizeof(*ucp)))
			return -EFAULT;
so this access_ok() is so much garbage.  Then it does normal unsage_get_...()
stuff, so it doesn't need that fault-in crap at all - it *must* handle
copyin failures, fault-in or not.  Just lose that fault_in_... call and be
done with that.


> @@ -1237,7 +1237,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
>  #endif
>  
>  	if (!access_ok(ctx, sizeof(*ctx)) ||
> -	    fault_in_pages_readable((u8 __user *)ctx, sizeof(*ctx)))
> +	    fault_in_readable((char __user *)ctx, sizeof(*ctx)))
>  		return -EFAULT;

Ditto.

> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 1831bba0582e..9f471b4a11e3 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -688,7 +688,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>  	if (new_ctx == NULL)
>  		return 0;
>  	if (!access_ok(new_ctx, ctx_size) ||
> -	    fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
> +	    fault_in_readable((char __user *)new_ctx, ctx_size))
>  		return -EFAULT;

... and again.

> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..9233ecc31e2e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2244,9 +2244,8 @@ static noinline int search_ioctl(struct inode *inode,
>  	key.offset = sk->min_offset;
>  
>  	while (1) {
> -		ret = fault_in_pages_writeable(ubuf + sk_offset,
> -					       *buf_size - sk_offset);
> -		if (ret)
> +		ret = -EFAULT;
> +		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
>  			break;

Really?

> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 25dfc48536d7..069cedd9d7b4 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -191,7 +191,7 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
>  	buf = iov->iov_base + skip;
>  	copy = min(bytes, iov->iov_len - skip);
>  
> -	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_pages_writeable(buf, copy)) {
> +	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy)) {

Here we definitely want "fail only if nothing could be faulted in"

>  		kaddr = kmap_atomic(page);
>  		from = kaddr + offset;
>  
> @@ -275,7 +275,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
>  	buf = iov->iov_base + skip;
>  	copy = min(bytes, iov->iov_len - skip);
>  
> -	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_pages_readable(buf, copy)) {
> +	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy)) {

Same.

> @@ -446,13 +446,11 @@ int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes)
>  			bytes = i->count;
>  		for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
>  			size_t len = min(bytes, p->iov_len - skip);
> -			int err;
>  
>  			if (unlikely(!len))
>  				continue;
> -			err = fault_in_pages_readable(p->iov_base + skip, len);
> -			if (unlikely(err))
> -				return err;
> +			if (fault_in_readable(p->iov_base + skip, len))
> +				return -EFAULT;

... and the same, except that here we want failure only if nothing had already
been faulted in.
