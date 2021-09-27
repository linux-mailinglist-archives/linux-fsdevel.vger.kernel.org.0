Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F17419FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhI0UE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 16:04:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhI0UE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:04:59 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 373C31FF79;
        Mon, 27 Sep 2021 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632772999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OWyy087kUcLdlyc/fMUCTYpqi5qxNMTXwsGsPPvHgDU=;
        b=kWibP7IwsPtmLu1Z91YlWpRQCdwjku9jIL9nWyNAlXt52WM/cmjZMpdX6RVSEyAvmYspZe
        Hvz4gXkWKTESUOeX6ZYKqVRAuFqtd14BOB+lrP/PNqft0q9rAPKq/qYqQxSHouQU67RRQN
        LQe8zYMxT45IOXgaCreUieFpTycrqB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632772999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OWyy087kUcLdlyc/fMUCTYpqi5qxNMTXwsGsPPvHgDU=;
        b=WWxu+gdW8UEBCsHxKgDJsEOiF45Qv/5XDpNAT1PmVspypr8yqEgnie2RREgD+1bm8EYsAl
        7MO73hUAa6KcqnBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 04D5F25D3E;
        Mon, 27 Sep 2021 20:03:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31B56DA799; Mon, 27 Sep 2021 22:03:02 +0200 (CEST)
Date:   Mon, 27 Sep 2021 22:03:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, hch@lst.de,
        trond.myklebust@primarydata.com, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Message-ID: <20210927200302.GH9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, hch@lst.de,
        trond.myklebust@primarydata.com, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YU84rYOyyXDP3wjp@casper.infradead.org>
 <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
 <2396106.1632584202@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396106.1632584202@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 25, 2021 at 04:36:42PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
> > > Delete the BIO-generating swap read/write paths and always use ->swap_rw().
> > > This puts the mapping layer in the filesystem.
> > 
> > Is SWP_FS_OPS now unused after this patch?
> 
> Ummm.  Interesting question - it's only used in swap_set_page_dirty():
> 
> int swap_set_page_dirty(struct page *page)
> {
> 	struct swap_info_struct *sis = page_swap_info(page);
> 
> 	if (data_race(sis->flags & SWP_FS_OPS)) {
> 		struct address_space *mapping = sis->swap_file->f_mapping;
> 
> 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
> 		return mapping->a_ops->set_page_dirty(page);
> 	} else {
> 		return __set_page_dirty_no_writeback(page);
> 	}
> }
> 
> 
> > Also, do we still need ->swap_activate and ->swap_deactivate?
> 
> f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'm
> not sure how necessary it is.

Yes we still need it for btrfs. Besides checking the conditions similar
to what iomap_swapfile_activate does on the file itself, we need to
exclude other operations potentially changing the mapping on the level
of block groups. This is namely relocation, used to implement several
other things like resize or balance. There's an exclusion at the
beginning of btrfs_swap_activate. Right now I don't see how we could
make sure that the swapfile requirements would be satisfied without it.
