Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6234342B95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 11:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCTKv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 06:51:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCTKvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 06:51:19 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNYTP-0004Ud-8g; Sat, 20 Mar 2021 10:04:47 +0000
Date:   Sat, 20 Mar 2021 11:04:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v8 01/10] iov_iter: add copy_struct_from_iter()
Message-ID: <20210320100446.g5jysruamqklzzb5@wittgenstein>
References: <cover.1615922644.git.osandov@fb.com>
 <e71e712d27b2e2c19efc5b1454bd8581ad98d900.1615922644.git.osandov@fb.com>
 <20210317175611.adntftl6w3avptvk@wittgenstein>
 <YFJOLlm3GuZgoVSi@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFJOLlm3GuZgoVSi@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:45:02AM -0700, Omar Sandoval wrote:
> On Wed, Mar 17, 2021 at 06:56:11PM +0100, Christian Brauner wrote:
> > On Tue, Mar 16, 2021 at 12:42:57PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > This is essentially copy_struct_from_user() but for an iov_iter.
> > > 
> > > Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  include/linux/uio.h |  2 ++
> > >  lib/iov_iter.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 84 insertions(+)
> > > 
> > > diff --git a/include/linux/uio.h b/include/linux/uio.h
> > > index 72d88566694e..f4e6ea85a269 100644
> > > --- a/include/linux/uio.h
> > > +++ b/include/linux/uio.h
> > > @@ -121,6 +121,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
> > >  			 struct iov_iter *i);
> > >  size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
> > >  			 struct iov_iter *i);
> > > +int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
> > > +			  size_t usize);
> > >  
> > >  size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
> > >  size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
> > > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > > index a21e6a5792c5..f45826ed7528 100644
> > > --- a/lib/iov_iter.c
> > > +++ b/lib/iov_iter.c
> > > @@ -948,6 +948,88 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
> > >  }
> > >  EXPORT_SYMBOL(copy_page_from_iter);
> > >  
> > > +/**
> > > + * copy_struct_from_iter - copy a struct from an iov_iter
> > > + * @dst: Destination buffer.
> > > + * @ksize: Size of @dst struct.
> > > + * @i: Source iterator.
> > > + * @usize: (Alleged) size of struct in @i.
> > > + *
> > > + * Copies a struct from an iov_iter in a way that guarantees
> > > + * backwards-compatibility for struct arguments in an iovec (as long as the
> > > + * rules for copy_struct_from_user() are followed).
> > > + *
> > > + * The recommended usage is that @usize be taken from the current segment:
> > > + *
> > > + *   int do_foo(struct iov_iter *i)
> > > + *   {
> > > + *     size_t usize = iov_iter_single_seg_count(i);
> > > + *     struct foo karg;
> > > + *     int err;
> > > + *
> > > + *     if (usize > PAGE_SIZE)
> > > + *       return -E2BIG;
> > > + *     if (usize < FOO_SIZE_VER0)
> > > + *       return -EINVAL;
> > > + *     err = copy_struct_from_iter(&karg, sizeof(karg), i, usize);
> > > + *     if (err)
> > > + *       return err;
> > > + *
> > > + *     // ...
> > > + *   }
> > > + *
> > > + * Return: 0 on success, -errno on error (see copy_struct_from_user()).
> > > + *
> > > + * On success, the iterator is advanced @usize bytes. On error, the iterator is
> > > + * not advanced.
> > > + */
> > > +int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
> > > +			  size_t usize)
> > > +{
> > > +	if (usize <= ksize) {
> > > +		if (!copy_from_iter_full(dst, usize, i))
> > > +			return -EFAULT;
> > > +		memset(dst + usize, 0, ksize - usize);
> > > +	} else {
> > > +		size_t copied = 0, copy;
> > > +		int ret;
> > > +
> > > +		if (WARN_ON(iov_iter_is_pipe(i)) || unlikely(i->count < usize))
> > > +			return -EFAULT;
> > > +		if (iter_is_iovec(i))
> > > +			might_fault();
> > > +		iterate_all_kinds(i, usize, v, ({
> > > +			copy = min(ksize - copied, v.iov_len);
> > > +			if (copy && copyin(dst + copied, v.iov_base, copy))
> > > +				return -EFAULT;
> > > +			copied += copy;
> > > +			ret = check_zeroed_user(v.iov_base + copy,
> > > +						v.iov_len - copy);
> > > +			if (ret <= 0)
> > > +				return ret ?: -E2BIG;
> > > +			0;}), ({
> > > +			char *addr = kmap_atomic(v.bv_page);
> > > +			copy = min_t(size_t, ksize - copied, v.bv_len);
> > > +			memcpy(dst + copied, addr + v.bv_offset, copy);
> > > +			copied += copy;
> > > +			ret = memchr_inv(addr + v.bv_offset + copy, 0,
> > > +					 v.bv_len - copy) ? -E2BIG : 0;
> > > +			kunmap_atomic(addr);
> > > +			if (ret)
> > > +				return ret;
> > > +			}), ({
> > > +			copy = min(ksize - copied, v.iov_len);
> > > +			memcpy(dst + copied, v.iov_base, copy);
> > > +			if (memchr_inv(v.iov_base, 0, v.iov_len))
> > > +				return -E2BIG;
> > > +			})
> > > +		)
> > 
> > 
> > Following the semantics of copy_struct_from_user() is certainly a good
> > idea but can this in any way be rewritten to not look like this; at
> > least not as crammed. It's a bit painful to follow here what's going.
> 
> I think that's just the nature of the iov_iter code :) I'm just
> following the rest of this file, which uses some mind-expanding macros.
> Do you have any suggestions for how to clean this function up?

I think the follow-up discussion this triggered caused an improvement now. :)
Christian
