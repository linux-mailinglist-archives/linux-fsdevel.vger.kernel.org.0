Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296A672F41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 03:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjASCwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 21:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjASCwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:52:34 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF114490;
        Wed, 18 Jan 2023 18:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HnE8fVbkB/BVCYxP+S1x8sDjBJ0ldtemNXen2hWnksk=; b=oqdy5dQXQK8UKr2bchgDpmzr4u
        /YEa4vss13qzDFzF/5SZ6+YIyD4koYihP2urPA99HHyQPAeqFTwNoDCD/nwRMM99Gud8hcYQ6kWQO
        3NNQaUuORpB5S2seuDUMhMGySxvMub3F89zZnCiXz9KHoAAHJdZMXDiLpsAp6znVF4da8iOzr0OlJ
        +QiwMga1XvlbOpQz+A4ICPE0otE5Y88xCqIwMlyvaVVGTJ+Ydurhxd3SADgPaxnJ8iVYYPN4h04JC
        tmtjCQB/Ozgx7lcaNDD7I9yYZ5Ja69xsVH95GxSK8u16M5ZaZ3m/9nHWKGUeSsd/a5KcWAHDZbfft
        Vmx9DLiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIL2C-002f1r-1E;
        Thu, 19 Jan 2023 02:52:12 +0000
Date:   Thu, 19 Jan 2023 02:52:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/34] 9p: Pin pages rather than ref'ing if appropriate
Message-ID: <Y8iwXJ2gMcCyXzm4@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391063242.2311931.3275290816918213423.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391063242.2311931.3275290816918213423.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:10:32PM +0000, David Howells wrote:

> @@ -310,73 +310,34 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  			       struct iov_iter *data,
>  			       int count,
>  			       size_t *offs,
> -			       int *need_drop,
> +			       int *cleanup_mode,
>  			       unsigned int gup_flags)
>  {
>  	int nr_pages;
>  	int err;
> +	int n;
>  
>  	if (!iov_iter_count(data))
>  		return 0;
>  
> -	if (!iov_iter_is_kvec(data)) {
> -		int n;
> -		/*
> -		 * We allow only p9_max_pages pinned. We wait for the
> -		 * Other zc request to finish here
> -		 */
> -		if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
> -			err = wait_event_killable(vp_wq,
> -			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
> -			if (err == -ERESTARTSYS)
> -				return err;
> -		}
> -		n = iov_iter_get_pages_alloc(data, pages, count, offs,
> -					     gup_flags);
> -		if (n < 0)
> -			return n;
> -		*need_drop = 1;
> -		nr_pages = DIV_ROUND_UP(n + *offs, PAGE_SIZE);
> -		atomic_add(nr_pages, &vp_pinned);
> -		return n;
> -	} else {
> -		/* kernel buffer, no need to pin pages */
> -		int index;
> -		size_t len;
> -		void *p;
> -
> -		/* we'd already checked that it's non-empty */
> -		while (1) {
> -			len = iov_iter_single_seg_count(data);
> -			if (likely(len)) {
> -				p = data->kvec->iov_base + data->iov_offset;
> -				break;
> -			}
> -			iov_iter_advance(data, 0);
> -		}
> -		if (len > count)
> -			len = count;
> -
> -		nr_pages = DIV_ROUND_UP((unsigned long)p + len, PAGE_SIZE) -
> -			   (unsigned long)p / PAGE_SIZE;
> -
> -		*pages = kmalloc_array(nr_pages, sizeof(struct page *),
> -				       GFP_NOFS);
> -		if (!*pages)
> -			return -ENOMEM;
> -
> -		*need_drop = 0;
> -		p -= (*offs = offset_in_page(p));
> -		for (index = 0; index < nr_pages; index++) {
> -			if (is_vmalloc_addr(p))
> -				(*pages)[index] = vmalloc_to_page(p);
> -			else
> -				(*pages)[index] = kmap_to_page(p);
> -			p += PAGE_SIZE;
> -		}
> -		iov_iter_advance(data, len);
> -		return len;
> +	/*
> +	 * We allow only p9_max_pages pinned. We wait for the
> +	 * Other zc request to finish here
> +	 */
> +	if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
> +		err = wait_event_killable(vp_wq,
> +					  (atomic_read(&vp_pinned) < chan->p9_max_pages));
> +		if (err == -ERESTARTSYS)
> +			return err;
>  	}
> +
> +	n = iov_iter_extract_pages(data, pages, count, offs, gup_flags);

Wait a sec; just how would that work for ITER_KVEC?  AFAICS, in your
tree that would blow with -EFAULT...

Yup; in p9_client_readdir() in your tree:

net/9p/client.c:2057:	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);

net/9p/client.c:2077:		req = p9_client_zc_rpc(clnt, P9_TREADDIR, &to, NULL, rsize, 0,
net/9p/client.c:2078:				       11, "dqd", fid->fid, offset, rsize);

where
net/9p/client.c:799:	err = c->trans_mod->zc_request(c, req, uidata, uodata,
net/9p/client.c:800:				       inlen, olen, in_hdrlen);

and in p9_virtio_zc_request(), which is a possible ->zc_request() instance
net/9p/trans_virtio.c:402:		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
net/9p/trans_virtio.c:403:					    outlen, &offs, &cleanup_mode,
net/9p/trans_virtio.c:404:					    FOLL_DEST_BUF);

with p9_get_mapped_pages() hitting
net/9p/trans_virtio.c:334:	n = iov_iter_extract_pages(data, pages, count, offs, gup_flags);
net/9p/trans_virtio.c:335:	if (n < 0)
net/9p/trans_virtio.c:336:		return n;

and in iov_iter_extract_get_pages()
lib/iov_iter.c:2250:	if (likely(user_backed_iter(i)))
lib/iov_iter.c:2251:		return iov_iter_extract_user_pages(i, pages, maxsize,
lib/iov_iter.c:2252:						   maxpages, gup_flags,
lib/iov_iter.c:2253:						   offset0);
lib/iov_iter.c:2254:	if (iov_iter_is_bvec(i))
lib/iov_iter.c:2255:		return iov_iter_extract_bvec_pages(i, pages, maxsize,
lib/iov_iter.c:2256:						   maxpages, gup_flags,
lib/iov_iter.c:2257:						   offset0);
lib/iov_iter.c:2258:	if (iov_iter_is_pipe(i))
lib/iov_iter.c:2259:		return iov_iter_extract_pipe_pages(i, pages, maxsize,
lib/iov_iter.c:2260:						   maxpages, gup_flags,
lib/iov_iter.c:2261:						   offset0);
lib/iov_iter.c:2262:	if (iov_iter_is_xarray(i))
lib/iov_iter.c:2263:		return iov_iter_extract_xarray_pages(i, pages, maxsize,
lib/iov_iter.c:2264:						     maxpages, gup_flags,
lib/iov_iter.c:2265:						     offset0);
lib/iov_iter.c:2266:	return -EFAULT;

All quoted lines by your
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tree/
How could that possibly work?
