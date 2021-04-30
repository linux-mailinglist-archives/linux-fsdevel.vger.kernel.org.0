Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6C36F4CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhD3ERX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 00:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhD3ERX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 341236101B;
        Fri, 30 Apr 2021 04:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1619756195;
        bh=xhexiXbss3a7nAe5J1pREY15jAnW/gq8wn0LwB5fLgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2YqwBTJKXUnmfpyHTuBgrTeLpDen/BK/fRgjhh6RTzcIJReUpeNqFOK5RteKgCCy+
         KVkkI5XaJeDLq5Ggn3Q0Fv3rE1/FErkuyzAX0dyb+fJLqk1ZvjKq5a+u09bAmjz4Ki
         az6Om78xeZmHXevcWYARg2t1wDzkMj0Wa0xPl4HU=
Date:   Thu, 29 Apr 2021 21:16:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-Id: <20210429211634.de4e0fb98d27b3ab9d05757c@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
        <20210331024913.GS351017@casper.infradead.org>
        <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
        <20210401170615.GH351017@casper.infradead.org>
        <20210402031305.GK351017@casper.infradead.org>
        <20210402132708.GM351017@casper.infradead.org>
        <20210402170414.GQ351017@casper.infradead.org>
        <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
        <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Apr 2021 14:16:04 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Fri, 2 Apr 2021, Hugh Dickins wrote:
> > 
> > There is a "Put holes back where they were" xas_store(&xas, NULL) on
> > the failure path, which I think we would expect to delete empty nodes.
> > But it only goes as far as nr_none.  Is it ok to xas_store(&xas, NULL)
> > where there was no non-NULL entry before?  I should try that, maybe
> > adjusting the !nr_none break will give a very simple fix.
> 
> No, XArray did not like that:
> xas_update() XA_NODE_BUG_ON(node, !list_empty(&node->private_list)).
> 
> But also it's the wrong thing for collapse_file() to do, from a file
> integrity point of view. So far as there is a non-NULL page in the list,
> or nr_none is non-zero, those subpages are frozen at the src end, and
> THP head locked and not Uptodate at the dst end. But go beyond nr_none,
> and a racing task could be adding new pages, which THP collapse failure
> has no right to delete behind its back.
> 
> Not an issue for READ_ONLY_THP_FOR_FS, but important for shmem and future.
> 
> > 
> > Or, if you remove the "static " from xas_trim(), maybe that provides
> > the xas_prune_range() you proposed, or the cleanup pass I proposed.
> > To be called on collapse_file() failure, or when eviction finds
> > !mapping_empty().
> 
> Something like this I think.
> 

I'm not sure this ever was resolved?

Is it the case that the series "Remove nrexceptional tracking v2" at
least exposed this bug?

IOW, what the heck should I do with

mm-introduce-and-use-mapping_empty.patch
mm-stop-accounting-shadow-entries.patch
dax-account-dax-entries-as-nrpages.patch
mm-remove-nrexceptional-from-inode.patch

Thanks.
