Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FF5B5AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILNQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiILNQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD052DAA3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662988566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VP+uYKimQS0Q+hfj+aqPyMRGXCwQ8d18z/rHRv8AgA8=;
        b=adFO7A5+T4YJ38VDrvQCXwJxrR1MMkwbPXrywIUJkhxjqA48jd4UGc+ESVri/2RKwnB1HE
        qIeKNdu8ldZOjUvwA5eY6PbxOUWU6UFtpxP41py08NAQ5iNJh2AlZZIlhOgXpe7GjZ+gIc
        P8wniYNa50ci5D64Of4IOhHlxbgARj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-u-hn2eR_O6-XzxdcQJPr_g-1; Mon, 12 Sep 2022 09:16:04 -0400
X-MC-Unique: u-hn2eR_O6-XzxdcQJPr_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EEA2823F1B;
        Mon, 12 Sep 2022 13:16:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DAF210EB8;
        Mon, 12 Sep 2022 13:16:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5E99B2209F9; Mon, 12 Sep 2022 09:16:02 -0400 (EDT)
Date:   Mon, 12 Sep 2022 09:16:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file
 handles)
Message-ID: <Yx8xEhxrF5eFCwJR@redhat.com>
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com>
 <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com>
 <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 11, 2022 at 01:14:49PM +0300, Amir Goldstein wrote:
> On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > LOOKUP except it takes a {variable length handle, name} as input and
> > returns a variable length handle *and* a u64 node_id that can be used
> > normally for all other operations.
> >
> > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > based fs) would be that userspace need not keep a refcounted object
> > around until the kernel sends a FORGET, but can prune its node ID
> > based cache at any time.   If that happens and a request from the
> > client (kernel) comes in with a stale node ID, the server will return
> > -ESTALE and the client can ask for a new node ID with a special
> > lookup_handle(fh, NULL).
> >
> > Disadvantages being:
> >
> >  - cost of generating a file handle on all lookups
> >  - cost of storing file handle in kernel icache
> >
> > I don't think either of those are problematic in the virtiofs case.
> > The cost of having to keep fds open while the client has them in its
> > cache is much higher.
> >
> 
> I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> implementation of persistent file handles for FUSE.

Hi Amir,

I was going throug the proposal above for LOOKUP_HANDLE and I was
wondering how nodeid reuse is handled. IOW, if server decides to drop
nodeid from its cache and reuse it for some other file, how will we
differentiate between two. Some sort of generation id encoded in
nodeid?

> 
> The purpose is "proper" NFS export support for FUSE.
> "proper" being survives server restart.

Sounds like a good enhancement. 

> 
> I realize there is an ongoing effort to use file handles in the virtiofsd
> instead of open fds and that LOOKUP_HANDLE could assist in that
> effort, but that is an added benefit.

Using file handles (instead of keeping O_PATH fds open), is now available
in virtriofsd. (option --inode-file-handles). Thanks to Hanna for this
work.

https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/README.md

With LOOKUP_HANDLE implemented, we can afford to implement a mixed
approach where we can keep O_PATH fd open but if there are too many
fds open, then close some of these fds. So this is sort of hybrid
approach between fd and file handles.

> 
> I have a C++ implementation [1] which sort of supports persistent
> file handles, but not in a generic manner.
> 
> If anyone knows of any WIP on LOOKUP_HANDLE please let me know.

I am not aware of any. Will be good if you make it happen upstream :-)

Thanks
Vivek

> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/libfuse/commits/fuse_passthrough
> 

