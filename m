Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6984A42424E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhJFQPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 12:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbhJFQPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633536788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Hr32Rxp6Zbw+fFtmt7vxzLwUTdA6hQILiEN5RHx0Z4=;
        b=Vk+raucX8A9u7Jn7JEQUPlUBrUFzYH6SXIXsm5VjwYns4SAGGLPsarkV4eGhwFLbtCeHhU
        tNc2qhZmjjy3YzNCXRQngZkNIR5ZL5gIKAmI7UhPYZQmZi7Cb8PnaiVW/5qfqGfxRAJ5Wl
        fpJfKN7Snux/BM5AUE5f+dlmtQIAwv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Lu5yf6gHMgq08A2f5OtLrg-1; Wed, 06 Oct 2021 12:13:07 -0400
X-MC-Unique: Lu5yf6gHMgq08A2f5OtLrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA6F6802C88;
        Wed,  6 Oct 2021 16:13:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0898B1002391;
        Wed,  6 Oct 2021 16:12:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9225A220BDB; Wed,  6 Oct 2021 12:12:52 -0400 (EDT)
Date:   Wed, 6 Oct 2021 12:12:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
Message-ID: <YV3LBNM3jnGBBzwS@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
 <20210930143850.1188628-8-vgoyal@redhat.com>
 <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:02:36PM +0200, Miklos Szeredi wrote:
> On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> > sent by file server to signifiy that a previous locking request has
> > completed and actual caller should be woken up.
> 
> Shouldn't this also be generic instead of lock specific?
> 
> I.e. generic header  + original outarg.

Hi Miklos,

I am not sure I understand the idea. Can you please elaborate a bit more.

IIUC, "fuse_out_header + original outarg"  is format for responding
to regular fuse requests. If we use that it will become like responding
to same request twice. First time we responded with ->error=1 so that
caller can wait and second time we respond with actual outarg (if
there is one depending on the type of request).

IOW, this will become more like implementing blocking of request in
client in a more generic manner.

But outarg, depends on type of request (In case of locking there is
none). And outarg memory is allocated by driver and filled by server.
In case of notifications, driver is allocating the memory but it
does not know what will come in notification and how much memory
to allocate. So it relies on device telling it how much memory
to allocate in general so that bunch of pre-defined notification
types can fit in (fs->notify_buf_size).

I modeled this on the same lines as other fuse notifications where
server sends notifications with following format.

fuse_out_header + <structure based on notification type>

out_header->unique is 0 for notifications to differentiate notifications
from request reply.

out_header->error contains the code of actual notification being sent.
ex. FUSE_NOTIFY_INVAL_INODE or FUSE_NOTIFY_LOCK or FUSE_NOTIFY_DELETE. 
Right now virtiofs supports only one notification type. But in future
we can introduce more types (to support inotify stuff etc).

In short, I modeled this on existing notion of fuse notifications
(and not fuse reply). And given notifications are asynchronous,
we don't know what were original outarg. In fact they might
be generated not necessarily in response to a request. And that's
why this notion of defining a type of notification (FUSE_NOTIFY_LOCK)
and then let driver decide how to handle this notification.

I might have completely misunderstood your suggestion. Please help
me understand.

Thanks
Vivek

