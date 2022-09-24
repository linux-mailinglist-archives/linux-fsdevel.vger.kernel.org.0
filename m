Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1D5E885E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 06:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiIXEfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 00:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIXEfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 00:35:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD628E6DFE;
        Fri, 23 Sep 2022 21:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GRXIx+y5OMwYb3YOlMDz+3OaSSwqvgrzxg78N6l6dm4=; b=nSZ9vVwOIFT9lrRGowuJzQR3im
        +S+41z9rktMv3wjY7Dz6Qwu0EBxdVlMTP2dD99t+Rw2IpMSIa+dd7IpfolopaZo5wKABnraQ/6Tel
        4zJ/PvrEas6rjYwJOoLu2UjghRmfiCqYnpYzWNhGqR6QMNs9vRzPVNxk9BhWM91HfSUtPF/vLlJMT
        q8Mka2owa9uaiK7DtPICSeqON67cI8cFYQ6BzzAR7koTVNWwDMXAcKb5cfDpWb83Grov4wVBIPIu+
        DF0n5xL72ec1mOsx6idf4G6aPJaiZQQA7kLme+pS7KsYuGNupg8oR3/U1JKzH/FGhW3GE+aadvPFi
        Z4tKjNmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obwsP-0039Vr-1k;
        Sat, 24 Sep 2022 04:34:53 +0000
Date:   Sat, 24 Sep 2022 05:34:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] cifs: Change the I/O paths to use an iterator rather
 than a page list
Message-ID: <Yy6I7QBvlRP3yDbe@ZenIV>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
 <166126396180.708021.271013668175370826.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166126396180.708021.271013668175370826.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:12:41PM +0100, David Howells wrote:
