Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8431C8DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 11:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBPKdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 05:33:17 -0500
Received: from verein.lst.de ([213.95.11.211]:40771 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBPKdB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:33:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E1E76736F; Tue, 16 Feb 2021 11:32:16 +0100 (CET)
Date:   Tue, 16 Feb 2021 11:32:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
Message-ID: <20210216103215.GB27714@lst.de>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 03:44:52PM +0000, David Howells wrote:
> Provide a function, readahead_expand(), that expands the set of pages
> specified by a readahead_control object to encompass a revised area with a
> proposed size and length.
> 
> The proposed area must include all of the old area and may be expanded yet
> more by this function so that the edges align on (transparent huge) page
> boundaries as allocated.
> 
> The expansion will be cut short if a page already exists in either of the
> areas being expanded into.  Note that any expansion made in such a case is
> not rolled back.
> 
> This will be used by fscache so that reads can be expanded to cache granule
> boundaries, thereby allowing whole granules to be stored in the cache, but
> there are other potential users also.

So looking at linux-next this seems to have a user, but that user is
dead wood given that nothing implements ->expand_readahead.

Looking at the code structure I think netfs_readahead and
netfs_rreq_expand is a complete mess and needs to be turned upside
down, that is instead of calling back from netfs_readahead to the
calling file system, split it into a few helpers called by the
caller.

But even after this can't we just expose the cache granule boundary
to the VM so that the read-ahead request gets setup correctly from
the very beginning?
