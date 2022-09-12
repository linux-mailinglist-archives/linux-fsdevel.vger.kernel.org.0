Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B05B5C4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiILOfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiILOfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405562F019
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662993339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yxBrb62A1CiBnIX1UMvfEzop9eEkwJ1FcPBxjds5oeQ=;
        b=h4GJTa8eVshhBajUHJzVHChYF0jDRk7wvbFRp2qZDpJu6TupmhydvtQXZNyoYTGvj+eUKW
        oCUGEGhCf8XWkq5yYLetp8/HKpyu9hjP5HILC64fkBp1mw27dNK0pbqDPWA7IndrLKlx7t
        SQ/5YwSt9GdCr2qvQ0zjxJ3JPk4pXXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-cQ_uu3dDM-C6QVcBXRX4vw-1; Mon, 12 Sep 2022 10:35:37 -0400
X-MC-Unique: cQ_uu3dDM-C6QVcBXRX4vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28DFE185A7A4;
        Mon, 12 Sep 2022 14:35:37 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11CFE2166B29;
        Mon, 12 Sep 2022 14:35:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C13DD2209F9; Mon, 12 Sep 2022 10:35:36 -0400 (EDT)
Date:   Mon, 12 Sep 2022 10:35:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file
 handles)
Message-ID: <Yx9DuJwWN3l5T4jL@redhat.com>
References: <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com>
 <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com>
 <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
 <Yx8xEhxrF5eFCwJR@redhat.com>
 <CAOQ4uxikeG5Ys4Hm2nr7CuJ7cDpNmOP-PRKjezi-DTwDUP42kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxikeG5Ys4Hm2nr7CuJ7cDpNmOP-PRKjezi-DTwDUP42kw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:38:48PM +0300, Amir Goldstein wrote:
> On Mon, Sep 12, 2022 at 4:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Sun, Sep 11, 2022 at 01:14:49PM +0300, Amir Goldstein wrote:
> > > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > > LOOKUP except it takes a {variable length handle, name} as input and
> > > > returns a variable length handle *and* a u64 node_id that can be used
> > > > normally for all other operations.
> > > >
> > > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > > based fs) would be that userspace need not keep a refcounted object
> > > > around until the kernel sends a FORGET, but can prune its node ID
> > > > based cache at any time.   If that happens and a request from the
> > > > client (kernel) comes in with a stale node ID, the server will return
> > > > -ESTALE and the client can ask for a new node ID with a special
> > > > lookup_handle(fh, NULL).
> > > >
> > > > Disadvantages being:
> > > >
> > > >  - cost of generating a file handle on all lookups
> > > >  - cost of storing file handle in kernel icache
> > > >
> > > > I don't think either of those are problematic in the virtiofs case.
> > > > The cost of having to keep fds open while the client has them in its
> > > > cache is much higher.
> > > >
> > >
> > > I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> > > implementation of persistent file handles for FUSE.
> >
> > Hi Amir,
> >
> > I was going throug the proposal above for LOOKUP_HANDLE and I was
> > wondering how nodeid reuse is handled.
> 
> LOOKUP_HANDLE extends the 64bit node id to be variable size id.

Ok. So this variable size id is basically file handle returned by
host?

So this looks little different from what Miklos had suggested. IIUC,
he wanted LOOKUP_HANDLE to return both file handle as well as *node id*.

*********************************
One proposal was to add  LOOKUP_HANDLE operation that is similar to
LOOKUP except it takes a {variable length handle, name} as input and
returns a variable length handle *and* a u64 node_id that can be used
normally for all other operations.
***************************************

> A server that declares support for LOOKUP_HANDLE must never
> reuse a handle.
> 
> That's the basic idea. Just as a filesystem that declares to support
> exportfs must never reuse a file handle.

> 
> > IOW, if server decides to drop
> > nodeid from its cache and reuse it for some other file, how will we
> > differentiate between two. Some sort of generation id encoded in
> > nodeid?
> >
> 
> That's usually the way that file handles are implemented in
> local fs. The inode number is the internal lookup index and the
> generation part is advanced on reuse.
> 
> But for passthrough fs like virtiofsd, the LOOKUP_HANDLE will
> just use the native fs file handles, so virtiofsd can evict the inodes
> entry from its cache completely, not only close the open fds.

Ok, got it. Will be interesting to see how kernel fuse changes look
to accomodate this variable sized nodeid.

> 
> That is what my libfuse_passthough POC does.

Where have you hosted corresponding kernel changes?

Thanks
Vivek

