Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE454240A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhJFPC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238436AbhJFPC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633532466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3H2QMb00dsRMTOZaX2va4UjRstVXRokvJ2b1tGr8Rk=;
        b=BXS8pHL/ssrykdvt+BgsqajuIbTIomrnwXvUkHRJa2NGoOG0LUEd/pa30lq/nFwDKrtjL+
        EjM3JltHQ1DSjlE0UKF4qW7Zwx5E/m+0DTYRcLR2Au5G+IlpItNnvQbHVFMFEtHvEsY5hc
        gvwl+eGrRf2Y3h/hPDVMzABfqkcDr6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564--ie1wfbiPhu-ODUClHHOeA-1; Wed, 06 Oct 2021 11:01:05 -0400
X-MC-Unique: -ie1wfbiPhu-ODUClHHOeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FEBF100C662;
        Wed,  6 Oct 2021 15:01:04 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2B69AA22;
        Wed,  6 Oct 2021 15:01:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 89540220BDB; Wed,  6 Oct 2021 11:01:03 -0400 (EDT)
Date:   Wed, 6 Oct 2021 11:01:03 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
Message-ID: <YV26L03HvAfMd/VC@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
 <20210930143850.1188628-8-vgoyal@redhat.com>
 <CAJfpegu5Y5X_CcKS9hsoW3ao5+WPJjm-6hsMVEiGU8PjSKy2gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu5Y5X_CcKS9hsoW3ao5+WPJjm-6hsMVEiGU8PjSKy2gg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:55:16PM +0200, Miklos Szeredi wrote:
> On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> > sent by file server to signifiy that a previous locking request has
> > completed and actual caller should be woken up.
> >
> > As of now we don't support blocking variant of posix locks and daemon
> > returns -EOPNOTSUPP. Reason being that it can lead to deadlocks.
> > Virtqueue size is limited and it is possible we fill virtqueue with
> > all the requests of fcntl(F_SETLKW) and wait for reply. And later a
> > subsequent unlock request can't make progress because virtqueue is full.
> > And that means F_SETLKW can't make progress and we are deadlocked.
> >
> > This problem is not limited to posix locks only. I think blocking remote
> > flock and open file description locks should face the same issue. Right
> > now fuse does not support open file description locks, so its not
> > a problem. But fuse/virtiofs does support remote flock and they can use
> > same mechanism too.
> >
> > Use notification queue to solve this problem. After submitting lock
> > request device will send a reply asking requester to wait. Once lock is
> > available, requester will get a notification saying lock is available.
> > That way we don't keep the request virtueue busy while we are waiting for
> > lock and further unlock requests can make progress.
> >
> > When we get a reply in response to lock request, we need a way to know
> > if we need to wait for notification or not. I have overloaded the
> > fuse_out_header->error field. If value is ->error is 1, that's a signal
> > to caller to wait for lock notification. Overloading ->error in this way
> > is not the best way to do it. But I am running out of ideas.
> 
> Since all values besides -511..0 are reserved this seems okay.
> However this needs to be a named value and added to uapi/linux/fuse.h.

Ok, I will define this value and put in uapi/linux/fuse.h. 

Thanks
Vivek

