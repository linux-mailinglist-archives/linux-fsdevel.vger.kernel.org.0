Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACA1443647
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 20:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhKBTLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 15:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBTLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635880148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doMZ0eRqCZW9lV+d3+3sJlDFNI0EgereCdR+DU6HYmI=;
        b=MzAWAG/LmsR4xcpW76IDWJErohTMNQaVHJIfNPKL+Vv+BX00SPkZ0Rb3KAQznvAjX2QrCZ
        BNBvY0vbyH2U2fQLf5YzAPQXFK1LPOi93Y0a8R8EAatZ3M4fEc/186RvmaAMCh3STIWW5v
        IEFEtVzabhtCA/XEV+ns1zesIYNO6Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-7JjlXjHFMDmnbPjb_To_yQ-1; Tue, 02 Nov 2021 15:09:05 -0400
X-MC-Unique: 7JjlXjHFMDmnbPjb_To_yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC308106B7D9;
        Tue,  2 Nov 2021 19:09:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A62A57CD2;
        Tue,  2 Nov 2021 19:09:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0D03F222F94; Tue,  2 Nov 2021 15:09:03 -0400 (EDT)
Date:   Tue, 2 Nov 2021 15:09:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2 2/2] fuse: Send security context of inode on file
 creation
Message-ID: <YYGMzi2EJwIX4cIn@redhat.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
 <20211012180624.447474-3-vgoyal@redhat.com>
 <CAJfpegs-EHBjjnsVQdPWfH=idVENj9Aw0e-L4tjcgx3v38NJtg@mail.gmail.com>
 <YYFZl3egeX88G3FQ@redhat.com>
 <CAJfpeguMLE1rgpuP7gWWNcip6R+cgp-BdDfdQGtV=TouOVEn4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguMLE1rgpuP7gWWNcip6R+cgp-BdDfdQGtV=TouOVEn4A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:38:06PM +0100, Miklos Szeredi wrote:
> On Tue, 2 Nov 2021 at 16:30, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Nov 02, 2021 at 03:00:30PM +0100, Miklos Szeredi wrote:
> > > On Tue, 12 Oct 2021 at 20:06, Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > > > @@ -633,7 +713,29 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> > > >         args->out_numargs = 1;
> > > >         args->out_args[0].size = sizeof(outarg);
> > > >         args->out_args[0].value = &outarg;
> > > > +
> > > > +       if (init_security) {
> > >
> >
> > Hi Miklos,
> >
> > > Instead of a new arg to create_new_entry(), this could check
> > > args.opcode != FUSE_LINK.
> >
> > Will do.
> >
> > >
> > > > +               unsigned short idx = args->in_numargs;
> > > > +
> > > > +               if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
> > > > +                       err = -ENOMEM;
> > > > +                       goto out_put_forget_req;
> > > > +               }
> > > > +
> > > > +               err = get_security_context(entry, mode, &security_ctx,
> > > > +                                          &security_ctxlen);
> > > > +               if (err)
> > > > +                       goto out_put_forget_req;
> > > > +
> > > > +               if (security_ctxlen > 0) {
> > >
> > > This doesn't seem right.  How would the server know if this is arg is missing?
> > >
> > > I think if FUSE_SECURITY_CTX was negotiated, then the secctx header
> > > will always need to be added to the MK* requests.
> >
> > Even for the case of FUSE_LINK request? I think I put this check because
> > FUSE_LINK is not sending secctx header. Other requests are appending
> > this header even if a security module is not loaded/enabled.
> 
> No, FUSE_LINK wouldn't even get this far.

You are right. My bad. So looks like this check will always be true
given the current code. get_security_context() will either all
headers with security context or just return zeroed "struct fuse_secctxs",
indicating there are no security context. 

If that's the case, I should be able to get rid of this check. I will
do some more testing.

> 
> > I guess it makes more sense to add secctx header even for FUSE_LINK
> > request. Just that header will mention 0 security contexts are
> > following. This will interface more uniform. I will make this change.
> 
> Why? FUSE_LINK is not an inode creation op, it just shares the
> instantiation part with creation.

Ok, got it. Makes sense. So no sending of zeroed security context header
with FUSE_LINK.

Vivek

