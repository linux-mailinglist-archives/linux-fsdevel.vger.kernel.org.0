Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BD3EB134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhHMHNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:13:21 -0400
Received: from verein.lst.de ([213.95.11.211]:46616 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239319AbhHMHNQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:13:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA67C67373; Fri, 13 Aug 2021 09:12:45 +0200 (CEST)
Date:   Fri, 13 Aug 2021 09:12:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <20210813071245.GC26339@lst.de>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk> <162879974434.3306668.4798886633463058599.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879974434.3306668.4798886633463058599.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/*
> + * Keep track of the kiocb we're using to do async DIO.  We have to
> + * refcount it until various things stop looking at the kiocb *after*
> + * calling ->ki_complete().
> + */
> +struct swapfile_kiocb {
> +	struct kiocb		iocb;
> +	refcount_t		ki_refcnt;
> +};

The ki_ prefix is a little strange here.

> +
> +static void swapfile_put_kiocb(struct swapfile_kiocb *ki)
> +{
> +	if (refcount_dec_and_test(&ki->ki_refcnt)) {
> +		fput(ki->iocb.ki_filp);

What do we need the file reference for here?  The swap code has to have
higher level prevention for closing the file vs active I/O, at least the
block path seems to rely on that.

> +static void swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
> +{
> +	struct swapfile_kiocb *ki = container_of(iocb, struct swapfile_kiocb, iocb);

Overly long line.

> +	/* Should set IOCB_HIPRI too, but the box becomes unresponsive whilst
> +	 * putting out occasional messages about the NFS sunrpc scheduling
> +	 * tasks being hung.
> +	 */

IOCB_HIPRI has a very specific meaning, so I'm not sure we should
use it never mind leave such a comment here.  Also this is not the
proper standard kernel comment style.

> +
> +	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));
> +	ret = swap_file->f_mapping->a_ops->direct_IO(&kiocb, &to);
> +
> +	__swapfile_read_complete(&kiocb, ret, 0);
> +	return (ret > 0) ? 0 : ret;

No need for the braces.

> +	return (ret > 0) ? 0 : ret;

Same here.
