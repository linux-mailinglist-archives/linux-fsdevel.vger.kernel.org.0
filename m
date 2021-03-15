Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B976433B316
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCOMzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCOMyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:54:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C33C061574;
        Mon, 15 Mar 2021 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hUmA3BEtzcJvz01TWYKXFbQSzi3Lt/8ZG4oFt7gXa3o=; b=LDzh+hErroH07/2l19Cc8w4NsG
        ukMfGjjv1ZLXtEiDSYHtYgOE61fEooSW6yl6nYmKra259al18sIGMgcv6lSOJx/sWbd0ESuMSnohE
        AJvjmCFzbMPyq+u0RpHtmoYqfKahvKPixclIb005c7/+IAobwcBZnMfI/ti9UdeexDue8yEzepCSc
        kxCTTs0UEbjcOHQUEqOb9rIooC0wCCpkEZuU3WQP14rEsRORD/hzucOsH7n0W1ls2LtISwvipdtih
        Xlbtbef+TST//pGjHM16t4AnVgO7yJyXDHg0h0yG/4mmvwqZnA26xBROyvCUZWAUxrLdg8ItU+LPj
        TetyiKmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLmk4-000BGZ-P8; Mon, 15 Mar 2021 12:54:43 +0000
Date:   Mon, 15 Mar 2021 12:54:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] vfs: Use the mounts_to_id array to do /proc/mounts
 and co.
Message-ID: <20210315125440.GV2577561@casper.infradead.org>
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
 <161581007628.2850696.11692651942358302102.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161581007628.2850696.11692651942358302102.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:07:56PM +0000, David Howells wrote:
> Use the mounts_to_id xarray added to the mount namespace to perform

You called it mounts_by_id in the last patch ...

> Since it doesn't trawl a standard list_head, but rather uses xarray, this
> could be done under the RCU read lock only.  To do this, we would need to
> hide mounts that are in the process of being inserted into the tree by
> marking them in the xarray itself or using a mount flag.

>  /* iterator; we want it to have access to namespace_sem, thus here... */
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {
> -	struct proc_mounts *p = m->private;
> -	struct list_head *prev;
> +	struct proc_mounts *state = m->private;
> +	void *entry;
>  
>  	down_read(&namespace_sem);
> -	if (!*pos) {
> -		prev = &p->ns->list;
> -	} else {
> -		prev = &p->cursor.mnt_list;
> +	state->xas = (struct xa_state) __XA_STATE(&state->ns->mounts_by_id, *pos, 0, 0);
>  
> -		/* Read after we'd reached the end? */
> -		if (list_empty(prev))
> -			return NULL;
> -	}
> +	entry = xas_find(&state->xas, ULONG_MAX);

I know you haven't enabled enough debugging because this will assert
that either the RCU read lock or the xa_lock is held to prevent xa_nodes
from disappearing underneath us.

Why do you want to use an xa_state for this?  This is /proc, so efficiency
isn't the highest priority.  I'd just use xa_find(), and then you don't
need to care about an xa_state or locking -- it handles taking the rcu
read lock for you.

> +	while (entry && xas_invalid(entry))

I've never seen anybody make that mistake before.  Good one.  Not sure
if there's anything I can do to prevent it in future.

> +		entry = xas_next_entry(&state->xas, ULONG_MAX);
