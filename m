Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCD27E15F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgI3Gkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 02:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgI3Gkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:40:39 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB7C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 23:40:38 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id r78so167101vke.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tutwXlLRaCHmNunSZOUg3PFewrcSdlhQGYC1/N5DtJA=;
        b=avwq57Ap2/fV3ZAutyiFwEZ07ArfkXhlgtYTLYmfqV/wgNzcOMyRJYa3Y3QXcZwsZD
         Ow3RKKyFsBwNE4sa+z6K3fk+Rcki8+gUTV5Wql0HgoYLLjze6UcDyIkuYbyQMNCtardL
         YN0XrDBY/2Kvt+it57hvDhGO74D6Lcwe3MP1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tutwXlLRaCHmNunSZOUg3PFewrcSdlhQGYC1/N5DtJA=;
        b=Kj9sTKx1rF8/ajq6Kt+EKCrUGmMCZiLtebSIzdDwTQLadfOcxWNn4yNjJjNy4YvqJH
         ksjHjofPGP2+VDWWH7ul+RH9boci7En1P4XHXiNu2DY8Lnbh+frISHYDy1ci7KN9K4VE
         MKRfteEdFbywlPqZwK9MrFUmvrcdSkd7SSuorYSsCm/N6K9RaVrZdkj+5HnfTb9+ksAt
         DEtWI8HJD240CVy5j6wuME135eeQe+cY+DqUtY+K2WUXWtr/trPvSBqbXtwO2O0Ovshy
         VrvJvPoIUcOSdzfk9KdGFvvLIMqMzAtIwqUJfLwXt7zXkEkOf0Txcvnp+BhOzAgMbWYI
         gWNA==
X-Gm-Message-State: AOAM531cAyKWVZr0hcvEe2Tuz9QrBI3NaJIVzeV6MufdbF8KPWwhXgTm
        JgdupSEQUSJO79lFl6iK5vCyTm0JESjgFcczQGXDv6nVGNZs3g==
X-Google-Smtp-Source: ABdhPJyMVSpMmY2p/Qy8YeMjS07i+0uB+7Wc9oSnadh1jdANgSug9BbCyeZwyTiO5fBeJjAkLnNXR1NbQ5irVw6D9Cw=
X-Received: by 2002:a05:6122:45e:: with SMTP id f30mr491775vkk.15.1601448037398;
 Tue, 29 Sep 2020 23:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200929185015.GG220516@redhat.com> <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 08:40:26 +0200
Message-ID: <CAJfpegtH0TruLCnG_YJ8aUBHh7k5sqN_wVEegvDPJOoDcmwLSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Zhi Zhang <zhang.david2011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:36 AM Amir Goldstein <amir73il@gmail.com> wrote:

> I wonder out loud if this change of behavior you proposed is a good opportunity
> to introduce some of the verbs from SMB oplocks / NFS delegations into the
> FUSE protocol in order to allow finer grained control over per-file
> (and later also per-directory) caching behavior.

That would be really nice.  Let me find a recent discussion on this...
ah it was private.   Copying the thread below.  Thoughts?

Thanks,
Miklos

On Tue, Aug 11, 2020 at 8:56 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Aug 5, 2020 at 5:53 AM Zhi Zhang <zhang.david2011@gmail.com> wrote:
> > On Tue, Aug 4, 2020 at 11:36 AM Zhi Zhang <zhang.david2011@gmail.com> wrote:
> > > On Mon, Aug 3, 2020 at 6:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Thu, Jul 23, 2020 at 12:40 PM Zhi Zhang <zhang.david2011@gmail.com> wrote:
>
> > > > > We are using distributed filesystem ceph-fuse and we enabled writeback
> > > > > cache on fuse which improves the write performance, but the file's
> > > > > size attribute can't be updated on another client even if the users on
> > > > > this client only read this file.
> > > > >
> > > > > From my understanding, if the file is not opened in write mode and
> > > > > already writes its buffered data to userspace filesystem like
> > > > > ceph-fuse, then its state should be clean. The upper userspace and
> > > > > remote server should be responsible for the data and consistency. So
> > > > > at this moment fuse could trust the attributes from the server which
> > > > > has the most authoritative information about this file.
> > > > >
> > > > > Please let me know your thoughts, then I can work on this patch. Thanks.
> > > >
> > > > Hi,
> > > >
> > > > Something like this makes sense, but I think we should be adding an
> > > > explicit state (a lease to read/write the data) to the fuse inode.
> > > >
> > > > Opening for write would automatically acquire the WRITE lease,
> > > > similarly opening for read would acquire the READ lease.  Then we need
> > > > a new notification for revoking a lease (FUSE_NOTIFY_REVOKE).  And we
> > > > need a new request for re-acquiring a lease (FUSE_REACQUIRE).
> > > >
> > > > Does that make sense?
> > > >
> > > > Would you mind discussing this on the linux-fsdevel mailing lists?
> > > >
> > > > Thanks,
> > > > Miklos>
> > Hi Miklos,
> >
> > Thanks for the comments. I thought about it but I still have a couple
> > of questions about the lease.
> >
> > 1. After acquiring a WRITE lease, when should we release(revoke) it?
> > Before I assumed the file would be clean once we wrote buffered data
> > to the userspace file system. Now if we introduce the lease, should we
> > release the WRITE lease once we write the buffered data or we need to
> > wait for the revoking notification from userspace file system?
>
> I think it's easier to wait for the notification, instead of trying to
> guess.   When the file is closed (released) then the lease is also
> implicitly released.
>
> > 2. What is the purpose of READ lease?
> > Once we hold the READ lease, we could trust cached attributes and data
> > until revoking notification from userspace file system?
>
> Yes.
>
> > 3. What is the purpose of re-acquiring a lease and why do we need a new request?
> > From my understanding, the lease mechanism is only known by kernel
> > fuse, not for libfuse.
>
> We don't necessarily need a new request, it could be implicit in the
> first uncached write.
>
> > To re-acquire a lease here is actually for READ
> > lease by sending a sync getattr request.
>
> Yes.
>
> Thanks,
> Miklos
