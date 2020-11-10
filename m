Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565BC2AE1D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 22:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgKJVc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 16:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbgKJVc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:32:59 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A687C0613D1;
        Tue, 10 Nov 2020 13:32:59 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcbG1-00347a-E4; Tue, 10 Nov 2020 21:32:53 +0000
Date:   Tue, 10 Nov 2020 21:32:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201110213253.GV3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104082738.1054792-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:27:33AM +0100, Christoph Hellwig wrote:

>  ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>  {
> -	struct seq_file *m = file->private_data;
> +	struct iovec iov = { .iov_base = buf, .iov_len = size};
> +	struct kiocb kiocb;
> +	struct iov_iter iter;
> +	ssize_t ret;
> +
> +	init_sync_kiocb(&kiocb, file);
> +	iov_iter_init(&iter, READ, &iov, 1, size);
> +
> +	kiocb.ki_pos = *ppos;
> +	ret = seq_read_iter(&kiocb, &iter);
> +	*ppos = kiocb.ki_pos;
> +	return ret;
> +}
> +EXPORT_SYMBOL(seq_read);

This is basically an open-coded copy of new_sync_read()...

>  	if (m->count) {
>  		n = min(m->count, size);
> -		err = copy_to_user(buf, m->buf + m->from, n);
> -		if (err)
> +		if (copy_to_iter(m->buf + m->from, n, iter) != n)
>  			goto Efault;
>  		m->count -= n;
>  		m->from += n;
>  		size -= n;
> -		buf += n;
>  		copied += n;
>  		if (!size)
>  			goto Done;

>  	n = min(m->count, size);
> -	err = copy_to_user(buf, m->buf, n);
> -	if (err)
> +	if (copy_to_iter(m->buf, n, iter) != n)
>  		goto Efault;

This is actually broken from generic_file_splice_read() POV; if you've
already emitted something, you will end up with more data spewed into
pipe than you report to caller.  You want something similar to
copy_to_iter_full() here, with iterator _not_ advanced in case of
failure.  The first call is not an issue (you have no data copied
yet, so you'll end up with -EFAULT, aka "discard everything you've
put there and return -EAGAIN"), but the second really is a problem.

BTW, other ->read_iter() instances might need to be careful with that
pattern as well; drivers/gpu/drm/drm_dp_aux_dev.c:auxdev_read_iter()
would appear to have the same problem.

<greps some more>
                if (unlikely(iov_iter_is_pipe(iter))) {
                        void *addr = kmap_atomic(page);

                        written = copy_to_iter(addr, copy, iter);
                        kunmap_atomic(addr);   
                } else
in fs/cifs/file.c looks... interesting, considering the fact that
copy_to_iter() for pipe destination might very well have to do
allocations.  With GFP_USER.  Under kmap_atomic()...

Note that we have this:
static inline int copy_linear_skb(struct sk_buff *skb, int len, int off,
                                  struct iov_iter *to)
{
        int n;

        n = copy_to_iter(skb->data + off, len, to);
        if (n == len)
                return 0;

        iov_iter_revert(to, n);
        return -EFAULT;
}
i.e. the same "do not advance on short copy" kind of thing.

AFAICS, not all callers want that semantics, but I think it's worth
a new primitive.  I'm not saying it should be a prereq for your
series, but either that or an explicit iov_iter_revert() is needed.
