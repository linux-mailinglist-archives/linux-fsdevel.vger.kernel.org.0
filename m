Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995325B36F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgIBSIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 14:08:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25320 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgIBSIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599070094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLA4uym5kWLKQngGV6Z4QYoQU8o4rFo1yPttD4tVbVA=;
        b=Uy/pSIlOLYJFUlAgBzpyz1WZAzAQB0TBAkuWag+K1uemn8oS8+uPKjlXmogrZLSGT/FJ32
        jfLwVfzI+Q7NYW4Bba9NzTRMjUUg1pW8W9asCE4WOVaj3bpqWMA+myLHrPfRTlQOMlYRl+
        AyayPVuf1AIeDqeYs7wBdeviIV9tEog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-8ykxYfIxNDWYhPXluijvFQ-1; Wed, 02 Sep 2020 14:08:12 -0400
X-MC-Unique: 8ykxYfIxNDWYhPXluijvFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C82518A2257;
        Wed,  2 Sep 2020 18:08:11 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-152.rdu2.redhat.com [10.10.114.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A32615D9CC;
        Wed,  2 Sep 2020 18:08:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1A0B0223642; Wed,  2 Sep 2020 14:08:04 -0400 (EDT)
Date:   Wed, 2 Sep 2020 14:08:04 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] fuse: Add a flag FUSE_NONSHARED_FS
Message-ID: <20200902180804.GB1263242@redhat.com>
References: <20200901204045.1250822-1-vgoyal@redhat.com>
 <20200901204045.1250822-2-vgoyal@redhat.com>
 <CAJfpegtUMJqUDhFTePpFP=oQ=XGFj2tfvx+unV94sN3fFZbZHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtUMJqUDhFTePpFP=oQ=XGFj2tfvx+unV94sN3fFZbZHg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:57:07AM +0200, Miklos Szeredi wrote:
> On Tue, Sep 1, 2020 at 10:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > FUSE_NONSHARED_FS will signify that filesystem is not shared. That is
> > all fuse modifications are going thourgh this single fuse connection. It
> > should not happen that file's data/metadata changed without the knowledge
> > of fuse. Automatic file time stamp changes will probably be an exception
> > to this rule.
> >
> > If filesystem is shared between different clients, then this flag should
> > not be set.
> 
> I'm thinking maybe this flag should force some other parameters as well:

So you are thinking of fuse enforcing these parameters automatically
without server asking for it. IOW, override what server says about
following parameters and fuse sets their values if
FUSE_NONSHARED_FS is set?

Or should we recommend these for FUSE_NONSHARED_FS and let file server
specify all this.

> 
> ^FUSE_POSIX_LOCK

No remote posix locks. Makes sense. If filesystem is not shared then
there is no need of remote posix locks.

> ^FUSE_FLOCK_LOCKS

No remote BSD style file locks. If filesystem is not shared, then
local locks should work just fine.

> ^FUSE_AUTO_INVAL_DATA

This controls if page cache data should be invalidated upon mtime
change. For non shared fs, mtime should not change outside fuse, 
so makes sense to enforce ^FUSE_AUTO_INVAL_DATA.

> FUSE_EXPLICIT_INVAL_DATA

This tells fuse to not invalidate page cache and not truncate page cache
if attr->size or mtime change is detected. For non-shared fs we don't
expect attr->size or mtime to change, so it does not harm to enfroce
this.

> FUSE_CACHE_SYMLINKS

This caches readlink responses. Makes sense to enable it for
non shared fs. 

> attr_valid=inf
> entry_valid=inf

dentry and attr timeout being infinite should be good for performance
if filesystem is not shared.

> FOPEN_KEEP_CACHE

If this is not set, by default fuse invalidates page cache on open. Makes
sense to not flush page cache on open with FUSE_NONSHARED_FS.

> FOPEN_CACHE_DIR

Caching directory contents for FUSE_NONSHARED_FS makes sense too.

> 
> This would make sure that it's really only used in the non-shared case.

I am little afraid of enforcing this in fuse core because tomorrow
somebody will say hey I need hybrid mode where FUSE_NONSHARED_FS is
set but for some reason I want attrs to expire after some time. I 
don't have a good use case in my mind though.

If I were to choose, I will probably document it and suggest that
file servers sets all the above for the case of FUSE_NONSHARED_FS.

But I am also open to enforcing this in fuse core if you prefer
that option.

Thanks
Vivek

