Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF63A78CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFOIMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFOIMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:12:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513BC061574;
        Tue, 15 Jun 2021 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ft7zLdSFViq5Zhgyf9n/exouydex1YshFu8BNksbfwQ=; b=C7jfShJA/fcRdtSMHpbZHySmb/
        WFs85u/T+34HKcy1G3eMMoNS/Owe/pGk+f0gfso8LrHu1LfwH3wMiJQBVfCMNQpZpkmUWVhW3W/+X
        G++n/H9ULFucSpaH48zk75XmzBzTQtH+KTxQQvjXWVn8Lr7zGnb6L/C8j/BDZG39aKJ7cRp8Zuviw
        DK1IHclFVPvqBW+eXDoIqGJVX8b38l587dSVlgvskA8L1A3GUvj2CMSKJjAJ7gqKNW+Svm2a4SGd9
        wNWfHJXzdAaH9DLf+EmopGfnqjb2toawR5ZTgLaTLaqCZOuaEWGJqa6XKRmj5OhKpo4o+owYIQ40l
        vSUJXiaA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt498-006EOQ-8H; Tue, 15 Jun 2021 08:10:10 +0000
Date:   Tue, 15 Jun 2021 09:10:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com,
        stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com
Subject: Re: [PATCH v4 02/10] cifsd: add server handler
Message-ID: <YMhgXsAez9jmeUkW@infradead.org>
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
 <CGME20210602035815epcas1p18f19c96ea3d299f97a90d818b83a3c85@epcas1p1.samsung.com>
 <20210602034847.5371-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602034847.5371-3-namjae.jeon@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 12:48:39PM +0900, Namjae Jeon wrote:
> +/* @FIXME clean up this code */

Hmm, should that be in a submitted codebase?

> +#define DATA_STREAM	1
> +#define DIR_STREAM	2

Should this use a named enum to document the usage a bit better?

> +#ifndef ksmbd_pr_fmt
> +#ifdef SUBMOD_NAME
> +#define ksmbd_pr_fmt(fmt)	"ksmbd: " SUBMOD_NAME ": " fmt
> +#else
> +#define ksmbd_pr_fmt(fmt)	"ksmbd: " fmt
> +#endif
> +#endif

Why not use the pr_fmt built into pr_*?  With that all the message
wrappers except for the _dbg one can go away.

Also can you please decided if this is kcifsd or ksmbd?  Using both
names is rather confusing.

> +#ifndef ____ksmbd_align
> +#define ____ksmbd_align		__aligned(4)
> +#endif

No need for the ifndef and all the _ prefixes.  More importantly from
a quick look it seems like none of the structures really needs the
attribute anyway.

> +#define KSMBD_SHARE_CONFIG_PATH(s)				\
> +	({							\
> +		char *p = (s)->____payload;			\
> +		if ((s)->veto_list_sz)				\
> +			p += (s)->veto_list_sz + 1;		\
> +		p;						\
> +	 })

Why no inline function?

> +/* @FIXME */
> +#include "ksmbd_server.h"

???
