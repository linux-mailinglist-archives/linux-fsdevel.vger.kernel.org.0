Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9840700E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhIJQ5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 12:57:44 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:41878 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIJQ5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:57:42 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOjpE-002whY-NL; Fri, 10 Sep 2021 16:56:28 +0000
Date:   Fri, 10 Sep 2021 16:56:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:06:25AM -0600, Jens Axboe wrote:

> Looks something like this. Not super pretty in terms of needing a define
> for this, and maybe I'm missing something, but ideally we'd want it as
> an anonymous struct that's defined inside iov_iter. Anyway, gets the
> point across. Alternatively, since we're down to just a few members now,
> we just duplicate them in each struct...
> 
> Would be split into two patches, one for the iov_state addition and
> the save/restore helpers, and then one switching io_uring to use them.
> Figured we'd need some agreement on this first...

> +#define IOV_ITER_STATE					\
> +	size_t iov_offset;				\
> +	size_t count;					\
> +	union {						\
> +		unsigned long nr_segs;			\
> +		struct {				\
> +			unsigned int head;		\
> +			unsigned int start_head;	\
> +		};					\
> +		loff_t xarray_start;			\
> +	};						\
> +
> +struct iov_iter_state {
> +	IOV_ITER_STATE;
> +};
> +
>  struct iov_iter {
>  	u8 iter_type;
>  	bool data_source;
> -	size_t iov_offset;
> -	size_t count;
>  	union {
>  		const struct iovec *iov;
>  		const struct kvec *kvec;
> @@ -40,12 +54,10 @@ struct iov_iter {
>  		struct pipe_inode_info *pipe;
>  	};
>  	union {
> -		unsigned long nr_segs;
> +		struct iov_iter_state state;
>  		struct {
> -			unsigned int head;
> -			unsigned int start_head;
> +			IOV_ITER_STATE;
>  		};
> -		loff_t xarray_start;
>  	};
>  	size_t truncated;
>  };

No.  This is impossible to read *and* wrong for flavours other than
iovec anyway.

Rules:
	count is flavour-independent
	iovec: iov, nr_segs, iov_offset.  nr_segs + iov is constant
	kvec: kvec, nr_segs, iov_offset.  nr_segs + kvec is constant
	bvec: bvec, nr_segs, iov_offset.  nr_segs + bvec is constant
	xarray: xarray, xarray_start, iov_offset.  xarray and xarray_start are constant.
	pipe: pipe, head, start_head, iov_offset.  pipe and start_head are constant,
						   iov_offset can be derived from the rest.
	discard: nothing.

What's more, for pipe (output-only) the situation is much trickier and
there this "reset + advance" won't work at all.  Simply not applicable.

What's the point of all those contortions, anyway?  You only need it for
iovec case; don't mix doing that and turning it into flavour-independent
primitive.

Especially since you turn around and access the fields of that sucker
(->count, that is) directly in your code.  Keep it simple and readable,
please.  We'll sort the sane flavour-independent API later.  And get
rid of ->truncate, while we are at it.