>  static void
>  cifs_writev_requeue(struct cifs_writedata *wdata)
>  {
> -	int i, rc = 0;
> +	int rc = 0;
>  	struct inode *inode = d_inode(wdata->cfile->dentry);
>  	struct TCP_Server_Info *server;
> -	unsigned int rest_len;
> +	unsigned int rest_len = wdata->bytes;

Umm...  Can that by different from iov_iter_count(&wdata->iter)?

> +	loff_t fpos = wdata->offset;
>  
>  	server = tlink_tcon(wdata->cfile->tlink)->ses->server;
> -	i = 0;
> -	rest_len = wdata->bytes;
>  	do {
>  		struct cifs_writedata *wdata2;
> -		unsigned int j, nr_pages, wsize, tailsz, cur_len;
> +		unsigned int wsize, cur_len;
>  
>  		wsize = server->ops->wp_retry_size(inode);
>  		if (wsize < rest_len) {
> -			nr_pages = wsize / PAGE_SIZE;
> -			if (!nr_pages) {
> -				rc = -EOPNOTSUPP;
> +			if (wsize < PAGE_SIZE) {
> +				rc = -ENOTSUPP;
>  				break;
>  			}
> -			cur_len = nr_pages * PAGE_SIZE;
> -			tailsz = PAGE_SIZE;
> +			cur_len = min(round_down(wsize, PAGE_SIZE), rest_len);
>  		} else {
> -			nr_pages = DIV_ROUND_UP(rest_len, PAGE_SIZE);
>  			cur_len = rest_len;
> -			tailsz = rest_len - (nr_pages - 1) * PAGE_SIZE;
>  		}
>  
> -		wdata2 = cifs_writedata_alloc(nr_pages, cifs_writev_complete);
> +		wdata2 = cifs_writedata_alloc(cifs_writev_complete);
>  		if (!wdata2) {
>  			rc = -ENOMEM;
>  			break;
>  		}
>  
> -		for (j = 0; j < nr_pages; j++) {
> -			wdata2->pages[j] = wdata->pages[i + j];
> -			lock_page(wdata2->pages[j]);
> -			clear_page_dirty_for_io(wdata2->pages[j]);
> -		}
> -
>  		wdata2->sync_mode = wdata->sync_mode;
> -		wdata2->nr_pages = nr_pages;
> -		wdata2->offset = page_offset(wdata2->pages[0]);
> -		wdata2->pagesz = PAGE_SIZE;
> -		wdata2->tailsz = tailsz;
> -		wdata2->bytes = cur_len;
> +		wdata2->offset	= fpos;
> +		wdata2->bytes	= cur_len;
> +		wdata2->iter	= wdata->iter;
> +
> +		iov_iter_advance(&wdata2->iter, fpos - wdata->offset);

Am I right assuming that wdata->iter won't be looked at after we return?
If so, why not advance wdata->iter instead?  At the point where you
increment fpos, that is.  And instead of rest_len just use
iov_iter_count(&wdata->iter)...

> -	/* cleanup remaining pages from the original wdata */
> -	for (; i < wdata->nr_pages; i++) {
> -		SetPageError(wdata->pages[i]);
> -		end_page_writeback(wdata->pages[i]);
> -		put_page(wdata->pages[i]);
> -	}
> +	/* Clean up remaining pages from the original wdata */
> +	if (iov_iter_is_xarray(&wdata->iter))
> +		cifs_pages_write_failed(inode, fpos, rest_len);
>  
>  	if (rc != 0 && !is_retryable_error(rc))
>  		mapping_set_error(inode->i_mapping, rc);
> @@ -2491,7 +2503,6 @@ cifs_writev_complete(struct work_struct *work)
>  	struct cifs_writedata *wdata = container_of(work,
>  						struct cifs_writedata, work);
>  	struct inode *inode = d_inode(wdata->cfile->dentry);
> -	int i = 0;
>  
>  	if (wdata->result == 0) {
>  		spin_lock(&inode->i_lock);

> +/*
> + * Select span of a bvec iterator we're going to use.  Limit it by both maximum
> + * size and maximum number of segments.
> + */
> +static size_t cifs_limit_bvec_subset(const struct iov_iter *iter, size_t offset,
> +				     size_t max_size, size_t max_segs, unsigned int *_nsegs)
> +{
> +	const struct bio_vec *bvecs = iter->bvec;
> +	unsigned int nbv = iter->nr_segs, ix = 0, nsegs = 0;
> +	size_t len, span = 0, n = iter->count;
> +	size_t skip = iter->iov_offset + offset;
> +
> +	if (WARN_ON(!iov_iter_is_bvec(iter)) || WARN_ON(offset > n) || n == 0)
> +		return 0;
> +
> +	while (n && ix < nbv && skip) {
> +		len = bvecs[ix].bv_len;
> +		if (skip < len)
> +			break;
> +		skip -= len;
> +		n -= len;
> +		ix++;
> +	}

Umm...  Are you guaranteed that iter->count points to an end of some bvec?
IOW, what's to stop your n from wrapping around?

>  static int
> -cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
> +cifs_write_from_iter(loff_t fpos, size_t len, const struct iov_iter *from,
>  		     struct cifsFileInfo *open_file,
>  		     struct cifs_sb_info *cifs_sb, struct list_head *wdata_list,
>  		     struct cifs_aio_ctx *ctx)
>  {
>  	int rc = 0;
> -	size_t cur_len;
> -	unsigned long nr_pages, num_pages, i;
> +	size_t cur_len, max_len;
>  	struct cifs_writedata *wdata;
> -	struct iov_iter saved_from = *from;
> -	loff_t saved_offset = offset;
> +	size_t skip = 0;
>  	pid_t pid;
>  	struct TCP_Server_Info *server;
> -	struct page **pagevec;
> -	size_t start;
> -	unsigned int xid;
> +	unsigned int xid, max_segs = INT_MAX;
>  
>  	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
>  		pid = open_file->pid;
> @@ -3341,10 +3741,20 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>  	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
>  	xid = get_xid();
>  
> +#ifdef CONFIG_CIFS_SMB_DIRECT
> +	if (server->smbd_conn)
> +		max_segs = server->smbd_conn->max_frmr_depth;
> +#endif
> +
>  	do {
> -		unsigned int wsize;
>  		struct cifs_credits credits_on_stack;
>  		struct cifs_credits *credits = &credits_on_stack;
> +		unsigned int wsize, nsegs = 0;
> +
> +		if (signal_pending(current)) {
> +			rc = -EINTR;
> +			break;
> +		}
>  
>  		if (open_file->invalidHandle) {
>  			rc = cifs_reopen_file(open_file, false);
> @@ -3359,96 +3769,43 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>  		if (rc)
>  			break;
>  
> -		cur_len = min_t(const size_t, len, wsize);
> -
> -		if (ctx->direct_io) {
> -			ssize_t result;
> -
> -			result = iov_iter_get_pages_alloc2(
> -				from, &pagevec, cur_len, &start);
> -			if (result < 0) {
> -				cifs_dbg(VFS,
> -					 "direct_writev couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
> -					 result, iov_iter_type(from),
> -					 from->iov_offset, from->count);
> -				dump_stack();
> -
> -				rc = result;
> -				add_credits_and_wake_if(server, credits, 0);
> -				break;
> -			}
> -			cur_len = (size_t)result;
> -
> -			nr_pages =
> -				(cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
> -
> -			wdata = cifs_writedata_direct_alloc(pagevec,
> -					     cifs_uncached_writev_complete);
> -			if (!wdata) {
> -				rc = -ENOMEM;
> -				add_credits_and_wake_if(server, credits, 0);
> -				break;
> -			}
> -
> -
> -			wdata->page_offset = start;
> -			wdata->tailsz =
> -				nr_pages > 1 ?
> -					cur_len - (PAGE_SIZE - start) -
> -					(nr_pages - 2) * PAGE_SIZE :
> -					cur_len;
> -		} else {
> -			nr_pages = get_numpages(wsize, len, &cur_len);
> -			wdata = cifs_writedata_alloc(nr_pages,
> -					     cifs_uncached_writev_complete);
> -			if (!wdata) {
> -				rc = -ENOMEM;
> -				add_credits_and_wake_if(server, credits, 0);
> -				break;
> -			}
> -
> -			rc = cifs_write_allocate_pages(wdata->pages, nr_pages);
> -			if (rc) {
> -				kvfree(wdata->pages);
> -				kfree(wdata);
> -				add_credits_and_wake_if(server, credits, 0);
> -				break;
> -			}
> -
> -			num_pages = nr_pages;
> -			rc = wdata_fill_from_iovec(
> -				wdata, from, &cur_len, &num_pages);
> -			if (rc) {
> -				for (i = 0; i < nr_pages; i++)
> -					put_page(wdata->pages[i]);
> -				kvfree(wdata->pages);
> -				kfree(wdata);
> -				add_credits_and_wake_if(server, credits, 0);
> -				break;
> -			}
> +		max_len = min_t(const size_t, len, wsize);
> +		if (!max_len) {
> +			rc = -EAGAIN;
> +			add_credits_and_wake_if(server, credits, 0);
> +			break;
> +		}
>  
> -			/*
> -			 * Bring nr_pages down to the number of pages we
> -			 * actually used, and free any pages that we didn't use.
> -			 */
> -			for ( ; nr_pages > num_pages; nr_pages--)
> -				put_page(wdata->pages[nr_pages - 1]);
> +		cur_len = cifs_limit_bvec_subset(from, skip, max_len, max_segs, &nsegs);
> +		cifs_dbg(FYI, "write_from_iter len=%zx/%zx nsegs=%u/%lu/%u\n",
> +			 cur_len, max_len, nsegs, from->nr_segs, max_segs);
> +		if (cur_len == 0) {
> +			rc = -EIO;
> +			add_credits_and_wake_if(server, credits, 0);
> +			break;
> +		}
>  
> -			wdata->tailsz = cur_len - ((nr_pages - 1) * PAGE_SIZE);
> +		wdata = cifs_writedata_alloc(cifs_uncached_writev_complete);
> +		if (!wdata) {
> +			rc = -ENOMEM;
> +			add_credits_and_wake_if(server, credits, 0);
> +			break;
>  		}
>  
>  		wdata->sync_mode = WB_SYNC_ALL;
> -		wdata->nr_pages = nr_pages;
> -		wdata->offset = (__u64)offset;
> -		wdata->cfile = cifsFileInfo_get(open_file);
> -		wdata->server = server;
> -		wdata->pid = pid;
> -		wdata->bytes = cur_len;
> -		wdata->pagesz = PAGE_SIZE;
> -		wdata->credits = credits_on_stack;
> -		wdata->ctx = ctx;
> +		wdata->offset	= (__u64)fpos;
> +		wdata->cfile	= cifsFileInfo_get(open_file);
> +		wdata->server	= server;
> +		wdata->pid	= pid;
> +		wdata->bytes	= cur_len;
> +		wdata->credits	= credits_on_stack;
> +		wdata->iter	= *from;
> +		wdata->ctx	= ctx;
>  		kref_get(&ctx->refcount);
>  
> +		iov_iter_advance(&wdata->iter, skip);
> +		iov_iter_truncate(&wdata->iter, cur_len);
> +
>  		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
>  
>  		if (!rc) {
> @@ -3463,16 +3820,14 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>  			add_credits_and_wake_if(server, &wdata->credits, 0);
>  			kref_put(&wdata->refcount,
>  				 cifs_uncached_writedata_release);
> -			if (rc == -EAGAIN) {
> -				*from = saved_from;
> -				iov_iter_advance(from, offset - saved_offset);
> +			if (rc == -EAGAIN)
>  				continue;
> -			}
>  			break;
>  		}
>  
>  		list_add_tail(&wdata->list, wdata_list);
> -		offset += cur_len;
> +		skip += cur_len;
> +		fpos += cur_len;

	IDGI.  Why not simply iov_iter_advance(from, cur_len) here, and
to hell with both the iov_iter_advance() above *and* with skip argument
of cifs_limit_bvec_subset()?  If you want to keep from const - copy into
local variable and be done with that...
