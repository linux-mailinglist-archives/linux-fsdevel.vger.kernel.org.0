Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9932407C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhBXPIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbhBXNmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:42:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB702C061797;
        Wed, 24 Feb 2021 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xqha6KaFHgtvIKBaYdn52JwvfxXRN9RcHQ72fzYOeuc=; b=sXng7xDNXehmcnr+hW/CSKnK/Q
        rvJT1OrIAsqWa9NN8xPC9n3JB67aLuQc2z/fV0E1k3Ec/VnIEdSzmtm1OAdBOJq1uPxrXe9j35Var
        hgFb42qG7+e4qFPooFPcxYWXx5OwRaM5RixwDaIlmOM4BaZFTtYvMZpL57/LvY9Pq/ufZ7zgSNxH6
        YirC1u+3y9MMSC14hmmHiSkNiAI9PSRdM5kq0tTHEU8xFm74X0qWSGMpNyG4yP+YTs+LTIn9rvQw2
        n1NkwimRKMjDpd5nbMqzJHT5MoOlSfnFjidjke0IfLaJQJPsUAq8vIocd5kZE8FA2HsJJsdogN0B2
        wHLmVtyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEuPj-009SVQ-M3; Wed, 24 Feb 2021 13:41:16 +0000
Date:   Wed, 24 Feb 2021 13:41:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [RFC] Better page cache error handling
Message-ID: <20210224134115.GP2858050@casper.infradead.org>
References: <20210205161142.GI308988@casper.infradead.org>
 <20210224123848.GA27695@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224123848.GA27695@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 01:38:48PM +0100, Jan Kara wrote:
> > We allocate a page and try to read it.  29 threads pile up waiting
> > for the page lock in filemap_update_page().  The error returned by the
> > original I/O is shared between all 29 waiters as well as being returned
> > to the requesting thread.  The next request for index.html will send
> > another I/O, and more waiters will pile up trying to get the page lock,
> > but at no time will more than 30 threads be waiting for the I/O to fail.
> 
> Interesting idea. It certainly improves current behavior. I just wonder
> whether this isn't a partial solution to a problem and a full solution of
> it would have to go in a different direction? I mean it just seems
> wrong that each reader (let's assume they just won't overlap) has to retry
> the failed IO and wait for the HW to figure out it's not going to work.
> Shouldn't we cache the error state with the page? And I understand that we
> then also have to deal with the problem how to invalidate the error state
> when the block might eventually become readable (for stuff like temporary
> IO failures). That would need some signalling from the driver to the page
> cache, maybe in a form of some error recovery sequence counter or something
> like that. For stuff like iSCSI, multipath, or NBD it could be doable I
> believe...

That felt like a larger change than I wanted to make.  I already have
a few big projects on my plate!

Also, it's not clear to me that the host can necessarily figure out when
a device has fixed an error -- certainly for the three cases you list
it can be done.  I think we'd want a timer to indicate that it's worth
retrying instead of returning the error.

Anyway, that seems like a lot of data to cram into a struct page.  So I
think my proposal is still worth pursuing while waiting for someone to
come up with a perfect solution.
