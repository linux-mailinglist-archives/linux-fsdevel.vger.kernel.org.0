Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDFB30427F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405997AbhAZP1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406262AbhAZP1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611674735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJe0QMue+MrGLDqG9YMY3B8wc1OhQAcndv4QLZtzS5Q=;
        b=XZ4XXj3RQLC1MO2SguWy4v0N70WOJeihrwJLp9EUo0FQGg6WKggxCwuXGWAbRj/NK7KvNM
        iwefUJ3F/Vd7atA9uc4ZYFT8TB3DqCEy776Xvw1B7E14LwCX1X8qgI7bRONVnJyXEs9PA5
        /25prPZfK8AAHBsW9+lbLL8upw+Ss3I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-Dz57Ho37OqCrrf9cMYaH9A-1; Tue, 26 Jan 2021 10:25:33 -0500
X-MC-Unique: Dz57Ho37OqCrrf9cMYaH9A-1
Received: by mail-ed1-f70.google.com with SMTP id m16so9489779edd.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 07:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJe0QMue+MrGLDqG9YMY3B8wc1OhQAcndv4QLZtzS5Q=;
        b=PQ9Al3TeRJSrBEAvRJ9zZZqGkFOAgpZxNBJP5MsgWr09rQxrx2M1ZN7gru6qhAcbv0
         XA9S7ESRB8HTP+MDhnrVSIMlivs9JrwJDGkPewGnK+R2qJkw8ehxPQxfmqB2124ZQxo3
         sFVIeKTp95AflVU2J8q6IMS3nC1Gy0tqJizyILo3HAXL3W76xz5OpSUV5GaNhe8/imaX
         NxM+QbBZBIplzUxrBi1hcgwNTI4l75xorWCskyI6XxI7NMjo8SwqH3U43xPTkULFr8qx
         bJ3kaHrsgTj2ie+AMAejZFApD3uxR8oiRcLesGMgZ2iIsaYr6jwVICIi6In9ND8cE+xS
         /vTg==
X-Gm-Message-State: AOAM531SSmYH19uUKE5zls2kcOhdTDqUmXv6OF/V0E3iw6KNDupj2LKg
        F4dcIAkF7QE9ok8oTdq0KHegnwrypEJyoEcTz2VGtjTIoHD2NYWtpBfKbL8pdvRJF2ODWlYMG7/
        QETvxHVjfdnsDkl8CIJsrp1uU0pAR4Of+HT2pKsk1DQ==
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr5114898edc.344.1611674731921;
        Tue, 26 Jan 2021 07:25:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlAcqaq8CqekYAOTl5XTKJw4byUxjRunvP1wQKBAqraCVAKiDEx3Vt3nz1iiXtLgQBV8BZqw1Aaq6eAK2Q72M=
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr5114888edc.344.1611674731765;
 Tue, 26 Jan 2021 07:25:31 -0800 (PST)
MIME-Version: 1.0
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161057357.2537118.6542184374596533032.stgit@warthog.procyon.org.uk> <20210126040540.GK308988@casper.infradead.org>
In-Reply-To: <20210126040540.GK308988@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 26 Jan 2021 10:24:55 -0500
Message-ID: <CALF+zOn80NoeaBW8i9djC8qBCEng7riaHgz77uhxipaZ+RJ5ew@mail.gmail.com>
Subject: Re: [PATCH 27/32] NFS: Refactor nfs_readpage() and
 nfs_readpage_async() to use nfs_readdesc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:06 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 25, 2021 at 09:36:13PM +0000, David Howells wrote:
> > +int nfs_readpage_async(void *data, struct inode *inode,
> >                      struct page *page)
> >  {
> > +     struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
>
> You don't need a cast to cast from void.
>
Right, fixing.

> > @@ -440,17 +439,16 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
> >       if (ret == 0)
> >               goto read_complete; /* all pages were read */
> >
> > -     desc.pgio = &pgio;
> > -     nfs_pageio_init_read(&pgio, inode, false,
> > +     nfs_pageio_init_read(&desc.pgio, inode, false,
>
> I like what you've done here, embedding the pgio in the desc.
>
Thanks for the review!

