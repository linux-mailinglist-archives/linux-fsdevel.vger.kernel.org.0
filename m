Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF1152086
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 19:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBDSm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 13:42:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727548AbgBDSm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580841745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=feAKuhe8GIlnCIa6qAcuICC4Lf8iXtEsicKqM5EBCbw=;
        b=GwzyvSd+afUFffQdd87d7mL0Xl+U8/5jsbUM92nSEkNqMRLjhtAw1MRzsIKTPC0VM82rvE
        vllg6XCbMG/KxYZbH6KxJVga5S14C3G5HYuuYKBsg0ucIieWPAoJoqH1JTwdRxcgn7Xw78
        tSV20HTBYTFU6tOw5YJca6GdeGykEPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-8Qf740q1NeitsPZuFChNoQ-1; Tue, 04 Feb 2020 13:42:23 -0500
X-MC-Unique: 8Qf740q1NeitsPZuFChNoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08297107B28C;
        Tue,  4 Feb 2020 18:42:22 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF693867FD;
        Tue,  4 Feb 2020 18:42:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2E4FC2202E9; Tue,  4 Feb 2020 13:42:21 -0500 (EST)
Date:   Tue, 4 Feb 2020 13:42:21 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
Message-ID: <20200204184221.GA24566@redhat.com>
References: <20200131115004.17410-1-mszeredi@redhat.com>
 <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com>
 <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 07:02:05PM +0200, Amir Goldstein wrote:
> On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > > revalidation in that case, just as we already do for lower layers.
> > > >
> > > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > > case.
> > >
> > > Hi Miklos,
> > >
> > > I have couple of very basic questions.
> > >
> > > - So with this change, we will allow NFS to be upper layer also?
> >
> > I haven't tested, but I think it will fail on the d_type test.
> 
> But we do not fail mount on no d_type support...
> Besides, I though you were going to add the RENAME_WHITEOUT
> test to avert untested network fs as upper.
> 
> >
> > > - What does revalidation on lower/upper mean? Does that mean that
> > >   lower/upper can now change underneath overlayfs and overlayfs will
> > >   cope with it.
> >
> > No, that's a more complicated thing.  Especially with redirected
> > layers (i.e. revalidating a redirect actually means revalidating all
> > the path components of that redirect).
> >
> > > If we still expect underlying layers not to change, then
> > >   what's the point of calling ->revalidate().
> >
> > That's a good question; I guess because that's what the filesystem
> > expects.  OTOH, it's probably unnecessary in most cases, since the
> > path could come from an open file descriptor, in which case the vfs
> > will not do any revalidation on that path.
> >
> 
> Note that ovl_dentry_revalidate() never returns 0 and therefore, vfs
> will never actually redo the lookup, but instead return -ESTALE
> to userspace. Right? This makes some sense considering that underlying
> layers are not expected to change.
> 
> The question is, with virtiofs, can we know that the server/host will not
> invalidate entries?

I don't think virtiofs will ensure that server/host will not invalidate
entries. It will be more of a configuration thing where we will expect
users to configure things in such a way that shared directory does not
change.

So that means, if user does not configure it properly and things change
unexpectedly, then overlayfs should be able to detect it and flag error
to user space?

> And if it does, should it cause a permanent error
> in overlayfs or a transient error? If we do not want a permanent error,
> then ->revalidate() needs to be called to invalidate the overlay dentry. No?

So as of now user space will get -ESTALE and that will get cleared when
user space retries after corresponding ovl dentry has been dropped from
cache (either dentry is evicted, cache is cleared forcibly or overlayfs
is remounted)? If yes, that kind of makes sense. Overlay does not expect
underlying layers to change and if a change it detected it is flagged
to user space (and overlayfs does not try to fix it)?

Thanks
Vivek

