Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A3A2CAFC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 23:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgLAWKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLAWKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:10:22 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 14:09:36 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v14so7822061lfo.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlzQ03tqfinj27u0ebVErPykOI5l7u1KcSRGpfzmnog=;
        b=grs1bdMFiMi2UC6AirzN97SNSTI07zwIKQxT3gXBGfbm1Q1pMTqHMCgMPdIxa2y1dD
         o39Md9e46IkNVhdiEh24MuI+Z2DFzE9JyFX2jbrY7vKkYrewjZXI8H66gdSvYLqycGu0
         c/vv62fx8jZiuldnafqCg7hi1Dytmxs4/Shfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlzQ03tqfinj27u0ebVErPykOI5l7u1KcSRGpfzmnog=;
        b=sUvr3iGdzkAtbiUvoBLHCIvCFbaF+CYjWqY86mjO9XtezQL10cFP54CDVtt6XKGxsT
         hJxNSe1/zX5MvjsVWgxsGNiFGURDI5veyoHaYxT2r3zzRrdgmmt0JCP8NH/RSqmckWif
         92RHhGdH13dNECR3aJrnTeDA2FFv3E5fKsdAmPk8BTNLVetxY/GhosKGc7poNbkqgz7B
         +taZa/elWZYCSC9YHtqA1TcSf17ARqn2Kin6kpUjMFn1hcWTGjI2VP4EX4ibl82bymak
         J5Qm8deCSU68ZHwuWUZ9aCOZThTfiVQkqpKqTwUednxeHWSIx1DQbkfWzfyKDSfulkRX
         TEJA==
X-Gm-Message-State: AOAM532ncybBFtWxPbGhCN4t06l6dsSZoatutUTP/fvRAPqzlm3V411R
        NztBsCC7Cs2c4BIvNJkhibPjoHP8FodyZw==
X-Google-Smtp-Source: ABdhPJzNsaFrn3z2dnUHPRSJkA68Y0qHuLNGaqRqV27MSoMkhHVjJ1FfKYqGyTEAjhnZyi3Gpl4kDQ==
X-Received: by 2002:ac2:548b:: with SMTP id t11mr2069062lfk.323.1606860574279;
        Tue, 01 Dec 2020 14:09:34 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id k3sm117652lfm.226.2020.12.01.14.09.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 14:09:33 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id y10so5814551ljc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 14:09:33 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr2418268ljp.285.1606860572738;
 Tue, 01 Dec 2020 14:09:32 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com> <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
 <300456.1606856642@warthog.procyon.org.uk>
In-Reply-To: <300456.1606856642@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Dec 2020 14:09:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgB_e1anR0b4B5p3qxR9nq1-xrRponA6Q6WbGTOSFNmPw@mail.gmail.com>
Message-ID: <CAHk-=wgB_e1anR0b4B5p3qxR9nq1-xrRponA6Q6WbGTOSFNmPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to filesystems
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 1, 2020 at 1:04 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > And if IS_DAX() is correct, then why shouldn't this just be done in
> > generic code? Why move it to every individual filesystem?
>
> One way of looking at it is that the check is then done for every filesystem -
> most of which don't support it.  Not sure whether that's a big enough problem
> to worry about.  The same is true of the automount test too, I suppose...

So I'd rather have it in one single place than spread out in the filesystems.

Especially when it turns out that the STATX_ATTR_DAX bitmask value was
wrong - now clearly it doesn't seem to currently *matter* to anything,
but imagine if we had to have some strange compat rule to fix things
up with stat() versioning or similar. That's exactly the kind of code
we would _not_ want in every filesystem.

So basically, the thing that argues against this patch is that it
seems to just duplicate things inside filesystems, when the VFS layter
already has the information.

Now, if the VFS information was possibly stale or wrong, that woudl be
one thing. But then we'd have other and bigger  problems elsewhere as
far as I can tell.

IOW - make generic what can be made generic, and try to avoid having
filesystems do their own thing.

[ Replace "filesystems" by "architectures" or whatever else, this is
obviously not a filesystem-specific rule in general. ]

And don't get me wrong - I don't _hate_ the patch, and I don't care
_that_ deeply, but it just doesn't seem to make any sense to me. My
initial query was really about "what am I missing - can you please
flesh out the commit message because I don't understand what's wrong".

                Linus
