Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3A52DDDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiESTdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiESTdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 15:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA88A5930F
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652988828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlRs+bfxWYbBbjnLR2rK0SLWkDzLq4+HCX4OhBU9Tww=;
        b=A4FfuNXyj8Z/OtrCI9Pb9kqoALYrR9BI/4WAhDz0ThRiUhyoRdofMSWSilWsGEbpNk2Yn9
        HvTbZTq6jC+q23l91hkEgctNHsy+ALYO6+IjQTwHv5oXCuDEOsrGTrqmNiIsCInYUkN400
        RkQzuSQufPW3q057RMvjfd5yT0k9pKo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-zrJHUk78NhaUxtngxbrHzw-1; Thu, 19 May 2022 15:33:45 -0400
X-MC-Unique: zrJHUk78NhaUxtngxbrHzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDFDB29AA2F2;
        Thu, 19 May 2022 19:33:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46C0400E895;
        Thu, 19 May 2022 19:33:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 85CC52208FA; Thu, 19 May 2022 15:33:44 -0400 (EDT)
Date:   Thu, 19 May 2022 15:33:44 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <YoabmCQAWpBY5++X@redhat.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 11:39:01AM +0200, Miklos Szeredi wrote:
> On Tue, 17 May 2022 at 12:08, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >
> > In FUSE, as of now, uncached lookups are expensive over the wire.
> > E.g additional latencies and stressing (meta data) servers from
> > thousands of clients. These lookup calls possibly can be avoided
> > in some cases. Incoming three patches address this issue.
> >
> >
> > Fist patch handles the case where we are creating a file with O_CREAT.
> > Before we go for file creation, we do a lookup on the file which is most
> > likely non-existent. After this lookup is done, we again go into libfuse
> > to create file. Such lookups where file is most likely non-existent, can
> > be avoided.
> 
> I'd really like to see a bit wider picture...
> 
> We have several cases, first of all let's look at plain O_CREAT
> without O_EXCL (assume that there were no changes since the last
> lookup for simplicity):

Hi Miklos,

Thanks for providing this breakup. There are too many cases here and
this data helps a lot with that. I feel this should really be captured
in commit logs to show the current paths and how these have been 
optimized with ATOMIC_OPEN/CREATE_EXT.

> 
> [not cached, negative]
>    ->atomic_open()
>       LOOKUP
>       CREATE
> 
> [not cached, positive]
>    ->atomic_open()
>       LOOKUP
>    ->open()
>       OPEN
> 
> [cached, negative, validity timeout not expired]
>    ->d_revalidate()
>       return 1
>    ->atomic_open()
>       CREATE
> 
> [cached, negative, validity timeout expired]
>    ->d_revalidate()
>       return 0
>    ->atomic_open()
>       LOOKUP
>       CREATE
> 
> [cached, positive, validity timeout not expired]
>    ->d_revalidate()
>       return 1
>    ->open()
>       OPEN
> 
> [cached, positive, validity timeout expired]
>    ->d_revalidate()
>       LOOKUP
>       return 1
>    ->open()
>       OPEN
> 
> (Caveat emptor: I'm just looking at the code and haven't actually
> tested what happens.)
> 
> Apparently in all of these cases we are doing at least one request, so
> it would make sense to make them uniform:
> 
> [not cached]
>    ->atomic_open()
>       CREATE_EXT
> 
> [cached]
>    ->d_revalidate()
>       return 0

So fuse_dentry_revalidate() will return 0 even if timeout has not
expired (if server supports so called atomic_open()).
And that will lead to calling d_invalidate() on existing positive dentry
always. IOW, if I am calling open() on a dentry, dentry will always be
dropped and a new dentry will always be created from ->atomic_open() path,
is that right.

I am not sure what does it mean from VFS perspective to always call
d_invalidate() on a cached positive dentry when open() is called. 

/**
 * d_invalidate - detach submounts, prune dcache, and drop
 * @dentry: dentry to invalidate (aka detach, prune and drop)
 */

Thanks
Vivek

>    ->atomic_open()
>       CREATE_EXT
> 
> Similarly we can look at the current O_CREAT | O_EXCL cases:
> 
> [not cached, negative]
>    ->atomic_open()
>       LOOKUP
>       CREATE
> 
> [not cached, positive]
>    ->atomic_open()
>       LOOKUP
>    return -EEXIST
> 
> [cached, negative]
>    ->d_revalidate()
>       return 0 (see LOOKUP_EXCL check)
>    ->atomic_open()
>       LOOKUP
>       CREATE
> 
> [cached, positive]
>    ->d_revalidate()
>       LOOKUP
>       return 1
>    return -EEXIST
> 
> Again we are doing at least one request, so we can unconditionally
> replace them with CREATE_EXT like the non-O_EXCL case.
> 
> 
> >
> > Second patch handles the case where we open first time a file/dir
> > but do a lookup first on it. After lookup is performed we make another
> > call into libfuse to open the file. Now these two separate calls into
> > libfuse can be combined and performed as a single call into libfuse.
> 
> And here's my analysis:
> 
> [not cached, negative]
>    ->lookup()
>       LOOKUP
>    return -ENOENT
> 
> [not cached, positive]
>    ->lookup()
>       LOOKUP
>    ->open()
>       OPEN
> 
> [cached, negative, validity timeout not expired]
>     ->d_revalidate()
>        return 1
>     return -ENOENT
> 
> [cached, negative, validity timeout expired]
>    ->d_revalidate()
>       return 0
>    ->atomic_open()
>       LOOKUP
>    return -ENOENT
> 
> [cached, positive, validity timeout not expired]
>    ->d_revalidate()
>       return 1
>    ->open()
>       OPEN
> 
> [cached, positive, validity timeout expired]
>    ->d_revalidate()
>       LOOKUP
>       return 1
>    ->open()
>       OPEN
> 
> There's one case were no request is sent:  a valid cached negative
> dentry.   Possibly we can also make this uniform, e.g.:
> 
> [not cached]
>    ->atomic_open()
>        OPEN_ATOMIC
> 
> [cached, negative, validity timeout not expired]
>     ->d_revalidate()
>        return 1
>     return -ENOENT
> 
> [cached, negative, validity timeout expired]
>    ->d_revalidate()
>       return 0
>    ->atomic_open()
>       OPEN_ATOMIC
> 
> [cached, positive]
>    ->d_revalidate()
>       return 0
>    ->atomic_open()
>       OPEN_ATOMIC
> 
> It may even make the code simpler to clearly separate the cases where
> the atomic variants are supported and when not.  I'd also consider
> merging CREATE_EXT into OPEN_ATOMIC, since a filesystem implementing
> one will highly likely want to implement the other as well.
> 
> Thanks,
> Miklos
> 

