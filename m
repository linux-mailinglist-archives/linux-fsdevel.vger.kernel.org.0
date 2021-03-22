Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30077344558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhCVNQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhCVNOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:14:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B200C061762;
        Mon, 22 Mar 2021 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyQ3noBGBl7to0Ak709SJOEr1ptQB/CJ1kxoLr54qT0=; b=edSZN6BOpAbq5FBQQED410br1I
        nNsiy00bAQ3OUcYzccL77Cbmmu7+y++WWG/0mXFTh7DHsjhiXjz632U0FBbKu7Vna+QF2hAvyz30B
        2udCgvhVRUMTIR4vOG93bJ+t61y4KQ5/Vyh5Ja3RRslUEFlOkScXT04AlrE3/gmBMebZlvmhq3TNf
        irv8tjdsheQBjYUQZNtaD0EPuCZvtS+VsHQuX4Up1T+0vT/uAdLvpcKAJFkQzrrVnPajt3WABKJNx
        ux0XzLlWRz1avusjMTJt5y4B1u/WrVF2FXw0PDKGjxWe/5nE/6zi//4NR9uF5szM5qkT3n3VRNHD8
        f4s3rs/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOKMO-008YL0-9B; Mon, 22 Mar 2021 13:13:00 +0000
Date:   Mon, 22 Mar 2021 13:12:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        hyc.lee@gmail.com, viro@zeniv.linux.org.uk, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Message-ID: <20210322131244.GM1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com>
 <20210322083445.GJ1719932@casper.infradead.org>
 <YFhw932H8BZalhmu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhw932H8BZalhmu@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:27:03PM +0900, Sergey Senozhatsky wrote:
> On (21/03/22 08:34), Matthew Wilcox wrote:
> > > +++ b/fs/cifsd/mgmt/ksmbd_ida.c
> > > @@ -0,0 +1,69 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
> > > + */
> > > +
> > > +#include "ksmbd_ida.h"
> > > +
> > > +struct ksmbd_ida *ksmbd_ida_alloc(void)
> > > +{
> > > +	struct ksmbd_ida *ida;
> > > +
> > > +	ida = kmalloc(sizeof(struct ksmbd_ida), GFP_KERNEL);
> > > +	if (!ida)
> > > +		return NULL;
> > > +
> > > +	ida_init(&ida->map);
> > > +	return ida;
> > > +}
> >
> > ... why?  Everywhere that you call ksmbd_ida_alloc(), you would
> > be better off just embedding the struct ida into the struct that
> > currently has a pointer to it.  Or declaring it statically.  Then
> > you can even initialise it statically using DEFINE_IDA() and
> > eliminate the initialiser functions.
> 
> IIRC this ida is per SMB session, so it probably cannot be static.

Depends which IDA you're talking about.

+struct ksmbd_conn *ksmbd_conn_alloc(void)
+	conn->async_ida = ksmbd_ida_alloc();
Embed into 'conn'.

+static struct ksmbd_ida *ida;
+int ksmbd_ipc_init(void)
+	ida = ksmbd_ida_alloc();
Should be static.

> And Windows, IIRC, doesn't like "just any IDs". Some versions of Windows
> would fail the session login if server would return the first id == 0,
> instead of 1. Or vice versa. I don't remember all the details, the last
> time I looked into this was in 2019.

Sure, you can keep that logic.

> > ... walk the linked list looking for an ID match.  You'd be much better
> > off using an allocating XArray:
> > https://www.kernel.org/doc/html/latest/core-api/xarray.html
> 
> I think cifsd code predates XArray ;)

Sure, but you could have used an IDR ;-)

> > Then you could lookup tree connections in O(log(n)) time instead of
> > O(n) time.
> 
> Agreed. Not sure I remember why the code does list traversal here.
