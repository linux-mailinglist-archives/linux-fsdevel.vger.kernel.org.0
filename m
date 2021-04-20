Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A236609D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhDTUIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTUIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:08:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2AC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HJAKCvJHMAOqWOj1DPVpoh9bepAKILuMi3FEgUJRdyc=; b=MdTQ4mV6AHBDD5j3eqEZMUSbce
        sH4CwMQkawXu0TnVi9L+vCg+pnaArFSEBi35wAgI0MqgNYgkQNmDVjS+77SxQCgTqSmWDbWLeljKY
        aJtsgdLyujBG7+xXuNQl7IpnqOSABkzdMVc+2YvbFyj4L3avEPXwpU8HcT7LI3c4ntpzSS5Q5irhe
        GZb41cXWN1Ekp9No/H52KeN8RWKOHTa/IWppBVRluu2fP65urO1FVeEje3fu53weBPfQTbyGcuInW
        Q/IGf2pey72TO4VpXey2f4Izcruyu/FzS3MiaP+a5LhmAZnHTitqPQ8MQXnR6vc9SNettpXNOQT8N
        apr6Goyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYwe6-00FazS-4Y; Tue, 20 Apr 2021 20:07:02 +0000
Date:   Tue, 20 Apr 2021 21:06:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: Handle ractl nr_pages being modified
Message-ID: <20210420200654.GC3596236@casper.infradead.org>
References: <20210420200116.3715790-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420200116.3715790-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:01:15PM +0100, Matthew Wilcox (Oracle) wrote:
> The BUG_ON that checks whether the ractl is still in sync with the
> local variables can trigger under some fairly unusual circumstances.
> Remove the BUG_ON and resync the loop counter after every call to
> read_pages().
> 
> One way I've seen to trigger it is:
> 
>  - Start out with a partially populated range in the page cache
>  - Allocate some pages and run into an existing page
>  - Send the read request off to the filesystem
>  - The page we ran into is removed from the page cache
>  - readahead_expand() succeeds in expanding upwards
>  - Return to page_cache_ra_unbounded() and we hit the BUG_ON, as nr_pages
>    has been adjusted upwards.

(nb: this has only been reported for a kernel which has readahead_expand().
there is no indication this BUG_ON can be hit by a released kernel)
