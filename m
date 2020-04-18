Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD91AF48A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDRUPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 16:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDRUPL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:15:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0B221D93;
        Sat, 18 Apr 2020 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587240910;
        bh=QodNS7jQf/8r+MmfUSCPPvm6Xo+BZcg9ZG7LxYlG7/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1G588uZCL+ntQx9O37pEdgratWOEUiY0XgcqjouFjHTDk60Q8SZ9dO5R43Wwu2Sri
         GuBcuHolcKslqCPkUrwfw8MN68Fl2XZQtOMBDOo4M7XhcydM4fRtwAPBvclYdJV7pX
         n9omhF7RhQuo8BbfifKQWybDRWiHpobeddl4xmKo=
Date:   Sat, 18 Apr 2020 13:15:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] ipc: Convert ipcs_idr to XArray
Message-Id: <20200418131509.fb3c19bf450d618be797c030@linux-foundation.org>
In-Reply-To: <20200326151418.27545-1-willy@infradead.org>
References: <20200326151418.27545-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Mar 2020 08:14:18 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The XArray has better loops than the IDR has, removing the need to
> open-code them.  We also don't need to call idr_destroy() any more.
> Allocating the ID is a little tricky due to needing to get 'seq'
> correct.  Open-code a variant of __xa_alloc() which lets us set the
> ID and the seq before depositing the pointer in the array.

hm, this goes rather deep.  Manfred & Davidlohr, are you able to run
this through some testing?

>
> ...
>
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -104,12 +104,20 @@ static const struct rhashtable_params ipc_kht_params = {
>  	.automatic_shrinking	= true,
>  };
>  
> +#ifdef CONFIG_CHECKPOINT_RESTORE

The code grew a few additional CONFIG_CHECKPOINT_RESTORE ifdefs. 
What's going on here?  Why is CRIU special in ipc/?

> +#define set_restore_id(ids, x)	ids->restore_id = x
> +#define get_restore_id(ids)	ids->restore_id
> +#else
> +#define set_restore_id(ids, x)	do { } while (0)
> +#define get_restore_id(ids)	(-1)
> +#endif

Well these are ugly.  Can't all this be done in C?

>
> ...
>
