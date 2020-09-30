Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54C27E95C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgI3NTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 09:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3NTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:19:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A49C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 06:19:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z13so1726781iom.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9y/NrQkvBcTIO38IEefBh6luJqTwIynmmO+fo3HHumA=;
        b=h9ohypAw2YRdJXKtfUNajPWTrVxC1ZFH5jZ/TV+PXZ9vnccTY3Lj6CuUmGJS8vTh/O
         AQ64N6lZHOaJV3ONeCZVkt7WrcEPT6JLhDC8Ovi8l5k3oerHTOxv+MFM94C1RKPb6Shj
         Te3DKoNdmi6VxVILK+uj9Dp3TO8PMGk5AE3dyuAInbi8xWQ8Bz7UnoaDjY6ev7ZCEYbV
         0OzQRIYxBlZ708SxwVLEv4izi0Vge7YeEs87XhEWrnBIbqLJie2mLnjv5WrqQ4qFukun
         fr+OZyZL4dvw3FPHXkHRfoRBJZr5QQPTjzHOFwiq+p8wHo+JZ32WP7FQ3WPJGZLGDAdU
         00bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9y/NrQkvBcTIO38IEefBh6luJqTwIynmmO+fo3HHumA=;
        b=UsjYJfKSbIfljK8p3vFaNovzkvCGWzHfVTAeok/dM/79YSFoXeD1Ty92KcRmNT2YHc
         3e098eRxE4MXM7CwnHtiyh6wPcH18KrNXHoC78L4AWs5swNf6JGXV6Jj7o4VHQuzMeb0
         6F/NvqePvDKiBIHeFz/hwMnGpZQovtofU6L02WIOejQijtS0v+n3yjDw35psQg388+So
         b3ATQsG9sQRlKnUuvl+MRLMYQ++30ODa1eSQ+/bekh57IhdttHSK577CWfDu+lk1rNdA
         f2qVOVpcSik0v6OYvIbxzlrO5lnKjLR6rCGIq420hA0Zp+jVIAE1FW6Ir9PSdmzvAiZu
         Pn/Q==
X-Gm-Message-State: AOAM530F2gS0+7gMmNEemhh7mPG8m1m6OVhk4obZA421m/ZnxTfG8XVA
        GxoFH12nhZkc1Rl1qiAFk9vk877zbOQMhn4aBws=
X-Google-Smtp-Source: ABdhPJy119rK67QuWjsf/goWNCIUWxHbQXZmvHr4VaIdXg7lBdDuUcT+j9brJH1jkdft8VYivAh7CzsY0gadMcHcurA=
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr1655796iow.64.1601471989151;
 Wed, 30 Sep 2020 06:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200929185015.GG220516@redhat.com> <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
 <20200930130222.GA267985@redhat.com>
