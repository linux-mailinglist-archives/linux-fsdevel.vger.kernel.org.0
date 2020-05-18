Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46E1D73BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgERJRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERJRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 05:17:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411ADC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 02:17:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id be9so3695594edb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xlz8GsaEbqA7+Q0OgDVIVF7fZyrH+eyib1SwOfcFkk=;
        b=GwLWHDJpAgtpfvRU2Fl0XDrm+cFz4QU1FCrNrXPGsMOh9MUPIXxxx/3Lu8Q77ZsTfP
         QMhnLgCbloAHRfhuT9x29yE5bYKzLSOk9n3b5ynOwjNVCiJTyCp2gnhRJuhmeHLP5kVD
         vsENIg0p4v6RIzz74CLJvqgxw3JCcY0Fa9KIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xlz8GsaEbqA7+Q0OgDVIVF7fZyrH+eyib1SwOfcFkk=;
        b=hISG18UmrEHcOIbH6IQHVqmowLQNCnHtXsOYTdjkrX+PuHHzBdQsXp2ZBHuhwGnaLo
         G0rc5pX/ISftClkI/sKafGFjMWhRZ9tZe/W+zIKgOcdZeWyGNdZIifvK9U6KC5SzLkK5
         bfyZhCKfcM47vwbYPrAtIjebhxcOpjnDQarI7IJDEarxqQKk+KN5UsLgdTC4i/7w6hNl
         f72R8oHlGuN5Jd76SjXUntRgYwLpVC4j9UgLueyMLYgHLqcQwZc3RjXNAPO7r0wvuBhV
         7UIlhs0KJG0O24syZT2DcvqhhmmNhUEVgIDcuPxIbk/dIV7mxH2HTvtN8VG64Li8MFt+
         pXWQ==
X-Gm-Message-State: AOAM5330xlor1EiRwgPic5gEE/SGWwdCk2mbJer9u6Pmyh7VQRhXI4dE
        tc2WADTs32WsNYFDlo0B29XGRyVdSkgN+h7s8mC9dg==
X-Google-Smtp-Source: ABdhPJwpDqdsy9lmKmYTn6XGegQYLl2kT288a0DXA49iyCvZtD8jstRHqiY9fH6eZ1ZmbGlu5YMqc03a2MQokxkbGSM=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr12955766edt.168.1589793435950;
 Mon, 18 May 2020 02:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200515072047.31454-1-cgxu519@mykernel.net> <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
 <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com> <CAOQ4uxgfEBksbtLtPVA2L-JhRUQ5aEh9+W4dXGREuoMe40V8tQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgfEBksbtLtPVA2L-JhRUQ5aEh9+W4dXGREuoMe40V8tQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 11:17:04 +0200
Message-ID: <CAJfpegseFkdiKQ-_h64-9O-euoy8FDr_fA=wLxpR9cnpC2NHtg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ian Kent <raven@themaw.net>, Chengguang Xu <cgxu519@mykernel.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 10:52 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > I also do really see the need for it because only hashed negative
> > > > dentrys will be retained by the VFS so, if you see a hashed negative
> > > > dentry then you can cause it to be discarded on release of the last
> > > > reference by dropping it.
> > > >
> > > > So what's different here, why is adding an argument to do that drop
> > > > in the VFS itself needed instead of just doing it in overlayfs?
> > >
> > > That was v1 patch. It was dealing with the possible race of
> > > returned negative dentry becoming positive before dropping it
> > > in an intrusive manner.
> > >
> > > In retrospect, I think this race doesn't matter and there is no
> > > harm in dropping a positive dentry in a race obviously caused by
> > > accessing the underlying layer, which as documented results in
> > > "undefined behavior".
> > >
> > > Miklos, am I missing something?
> >
> > Dropping a positive dentry is harmful in case there's a long term
> > reference to the dentry (e.g. an open file) since it will look as if
> > the file was deleted, when in fact it wasn't.
> >
>
> I see. My point was that the negative->positive transition cannot
> happen on underlying layers without user modifying underlying
> layers underneath overlay, so it is fine to be in the "undefined" behavior
> zone.

Right, I don't think you can actually crash a filesystem by unhashing
a positive dentry in the middle of a create op, but it would
definitely be prudent to avoid that.

>
> > It's possible to unhash a negative dentry in a safe way if we make
> > sure it cannot become positive.  One way is to grab d_lock and remove
> > it from the hash table only if count is one.
> >
> > So yes, we could have a helper to do that instead of the lookup flag.
> > The disadvantage being that we'd also be dropping negatives that did
> > not enter the cache because of our lookup.
> >
> > I don't really care, both are probably good enough for the overlayfs case.
> >
>
> There is another point to consider.
> A negative underlying fs dentry may be useless for *this* overlayfs instance,
> but since lower layers can be shared among many overlayfs instances,
> for example, thousands of containers all testing for existence of file /etc/FOO
> on startup.
>
> It sounds like if we want to go through with DONTCACHE_NEGATIVE, that
> it should be opt-in behavior for overlayfs.

Good point.

Thanks,
Miklos
