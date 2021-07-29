Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA503DA897
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhG2QLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 12:11:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhG2QJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:09:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 156D122270;
        Thu, 29 Jul 2021 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627574942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lq/O8Y0CB9RHKdJxxOQdFWMqsh1BnqsluCSel35j/Ws=;
        b=sSu76YsVtqBJq5/Bguo2I/CH0YFJ/DjJgd3sR7TZ2DA/9jv8pxNb4fOGXp00TGv6AvdpQP
        0TG7+P31Ox7BlQlAw1sNQ35ypEOw2iL1eqE5Gn6rLEXoIgbwz0Y+fyeENataIlBgUU/1y0
        dKuHTwBDnDgpD2ujb+ksJ+WfMhdsEKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627574942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lq/O8Y0CB9RHKdJxxOQdFWMqsh1BnqsluCSel35j/Ws=;
        b=Qg4MWPER216A8pfT5Bwdf8hoai1JgM7ZGugt/w3qMT0FdASkrxZU7BjskWfAz4XponrUDh
        /Xz3gbeKaOtkCwBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A052213357;
        Thu, 29 Jul 2021 16:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5jqyF53SAmEgOgAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Thu, 29 Jul 2021 16:09:01 +0000
Date:   Thu, 29 Jul 2021 11:08:59 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
Message-ID: <20210729160859.sfdypnrti5hxk6fg@fiona>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
 <YP7uqRrXsbCqTpfx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP7uqRrXsbCqTpfx@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:19 26/07, Matthew Wilcox wrote:
> On Mon, Jul 26, 2021 at 11:46:47AM -0500, Goldwyn Rodrigues wrote:
> > Simplification.
> > 
> > file_ra_state_init() take struct address_space *, just to use inode
> > pointer by dereferencing from mapping->host.
> > 
> > The callers also derive mapping either by file->f_mapping, or
> > even file->f_mapping->host->i_mapping.
> > 
> > Change file_ra_state_init() to accept struct inode * to reduce pointer
> > dereferencing, both in the callee and the caller.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> (some adjacent comments)
> 
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index 4806295116d8..c43bf9915cda 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -351,7 +351,7 @@ static void readahead_cache(struct inode *inode)
> >  	if (!ra)
> >  		return;
> >  
> > -	file_ra_state_init(ra, inode->i_mapping);
> > +	file_ra_state_init(ra, inode);
> >  	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
> >  
> >  	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);
> 
> Why does btrfs allocate a file_ra_state using kmalloc instead of
> on the stack?
> 
> > +++ b/include/linux/fs.h
> > @@ -3260,7 +3260,7 @@ extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> >  
> >  
> >  extern void
> > -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
> > +file_ra_state_init(struct file_ra_state *ra, struct inode *inode);
> 
> This should move to pagemap.h (and lose the extern).
> I'd put it near the definition of VM_READAHEAD_PAGES.
> 
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index d589f147f4c2..3541941df5e7 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -31,9 +31,9 @@
> >   * memset *ra to zero.
> >   */
> >  void
> > -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> > +file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
> >  {
> > -	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> > +	ra->ra_pages = inode_to_bdi(inode)->ra_pages;
> >  	ra->prev_pos = -1;
> >  }
> >  EXPORT_SYMBOL_GPL(file_ra_state_init);
> 
> I'm not entirely sure why this function is out-of-line, tbh.
> Would it make more sense for it to be static inline in a header?

Which one? pagemap.h or fs.h does not know of inode_to_bdi(), should
linux/backing-dev.h be included?

-- 
Goldwyn
