Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991B82FD79E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbhATR6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbhATR6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:58:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962AC061757;
        Wed, 20 Jan 2021 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pUnziRy/TcrH98npVbZkez1LzWGAocfrqdjT4NTwcIw=; b=skUQ+xxSKtRRyAldNILOAj5MVs
        uowju0zOwSmH1OMrQWg/aWfjCTQUmlLzum+Lxg8Ueu+yd8m5xjBF4UP7wtrqTPKAsePZ+E4rpHZK/
        MLKeJ2J8rHRTyEGxZnT9gtHgVZ7b62DJl01FoxsKcRiLO/lMfjR7xlQ6Q13Wf/Ce8wepxaCtKrISG
        +I8AAfVArrIa8IPwwF9gg4tJIEkn++CLj8Jl7EE2XxggIaTTMdizW9VxwT0WJqfhGuPKOhGavbIy1
        AyXRBugLXjFCmNkdRNJQlfw2z9qgH1AiZE02mwVKAOHqgfKSWD4OwenLQnA0CIEwuoLV0t33gNv17
        uHV9vK9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2HiS-00G1HZ-K2; Wed, 20 Jan 2021 17:56:26 +0000
Date:   Wed, 20 Jan 2021 17:56:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: Provide address_space operation for filling
 pages for read
Message-ID: <20210120175624.GL2260413@casper.infradead.org>
References: <20210120160611.26853-1-jack@suse.cz>
 <20210120160611.26853-3-jack@suse.cz>
 <20210120162001.GB3790454@infradead.org>
 <20210120172705.GC24063@quack2.suse.cz>
 <20210120172836.GA3809508@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120172836.GA3809508@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:28:36PM +0000, Christoph Hellwig wrote:
> On Wed, Jan 20, 2021 at 06:27:05PM +0100, Jan Kara wrote:
> > This would mean pulling i_mmap_sem out from ext4/XFS/F2FS private inode
> > into the VFS inode. Which is fine by me but it would grow struct inode for
> > proc / tmpfs / btrfs (although for btrfs I'm not convinced it isn't
> > actually prone to the race and doesn't need similar protection as xfs /
> > ext4) so some people may object.
> 
> The btrfs folks are already looking into lifting it to common code.
> 
> Also I have a patch pending to remove a list_head from the inode to
> counter the size increase :)

We can get rid of nrexceptional as well:

https://lore.kernel.org/linux-fsdevel/20201026151849.24232-1-willy@infradead.org/

We can also reduce the size of the rwsem by one word by replacing the list_head with a single pointer.

https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/wlist

(haven't touched it in almost four years, seemed to have a bug last time
i looked at it).
