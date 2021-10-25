Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14EF439BF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhJYQqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 12:46:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53514 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhJYQqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:46:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2721FD47;
        Mon, 25 Oct 2021 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635180218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnjRbMNi7vASM5fyE3GxhiHxXT0BDlx8St1eRazeD8o=;
        b=HQ/ELBkMVwvPezRkxJ8hbLCJOYAddZ5V1E1x9qRby8f7SbIYJ0jiT+k0ZQknrQtaAXzUMf
        wAhDsYwN2ZKwBeBnd4lZaIuAyUJHjZiftolODAZsSU5iK7s8bHeH5jjmDwSIxP+f1wL83I
        9/eUPkl7TlQ8AhCafRyKyWpl3C1Ryf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635180218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnjRbMNi7vASM5fyE3GxhiHxXT0BDlx8St1eRazeD8o=;
        b=SYw+soUAHbqGDrhswsXCUgWCKRbkK8lqzeUTeppUfL+aZZijfzd6hK3mOlWaG4YriR8YYn
        EHqKfKLFcLfyobBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA7213C0B;
        Mon, 25 Oct 2021 16:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bSWHHLnedmFyQAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Mon, 25 Oct 2021 16:43:37 +0000
Date:   Mon, 25 Oct 2021 11:43:35 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Shared memory for shared extents
Message-ID: <20211025164335.t7he6miollf6un2j@fiona>
References: <cover.1634933121.git.rgoldwyn@suse.com>
 <YXNoxZqKPkxZvr3E@casper.infradead.org>
 <20211025145301.hk627p2qcotxegrd@fiona>
 <YXbQm6TxaWcLnpal@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbQm6TxaWcLnpal@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16:43 25/10, Matthew Wilcox wrote:
> On Mon, Oct 25, 2021 at 09:53:01AM -0500, Goldwyn Rodrigues wrote:
> > On  2:43 23/10, Matthew Wilcox wrote:
> > > On Fri, Oct 22, 2021 at 03:15:00PM -0500, Goldwyn Rodrigues wrote:
> > > > This is an attempt to reduce the memory footprint by using a shared
> > > > page(s) for shared extent(s) in the filesystem. I am hoping to start a
> > > > discussion to iron out the details for implementation.
> > > 
> > > When you say "Shared extents", you mean reflinks, which are COW, right?
> > 
> > Yes, shared extents are extents which are shared on disk by two or more
> > files. Yes, same as reflinks. Just to explain with an example:
> > 
> > If two files, f1 and f2 have shared extent(s), and both files are read. Each
> > file's mapping->i_pages will hold a copy of the contents of the shared
> > extent on disk. So, f1->mapping will have one copy and f2->mapping will
> > have another copy.
> > 
> > For reads (and only reads), if we use underlying device's mapping, we
> > can save on duplicate copy of the pages.
> 
> Yes; I'm familiar with the problem.  Dave Chinner and I had a great
> discussion about it at LCA a couple of years ago.
> 
> The implementation I've had in mind for a while is that the filesystem
> either creates a separate inode for a shared extent, or (as you've
> done here) uses the bdev's inode.  We can discuss the pros/cons of
> that separately.
> 
> To avoid the double-lookup problem, I was intending to generalise DAX
> entries into PFN entries.  That way, if the read() (or mmap read fault)
> misses in the inode's cache, we can look up the shared extent cache,
> and then cache the physical address of the memory in the inode.

I am not sure I understand. Could you provide an example? Would this be
specific to DAX? What about standard block devices?

> 
> That makes reclaim/eviction of the page in the shared extent more
> expensive because you have to iterate all the inodes which share the
> extent and remove the PFN entries before the page can be reused.

Not sure of this, but won't it complicate things if there are different
shared extents in different files? Say shared extent SE1 belongs to f1
and f2, where as SE2 belongs to f2 and f3?

> 
> Perhaps we should have a Zoom meeting about this before producing duelling
> patch series?  I can host if you're interested.

Yes, I think that would be nice. I am in the central US Timezone.
If possible, I would like to add David Disseldorp who is based in
Germany.

-- 
Goldwyn
