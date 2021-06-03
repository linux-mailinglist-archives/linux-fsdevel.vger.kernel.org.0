Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704AE39A9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFCSIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFCSIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:08:34 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8479C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jun 2021 11:06:49 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id g34so3794899uah.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llczrUowQbUDxoyW8Fe3w+wZDCFWjdjoD/4x2j+vVJg=;
        b=Xrk/o1WlRoaP8m7dFFhXj1nHF3JRF2UNcgDTxbO5PUjM5F3VtmIuL+9y81MbbHRKs6
         H8MEqgjIcYzrCEujCfLC0p3mJLbkDpBXgGbiPIPAFCjy3WwgO3PEdYvJf31nniA0Gei2
         kOooV/K6xbQuBRB86za14gz/kpVbu4MU2jKjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llczrUowQbUDxoyW8Fe3w+wZDCFWjdjoD/4x2j+vVJg=;
        b=IatiaRl0khaURJjacG0jF/y2nO8Yo1kEqwCWn3SxqgjVMxbE0SrmccVCW8rlf+sTWd
         h8BDV83Y0H8noEaAHWXnccSq8eYhvxImO09PJQb2Wc6bexsb/71l+0KjCQgReREDI449
         dJr53u1jYG1kln8cu90z1Gh2+pnH/BBJsduQncOmUvA3qUBpscS0barqx+J+6PBj7E1i
         aO11CFZIB8jasNr572oCPl+g+8MRxliL7K3Z7/sNEk6vio9ioc4B4JFM06Dr42nnc3sF
         4AVmCsK4v9D/XPeusZ+oMsjKYgT6XOiQqABlvhtAfywQZaRQYCTSQed+ySsWYD3wCVi9
         1Okg==
X-Gm-Message-State: AOAM530jpcEV4P2LGZtWPDXaP4EcHotQOhYrphb3oRFRZJ6oHw8ONoWr
        vKTeNEQoX3N5xFppA9ehc4ZFOON0YXO4SFWK16Fbkg==
X-Google-Smtp-Source: ABdhPJwIEosM7UwGjOOqVwRg9ztnWaeH+lJ0LVEs2YTd3Sl9IOmB5t/Z7UPzry6FVBfO8CGl+ftVPdCL9jwH75USFps=
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr603626vky.23.1622743608931;
 Thu, 03 Jun 2021 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <162218364554.34379.636306635794792903.stgit@web.messagingengine.com> <87czt2q2pl.fsf@disp2133>
In-Reply-To: <87czt2q2pl.fsf@disp2133>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Jun 2021 20:06:38 +0200
Message-ID: <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Jun 2021 at 19:26, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ian Kent <raven@themaw.net> writes:
>
> > If there are many lookups for non-existent paths these negative lookups
> > can lead to a lot of overhead during path walks.
> >
> > The VFS allows dentries to be created as negative and hashed, and caches
> > them so they can be used to reduce the fairly high overhead alloc/free
> > cycle that occurs during these lookups.
> >
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 33 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 4c69e2af82dac..5151c712f06f5 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
> >       if (flags & LOOKUP_RCU)
> >               return -ECHILD;
> >
> > -     /* Always perform fresh lookup for negatives */
> > -     if (d_really_is_negative(dentry))
> > -             goto out_bad_unlocked;
> > +     mutex_lock(&kernfs_mutex);
> >
> >       kn = kernfs_dentry_node(dentry);
> > -     mutex_lock(&kernfs_mutex);
>
> Why bring kernfs_dentry_node inside the mutex?
>
> The inode lock of the parent should protect negative to positive
> transitions not the kernfs_mutex.  So moving the code inside
> the mutex looks unnecessary and confusing.

Except that d_revalidate() may or may not be called with parent lock held.

Thanks,
Miklos