In-Reply-To: <20200930130222.GA267985@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Sep 2020 16:19:37 +0300
Message-ID: <CAOQ4uxidHB25jSnJJWNM_y5DmaqjqZ-9s+ZnyU3Zm-q-8TPvzw@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 4:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Sep 30, 2020 at 07:35:57AM +0300, Amir Goldstein wrote:
> > On Tue, Sep 29, 2020 at 9:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Following commit added a flag to invalidate guest page cache automatically.
> > >
> > > 72d0d248ca823 fuse: add FUSE_AUTO_INVAL_DATA init flag
> > >
> > > Idea seemed to be that for network file systmes if client A modifies
> > > the file, then client B should be able to detect that mtime of file
> > > change and invalidate its own cache and fetch new data from server.
> > >
> > > There are few questions/issues with this method.
> > >
> > > How soon client B able to detect that file has changed. Should it
> > > first GETATTR from server for every READ and compare mtime. That
> > > will be much stronger cache coherency but very slow because every
> > > READ will first be preceeded by a GETATTR.
> > >
> > > Or should this be driven by inode timeout. That is if inode cached attrs
> > > (including mtime) have timed out, we fetch new mtime from server and
> > > invalidate cache based on that.
> > >
> > > Current logic calls fuse_update_attr() on every READ. But that method
> > > will result in GETATTR only if either attrs have timedout or if cached
> > > attrs have been invalidated.
> > >
> > > If client B is only doing READs (and not WRITEs), then attrs should be
> > > valid for inode timeout interval. And that means client B will detect
> > > mtime change only after timeout interval.
> > >
> > > But if client B is also doing WRITE, then once WRITE completes, we
> > > invalidate cached attrs. That means next READ will force GETATTR()
> > > and invalidate page cache. In this case client B will detect the
> > > change by client A much sooner but it can't differentiate between
> > > its own WRITEs and by another client WRITE. So every WRITE followed
> > > by READ will result in GETATTR, followed by page cache invalidation
> > > and performance suffers in mixed read/write workloads.
> > >
> > > I am assuming that intent of auto_inval_data is to detect changes
> > > by another client but it can take up to "inode timeout" seconds
> > > to detect that change. (And it does not guarantee an immidiate change
> > > detection).
> > >
> > > If above assumption is acceptable, then I am proposing this patch
> > > which will update attrs on READ only if attrs have timed out. This
> > > means every second we will do a GETATTR and invalidate page cache.
> > >
> > > This is also suboptimal because only if client B is writing, our
> > > cache is still valid but we will still invalidate it after 1 second.
> > > But we don't have a good mechanism to differentiate between our own
> > > changes and another client's changes. So this is probably second
> > > best method to reduce the extent of issue.
> > >
> >
> > I was under the impression that virtiofs in now in the stage of stabilizing the
> > "all changes are from this client and no local changes on server" use case.
>
> Looks like that kubernetes is allowed to drop some files in host directory
> while it is being shared with guest. And I will not be surprised that if
> kata is already doing some very limited amount of modification on
> directory on host.
>
> For virtiofs we have both the use cases. For container images, "no
> sharing" assumption should work probably reasonably fine. But then
> we also need to address other use case of sharing volumes between
> containers and there other clients can modify shared directory.
>
> > Is that the case? I remember you also had an idea to communicate that this
> > is the use case on connection setup time for SB_NOSEC which did not happen.
>
> Given we have both the use cases and I am not 100% sure if kata is not
> doing any modifications on host, I thought not to pursue this line of
> thought that no modifications are allowed on host. It will be very
> limiting if kata/kubernetes decide to drop small files or make other
> small changes on host.
>
> >
> > If that is the case, why use auto_inval_data at all for virtiofs and not
> > explicit_inval_data?
> > Is that because you do want to allow local changes on the server?
>
> Yes. Atleast want to keep that possibility open. We know that there is
> a demand for this other mode too.
>
> If it ever becomes clear that for container image case we don't need
> any modifications on server, then I can easily add an option to virtiofsd
> and disable auto_inval_data for that use case. Having said that, we
> still need to optimize auto_inval_data case. Its inconsistent with
> itself. A client's own WRITE will invalidate its cache.
>
> >
> > I wonder out loud if this change of behavior you proposed is a good opportunity
> > to introduce some of the verbs from SMB oplocks / NFS delegations into the
> > FUSE protocol in order to allow finer grained control over per-file
> > (and later also
> > per-directory) caching behavior.
>
> May be. How will NFS delegation help with cache invalidation issue. I
> mean if client B has the lease and modifying file, then client A will
> still need to know when client B has modified the file and invalidate
> its own caches.

I think it goes a bit something like this:

B can ask and get a WRITE lease, if no other client has a READ lease.
Then it can do writeback cache and read cache.

If A is opening a file for read, then client B lease needs to be "broken"
or "revoked" and acknowledged by client B *before* client A open returns,
which means B needs to flush all its cached writes and start doing uncached
writes.

Both clients A and B can be granted a READ lease for cached reads if
there are no writers. The first open for write will break the READ leases,
but there is no need to wait when breaking READ leases.

>
> I don't know anything about SMB oplocks and know very little about NFS
> delegation.
>

I don't know that much either, I just know they are meant to close
the "knowledge gap" that you describe in your use case.
See email from Miklos about more specific details.

Thanks,
Amir.
