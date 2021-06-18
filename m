Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146AD3ACB5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFRMz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 08:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhFRMz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624020798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7yYJwP0hLqEgWbtE3UdqtU4/CGBcO2PNzuDJpFqL/M=;
        b=QPj8TCGz5j/mTuxVjPdsSaAfMuOiSzpwdUkGxet16UsM3OYegdK5ZNGkAOpbTn0IsjKGQ8
        AVGWWuRJJ1DA7pyW8BYT11L9eC8bkwYjBfnWxK8yM3zcngK191CLJINKjsZH0cr1CdemCb
        3Pb7/Mms+RUfLQjPmzSvlXQL99La+Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ZLKhS9mkOo-68xNIRpssBA-1; Fri, 18 Jun 2021 08:53:16 -0400
X-MC-Unique: ZLKhS9mkOo-68xNIRpssBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5327B100C611;
        Fri, 18 Jun 2021 12:53:15 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-2.rdu2.redhat.com [10.10.114.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD50B60FC2;
        Fri, 18 Jun 2021 12:53:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 65EBC22054F; Fri, 18 Jun 2021 08:53:08 -0400 (EDT)
Date:   Fri, 18 Jun 2021 08:53:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2 1/2] init/do_mounts.c: Add a path to boot from tag
 based filesystems
Message-ID: <20210618125308.GB1234055@redhat.com>
References: <20210614174454.903555-1-vgoyal@redhat.com>
 <20210614174454.903555-2-vgoyal@redhat.com>
 <CAJfpeguD+F3Ai01=-JYNTKS4LP4d879=+8T7eOBewZpevTRbJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguD+F3Ai01=-JYNTKS4LP4d879=+8T7eOBewZpevTRbJg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 09:07:14AM +0200, Miklos Szeredi wrote:
> On Mon, 14 Jun 2021 at 19:45, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > We want to be able to mount virtiofs as rootfs and pass appropriate
> > kernel command line. Right now there does not seem to be a good way
> > to do that. If I specify "root=myfs rootfstype=virtiofs", system
> > panics.
> >
> > virtio-fs: tag </dev/root> not found
> > ..
> > ..
> > [ end Kernel panic - not syncing: VFS: Unable to mount root fs on
> > +unknown-block(0,0) ]
> >
> > Basic problem here is that kernel assumes that device identifier
> > passed in "root=" is a block device. But there are few execptions
> > to this rule to take care of the needs of mtd, ubi, NFS and CIFS.
> >
> > For example, mtd and ubi prefix "mtd:" or "ubi:" respectively.
> >
> > "root=mtd:<identifier>" or "root=ubi:<identifier>"
> >
> > NFS and CIFS use "root=/dev/nfs" and CIFS passes "root=/dev/cifs" and
> > actual root device details come from filesystem specific kernel
> > command line options.
> >
> > virtiofs does not seem to fit in any of the above categories. In fact
> > we have 9pfs which can be used to boot from but it also does not
> > have a proper syntax to specify rootfs and does not fit into any of
> > the existing syntax. They both expect a device "tag" to be passed
> > in a device to be mounted. And filesystem knows how to parse and
> > use "tag".
> >
> > So there seem to be a class of filesystems which specify root device
> > using a "tag" which is understood by the filesystem. And filesystem
> > simply expects that "tag" to be passed as "source" of mount and
> > how to mount filesystem using that "tag" is responsibility of filesystem.
> >
> > This patch proposes that we internally create a list of filesystems
> > which pass a "tag" in "root=<tag>" and expect that tag to be passed
> > as "source" of mount. With this patch I can boot into virtiofs rootfs
> > with following syntax.
> >
> > "root=myfs rootfstype=virtiofs rw"
> 
> The syntax and the implementation looks good.
> 
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks Miklos. Now Christoph has come up with another patch series to
achieve the same. And that patches series looks better than my patches.

https://lore.kernel.org/linux-fsdevel/20210617153649.1886693-1-hch@lst.de/

There are couple of minor issues to be taken care of. I am hoping after
that these patches can be merged.

Thanks
Vivek

