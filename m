Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F87339B4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 03:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhCMCfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 21:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhCMCfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:35:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5473C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Mar 2021 18:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4QdtxG0hSq/IIvCfi+gr9son1T9syNKPmuqqjfe6uS4=; b=Xs2F87UU5qSNJGluefg+EQlHCw
        VWctJEFYCDH8CIeeIgqkkiIOhBJI5tXiz5SC/ROPvop9funPRzNVhpJJZcK4FZ3vXwNJECHfwEbu3
        2diC4nMy+htV6IyCHy7InnsVjMM2+TNvGchkxksN7rYYw5vPXImSi7MD0HmCl86nXG50gon+pjhUz
        MPL/dgf4Uj2YEAIbk9EMNyur2pEyKUnuE4JE+WB4yHzDWxmOjx6d87XalDgI31DfGCW71Z4Z1Y8jf
        9Zgvf5YievILvzY03SaeIvCZbGCPfOd+7cZUOAeWTS7RpBjezGvuU6mAIYiSToQ5JtarJyDRQ/0ti
        PJLxnvDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKu7d-00CctL-AK; Sat, 13 Mar 2021 02:35:25 +0000
Date:   Sat, 13 Mar 2021 02:35:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 0/4] Remove nrexceptional tracking
Message-ID: <20210313023521.GG2577561@casper.infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20210121184334.GA4127393@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121184334.GA4127393@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping?

On Thu, Jan 21, 2021 at 06:43:34PM +0000, Matthew Wilcox wrote:
> Ping?  These patches still apply to next-20210121.
> 
> On Mon, Oct 26, 2020 at 03:18:45PM +0000, Matthew Wilcox (Oracle) wrote:
> > We actually use nrexceptional for very little these days.  It's a minor
> > pain to keep in sync with nrpages, but the pain becomes much bigger
> > with the THP patches because we don't know how many indices a shadow
> > entry occupies.  It's easier to just remove it than keep it accurate.
> > 
> > Also, we save 8 bytes per inode which is nothing to sneeze at; on my
> > laptop, it would improve shmem_inode_cache from 22 to 23 objects per
> > 16kB, and inode_cache from 26 to 27 objects.  Combined, that saves
> > a megabyte of memory from a combined usage of 25MB for both caches.
> > Unfortunately, ext4 doesn't cross a magic boundary, so it doesn't save
> > any memory for ext4.
> > 
> > Matthew Wilcox (Oracle) (4):
> >   mm: Introduce and use mapping_empty
> >   mm: Stop accounting shadow entries
> >   dax: Account DAX entries as nrpages
> >   mm: Remove nrexceptional from inode
> > 
> >  fs/block_dev.c          |  2 +-
> >  fs/dax.c                |  8 ++++----
> >  fs/gfs2/glock.c         |  3 +--
> >  fs/inode.c              |  2 +-
> >  include/linux/fs.h      |  2 --
> >  include/linux/pagemap.h |  5 +++++
> >  mm/filemap.c            | 16 ----------------
> >  mm/swap_state.c         |  4 ----
> >  mm/truncate.c           | 19 +++----------------
> >  mm/workingset.c         |  1 -
> >  10 files changed, 15 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 2.28.0
> > 
> 
