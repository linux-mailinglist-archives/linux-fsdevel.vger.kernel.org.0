Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7403241114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHJTj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 15:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgHJTj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:39:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F127C061787
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 12:39:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs17so7297121edb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FB9qBlcnnV7tNXkgg0cfLMfuoyQM+za2trKIURDDTQ=;
        b=qiqKtTbV0zFdDhubSofXDpDaKx/M0v422ibki3fNwhZrFXYn9o4oq0vUEgj4rmCF8p
         D2pJKhwNSNR6f8sEyRE5zP9N71FfdAUWNtUtM1+gkdiBblXKV2hE4j7UwqHB/A7OWvJ6
         cCmLzgqcmCG6zy9LOIktVigjXCrGRh8eUBpxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FB9qBlcnnV7tNXkgg0cfLMfuoyQM+za2trKIURDDTQ=;
        b=pBgL4o/0Qu2n7yNm+HonrJRrI97fMO5/fy7lHxzZzJpnnqqU3U78T2/iEazf3sNGlt
         Mllpo0QpQx8rTQjv3tjdT3nw/rsNkQNLSCRDGsIMj/oUX0mblYcbiHSsAToFZvl6bZAC
         NKc9SOBLeoN+a4UPCu1fG9hT68U6wra3kCbuCmNqasV7pFaDWK5/VbrIZW3OgrKSgwXE
         6IcNEcL0vTJXSFs2GvGpz/cviUahP4MbxDqHGt8oXsvuaSwg5pL5yGQ7UNTsowEwHtPn
         B2/Al5xiUPNQcoyShEqNkNuPBpz24Rg7pqoDvfrR5HIHMs3B3L01JlOQYzUQ5F9YU1Tw
         DDNg==
X-Gm-Message-State: AOAM532OhQDLyQBhUivK0bmzEiF6Ji2SAxC39Obya57g69ldEfdrp/uW
        03vSCNfq+lW3AF3QjbpOnUc2hYfKPL7ucg/JYwgBnA==
X-Google-Smtp-Source: ABdhPJyH2EkBTBDb8WZ5/x6K4+FKGgD/g6LwMm6Jm0zyXMvzJTmPZjGQRN49r4uDZDW1iCYBmXQUcAEBje8RAdMsb+k=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr23251645edt.17.1597088397331;
 Mon, 10 Aug 2020 12:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200807195526.426056-1-vgoyal@redhat.com> <20200807195526.426056-19-vgoyal@redhat.com>
 <CAJfpegs1CtPMaVmbDc__N0Fc3FkNEe=vQOkrr8RKiiS6NqTyHA@mail.gmail.com> <20200810193717.GF455528@redhat.com>
In-Reply-To: <20200810193717.GF455528@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Aug 2020 21:39:46 +0200
Message-ID: <CAJfpegsARKo+az+4Q98ecH3RMQinFT=QeMdte2=aZdvbz2WY1w@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] fuse: Release file in process context
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 9:37 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Aug 10, 2020 at 10:29:13AM +0200, Miklos Szeredi wrote:
> > On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > fuse_file_put(sync) can be called with sync=true/false. If sync=true,
> > > it waits for release request response and then calls iput() in the
> > > caller's context. If sync=false, it does not wait for release request
> > > response, frees the fuse_file struct immediately and req->end function
> > > does the iput().
> > >
> > > iput() can be a problem with DAX if called in req->end context. If this
> > > is last reference to inode (VFS has let go its reference already), then
> > > iput() will clean DAX mappings as well and send REMOVEMAPPING requests
> > > and wait for completion. (All the the worker thread context which is
> > > processing fuse replies from daemon on the host).
> > >
> > > That means it blocks worker thread and it stops processing further
> > > replies and system deadlocks.
> >
> > Is this reasoning specific to DAX?  Seems to me this is a virtio-fs
> > specific issue.
>
> Hi Miklos,
>
> I am looking at this patch closely and maybe we don't need it, given
> current code.
>
> Reason being that looks like for virtiofs now we set ctx->destroy=true
> and that sets fc->destroy. And if that's set, we don't schedule async req
> in fuse_release_common();
>
> fuse_release_common() {
>   fuse_file_put(ff, ff->fc->destroy, isdir);
> }
>
> And if we don't schedule async file put, we don't run the risk of
> blocking worker thread in evict_inode() with DAX enabled.
>
> I ran blogbench multiple times with this patch reverted and I can't
> reproduce the deadlock.
>
> So we can drop this patch for now. If need be I will fix it as
> post merge patch.

Okay.  Yeah, I was thinking along the lines of no-async-release-ever
for virtiofs, but apparently that's already done.

Thanks,
Miklos
