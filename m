Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7945888E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhKVERQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 23:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhKVERP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 23:17:15 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21FFC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Nov 2021 20:14:09 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v203so10029668ybe.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Nov 2021 20:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ufl+2uObLITemAu7uloYFsoe/3xNUfHY/I0EtFNIV8Y=;
        b=5aecOjRkc9aLOLkzu2uDthsl37YvSVjvTyMWLPECyRTFNifHUei2xI+c6kJSnkBbXA
         dL6NCp9o/kTrwsLDBOXgNmJAzPkSzHZx2fy0zC/Vzs4ZehwydwyZzXIa1CUe15+gDHOo
         CWP/bEvLLQADhSE3EC0/Fot+hgUFPn79xZtCFbbOZ1SECjdtA7rWVeooExU8Lv4cyOgs
         rK4adpXz4mUFyhb+x8qXpUt5mgMCg6E/S7jWk0cn7wdu7VW6A63J2g/K+xYIG6DM9Wya
         2GQvPfznECSNNgZOXK0/OhvPq3LE79eRHwmkUs4CCzXaBUkZqoq7PtwX/cBFGeDXOM+G
         IAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ufl+2uObLITemAu7uloYFsoe/3xNUfHY/I0EtFNIV8Y=;
        b=7rE2Bm4vIVpSvFoaZHImAKV47p0mi9EDlkRdeAzhJwNDXQYmYRsoiRyZGl8VJEElWZ
         nk9K4jjnDo/ns39mrasn6Vha+JPDxkCRznbe3XlYbDs+DTnG0bXtx0iWwuP3VBjHlV2q
         wwVYq4pvdODBtkuSVN95blRyIn+Ut2V9jPW9XxF6F8rhbn9Cd7ooPiAttThdL6nh1Pdt
         LDIFrEF3LTF5H6SCMMh1UfdsymR7m6qpGL6UvNdBIsyxsBBxHd6TrNwW9xV/jJdEDOzw
         PMBZ729Kh+G7B94ZqMoImPpSwuozXp76lo1+pBKg4ftfe+2Pa9YRNkz0a9eArTFoNofs
         M3pA==
X-Gm-Message-State: AOAM531RhcJidTv548Kujo3DJsEXFJtgyImBZ5pZ2R7Tor2imd6wCAZF
        c/6eHz/nbrrQOQmmPJ09qlQlIjGMRhALNhfLrXurnQ==
X-Google-Smtp-Source: ABdhPJxewORqZoBMGaaxO4om0D8FAxIpf6byiMm6K3qnsT6twjozIDqCQveLRQqVrpnPUKnBAObQHoXwFPuAkibE3o0=
X-Received: by 2002:a25:b0a8:: with SMTP id f40mr56470993ybj.125.1637554448962;
 Sun, 21 Nov 2021 20:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20211119041104.27662-1-songmuchun@bytedance.com>
 <YZdQ+0D7n5xCnw5A@infradead.org> <20211119145643.21bbd5ee8e2830dd72d983e3@linux-foundation.org>
In-Reply-To: <20211119145643.21bbd5ee8e2830dd72d983e3@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 22 Nov 2021 12:13:33 +0800
Message-ID: <CAMZfGtV7pNaVNtzPCmXnGgeojPzyVxXSeawnp5znJxkjFweAgA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: proc: store PDE()->data into inode->i_private
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        gladkov.alexey@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 20, 2021 at 6:56 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 18 Nov 2021 23:23:39 -0800 Christoph Hellwig <hch@infradead.org> wrote:
>
> > On Fri, Nov 19, 2021 at 12:11:04PM +0800, Muchun Song wrote:
> > > +
> > > +/*
> > > + * Obtain the private data passed by user through proc_create_data() or
> > > + * related.
> > > + */
> > > +static inline void *pde_data(const struct inode *inode)
> > > +{
> > > +   return inode->i_private;
> > > +}
> > > +
> > > +#define PDE_DATA(i)        pde_data(i)
> >
> > What is the point of pde_data?
>
> It's a regular old C function, hence should be in lower case.
>
> I assume the upper case thing is a holdover from when it was
> implemented as a macro.
>
> >  If we really think changing to lower
> > case is worth it (I don't think so, using upper case for getting at
> > private data is a common idiom in file systems),
>
> It is?  How odd.
>
> I find the upper-case thing to be actively misleading.  It's mildly
> surprising to discover that it's actually a plain old C function.
>
> > we can just do that
> > scripted in one go.
>
> Yes, I'd like to see a followup patch which converts the current
> PDE_DATA() callsites.
>

You mean replace all PDE_DATA with pde_data in another patch?

Thanks.
