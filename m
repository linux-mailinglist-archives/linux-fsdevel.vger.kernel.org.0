Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8F307FDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhA1Utm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 15:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhA1Uta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:49:30 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF979C061574;
        Thu, 28 Jan 2021 12:48:49 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n2so7031215iom.7;
        Thu, 28 Jan 2021 12:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdoEjK6WmyZe9D8sv9PM+Lkh5UShPE1H2BMAI6rL4mM=;
        b=bEMcf+0G8+LpCT33Bdzu4oxYnH9lg3WhORjDhmjqZJlvu8/SjAvLA/ulKCX/guPcj9
         AXGe6k4RGTPTqLkx6iw1P5zr+U92ek2+wRE11YCfS4oVqIj1uD65nTtHc7su2thWHY7p
         Rtx1e60brbze3+EfTgtMntaESUSjFNxMF4LmYP38B38sw6O3J7/5p4eY0IxKrmfv20C8
         wzSklEl6HcSYG6TeQ/fO36tAh8XADiyKrgC31A+4Ua2XLCZJl9avNkQ+vY3mB7EmS4x6
         pIzsUolto0uGdywGMgC0xGXDqAa2QfpTW+fgysNV8IhykCpAjDfOTSi97md1bHkXhETm
         lWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdoEjK6WmyZe9D8sv9PM+Lkh5UShPE1H2BMAI6rL4mM=;
        b=qXvjXevzlnDj3NY3fsQqA5oUEnFWjdPKOlbcv/nkPtDgAQifj5pq9EDXo/n6U6Vznp
         OSFrPRGX/HEPpDI7YJl2tpR2IgHbDHrQO+va0Lsb0y9fJLVzEJwUj4CHWk8YTWd6Jy6w
         ldRB0Tu8VTonh5X24ZBwsk+P2FVvmmzm+oB0BL3kXXcGDMp0RLCsa2RJy6HOgGJu+sIc
         ycmStlRJuQNtrpsCDnw1PNZaNJLlOZFsZpKDJV8Yrvr/jfNdd4rDKmuTwrxokWvzfr/x
         1lmwsMvk0KsAXjRymnT1b+W8x5YFLtukNRu+a1P4JYeM767emPiQuKln0YmH1zo9oy7j
         CMmw==
X-Gm-Message-State: AOAM5325JFKx7b+LjMKD+ShewsRJ3yhFsgUFP9kGzfvjvtG3Iv8m+u5j
        IZDAY9cYZs3P4lmvp9dJPgGYn0akzQEvcAv7lcrU7MPeHBw=
X-Google-Smtp-Source: ABdhPJwEfQfxpnmTaXxKdFQhLhUuZKcJjUgIqb4XWB6FsQSdQVE00jXzdZ/moiHqw0bN9zCv9h/LM28RVuL5Uoy9YRA=
X-Received: by 2002:a6b:2bca:: with SMTP id r193mr1102442ior.167.1611866929271;
 Thu, 28 Jan 2021 12:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20210126134103.240031-1-jlayton@kernel.org> <CAOi1vP-3Ma4LdCcu6sPpwVbmrto5HnOAsJ6r9_973hYY3ODBUQ@mail.gmail.com>
 <2301cde67ae7aa54d860fc3962aeb8ed85744c75.camel@kernel.org>
In-Reply-To: <2301cde67ae7aa54d860fc3962aeb8ed85744c75.camel@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 28 Jan 2021 21:48:44 +0100
Message-ID: <CAOi1vP_7dfuKgQxFpyeUDMJBGm=cnQSvYHDnU=6YPTzbB9+d6w@mail.gmail.com>
Subject: Re: [PATCH 0/6] ceph: convert to new netfs read helpers
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ceph Development <ceph-devel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 1:52 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2021-01-27 at 23:50 +0100, Ilya Dryomov wrote:
> > On Tue, Jan 26, 2021 at 2:41 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > This patchset converts ceph to use the new netfs readpage, write_begin,
> > > and readahead helpers to handle buffered reads. This is a substantial
> > > reduction in code in ceph, but shouldn't really affect functionality in
> > > any way.
> > >
> > > Ilya, if you don't have any objections, I'll plan to let David pull this
> > > series into his tree to be merged with the netfs API patches themselves.
> >
> > Sure, that works for me.
> >
> > I would have expected that the new netfs infrastructure is pushed
> > to a public branch that individual filesystems could peruse, but since
> > David's set already includes patches for AFS and NFS, let's tag along.
> >
> > Thanks,
> >
> >                 Ilya
>
> David has a fscache-netfs-lib branch that has all of the infrastructure
> changes. See:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib

I saw that, but AFAICS it hasn't been declared public (as in suitable
for other people to base their work on, with the promise that history
won't get rewritten.  It is branched off of what looks like a random
snapshot of Linus' tree instead of a release point, etc.

Thanks,

                Ilya
