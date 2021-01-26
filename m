Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4693042C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391799AbhAZPmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391730AbhAZPgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611675277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+sg4yNwZrAUtqGjsjAIZF/lC9W6Hi56SguvTv3qRusA=;
        b=FDAejDp4IMjtM0YgJfd1ly8cj3vX+L9tTvkjXSX8C2W6YKAMOw7F9zZXDuq9AACx/EUb6H
        0V+t3PsfIaXrbRzKrpHkRw0BjLewpWi+RClptpdGLO3NlQ+6IDJDpp10sZuXmVIZhqANH1
        7fow1/Oz3AcxY+OW2E/114WXbvOOXTo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-DRDSXN9RPWybRfw3Uf8I4A-1; Tue, 26 Jan 2021 10:34:36 -0500
X-MC-Unique: DRDSXN9RPWybRfw3Uf8I4A-1
Received: by mail-ed1-f72.google.com with SMTP id ck25so9505772edb.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 07:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sg4yNwZrAUtqGjsjAIZF/lC9W6Hi56SguvTv3qRusA=;
        b=sN+g/s29So1nlHr7WCVFFd8SpsiwmyA49iVFig+kh2AqYKZz149hDTIPJXvja9bZ0R
         nUogZ88gbHISNO92SelU+WHodVfCW25LpYzg3zMiNkOAeooyxR0GLx3zp1pphNKUhQcr
         kIeoC79fSs+lO2bf68M4orkVMjj49V2MmCbFKPDvUsoSVwqQb2wZmSQUQ2ZZZ0UFhsyP
         hic5f+VJzjdjQDnqc9e9YDrlO9bhyFY7513kWtqB7HlMvP3fEORs0mZdRHjpbE/aKACh
         Kr1RlDjG0wfYLrbBZA/ajSqlTmW6ywVoeXhMliqhNxXp2l4wFwNpKVqSg+bdz695w8fC
         MEoQ==
X-Gm-Message-State: AOAM532b12EJIqhVLax9Podk5sqxXruIzCz8ieH0KGxsPWitWhjAjzyJ
        BBvQe1xrYUr00bNriDHtSAobG11EeU/8KzsqhbwNf0LwmP4ZAh+/1/rwn1ZKXIC/I+A/lvae8/b
        /lW5v8UhQbnorN9O91dOUqGTDqow/QY6oUT02bzbEwQ==
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr2289503ejp.436.1611675275260;
        Tue, 26 Jan 2021 07:34:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSasZks4PL3NUJQfxg7We8UW4x28G54NbjOgDuCVAFpi7QKXrub9Pz5L3G6Ovg3Un+JLmrv6pQRbddbpD7RMI=
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr2289493ejp.436.1611675275099;
 Tue, 26 Jan 2021 07:34:35 -0800 (PST)
MIME-Version: 1.0
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161054970.2537118.5401048451896267742.stgit@warthog.procyon.org.uk> <20210126035928.GJ308988@casper.infradead.org>
In-Reply-To: <20210126035928.GJ308988@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 26 Jan 2021 10:33:59 -0500
Message-ID: <CALF+zOkNMHjtH+cZrGQFqbH5dD5gUpV+y3k-Bt31E35d4kn1oA@mail.gmail.com>
Subject: Re: [PATCH 25/32] NFS: Clean up nfs_readpage() and nfs_readpages()
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

On Mon, Jan 25, 2021 at 11:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 25, 2021 at 09:35:49PM +0000, David Howells wrote:
> > -int nfs_readpage(struct file *file, struct page *page)
> > +int nfs_readpage(struct file *filp, struct page *page)
>
> I appreciate we're inconsistent between file and filp, but we're actually
> moving more towards file than filp.
>
Got it, easy enough to change.

