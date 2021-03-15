Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3F33B30D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCOMrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCOMrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:47:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D253C061574;
        Mon, 15 Mar 2021 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=k8kBd5XUDTT977pE3SWgeErOtsPBNTbq9YiM/WW5MBU=; b=WzJfxcPs+Wb6LWt63nadK8c89g
        3kznciq1z0qw7lt7hNytHeFeAlG8pDIBT0ZprwO/b2Uu1uyW6XyVSyRmluZKR5Jl/A4clxkNCkI3E
        NojWIHTgZ7QeX9QA5+AoPQNWWz5kDJmUA7uqE041i/ucAbT+o42RNK3AZegm5Nwxh50IrYmXpDCUQ
        gWBKqkf992UbcGiS5AXOOp1noQr8abEa+LsEj6taEXQWBknyRVUPKdVxHfCwXFEUXySdaCfhXsY4Q
        mabYu8E3Ty2rSilfFzGBjj6DEeu2u7dMdOtSHWZbUV6QpXJ/cUh2CXlAEN26DDOya0aZ3r0NFsPpc
        k9lbM4hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLmcO-000AnN-Q0; Mon, 15 Mar 2021 12:46:47 +0000
Date:   Mon, 15 Mar 2021 12:46:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] vfs: Use an xarray instead of inserted
 bookmarks to scan mount list
Message-ID: <20210315124644.GU2577561@casper.infradead.org>
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:07:39PM +0000, David Howells wrote:
> 
> Hi Al, Miklós,
> 
> Can we consider replacing the "insert cursor" approach we're currently
> using for proc files to scan the current namespace's mount list[1] with
> something that uses an xarray of mounts indexed by mnt_id?
> 
> This has some advantages:
> 
>  (1) It's simpler.  We don't need to insert dummy mount objects as
>      bookmarks into the mount list and code that's walking the list doesn't
>      have to carefully step over them.
> 
>  (2) We can use the file position to represent the mnt_id and can jump to
>      it directly - ie. using seek() to jump to a mount object by its ID.
> 
>  (3) It might make it easier to use RCU in future to dump mount entries
>      rather than having to take namespace_sem.  xarray provides for the
>      possibility of tagging entries to say that they're viewable to avoid
>      dumping incomplete mount objects.

Usually one fully constructs the object, then inserts it into the XArray.

> But there are a number of disadvantages:
> 
>  (1) We have to allocate memory to maintain the xarray, which becomes more
>      of a problem as mnt_id values get scattered.

mnt_id values don't seem to get particularly scattered.  They're allocated
using an IDA, so they stay small (unlike someone using idr_alloc_cyclic
;-).

