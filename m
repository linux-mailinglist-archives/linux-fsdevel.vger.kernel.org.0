Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4967554926C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbiFMPpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiFMPpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:45:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1016F90D
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 06:22:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gl15so11173793ejb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYzFpJHsjVS9uc3prNzYOugZOo9Xe8Jgbmt0HTJd3Pc=;
        b=JDSWkIntiOSlPn5TIbBDrHJj3EePySo727AbtYQyGe+IVVJWl5dgr7Z9CaZP9NzxmT
         bkp3itOv0nnE5lQB9+orvEDZA6hp56WCdrvRA7vNelJ7sQKdAJBeZvDx8PUw0VSX12LB
         OwVb+lUFFFDj0Y+GrRkvj0VwWfiYrtAUIxbpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYzFpJHsjVS9uc3prNzYOugZOo9Xe8Jgbmt0HTJd3Pc=;
        b=HXAHpLHga8FR0y8Gmb+xsjvJWrcKlaIrtxGLD1Uxt4dgzef35zR53dhApR0IlaF0Vd
         bf+35DsswxVrPiPqHERlVYwNXszOQmWlBPbuPyLGwQG+rK/osTpFkls4AaQupZwgJ3ik
         2AiX98OU9QymgWkRNiziCLj1nQEv0exjp1Shq+LbwOmSsQooaDJjBvDM77Wmgh9Ld7w/
         2WAjfh7VdFLDi61j+8oBJ18vSnLLUplaFpLIFRIpgQZdke5XdJvo9/eZafh0PoG5schd
         aRW6QZBBILgkZsXt3x/8B0lrlbPRLe1Oz+UbI3QtL7KshVmc7/opGVjfdoFTlWuxUF3M
         Q80w==
X-Gm-Message-State: AOAM53326+2umIVPWgMfvs0Ig9nTzfz1MSzWZ/l+CpT0MINVCz9LqYZO
        RAutYQ2cFiYBj6XhCEkSqyhVmvxZKy5wsIQcJROyirlcWyA=
X-Google-Smtp-Source: ABdhPJw4g/FlkoYT6Hc4IjwQtLbHgLA56oBDxX5CzRtmJkdBv+f9jU0e+7sJxSAijYTfkjXfkGGkBemEuRlf4hfn6co=
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id
 jg21-20020a170907971500b00711ca06ca50mr38087186ejc.192.1655126552161; Mon, 13
 Jun 2022 06:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein> <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
 <20220613093745.4szlhoutyqpizyys@wittgenstein> <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
 <20220613104604.t5ptuhrl2d4l7kbl@wittgenstein>
In-Reply-To: <20220613104604.t5ptuhrl2d4l7kbl@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jun 2022 15:22:21 +0200
Message-ID: <CAJfpegs7Pepc3przdGLPFCATe1wNT--zLjqp4Nxi1MXOtE2P=w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Jun 2022 at 12:46, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:34:05PM +0200, Miklos Szeredi wrote:
> > On Mon, 13 Jun 2022 at 11:37, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
> > > > On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 6/7/22 1:47 AM, Christian Brauner wrote:
> > > > > > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> > > >
> > > > [...]
> > > >
> > > > > >> +static bool __read_mostly allow_other_parent_userns;
> > > > > >> +module_param(allow_other_parent_userns, bool, 0644);
> > > > > >> +MODULE_PARM_DESC(allow_other_parent_userns,
> > > > > >> + "Allow users not in mounting or descendant userns "
> > > > > >> + "to access FUSE with allow_other set");
> > > > > >
> > > > > > The name of the parameter also suggests that access is granted to parent
> > > > > > userns tasks whereas the change seems to me to allows every task access
> > > > > > to that fuse filesystem independent of what userns they are in.
> > > > > >
> > > > > > So even a task in a sibling userns could - probably with rather
> > > > > > elaborate mount propagation trickery - access that fuse filesystem.
> > > > > >
> > > > > > AFaict, either the module parameter is misnamed or the patch doesn't
> > > > > > implement the behavior expressed in the name.
> > > > > >
> > > > > > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > > > > > Did we agree that it was a good idea to weaken it to all tasks?
> > > > > > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > > > > > the initial userns?
> > > > >
> > > > > I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> > > > > ignore the allow_other mount option in such case? The idea is that
> > > > > CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> > > > > user not mounting with allow_other preventing root from reading contents
> > > > > defeats the purpose at least partially.
> > > >
> > > > If we want to be compatible with "user_allow_other", then it should be
> > > > checking if the uid/gid of the current task is mapped in the
> > > > filesystems user_ns (fsuidgid_has_mapping()).  Right?
> > >
> > > I think that's doable. So assuming we're still talking about requiring
> > > cap_sys_admin then we'd roughly have sm like:
> > >
> > >         if (fc->allow_other)
> > >                 return current_in_userns(fc->user_ns) ||
> > >                         (capable(CAP_SYS_ADMIN) &&
> > >                         fsuidgid_has_mapping(..., &init_user_ns));
> >
> > No, I meant this:
> >
> >         if (fc->allow_other)
> >                 return current_in_userns(fc->user_ns) ||
> >                         (userns_allow_other &&
> >                         fsuidgid_has_mapping(..., &init_user_ns));
> >
> > But I think the OP wanted to allow real root to access the fs, which
> > this doesn't allow (since 0 will have no mapping in the user ns), so
> > I'm not sure what's the right solution...
>
> I aimed to show that. You can setfs*id() and retain capabilities and
> still access the filesystem.
>
> >
> > Maybe the original patch is fine: this check isn't meant to protect
> > the filesystem from access, it's meant to protect the accessor.
>
> I don't have specific worries here. I'm just a bit hesitant to just let
> anyone access the fs. But if we go for allow other semantics then that's
> probably fine. Though I wonder why then we don't just do:
>
> if (fc->allow_other)
>         return current_in_userns(fc->user_ns) ||
>                 (userns_allow_other &&
>                 ns_capable(fc->user_ns, CAP_SYS_ADMIN));
>
> ? That'll let any ancestor userns access the fs not just descendants of
> fc->user_ns.

Looks good to me.

Thanks,
Miklos
