Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D127E923
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgI3NCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 09:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729859AbgI3NCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:02:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601470950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOpIMFzvWStaJSxrSyETmaSNkRed1cLEtN/o+YLBBiI=;
        b=SncKxbEbIdG4pZGVAxR4/EnObvBiQ6gvX5FSma9AxNXfxgU/moHXAZFWi111KGaCP4XVqK
        wySbvGDmKzJbU9BnzezOCiB96Sh591zEh3V2Xbu0MiF+dUyYhMZHyCN+C6E1pMkB+N/dPl
        vh9Za7Sl2Z0tyTY1RdAY3L6sJNx/3KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-eAYeXKY4P7qHtyNSyLZi_g-1; Wed, 30 Sep 2020 09:02:27 -0400
X-MC-Unique: eAYeXKY4P7qHtyNSyLZi_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B6001040C36;
        Wed, 30 Sep 2020 13:02:26 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-155.rdu2.redhat.com [10.10.112.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 065767BE42;
        Wed, 30 Sep 2020 13:02:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 93757220203; Wed, 30 Sep 2020 09:02:22 -0400 (EDT)
Date:   Wed, 30 Sep 2020 09:02:22 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
Message-ID: <20200930130222.GA267985@redhat.com>
References: <20200929185015.GG220516@redhat.com>
 <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:35:57AM +0300, Amir Goldstein wrote:
> On Tue, Sep 29, 2020 at 9:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Following commit added a flag to invalidate guest page cache automatically.
> >
> > 72d0d248ca823 fuse: add FUSE_AUTO_INVAL_DATA init flag
> >
> > Idea seemed to be that for network file systmes if client A modifies
> > the file, then client B should be able to detect that mtime of file
> > change and invalidate its own cache and fetch new data from server.
> >
> > There are few questions/issues with this method.
> >
> > How soon client B able to detect that file has changed. Should it
> > first GETATTR from server for every READ and compare mtime. That
> > will be much stronger cache coherency but very slow because every
> > READ will first be preceeded by a GETATTR.
> >
> > Or should this be driven by inode timeout. That is if inode cached attrs
> > (including mtime) have timed out, we fetch new mtime from server and
> > invalidate cache based on that.
> >
> > Current logic calls fuse_update_attr() on every READ. But that method
> > will result in GETATTR only if either attrs have timedout or if cached
> > attrs have been invalidated.
> >
> > If client B is only doing READs (and not WRITEs), then attrs should be
> > valid for inode timeout interval. And that means client B will detect
> > mtime change only after timeout interval.
> >
> > But if client B is also doing WRITE, then once WRITE completes, we
> > invalidate cached attrs. That means next READ will force GETATTR()
> > and invalidate page cache. In this case client B will detect the
> > change by client A much sooner but it can't differentiate between
> > its own WRITEs and by another client WRITE. So every WRITE followed
> > by READ will result in GETATTR, followed by page cache invalidation
> > and performance suffers in mixed read/write workloads.
> >
> > I am assuming that intent of auto_inval_data is to detect changes
> > by another client but it can take up to "inode timeout" seconds
> > to detect that change. (And it does not guarantee an immidiate change
> > detection).
> >
> > If above assumption is acceptable, then I am proposing this patch
> > which will update attrs on READ only if attrs have timed out. This
> > means every second we will do a GETATTR and invalidate page cache.
> >
> > This is also suboptimal because only if client B is writing, our
> > cache is still valid but we will still invalidate it after 1 second.
> > But we don't have a good mechanism to differentiate between our own
> > changes and another client's changes. So this is probably second
> > best method to reduce the extent of issue.
> >
> 
> I was under the impression that virtiofs in now in the stage of stabilizing the
> "all changes are from this client and no local changes on server" use case.

Looks like that kubernetes is allowed to drop some files in host directory
while it is being shared with guest. And I will not be surprised that if
kata is already doing some very limited amount of modification on
directory on host.

For virtiofs we have both the use cases. For container images, "no
sharing" assumption should work probably reasonably fine. But then
we also need to address other use case of sharing volumes between
containers and there other clients can modify shared directory.

> Is that the case? I remember you also had an idea to communicate that this
> is the use case on connection setup time for SB_NOSEC which did not happen.

Given we have both the use cases and I am not 100% sure if kata is not
doing any modifications on host, I thought not to pursue this line of
thought that no modifications are allowed on host. It will be very
limiting if kata/kubernetes decide to drop small files or make other
small changes on host.

> 
> If that is the case, why use auto_inval_data at all for virtiofs and not
> explicit_inval_data?
> Is that because you do want to allow local changes on the server?

Yes. Atleast want to keep that possibility open. We know that there is
a demand for this other mode too.

If it ever becomes clear that for container image case we don't need
any modifications on server, then I can easily add an option to virtiofsd
and disable auto_inval_data for that use case. Having said that, we
still need to optimize auto_inval_data case. Its inconsistent with
itself. A client's own WRITE will invalidate its cache.

> 
> I wonder out loud if this change of behavior you proposed is a good opportunity
> to introduce some of the verbs from SMB oplocks / NFS delegations into the
> FUSE protocol in order to allow finer grained control over per-file
> (and later also
> per-directory) caching behavior.

May be. How will NFS delegation help with cache invalidation issue. I
mean if client B has the lease and modifying file, then client A will
still need to know when client B has modified the file and invalidate
its own caches.

I don't know anything about SMB oplocks and know very little about NFS
delegation.

Thanks
Vivek

